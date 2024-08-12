Return-Path: <linux-rdma+bounces-4332-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BD594EC94
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 14:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6632B28206B
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 12:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AF4178CE2;
	Mon, 12 Aug 2024 12:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5lVR1B6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75C9535DC
	for <linux-rdma@vger.kernel.org>; Mon, 12 Aug 2024 12:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464924; cv=none; b=oos5sV+LXlJUE+62Srb+9JnMKCmY1llf3w89GEM+GD2paD1qm0Fg6oEQv9NRS1HpyBzKVO1bnJNUx3w1fsilL915RzvVXCdlFNfFunTULZyC6285Q4cDTp0ZCjIKZexw9038kgmczp+HyyHHq1D8jQl39+EOK3OohqLAkjL+sVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464924; c=relaxed/simple;
	bh=Fhm9Jib5yWsNm9DwpInRjt2y3Oa1XVlciq0T6UweSbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEIADHE0p8Fhn4QUL7+Zw7P1ya0TqQm4preyDj/bgHUXM09tag5QExtrKq8kOGxlFi0uSZOFdoX9NQVL8sC6NgCBa1GL6WwOhPmhujf+E7dYUSBBjXoxO4D4zrJ1XOMGNRnA6o49FFCLhOl9EvjMZ9FIB0s3qFvcR8yUHT/MMw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5lVR1B6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DED2C32782;
	Mon, 12 Aug 2024 12:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723464924;
	bh=Fhm9Jib5yWsNm9DwpInRjt2y3Oa1XVlciq0T6UweSbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M5lVR1B6dJHGPhYBfOPPsIZjdQXiqVgraLXFW95QwSoc8QVY0letV5YZNtmiUnrIl
	 sdgGGpnaeFEDWnHIPgeWHTZoqGmKc81c3NWL1Qiq9H4xjIMR+Rz1T3I/O3KUPb038z
	 ahbTFLU3m3pFyOR1GgA4VdsI620liu+p6uKmxaU2nkm/s81tkEFjZOXxD3SI9faVFc
	 ownEp4zYTWiV1r50sKfDYix22OSinjZDWq1X/oQX3kQi5qNDuIRj7vYiAHQrqEqX/5
	 Q/YRIhJtQxy4oOuKDCPibTpJDoOw+gYfKF05HDc0s8GyDIkBtLzPkHViaMTxc2hIZl
	 gGov3ZP+UhxvQ==
Date: Mon, 12 Aug 2024 15:15:20 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Haris Iqbal <haris.iqbal@ionos.com>
Cc: linux-rdma@vger.kernel.org, bvanassche@acm.org, jgg@ziepe.ca,
	jinpu.wang@ionos.com,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: Re: [PATCH for-next 01/13] RDMA/rtrs-srv: Make rtrs_srv_open fail if
 its a second call
Message-ID: <20240812121520.GF12060@unreal>
References: <20240809131538.944907-1-haris.iqbal@ionos.com>
 <20240809131538.944907-2-haris.iqbal@ionos.com>
 <20240811083830.GB5925@unreal>
 <CAJpMwyjksJakyZVvf_jWwrnvbpV_T=jjAKgXG5k0ZCGyoZx_Rg@mail.gmail.com>
 <20240812103433.GC12060@unreal>
 <CAJpMwyjgNnCb4D8D_hHm5sQAzwLurPig=MzLdNtScVU2CzvMQA@mail.gmail.com>
 <20240812105942.GD12060@unreal>
 <CAJpMwyh7ytEawa=Yzg8CM=QZROvoBY70unhFvJdbAW9BU+xoUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJpMwyh7ytEawa=Yzg8CM=QZROvoBY70unhFvJdbAW9BU+xoUg@mail.gmail.com>

