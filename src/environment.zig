const std = @import("std");
const vector = @import("vector.zig");
const Vector = vector.Vector;
const Point = vector.Point;

const EPSILON = 0.00001;

pub const Environment = struct {
    gravity: Vector(f64),
    wind: Vector(f64),
};

pub const Projectile = struct {
    position: Point(f64),
    velocity: Vector(f64),
};

pub fn tick(env: Environment, proj: Projectile) Projectile {
    const position = proj.position.addVector(proj.velocity);
    const velocity = proj.velocity.add(env.gravity).add(env.wind);
    return .{
        .position = position,
        .velocity = velocity,
    };
}

test "tick" {
    const env = Environment{
        .gravity = Vector(f64).init(0.0, -0.1, 0.0),
        .wind = Vector(f64).init(-0.01, 0.0, 0.0),
    };
    const proj = Projectile{
        .position = Point(f64).init(0.0, 1.0, 0.0),
        .velocity = Vector(f64).init(1.0, 1.0, 0.0),
    };
    const new_proj = tick(env, proj);
    try std.testing.expectApproxEqAbs(new_proj.position.x, 1.0, EPSILON);
    try std.testing.expectApproxEqAbs(new_proj.position.y, 2.0, EPSILON);
    try std.testing.expectApproxEqAbs(new_proj.velocity.x, 0.99, EPSILON);
    try std.testing.expectApproxEqAbs(new_proj.velocity.y, 0.9, EPSILON);
}
