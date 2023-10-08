const std = @import("std");
const math = std.math;

pub const TupleType = enum(u8) {
    vector,
    point,
};

pub fn Point(comptime T: type) type {
    return struct {
        x: T,
        y: T,
        z: T,
        _type: TupleType,

        pub fn init(x: T, y: T, z: T) Point(T) {
            return .{
                .x = x,
                .y = y,
                .z = z,
                ._type = TupleType.point,
            };
        }
    };
}

pub fn Vector(comptime T: type) type {
    return struct {
        x: T,
        y: T,
        z: T,
        _type: TupleType,

        pub fn init(x: T, y: T, z: T) Vector(T) {
            return .{
                .x = x,
                .y = y,
                .z = z,
                ._type = TupleType.vector,
            };
        }

        pub fn add(self: Vector(T), other: Vector(T)) Vector(T) {
            return .{
                .x = self.x + other.x,
                .y = self.y + other.y,
                .z = self.z + other.z,
                ._type = TupleType.vector,
            };
        }

        pub fn diff(self: Vector(T), other: Vector(T)) Vector(T) {
            return .{
                .x = self.x - other.x,
                .y = self.y - other.y,
                .z = self.z - other.z,
                ._type = TupleType.vector,
            };
        }

        pub fn negate(self: Vector(T)) Vector(T) {
            return .{
                .x = -self.x,
                .y = -self.y,
                .z = -self.z,
                ._type = TupleType.vector,
            };
        }

        pub fn scale(self: Vector(T), scalar: T) Vector(T) {
            return .{
                .x = self.x * scalar,
                .y = self.y * scalar,
                .z = self.z * scalar,
                ._type = TupleType.vector,
            };
        }

        pub fn magnitude(self: Vector(T)) T {
            return @sqrt(math.pow(T, self.x, 2) + math.pow(T, self.y, 2) + math.pow(T, self.z, 2));
        }

        pub fn normalize(self: Vector(T)) Vector(T) {
            const m = self.magnitude();
            return .{
                .x = self.x / m,
                .y = self.y / m,
                .z = self.z / m,
                ._type = TupleType.vector,
            };
        }

        pub fn dot(self: Vector(T), other: Vector(T)) T {
            return self.x * other.x + self.y * other.y + self.z * other.z;
        }

        pub fn cross(self: Vector(T), other: Vector(T)) Vector(T) {
            // input order dependent
            return .{
                .x = (self.y * other.z - self.z * other.y),
                .y = (self.z * other.x - self.x * other.z),
                .z = (self.x * other.y - self.y * other.x),
                ._type = TupleType.vector,
            };
        }
    };
}

test "Point.init" {
    const p = Point(f64).init(4.3, -4.2, 3.1);

    try std.testing.expectEqual(p, Point(f64).init(4.3, -4.2, 3.1));
}

test "Vector.init" {
    const v = Vector(f64).init(4.3, -4.2, 3.1);

    try std.testing.expectEqual(v, Vector(f64).init(4.3, -4.2, 3.1));
}

test "Vector.add" {
    const v1 = Vector(f64).init(3.0, -2.0, 5.0);
    const v2 = Vector(f64).init(-2.0, 3.0, 1.0);

    const expected = Vector(f64).init(1.0, 1.0, 6.0);
    const result = v1.add(v2);

    try std.testing.expectEqual(result, expected);
}

test "Vector.diff" {
    const v1 = Vector(f64).init(3.0, 2.0, 1.0);
    const v2 = Vector(f64).init(5.0, 6.0, 7.0);

    const expected = Vector(f64).init(-2.0, -4.0, -6.0);
    const result = v1.diff(v2);

    try std.testing.expectEqual(result, expected);
}

test "Vector.negate" {
    const v = Vector(f64).init(1.0, -2.0, 3.0);

    const expected = Vector(f64).init(-1.0, 2.0, -3.0);
    const result = v.negate();

    try std.testing.expectEqual(result, expected);
}

test "Vector.scale" {
    const v = Vector(f64).init(1.0, -2.0, 3.0);

    const expected = Vector(f64).init(3.5, -7.0, 10.5);
    const result = v.scale(3.5);

    try std.testing.expectEqual(result, expected);
}

test "Vector.magnitude" {
    var v = Vector(f64).init(1.0, 0.0, 0.0);
    try std.testing.expect(v.magnitude() == 1.0);

    v = Vector(f64).init(0.0, 1.0, 0.0);
    try std.testing.expect(v.magnitude() == 1.0);

    v = Vector(f64).init(0.0, 0.0, 1.0);
    try std.testing.expect(v.magnitude() == 1.0);

    v = Vector(f64).init(1.0, 2.0, 3.0);
    try std.testing.expect(v.magnitude() == @sqrt(14.0));

    v = Vector(f64).init(-1.0, -2.0, -3.0);
    try std.testing.expect(v.magnitude() == @sqrt(14.0));
}

// could break up into multiple tests
test "Vector.normalize" {
    var v = Vector(f64).init(4.0, 0.0, 0.0);
    var expected = Vector(f64).init(1.0, 0.0, 0.0);
    var result = v.normalize();

    try std.testing.expectEqual(result, expected);

    try std.testing.expect(result.magnitude() == 1.0);

    v = Vector(f64).init(1.0, 2.0, 3.0);
    const m = @sqrt(14.0);
    expected = Vector(f64).init(1.0 / m, 2.0 / m, 3.0 / m);
    result = v.normalize();

    try std.testing.expectEqual(result, expected);

    try std.testing.expect(result.magnitude() == 1.0);
}

test "Vector.dot" {
    const v1 = Vector(f64).init(1.0, 2.0, 3.0);
    const v2 = Vector(f64).init(2.0, 3.0, 4.0);

    try std.testing.expect(v1.dot(v2) == 20.0);
}

test "Vector.cross" {
    const v1 = Vector(f64).init(1.0, 2.0, 3.0);
    const v2 = Vector(f64).init(2.0, 3.0, 4.0);

    const expected = Vector(f64).init(-1.0, 2.0, -1.0);
    const result = v1.cross(v2);

    try std.testing.expectEqual(result, expected);
}
