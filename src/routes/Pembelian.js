import express from "express";
import { createPembelianWithDetil, gPembelian } from "../controllers/Pembelian.js";

const router = express.Router();

// Endpoint untuk membuat pembelian dengan detail pembelian
router.post("/kasir/pembelian", async (req, res) => {
  try {
    const {
      tanggal,
      totalPembelian,
      potongan,
      metodePembayaran,
      keterangan,
      idPengguna,
      idPemasok,
      detilPembelian,
    } = req.body;

    // Panggil fungsi createPembelianWithDetil dari controller dengan data yang diterima dari body request
    const newPembelian = await createPembelianWithDetil({
      tanggal,
      totalPembelian,
      potongan,
      metodePembayaran,
      keterangan,
      idPengguna,
      idPemasok,
      detilPembelian,
    });

    // Kirim response dengan pembelian yang baru dibuat
    res.status(201).json(newPembelian);
  } catch (error) {
    // Tangani error jika pembuatan pembelian gagal
    res.status(500).json({ error: error.message });
  }
});

router.get("/kasir/pembelian", gPembelian)

export default router;
