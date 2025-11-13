import { type User, type InsertUser, type PersonalMacro, type InsertPersonalMacro } from "@shared/schema";
import { randomUUID } from "crypto";

export interface IStorage {
  getUser(id: string): Promise<User | undefined>;
  getUserByUsername(username: string): Promise<User | undefined>;
  createUser(user: InsertUser): Promise<User>;
  
  getAllMacros(): Promise<PersonalMacro[]>;
  getCuratedMacros(): Promise<PersonalMacro[]>;
  getPersonalMacros(): Promise<PersonalMacro[]>;
  getPersonalMacro(id: string): Promise<PersonalMacro | undefined>;
  createPersonalMacro(macro: InsertPersonalMacro): Promise<PersonalMacro>;
  createCuratedMacro(macro: InsertPersonalMacro): Promise<PersonalMacro>;
  deletePersonalMacro(id: string): Promise<boolean>;
}

export class MemStorage implements IStorage {
  private users: Map<string, User>;
  private personalMacros: Map<string, PersonalMacro>;

  constructor() {
    this.users = new Map();
    this.personalMacros = new Map();
  }

  async getUser(id: string): Promise<User | undefined> {
    return this.users.get(id);
  }

  async getUserByUsername(username: string): Promise<User | undefined> {
    return Array.from(this.users.values()).find(
      (user) => user.username === username,
    );
  }

  async createUser(insertUser: InsertUser): Promise<User> {
    const id = randomUUID();
    const user: User = { ...insertUser, id };
    this.users.set(id, user);
    return user;
  }

  async getAllMacros(): Promise<PersonalMacro[]> {
    return Array.from(this.personalMacros.values());
  }

  async getCuratedMacros(): Promise<PersonalMacro[]> {
    return Array.from(this.personalMacros.values()).filter(macro => !macro.isPersonal);
  }

  async getPersonalMacros(): Promise<PersonalMacro[]> {
    return Array.from(this.personalMacros.values()).filter(macro => macro.isPersonal);
  }

  async getPersonalMacro(id: string): Promise<PersonalMacro | undefined> {
    return this.personalMacros.get(id);
  }

  async createPersonalMacro(insertMacro: InsertPersonalMacro): Promise<PersonalMacro> {
    const id = randomUUID();
    const macro: PersonalMacro = { ...insertMacro, id, isPersonal: true };
    this.personalMacros.set(id, macro);
    return macro;
  }

  async createCuratedMacro(insertMacro: InsertPersonalMacro): Promise<PersonalMacro> {
    const id = randomUUID();
    const macro: PersonalMacro = { ...insertMacro, id, isPersonal: false };
    this.personalMacros.set(id, macro);
    return macro;
  }

  async deletePersonalMacro(id: string): Promise<boolean> {
    return this.personalMacros.delete(id);
  }
}

export const storage = new MemStorage();
