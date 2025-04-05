module.exports = {
  root: true,
  env: {
    es6: true,
    node: true,
  },
  extends: [
    'eslint:recommended',
    'google',
    'plugin:@typescript-eslint/recommended',
    'prettier' // Añadido para evitar conflictos
  ],
  parser: '@typescript-eslint/parser',
  parserOptions: {
    project: ['tsconfig.json', 'tsconfig.dev.json'],
    tsconfigRootDir: __dirname,
    sourceType: 'module',
  },
  ignorePatterns: [
    '/lib/**/*',
    '/node_modules/**/*',
    '*.config.js',
    'prettierrc.js',
  ],
  plugins: [
    '@typescript-eslint'
  ],
  rules: {
    'quotes': ['error', 'single'], // Coherente con Prettier
    'indent': 'off', // Delegado a Prettier
    'max-len': ['error', { 'code': 100, 'ignoreUrls': true }],
    'require-jsdoc': 'off',
    'valid-jsdoc': 'off',
    '@typescript-eslint/explicit-function-return-type': 'off',
    '@typescript-eslint/no-unused-vars': 'warn'
  }
};