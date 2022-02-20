package utilities;

import game.Conductor;
import states.PlayState;
import flixel.FlxG;

class Ratings
{
    private static var scores:Array<Dynamic> = [
        ['marvelous', 400],
        ['sick', 350],
        ['good', 200],
        ['bad', 50],
        ['shit', -150]
    ];

    public static function getRating(time:Float)
    {
        var judges = utilities.Options.getData("judgementTimings");

        var timings:Array<Array<Dynamic>> = [
            [judges[0], "marvelous"],
            [judges[1], "sick"],
            [judges[2], "good"],
            [judges[3], "bad"]
        ];

        var rating:String = 'bruh';

        for(x in timings)
        {
            if(x[1] == "marvelous" && utilities.Options.getData("marvelousRatings") || x[1] != "marvelous")
            {
                if(time <= x[0] * PlayState.songMultiplier && rating == 'bruh')
                {
                    rating = x[1];
                }
            }
        }

        if(rating == 'bruh')
            rating = "shit";

        return rating;
    }

    public static function returnPreset(name:String = "leather engine"):Array<Int>
    {
        switch(name.toLowerCase())
        {
            case "leather engine":
                return [25, 50, 70, 100];
            case "kade engine" | "psych engine":
                /* 22.5 but rounded */
                return [23, 45, 90, 135];
            case "friday night funkin'":
                return [Std.int(Conductor.safeZoneOffset * 0.1), Std.int(Conductor.safeZoneOffset * 0.2), Std.int(Conductor.safeZoneOffset * 0.75), Std.int(Conductor.safeZoneOffset * 0.9)];
        }

        return [25, 50, 70, 100];
    }

    public static function getRank(accuracy:Float, ?misses:Int)
    {
        // yeah this is kinda taken from kade engine but i didnt use the etterna 'wife3' ranking system (instead just my own custom values)
        var conditions:Array<Bool>;

        if(utilities.Options.getData("ratingType") == "complex")
        {
            conditions = [
                accuracy == 100, // Like, WOW
                accuracy >= 98, // Like, Thats Great!
                accuracy >= 95, // Like, Thats Good
                accuracy >= 92, // Hey Scoob, This Kid Is Good!
                accuracy >= 89, // This is a challenge!
                accuracy >= 85, // Like Thats Sick!
                accuracy >= 80, // Starting to improve!
                accuracy >= 70, // Thats, like, really cool!
                accuracy >= 69, // haha, nice.
                accuracy >= 65, // Like, Thats Great!
                accuracy >= 50, // ZOINKS!
                accuracy >= 10, // Like, How are you still alive?
                accuracy >= 5, // Like, You're Bad
                accuracy < 4, // Ruh Rouh
            ];
        }
        else // simple
        {
            conditions = [
                accuracy == 100, // Like, WOW
                accuracy >= 85, // Hey Scoob, This Kid Is Good!
                accuracy >= 60, // Like Thats Sick!
                accuracy >= 50, // ZOINKS!
                accuracy >= 35, // Like, How are you still alive?
                accuracy >= 10, // REALLY BAD
                accuracy >= 2, // OOF
                accuracy >= 0 // Ruh Rouh
            ];
        }

        var missesRating:String = "";

        if(utilities.Options.getData("ratingType") == "complex")
        {
            if(misses != null)
            {
                var ratingsArray:Array<Int> = [
                    PlayState.instance.ratings.get("marvelous"),
                    PlayState.instance.ratings.get("sick"),
                    PlayState.instance.ratings.get("good"),
                    PlayState.instance.ratings.get("bad"),
                    PlayState.instance.ratings.get("shit")
                ];
    
                if(misses == 0)
                {
                    missesRating = "FC - ";
    
                    if(ratingsArray[3] < 10 && ratingsArray[4] == 0)
                        missesRating = "SDB - ";
    
                    if(ratingsArray[3] == 0 && ratingsArray[4] == 0)
                        missesRating = "GFC - ";
    
                    if(ratingsArray[2] < 10 && ratingsArray[3] == 0 && ratingsArray[4] == 0)
                        missesRating = "SDG - ";
    
                    if(ratingsArray[2] == 0 && ratingsArray[3] == 0 && ratingsArray[4] == 0)
                        missesRating = "PFC - ";
    
                    if(ratingsArray[1] < 10 && ratingsArray[2] == 0 && ratingsArray[3] == 0 && ratingsArray[4] == 0)
                        missesRating = "SDP - ";
    
                    if(ratingsArray[1] == 0 && ratingsArray[2] == 0 && ratingsArray[3] == 0 && ratingsArray[4] == 0)
                        missesRating = "MFC - ";
                }
    
                if(misses > 0 && misses < 10)
                    missesRating = "SDCB - ";
    
                if(misses >= 10)
                    missesRating = "CLEAR - ";
            }
        }
        else
        {
            if(misses != null)
            {
                if(misses == 0)
                    missesRating = "FC - ";
            }
        }

        for(condition in 0...conditions.length)
        {
            var rating_success = conditions[condition];

            if(rating_success)
            {
                switch(utilities.Options.getData("ratingType"))
                {
                    case "complex":
                        switch(condition)
                        {
                            case 0:
                                return missesRating + "SSSS - Like, WOW";
                            case 1:
                                return missesRating + "SSS - Like, Thats Sick!";
                            case 2:
                                return missesRating + "SS - Like, Thats Great";
                            case 3:
                                return missesRating + "S - Like Thats Good";
                            case 4:
                                return missesRating + "AA - Hey Scoob, This Kid Is Good!";
                            case 5:
                                return missesRating + "A - This Is a challenge!";
                            case 6:
                                return missesRating + "B+ - Hey, Man, You're Starting to improve!";
                            case 7:
                                return missesRating + "B - Thats, like, really cool...";
                            case 8:
                                return missesRating + "C - ZOINKS!";
                            case 9:
                                return missesRating + "D - Like, How are you still alive?";
                            case 10:
                                return missesRating + "E - Like, You're Bad";
                            case 11:
                                return missesRating + "F - OOF";
                            case 12:
                                return missesRating + "G - Ruh Rouh!";
                        }
                    default:
                        switch(condition)
                        {
                            case 0:
                                return missesRating + "Perfect";
                            case 1:
                                return missesRating + "Sick";
                            case 2:
                                return missesRating + "Good";
                            case 3:
                                return missesRating + "Ok";
                            case 4:
                                return missesRating + "Bad";
                            case 5:
                                return missesRating + "Really Bad";
                            case 6:
                                return missesRating + "OOF";
                            case 7:
                                return missesRating + "how tf u this bad";
                        }
                }
            }
        }

        return "N/A";
    }

    public static function getScore(rating:String)
    {
        var score:Int = 0;

        for(x in scores)
        {
            if(rating == x[0])
            {
                score = x[1];
            }
        }

        return score;
    }
}