// Class này dùng để cấu hình responsive (thay đổi layout theo kích thước màn hình)
class ResponsiveConfig {
  // 👉 Số cột trong GridView (2 cột cho màn hình nhỏ, 3 cột cho màn hình to)
  final int crossAxisCount;

  // 👉 Tỉ lệ chiều rộng / chiều cao của item trong GridView
  // Ví dụ 0.65 nghĩa là item cao hơn, 0.6 thì item cân đối hơn
  final double aspectRatio;

  // 👉 Kích thước bán kính (radius) của avatar (ảnh đại diện tròn)
  final double avatarRadius;

  // 👉 Font chữ nhỏ (dùng cho subtitle, text phụ)
  final double fontSmall;

  // 👉 Font chữ body (text nội dung chính)
  final double fontBody;

  // 👉 Font chữ tiêu đề (title, heading, tên sản phẩm)
  final double fontTitle;

  // 👉 Font chữ hiển thị giá (price, thường to hơn body)
  final double fontPrice;

  // 👉 Kích thước icon (ví dụ icon giỏ hàng, icon search)
  final double iconSize;

  // 👉 Bán kính bo tròn cho icon button (ví dụ nút tròn nhỏ chứa icon)
  final double iconRadius;

  // 👉 Padding chung (khoảng cách viền ngoài, margin trong container)
  final double padding;

  // 👉 Khoảng cách giữa các phần tử (spacing giữa items, grid spacing)
  final double spacing;

  // Constructor private (chỉ dùng trong factory)
  ResponsiveConfig._({
    required this.crossAxisCount,
    required this.aspectRatio,
    required this.avatarRadius,
    required this.fontSmall,
    required this.fontBody,
    required this.fontTitle,
    required this.fontPrice,
    required this.iconSize,
    required this.iconRadius,
    required this.padding,
    required this.spacing,
  });

  // 👉 Factory constructor: chọn config theo độ rộng màn hình
  factory ResponsiveConfig.of(double screenWidth) {
    if (screenWidth < 400) {
      // Rule cho màn hình nhỏ (smartphone nhỏ)
      return ResponsiveConfig._(
        crossAxisCount: 2,
        aspectRatio: 0.65,
        avatarRadius: 40,
        fontSmall: 10,
        fontBody: 12,
        fontTitle: 14,
        fontPrice: 16,
        iconSize: 16,
        iconRadius: 14,
        padding: 8,
        spacing: 6,
      );
    } else {
      // Rule cho màn hình to (smartphone lớn / tablet nhỏ)
      return ResponsiveConfig._(
        crossAxisCount: 3,
        aspectRatio: 0.6,
        avatarRadius: 50,
        fontSmall: 12,
        fontBody: 14,
        fontTitle: 16,
        fontPrice: 18,
        iconSize: 18,
        iconRadius: 16,
        padding: 12,
        spacing: 8,
      );
    }
  }
}
