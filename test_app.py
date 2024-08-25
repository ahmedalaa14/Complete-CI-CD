import unittest
import json
import os
import tempfile
from app import app, load_data, save_data, DataBase

class LibraryAppTestCase(unittest.TestCase):

    def setUp(self):
        # Create a temporary file to use as our test database
        self.db_fd, self.db_path = tempfile.mkstemp()
        app.config['TESTING'] = True
        app.config['WTF_CSRF_ENABLED'] = False
        
        # Modify the global DataBase variable to use our temporary file
        global DataBase
        DataBase = self.db_path
        
        self.app = app.test_client()

        # Initialize the temporary database with empty data
        self.reset_database()

    def tearDown(self):
        # Close and remove the temporary file
        os.close(self.db_fd)
        os.unlink(self.db_path)

    def reset_database(self):
        # Helper method to reset the database to an empty state
        with open(self.db_path, 'w') as f:
            json.dump({"books": [], "borrowed_books": []}, f)


    def test_save_and_load_data(self):
        self.reset_database()  # Ensure database is empty before this test
        test_data = {"books": [{"title": "Test Book", "author": "Test Author"}], "borrowed_books": []}
        save_data(test_data)
        loaded_data = load_data()
        self.assertEqual(loaded_data, test_data)

    def test_index_route(self):
        response = self.app.get('/')
        self.assertEqual(response.status_code, 200)

    def test_update_book(self):
        self.reset_database()  # Ensure database is empty before this test
        save_data({"books": [{"title": "Old Title", "author": "Old Author"}], "borrowed_books": []})
        response = self.app.post('/update_book/Old Title', data=dict(
            title="Updated Title",
            author="Updated Author"
        ), follow_redirects=True)
        self.assertEqual(response.status_code, 200)
        data = load_data()
        self.assertEqual(data['books'][0]['title'], "Updated Title")

    def test_remove_book(self):
        self.reset_database()  # Ensure database is empty before this test
        save_data({"books": [{"title": "To Remove", "author": "Some Author"}], "borrowed_books": []})
        response = self.app.post('/remove_book', data=dict(
            title="To Remove"
        ), follow_redirects=True)
        self.assertEqual(response.status_code, 200)
        data = load_data()
        self.assertEqual(len(data['books']), 0)

    def test_search_book(self):
        self.reset_database()  # Ensure database is empty before this test
        save_data({"books": [{"title": "Search Me", "author": "Find Author"}], "borrowed_books": []})
        response = self.app.post('/search_book', data=dict(
            title="Search"
        ))
        self.assertEqual(response.status_code, 200)
        self.assertIn(b"Search Me", response.data)

    def test_borrow_book(self):
        self.reset_database()  # Ensure database is empty before this test
        save_data({"books": [{"title": "Borrow Me", "author": "Lend Author"}], "borrowed_books": []})
        response = self.app.post('/borrow_book', data=dict(
            title="Borrow Me",
            borrower="Test Borrower"
        ), follow_redirects=True)
        self.assertEqual(response.status_code, 200)
        data = load_data()
        self.assertEqual(len(data['books']), 0)
        self.assertEqual(len(data['borrowed_books']), 1)

    def test_return_book(self):
        self.reset_database()  # Ensure database is empty before this test
        save_data({"books": [], "borrowed_books": [{"title": "Return Me", "author": "Return Author", "borrower": "Someone"}]})
        response = self.app.post('/return_book', data=dict(
            title="Return Me"
        ), follow_redirects=True)
        self.assertEqual(response.status_code, 200)
        data = load_data()
        self.assertEqual(len(data['books']), 1)
        self.assertEqual(len(data['borrowed_books']), 0)

if __name__ == '__main__':
    unittest.main()
