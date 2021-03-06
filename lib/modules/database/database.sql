CREATE TABLE IF NOT EXISTS Actividad(
    id INTEGER PRIMARY KEY,
    nombre VARCHAR NOT NULL,
    descripcion VARCHAR NOT NULL,
    days VARCHAR NULL,
    time VARCHAR NULL,
    active INTEGER DEFAULT 1,
    type varchar not null,
    complements text
);

CREATE TABLE IF NOT EXISTS imagenesactividades(
    id INTEGER PRIMARY KEY,
    activity_id INTEGER,
    url text,
    foreign key(activity_id) references actividad(id)
);

CREATE TABLE IF NOT EXISTS procedimiento(
    steps text,
    id integer primary key,
    activity_id integer,
    foreign key(activity_id) references actividad(id)
);

CREATE TABLE IF NOT EXISTS Comida(
    id INTEGER PRIMARY KEY,
    nombre VARCHAR NOT NULL,
    urlImagen varchar not null,
    preparacion text,
    ingredientes text
);

CREATE TABLE IF NOT EXISTS Contacto(
    id INTEGER PRIMARY KEY,
    name VARCHAR NOT NULL,
    description TEXT,
    phone CHAR(10)
);

CREATE TABLE IF NOT EXISTS alarma(
    id INTEGER PRIMARY KEY,
    title VARCHAR NULL DEFAULT "Sin título",
    body VARCHAR NULL DEFAULT "Sin descripción",
    day INTEGER NOT NULL,
    time VARCHAR NOT NULL, --HH:MM
    active INTEGER DEFAULT 1,
    interval INTEGER DEFAULT 7
);

CREATE TABLE IF NOT EXISTS actividadesAlarmas(
    alarma_id INTEGER NOT NULL,
    actividad_id INTEGER NOT NULL,
    FOREIGN KEY(actividad_id) REFERENCES actividad(id) ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY(alarma_id) REFERENCES alarma(id) ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS water(
    id INTEGER PRIMARY KEY,
    size INTEGER NOT NULL, -- glass size in ml
    goal DECIMAL NOT NULL, -- how many Lts are you going to drink?
    start_hour INTEGER NOT NULL, -- time to start alarms
    start_minute INTEGER NOT NULL,
    end_hour INTEGER NOT NULL, -- time to stop alarms
    end_minute INTEGER NOT NULL,
    active INTEGER DEFAULT 0
    -- water progress is storaged in cache
);

CREATE TABLE IF NOT EXISTS waterAlarms(
    alarm_id INTEGER NOT NULL,
    water_id INTEGER NOT NULL,
    FOREIGN KEY(water_id) REFERENCES water(id) ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY(alarm_id) REFERENCES alarma(id) ON UPDATE CASCADE ON DELETE NO ACTION
);