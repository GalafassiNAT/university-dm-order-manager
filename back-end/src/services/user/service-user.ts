import { PrismaClient } from "@prisma/client";
import { PayloadAcessToken } from "../../utils/security/security";

export default class ServiceUser {
  prismaClient: PrismaClient;

  constructor(prismaClient: PrismaClient) {
    this.prismaClient = prismaClient;
  }

  async getAll(payloadAccessToken: PayloadAcessToken) {
    const { companyId } = payloadAccessToken;

    const users = await this.prismaClient.user.findMany({
      where: {
        companyId,
        deleted: false
      }, select: {
        id: true,
        name: true,
        profileTypeName: true,
        OrderBeingMade: true,
        OrderCompleted: true,
        OrderCreated: true,
        OrderDelivered: true,
      }
    })

    return users
  }

  async get(payloadAccessToken: PayloadAcessToken, userId: number) {
    const user = await this.prismaClient.user.findUnique({
      where: {
        id: userId,
        companyId: payloadAccessToken.companyId,
        deleted: false
      },
      select: {
        id: true,
        name: true,
        profileTypeName: true,
        OrderBeingMade: true,
        OrderCompleted: true,
        OrderCreated: true,
        OrderDelivered: true,
      }
    });

    if (user === null)
      throw "Usuario não econtrado !";

    return user;
  }
}