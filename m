Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06FD378E9F
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 15:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240765AbhEJNXE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 09:23:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238555AbhEJMEx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 May 2021 08:04:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49E3C613C9;
        Mon, 10 May 2021 12:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620648229;
        bh=9p8/RYbvAocSpDtHOSLSZEbVEdvuYQd7rFMrobHfCic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sleeKqJHlh6XKxqXUsE6XV0cIF+9NJp/m/B9bSIgW+YpcWBiRh4nf0ing2dW+fmQE
         lRGMUUA+InxqcGruHkCtqkrM0oWb/sANSspLQ3GFHmF335LPlRTLqZDZNkeeRMJIc1
         qEAmLPCQVc6B5txXwk6dWKYd91gBNYtiLTcvmSJaRWNm4At8MSkkmXDuccug8b2/fy
         21MncXtCH2WZy5bjAc4lAIiGa0qRX+bkS2uNsrN0Dp2NIKECcks+YvzgSiGwVxJo1d
         hjDVbLHxCushXGhfakycFrldjC8qAV/HocZHarJUNn0xnhDJ7TLtSm822mk/+kJzNi
         JZqy93er/b1CA==
Date:   Mon, 10 May 2021 15:03:45 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Haris Iqbal <haris.iqbal@ionos.com>
Cc:     Gioh Kim <gi-oh.kim@ionos.com>, linux-rdma@vger.kernel.org,
        bvanassche@acm.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: Re: [PATCH for-next 04/20] RDMA/rtrs-srv: Add error messages for
 cases when failing RDMA connection
Message-ID: <YJkhIcw4xMfd9Dgm@unreal>
References: <20210503114818.288896-1-gi-oh.kim@ionos.com>
 <20210503114818.288896-5-gi-oh.kim@ionos.com>
 <YJfHDvkc4BK7plTK@unreal>
 <CAJpMwygX36AhWH=_qCAPzcHh4BSLL6eA_1Tw0J6Sa25k9qg7Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJpMwygX36AhWH=_qCAPzcHh4BSLL6eA_1Tw0J6Sa25k9qg7Mw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 10, 2021 at 12:55:42PM +0200, Haris Iqbal wrote:
> On Sun, May 9, 2021 at 1:27 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Mon, May 03, 2021 at 01:48:02PM +0200, Gioh Kim wrote:
> > > From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > >
> > > It was difficult to find out why it failed to establish RDMA
> > > connection. This patch adds some messages to show which function
> > > has failed why.
> > >
> > > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> > > ---
> > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > index 3d09d01e34b4..df17dd4c1e28 100644
> > > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > @@ -1356,8 +1356,10 @@ static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
> > >        * If this request is not the first connection request from the
> > >        * client for this session then fail and return error.
> > >        */
> > > -     if (!first_conn)
> > > +     if (!first_conn) {
> > > +             pr_err("Error: Not the first connection request for this session\n");
> > >               return ERR_PTR(-ENXIO);
> > > +     }
> > >
> > >       /* need to allocate a new srv */
> > >       srv = kzalloc(sizeof(*srv), GFP_KERNEL);
> > > @@ -1812,6 +1814,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
> > >       srv = get_or_create_srv(ctx, &msg->paths_uuid, msg->first_conn);
> > >       if (IS_ERR(srv)) {
> > >               err = PTR_ERR(srv);
> > > +             pr_err("get_or_create_srv(), error %d\n", err);
> > >               goto reject_w_err;
> > >       }
> > >       mutex_lock(&srv->paths_mutex);
> > > @@ -1850,11 +1853,13 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
> > >                       mutex_unlock(&srv->paths_mutex);
> > >                       put_srv(srv);
> > >                       err = PTR_ERR(sess);
> > > +                     pr_err("RTRS server session allocation failed: %d\n", err);
> > >                       goto reject_w_err;
> > >               }
> > >       }
> > >       err = create_con(sess, cm_id, cid);
> > >       if (err) {
> > > +             rtrs_err((&sess->s), "create_con(), error %d\n", err);
> > >               (void)rtrs_rdma_do_reject(cm_id, err);
> >
> > Unrelated to this change, but this (void) casting should be go.
> 
> Hi Leon
> 
> We wanted to explicitly signal that the code is ignoring the return
> value of the function. Is there a strong reason for the casting to be
> removed?

"Don't write useless code and don't assume that the kernel developers
are first year college students" - is this strong enough reason for you?

Your (void) casting doesn't give anything extra, just churn and even
more suspicious review over such code.

Thanks
