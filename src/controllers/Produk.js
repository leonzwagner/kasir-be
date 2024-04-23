import { prisma } from "../database/db.js";

export const gProduk = async (_, res) => {
  try {
    const response = await prisma.barang.findMany();
    res.status(200).json(response);
  } catch (error) {
    res.status(500).json({ msg: error.message });
  }
};

export const gProdukByParams = async (req, res) => {
  const paramsId = parseInt(req.params.id);
  try {
    const produk = await prisma.barang.findFirst({
      where: {
        ID_BARANG: paramsId 
      },
    });
    res.status(200).json(produk);
  } catch (error) {
    res.status(500).json({ msg: error.message });
  }
};

export const cProduk = async (req, res) => {
  const newProduk = req.body;

  const existData = await prisma.barang.findFirst({
    where: {
      NAMA_BARANG: newProduk.NAMA_BARANG,
    },
  });

  if (existData) return res.status(400).json({ msg: "product exists!" });

  try {
    const produk = await prisma.barang.create({
      data: {
        NAMA_BARANG: newProduk.NAMA_BARANG,
        KATEGORI: newProduk.KATEGORI,
        SATUAN: newProduk.SATUAN,
        HARGA_BELI: newProduk.HARGA_BELI,
        HARGA_JUAL: newProduk.HARGA_JUAL,
        STOK: newProduk.STOK,
        KETERANGAN: newProduk.KETERANGAN,
        BARCODE: newProduk.BARCODE
      },
    });
    res.status(201).json({ msg: "data created!", data: produk });
  } catch (error) {
    res.status(500).json({ msg: error.message });
  }
};

export const cmProduk = async (req, res) => {
  const dataProduk = req.body.dataProduk;

  try {
    const createProduks = await prisma.barang.createMany({
      data: dataProduk,
      skipDuplicates: true
    });
    res.status(201).json({ msg: "data created", data: createProduks });
  } catch (error) {
    res.status(500).json({ msg: error.message });
  }
};

export const uProduk = async (req, res) => {
  const upProduk = req.body;
  const params = parseInt(req.params.id);

  try {
    const produk = await prisma.barang.update({
      where: {
        ID_BARANG: params,
      },

      data: {
        NAMA_BARANG: upProduk.NAMA_BARANG,
        KATEGORI: upProduk.KATEGORI,
        SATUAN: upProduk.SATUAN,
        HARGA_BELI: upProduk.HARGA_BELI,
        HARGA_JUAL: upProduk.HARGA_JUAL,
        STOK: upProduk.STOK,
        KETERANGAN: upProduk.KETERANGAN,
        BARCODE: upProduk.BARCODE
      },
    });
    res.status(200).json({ msg: "data updated", data: produk });
  } catch (error) {
    res.status(500).json({ msg: error.message });
  }
};

export const dProduk = async (req, res) => {
  const params = parseInt(req.params.id);

  try {
    const produk = await prisma.barang.delete({
      where: {
        ID_BARANG: params,
      },
    });
    res.status(200).json({ msg: "data deleted", produk });
  } catch (error) {
    res.status(500).json({ msg: error.message });
  }
};
