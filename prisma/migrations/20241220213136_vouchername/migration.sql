/*
  Warnings:

  - Made the column `name` on table `Voucher` required. This step will fail if there are existing NULL values in that column.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Voucher" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "image" TEXT,
    "name" TEXT NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true
);
INSERT INTO "new_Voucher" ("active", "id", "image", "name") SELECT "active", "id", "image", "name" FROM "Voucher";
DROP TABLE "Voucher";
ALTER TABLE "new_Voucher" RENAME TO "Voucher";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
