CREATE TABLE "user_host" (
	"user_host_id" serial NOT NULL,
	"user_status_id" integer NOT NULL,
	"first_name" VARCHAR(100) NOT NULL,
	"last_name" VARCHAR(100) NOT NULL,
	"email" VARCHAR(100) NOT NULL UNIQUE,
	"password" VARCHAR(100) NOT NULL,
	"google" BOOLEAN NOT NULL,
	"bank_account_id" integer NOT NULL,
	CONSTRAINT user_host_pk PRIMARY KEY ("user_host_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "event" (
	"event_id" serial NOT NULL,
	"user_host_id" integer NOT NULL,
	"title" varchar(100) NOT NULL,
	"description" TEXT NOT NULL,
	"start_event_date" TIMESTAMP NOT NULL,
	"start_sale_date" TIMESTAMP NOT NULL,
	"end_sale_date" TIMESTAMP NOT NULL,
	"end_event_date" TIMESTAMP NOT NULL,
	"street_address" varchar(200) NOT NULL,
	"address_number" varchar(50) NOT NULL,
	"city_id" integer NOT NULL,
	"address_description" varchar(200) NOT NULL,
	"url_facebook_site" varchar(200) NOT NULL,
	"website_url" varchar(200) NOT NULL,
	"contact_email" varchar(200) NOT NULL,
	"event_type_id" integer NOT NULL,
	"event_image" varchar(200) NOT NULL,
	"min_age_assistant" integer NOT NULL,
	"event_status_id" integer NOT NULL,
	CONSTRAINT event_pk PRIMARY KEY ("event_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "event_type" (
	"event_type_id" serial NOT NULL,
	"name" varchar(100) NOT NULL,
	"description" varchar(200) NOT NULL,
	CONSTRAINT event_type_pk PRIMARY KEY ("event_type_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "event_status" (
	"event_status_id" serial NOT NULL,
	"name" varchar(100) NOT NULL,
	"description" varchar(200) NOT NULL,
	CONSTRAINT event_status_pk PRIMARY KEY ("event_status_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "ticket_type" (
	"ticket_type_id" serial NOT NULL,
	"name" varchar(100) NOT NULL,
	"event_id" integer,
	CONSTRAINT ticket_type_pk PRIMARY KEY ("ticket_type_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "user_assistant" (
	"user_assistant_id" serial NOT NULL,
	"user_status_id" integer NOT NULL,
	"first_name" VARCHAR(100) NOT NULL,
	"last_name" VARCHAR(100) NOT NULL,
	"email" VARCHAR(100) NOT NULL UNIQUE,
	"password" VARCHAR(100) NOT NULL,
	"google" BOOLEAN NOT NULL,
	"birth_date" TIMESTAMP NOT NULL,
	CONSTRAINT user_assistant_pk PRIMARY KEY ("user_assistant_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "user_status" (
	"user_status_id" serial NOT NULL,
	"status" VARCHAR(100) NOT NULL UNIQUE,
	"description" VARCHAR(100) NOT NULL,
	CONSTRAINT user_status_pk PRIMARY KEY ("user_status_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "bank_account" (
	"bank_account_id" serial NOT NULL,
	"bank_id" integer NOT NULL,
	"account_type_id" integer NOT NULL,
	"account_numer" integer NOT NULL,
	CONSTRAINT bank_account_pk PRIMARY KEY ("bank_account_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "account_type" (
	"account_type_id" serial NOT NULL,
	"name" VARCHAR(100) NOT NULL,
	CONSTRAINT account_type_pk PRIMARY KEY ("account_type_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "bank" (
	"bank_id" serial NOT NULL,
	"name" VARCHAR(100) NOT NULL,
	CONSTRAINT bank_pk PRIMARY KEY ("bank_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "sale_stage" (
	"sale_stage_id" serial NOT NULL,
	"name" varchar(100) NOT NULL,
	"start_date" TIMESTAMP NOT NULL,
	"end_date" TIMESTAMP NOT NULL,
	"event_id" integer NOT NULL,
	CONSTRAINT sale_stage_pk PRIMARY KEY ("sale_stage_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "stage_ticket" (
	"stage_ticket_id" serial NOT NULL,
	"ticket_type_id" integer NOT NULL,
	"sale_stage_id" integer NOT NULL,
	"quantity" integer NOT NULL,
	"price" DECIMAL NOT NULL,
	CONSTRAINT stage_ticketT_pk PRIMARY KEY ("stage_ticket_id")
) WITH (
  OIDS=FALSE
);



ALTER TABLE "user_host" ADD CONSTRAINT "user_host_fk0" FOREIGN KEY ("user_status_id") REFERENCES "user_status"("user_status_id");
ALTER TABLE "user_host" ADD CONSTRAINT "user_host_fk1" FOREIGN KEY ("bank_account_id") REFERENCES "bank_account"("bank_account_id");

ALTER TABLE "event" ADD CONSTRAINT "event_fk0" FOREIGN KEY ("user_host_id") REFERENCES "user_host"("user_host_id");
ALTER TABLE "event" ADD CONSTRAINT "event_fk1" FOREIGN KEY ("event_type_id") REFERENCES "event_type"("event_type_id");
ALTER TABLE "event" ADD CONSTRAINT "event_fk2" FOREIGN KEY ("event_status_id") REFERENCES "event_status"("event_status_id");



ALTER TABLE "ticket_type" ADD CONSTRAINT "ticket_type_fk0" FOREIGN KEY ("event_id") REFERENCES "event"("event_id");

ALTER TABLE "user_assistant" ADD CONSTRAINT "user_assistant_fk0" FOREIGN KEY ("user_status_id") REFERENCES "user_status"("user_status_id");


ALTER TABLE "bank_account" ADD CONSTRAINT "bank_account_fk0" FOREIGN KEY ("bank_id") REFERENCES "bank"("bank_id");
ALTER TABLE "bank_account" ADD CONSTRAINT "bank_account_fk1" FOREIGN KEY ("account_type_id") REFERENCES "account_type"("account_type_id");



ALTER TABLE "sale_stage" ADD CONSTRAINT "sale_stage_fk0" FOREIGN KEY ("event_id") REFERENCES "event"("event_id");

ALTER TABLE "stage_ticket" ADD CONSTRAINT "stage_ticket_fk0" FOREIGN KEY ("ticket_type_id") REFERENCES "ticket_type"("ticket_type_id");
ALTER TABLE "stage_ticket" ADD CONSTRAINT "stage_ticket_fk1" FOREIGN KEY ("sale_stage_id") REFERENCES "sale_stage"("sale_stage_id");

