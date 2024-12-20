/*
  Warnings:

  - Made the column `userId` on table `Usage` required. This step will fail if there are existing NULL values in that column.
  - Made the column `voucherid` on table `Usage` required. This step will fail if there are existing NULL values in that column.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Usage" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "userId" TEXT NOT NULL,
    "voucherid" TEXT NOT NULL,
    "usedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "Usage_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Usage_voucherid_fkey" FOREIGN KEY ("voucherid") REFERENCES "Voucher" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Usage" ("id", "usedAt", "userId", "voucherid") SELECT "id", coalesce("usedAt", CURRENT_TIMESTAMP) AS "usedAt", "userId", "voucherid" FROM "Usage";
DROP TABLE "Usage";
ALTER TABLE "new_Usage" RENAME TO "Usage";
CREATE TABLE "new_User" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "email" TEXT,
    "password" TEXT NOT NULL,
    "role" TEXT NOT NULL
);
INSERT INTO "new_User" ("email", "id", "name", "password", "role") SELECT "email", "id", "name", "password", "role" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
