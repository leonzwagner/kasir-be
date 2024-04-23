import { prisma } from "../database/db.js";

export const gPelanggan = async (_, res) => {
  try {
    const response = await prisma.pelanggan.findMany();
    res.status(200).json(response);
  } catch (error) {
    res.status(500).json({ msg: error.message });
  }
};

export const cPelanggan = async (req, res) => {
  const newPelanggan = req.body;

  const isExist = await prisma.pelanggan.findFirst({
    where: {
      NOMOR_TELEPON: newPelanggan.NOMOR_TELEPON,
    },
  });

  if (isExist) return res.status(404).json({ msg: "pelanggan exists!" });

  try {
    const pelanggan = await prisma.pelanggan.create({
      data: {
        NAMA_PELANGGAN: newPelanggan.NAMA_PELANGGAN,
        ALAMAT: newPelanggan.ALAMAT,
        NOMOR_TELEPON: newPelanggan.NOMOR_TELEPON,
      },
    });
    res.status(201).json({ msg: "data created", data: pelanggan });
  } catch (error) {
    res.status(500).json({ msg: error.message })
  }
};

export const gPelangganByParams = async (req, res) => {
  const paramsId = parseInt(req.params.id);
  try {
    const pelanggan = await prisma.pelanggan.findFirst({
      where: {
        ID_PELANGGAN: paramsId 
      },
    });
    res.status(200).json(pelanggan);
  } catch (error) {
    res.status(500).json({ msg: error.message });
  }
};

export const dPelanggan = async (req, res) => {
  const params = parseInt(req.params.id);

  try {
    const pelanggan = await prisma.pelanggan.delete({
      where: {
        ID_PELANGGAN: params,
      },
    });
    res.status(200).json({ msg: "data deleted", pelanggan });
  } catch (error) {
    res.status(500).json({ msg: error.message });
  }
};

export const uPelanggan = async (req, res) => {
  const upPelanggan = req.body;
  const params = parseInt(req.params.id);

  try {
    const pelanggan = await prisma.pelanggan.update({
      where: {
        ID_PELANGGAN: params,
      },

      data: {
        NAMA_PELANGGAN: upPelanggan.NAMA_PELANGGAN,
        ALAMAT: upPelanggan.ALAMAT,
        NOMOR_TELEPON: upPelanggan.NOMOR_TELEPON,
      },
    });
    res.status(200).json({ msg: "data updated", data: pelanggan });
  } catch (error) {
    res.status(500).json({ msg: error.message });
  }
};

