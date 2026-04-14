create schema if not exists hotel_schema;

create table if not exists hotel_schema.hotel (
    hotel_id int primary key auto_increment,
    hotel_name varchar(100) not null,
    phone varchar(20) not null unique,
    email varchar(100) not null unique,
    star_rating int not null check (star_rating >= 1 and star_rating <= 5)
);

create table if not exists hotel_schema.room_type (
    room_type_id int primary key auto_increment,
    type_name varchar(50) not null,
    max_occupancy int not null check (max_occupancy > 0),
    base_price decimal(10,2) not null check (base_price >= 0)
);

create table if not exists hotel_schema.department (
    department_id int primary key auto_increment,
    hotel_id int not null,
    dept_name varchar(50) not null,
    foreign key (hotel_id) references hotel_schema.hotel(hotel_id)
);

create table if not exists hotel_schema.staff (
    staff_id int primary key auto_increment,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    position varchar(50) not null,
    email varchar(100) not null unique,
    department_id int not null,
    foreign key (department_id) references hotel_schema.department(department_id)
);

create table if not exists hotel_schema.room (
    room_id int primary key auto_increment,
    hotel_id int not null,
    room_type_id int not null,
    room_number varchar(10) not null,
    floor int not null,
    status varchar(20) default 'available',
    unique (hotel_id, room_number),
    foreign key (hotel_id) references hotel_schema.hotel(hotel_id),
    foreign key (room_type_id) references hotel_schema.room_type(room_type_id)
);

create table if not exists hotel_schema.customer (
    customer_id int primary key auto_increment,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    email varchar(100) not null unique,
    phone varchar(20) not null,
    passport_number varchar(30) not null unique,
    gender char(1) not null check (gender in ('m', 'f'))
);

create table if not exists hotel_schema.booking (
    booking_id int primary key auto_increment,
    check_in_date date not null check (check_in_date > '2026-01-01'),
    check_out_date date not null,
    status varchar(20) default 'confirmed',
    total_price decimal(10,2) not null check (total_price >= 0),
    customer_id int not null,
    room_id int not null,
    check (check_out_date > check_in_date),
    foreign key (customer_id) references hotel_schema.customer(customer_id),
    foreign key (room_id) references hotel_schema.room(room_id)
);

create table if not exists hotel_schema.service (
    service_id int primary key auto_increment,
    service_name varchar(100) not null,
    category varchar(50) not null,
    price decimal(10,2) not null check (price >= 0)
);

create table if not exists hotel_schema.booking_service (
    booking_service_id int primary key auto_increment,
    quantity int not null check (quantity > 0),
    service_date date not null check (service_date > '2026-01-01'),
    booking_id int not null,
    service_id int not null,
    foreign key (booking_id) references hotel_schema.booking(booking_id),
    foreign key (service_id) references hotel_schema.service(service_id)
);

create table if not exists hotel_schema.payment (
    payment_id int primary key auto_increment,
    amount decimal(10,2) not null check (amount > 0),
    payment_date timestamp default current_timestamp,
    payment_method varchar(30) not null,
    status varchar(20) default 'pending',
    booking_id int not null,
    foreign key (booking_id) references hotel_schema.booking(booking_id)
);

create table if not exists hotel_schema.review (
    review_id int primary key auto_increment,
    rating int not null check (rating between 1 and 5),
    comment text,
    created_at timestamp default current_timestamp,
    booking_id int not null,
    foreign key (booking_id) references hotel_schema.booking(booking_id)
);

create table if not exists hotel_schema.checkin_log (
    log_id int primary key auto_increment,
    actual_checkin timestamp null,
    actual_checkout timestamp null,
    staff_id int not null,
    booking_id int not null,
    foreign key (staff_id) references hotel_schema.staff(staff_id),
    foreign key (booking_id) references hotel_schema.booking(booking_id)
);

insert ignore into hotel_schema.hotel (hotel_name, phone, email, star_rating) values
('grand palace hotel', '+7-727-123-4567', 'info@grandpalace.kz', 5),
('city inn', '+7-727-987-6543', 'contact@cityinn.kz', 3);

insert ignore into hotel_schema.room_type (type_name, max_occupancy, base_price) values
('standard', 2, 80.00),
('deluxe', 2, 150.00),
('suite', 4, 300.00);

insert ignore into hotel_schema.customer (first_name, last_name, email, phone, passport_number, gender) values
('nurlan', 'akhmetov', 'nurlan@mail.kz', '+77001234567', 'kz123456', 'm'),
('sara', 'ospanova', 'sara@gmail.com', '+77009876543', 'kz789012', 'f');