On Mon, Aug 12, 2024 at 01:17:11PM +0200, Haris Iqbal wrote:
> On Mon, Aug 12, 2024 at 12:59 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Mon, Aug 12, 2024 at 12:39:06PM +0200, Haris Iqbal wrote:
> > > On Mon, Aug 12, 2024 at 12:34 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > On Mon, Aug 12, 2024 at 12:16:19PM +0200, Haris Iqbal wrote:
> > > > > On Sun, Aug 11, 2024 at 10:38 AM Leon Romanovsky <leon@kernel.org> wrote:
> > > > > >
> > > > > > On Fri, Aug 09, 2024 at 03:15:26PM +0200, Md Haris Iqbal wrote:
> > > > > > > Do not allow opening RTRS server if it is already in use and print
> > > > > > > proper error message.
> > > > > >
> > > > > > 1. How is it even possible? I see only one call to rtrs_srv_open() and
> > > > > > it is happening when the driver is loaded.
> > > > >
> > > > > rtrs_srv_open() is NOT called during RTRS driver load. It is called
> > > > > during RNBD driver load, which is a client which uses RTRS.
> > > > > RTRS server currently works with only a single client. Hence if, while
> > > > > in use by RNBD, another driver wants to use RTRS and calls
> > > > > rtrs_srv_open(), it should fail.
> > > >
> > > > ➜  kernel git:(rdma-next) ✗ git grep rtrs_srv_open
> > > > drivers/block/rnbd/rnbd-srv.c:  rtrs_ctx = rtrs_srv_open(&rtrs_ops, port_nr); <---- SINGLE CALL
> > > > drivers/block/rnbd/rnbd-srv.c:          pr_err("rtrs_srv_open(), err: %pe\n", rtrs_ctx);
> > > > drivers/infiniband/ulp/rtrs/rtrs-srv.c: * rtrs_srv_open() - open RTRS server context
> > > > drivers/infiniband/ulp/rtrs/rtrs-srv.c:struct rtrs_srv_ctx *rtrs_srv_open(struct rtrs_srv_ops *ops, u16 port)
> > > > drivers/infiniband/ulp/rtrs/rtrs-srv.c:EXPORT_SYMBOL(rtrs_srv_open);
> > > > drivers/infiniband/ulp/rtrs/rtrs.h:struct rtrs_srv_ctx *rtrs_srv_open(struct rtrs_srv_ops *ops, u16 port);
> > > >
> > > >   807 static int __init rnbd_srv_init_module(void)
> > > >   808 {
> > > >   809         int err = 0;
> > > >   810
> > > >   811         BUILD_BUG_ON(sizeof(struct rnbd_msg_hdr) != 4);
> > > >   812         BUILD_BUG_ON(sizeof(struct rnbd_msg_sess_info) != 36);
> > > >   813         BUILD_BUG_ON(sizeof(struct rnbd_msg_sess_info_rsp) != 36);
> > > >   814         BUILD_BUG_ON(sizeof(struct rnbd_msg_open) != 264);
> > > >   815         BUILD_BUG_ON(sizeof(struct rnbd_msg_close) != 8);
> > > >   816         BUILD_BUG_ON(sizeof(struct rnbd_msg_open_rsp) != 56);
> > > >   817         rtrs_ops = (struct rtrs_srv_ops) {
> > > >   818                 .rdma_ev = rnbd_srv_rdma_ev,
> > > >   819                 .link_ev = rnbd_srv_link_ev,
> > > >   820         };
> > > >   821         rtrs_ctx = rtrs_srv_open(&rtrs_ops, port_nr);
> > > >   822         if (IS_ERR(rtrs_ctx)) {
> > > >   823                 pr_err("rtrs_srv_open(), err: %pe\n", rtrs_ctx);   <---- ALREADY PRINTED ERROR
> > > >   824                 return PTR_ERR(rtrs_ctx);
> > > >   825         }
> > > >
> > > >   ...
> > > >
> > > >   843 module_init(rnbd_srv_init_module); <---- SINGLE CALL
> > > >
> > > > Upstream code has only on RNBD and one RTRS.
> > >
> > > Yes. But they are different drivers. RTRS as a stand-alone ULP does
> > > not know about RNBD or for that matter any other client driver, which
> > > may use it, either out of tree or in the future. If RTRS can serve
> > > only a single client, then it should should have protection for
> > > multiple calls to *_open().
> >
> > For now, there is only one upstream client and server.
> 
> In my understanding, its the general rule of abstraction that this
> type of limitation is handled where it exists.

We have such protection and it is called "monolithic kernel".

> 
> >
> > I want to remind you that during initial submission of RTR code, the
> > feedback was that this ULP shouldn't exist in first place and right
> > thing to do it is to use NVMe over fabrics.
> >
> > So chances that we will have real out-of-tree client are very low.
> 
> One reason for us to write this patch is that we are working on
> another client which uses RTRS. We could have kept this change
> out-of-tree, but frankly, it felt right to add this protection.

So once you will have this client upstream, we can discuss this change.

Thanks

