Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DAD3A2A9E
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 13:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhFJLtY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 07:49:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230033AbhFJLtY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Jun 2021 07:49:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3FA960FD8;
        Thu, 10 Jun 2021 11:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623325648;
        bh=7YxuqwYsONDTA+qgI2aFEeQMgplxmNsE4J8CozrGE5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bXWdtSZhHuDdBalkXqg2WYUd0yWxMJnELLfm5pmvHZOffo/tp4kOMnv9BSUv2VmhF
         HsEbQbVuGwgzHMdnLos/WSC78ggYBLosLxMr5J66AOhnHp3GBVxHEhgrxdclVeZQK+
         kkQILXWlJVu+0bTzgP2O83QLyNEWAIJQ/mJI6gbCXaexTaWULOZ0Od4b8nKYA/uLws
         dd4Ps38Hb+c0Q6sOFYSMe+x8p7D+mwPujoIolNJ3ZkI/Zw5DY82rOxwPPKHsIV/F88
         4qY4h0kmube/KlaZOEBXO1F8CNy6Y204EIMJtuCheeIQMevAcdAEuBumitna7SP9Ci
         238FnzpJngSiQ==
Date:   Thu, 10 Jun 2021 14:47:24 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: Re: [PATCH for-next 3/4] RDMA/rtrs: RDMA_RXE requires more number of
 WR
Message-ID: <YMH7zI0VZ4u1EfoJ@unreal>
References: <20210608103039.39080-1-jinpu.wang@ionos.com>
 <20210608103039.39080-4-jinpu.wang@ionos.com>
 <YMG99IVNqCK8OIVX@unreal>
 <CAMGffE=dUEnVrtYLy2xVYdm0Jb=JEnfBYvUB1ZZavx5a1BpnDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffE=dUEnVrtYLy2xVYdm0Jb=JEnfBYvUB1ZZavx5a1BpnDA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 10, 2021 at 01:01:07PM +0200, Jinpu Wang wrote:
> On Thu, Jun 10, 2021 at 9:23 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Tue, Jun 08, 2021 at 12:30:38PM +0200, Jack Wang wrote:
> > > From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > >
> > > When using rdma_rxe, post_one_recv() returns
> > > NOMEM error due to the full recv queue.
> > > This patch increase the number of WR for receive queue
> > > to support all devices.
> >
> > Why don't you query IB device to get max_qp_wr and set accordingly?
> >
> > Thanks
> Hi Leon,
> 
> We don't want to set the max_qp_wr, it will consume lots of memory.
> this patch is only for service connection
> used control messages.

OK, so why don't you set min(your_define, max_qp_wr)?

Thanks

> 
> For IO connection, we do query and max_qp_wr of the device, but still
> we need to set the minimum to
> reduce the memory consumption.
> 
> Thanks! Regards
> >
> > >
> > > Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> > > ---
> > >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 7 ++++---
> > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
> > >  2 files changed, 5 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > index cd53edddfe1f..acf0fde410c3 100644
> > > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > @@ -1579,10 +1579,11 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
> > >       lockdep_assert_held(&con->con_mutex);
> > >       if (con->c.cid == 0) {
> > >               /*
> > > -              * One completion for each receive and two for each send
> > > -              * (send request + registration)
> > > +              * Two (request + registration) completion for send
> > > +              * Two for recv if always_invalidate is set on server
> > > +              * or one for recv.
> > >                * + 2 for drain and heartbeat
> > > -              * in case qp gets into error state
> > > +              * in case qp gets into error state.
> > >                */
> > >               max_send_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
> > >               max_recv_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
> > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > index 04ec3080e9b5..bb73f7762a87 100644
> > > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > @@ -1656,7 +1656,7 @@ static int create_con(struct rtrs_srv_sess *sess,
> > >                * + 2 for drain and heartbeat
> > >                */
> > >               max_send_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
> > > -             max_recv_wr = SERVICE_CON_QUEUE_DEPTH + 2;
> > > +             max_recv_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
> > >               cq_size = max_send_wr + max_recv_wr;
> > >       } else {
> > >               /*
> > > --
> > > 2.25.1
> > >
