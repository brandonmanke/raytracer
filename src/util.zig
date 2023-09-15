const EPSILON: f64 = 0.00001;

pub fn float_cmp(a: f64, b: f64) bool {
    return @fabs(a - b) < EPSILON;
}

test "float_cmp" {
    try std.testing.expect(float_cmp(1.0, 1.0) == true);
    try std.testing.expect(float_cmp(1.0, 1.000001) == true);

    try std.testing.expect(float_cmp(1.0, 1.0 + EPSILON) == false);
    try std.testing.expect(float_cmp(1.0, 1.0 - EPSILON * 2.0) == false);
    try std.testing.expect(float_cmp(1.0, 1.000001) == true);
}
