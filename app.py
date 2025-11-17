from flask import Flask, render_template, request, flash, redirect, url_for
import os
from datetime import datetime

app = Flask(__name__)
app.secret_key = os.environ.get('SECRET_KEY', 'dev-secret-key-change-in-production')

@app.route('/')
def index():
    """Main page route"""
    return render_template('index.html')

@app.route('/contact', methods=['GET', 'POST'])
def contact():
    """Contact form route"""
    if request.method == 'POST':
        name = request.form.get('name', '').strip()
        email = request.form.get('email', '').strip()
        message = request.form.get('message', '').strip()
        
        # Basic validation
        if not name or not email or not message:
            flash('Please fill in all required fields.', 'error')
            return redirect(url_for('contact'))
        
        # Email validation (basic)
        if '@' not in email or '.' not in email:
            flash('Please enter a valid email address.', 'error')
            return redirect(url_for('contact'))
        
        # Here you would typically send an email or save to database
        # For now, we'll just flash a success message
        flash('Thank you for your message! We will get back to you soon.', 'success')
        
        # Log the contact form submission (optional)
        print(f"Contact form submission: {name} ({email}) - {message[:50]}...")
        
        return redirect(url_for('contact'))
    
    return render_template('index.html', scroll_to='contact')

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
