import { prisma } from "../database/db.js";

// export const cPembelianWithDetail = async (req, res) => {
//   const { LIST_BARANG, ID_PEMASOK, POTONGAN, METODE_PEMBAYARAN, KETERANGAN } =
//     req.body;
//
//   for (let i = 0; i < LIST_BARANG.length; i++) {
//     const { ID_BARANG } = LIST_BARANG[i];
//     const barang = await prisma.barang.findUnique({
//       where: {
//         ID_BARANG: ID_BARANG,
//       },
//     });
//     if (barang) {
//       LIST_BARANG[i].HARGA_SATUAN = barang.HARGA_BELI;
//       LIST_BARANG[i].TOTAL_HARGA = LIST_BARANG[i].HARGA_SATUAN * LIST_BARANG[i].JUMLAH
//     }
//   }
//
//   const TOTAL_PEMBELIAN: number = LIST_BARANG.reduce((total, barang) => total + barang.TOTAL_HARGA, 0)
// };

export async function createPembelianWithDetil(data) {
  const currDate = new Date();
  try {
    const result = await prisma.$transaction(async (prisma) => {
      // Buat pembelian dalam satu transaksi
      const pembelian = await prisma.pembelian.create({
        data: {
          TANGGAL: currDate,
          TOTAL_PEMBELIAN: 0,
          POTONGAN: data.potongan,
          METODE_PEMBAYARAN: data.metodePembayaran,
          KETERANGAN: data.keterangan,
          pengguna: { connect: { ID_PENGGUNA: data.idPengguna } },
          pemasok: { connect: { ID_PEMASOK: data.idPemasok } },
          // Tambahkan detail pembelian dari array detilPembelian
          pembelian_detil: {
            createMany: {
              data: data.detilPembelian.map((detil) => ({
                ID_BARANG: detil.idBarang,
                HARGA_SATUAN: detil.hargaSatuan,
                JUMLAH: detil.jumlah,
                TOTAL_HARGA: detil.jumlah * detil.hargaSatuan
              })),
            },
          },
        },
      });

      return pembelian;
    });

    return result;
  } catch (error) {
    throw new Error(`Failed to create pembelian with detil: ${error.message}`);
  }
}

export const gPembelian = async (_, res) => {
  try {
    const response = await prisma.pembelian.findMany({
      include: {
        pembelian_detil: true,
      },
    });
    res.status(200).json(response);
  } catch (error) {
    res.status(500).json({ msg: error.message });
  }
};
