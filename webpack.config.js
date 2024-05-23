var path = require('path');
var autoprefixer = require('autoprefixer')

module.exports = {
    entry: './src/main/js/app.js',
    devtool: 'eval-source-map',
    cache: true,
    mode: 'development',
    output: {
        path: __dirname,
        filename: 'bundle.js'
    },
    module: {
        rules: [
            {
                test: path.join(__dirname, '.'),
                exclude: /(node_modules)/,
                use: [{
                    loader: 'babel-loader',
                    options: {
                        presets: ["@babel/preset-env", "@babel/preset-react"]
                    }
                }]
            },
             {
                test: /\.css$/,
                use: [
                    'style-loader',
                    'css-loader'
                ]
            },
            {
                    test: /\.less$/i,
                    use: [
                      // compiles Less to CSS
                      "style-loader",
                      "css-loader",
                      "less-loader",
                    ],
                  }
        ]
    }
};