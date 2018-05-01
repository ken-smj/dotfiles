import java.text.*;
import java.time.*;
import java.time.temporal.*;
import java.time.zone.*;
import java.util.*;
import java.util.function.*;
import java.util.stream.*;


public class HarvestData
{
    private static long  DAYS_IN_400_YEARS       = IntStream.range (0, 400).map ((year) -> isLeapYear (year) ? 366 : 365).sum ();
    private static long  SECONDS_IN_400_YEARS    = (DAYS_IN_400_YEARS * 24 * 60 * 60);
    private static long  AVERAGE_SECONDS_IN_YEAR = (SECONDS_IN_400_YEARS / 400);


    public static void main (String[] args) throws Exception
    {
        if (Arrays.asList (args).contains ("--locales"))
            printLocaleData ();

        if (Arrays.asList (args).contains ("--timezones"))
            printTimezoneData ();
    }

    protected static void printLocaleData () throws Exception
    {
        List <Locale>  locales = new ArrayList <> (Arrays.asList (Locale.getAvailableLocales ()));
        locales.sort ((a, b) -> a.toLanguageTag ().compareToIgnoreCase (b.toLanguageTag ()));

        Map <Locale, Map <String, String>>  data = new LinkedHashMap <> ();

        List <String>  english_eras  = Arrays.asList (DateFormatSymbols.getInstance (Locale.ENGLISH).getEras ());
        List <String>  english_am_pm = Arrays.asList (DateFormatSymbols.getInstance (Locale.ENGLISH).getAmPmStrings ());

        for (Locale locale : locales) {
            Map <String, String>  map = new LinkedHashMap <> ();
            data.put (locale, map);

            if (DecimalFormatSymbols.getInstance (locale).getDecimalSeparator () != '.')
                map.put (":decimal-separator", String.format ("?%c", DecimalFormatSymbols.getInstance (locale).getDecimalSeparator ()));

            if (!Objects.equals (Arrays.asList (DateFormatSymbols.getInstance (locale).getEras ()), english_eras))
                map.put (":eras", toLispVector (Arrays.asList (DateFormatSymbols.getInstance (locale).getEras ())));

            map.put (":month-context-abbr",       toLispVector (getNames (locale, Calendar.MONTH,       Calendar.SHORT_FORMAT,     Calendar.JANUARY, Calendar.DECEMBER, -1)));
            map.put (":month-context-names",      toLispVector (getNames (locale, Calendar.MONTH,       Calendar.LONG_FORMAT,      Calendar.JANUARY, Calendar.DECEMBER, -1)));
            map.put (":weekday-context-abbr",     toLispVector (getNames (locale, Calendar.DAY_OF_WEEK, Calendar.SHORT_FORMAT,     Calendar.MONDAY,  Calendar.SATURDAY, Calendar.SUNDAY)));
            map.put (":weekday-context-names",    toLispVector (getNames (locale, Calendar.DAY_OF_WEEK, Calendar.LONG_FORMAT,      Calendar.MONDAY,  Calendar.SATURDAY, Calendar.SUNDAY)));
            map.put (":month-standalone-abbr",    toLispVector (getNames (locale, Calendar.MONTH,       Calendar.SHORT_STANDALONE, Calendar.JANUARY, Calendar.DECEMBER, -1)));
            map.put (":month-standalone-names",   toLispVector (getNames (locale, Calendar.MONTH,       Calendar.LONG_STANDALONE,  Calendar.JANUARY, Calendar.DECEMBER, -1)));
            map.put (":weekday-standalone-abbr",  toLispVector (getNames (locale, Calendar.DAY_OF_WEEK, Calendar.SHORT_STANDALONE, Calendar.MONDAY,  Calendar.SATURDAY, Calendar.SUNDAY)));
            map.put (":weekday-standalone-names", toLispVector (getNames (locale, Calendar.DAY_OF_WEEK, Calendar.LONG_STANDALONE,  Calendar.MONDAY,  Calendar.SATURDAY, Calendar.SUNDAY)));

            if (!Objects.equals (Arrays.asList (DateFormatSymbols.getInstance (locale).getAmPmStrings ()), english_am_pm))
                map.put (":am-pm", toLispVector (Arrays.asList (DateFormatSymbols.getInstance (locale).getAmPmStrings ())));

            removeUnnecessaryStandaloneStrings (map, ":month-standalone-abbr",    ":month-context-abbr");
            removeUnnecessaryStandaloneStrings (map, ":month-standalone-names",   ":month-context-names");
            removeUnnecessaryStandaloneStrings (map, ":weekday-standalone-abbr",  ":weekday-context-abbr");
            removeUnnecessaryStandaloneStrings (map, ":weekday-standalone-names", ":weekday-context-names");

            Map <String, String>  date_patterns = toPatternPlist ((style) -> (SimpleDateFormat) DateFormat.getDateInstance (style, locale));
            Map <String, String>  time_patterns = toPatternPlist ((style) -> (SimpleDateFormat) DateFormat.getTimeInstance (style, locale));

            // Fallbacks: short <- medium; full <- long <- medium.
            for (Map <String, String> patterns : Arrays.asList (date_patterns, time_patterns)) {
                if (Objects.equals (patterns.get (":short"), patterns.get (":medium")))
                    patterns.remove (":short");
                if (Objects.equals (patterns.get (":full"), patterns.get (":long")))
                    patterns.remove (":full");
                if (Objects.equals (patterns.get (":long"), patterns.get (":medium")))
                    patterns.remove (":long");
            }

            map.put (":date-patterns", toLispPlist (date_patterns, true));
            map.put (":time-patterns", toLispPlist (time_patterns, true));

            boolean  date_part_first = true;
            String   separator       = null;

            for (int date_style : new int[] { DateFormat.SHORT, DateFormat.MEDIUM, DateFormat.LONG, DateFormat.FULL }) {
                for (int time_style : new int[] { DateFormat.SHORT, DateFormat.MEDIUM, DateFormat.LONG, DateFormat.FULL }) {
                    String  date_pattern      = ((SimpleDateFormat) DateFormat.getDateInstance (date_style, locale)).toPattern ();
                    String  time_pattern      = ((SimpleDateFormat) DateFormat.getTimeInstance (time_style, locale)).toPattern ();
                    String  date_time_pattern = ((SimpleDateFormat) DateFormat.getDateTimeInstance (date_style, time_style, locale)).toPattern ();

                    if (separator == null) {
                        boolean  found = false;

                        search_loop:
                        for (boolean date_part_first_ : new boolean[] { true, false }) {
                            for (String separator_ : new String[] { " ", ", " }) {
                                if (Objects.equals (date_time_pattern, String.format ("%s%s%s",
                                                                                      date_part_first_ ? date_pattern : time_pattern,
                                                                                      separator_,
                                                                                      date_part_first_ ? time_pattern : date_pattern))) {
                                    found           = true;
                                    date_part_first = date_part_first_;
                                    separator       = separator_;
                                    break search_loop;
                                }
                            }
                        }

                        if (!found) {
                            throw new IllegalStateException (String.format ("cannot determine separator:\n  locale: %s\n  date-time: %s\n  date: %s\n  time: %s",
                                                                            locale.toLanguageTag (), date_time_pattern, date_pattern, time_pattern));
                        }
                    }

                    if (!Objects.equals (date_time_pattern, String.format ("%s%s%s",
                                                                           date_part_first ? date_pattern : time_pattern,
                                                                           separator,
                                                                           date_part_first ? time_pattern : date_pattern))) {
                        throw new IllegalStateException (String.format ("unexpected date-time pattern:\n  locale: %s\n  date-time: %s\n  date: %s\n  time: %s",
                                                                        locale.toLanguageTag (), date_time_pattern, date_pattern, time_pattern));
                    }
                }
            }

            if (!date_part_first || !" ".equals (separator))
                map.put (":date-time-pattern-rule", String.format ("(%s . %s)", date_part_first ? "t" : "nil", quoteString (separator)));
        }

        // Remove duplicates.
        for (Locale locale : locales) {
            Locale  parent = new Locale (locale.getLanguage ());
            if (Objects.equals (locale, parent))
                continue;

            if (Objects.equals (data.get (parent), data.get (locale))) {
                // We used to delete such locales, but now keep them in the database.
                // Otherwise, at runtime you can't for example use `ru-RU' and must use
                // `ru' instead.
                data.put (locale, new HashMap <> ());
            }
            else {
                for (Iterator <Map.Entry <String, String>> it = data.get (locale).entrySet ().iterator (); it.hasNext ();) {
                    Map.Entry <String, String>  entry = it.next ();
                    if (Objects.equals (entry.getValue (), data.get (parent).get (entry.getKey ())))
                        it.remove ();
                }
            }

            data.get (locale).put (":parent", parent.toLanguageTag ());
        }

        System.out.println ("(");
        for (Map.Entry <Locale, Map <String, String>> entry : data.entrySet ())
            System.out.println (toLispPlist (entry.getKey ().toLanguageTag (), entry.getValue (), false));
        System.out.println (")");
    }

