-- 1. Type ENUM pour limiter les rôles uniquement à 'candidate' et 'recruiter'
CREATE TYPE user_role AS ENUM ('candidate', 'recruiter');

-- 2. Table des utilisateurs (Authentification simple)
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role user_role NOT NULL DEFAULT 'candidate',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Table des candidats (Champs remplis par la suite via l'extraction du CV)
CREATE TABLE candidates (
    id SERIAL PRIMARY KEY,
    user_id INT UNIQUE NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    phone_number VARCHAR(20),
    cv_file_path VARCHAR(500), -- Chemin du fichier CV uploadé
    headline VARCHAR(255),      -- Titre (Ex: Développeur Full Stack) -> Extrait par l'IA
    summary TEXT,               -- Résumé / Profil -> Extrait par l'IA
    location VARCHAR(100),      -- Ville / Pays -> Extrait par l'IA
    linkedin_url VARCHAR(255),  -- Lien LinkedIn -> Extrait par l'IA
    github_url VARCHAR(255),    -- Lien GitHub -> Extrait par l'IA
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);