public abstract with sharing class Vehicle {

    public enum Medium {LAND, AIR, WATER}

    private static final Integer CAPACITY; //not sure what the question is asking regarding how to set capacity.

    private Integer speed;
    private String name;
    private Integer occupants;
    protected List<Medium> Media = new List<Medium>();

    public Vehicle(){
        this(0, 0, ''); //constructor chaining
    }

    public Vehicle(Integer s, Integer o, String n) {
        setSpeed(s);
        setOccupants(o);
        this.name = n;
    }

    public Integer getSpeed(){
        return this.speed;
    }

    public String getName(){
        return this.name;
    }

    public Integer getOccupants(){
        return this.occupants;
    }

    public void setSpeed(Integer s){
        if (s < 0){
            throw new IllegalArgumentException('Speed cannot be negative');
        }
        this.speed = s;
    }

    public void setOccupants(Integer o){
        if (o < 0){
            throw new IllegalArgumentException('Occupants cannot be negative');
        }
        this.occupants = o;
    }

    public void accelerate(Integer a){
        this.speed += a;
    }   

    public abstract void turn(Integer sr);

    public void printVehicle(){
        String mediaJoin = String.join(media, ', ');
        System.debug('Name: ' + this.name + ', Speed: ' + this.speed + ', Media: ' + mediaJoin + ', Occupants: ' + this.occupants);
    }
}