    protected static List <String> getNames (Locale locale, int field, int style, int from, int to, int extra)
    {
        Calendar       calendar = Calendar.getInstance (locale);
        List <String>  names    = new ArrayList <> ();

        for (int k = from; k <= to; k++) {
            calendar.set (field, k);
            names.add (calendar.getDisplayName (field, style, locale));

            // Java is not very consistent here, sometimes standalone strings are just null,
            // sometimes they duplicate context strings.
            if (names.get (names.size () - 1) == null)
                names.set (names.size () - 1, calendar.getDisplayName (field, style == Calendar.SHORT_STANDALONE ? Calendar.SHORT : Calendar.LONG, locale));
        }

        // Needed to put Sunday last.
        if (extra >= 0) {
            calendar.set (field, extra);
            names.add (calendar.getDisplayName (field, style, locale));

            if (names.get (names.size () - 1) == null)
                names.set (names.size () - 1, calendar.getDisplayName (field, style == Calendar.SHORT_STANDALONE ? Calendar.SHORT : Calendar.LONG, locale));
        }

        return names;
    }

    protected static void removeUnnecessaryStandaloneStrings (Map <String, String> properties, String standalone_key, String context_key)
    {
        if (Objects.equals (properties.get (standalone_key), properties.get (context_key)))
            properties.remove (standalone_key);
    }

