Return-Path: <linux-rdma+bounces-4330-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF9F94EB8E
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 13:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C4821C20356
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 11:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19F216C84C;
	Mon, 12 Aug 2024 11:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9ceQiXj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62602380
	for <linux-rdma@vger.kernel.org>; Mon, 12 Aug 2024 11:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723460464; cv=none; b=FFeGVIrdjFh9NUhYTM53lAfdfHog6NayMyqsLrIN01rRUfCtdqn4sGwOg/DwiCvFKrmzBuUe5405lYtqPTeVc8TtguAoZbnoxOM9G7+beKskELGcziAOaD0fwZwmesYS7J2tn/kZa5c+NQVeHBNEGu1cukRZRcy1KjpVeMNRzmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723460464; c=relaxed/simple;
	bh=cU0cGe1GGGNHM1tXkTQb6+WI8/1k/X7rKLziSD1qG8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upyvuYjY7YCzir7TZvRUDQeltfaGKqm3KJHyR4ONVRsEX1P6fKqtb/jxHfqkZYagF3h/PJwSu+9DbdstzeBG9AJMS/xsOtoU7B4Qv8VuBdEV/tY/VqtAwIqda+07jmq3NAMj20yxSUzH6SPsbOCzBYPwoMIUFD2FdzBXrYbFqkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9ceQiXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C034C32782;
	Mon, 12 Aug 2024 11:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723460463;
	bh=cU0cGe1GGGNHM1tXkTQb6+WI8/1k/X7rKLziSD1qG8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m9ceQiXjPeAFuHZy+5+cJbM0gCp6sfSnxqCe48UkgG/XKUYuu8OllmhZOOKJ8gUAD
	 B9CL6smlFkWM2I2S5ppj9uwUoXQM5Urf3fKXveuW/bxbHOCq1GAf/EDk10jQF+Fk7U
	 mcvlOJBhPX+FFCbdgDRrkQrdb+9C1Rpzjod0s0wwWwmCaDQ20G0tIeqsYt1xS3dMTJ
	 EJV8kHJVstdA+XqfD3AuUgPiCj6CKyDLvQT0wNA06nP242lXzuhcB+rqJ3+eaOFei+
	 Fvu9Rbhw2w4VwyBea7BPwyJlc8VFFAlp17KvSy5H3a+F6WeN8RptPZoYq9s9RbJjaw
	 rFmBr31cwK0AA==
Date: Mon, 12 Aug 2024 14:00:59 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jinpu Wang <jinpu.wang@ionos.com>
Cc: Md Haris Iqbal <haris.iqbal@ionos.com>, linux-rdma@vger.kernel.org,
	bvanassche@acm.org, jgg@ziepe.ca,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: Re: [PATCH for-next 02/13] RDMA/rtrs-srv: Fix use-after-free during
 session establishment
Message-ID: <20240812110059.GE12060@unreal>
References: <20240809131538.944907-1-haris.iqbal@ionos.com>
 <20240809131538.944907-3-haris.iqbal@ionos.com>
 <20240811084110.GC5925@unreal>
 <CAMGffEmvWLy4-ugYVPBLYAAe43xZ73=bp7sH5ackf6M7w2zdZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMGffEmvWLy4-ugYVPBLYAAe43xZ73=bp7sH5ackf6M7w2zdZg@mail.gmail.com>

On Mon, Aug 12, 2024 at 12:52:25PM +0200, Jinpu Wang wrote:
> Hi,
> 
> On Sun, Aug 11, 2024 at 10:41 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Fri, Aug 09, 2024 at 03:15:27PM +0200, Md Haris Iqbal wrote:
> > > From: Jack Wang <jinpu.wang@ionos.com>
> > >
> > > In case of error happening during session stablishment, close_work is
> > > running. A new RDMA CM event may arrive since we don't destroy cm_id
> > > before destroying qp. To fix this, we first destroy cm_id after drain_qp,
> > > so no new RDMA CM event will arrive afterwards.
> > >
> > > Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> > > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > > Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
> > > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > > ---
> > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
> > >  drivers/infiniband/ulp/rtrs/rtrs.c     | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > index fb67b58a7f62..90ea25ad6720 100644
> > > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > @@ -1540,6 +1540,7 @@ static void rtrs_srv_close_work(struct work_struct *work)
> > >               con = to_srv_con(srv_path->s.con[i]);
> > >               rdma_disconnect(con->c.cm_id);
> > >               ib_drain_qp(con->c.qp);
> > > +             rdma_destroy_id(con->c.cm_id);
> > >       }
> > >
> > >       /*
> > > @@ -1564,7 +1565,6 @@ static void rtrs_srv_close_work(struct work_struct *work)
> > >                       continue;
> > >               con = to_srv_con(srv_path->s.con[i]);
> > >               rtrs_cq_qp_destroy(&con->c);
> > > -             rdma_destroy_id(con->c.cm_id);
> > >               kfree(con);
> > >       }
> > >       rtrs_ib_dev_put(srv_path->s.dev);
> > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
> > > index 4e17d546d4cc..44167fd1c958 100644
> > > --- a/drivers/infiniband/ulp/rtrs/rtrs.c
> > > +++ b/drivers/infiniband/ulp/rtrs/rtrs.c
> > > @@ -318,7 +318,7 @@ EXPORT_SYMBOL_GPL(rtrs_cq_qp_create);
> > >  void rtrs_cq_qp_destroy(struct rtrs_con *con)
> > >  {
> > >       if (con->qp) {
> > > -             rdma_destroy_qp(con->cm_id);
> > > +             ib_destroy_qp(con->qp);
> >
> > You created that QP with rdma_create_qp() and you should destroy it with rdma_destroy_qp().
> We can't do it, as we move rdma_destroy_id before rtrs_cq_qp_destroy,
> if we still call rdma_destroy_qp, which will lead to use after free as
> cm_id could already be free-ed.

It is a hint that you are doing something wrong.

Thanks

> 
> >
> > Thanks
> Thx!
> >
> > >               con->qp = NULL;
> > >       }
> > >       destroy_cq(con);
> > > --
> > > 2.25.1
> > >
> 

