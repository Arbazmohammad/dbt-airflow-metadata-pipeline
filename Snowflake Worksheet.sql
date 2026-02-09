SUSE DATABASE AIRBNB;
USE schema STAGING;

-- DDL commands
CREATE OR REPLACE TABLE HOSTS (
    host_id NUMBER,
    host_name STRING,
    host_since DATE,
    is_superhost BOOLEAN,
    response_rate NUMBER,
    created_at TIMESTAMP,
    PRIMARY KEY (host_id)
);

CREATE OR REPLACE TABLE LISTINGS (
    listing_id NUMBER,
    host_id NUMBER,
    property_type STRING,
    room_type STRING,
    city STRING,
    country STRING,
    accommodates NUMBER,
    bedrooms NUMBER,
    bathrooms NUMBER,
    price_per_night NUMBER,
    created_at TIMESTAMP,
    PRIMARY KEY (listing_id)
);

CREATE OR REPLACE TABLE BOOKINGS (
    booking_id STRING,
    listing_id NUMBER,
    booking_date TIMESTAMP,
    nights_booked NUMBER,
    booking_amount NUMBER,
    cleaning_fee NUMBER,
    service_fee NUMBER,
    booking_status STRING,
    created_at TIMESTAMP,
    PRIMARY KEY (booking_id)
);

select * from hosts;

CREATE OR REPLACE FILE FORMAT csv_format
    TYPE = 'CSV'
    FIELD_DELIMITER = ','
    SKIP_HEADER = 1
    ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE;

show file formats;

CREATE or REPLACE STAGE snowstage
FILE_FORMAT = csv_format
URL = 's3://snowbucketarbaz/source/';

show stages;

COPY INTO BOOKINGs
FROM @snowstage
FILES = ('bookings.csv')
CREDENTIALS=(aws_key_id = 'AKIASPQ5MDW4THDNHJUV', aws_secret_key = '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');

COPY INTO LISTINGS
FROM @snowstage
FILES = ('listings.csv')
CREDENTIALS=(aws_key_id = 'AKIASPQ5MDW4THDNHJUV', aws_secret_key = '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');

COPY INTO HOSTS
FROM @snowstage
FILES = ('hosts.csv')
CREDENTIALS=(aws_key_id = 'AKIASPQ5MDW4THDNHJUV', aws_secret_key = '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');

select * from listings;

SELECT * from AIRBNB.GOLD.OBT;