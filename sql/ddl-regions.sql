-- Drop table

-- DROP TABLE public.region

CREATE TABLE public.region (
	region_id serial NOT NULL,
	"name" varchar NULL,
	ordinal varchar NULL,
	CONSTRAINT region_pk PRIMARY KEY (region_id)
)
WITH (
	OIDS=FALSE
) ;



-- Drop table

-- DROP TABLE public.province

CREATE TABLE public.province (
	province_id serial NOT NULL,
	"name" varchar NULL,
	region_id int4 NULL,
	CONSTRAINT province_pk PRIMARY KEY (province_id),
	CONSTRAINT province_region_fk FOREIGN KEY (region_id) REFERENCES region(region_id)
)
WITH (
	OIDS=FALSE
) ;

-- Drop table

-- DROP TABLE public.commune

CREATE TABLE public.commune (
	commune_id serial NOT NULL,
	"name" varchar NULL,
	province_id int4 NULL,
	CONSTRAINT commune_pk PRIMARY KEY (commune_id),
	CONSTRAINT commune_province_fk FOREIGN KEY (province_id) REFERENCES province(province_id)
)
WITH (
	OIDS=FALSE
) ;


