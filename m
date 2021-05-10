Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14616378EAF
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 15:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240825AbhEJNXJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 09:23:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344877AbhEJMUu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 May 2021 08:20:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43B33613EE;
        Mon, 10 May 2021 12:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620649186;
        bh=QCdW+nkSeJFNMUSJY4+5i12O755R83pH8nPUoWHgQeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rei8RKaQTeoKstH7Z3ptMvHtcKOICTvM8QuPLf9jSYotHo8U8KG8fbYg8riwIwmzK
         yve1xETbbc3kHJGIVVophavAWHxFXgrz6tDb1iwKiL4MNHTBgKjXuuEkyVc9YEpCf3
         Hi1Y5TdAxI1Eh/SUpTXvVxFODPhsyyTR0pqyrx6PDmmaTbJXMgbY5Ud2bAobS9Mg2p
         r+XrNtKtLjBIXGqXEK8mXl0SPIjblGy9VR/w0tnw+Xf5A4PUUwl/ePmYNdjON5fn0d
         9hN498sK/0DT9zhQYjEY4gjBY6pBIIerdzJPOG3MknWYVyVPFKM+Yg/RW1mKMWSpYY
         zwwg2eAWj72bw==
Date:   Mon, 10 May 2021 15:19:42 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Haris Iqbal <haris.iqbal@ionos.com>
Cc:     Gioh Kim <gi-oh.kim@ionos.com>, linux-rdma@vger.kernel.org,
        bvanassche@acm.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: Re: [PATCH for-next 04/20] RDMA/rtrs-srv: Add error messages for
 cases when failing RDMA connection
Message-ID: <YJkk3lihskAtbBIv@unreal>
References: <20210503114818.288896-1-gi-oh.kim@ionos.com>
 <20210503114818.288896-5-gi-oh.kim@ionos.com>
 <YJfHDvkc4BK7plTK@unreal>
 <CAJpMwygX36AhWH=_qCAPzcHh4BSLL6eA_1Tw0J6Sa25k9qg7Mw@mail.gmail.com>
 <YJkhIcw4xMfd9Dgm@unreal>
 <CAJpMwyjhtNQ+k2NUa7iuDSde_XdG4fBSaxyOuB9jmur013F+1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJpMwyjhtNQ+k2NUa7iuDSde_XdG4fBSaxyOuB9jmur013F+1w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 10, 2021 at 02:16:02PM +0200, Haris Iqbal wrote:
> On Mon, May 10, 2021 at 2:03 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Mon, May 10, 2021 at 12:55:42PM +0200, Haris Iqbal wrote:
> > > On Sun, May 9, 2021 at 1:27 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > On Mon, May 03, 2021 at 01:48:02PM +0200, Gioh Kim wrote:
> > > > > From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > > > >
> > > > > It was difficult to find out why it failed to establish RDMA
> > > > > connection. This patch adds some messages to show which function
> > > > > has failed why.
> > > > >
> > > > > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > > > > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > > > > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> > > > > ---
> > > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 8 +++++++-
> > > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > > index 3d09d01e34b4..df17dd4c1e28 100644
> > > > > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > > @@ -1356,8 +1356,10 @@ static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
> > > > >        * If this request is not the first connection request from the
> > > > >        * client for this session then fail and return error.
> > > > >        */
> > > > > -     if (!first_conn)
> > > > > +     if (!first_conn) {
> > > > > +             pr_err("Error: Not the first connection request for this session\n");
> > > > >               return ERR_PTR(-ENXIO);
> > > > > +     }
> > > > >
> > > > >       /* need to allocate a new srv */
> > > > >       srv = kzalloc(sizeof(*srv), GFP_KERNEL);
> > > > > @@ -1812,6 +1814,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
> > > > >       srv = get_or_create_srv(ctx, &msg->paths_uuid, msg->first_conn);
> > > > >       if (IS_ERR(srv)) {
> > > > >               err = PTR_ERR(srv);
> > > > > +             pr_err("get_or_create_srv(), error %d\n", err);
> > > > >               goto reject_w_err;
> > > > >       }
> > > > >       mutex_lock(&srv->paths_mutex);
> > > > > @@ -1850,11 +1853,13 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
> > > > >                       mutex_unlock(&srv->paths_mutex);
> > > > >                       put_srv(srv);
> > > > >                       err = PTR_ERR(sess);
> > > > > +                     pr_err("RTRS server session allocation failed: %d\n", err);
> > > > >                       goto reject_w_err;
> > > > >               }
> > > > >       }
> > > > >       err = create_con(sess, cm_id, cid);
> > > > >       if (err) {
> > > > > +             rtrs_err((&sess->s), "create_con(), error %d\n", err);
> > > > >               (void)rtrs_rdma_do_reject(cm_id, err);
> > > >
> > > > Unrelated to this change, but this (void) casting should be go.
> > >
> > > Hi Leon
> > >
> > > We wanted to explicitly signal that the code is ignoring the return
> > > value of the function. Is there a strong reason for the casting to be
> > > removed?
> >
> > "Don't write useless code and don't assume that the kernel developers
> > are first year college students" - is this strong enough reason for you?
> 
> I am all for simple and minimum code; but this casting does have a
> decent reason.
> 
> Anyway if the RDMA code style calls for this to be removed; will
> remove them in a separate patch and send out with the next batch of
> patches.

Yes, please, we prefer proper APIs that don't require any special
comments to use them.

Thanks

> 
> >
> > Your (void) casting doesn't give anything extra, just churn and even
> > more suspicious review over such code.
> >
> > Thanks
