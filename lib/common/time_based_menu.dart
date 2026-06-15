class TimeBasedMenu {

  static List<String> getTodaysSpecial(int hour) {

    if (hour >= 6 && hour < 11) {
      return ["Masala Dosa"];
    }

    if (hour >= 11 && hour < 16) {
      return ["Veg Thali"];
    }

    if (hour >= 16 && hour < 19) {
      return ["Paneer Pakoda"];
    }

    return ["Veg Biryani"];
  }

  static List<String> getRecommended(int hour) {

    if (hour >= 6 && hour < 11) {
      return [
        "Tea",
        "Nescafe",
        "Toast Butter",
        "Poha",
        "Upma"
      ];
    }

    if (hour >= 11 && hour < 16) {
      return [
        "Paneer Butter Masala",
        "Dal Fry",
        "Jeera Rice",
        "Butter Naan"
      ];
    }

    if (hour >= 16 && hour < 19) {
      return [
        "Paneer Pakoda",
        "Kurkuri Tikki",
        "Tea",
        "Coffee"
      ];
    }

    return [
      "Paneer Handi",
      "Veg Kolhapuri",
      "Butter Naan",
      "Veg Biryani"
    ];
  }

  static List<String> getMostOrdered(int hour) {

    if (hour >= 6 && hour < 11) {
      return [
        "Tea",
        "Masala Dosa",
        "Bread Butter"
      ];
    }

    if (hour >= 11 && hour < 16) {
      return [
        "Veg Biryani",
        "Paneer Butter Masala",
        "Butter Naan"
      ];
    }

    if (hour >= 16 && hour < 19) {
      return [
        "Paneer Pakoda",
        "Tea",
        "French Fries"
      ];
    }

    return [
      "Veg Biryani",
      "Paneer Handi",
      "Butter Naan"
    ];
  }
}