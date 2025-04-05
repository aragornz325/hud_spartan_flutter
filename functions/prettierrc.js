/**
 * Configuración optimizada para Cloud Functions
 * @type {import("prettier").Config}
 */
module.exports = {
  printWidth: 100,
  tabWidth: 2,
  useTabs: false,
  semi: true, // Cambiado a true para Firebase/Node.js
  singleQuote: true, // Cambiado a false para Firebase/Node.js
  trailingComma: 'all',
  arrowParens: 'always',
  bracketSpacing: true,
  bracketSameLine: false,
  endOfLine: 'auto', // Para compatibilidad multiplataforma
  plugins: [], // Eliminados plugins de UI
  overrides: [
    {
      files: '*.ts',
      options: {
        parser: 'typescript'
      }
    }
  ]
}