/* eslint-env node */
import ServiceWorkerWebpackPlugin from 'serviceworker-webpack-plugin'
const HtmlWebpackPlugin = require('html-webpack-plugin')
const CopyWebpackPlugin = require('copy-webpack-plugin')
const webpack = require('webpack')
const path = require('path')
const glob = require('glob')
const DashboardPlugin = require('webpack-dashboard/plugin')
const GoogleFontsPlugin = require('google-fonts-webpack-plugin')
const ExtractTextPlugin = require('extract-text-webpack-plugin')
const PurifyCSSPlugin = require('purifycss-webpack')
const BundleAnalyzerPlugin = require('webpack-bundle-analyzer').BundleAnalyzerPlugin
const Visualizer = require('webpack-visualizer-plugin')

module.exports = {
  devtool: 'source-map',
  entry: ['babel-polyfill', `${__dirname  }/src/index.js`],
  target: 'web',
  node: {
    fs: 'empty'
  },
  output: {
    path: `${__dirname  }/dist`,
    filename: '[name].js',
    chunkFilename: '[name].js',
    crossOriginLoading: 'anonymous',
    publicPath: '/'
  },
  resolve: {
    alias: {
      mainConfig$: path.resolve(__dirname, 'config.js')
    }
  },
  module: {
    rules: [{
      enforce: 'pre',
      test: /\.tag$/,
      use: 'tag-loader',
    }, {
      test: /\.js$|\.tag$/,
      exclude: /(node_modules|bower_components)/,
      use: {
        loader: 'babel-loader',
        options: {
          cacheDirectory: true,
          presets: [
            ['env', {
              'targets': {
                'browsers': ['last 1 chrome versions', 'last 1 firefox versions', 'last 1 Edge versions']
              },
              useBuiltIns: true
            }]
          ],
          plugins: ['dynamic-import-webpack', 'transform-object-rest-spread']
        }
      }
    },
    {
      test: /\.(sass|scss)$/,
      use: ExtractTextPlugin.extract(['css-loader', 'sass-loader'])
    }, {
      test: /\.(gif|svg|eot|ttf|woff|woff2)$/,
      use: {
        loader: 'url-loader',
        options: {
          limit: 10000
        }
      }
    }, {
      test: /\.(gif|png|jpe?g|svg)$/i,
      loaders: [
        'file-loader', {
          loader: 'image-webpack-loader',
          options: {
            gifsicle: {
              interlaced: false,
            },
            optipng: {
              optimizationLevel: 7,
            },
            pngquant: {
              quality: '65-90',
              speed: 4
            },
            mozjpeg: {
              progressive: true,
              quality: 65
            },
            // Specifying webp here will create a WEBP version of your JPG/PNG images
            webp: {
              quality: 75
            }
          }
        }
      ]
    }, {
      test: /\.css$/,
      use: ExtractTextPlugin.extract({
        use: {
          loader: 'css-loader'
        }
      })
    },
    {
      test: /\.html$/,
      use: [{
        loader: 'html-loader',
        options: {
          minimize: true,
          removeComments: true,
          collapseWhitespace: true,
          interpolate: true
        }
      }],
    }
    ]
  },
  plugins: [
    new webpack.ProvidePlugin({
      riot: 'riot'
    }),
    new ExtractTextPlugin({ // define where to save the file
      filename: '[name].css',
      allChunks: true
    }),
    new PurifyCSSPlugin({
      moduleExtensions: ['.html', '.tag'],
      // Give paths to parse for rules. These should be absolute!
      paths: [...glob.sync(path.join(__dirname, '/src/tags/**/*.tag')),path.join(__dirname, '/src/public/index.html')],
      purifyOptions: {
        info: true,
        minify: true,
        whitelist: ['*sn-*', 'video', '*ct-*', '*ce-*', '*content*', '*[data-editable]*']
      }
    }),
    new webpack.optimize.CommonsChunkPlugin({
      name: 'commons',
      children: true,
      async: true,
      minChunks: 2,
    }),
    new HtmlWebpackPlugin({
      template: './src/public/index.html',
      inject: 'body',
    }),
    new CopyWebpackPlugin([{from:'./_headers'},{from:'./_redirects'}]),
    // new GoogleFontsPlugin({
    //   fonts: [
    //     { family: 'Roboto', variants: ['300', '400', '500', '700']}
    //   ],
    //   formats: ['woff', 'woff2']
    // }),
    new BundleAnalyzerPlugin({
      // Can be `server`, `static` or `disabled`.
      // In `server` mode analyzer will start HTTP server to show bundle report.
      // In `static` mode single HTML file with bundle report will be generated.
      // In `disabled` mode you can use this plugin to just generate Webpack Stats JSON file by setting `generateStatsFile` to `true`.
      analyzerMode: 'static',
      // Path to bundle report file that will be generated in `static` mode.
      // Relative to bundles output directory.
      reportFilename: 'report.html',
      // Module sizes to show in report by default.
      // Should be one of `stat`, `parsed` or `gzip`.
      // See "Definitions" section for more information.
      defaultSizes: 'parsed',
      // Automatically open report in default browser
      openAnalyzer: false,
      // If `true`, Webpack Stats JSON file will be generated in bundles output directory
      generateStatsFile: false,
      // Name of Webpack Stats JSON file that will be generated if `generateStatsFile` is `true`.
      // Relative to bundles output directory.
      statsFilename: 'stats.json',
      // Options for `stats.toJson()` method.
      // For example you can exclude sources of your modules from stats file with `source: false` option.
      // See more options here: https://github.com/webpack/webpack/blob/webpack-1/lib/Stats.js#L21
      statsOptions: null,
      // Log level. Can be 'info', 'warn', 'error' or 'silent'.
      logLevel: 'info'
    }),
    new ServiceWorkerWebpackPlugin({
      entry: path.join(__dirname, 'src/sw.js'),
    }),
    new Visualizer(),
    new DashboardPlugin()
  ]
}
