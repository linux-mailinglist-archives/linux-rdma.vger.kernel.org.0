Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0C03DDDC2
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Aug 2021 18:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbhHBQeU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Aug 2021 12:34:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233075AbhHBQeS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Aug 2021 12:34:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EBB061029;
        Mon,  2 Aug 2021 16:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627922048;
        bh=LHx+2cUrgzNK38RC/ClXs+9ejBYjaoNRq1R6TOt9Uic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yhw/i4mo08T1qRcHl63LZmGXS7+q0ezK3J6xOZvHopRqx5G2QE8ekLpAMrhR83cBD
         gPB5ZTNSfQWTK07COdADIq2Pyojtxr8iFtuZUDPPX7DH8ws2a3XHLSCii6gsal/8kG
         ztoqJU3w8n1LAP7DhI5kZtHPXRvSiP3/6FUOS0UCLA5pl+GKofDtVWJcXpi7p4p0YV
         FKgKViSDlGgKHMMyFGFh9ig812e5DsdXpoAgDr4hdzoCjdIhRsmHxZ2nu/hev5XKcd
         +8qTzk2VoZtlhmcKN5XNgyNe2hXxJ7G5vqDy0Dt9tiepBnK+9vrSxCR+LfBigliZ6n
         36X4zkA5/ksVg==
Date:   Mon, 2 Aug 2021 19:34:02 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Haris Iqbal <haris.iqbal@ionos.com>
Cc:     Jack Wang <jinpu.wang@ionos.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Gioh Kim <gi-oh.kim@ionos.com>
Subject: Re: [PATCH for-next 02/10] RDMA/rtrs-srv: Prevent sysfs error with
 path name "ctl"
Message-ID: <YQgeeqWOY/PA4zU8@unreal>
References: <20210730131832.118865-1-jinpu.wang@ionos.com>
 <20210730131832.118865-3-jinpu.wang@ionos.com>
 <YQeVAMWiZZ1sRqDP@unreal>
 <CAJpMwyjo7H53A33Wzm2yX4qQ6WxHu7Q3ia5xoHqOtdD8VupPYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJpMwyjo7H53A33Wzm2yX4qQ6WxHu7Q3ia5xoHqOtdD8VupPYQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 02, 2021 at 04:24:39PM +0200, Haris Iqbal wrote:
> On Mon, Aug 2, 2021 at 8:47 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Fri, Jul 30, 2021 at 03:18:24PM +0200, Jack Wang wrote:
> > > From: Gioh Kim <gi-oh.kim@ionos.com>
> > >
> > > If the client tries to create a path with name "ctl",
> > > the server tries to creates /sys/devices/virtual/rtrs-server/ctl/.
> > > Then server generated below error because there is already ctl directory
> > > which manages some setup of the server.
> > >
> > > sysfs: cannot create duplicate filename '/devices/virtual/rtrs-server/ctl'
> > > Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
> > > Call Trace:
> > > dump_stack+0x50/0x63
> > > sysfs_warn_dup.cold+0x17/0x24
> > > sysfs_create_dir_ns+0xb6/0xd0
> > > kobject_add_internal+0xa6/0x2a0
> > > kobject_add+0x7e/0xb0
> > > ? _cond_resched+0x15/0x30
> > > device_add+0x121/0x640
> > > rtrs_srv_create_sess_files+0x18f/0x1f0 [rtrs_server]
> > > ? __alloc_pages_nodemask+0x16c/0x2b0
> > > ? kmalloc_order+0x7c/0x90
> > > ? kmalloc_order_trace+0x1d/0xa0
> > > ? rtrs_iu_alloc+0x17e/0x1bf [rtrs_core]
> > > rtrs_srv_info_req_done+0x417/0x5b0 [rtrs_server]
> > > ? __switch_to_asm+0x40/0x70
> > > __ib_process_cq+0x76/0xd0 [ib_core]
> > > ib_cq_poll_work+0x26/0x80 [ib_core]
> > > process_one_work+0x1df/0x3a0
> > > worker_thread+0x4a/0x3c0
> > > kthread+0xfb/0x130
> > > ? process_one_work+0x3a0/0x3a0
> > > ? kthread_park+0x90/0x90
> > > ret_from_fork+0x1f/0x40
> > > kobject_add_internal failed for ctl with -EEXIST, don't try to register things with the same name in the same directory.
> > > rtrs_server L178: device_add(): -17
> > >
> > > This patch checks the path name and disconnect on server to prevent
> > > the kernel error.
> > >
> > > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> > > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > > ---
> > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > index cd9a4ccf4c28..b814a6052cf1 100644
> > > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > @@ -758,6 +758,14 @@ static bool exist_sessname(struct rtrs_srv_ctx *ctx,
> > >       struct rtrs_srv_sess *sess;
> > >       bool found = false;
> > >
> > > +     /*
> > > +      * Session name "ct" is not allowed because
> > > +      * /sys/devices/virtual/rtrs-server/ctl already exists
> > > +      * for setup management.
> > > +      */
> > > +     if (!strcmp(sessname, "ctl"))
> > > +             return true;
> >
> > Why does it have special treatment?
> 
> rtrs-server creates a folder named ctl when the module is modprob'ed.
> When a session is established, a folder of the session name is created
> at the same location, which would hold sysfs entries such as
> clt_hostname, path details, queue_depth, etc.
> 
> Due to this conflict of names, creation of session with that name is
> not possible. So this gracefully fails the connection establishment
> instead of a stack trace.
> 
> > And what will happen if user supplies "." or ".."?
> 
> Weirdly enough, this succeeds. I tried, and the session creation
> succeeds, and there is a hidden entry in the rtrs-server folder, but
> it cannot be accessed through bash.

All special symbols must be disallowed and filtered on the server side. 

> 
> > Does rtrs receive this session name from the other side in the network?
> 
> Yes. This string is entered by the user while creating the session.

It sounds scary

> 
> >
> > Thanks