    protected static void printTimezoneData () throws Exception
    {
        List <ZoneId>  timezones = ZoneId.getAvailableZoneIds ().stream ().map ((id) -> ZoneId.of (id)).collect (Collectors.toList ());
        timezones.sort ((a, b) -> a.getId ().compareToIgnoreCase (b.getId ()));

        Map <ZoneId, List <Object>>  data = new LinkedHashMap <> ();

        for (ZoneId timezone : timezones) {
            ZoneRules  rules = timezone.getRules ();

            if (rules.isFixedOffset ())
                data.put (timezone, Collections.singletonList (rules.getOffset (Instant.now ()).getTotalSeconds ()));
            else {
                // They are probably already ordered, but I cannot find a confirmation in
                // the documentation.
                List <ZoneOffsetTransition>  transitions = new ArrayList <> (rules.getTransitions ());
                transitions.sort ((a, b) -> a.getInstant ().compareTo (b.getInstant ()));

                LocalDateTime         first           = LocalDateTime.ofInstant (transitions.get (0).getInstant (), ZoneOffset.UTC);
                int                   base_year       = Year.of (first.get (ChronoField.YEAR)).getValue ();
                long                  base            = Year.of (first.get (ChronoField.YEAR)).atDay (1).atStartOfDay ().toInstant (ZoneOffset.UTC).getEpochSecond ();
                int                   last_offset     = transitions.get (0).getOffsetBefore ().getTotalSeconds ();
                List <Object>         zone_data       = new ArrayList <> ();
                List <List <Object>>  transition_data = new ArrayList <> ();

                for (ZoneOffsetTransition transition : transitions) {
                    int  year_offset = (int) ((transition.getInstant ().getEpochSecond () - base) / AVERAGE_SECONDS_IN_YEAR);
                    if ((transition.getInstant ().getEpochSecond () + 1 - base) % AVERAGE_SECONDS_IN_YEAR < 1)
                        System.err.println (String.format ("*Warning*: timezone '%s', offset transition at %s would be a potential rounding error", timezone.getId (), transition.getInstant ()));

                    while (year_offset >= transition_data.size ())
                        transition_data.add (new ArrayList <> (Arrays.asList (last_offset)));

                    transition_data.get (year_offset).add (transition.getInstant ().getEpochSecond () - (base + year_offset * AVERAGE_SECONDS_IN_YEAR));
                    transition_data.get (year_offset).add (last_offset = transition.getOffsetAfter ().getTotalSeconds ());
                }

                List <Object>  transition_rule_data = new ArrayList <> ();
                for (ZoneOffsetTransitionRule transition_rule : rules.getTransitionRules ()) {
                    Map <String, String>  rule = new LinkedHashMap <> ();

                    rule.put (":month",        String.valueOf (transition_rule.getMonth ().getValue ()));
                    rule.put (":day-of-month", String.valueOf (transition_rule.getDayOfMonthIndicator ()));

                    if (transition_rule.getDayOfWeek () != null)
                        rule.put (":day-of-week", String.valueOf (transition_rule.getDayOfWeek ().getValue () - 1));

                    if (transition_rule.isMidnightEndOfDay ())
                        rule.put (":end-of-day", "t");

                    rule.put (":time", String.valueOf (transition_rule.getLocalTime ().toSecondOfDay ()));

                    switch (transition_rule.getTimeDefinition ()) {
                    case UTC:
                        rule.put (":time-definition", "utc");
                        break;
                    case WALL:
                        rule.put (":time-definition", "wall");
                        break;
                    case STANDARD:
                        rule.put (":time-definition", "standard");
                        rule.put (":standard-offset", String.valueOf (transition_rule.getStandardOffset ().getTotalSeconds ()));
                        break;
                    default:
                        throw new IllegalStateException (transition_rule.getTimeDefinition ().name ());
                    }

                    rule.put (":before", String.valueOf (transition_rule.getOffsetBefore ().getTotalSeconds ()));
                    rule.put (":after",  String.valueOf (transition_rule.getOffsetAfter  ().getTotalSeconds ()));

                    transition_rule_data.add (toLispPlist (rule, false));
                }

                zone_data.add (String.valueOf (base));
                zone_data.add (toLispVector (transition_data.stream ().map (HarvestData::toLispList).collect (Collectors.toList ()), false));
                zone_data.add (String.valueOf (base_year));
                zone_data.add (toLispList (transition_rule_data));

                data.put (timezone, zone_data);
            }
        }

        System.out.println ("(");
        for (Map.Entry <ZoneId, List <Object>> entry : data.entrySet ())
            System.out.format ("(%s\n %s)\n", entry.getKey (), entry.getValue ().stream ().map (String::valueOf).collect (Collectors.joining ("\n ")));
        System.out.println (")");
    }

