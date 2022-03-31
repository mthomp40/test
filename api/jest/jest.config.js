module.exports = {
  collectCoverage: true,
  collectCoverageFrom: ['**/*.{ts,tsx,js,jsx}', '!**/node_modules/**'],
  coverageDirectory: '<rootDir>/../jest/coverage',
  coverageThreshold: {
    /** @todo These values are should be updated once we start getting more tests in */
    global: {
      branches: 0,
      functions: 0,
      lines: 0,
      statements: 0,
    },
  },
  preset: 'ts-jest',
  testEnvironment: 'node',
  testRegex: '(/__tests__/.*|(\\.|/)(test|spec))\\.ts?$',
  testSequencer: '<rootDir>/../jest/sequencer.js',
  verbose: true,
  setupFilesAfterEnv: [
    '<rootDir>/../jest/defaultTimeout.js',
    '<rootDir>/../jest/afterEnv.ts',
  ],
  rootDir: '../src/',
};
