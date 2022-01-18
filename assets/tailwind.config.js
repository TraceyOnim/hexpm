module.exports = {
  mode: "jit",
  purge: [
    "../lib/hexpm_web/**/*.html.eex",
    "../lib/hexpm_web/**/*.html.leex",
    "../lib/hexpm_web/**/views/**/*.ex",
    "../lib/hexpm_web/**/live/**/*.ex",
    "./js/**/*.js"
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    fontFamily: {
      "mono": ["JetBrains Mono"],
      "sans": ["Inter var"]
    },
    boxShadow: {
      DEFAULT: "0 4px 15px rgba(3, 9, 19, 0.15)",
      inner: "inset 0 4px 4px rgba(105, 67, 141, 0.2)",
      "2xl": "0 25px 50px -12px rgb(0 0 0 / 0.25)"
    },
    colors: {
      primary: {
        900: "#85d7ff",
        800: "#3D2165",
        700: "#523079",
        600: "#69438D",
        500: "#8769A4",
        400: "#A58EBB",
        300: "#C3B4D1",
        200: "#E1D9E8",
        100: "#F0EDF4",
        50: "#F7F5F9"
      },
      green: {
        900: "#054333",
        800: "#085438",
        700: "#0C643C",
        600: "#11753D",
        500: "#419164",
        400: "#70AC8B",
        300: "#A0C8B1",
        200: "#CFE3D8",
        100: "#E8F2EC",
        50: "#F3F8F5"
      },
      blue: {
        900: "#04237D",
        800: "#07329B",
        700: "#0A44B9",
        600: "#0F59D8",
        500: "#3F7AE0",
        400: "#6F9BE8",
        300: "#9FBDEF",
        200: "#CFDEF7",
        100: "#E7EFFC",
        50: "#F3F6FD"
      },
      yellow: {
        900: "#8A5912",
        800: "#AC751D",
        700: "#CD942A",
        600: "#EFB63A",
        500: "#F2C561",
        400: "#F5D389",
        300: "#F9E2B0",
        200: "#FCF0D8",
        100: "#FEF8EC",
        50: "#FEFBF5"
      },
      red: {
        900: "#620E32",
        800: "#7A1638",
        700: "#92203C",
        600: "#AA2C3F",
        500: "#BB5665",
        400: "#CC808C",
        300: "#DDABB2",
        200: "#EED5D9",
        100: "#F7EAEC",
        50: "#FAF4F5"
      },
      gray: {
        900: "#030913",
        800: "#0D1829",
        700: "#1C2A3A",
        600: "#304254",
        500: "#445668",
        400: "#61758A",
        300: "#91A4B7",
        200: "#CAD5E0",
        100: "#E1E8F0",
        50: "#F0F5F9"
      },
      white: {
        DEFAULT: "#FFFFFF"
      }

    },
    extend: {}
  },
  variants: {
    extend: {}
  },
  plugins: [
    require("@tailwindcss/forms")
  ]
}