    protected static String toLispList (List <?> list)
    {
        if (list == null || list.isEmpty ())
            return "nil";
        else
            return String.format ("(%s)", list.stream ().map (String::valueOf).collect (Collectors.joining (" ")));
    }

    protected static String toLispPlist (Map <String, String> properties, boolean quote_value_strings)
    {
        return toLispPlist (null, properties, quote_value_strings);
    }

    protected static String toLispPlist (String associate_to, Map <String, String> properties, boolean quote_value_strings)
    {
        return String.format ("(%s%s%s)",
                              associate_to != null ? associate_to : "",
                              associate_to != null && !properties.isEmpty () ? " " : "",
                              (properties.entrySet ().stream ()
                               .map ((entry) -> String.format ("%s %s", entry.getKey (), quote_value_strings ? quoteString (entry.getValue ()) : entry.getValue ()))
                               .collect (Collectors.joining (" "))));
    }

    protected static String toLispVector (List <String> strings)
    {
        return toLispVector (strings, true);
    }

    protected static String toLispVector (List <String> strings, boolean quote_value_strings)
    {
        return String.format ("[%s]", strings.stream ().map ((string) -> quote_value_strings ? quoteString (string) : string).collect (Collectors.joining (" ")));
    }

    protected static Map <String, String> toPatternPlist (Function <Integer, SimpleDateFormat> format)
    {
        Map <String, String>  patterns = new LinkedHashMap <> ();

        patterns.put (":short",  format.apply (DateFormat.SHORT) .toPattern ());
        patterns.put (":medium", format.apply (DateFormat.MEDIUM).toPattern ());
        patterns.put (":long",   format.apply (DateFormat.LONG)  .toPattern ());
        patterns.put (":full",   format.apply (DateFormat.FULL)  .toPattern ());

        return patterns;
    }

    protected static String quoteString (String string)
    {
        return string != null ? String.format ("\"%s\"", string.replaceAll ("\\\\", "\\\\").replaceAll ("\"", "\\\"")) : "nil";
    }

    protected static boolean isLeapYear (int year)
    {
        return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
    }
}
