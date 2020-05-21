const express = require('express');
const cors = require('cors');
const morgan = require('morgan');

const { routes } = require('./routes');
const port = process.env.PORT || 3333;
const app = express();

app.use(morgan('dev'));
app.use(cors());
app.use(express.json());
app.use(routes);

app.listen(port);
