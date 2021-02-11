Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB62318753
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Feb 2021 10:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhBKJrQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Feb 2021 04:47:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:45220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230138AbhBKJhn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Feb 2021 04:37:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABBD364E8B;
        Thu, 11 Feb 2021 09:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613036222;
        bh=/y4Fp7qAnqIlft3C6OFHlEq2J3YS763ybeZmf3XA6zQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oG+dBbYCR2jnR5h5/1nvRrMGcQbqcLE3aYKuGECKRn5UyrmLQGvkJA9R9lFdViz8g
         DA2Pmh/foHPQIYhI3iwCGRs8PuC9e5F+9wMejul1RQ9i4sxRkFhTKyDfgt1a3B3oOT
         Y4pTD0HOO+c+taPYTGXiNxP9cPq/UQwDtqI3sSNIeAYG282xZAE6DliHCmwRrFOAtP
         FtoemgbUyGlo9tLz7kK8mHb/OADE6fTe9K7QFrVLKccD0dPx+YMZ3aUqcrWTJybMIw
         M5CFVfvYjU5dVj8VxycDutJhtBrsZEQneotZ2/g8opDsJ8nHObyP7MLgbPSEa35hgo
         /gKU084hFR0pw==
Date:   Thu, 11 Feb 2021 11:36:58 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     linux-rdma@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
Subject: Re: [PATCH for-next 2/4] RDMA/rtrs: Only allow addition of path to
 an already established session
Message-ID: <20210211093658.GE1275163@unreal>
References: <20210211065526.7510-1-jinpu.wang@cloud.ionos.com>
 <20210211065526.7510-3-jinpu.wang@cloud.ionos.com>
 <20210211084300.GB1275163@unreal>
 <CAMGffEnxs4NXODsYKyXyRvfUUwyF+bX_XO7JfA_pyFSawwo-fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEnxs4NXODsYKyXyRvfUUwyF+bX_XO7JfA_pyFSawwo-fQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 11, 2021 at 10:23:54AM +0100, Jinpu Wang wrote:
> On Thu, Feb 11, 2021 at 9:43 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Thu, Feb 11, 2021 at 07:55:24AM +0100, Jack Wang wrote:
> > > From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > >
> > > While adding a path from the client side to an already established
> > > session, it was possible to provide the destination IP to a different
> > > server. This is dangerous.
> > >
> > > This commit adds an extra member to the rtrs_msg_conn_req structure, named
> > > first_conn; which is supposed to notify if the connection request is the
> > > first for that session or not.
> > >
> > > On the server side, if a session does not exist but the first_conn
> > > received inside the rtrs_msg_conn_req structure is 1, the connection
> > > request is failed. This signifies that the connection request is for an
> > > already existing session, and since the server did not find one, it is an
> > > wrong connection request.
> > >
> > > Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
> > > Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> > > Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > > Reviewed-by: Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
> > > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > ---
> > >  drivers/infiniband/ulp/rtrs/rtrs-clt.c |  5 +++++
> > >  drivers/infiniband/ulp/rtrs/rtrs-clt.h |  1 +
> > >  drivers/infiniband/ulp/rtrs/rtrs-pri.h |  4 +++-
> > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 21 ++++++++++++++++-----
> > >  4 files changed, 25 insertions(+), 6 deletions(-)

<...>

> > >
> > >       mutex_lock(&ctx->srv_mutex);
> > >       list_for_each_entry(srv, &ctx->srv_list, ctx_list) {
> > > @@ -1346,12 +1348,20 @@ static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
> > >                       return srv;
> > >               }
> > >       }
> > > +     /*
> > > +      * If this request is not the first connection request from the
> > > +      * client for this session then fail and return error.
> > > +      */
> > > +     if (!first_conn) {
> > > +             err = -ENXIO;
> > > +             goto err;
> > > +     }
> >
> > Are you sure that this check not racy?
> I can't see how a function parameter check can be racy, can you elaborate?

get_or_create_srv() itself is protected with mutex_lock, but it can be called
in parallel by rtrs_rdma_connect(), this is why I asked.

Thanks

> >
> > Thanks
> Thanks for the review.!
> >
> > >
> > >       /* need to allocate a new srv */
> > >       srv = kzalloc(sizeof(*srv), GFP_KERNEL);
> > >       if  (!srv) {
> > >               mutex_unlock(&ctx->srv_mutex);
> > > -             return NULL;
> > > +             goto err;
> > >       }
> > >
> > >       INIT_LIST_HEAD(&srv->paths_list);
> > > @@ -1386,7 +1396,8 @@ static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
> > >
> > >  err_free_srv:
> > >       kfree(srv);
> > > -     return NULL;
> > > +err:
> > > +     return ERR_PTR(err);
> > >  }
> > >
> > >  static void put_srv(struct rtrs_srv *srv)
> > > @@ -1787,12 +1798,12 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
> > >               goto reject_w_econnreset;
> > >       }
> > >       recon_cnt = le16_to_cpu(msg->recon_cnt);
> > > -     srv = get_or_create_srv(ctx, &msg->paths_uuid);
> > > +     srv = get_or_create_srv(ctx, &msg->paths_uuid, msg->first_conn);
> > >       /*
> > >        * "refcount == 0" happens if a previous thread calls get_or_create_srv
> > >        * allocate srv, but chunks of srv are not allocated yet.
> > >        */
> > > -     if (!srv || refcount_read(&srv->refcount) == 0) {
> > > +     if (IS_ERR(srv) || refcount_read(&srv->refcount) == 0) {
> > >               err = -ENOMEM;
> > >               goto reject_w_err;
> > >       }
> > > --
> > > 2.25.1
> > >
