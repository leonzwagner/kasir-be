import { prisma } from "../database/db.js";

export const gDetail = async (_, res) => {
  try {
    const response = await prisma.detailpenjualan.findMany({
      include: {
        penjualan: true,
      },
    });
    res.status(200).json(response);
  } catch (error) {
    res.status(500).json({ msg: error.message });
  }
};

export const cDetail = async (req, res) => {
   
};
