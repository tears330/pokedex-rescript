module.exports = {
  content: ['./index.html', './src/**/*.{res,js}'],
  theme: {
    colors: {
      dark: {
        900: 'rgba(31, 31, 31, 1)',
        500: 'rgba(45, 47, 54, 1)',
        300: 'rgba(63, 65, 75, 1)',
        200: 'rgba(72, 77, 87, 1)',
        100: 'rgba(139, 139, 139, 1)',
      },
      white: {
        900: 'rgba(255, 255, 255, 1)',
        800: 'rgba(237, 237, 237, 1)',
      },
      primary: 'rgba(242, 201, 76, 1)',
      'primary-dark': 'rgba(242, 201, 76, 0.8)',
    },
  },
  plugins: [],
};
