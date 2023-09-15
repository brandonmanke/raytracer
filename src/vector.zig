const std = @import("std");
const math = std.math;

const TupleType = enum(u8) {
    vector,
    point,
};

const Point = struct {
    x: f64,
    y: f64,
    z: f64,
    _type: TupleType,

    pub fn init(x: f64, y: f64, z: f64) Point {
        return Point{
            .x = x,
            .y = y,
            .z = z,
            ._type = TupleType.point,
        };
    }
};

const Vector = struct {
    x: f64,
    y: f64,
    z: f64,
    _type: TupleType,

    pub fn init(x: f64, y: f64, z: f64) Vector {
        return Vector{
            .x = x,
            .y = y,
            .z = z,
            ._type = TupleType.vector,
        };
    }

    pub fn add(self: Vector, other: Vector) Vector {
        return Vector{
            .x = self.x + other.x,
            .y = self.y + other.y,
            .z = self.z + other.z,
            ._type = TupleType.vector,
        };
    }

    pub fn diff(self: Vector, other: Vector) Vector {
        return Vector{
            .x = self.x - other.x,
            .y = self.y - other.y,
            .z = self.z - other.z,
            ._type = TupleType.vector,
        };
    }

    pub fn negate(self: Vector) Vector {
        return Vector{
            .x = -self.x,
            .y = -self.y,
            .z = -self.z,
            ._type = TupleType.vector,
        };
    }

    pub fn scale(self: Vector, scalar: f64) Vector {
        return Vector{
            .x = self.x * scalar,
            .y = self.y * scalar,
            .z = self.z * scalar,
            ._type = TupleType.vector,
        };
    }

    pub fn magnitude(self: Vector) f64 {
        return @sqrt(math.pow(f64, self.x, 2) + math.pow(f64, self.y, 2) + math.pow(f64, self.z, 2));
    }

    pub fn normalize(self: Vector) Vector {
        const m = self.magnitude();
        return Vector{
            .x = self.x / m,
            .y = self.y / m,
            .z = self.z / m,
            ._type = TupleType.vector,
        };
    }

    pub fn dot(self: Vector, other: Vector) f64 {
        return self.x * other.x + self.y * other.y + self.z * other.z;
    }

    pub fn cross(self: Vector, other: Vector) Vector {
        // input order dependent
        return Vector{
            .x = (self.y * other.z - self.z * other.y),
            .y = (self.z * other.x - self.x * other.z),
            .z = (self.x * other.y - self.y * other.x),
            ._type = TupleType.vector,
        };
    }
};

test "point.init" {
    const p = Point.init(4.3, -4.2, 3.1);

    try std.testing.expectEqual(p, Point.init(4.3, -4.2, 3.1));
}

test "vector.init" {
    const v = Vector.init(4.3, -4.2, 3.1);

    try std.testing.expectEqual(v, Vector.init(4.3, -4.2, 3.1));
}

test "vector.add" {
    const v1 = Vector.init(3.0, -2.0, 5.0);
    const v2 = Vector.init(-2.0, 3.0, 1.0);

    const expected = Vector.init(1.0, 1.0, 6.0);
    const result = v1.add(v2);

    try std.testing.expectEqual(result, expected);
}

test "vector.diff" {
    const v1 = Vector.init(3.0, 2.0, 1.0);
    const v2 = Vector.init(5.0, 6.0, 7.0);

    const expected = Vector.init(-2.0, -4.0, -6.0);
    const result = v1.diff(v2);

    try std.testing.expectEqual(result, expected);
}

test "vector.negate" {
    const v = Vector.init(1.0, -2.0, 3.0);

    const expected = Vector.init(-1.0, 2.0, -3.0);
    const result = v.negate();

    try std.testing.expectEqual(result, expected);
}

test "vector.scale" {
    const v = Vector.init(1.0, -2.0, 3.0);

    const expected = Vector.init(3.5, -7.0, 10.5);
    const result = v.scale(3.5);

    try std.testing.expectEqual(result, expected);
}

test "vector.magnitude" {
    var v = Vector.init(1.0, 0.0, 0.0);
    try std.testing.expect(v.magnitude() == 1.0);

    v = Vector.init(0.0, 1.0, 0.0);
    try std.testing.expect(v.magnitude() == 1.0);

    v = Vector.init(0.0, 0.0, 1.0);
    try std.testing.expect(v.magnitude() == 1.0);

    v = Vector.init(1.0, 2.0, 3.0);
    try std.testing.expect(v.magnitude() == @sqrt(14.0));

    v = Vector.init(-1.0, -2.0, -3.0);
    try std.testing.expect(v.magnitude() == @sqrt(14.0));
}

// could break up into multiple tests
test "vector.normalize" {
    var v = Vector.init(4.0, 0.0, 0.0);
    var expected = Vector.init(1.0, 0.0, 0.0);
    var result = v.normalize();

    try std.testing.expectEqual(result, expected);

    try std.testing.expect(result.magnitude() == 1.0);

    v = Vector.init(1.0, 2.0, 3.0);
    const m = @sqrt(14.0);
    expected = Vector.init(1.0 / m, 2.0 / m, 3.0 / m);
    result = v.normalize();

    try std.testing.expectEqual(result, expected);

    try std.testing.expect(result.magnitude() == 1.0);
}

test "vector.dot" {
    const v1 = Vector.init(1.0, 2.0, 3.0);
    const v2 = Vector.init(2.0, 3.0, 4.0);

    try std.testing.expect(v1.dot(v2) == 20.0);
}

test "vector.cross" {
    const v1 = Vector.init(1.0, 2.0, 3.0);
    const v2 = Vector.init(2.0, 3.0, 4.0);

    const expected = Vector.init(-1.0, 2.0, -1.0);
    const result = v1.cross(v2);

    try std.testing.expectEqual(result, expected);
}
