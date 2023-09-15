const std = @import("std");

const EPSILON: f64 = 0.00001;

pub fn floatCmp(comptime T: type, a: f64, b: f64) bool {
    if (@typeInfo(T) != .Float) {
        @compileError("floatCmp not implemented for " ++ @typeName(T) ++ " (only works with floating point numbers)");
    }
    return @fabs(a - b) < EPSILON;
}

test "floatCmp" {
    try std.testing.expect(floatCmp(f16, 1.0, 1.0) == true);
    try std.testing.expect(floatCmp(f64, 1.0, 1.000001) == true);
    try std.testing.expect(floatCmp(f128, 1.0, 1.000001) == true);

    try std.testing.expect(floatCmp(f64, 1.0, 1.0 + EPSILON) == false);
    try std.testing.expect(floatCmp(f64, 1.0, 1.0 - EPSILON * 2.0) == false);
}
