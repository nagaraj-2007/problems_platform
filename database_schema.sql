-- Problem Platform Database Schema
-- Created for Flutter Problem Solving Platform

-- Users table
CREATE TABLE users (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    join_date TIMESTAMP NOT NULL,
    problems_posted INT DEFAULT 0,
    plans_submitted INT DEFAULT 0,
    reviews_given INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Categories reference table
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Problems table
CREATE TABLE problems (
    id VARCHAR(50) PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    category VARCHAR(100) NOT NULL,
    context TEXT(500) NOT NULL,
    author_id VARCHAR(50) NOT NULL,
    author_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    plan_count INT DEFAULT 0,
    average_rating DECIMAL(3,2) DEFAULT 0.00,
    review_count INT DEFAULT 0,
    like_count INT DEFAULT 0,
    created_at_db TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (author_id) REFERENCES users(id)
);

-- Problem media (images/videos)
CREATE TABLE problem_media (
    id INT AUTO_INCREMENT PRIMARY KEY,
    problem_id VARCHAR(50) NOT NULL,
    media_type ENUM('image', 'video') NOT NULL,
    media_url VARCHAR(500) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (problem_id) REFERENCES problems(id) ON DELETE CASCADE
);

-- Plans table
CREATE TABLE plans (
    id VARCHAR(50) PRIMARY KEY,
    problem_id VARCHAR(50) NOT NULL,
    author_id VARCHAR(50) NOT NULL,
    author_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    average_rating DECIMAL(3,2) DEFAULT 0.00,
    rating_count INT DEFAULT 0,
    like_count INT DEFAULT 0,
    created_at_db TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (problem_id) REFERENCES problems(id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES users(id)
);

-- Plan steps
CREATE TABLE plan_steps (
    id INT AUTO_INCREMENT PRIMARY KEY,
    plan_id VARCHAR(50) NOT NULL,
    step_order INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (plan_id) REFERENCES plans(id) ON DELETE CASCADE
);

-- Problem reviews
CREATE TABLE problem_reviews (
    id VARCHAR(50) PRIMARY KEY,
    problem_id VARCHAR(50) NOT NULL,
    reviewer_id VARCHAR(50) NOT NULL,
    reviewer_name VARCHAR(255) NOT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMP NOT NULL,
    created_at_db TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (problem_id) REFERENCES problems(id) ON DELETE CASCADE,
    FOREIGN KEY (reviewer_id) REFERENCES users(id),
    UNIQUE KEY unique_problem_reviewer (problem_id, reviewer_id)
);

-- Plan ratings
CREATE TABLE plan_ratings (
    id VARCHAR(50) PRIMARY KEY,
    plan_id VARCHAR(50) NOT NULL,
    rater_id VARCHAR(50) NOT NULL,
    rater_name VARCHAR(255) NOT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMP NOT NULL,
    created_at_db TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (plan_id) REFERENCES plans(id) ON DELETE CASCADE,
    FOREIGN KEY (rater_id) REFERENCES users(id),
    UNIQUE KEY unique_plan_rater (plan_id, rater_id)
);

-- Problem likes
CREATE TABLE problem_likes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    problem_id VARCHAR(50) NOT NULL,
    user_id VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (problem_id) REFERENCES problems(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id),
    UNIQUE KEY unique_problem_like (problem_id, user_id)
);

-- Plan likes
CREATE TABLE plan_likes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    plan_id VARCHAR(50) NOT NULL,
    user_id VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (plan_id) REFERENCES plans(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id),
    UNIQUE KEY unique_plan_like (plan_id, user_id)
);

-- Insert predefined categories
INSERT INTO categories (name) VALUES 
('IT / Software'),
('Agriculture'),
('Business / Startup'),
('Finance (non-trading, general)'),
('Career / Jobs'),
('Education / Learning'),
('Healthcare'),
('Manufacturing'),
('Marketing / Sales'),
('Operations / Process'),
('Human Resources'),
('Legal / Compliance'),
('Real Estate'),
('Logistics / Supply Chain'),
('Retail / E-commerce'),
('Government / Public Services'),
('Environment / Sustainability'),
('Product / UX / Design'),
('Data / Analytics'),
('Security / Risk'),
('Social / Community'),
('Personal Productivity'),
('Research / Innovation'),
('Other (Uncategorized)');

-- Indexes for better performance
CREATE INDEX idx_problems_category ON problems(category);
CREATE INDEX idx_problems_author ON problems(author_id);
CREATE INDEX idx_problems_created ON problems(created_at);
CREATE INDEX idx_plans_problem ON plans(problem_id);
CREATE INDEX idx_plans_author ON plans(author_id);
CREATE INDEX idx_problem_reviews_problem ON problem_reviews(problem_id);
CREATE INDEX idx_plan_ratings_plan ON plan_ratings(plan_id);