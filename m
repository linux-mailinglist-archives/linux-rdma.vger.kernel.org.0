Return-Path: <linux-rdma+bounces-4325-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325A594EB3B
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 12:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2CA8282821
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 10:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C0116F0F0;
	Mon, 12 Aug 2024 10:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUAsU8Cn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352D616F0DC
	for <linux-rdma@vger.kernel.org>; Mon, 12 Aug 2024 10:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723458878; cv=none; b=LU1EflmRmweWRlKG9/EzhekvZaMNtQtjplW8bToD0hoet9+JvwfOX5mmHv/jHR2DH04WgC7jZILcBFhnSa9cSGobu6XyVOWSn7maukIqRJ01lFrwd7jZj5JI5ZTjfWxK3GCDd7hY4kEV9HGNIc5jbiPTN2T3Yia/X3BkPj1j6u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723458878; c=relaxed/simple;
	bh=gOOiEsVWkjrfqy5449BbYknhxD6qZwT06BWE9nvQ1BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWgTd1ceuhtVdcCiFcwVj2+YZPrj11SeRH4LAczAbRcNjP0Z/ZmaP7KnpwodTaZlFLj+3JyXr/vuUkP106CgkhMBtb49z+FjeB2iyRbPLaBfcUeZtilwo0S8P05pty6PubL6JegUeClqTpgRICy7MQ6/yo94mWl636q4j+xDm0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUAsU8Cn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236CAC4AF0F;
	Mon, 12 Aug 2024 10:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723458877;
	bh=gOOiEsVWkjrfqy5449BbYknhxD6qZwT06BWE9nvQ1BA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sUAsU8CnQDyv3eRgd1mYgNs6wSvdxs/P17SzZ5v279xDTVBIn7vgKhcxLfzbpTrLE
	 zE59qWPrA9SIjvJoPf07ha0ROxu8saxMi2HppSDEyeQwOcxqW0BagyxG/RPNiMHXYw
	 fF9cx4AovWxaWEhklYlQLmJuLaVfKNxn6N0UIKRWrKPx8BJu0BnKqdnQM6ce5ROQT6
	 UybzXjFP7HUWgRbKgq7jp7zJBXKC0yUFmRtTIm9rjroKHwKMg0lUs6VjAS6+mMtG7x
	 0HL77PFXmLKS8VcCbaZpBKezdqY2la+Wrl/B9+eRZmIuPPC/GPluqAiuACFfhEdsGi
	 4iMz4tR3P57Ig==
Date: Mon, 12 Aug 2024 13:34:33 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Haris Iqbal <haris.iqbal@ionos.com>
Cc: linux-rdma@vger.kernel.org, bvanassche@acm.org, jgg@ziepe.ca,
	jinpu.wang@ionos.com,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: Re: [PATCH for-next 01/13] RDMA/rtrs-srv: Make rtrs_srv_open fail if
 its a second call
Message-ID: <20240812103433.GC12060@unreal>
References: <20240809131538.944907-1-haris.iqbal@ionos.com>
 <20240809131538.944907-2-haris.iqbal@ionos.com>
 <20240811083830.GB5925@unreal>
 <CAJpMwyjksJakyZVvf_jWwrnvbpV_T=jjAKgXG5k0ZCGyoZx_Rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJpMwyjksJakyZVvf_jWwrnvbpV_T=jjAKgXG5k0ZCGyoZx_Rg@mail.gmail.com>

On Mon, Aug 12, 2024 at 12:16:19PM +0200, Haris Iqbal wrote:
> On Sun, Aug 11, 2024 at 10:38 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Fri, Aug 09, 2024 at 03:15:26PM +0200, Md Haris Iqbal wrote:
> > > Do not allow opening RTRS server if it is already in use and print
> > > proper error message.
> >
> > 1. How is it even possible? I see only one call to rtrs_srv_open() and
> > it is happening when the driver is loaded.
> 
> rtrs_srv_open() is NOT called during RTRS driver load. It is called
> during RNBD driver load, which is a client which uses RTRS.
> RTRS server currently works with only a single client. Hence if, while
> in use by RNBD, another driver wants to use RTRS and calls
> rtrs_srv_open(), it should fail.

