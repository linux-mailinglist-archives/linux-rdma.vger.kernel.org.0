Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E059120C4C4
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2020 00:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgF0W5h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 27 Jun 2020 18:57:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgF0W5g (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 27 Jun 2020 18:57:36 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B48A720702;
        Sat, 27 Jun 2020 22:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593298655;
        bh=pIX6B9Q3ruZzIvrotxJUkfdomlRxkZx0LL2DcGUF1yg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qM/h678s+QZ3ckN6KV9fxTw7uS1dVeNGnRxTBr/REvgsaPArmcNEamHPqq+FZRvg5
         ov+yUpwO1r2l7U8WIYRUAlUxxq34ZYWdmb4ZIXFw9xwMqPyiPbfnsAuTCabxvkJde9
         Uh1jPPDEKfzxRMfYzL9aJwSyn76AoqBIZOoghY9M=
Date:   Sat, 27 Jun 2020 15:57:34 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/ucma: Put a lock around every call to the rdma_cm
 layer
Message-ID: <20200627225734.GL7065@sol.localdomain>
References: <20200218210432.GA31966@ziepe.ca>
 <20200219060701.GG1075@sol.localdomain>
 <20200219202221.GN23930@mellanox.com>
 <20200307204153.GJ15444@sol.localdomain>
 <20200309193012.GA13183@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309193012.GA13183@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 09, 2020 at 04:30:12PM -0300, Jason Gunthorpe wrote:
> On Sat, Mar 07, 2020 at 12:41:53PM -0800, Eric Biggers wrote:
> > On Wed, Feb 19, 2020 at 08:22:25PM +0000, Jason Gunthorpe wrote:
> > > On Tue, Feb 18, 2020 at 10:07:01PM -0800, Eric Biggers wrote:
> > > > > these 11 lets include them as  well. I wasn't able to find a way to
> > > > > search for things, this list is from your past email, thanks.
> > > > > 
> > > > 
> > > > Unfortunately I haven't had time to work on syzkaller bugs lately, so I can't
> > > > provide an updated list until I go through the long backlog of bugs.
> > > 
> > > Ok
> > 
> > Here's an updated list:
> > 
> > --------------------------------------------------------------------------------
> > Title:              general protection fault in rds_ib_add_one
> > Last occurred:      0 days ago
> > Reported:           12 days ago
> > Branches:           Mainline and others
> > Dashboard link:     https://syzkaller.appspot.com/bug?id=15f96d171c64999196ac7db3de107f24b9182a8e
> > Original thread:    https://lore.kernel.org/lkml/000000000000b9b7d4059f4e4ac7@google.com/T/#u
> > 
> > This bug has a C reproducer.
> 
> Looks like this is fixed by Hillf
> 
> > --------------------------------------------------------------------------------
> > Title:              INFO: trying to register non-static key in xa_destroy
> > Last occurred:      0 days ago
> > Reported:           11 days ago
> > Branches:           Mainline and others
> > Dashboard link:     https://syzkaller.appspot.com/bug?id=c0a75a31c5fa84e6e5d3131fd98a5b56e2141b9a
> > Original thread:    https://lore.kernel.org/lkml/00000000000046895c059f5cae37@google.com/T/#u
> > 
> > This bug has a C reproducer.
> 
> Fixed in v5.6-rc5
> 
> > --------------------------------------------------------------------------------
> > Title:              general protection fault in nldev_stat_set_doit
> > Last occurred:      4 days ago
> > Reported:           11 days ago
> > Branches:           Mainline and others
> > Dashboard link:     https://syzkaller.appspot.com/bug?id=1fbcb607cf49d8b5a3c8e056971f045f9bfa34f3
> > Original thread:    https://lore.kernel.org/lkml/0000000000004aa34d059f5caedc@google.com/T/#u
> > 
> > This bug has a C reproducer.
> 
> Fixed in v5.6-rc5
>  
> > --------------------------------------------------------------------------------
> > Title:              BUG: corrupted list in _cma_attach_to_dev
> > Last occurred:      2 days ago
> > Reported:           6 days ago
> > Branches:           Mainline
> > Dashboard link:     https://syzkaller.appspot.com/bug?id=067b1e60bab1b617c1208f078cd76c9087f070e0
> > Original thread:    https://lore.kernel.org/lkml/000000000000cfed90059fcfdccb@google.com/T/#u
> > 
> > This bug has a C reproducer.
> 
> Most likely fixed by this patch, syzkaller is re-testing
> 
> > --------------------------------------------------------------------------------
> > Title:              WARNING: kobject bug in ib_register_device
> > Last occurred:      1 day ago
> > Reported:           12 days ago
> > Branches:           Mainline and others
> > Dashboard link:     https://syzkaller.appspot.com/bug?id=805ad726feb6910e35088ae7bbe61f4125e573b7
> > Original thread:    https://lore.kernel.org/lkml/000000000000026ac5059f4e27f3@google.com/T/#u
> > 
> > This bug has a C reproducer.
> 
> Oh, this wasn't sent to rdma, yes, obvious rdma bug, made a patch
> 
> > --------------------------------------------------------------------------------
> > Title:              BUG: corrupted list in cma_listen_on_dev
> > Last occurred:      4 days ago
> > Reported:           4 days ago
> > Branches:           Mainline
> > Dashboard link:     https://syzkaller.appspot.com/bug?id=e8fcdea4e5a443c597c94fb6eda7d6646eafe6a2
> > Original thread:    https://lore.kernel.org/lkml/00000000000020c5d205a001c308@google.com/T/#u
> > 
> > This bug has a C reproducer.
> 
> Fixed by this patch, syzkaller confirmed, now duped to another bug
> 
> > --------------------------------------------------------------------------------
> > Title:              KASAN: use-after-free Read in rxe_query_port
> > Last occurred:      0 days ago
> > Reported:           6 days ago
> > Branches:           Mainline and others
> > Dashboard link:     https://syzkaller.appspot.com/bug?id=f00443e97b44c466dc75edc31601110bf62a6f69
> > Original thread:    https://lore.kernel.org/lkml/0000000000000c9e12059fc941ff@google.com/T/#u
> > 
> > Unfortunately, this bug does not have a reproducer.
> 
> Perhaps Yanjun Zhu will look at this
> 
> > --------------------------------------------------------------------------------
> > Title:              WARNING in ib_free_port_attrs
> > Last occurred:      1 day ago
> > Reported:           6 days ago
> > Branches:           net and net-next
> > Dashboard link:     https://syzkaller.appspot.com/bug?id=4ec089798f282f2d2c3219151e420ed1ba10120d
> > Original thread:    https://lore.kernel.org/lkml/000000000000460717059fd83734@google.com/T/#u
> > 
> > Unfortunately, this bug does not have a reproducer.
> 
> Parav and I looked at this for a while and couldn't figure how how it
> is possible. Hoping for a reproducer
> 
> > --------------------------------------------------------------------------------
> > Title:              INFO: task hung in rdma_destroy_id
> > Last occurred:      3 days ago
> > Reported:           5 days ago
> > Branches:           Mainline and others
> > Dashboard link:     https://syzkaller.appspot.com/bug?id=e89b86960c3636f57dbb16bb25a829377ebdf43d
> > Original thread:    https://lore.kernel.org/lkml/00000000000059e701059fe3ec2f@google.com/T/#u
> > 
> > Unfortunately, this bug does not have a reproducer.
> 
> Most likely fixed by this patch
> 
> > --------------------------------------------------------------------------------
> > Title:              general protection fault in kobject_get
> > Last occurred:      6 days ago
> > Reported:           6 days ago
> > Branches:           net-next
> > Dashboard link:     https://syzkaller.appspot.com/bug?id=f8e0f99b310558dd489cc7427711a640c10b93e5
> > Original thread:    https://lore.kernel.org/lkml/000000000000c4b371059fd83a92@google.com/T/#u
> > 
> > Unfortunately, this bug does not have a reproducer.
> 
> Really surprised no reproducer, this is not a race bug. I wrote a fix,
> it is being tested now.
> 
> > --------------------------------------------------------------------------------
> > Title:              WARNING: kobject bug in add_one_compat_dev
> > Last occurred:      8 days ago
> > Reported:           10 days ago
> > Branches:           linux-next and net-next
> > Dashboard link:     https://syzkaller.appspot.com/bug?id=f8880fdc3cd0ba268421672360cf79bfa7fa4272
> > Original thread:    https://lore.kernel.org/lkml/0000000000005f77d6059f888f2e@google.com/T/#u
> > 
> > Unfortunately, this bug does not have a reproducer.
> 
> Hmm. I wonder if this is because 'dev_set_name' failed and we ignored
> it? Is that possible with this log? Lets fix that at least - I have no
> other idea how we could get an empty name.
> 
> > --------------------------------------------------------------------------------
> > Title:              WARNING in srp_remove_one
> > Last occurred:      9 days ago
> > Reported:           6 days ago
> > Branches:           Mainline
> > Dashboard link:     https://syzkaller.appspot.com/bug?id=16a5827f8f6f6ef0967e6492ffb2e2ca54c8c0fb
> > Original thread:    https://lore.kernel.org/lkml/000000000000144d79059fc9415d@google.com/T/#u
> > 
> > Unfortunately, this bug does not have a reproducer.
> 
> This looks a lot like 'WARNING in ib_free_port_attrs' - I don't have a
> clear idea how these sysfs errors are possible. I wonder if there is
> something strange going on in sysfs land during net ns actions?
> 
> Thanks,
> Jason

Hi Jason, here's my latest list (updated today) of bugs that are probably in
drivers/infiniband/:

--------------------------------------------------------------------------------
Title:              general protection fault in rds_ib_add_one
Last occurred:      1 day ago
Reported:           124 days ago
Branches:           Mainline and others
Dashboard link:     https://syzkaller.appspot.com/bug?id=15f96d171c64999196ac7db3de107f24b9182a8e
Original thread:    https://lore.kernel.org/lkml/000000000000b9b7d4059f4e4ac7@google.com/T/#u

This bug has a C reproducer.

The original thread for this bug received 5 replies; the last was 117 days ago.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+274094e62023782eeb17@syzkaller.appspotmail.com

If you send any email or patch for this bug, please consider replying to the
original thread.  For the git send-email command to use, or tips on how to reply
if the thread isn't in your mailbox, see the "Reply instructions" at
https://lore.kernel.org/r/000000000000b9b7d4059f4e4ac7@google.com

--------------------------------------------------------------------------------
Title:              WARNING in srp_remove_one
Last occurred:      0 days ago
Reported:           118 days ago
Branches:           Mainline and others
Dashboard link:     https://syzkaller.appspot.com/bug?id=16a5827f8f6f6ef0967e6492ffb2e2ca54c8c0fb
Original thread:    https://lore.kernel.org/lkml/000000000000144d79059fc9415d@google.com/T/#u

Unfortunately, this bug does not have a reproducer.

No one replied to the original thread for this bug.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+687bc62a84a6a2a3555a@syzkaller.appspotmail.com

If you send any email or patch for this bug, please consider replying to the
original thread.  For the git send-email command to use, or tips on how to reply
if the thread isn't in your mailbox, see the "Reply instructions" at
https://lore.kernel.org/r/000000000000144d79059fc9415d@google.com

--------------------------------------------------------------------------------
Title:              WARNING in ib_uverbs_remove_one
Last occurred:      0 days ago
Reported:           99 days ago
Branches:           Mainline and others
Dashboard link:     https://syzkaller.appspot.com/bug?id=7d092a26c44ac45dc0a59a1a0474be064db8fa66
Original thread:    https://lore.kernel.org/lkml/000000000000c3a75205a14cb8c9@google.com/T/#u

Unfortunately, this bug does not have a reproducer.

No one replied to the original thread for this bug.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+d3f37b9458fe8281d078@syzkaller.appspotmail.com

If you send any email or patch for this bug, please consider replying to the
original thread.  For the git send-email command to use, or tips on how to reply
if the thread isn't in your mailbox, see the "Reply instructions" at
https://lore.kernel.org/r/000000000000c3a75205a14cb8c9@google.com

--------------------------------------------------------------------------------
Title:              WARNING in ib_free_port_attrs
Last occurred:      1 day ago
Reported:           117 days ago
Branches:           Mainline and others
Dashboard link:     https://syzkaller.appspot.com/bug?id=4ec089798f282f2d2c3219151e420ed1ba10120d
Original thread:    https://lore.kernel.org/lkml/000000000000460717059fd83734@google.com/T/#u

Unfortunately, this bug does not have a reproducer.

The original thread for this bug received 1 reply, 116 days ago.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+e909641b84b5bc17ad8b@syzkaller.appspotmail.com

If you send any email or patch for this bug, please consider replying to the
original thread.  For the git send-email command to use, or tips on how to reply
if the thread isn't in your mailbox, see the "Reply instructions" at
https://lore.kernel.org/r/000000000000460717059fd83734@google.com

--------------------------------------------------------------------------------
Title:              WARNING in ib_umad_kill_port
Last occurred:      1 day ago
Reported:           82 days ago
Branches:           Mainline and others
Dashboard link:     https://syzkaller.appspot.com/bug?id=4ecc18c71d37b62b131aee8184a642ae5d2d21a6
Original thread:    https://lore.kernel.org/lkml/00000000000075245205a2997f68@google.com/T/#u

Unfortunately, this bug does not have a reproducer.

The original thread for this bug has received 8 replies; the last was 79 days
ago.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+9627a92b1f9262d5d30c@syzkaller.appspotmail.com

If you send any email or patch for this bug, please consider replying to the
original thread.  For the git send-email command to use, or tips on how to reply
if the thread isn't in your mailbox, see the "Reply instructions" at
https://lore.kernel.org/r/00000000000075245205a2997f68@google.com

--------------------------------------------------------------------------------
Title:              KASAN: use-after-free Write in addr_resolve
Last occurred:      20 days ago
Reported:           17 days ago
Branches:           Mainline
Dashboard link:     https://syzkaller.appspot.com/bug?id=e0a96faaf6799220954d5f5d8ec6fa0c386f85ac
Original thread:    https://lore.kernel.org/lkml/000000000000eb293205a7bdd19a@google.com/T/#u

Unfortunately, this bug does not have a reproducer.

No one has replied to the original thread for this bug yet.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+08092148130652a6faae@syzkaller.appspotmail.com

If you send any email or patch for this bug, please consider replying to the
original thread.  For the git send-email command to use, or tips on how to reply
if the thread isn't in your mailbox, see the "Reply instructions" at
https://lore.kernel.org/r/000000000000eb293205a7bdd19a@google.com

--------------------------------------------------------------------------------
Title:              KASAN: use-after-free Read in addr_handler (2)
Last occurred:      17 days ago
Reported:           17 days ago
Branches:           Mainline
Dashboard link:     https://syzkaller.appspot.com/bug?id=cfd37bf8b5d2768b6b87e7b4c3a588a06ea6284a
Original thread:    https://lore.kernel.org/lkml/000000000000107b4605a7bdce7d@google.com/T/#u

Unfortunately, this bug does not have a reproducer.

The original thread for this bug has received 2 replies; the last was 20 hours
ago.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+a929647172775e335941@syzkaller.appspotmail.com

If you send any email or patch for this bug, please reply to the original
thread, which had activity only 20 hours ago.  For the git send-email command to
use, or tips on how to reply if the thread isn't in your mailbox, see the "Reply
instructions" at https://lore.kernel.org/r/000000000000107b4605a7bdce7d@google.com

--------------------------------------------------------------------------------
Title:              KASAN: use-after-free Read in ib_uverbs_remove_one
Last occurred:      33 days ago
Reported:           30 days ago
Branches:           linux-next
Dashboard link:     https://syzkaller.appspot.com/bug?id=f1a3b9d9350867a50d642b8e2cee217569b8adca
Original thread:    https://lore.kernel.org/lkml/00000000000095442505a6b63551@google.com/T/#u

Unfortunately, this bug does not have a reproducer.

The original thread for this bug has received 2 replies; the last was 28 days
ago.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+478fd0d54412b8759e0d@syzkaller.appspotmail.com

If you send any email or patch for this bug, please consider replying to the
original thread.  For the git send-email command to use, or tips on how to reply
if the thread isn't in your mailbox, see the "Reply instructions" at
https://lore.kernel.org/r/00000000000095442505a6b63551@google.com

--------------------------------------------------------------------------------
Title:              WARNING in ib_unregister_device_queued
Last occurred:      51 days ago
Reported:           62 days ago
Branches:           net
Dashboard link:     https://syzkaller.appspot.com/bug?id=979c332b27ca869bd26c337574ef068908c1da3c
Original thread:    https://lore.kernel.org/lkml/000000000000aa012505a431c7d9@google.com/T/#u

Unfortunately, this bug does not have a reproducer.

The original thread for this bug has received 2 replies; the last was 60 days
ago.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+4088ed905e4ae2b0e13b@syzkaller.appspotmail.com

If you send any email or patch for this bug, please consider replying to the
original thread.  For the git send-email command to use, or tips on how to reply
if the thread isn't in your mailbox, see the "Reply instructions" at
https://lore.kernel.org/r/000000000000aa012505a431c7d9@google.com

