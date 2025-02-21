class CartHelper:
    def __init__(self):
        self.selected_tours = []
        self.selected_tickets = {}
        print("initialised")

    def add_ticket(self, ticket_category, ticket_type, price):
        # TODO: ensure that the tickets stack if type and category match on printing. -TT
        # type = Age group, category = VIP/Regular
        key = (ticket_category, ticket_type)

        if key in self.selected_tickets:
            self.selected_tickets[key]["count"] += 1
            self.selected_tickets[key]["price"] += price
        else:
            self.selected_tickets[key] = {
                "count": 1,
                "price": price,
                "label": f"{ticket_category} {ticket_type} Tickets(s)"
            }

    def add_tour(self, tour_name, date, price):
        # TODO: ensure that the tours stay separate on printing. -TT
        self.selected_tours.append(f"{tour_name} on {date} - ${price}")

    def get_expected_cart_entries(self):
        expected_cart_entries = []

        for (ticket_category, ticket_type), info in self.selected_tickets.items():
            expected_cart_entries.append({f"{info['count']} {info['label']} - ${info['price']}"})

        expected_cart_entries.extend(self.selected_tours)

        return expected_cart_entries