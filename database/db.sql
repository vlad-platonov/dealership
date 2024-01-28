CREATE TABLE vehicle (
    id INT NOT NULL PRIMARY KEY,
    ownerName VARCHAR(32) NULL,
    model INT NOT NULL,
    color VARCHAR(10) NOT NULL,
    x FLOAT NOT NULL,
    y FLOAT NOT NULL,
    z FLOAT NOT NULL,
    fa FLOAT NOT NULL,
    interior INT NOT NULL,
    world INT NOT NULL
);