import express from "express";
import cors from "cors";
import "dotenv/config";
import routerAuth from "./router/auth/router-auth";
import { PrismaClient } from "@prisma/client";
import Security, { PayloadAcessToken } from "./utils/security/security";
import routerUser from "./router/user/router-user";
import routerOrder from "./router/order/router-order";

declare module 'express-serve-static-core' {
  interface Request {
    payloadAccessToken?: PayloadAcessToken;
  }
  interface Response {
  }
}

const { ADDRESS, PORT, CRYPTO_KEY } = process.env;

if (ADDRESS === undefined || PORT === undefined || CRYPTO_KEY === undefined) throw ".ENV invalid !"

const app = express();

app.use(cors());

app.use(express.json());

app.get("/", (request, response) => {
  response.status(200).json({ message: "Running" });
});

const prismaClient = new PrismaClient();

const security = new Security(CRYPTO_KEY);

app.use("/auth", routerAuth(prismaClient, security));
app.use("/user", routerUser(prismaClient, security));
app.use("/order", routerOrder(prismaClient, security))

app.listen(Number(PORT), ADDRESS, () => {
  console.log(`[SERVER]: http://${ADDRESS}:${PORT}`);
});