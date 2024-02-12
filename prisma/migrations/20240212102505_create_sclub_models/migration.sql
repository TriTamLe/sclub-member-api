/*
  Warnings:

  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateExtension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- DropTable
DROP TABLE "User";

-- CreateTable
CREATE TABLE "club_roles" (
    "id" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "createdAt" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "display_name" TEXT NOT NULL,
    "value" VARCHAR(255) NOT NULL,

    CONSTRAINT "club_roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "houses" (
    "id" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "createdAt" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "name" TEXT NOT NULL,
    "value" SERIAL NOT NULL,
    "memberId" UUID NOT NULL,

    CONSTRAINT "houses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "members" (
    "id" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "createdAt" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "email" TEXT NOT NULL,
    "hash" TEXT NOT NULL,
    "name" TEXT,
    "phone" TEXT,
    "birthday" TIMESTAMP(3),
    "address" TEXT,
    "university" TEXT,
    "major" TEXT,
    "houseValue" INTEGER NOT NULL,
    "member_type_value" INTEGER NOT NULL,
    "hasRole" BOOLEAN NOT NULL DEFAULT false,
    "participant_term" TEXT NOT NULL,

    CONSTRAINT "members_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "member_club_roles" (
    "id" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "createdAt" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "term" TEXT NOT NULL,
    "memberId" UUID NOT NULL,
    "club_roles_value" VARCHAR(255) NOT NULL,

    CONSTRAINT "member_club_roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "member_types" (
    "id" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "createdAt" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "name" TEXT NOT NULL,
    "value" SERIAL NOT NULL,

    CONSTRAINT "member_types_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "roles" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "display_name" VARCHAR(255) NOT NULL,

    CONSTRAINT "roles_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "club_roles_value_key" ON "club_roles"("value");

-- CreateIndex
CREATE UNIQUE INDEX "houses_value_key" ON "houses"("value");

-- CreateIndex
CREATE UNIQUE INDEX "members_email_key" ON "members"("email");

-- CreateIndex
CREATE UNIQUE INDEX "member_types_value_key" ON "member_types"("value");

-- AddForeignKey
ALTER TABLE "members" ADD CONSTRAINT "members_houseValue_fkey" FOREIGN KEY ("houseValue") REFERENCES "houses"("value") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "members" ADD CONSTRAINT "members_member_type_value_fkey" FOREIGN KEY ("member_type_value") REFERENCES "member_types"("value") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "member_club_roles" ADD CONSTRAINT "member_club_roles_memberId_fkey" FOREIGN KEY ("memberId") REFERENCES "members"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "member_club_roles" ADD CONSTRAINT "member_club_roles_club_roles_value_fkey" FOREIGN KEY ("club_roles_value") REFERENCES "club_roles"("value") ON DELETE RESTRICT ON UPDATE CASCADE;
