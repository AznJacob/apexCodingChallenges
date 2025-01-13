public with sharing class Car extends Vehicle {

    private Integer steeringRotation;
    private Integer tireRotation;
    private Integer gear;

    public Car() {
        super();
        this.steeringRotation = 0;
        this.tireRotation = 0;
    }

    public Car(Integer s, Integer o, String n) {
        super(s, o, n);
        this.steeringRotation = 0;
        this.tireRotation = 0;
    }

    public override void turn(Integer sr){
        this.steeringRotation += sr;
        this.tireRotation += (Integer) (sr/16);
    }
}