➜  kernel git:(rdma-next) ✗ git grep rtrs_srv_open
drivers/block/rnbd/rnbd-srv.c:  rtrs_ctx = rtrs_srv_open(&rtrs_ops, port_nr); <---- SINGLE CALL
drivers/block/rnbd/rnbd-srv.c:          pr_err("rtrs_srv_open(), err: %pe\n", rtrs_ctx);
drivers/infiniband/ulp/rtrs/rtrs-srv.c: * rtrs_srv_open() - open RTRS server context
drivers/infiniband/ulp/rtrs/rtrs-srv.c:struct rtrs_srv_ctx *rtrs_srv_open(struct rtrs_srv_ops *ops, u16 port)
drivers/infiniband/ulp/rtrs/rtrs-srv.c:EXPORT_SYMBOL(rtrs_srv_open);
drivers/infiniband/ulp/rtrs/rtrs.h:struct rtrs_srv_ctx *rtrs_srv_open(struct rtrs_srv_ops *ops, u16 port);

  807 static int __init rnbd_srv_init_module(void)
  808 {
  809         int err = 0;
  810
  811         BUILD_BUG_ON(sizeof(struct rnbd_msg_hdr) != 4);
  812         BUILD_BUG_ON(sizeof(struct rnbd_msg_sess_info) != 36);
  813         BUILD_BUG_ON(sizeof(struct rnbd_msg_sess_info_rsp) != 36);
  814         BUILD_BUG_ON(sizeof(struct rnbd_msg_open) != 264);
  815         BUILD_BUG_ON(sizeof(struct rnbd_msg_close) != 8);
  816         BUILD_BUG_ON(sizeof(struct rnbd_msg_open_rsp) != 56);
  817         rtrs_ops = (struct rtrs_srv_ops) {
  818                 .rdma_ev = rnbd_srv_rdma_ev,
  819                 .link_ev = rnbd_srv_link_ev,
  820         };
  821         rtrs_ctx = rtrs_srv_open(&rtrs_ops, port_nr);
  822         if (IS_ERR(rtrs_ctx)) {
  823                 pr_err("rtrs_srv_open(), err: %pe\n", rtrs_ctx);   <---- ALREADY PRINTED ERROR
  824                 return PTR_ERR(rtrs_ctx);
  825         }

  ...

  843 module_init(rnbd_srv_init_module); <---- SINGLE CALL

Upstream code has only on RNBD and one RTRS.

Thanks


> 
> > 2. You already print an error message, why do you need to add another
> > one?
> 
> This patch adds only a single error print, in function
> rtrs_srv_open(). And it has not other print message. Am I missing
> something?
> 
> >
> > Thanks
> >
> > >
> > > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > > Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
> > > ---
> > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 27 +++++++++++++++++++++++---
> > >  drivers/infiniband/ulp/rtrs/rtrs-srv.h |  1 +
> > >  2 files changed, 25 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > index 1d33efb8fb03..fb67b58a7f62 100644
> > > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > @@ -2174,9 +2174,18 @@ struct rtrs_srv_ctx *rtrs_srv_open(struct rtrs_srv_ops *ops, u16 port)
> > >       struct rtrs_srv_ctx *ctx;
> > >       int err;
> > >
> > > +     mutex_lock(&ib_ctx.rtrs_srv_ib_mutex);
> > > +     if (ib_ctx.srv_ctx) {
> > > +             pr_err("%s: Already in use.\n", __func__);
> > > +             ctx = ERR_PTR(-EEXIST);
> > > +             goto out;
> > > +     }
> > > +
> > >       ctx = alloc_srv_ctx(ops);
> > > -     if (!ctx)
> > > -             return ERR_PTR(-ENOMEM);
> > > +     if (!ctx) {
> > > +             ctx = ERR_PTR(-ENOMEM);
> > > +             goto out;
> > > +     }
> > >
> > >       mutex_init(&ib_ctx.ib_dev_mutex);
> > >       ib_ctx.srv_ctx = ctx;
> > > @@ -2185,9 +2194,11 @@ struct rtrs_srv_ctx *rtrs_srv_open(struct rtrs_srv_ops *ops, u16 port)
> > >       err = ib_register_client(&rtrs_srv_client);
> > >       if (err) {
> > >               free_srv_ctx(ctx);
> > > -             return ERR_PTR(err);
> > > +             ctx = ERR_PTR(err);
> > >       }
> > >
> > > +out:
> > > +     mutex_unlock(&ib_ctx.rtrs_srv_ib_mutex);
> > >       return ctx;
> > >  }
> > >  EXPORT_SYMBOL(rtrs_srv_open);
> > > @@ -2221,10 +2232,16 @@ static void close_ctx(struct rtrs_srv_ctx *ctx)
> > >   */
> > >  void rtrs_srv_close(struct rtrs_srv_ctx *ctx)
> > >  {
> > > +     mutex_lock(&ib_ctx.rtrs_srv_ib_mutex);
> > > +     WARN_ON(ib_ctx.srv_ctx != ctx);
> > > +
> > >       ib_unregister_client(&rtrs_srv_client);
> > >       mutex_destroy(&ib_ctx.ib_dev_mutex);
> > >       close_ctx(ctx);
> > >       free_srv_ctx(ctx);
> > > +
> > > +     ib_ctx.srv_ctx = NULL;
> > > +     mutex_unlock(&ib_ctx.rtrs_srv_ib_mutex);
> > >  }
> > >  EXPORT_SYMBOL(rtrs_srv_close);
> > >
> > > @@ -2282,6 +2299,9 @@ static int __init rtrs_server_init(void)
> > >               goto out_dev_class;
> > >       }
> > >
> > > +     mutex_init(&ib_ctx.rtrs_srv_ib_mutex);
> > > +     ib_ctx.srv_ctx = NULL;
> > > +
> > >       return 0;
> > >
> > >  out_dev_class:
> > > @@ -2292,6 +2312,7 @@ static int __init rtrs_server_init(void)
> > >
> > >  static void __exit rtrs_server_exit(void)
> > >  {
> > > +     mutex_destroy(&ib_ctx.rtrs_srv_ib_mutex);
> > >       destroy_workqueue(rtrs_wq);
> > >       class_unregister(&rtrs_dev_class);
> > >       rtrs_rdma_dev_pd_deinit(&dev_pd);
> > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> > > index 5e325b82ff33..4924dde0a708 100644
> > > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> > > @@ -127,6 +127,7 @@ struct rtrs_srv_ib_ctx {
> > >       u16                     port;
> > >       struct mutex            ib_dev_mutex;
> > >       int                     ib_dev_count;
> > > +     struct mutex            rtrs_srv_ib_mutex;
> > >  };
> > >
> > >  extern const struct class rtrs_dev_class;
> > > --
> > > 2.25.1
> > >

