create database if not exists hotel_booking;
use hotel_booking;

create table if not exists hotel (
    hotel_id int primary key auto_increment,
    hotel_name varchar(100) not null,
    phone varchar(20) not null unique,
    email varchar(100) not null unique,
    star_rating smallint not null
);

create table if not exists room_type (
    room_type_id int primary key auto_increment,
    type_name varchar(50) not null,
    max_occupancy int not null,
    base_price decimal(10,2) not null
);

create table if not exists department (
    department_id int primary key auto_increment,
    hotel_id int not null,
    dept_name varchar(50) not null,
    foreign key (hotel_id) references hotel(hotel_id)
);

create table if not exists staff (
    staff_id int primary key auto_increment,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    position varchar(50) not null,
    email varchar(100) not null unique,
    hotel_id int not null,
    department_id int not null,
    foreign key (hotel_id) references hotel(hotel_id),
    foreign key (department_id) references department(department_id)
);

create table if not exists room (
    room_id int primary key auto_increment,
    hotel_id int not null,
    room_type_id int not null,
    room_number varchar(10) not null,
    floor int not null,
    status varchar(20) not null default 'available',
    unique (hotel_id, room_number),
    foreign key (hotel_id) references hotel(hotel_id),
    foreign key (room_type_id) references room_type(room_type_id)
);

create table if not exists customer (
    customer_id int primary key auto_increment,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    email varchar(100) not null unique,
    phone varchar(20) not null,
    passport_number varchar(30) not null unique
);

create table if not exists booking (
    booking_id int primary key auto_increment,
    check_in_date date not null,
    check_out_date date not null,
    status varchar(20) not null,
    total_price decimal(10,2) not null,
    customer_id int not null,
    room_id int not null,
    foreign key (customer_id) references customer(customer_id),
    foreign key (room_id) references room(room_id)
);

create table if not exists payment (
    payment_id int primary key auto_increment,
    amount decimal(10,2) not null,
    payment_date timestamp not null,
    payment_method varchar(30) not null,
    status varchar(20) not null,
    booking_id int not null,
    foreign key (booking_id) references booking(booking_id)
);

create table if not exists service (
    service_id int primary key auto_increment,
    service_name varchar(100) not null,
    category varchar(50) not null,
    price decimal(10,2) not null
);

create table if not exists booking_service (
    booking_service_id int primary key auto_increment,
    quantity int not null,
    service_date date not null,
    total_price decimal(10,2) not null,
    booking_id int not null,
    service_id int not null,
    foreign key (booking_id) references booking(booking_id),
    foreign key (service_id) references service(service_id)
);

create table if not exists review (
    review_id int primary key auto_increment,
    rating smallint not null,
    comment text,
    created_at timestamp not null,
    booking_id int not null,
    foreign key (booking_id) references booking(booking_id)
);

create table if not exists checkin_log (
    log_id int primary key auto_increment,
    actual_checkin timestamp,
    actual_checkout timestamp,
    staff_id int not null,
    booking_id int not null,
    foreign key (staff_id) references staff(staff_id),
    foreign key (booking_id) references booking(booking_id)
);

insert into hotel values
(1, 'Grand Palace Hotel', '+7-727-123-4567', 'info@grandpalace.kz', 5),
(2, 'City Inn', '+7-727-987-6543', 'contact@cityinn.kz', 3);

insert into room_type values
(1, 'Standard', 2, 80.00),
(2, 'Deluxe', 2, 150.00),
(3, 'Suite', 4, 300.00);

insert into department values
(1, 1, 'Reception'),
(2, 1, 'Housekeeping'),
(3, 1, 'Security');

insert into staff values
(1, 'Aisha', 'Bekova', 'Receptionist', 'aisha@grandpalace.kz', 1, 1),
(2, 'Damir', 'Seitkali', 'Manager', 'damir@grandpalace.kz', 1, 1),
(3, 'Zhanna', 'Aliyeva', 'Housekeeper', 'zhanna@grandpalace.kz', 1, 2);

insert into room values
(1, 1, 1, '101', 1, 'available'),
(2, 1, 2, '205', 2, 'occupied'),
(3, 1, 3, '301', 3, 'available'),
(4, 2, 1, '101', 1, 'available');

insert into customer values
(1, 'Nurlan', 'Akhmetov', 'nurlan@mail.kz', '+77001234567', 'KZ123456'),
(2, 'Sara', 'Ospanova', 'sara@gmail.com', '+77009876543', 'KZ789012'),
(3, 'Arman', 'Bekuov', 'arman@mail.kz', '+77005554433', 'KZ345678');

insert into booking values
(1, '2026-04-01', '2026-04-05', 'confirmed', 600.00, 1, 2),
(2, '2026-04-10', '2026-04-12', 'confirmed', 160.00, 2, 1),
(3, '2026-05-01', '2026-05-03', 'confirmed', 600.00, 3, 3);

insert into payment values
(1, 300.00, '2026-03-20 14:30:00', 'card', 'completed', 1),
(2, 300.00, '2026-04-01 09:00:00', 'card', 'completed', 1),
(3, 160.00, '2026-04-08 11:00:00', 'cash', 'completed', 2),
(4, 600.00, '2026-04-25 10:00:00', 'online', 'pending', 3);

insert into service values
(1, 'Breakfast', 'Food', 15.00),
(2, 'Spa Session', 'Wellness', 50.00),
(3, 'Airport Transfer', 'Transport', 30.00),
(4, 'Parking', 'Transport', 10.00);

insert into booking_service values
(1, 4, '2026-04-02', 60.00, 1, 1),
(2, 1, '2026-04-03', 50.00, 1, 2),
(3, 2, '2026-04-11', 30.00, 2, 1),
(4, 1, '2026-05-01', 30.00, 3, 3);

insert into review values
(1, 5, 'Excellent service!', '2026-04-06 12:00:00', 1),
(2, 4, 'Very comfortable stay.', '2026-04-13 10:00:00', 2);

insert into checkin_log values
(1, '2026-04-01 14:05:00', '2026-04-05 11:30:00', 1, 1),
(2, '2026-04-10 15:00:00', null, 2, 2);