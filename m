Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7367517D00C
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Mar 2020 21:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgCGUl4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 7 Mar 2020 15:41:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:45646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbgCGUl4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 7 Mar 2020 15:41:56 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25BB72070A;
        Sat,  7 Mar 2020 20:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583613715;
        bh=UtyteW5UqJZdSOyVmmN6dDA1ZlYIvZ14lmTl5hl2t+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rB7yOP4IyRfdEujDweGo0Y2dJv0cO4LIIDNa6UdsT+9ZuEd3hA1RmYD4Wn4caICg4
         kEp570idpYZJ13iJQ8cuawkzlHIHCqXKBxkEm/VEZc1wqfhhpvVw5zr0j9j6ac0Nit
         j3rDfF9F9NC5QLA8Na6aJbPjqkUC4C1FEcUikTo4=
Date:   Sat, 7 Mar 2020 12:41:53 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/ucma: Put a lock around every call to the rdma_cm
 layer
Message-ID: <20200307204153.GJ15444@sol.localdomain>
References: <20200218210432.GA31966@ziepe.ca>
 <20200219060701.GG1075@sol.localdomain>
 <20200219202221.GN23930@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219202221.GN23930@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 19, 2020 at 08:22:25PM +0000, Jason Gunthorpe wrote:
> On Tue, Feb 18, 2020 at 10:07:01PM -0800, Eric Biggers wrote:
> > > these 11 lets include them as  well. I wasn't able to find a way to
> > > search for things, this list is from your past email, thanks.
> > > 
> > 
> > Unfortunately I haven't had time to work on syzkaller bugs lately, so I can't
> > provide an updated list until I go through the long backlog of bugs.
> 
> Ok

Here's an updated list:

--------------------------------------------------------------------------------
Title:              general protection fault in rds_ib_add_one
Last occurred:      0 days ago
Reported:           12 days ago
Branches:           Mainline and others
Dashboard link:     https://syzkaller.appspot.com/bug?id=15f96d171c64999196ac7db3de107f24b9182a8e
Original thread:    https://lore.kernel.org/lkml/000000000000b9b7d4059f4e4ac7@google.com/T/#u

This bug has a C reproducer.

The original thread for this bug has received 5 replies; the last was 5 days
ago.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+274094e62023782eeb17@syzkaller.appspotmail.com

If you send any email or patch for this bug, please reply to the original
thread, which had activity only 5 days ago.  For the git send-email command to
use, or tips on how to reply if the thread isn't in your mailbox, see the "Reply
instructions" at https://lore.kernel.org/r/000000000000b9b7d4059f4e4ac7@google.com

--------------------------------------------------------------------------------
Title:              INFO: trying to register non-static key in xa_destroy
Last occurred:      0 days ago
Reported:           11 days ago
Branches:           Mainline and others
Dashboard link:     https://syzkaller.appspot.com/bug?id=c0a75a31c5fa84e6e5d3131fd98a5b56e2141b9a
Original thread:    https://lore.kernel.org/lkml/00000000000046895c059f5cae37@google.com/T/#u

This bug has a C reproducer.

No one has replied to the original thread for this bug yet.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+2e80962bedd9559fe0b3@syzkaller.appspotmail.com

If you send any email or patch for this bug, please reply to the original
thread.  For the git send-email command to use, or tips on how to reply if the
thread isn't in your mailbox, see the "Reply instructions" at
https://lore.kernel.org/r/00000000000046895c059f5cae37@google.com

--------------------------------------------------------------------------------
Title:              general protection fault in nldev_stat_set_doit
Last occurred:      4 days ago
Reported:           11 days ago
Branches:           Mainline and others
Dashboard link:     https://syzkaller.appspot.com/bug?id=1fbcb607cf49d8b5a3c8e056971f045f9bfa34f3
Original thread:    https://lore.kernel.org/lkml/0000000000004aa34d059f5caedc@google.com/T/#u

This bug has a C reproducer.

The original thread for this bug has received 1 reply, 11 days ago.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+bd4af81bc51ee0283445@syzkaller.appspotmail.com

