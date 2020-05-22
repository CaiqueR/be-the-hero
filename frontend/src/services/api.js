import axios from "axios";

const api = axios.create({
  baseURL: "https://flutter-bethehero.herokuapp.com",
});

export default api;
