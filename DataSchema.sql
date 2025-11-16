-- Фізична схема реляційної БД (SQL) для перевірки коду

-- 1. Таблиця Офіс-менеджер (Primary Entity)
CREATE TABLE "Ofis_Menedzher" (
    menedzher_id INT PRIMARY KEY,
    imya VARCHAR(50) NOT NULL,
    prizvishche VARCHAR(50) NOT NULL
);

-- 2. Таблиця Співробітник компанії (Primary Entity)
CREATE TABLE "Spivrobitnyk_Kompanii" (
    spivrobitnyk_id INT PRIMARY KEY,
    imya VARCHAR(50) NOT NULL,
    posada VARCHAR(100) NOT NULL
    CHECK (posada REGEXP '^[a-zA-Zа-яА-ЯёЁіІїЇєЄ\s-]+$')
);

-- 3. Таблиця Меню страв (Related to Manager and Employee)
CREATE TABLE "Menu_Strav" (
    strava_id INT PRIMARY KEY,
    nazva VARCHAR(100) UNIQUE NOT NULL,
    CHECK (nazva REGEXP '^[a-zA-Zа-яА-ЯёЁіІїЇєЄ0-9\s''-]+$'),
    tsina DECIMAL(10, 2) NOT NULL CHECK (tsina > 0),
    sklad_stravy TEXT,

    -- Зовнішні ключі для зв'язку 1:M
    menedzher_id INT NOT NULL,
    vidpovidalnyi_spivrobitnyk_id INT NOT NULL,

    FOREIGN KEY (menedzher_id)
    REFERENCES "Ofis_Menedzher" (menedzher_id),
    FOREIGN KEY (vidpovidalnyi_spivrobitnyk_id)
    REFERENCES "Spivrobitnyk_Kompanii" (spivrobitnyk_id)
);

-- 4. Таблиця Співробітник кафе (Related to Manager 1:1)
CREATE TABLE "Spivrobitnyk_Kafe" (
    kafe_spivrobitnyk_id INT PRIMARY KEY,
    imya VARCHAR(50) NOT NULL,
    posada VARCHAR(100) NOT NULL,

    -- Зовнішній ключ для зв'язку 1:1
    menedzher_id INT UNIQUE NOT NULL,

    FOREIGN KEY (menedzher_id)
    REFERENCES "Ofis_Menedzher" (menedzher_id)
);

-- 5. Таблиця Календар подій (Primary Entity)
CREATE TABLE "Kalendar_Podii" (
    kalendar_id INT PRIMARY KEY,
    nazva_podii VARCHAR(100) UNIQUE NOT NULL,
    chas_pochatku TIMESTAMP NOT NULL,
    chas_zakinchennya TIMESTAMP NOT NULL,
    -- Обмеження, що час початку має бути раніше часу закінчення
    CHECK (chas_pochatku < chas_zakinchennya)
);

-- 6. Таблиця Культурні заходи (Related to Calendar 1:M)
CREATE TABLE "Kulturni_Zakhody" (
    zakhid_id INT PRIMARY KEY,
    data_zakhodu DATE NOT NULL,
    chas_pochatku TIME NOT NULL,
    chas_zakinchennya TIME NOT NULL,
    mistse_provedennya VARCHAR(255) NOT NULL,

    -- Зовнішній ключ
    kalendar_id INT NOT NULL,

    FOREIGN KEY (kalendar_id)
    REFERENCES "Kalendar_Podii" (kalendar_id)
);

-- 7. Таблиця Доступ Співробітників до Заходів (M:M Relationship)
CREATE TABLE "Dostup_Spivrobitnykiv_Zakhody" (
    spivrobitnyk_id INT NOT NULL,
    zakhid_id INT NOT NULL,
    data_dostupu TIMESTAMP,

    -- Складений первинний ключ
    PRIMARY KEY (spivrobitnyk_id, zakhid_id),

    -- Зовнішні ключі
    FOREIGN KEY (spivrobitnyk_id)
    REFERENCES "Spivrobitnyk_Kompanii" (spivrobitnyk_id),
    FOREIGN KEY (zakhid_id)
    REFERENCES "Kulturni_Zakhody" (zakhid_id)
);