If you send any email or patch for this bug, please reply to the original
thread, which had activity only 11 days ago.  For the git send-email command to
use, or tips on how to reply if the thread isn't in your mailbox, see the "Reply
instructions" at https://lore.kernel.org/r/0000000000004aa34d059f5caedc@google.com

--------------------------------------------------------------------------------
Title:              BUG: corrupted list in _cma_attach_to_dev
Last occurred:      2 days ago
Reported:           6 days ago
Branches:           Mainline
Dashboard link:     https://syzkaller.appspot.com/bug?id=067b1e60bab1b617c1208f078cd76c9087f070e0
Original thread:    https://lore.kernel.org/lkml/000000000000cfed90059fcfdccb@google.com/T/#u

This bug has a C reproducer.

No one has replied to the original thread for this bug yet.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+06b50ee4a9bd73e8b89f@syzkaller.appspotmail.com

If you send any email or patch for this bug, please reply to the original
thread.  For the git send-email command to use, or tips on how to reply if the
thread isn't in your mailbox, see the "Reply instructions" at
https://lore.kernel.org/r/000000000000cfed90059fcfdccb@google.com

--------------------------------------------------------------------------------
Title:              WARNING: kobject bug in ib_register_device
Last occurred:      1 day ago
Reported:           12 days ago
Branches:           Mainline and others
Dashboard link:     https://syzkaller.appspot.com/bug?id=805ad726feb6910e35088ae7bbe61f4125e573b7
Original thread:    https://lore.kernel.org/lkml/000000000000026ac5059f4e27f3@google.com/T/#u

This bug has a C reproducer.

No one has replied to the original thread for this bug yet.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+da615ac67d4dbea32cbc@syzkaller.appspotmail.com

If you send any email or patch for this bug, please reply to the original
thread.  For the git send-email command to use, or tips on how to reply if the
thread isn't in your mailbox, see the "Reply instructions" at
https://lore.kernel.org/r/000000000000026ac5059f4e27f3@google.com

--------------------------------------------------------------------------------
Title:              BUG: corrupted list in cma_listen_on_dev
Last occurred:      4 days ago
Reported:           4 days ago
Branches:           Mainline
Dashboard link:     https://syzkaller.appspot.com/bug?id=e8fcdea4e5a443c597c94fb6eda7d6646eafe6a2
Original thread:    https://lore.kernel.org/lkml/00000000000020c5d205a001c308@google.com/T/#u

This bug has a C reproducer.

The original thread for this bug has received 1 reply, 3 days ago.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+2b10b240fbbed30f10fb@syzkaller.appspotmail.com

If you send any email or patch for this bug, please reply to the original
thread, which had activity only 3 days ago.  For the git send-email command to
use, or tips on how to reply if the thread isn't in your mailbox, see the "Reply
instructions" at https://lore.kernel.org/r/00000000000020c5d205a001c308@google.com

--------------------------------------------------------------------------------
Title:              KASAN: use-after-free Read in rxe_query_port
Last occurred:      0 days ago
Reported:           6 days ago
Branches:           Mainline and others
Dashboard link:     https://syzkaller.appspot.com/bug?id=f00443e97b44c466dc75edc31601110bf62a6f69
Original thread:    https://lore.kernel.org/lkml/0000000000000c9e12059fc941ff@google.com/T/#u

Unfortunately, this bug does not have a reproducer.

No one has replied to the original thread for this bug yet.

I'm not confident this bug is really in the net/rdma subsystem.  I also think it
might be in the net/smc subsystem.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+e11efb687f5ab7f01f3d@syzkaller.appspotmail.com

If you send any email or patch for this bug, please reply to the original
thread.  For the git send-email command to use, or tips on how to reply if the
thread isn't in your mailbox, see the "Reply instructions" at
https://lore.kernel.org/r/0000000000000c9e12059fc941ff@google.com

--------------------------------------------------------------------------------
Title:              WARNING in ib_free_port_attrs
Last occurred:      1 day ago
Reported:           6 days ago
Branches:           net and net-next
Dashboard link:     https://syzkaller.appspot.com/bug?id=4ec089798f282f2d2c3219151e420ed1ba10120d
Original thread:    https://lore.kernel.org/lkml/000000000000460717059fd83734@google.com/T/#u

