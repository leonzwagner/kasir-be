import { prisma } from "../database/db.js";

export const Login = async (req, res) => {
  try {
    const { username, password } = req.body;

    const user = await prisma.pengguna.findMany({
      where: {
        USERNAME: username,
        PASSWORD: password,
      },
    });

    if (user.length === 1) {
      req.session.username = user[0].USERNAME;
      console.log(req.session.username);
      res.send(`${req.session.username} logged in`);
    } else {
      return res.status(401).json({ msg: "Authentication failed" });
    }
  } catch (error) {
    return res.status(500).json({ msg: error.message });
  }
};

export const Register = async (req, res) => {
  const newPengguna = req.body;

  if (newPengguna.PASSWORD !== newPengguna.CONFPASS)
    return res.status(400).json({ msg: "password must be matched" });

  const isExist = await prisma.pengguna.findFirst({
    where: {
      NOMOR_TELEPON: newPengguna.NOMOR_TELEPON,
    },
  });


  if (isExist) return res.status(400).json({ msg: "user existed" });

  try {
    const pengguna = await prisma.pengguna.create({
      data: {
        NAMA_PENGGUNA: newPengguna.NAMA_PENGGUNA,
        ALAMAT: newPengguna.ALAMAT,
        NOMOR_TELEPON: newPengguna.NOMOR_TELEPON,
        USERNAME: newPengguna.USERNAME,
        PASSWORD: newPengguna.PASSWORD,
        HAK_AKSES: "petugas",
      },
    });
    res.status(201).json({ msg: "data created", data: pengguna });
  } catch (error) {
    res.status(500).json({ msg: error.message });
  }
};

export const gUsers = async(_, res) => {
  try {
    const response = await prisma.pengguna.findMany()
    res.status(200).json(response)
  } catch (error) {
    res.status(500).json({ msg: error.message})
  }
}

export const Me = async (req, res) => {
  if (!req.session.username) {
    return res.status(404).json({ msg: "Mohon login" });
  }

  const user = await prisma.pengguna.findFirst({
    where: {
      USERNAME: req.session.username,
    },

    select: {
      USERNAME: true,
      HAK_AKSES: true
    }
  });

  if (user.length == 0) return res.status(404).json({ msg: "failed" });
  res.status(200).json({ user });
};

export const Logout = (req, res) => {
  req.session.destroy((error)=> {
    if(error) return res.status(400).json({ msg: "cannot logout" })
    res.status(200).json({ msg: "you were logout"})
  })
}
