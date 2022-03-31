module.exports = {
  collectCoverage: true,
  coverageDirectory: '<rootDir>/../jest/coverage',
  coverageThreshold: {
    global: {
      branches: 20,
      functions: 20,
      lines: 20,
      statements: 20,
    },
  },
  moduleFileExtensions: ['ts', 'js', 'json', 'node'],
  preset: 'ts-jest',
  testEnvironment: 'node',
  verbose: true,
  rootDir: '../src/'
};
