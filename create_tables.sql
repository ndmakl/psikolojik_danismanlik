-- Psikolojik Danışmanlık Merkezi: Veritabanı Tabloları
-- Geliştiren: Nedim Akıl - ndmakl

-- 1. therapists
CREATE TABLE therapists (
    therapist_id SERIAL PRIMARY KEY,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    email VARCHAR(60),
    gender VARCHAR(10) CHECK (gender IN ('Kadın', 'Erkek'))
);

-- 2. therapist_available_days
CREATE TABLE therapist_available_days (
    day_id SERIAL PRIMARY KEY,
    therapist_id INTEGER REFERENCES therapists(therapist_id) ON DELETE CASCADE,
    available_day VARCHAR(10)
);

-- 3. clients
CREATE TABLE clients (
    client_id SERIAL PRIMARY KEY,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    email VARCHAR(60),
    phone_number VARCHAR(15),
    gender VARCHAR(10) CHECK (gender IN ('Kadın', 'Erkek')),
    birth_date DATE
);

-- 4. appointments
CREATE TABLE appointments (
    appointment_id SERIAL PRIMARY KEY,
    therapist_id INTEGER REFERENCES therapists(therapist_id),
    client_id INTEGER REFERENCES clients(client_id),
    appointment_date DATE,
    appointment_time TIME,
    status VARCHAR(20) CHECK (status IN ('planlandi', 'tamamlandi'))
);

-- 5. sessions
CREATE TABLE sessions (
    session_id SERIAL PRIMARY KEY,
    appointment_id INTEGER REFERENCES appointments(appointment_id) ON DELETE CASCADE,
    session_notes TEXT,
    session_duration INTEGER,
    session_outcome TEXT
);

-- 6. payments
CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    client_id INTEGER REFERENCES clients(client_id),
    amount NUMERIC(10,2),
    payment_date DATE,
    payment_method VARCHAR(20) CHECK (payment_method IN ('nakit', 'kredi karti')),
    status VARCHAR(20) CHECK (status IN ('planlandi', 'tamamlandi'))
);

-- 7. feedbacks
CREATE TABLE feedbacks (
    feedback_id SERIAL PRIMARY KEY,
    appointment_id INTEGER REFERENCES appointments(appointment_id),
    client_id INTEGER REFERENCES clients(client_id),
    feedback_text TEXT,
    feedback_date DATE
);

-- 8. users
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(30),
    password_hash TEXT
);

-- 9. cancellations
CREATE TABLE cancellations (
    cancellation_id SERIAL PRIMARY KEY,
    appointment_id INTEGER REFERENCES appointments(appointment_id) ON DELETE CASCADE,
    cancellation_reason TEXT,
    cancellation_date DATE
);
