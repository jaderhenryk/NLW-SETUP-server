-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_dayHabits" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "day_id" TEXT NOT NULL,
    "habit_id" TEXT NOT NULL,
    CONSTRAINT "dayHabits_day_id_fkey" FOREIGN KEY ("day_id") REFERENCES "days" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "dayHabits_habit_id_fkey" FOREIGN KEY ("habit_id") REFERENCES "habits" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_dayHabits" ("day_id", "habit_id", "id") SELECT "day_id", "habit_id", "id" FROM "dayHabits";
DROP TABLE "dayHabits";
ALTER TABLE "new_dayHabits" RENAME TO "dayHabits";
CREATE UNIQUE INDEX "dayHabits_day_id_habit_id_key" ON "dayHabits"("day_id", "habit_id");
CREATE TABLE "new_habit_week-days" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "habit_id" TEXT NOT NULL,
    "week_day" INTEGER NOT NULL,
    CONSTRAINT "habit_week-days_habit_id_fkey" FOREIGN KEY ("habit_id") REFERENCES "habits" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_habit_week-days" ("habit_id", "id", "week_day") SELECT "habit_id", "id", "week_day" FROM "habit_week-days";
DROP TABLE "habit_week-days";
ALTER TABLE "new_habit_week-days" RENAME TO "habit_week-days";
CREATE UNIQUE INDEX "habit_week-days_habit_id_week_day_key" ON "habit_week-days"("habit_id", "week_day");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
