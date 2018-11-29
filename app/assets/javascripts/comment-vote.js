function vote(self) {
    direction = $(self).data("target");
    comment_id = $(self).data("comment");
    votes = $(self).siblings(".votes");
    switch (direction) {
        case 'up':
            new_val = parseInt(votes.text()) + 1;
            votes.text(new_val);
            Rails.ajax({
                url: $(self).data("url"),
                type: "PATCH",
                data: "type=up&comment_id="+comment_id
            });
            break;
        case 'down':
            new_val = parseInt(votes.text()) - 1;
            votes.text(new_val);
            Rails.ajax({
                url: $(self).data("url"),
                type: "PATCH",
                data: "type=down&comment_id="+comment_id
            });
            break;
    }
}