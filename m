Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404263E39F6
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Aug 2021 13:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbhHHLar (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 8 Aug 2021 07:30:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229473AbhHHLar (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 8 Aug 2021 07:30:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98F0060F9E;
        Sun,  8 Aug 2021 11:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628422228;
        bh=ul2MjUtzjSe5ahYb3XaJ5Av2MUWhnUg8UcwbiGE3j68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uANFMhW/UqjRp44PZ86uBXjozG2zQ3BS45IqjMnJH3BSw5+ycHE5O99JDNjdKj63p
         Za1CG0C1x2uAbkHI42qBacRoekXMsh97rCOIw9KPal/yOMdVnlYGcqwl/keUl9Wx3a
         9AORbVULXfDyxYxQwKSWecGrebKjpnC/OPWKfuCz7EGL/BUbHEC27F+OmQmxMwQcv4
         cnqvqXrLbjIG9ziQGduvOoKA/JoDBETPq+MRWGRFu/QIrv0xLS9YDotq1qLw3eK8xZ
         tuJ3mnmHnnE6PUR51TMqjUg+Ze+5nrHPn65Q/GG2FJPVIsfv53GOk9EwDTBGy5CH0z
         IK0SDh8N8kUxg==
Date:   Sun, 8 Aug 2021 14:30:24 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <xjtuwjp@gmail.com>
Cc:     Gioh Kim <gi-oh.kim@ionos.com>,
        Md Haris Iqbal <haris.iqbal@ionos.com>, bvanassche@acm.org,
        dledford@redhat.com, jgg@ziepe.ca, jinpu.wang@ionos.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 for-next 3/6] RDMA/rtrs: Fix warning when use poll mode
Message-ID: <YQ/AUHeLg5kaqMiH@unreal>
References: <20210806112112.124313-1-haris.iqbal@ionos.com>
 <20210806112112.124313-4-haris.iqbal@ionos.com>
 <YQ+d1Ssiw+G5THYe@unreal>
 <CAD+HZHXM_MvTrNtAm=egQwKFhyHAi5WHDcXhTC0wvSegHbd4sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD+HZHXM_MvTrNtAm=egQwKFhyHAi5WHDcXhTC0wvSegHbd4sg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 08, 2021 at 01:07:29PM +0200, Jack Wang wrote:
> Leon Romanovsky <leon@kernel.org>于2021年8月8日 周日11:05写道：
> 
> > On Fri, Aug 06, 2021 at 01:21:09PM +0200, Md Haris Iqbal wrote:
> > > From: Jack Wang <jinpu.wang@ionos.com>
> > >
> > > when test with poll mode, it will fail and lead to warning below:
> > > echo "sessname=bla path=gid:fe80::2:c903:4e:d0b3@gid:fe80::2:c903:8:ca17
> > > device_path=/dev/nullb2 nr_poll_queues=-1" |
> > > sudo tee /sys/devices/virtual/rnbd-client/ctl/map_device
> > >
> > > rnbd_client L597: Mapping device /dev/nullb2 on session bla,
> > > (access_mode: rw, nr_poll_queues: 8)
> > > WARNING: CPU: 3 PID: 9886 at drivers/infiniband/core/cq.c:447
> > ib_cq_pool_get+0x26f/0x2a0 [ib_core]
> > >
> > > The problem is, when poll_queues are used, there will be more
> > connections than
> > > number of cpus; and those extra connections will have ib poll context
> > set to
> > > IB_POLL_DIRECT, which is not allowed to be used for shared CQs.
> > >
> > > So, in case those extra connections when poll queues are used, use
> > > ib_alloc_cq/ib_free_cq.
> > >
> > > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > > Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
> > > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > > ---
> > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c |  1 +
> > >  drivers/infiniband/ulp/rtrs/rtrs.c     | 17 ++++++++++++++---
> > >  2 files changed, 15 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > index cd9a4ccf4c28..47775987f91a 100644
> > > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > @@ -1768,6 +1768,7 @@ static struct rtrs_srv_sess *__alloc_sess(struct
> > rtrs_srv *srv,
> > >       strscpy(sess->s.sessname, str, sizeof(sess->s.sessname));
> > >
> > >       sess->s.con_num = con_num;
> > > +     sess->s.irq_con_num = con_num;
> > >       sess->s.recon_cnt = recon_cnt;
> > >       uuid_copy(&sess->s.uuid, uuid);
gTgT> > >       spin_lock_init(&sess->state_lock);
> > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c
> > b/drivers/infiniband/ulp/rtrs/rtrs.c
> > > index ca542e477d38..9bc323490ce3 100644
> > > --- a/drivers/infiniband/ulp/rtrs/rtrs.c
> > > +++ b/drivers/infiniband/ulp/rtrs/rtrs.c
> > > @@ -228,7 +228,12 @@ static int create_cq(struct rtrs_con *con, int
> > cq_vector, int nr_cqe,
> > >       struct rdma_cm_id *cm_id = con->cm_id;
> > >       struct ib_cq *cq;
> > >
> > > -     cq = ib_cq_pool_get(cm_id->device, nr_cqe, cq_vector, poll_ctx);
> > > +     if (con->cid >= con->sess->irq_con_num)
> > > +             cq = ib_alloc_cq(cm_id->device, con, nr_cqe, cq_vector,
> > > +                              poll_ctx);
> > > +     else
> > > +             cq = ib_cq_pool_get(cm_id->device, nr_cqe, cq_vector,
> > poll_ctx);
> >
> > I see same "if (con->c.cid >= sess->s.irq_con_num)" checks when calling
> > to rtrs_cq_qp_create() that will take poll_ctx and convey it to
> > create_cq().
> >
> > Please take a look on nvme_rdma_create_cq() which does the same without
> > passing poll_ctx.
> >
> > Thanks
> 
> Hi,
> 
> The reason rtrs needs to have poll_ctx is rtrs-clt and rtrs-srv use
> different poll_ctx, and they all call into rtrs_cq_qp_create, while
> nvme_rdma_create_cq is only for host (client) side.
> 
> I guess you wanted to convert the same if
> (con->c.cid>=sess->s.irq_con_num), this can be done in a new patch.

I don't want to see code that does something like that:
 if (a_cond)
   f(...)
      if (a_cond)
        do_X
       else
        do_Y

The ideal flow should have minimal number of ifs to make the code
more clear and readable, and definitely shouldn't have same if()
checks in various places of the callstack.

In your case, rtrs-srv uses IB_POLL_WORKQUEUE as poll_ctx which doesn't
look related to the issue stated in the commit message.

Thanks

> 
> Thanks
> 
> >
> >
