*** Settings ***
Documentation    Database Helpers

Library    DatabaseLibrary
Library    Factories/Users.py

*** Keywords ***
Connect To Postgres

    Connect To Database    psycopg2
    ...                    ditrxkrh
    ...                    ditrxkrh
    ...                    j6POGYdA4L3MqS4JE4FrRyQ8cVW3AKzN
    ...                    fanny.db.elephantsql.com
    ...                    5432

Reset Env
    Execute SQL String    DELETE FROM geeks;
    Execute SQL String    DELETE FROM users;

Insert User
    [Arguments]    ${u}

    ${pass_hash}    Get Hashed Pass    ${u}[password]

    ${q}    Set Variable    INSERT INTO users (name, email, password_hash, is_geek) values ('${u}[name] ${u}[lastname]', '${u}[email]', '${pass_hash}', false)

    Execute SQL String    ${q}

Users Seed
    ${user}        Factory User Login
    Insert User    ${user}               

    ${user2}       Factory User Be Geek
    Insert User    ${user2}