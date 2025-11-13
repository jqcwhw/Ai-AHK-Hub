import { sql } from "drizzle-orm";
import { pgTable, text, varchar } from "drizzle-orm/pg-core";
import { createInsertSchema } from "drizzle-zod";
import { z } from "zod";

export const users = pgTable("users", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  username: text("username").notNull().unique(),
  password: text("password").notNull(),
});

export const insertUserSchema = createInsertSchema(users).pick({
  username: true,
  password: true,
});

export type InsertUser = z.infer<typeof insertUserSchema>;
export type User = typeof users.$inferSelect;

export const githubSearchSchema = z.object({
  query: z.string().min(1),
  page: z.number().optional().default(1),
  perPage: z.number().optional().default(30),
});

export type GitHubSearchQuery = z.infer<typeof githubSearchSchema>;

export interface GitHubSearchResult {
  id: string;
  repository: string;
  owner: string;
  fileName: string;
  filePath: string;
  stars: number;
  description: string;
  codePreview: string;
  url: string;
  downloadUrl: string;
  language: "AHK v1" | "AHK v2";
}

export const personalMacroSchema = z.object({
  name: z.string().min(1),
  description: z.string(),
  content: z.string().min(1),
  tags: z.array(z.string()),
  version: z.enum(["v1", "v2"]),
});

export type InsertPersonalMacro = z.infer<typeof personalMacroSchema>;

export interface PersonalMacro extends InsertPersonalMacro {
  id: string;
  isPersonal: boolean;
}

// Big Games PS99 API schemas
export const bigGamesApiKeySchema = z.object({
  apiKey: z.string().min(1),
});

export type BigGamesApiKey = z.infer<typeof bigGamesApiKeySchema>;

export interface ClanData {
  Name: string;
  Created: number;
  Owner?: number;
  Icon: string;
  Desc?: string;
  MemberCapacity: number;
  OfficerCapacity?: number;
  GuildLevel?: number;
  Members?: Array<{
    UserID: number;
    PermissionLevel: number;
    JoinTime: number;
  }>;
  Contribution?: {
    Battle?: Array<{
      UserID: number;
      Points: number;
    }>;
  };
  CountryCode: string;
  DepositedDiamonds: number;
  Points: number;
  BronzeMedals?: number;
  SilverMedals?: number;
  GoldMedals?: number;
}

export interface ClanBattleData {
  status: string;
  data: {
    Clans: string[];
    EndTime: number;
    GoalDiamonds: number;
    StartTime: number;
  } | null;
}

export interface RAPItem {
  category: string;
  configData: {
    id: string;
    pt?: number;
    sh?: boolean;
    tn?: number;
  };
  value: number;
}

export interface ExistsItem {
  category: string;
  configData: {
    id: string;
    pt?: number;
    sh?: boolean;
    tn?: number;
  };
  value: number;
}
