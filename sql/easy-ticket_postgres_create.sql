CREATE TABLE "USER_HOST" (
	"user_host_id" serial NOT NULL,
	"user_status_id" integer NOT NULL,
	"name" VARCHAR(100) NOT NULL,
	"email" VARCHAR(100) NOT NULL UNIQUE,
	"password" VARCHAR(100) NOT NULL,
	"google" BOOLEAN NOT NULL,
	"bank_account_id" integer NOT NULL,
	CONSTRAINT USER_HOST_pk PRIMARY KEY ("user_host_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "EVENT" (
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
	CONSTRAINT EVENT_pk PRIMARY KEY ("event_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "EVENT_TYPE" (
	"event_type_id" serial NOT NULL,
	"name" varchar(100) NOT NULL,
	"description" varchar(200) NOT NULL,
	CONSTRAINT EVENT_TYPE_pk PRIMARY KEY ("event_type_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "EVENT_STATUS" (
	"event_status_id" serial NOT NULL,
	"name" varchar(100) NOT NULL,
	"description" varchar(200) NOT NULL,
	CONSTRAINT EVENT_STATUS_pk PRIMARY KEY ("event_status_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "TICKET_TYPE" (
	"ticket_type_id" serial NOT NULL,
	"name" varchar(100) NOT NULL,
	"event_id" integer,
	CONSTRAINT TICKET_TYPE_pk PRIMARY KEY ("ticket_type_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "USER_ASSISTANT" (
	"user_assistant_id" serial NOT NULL,
	"user_status_id" integer NOT NULL,
	"name" VARCHAR(100) NOT NULL,
	"email" VARCHAR(100) NOT NULL UNIQUE,
	"password" VARCHAR(100) NOT NULL,
	"google" BOOLEAN NOT NULL,
	"birth_date" TIMESTAMP NOT NULL,
	CONSTRAINT USER_ASSISTANT_pk PRIMARY KEY ("user_assistant_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "USER_STATUS" (
	"user_status_id" serial NOT NULL,
	"status" VARCHAR(100) NOT NULL UNIQUE,
	"description" VARCHAR(100) NOT NULL,
	CONSTRAINT USER_STATUS_pk PRIMARY KEY ("user_status_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "BANK_ACCOUNT" (
	"bank_account_id" serial NOT NULL,
	"bank_id" integer NOT NULL,
	"account_type_id" integer NOT NULL,
	"account_numer" integer NOT NULL,
	CONSTRAINT BANK_ACCOUNT_pk PRIMARY KEY ("bank_account_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "ACCOUNT_TYPE" (
	"account_type_id" serial NOT NULL,
	"name" VARCHAR(100) NOT NULL,
	CONSTRAINT ACCOUNT_TYPE_pk PRIMARY KEY ("account_type_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "BANK" (
	"bank_id" serial NOT NULL,
	"name" VARCHAR(100) NOT NULL,
	CONSTRAINT BANK_pk PRIMARY KEY ("bank_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "SALE_STAGE" (
	"sale_stage_id" serial NOT NULL,
	"name" varchar(100) NOT NULL,
	"start_date" TIMESTAMP NOT NULL,
	"end_date" TIMESTAMP NOT NULL,
	"event_id" integer NOT NULL,
	CONSTRAINT SALE_STAGE_pk PRIMARY KEY ("sale_stage_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "STAGE_TICKET" (
	"stage_ticket_id" serial NOT NULL,
	"ticket_type_id" integer NOT NULL,
	"sale_stage_id" integer NOT NULL,
	"quantity" integer NOT NULL,
	"price" DECIMAL NOT NULL,
	CONSTRAINT STAGE_TICKET_pk PRIMARY KEY ("stage_ticket_id")
) WITH (
  OIDS=FALSE
);



ALTER TABLE "USER_HOST" ADD CONSTRAINT "USER_HOST_fk0" FOREIGN KEY ("user_status_id") REFERENCES "USER_STATUS"("user_status_id");
ALTER TABLE "USER_HOST" ADD CONSTRAINT "USER_HOST_fk1" FOREIGN KEY ("bank_account_id") REFERENCES "BANK_ACCOUNT"("bank_account_id");

ALTER TABLE "EVENT" ADD CONSTRAINT "EVENT_fk0" FOREIGN KEY ("user_host_id") REFERENCES "USER_HOST"("user_host_id");
ALTER TABLE "EVENT" ADD CONSTRAINT "EVENT_fk1" FOREIGN KEY ("event_type_id") REFERENCES "EVENT_TYPE"("event_type_id");
ALTER TABLE "EVENT" ADD CONSTRAINT "EVENT_fk2" FOREIGN KEY ("event_status_id") REFERENCES "EVENT_STATUS"("event_status_id");



ALTER TABLE "TICKET_TYPE" ADD CONSTRAINT "TICKET_TYPE_fk0" FOREIGN KEY ("event_id") REFERENCES "EVENT"("event_id");

ALTER TABLE "USER_ASSISTANT" ADD CONSTRAINT "USER_ASSISTANT_fk0" FOREIGN KEY ("user_status_id") REFERENCES "USER_STATUS"("user_status_id");


ALTER TABLE "BANK_ACCOUNT" ADD CONSTRAINT "BANK_ACCOUNT_fk0" FOREIGN KEY ("bank_id") REFERENCES "BANK"("bank_id");
ALTER TABLE "BANK_ACCOUNT" ADD CONSTRAINT "BANK_ACCOUNT_fk1" FOREIGN KEY ("account_type_id") REFERENCES "ACCOUNT_TYPE"("account_type_id");



ALTER TABLE "SALE_STAGE" ADD CONSTRAINT "SALE_STAGE_fk0" FOREIGN KEY ("event_id") REFERENCES "EVENT"("event_id");

ALTER TABLE "STAGE_TICKET" ADD CONSTRAINT "STAGE_TICKET_fk0" FOREIGN KEY ("ticket_type_id") REFERENCES "TICKET_TYPE"("ticket_type_id");
ALTER TABLE "STAGE_TICKET" ADD CONSTRAINT "STAGE_TICKET_fk1" FOREIGN KEY ("sale_stage_id") REFERENCES "SALE_STAGE"("sale_stage_id");

