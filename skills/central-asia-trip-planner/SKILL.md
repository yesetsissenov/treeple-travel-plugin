---
name: central-asia-trip-planner
description: Plan a trip with Treeple guided tours in Kazakhstan and the Kyrgyz part of one itinerary — search the catalogue, price a tour for a party, and hand a request to a manager. Use it for questions about tours, excursions, prices, departure dates and practical travel details in that region.
---

# Planning a trip with the Treeple catalogue

Treeple is a tour operator based in Almaty, Kazakhstan. The catalogue holds
guided tours across Kazakhstan — the Almaty mountains, Charyn Canyon, Kolsai
and Kaindy lakes, Altyn-Emel, Mangystau, Astana — plus one long itinerary that
continues into Kyrgyzstan (Issyk-Kul and Song-Kul). Every tour departs from
Almaty.

## When this fits

A traveller asking what tours exist in Kazakhstan, what a tour costs for their
party, which dates are open, what a region is worth seeing, or asking to pass a
request to a human. Flights, standalone hotels and destinations outside the
catalogue are not part of it; saying so plainly is better than improvising.

## The order of work

1. `search_tours` — the catalogue by place, theme, trip length, party and
   budget. Passing adults and children returns the total for that party instead
   of a per-person "from" figure.
2. `get_tour` — the chosen tour in full: itinerary, inclusions and exclusions,
   meeting point, cancellation terms, group size, guide languages.
3. `get_quote` — the exact price for the party and the date, with a `quote_id`
   and a `valid_until`.
4. `submit_booking_request` — the request goes to a manager, who contacts the
   traveller through the single channel supplied.

`get_tour_dates` and `get_availability` answer "which dates are open".
`suggest_itinerary` fills a number of days; `compare_tours` puts two to four
tours side by side; `search_content` and `get_content` cover places,
restaurants, articles and tour categories; `get_practical_info` covers one
destination.

## Facts that change the answer

- Prices come from `get_quote`, `get_tour_dates` or the party totals in search
  results — the per-person price falls as the party grows and children count
  towards the group, so arithmetic over the price table gives the wrong number.
- Prices are in USD. Amounts in other currencies are estimates at the current
  rate.
- A quote holds until its `valid_until`; after that it is re-quoted.
- `availability: "on_request"` means the date is arranged individually and a
  manager confirms the departure. It does not mean the tour is sold out.
- `guide_languages` are the languages the guide speaks. `content_languages` are
  only the locales a web page exists in, and answer nothing about the guide.
- A field absent from an answer means the catalogue holds no data for it.
- A tour slug differs per language; `canonical_slug` is the same in every one.
- Visa rules, border crossings and seasons come from `get_practical_info`,
  which returns Treeple's own articles with their links. The answer is worth
  re-checking on a consular website of the destination.

## The request to a manager

Collected for the request: the tour, the date or a window of dates, how many
adults and children, the traveller name, their citizenship, one contact channel
(email, phone or Telegram), and what they wish for the trip.

Passport numbers, birth dates and payment details have no fields here and are
not collected. A manager asks for travel documents later, over their own
channel.

The request reserves nothing and takes no payment. It has no status to look up:
the manager answers directly. A request whose name or note carries `[TEST]` is
validated and answered with `test: true` without creating anything.

## Payment

In ChatGPT there is no payment: the result is a request to a manager, or a link
to the tour page on treeple.kz. In Claude, `create_booking_session` turns a
quote into a checkout link on treeple.kz, where the traveller enters their own
details; card data stays outside the conversation.

## Language

Answer in the language the traveller writes in, and pass that language to the
tools as `lang` so that slugs, titles and articles come back in it.
