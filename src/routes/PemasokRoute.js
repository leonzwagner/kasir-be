import express from "express";

import {
  gPemasok,
  cPemasok,
  gPemasokByParams,
  uPemasok,
  dPemasok,
} from "../controllers/Pemasok.js";

import { verifyUser, adminOnly } from "../middleware/Auth.js";

const router = express.Router();

router.get("/kasir/suppliers", verifyUser, gPemasok);
router.get("/kasir/supplier/:id", verifyUser, gPemasokByParams);
router.post("/kasir/supplier", verifyUser, cPemasok);
router.patch("/kasir/supplier/:id", verifyUser, uPemasok);
router.delete("/kasir/supplier/:id",verifyUser, dPemasok )

export default router;
