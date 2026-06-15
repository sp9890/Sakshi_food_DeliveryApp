const express = require('express');
const app = express();
const PORT = 3001;

app.use(express.json());

// Mock user database
const users = {};

// Sign Up endpoint
app.post('/api/sign_up', (req, res) => {
  try {
    const { name, email, mobile, password } = req.body;

    if (!name || !email || !mobile || !password) {
      return res.status(400).json({
        status: 'fail',
        message: 'All fields are required'
      });
    }

    if (users[email]) {
      return res.status(400).json({
        status: 'fail',
        message: 'Email already registered'
      });
    }

    users[email] = {
      name,
      email,
      mobile,
      password,
      userId: Date.now().toString()
    };

    res.json({
      status: 'success',
      payload: {
        user_id: users[email].userId,
        auth_token: 'mock_token_' + Date.now()
      }
    });
  } catch (error) {
    res.status(500).json({ status: 'fail', message: error.message });
  }
});

// Login endpoint
app.post('/api/login', (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({
        status: 'fail',
        message: 'Email and password required'
      });
    }

    const user = users[email];
    if (!user || user.password !== password) {
      return res.status(401).json({
        status: 'fail',
        message: 'Invalid email or password'
      });
    }

    res.json({
      status: 'success',
      payload: {
        user_id: user.userId,
        auth_token: 'mock_token_' + Date.now(),
        name: user.name
      }
    });
  } catch (error) {
    res.status(500).json({ status: 'fail', message: error.message });
  }
});

// Forgot Password Request
app.post('/api/forgot_password_request', (req, res) => {
  try {
    const { email } = req.body;

    if (!users[email]) {
      return res.status(404).json({
        status: 'fail',
        message: 'Email not found'
      });
    }

    res.json({
      status: 'success',
      message: 'Reset code sent to email',
      payload: { reset_code: '123456' }
    });
  } catch (error) {
    res.status(500).json({ status: 'fail', message: error.message });
  }
});

// Forgot Password Verify
app.post('/api/forgot_password_verify', (req, res) => {
  try {
    const { email, reset_code } = req.body;

    if (reset_code !== '123456') {
      return res.status(400).json({
        status: 'fail',
        message: 'Invalid reset code'
      });
    }

    res.json({
      status: 'success',
      message: 'Code verified'
    });
  } catch (error) {
    res.status(500).json({ status: 'fail', message: error.message });
  }
});

// Forgot Password Set New
app.post('/api/forgot_password_set_new', (req, res) => {
  try {
    const { email, reset_code, password } = req.body;

    if (!users[email]) {
      return res.status(404).json({
        status: 'fail',
        message: 'User not found'
      });
    }

    users[email].password = password;

    res.json({
      status: 'success',
      message: 'Password updated successfully'
    });
  } catch (error) {
    res.status(500).json({ status: 'fail', message: error.message });
  }
});

app.listen(PORT, () => {
  console.log(`Food Delivery API server running on http://localhost:${PORT}`);
  console.log('Available endpoints:');
  console.log('  POST /api/sign_up');
  console.log('  POST /api/login');
  console.log('  POST /api/forgot_password_request');
  console.log('  POST /api/forgot_password_verify');
  console.log('  POST /api/forgot_password_set_new');
});
