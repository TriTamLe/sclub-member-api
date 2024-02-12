/*
  Warnings:

  - You are about to drop the `member_club_roles` table. If the table is not empty, all the data it contains will be lost.
  - Changed the type of `participant_term` on the `members` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- DropForeignKey
ALTER TABLE "member_club_roles" DROP CONSTRAINT "member_club_roles_club_roles_value_fkey";

-- DropForeignKey
ALTER TABLE "member_club_roles" DROP CONSTRAINT "member_club_roles_memberId_fkey";

-- AlterTable
ALTER TABLE "members" DROP COLUMN "participant_term",
ADD COLUMN     "participant_term" INTEGER NOT NULL;

-- DropTable
DROP TABLE "member_club_roles";

-- CreateTable
CREATE TABLE "member_club_positions" (
    "id" UUID NOT NULL DEFAULT uuid_generate_v4(),
    "createdAt" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "termId" INTEGER NOT NULL,
    "memberId" UUID NOT NULL,
    "club_position_value" VARCHAR(255) NOT NULL,

    CONSTRAINT "member_club_positions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "term" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "startYear" INTEGER NOT NULL,

    CONSTRAINT "term_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "members" ADD CONSTRAINT "members_participant_term_fkey" FOREIGN KEY ("participant_term") REFERENCES "term"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "member_club_positions" ADD CONSTRAINT "member_club_positions_termId_fkey" FOREIGN KEY ("termId") REFERENCES "term"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "member_club_positions" ADD CONSTRAINT "member_club_positions_memberId_fkey" FOREIGN KEY ("memberId") REFERENCES "members"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "member_club_positions" ADD CONSTRAINT "member_club_positions_club_position_value_fkey" FOREIGN KEY ("club_position_value") REFERENCES "club_roles"("value") ON DELETE RESTRICT ON UPDATE CASCADE;