Unfortunately, this bug does not have a reproducer.

The original thread for this bug has received 1 reply, 4 days ago.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+e909641b84b5bc17ad8b@syzkaller.appspotmail.com

If you send any email or patch for this bug, please reply to the original
thread, which had activity only 4 days ago.  For the git send-email command to
use, or tips on how to reply if the thread isn't in your mailbox, see the "Reply
instructions" at https://lore.kernel.org/r/000000000000460717059fd83734@google.com

--------------------------------------------------------------------------------
Title:              INFO: task hung in rdma_destroy_id
Last occurred:      3 days ago
Reported:           5 days ago
Branches:           Mainline and others
Dashboard link:     https://syzkaller.appspot.com/bug?id=e89b86960c3636f57dbb16bb25a829377ebdf43d
Original thread:    https://lore.kernel.org/lkml/00000000000059e701059fe3ec2f@google.com/T/#u

Unfortunately, this bug does not have a reproducer.

No one has replied to the original thread for this bug yet.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+0abbad99bee187cf63d4@syzkaller.appspotmail.com

If you send any email or patch for this bug, please reply to the original
thread.  For the git send-email command to use, or tips on how to reply if the
thread isn't in your mailbox, see the "Reply instructions" at
https://lore.kernel.org/r/00000000000059e701059fe3ec2f@google.com

--------------------------------------------------------------------------------
Title:              general protection fault in kobject_get
Last occurred:      6 days ago
Reported:           6 days ago
Branches:           net-next
Dashboard link:     https://syzkaller.appspot.com/bug?id=f8e0f99b310558dd489cc7427711a640c10b93e5
Original thread:    https://lore.kernel.org/lkml/000000000000c4b371059fd83a92@google.com/T/#u

Unfortunately, this bug does not have a reproducer.

The original thread for this bug has received 2 replies; the last was 4 days
ago.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+46fe08363dbba223dec5@syzkaller.appspotmail.com

If you send any email or patch for this bug, please reply to the original
thread, which had activity only 4 days ago.  For the git send-email command to
use, or tips on how to reply if the thread isn't in your mailbox, see the "Reply
instructions" at https://lore.kernel.org/r/000000000000c4b371059fd83a92@google.com

--------------------------------------------------------------------------------
Title:              WARNING: kobject bug in add_one_compat_dev
Last occurred:      8 days ago
Reported:           10 days ago
Branches:           linux-next and net-next
Dashboard link:     https://syzkaller.appspot.com/bug?id=f8880fdc3cd0ba268421672360cf79bfa7fa4272
Original thread:    https://lore.kernel.org/lkml/0000000000005f77d6059f888f2e@google.com/T/#u

Unfortunately, this bug does not have a reproducer.

No one has replied to the original thread for this bug yet.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+ab4dae63f7d310641ded@syzkaller.appspotmail.com

If you send any email or patch for this bug, please reply to the original
thread.  For the git send-email command to use, or tips on how to reply if the
thread isn't in your mailbox, see the "Reply instructions" at
https://lore.kernel.org/r/0000000000005f77d6059f888f2e@google.com

--------------------------------------------------------------------------------
Title:              WARNING in srp_remove_one
Last occurred:      9 days ago
Reported:           6 days ago
Branches:           Mainline
Dashboard link:     https://syzkaller.appspot.com/bug?id=16a5827f8f6f6ef0967e6492ffb2e2ca54c8c0fb
Original thread:    https://lore.kernel.org/lkml/000000000000144d79059fc9415d@google.com/T/#u

Unfortunately, this bug does not have a reproducer.

No one has replied to the original thread for this bug yet.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+687bc62a84a6a2a3555a@syzkaller.appspotmail.com

If you send any email or patch for this bug, please reply to the original
thread.  For the git send-email command to use, or tips on how to reply if the
thread isn't in your mailbox, see the "Reply instructions" at
https://lore.kernel.org/r/000000000000144d79059fc9415d@google.com

