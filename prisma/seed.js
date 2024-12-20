import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

const seed = async () => {
  // clean up before the seeding (optional)
  await prisma.user.deleteMany();

  // you could also use createMany
  // but it is not supported for databases
  // e.g. SQLite https://github.com/prisma/prisma/issues/10710
  await prisma.user.create({
    data: {
      name:'admin',
      password:'admin',
      role: 'admin'
    }
  });
  console.log("admin user created");

  await prisma.voucher.create({
    data: {
      name:'Voucher1',
    }
  });
  console.log("Voucher1 created");
};

await seed();