import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import session from "express-session";
import { MemoryStore } from "express-session";

dotenv.config();

const app = express();
const PORT = process.env.PORT;

app.use(
  cors({
    origin: "http://localhost:3000",
    credentials: true,
  }),
);
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// session
app.use(
  session({
    cookie: {
      maxAge: 900000,
      secure: false,
      sameSite: true,
    },
    secret: "halogays",
    resave: false,
    saveUninitialized: true,
    store: new MemoryStore(),
  }),
);

app.get("/", (_, res) => {
  res.send("Hello, World!");
});

// Routes
import produk from "./src/routes/ProdukRoute.js";
import pelanggan from "./src/routes/PelangganRoute.js";
import detail from "./src/routes/PenjualanRoute.js";
import auth from "./src/routes/AuthRoute.js";
import pemasok from "./src/routes/PemasokRoute.js";
import pembelian from "./src/routes/Pembelian.js";

const routes = [produk, pelanggan, detail, auth, pemasok, pembelian];

routes.forEach((route) => {
  app.use(route);
});

app.listen(PORT, () => console.log(`Server running in localhost:${PORT}`));
