import express from "express";
const app = express();
const port = 3000;

app.get("/", (req, res) => {
  res.send("Hello GDSC!");
});

app.listen(port, () => {
  console.log(`app listening on port ${port}`);
});
