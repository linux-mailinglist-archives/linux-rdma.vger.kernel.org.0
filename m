Return-Path: <linux-rdma+bounces-11921-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF27AFB132
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 12:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE43817CCF3
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 10:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9508028A1CF;
	Mon,  7 Jul 2025 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPFJMWao"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5609621D583
	for <linux-rdma@vger.kernel.org>; Mon,  7 Jul 2025 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751884115; cv=none; b=ldTpWXBkQvRfI1xGAP0XIzPzIvRyGRsc0LXfo48PooZ6kkoc4BA1I7ItG+uA/WcFFQ2Q3ZHxhwcKr3XRBVdrukBFDLnEYO24ewy2Txa2bFPEqaglY8v7L6yBHwfh0MHXZTVoK0hDlSbTTHto8nTij3WYqao6zgYNou8qbwO6kyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751884115; c=relaxed/simple;
	bh=LHQ6woZPJ3BvkV8nC9eqBcZ4zZmy7EJcWxn2JK2fKLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmJ0dPRteSSF7SgpURgd/a41v9MOZ7Nomx+IYRk+6mxsFqwcZ6DrfgE39HqpcObW18MslmT969PXrerwQ5VYXmkRRfztSlqEM89jcZ/tqCkty3cq/ZJ204fosOBpUaXf1TITf6+dbt7Vpsav36T8x75PKYMHC5MhexYgMPcjdrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPFJMWao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CEC6C4CEE3;
	Mon,  7 Jul 2025 10:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751884114;
	bh=LHQ6woZPJ3BvkV8nC9eqBcZ4zZmy7EJcWxn2JK2fKLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EPFJMWaoAmqNaKTlKOQPsi2KkODyqiEuoM57J0o5rmOCvnCgR6H88edM1v9eIJ3y9
	 2HIyAi29iRMno7ZZGt9LlTMxxvO5Q9dz2S27egO1f7HA+j7EE1KfLi19c/+lH1Ee1z
	 GS+QcZ5oInpdPAcHFZWiJt/L/VOyIg3iv2m6/XX46c5gWpzp7J7N1gB9bATe1D7F16
	 7ERjft8W9QOYwc2UiM+SI8gwKjvEb7QnNeKBcww1uTP4yjRQfWqb+Crt0C6fqQoGzx
	 4Le1GcfVx/dyv3qQ49kRqiECSAOp7Xh/UVa787ElvZwn4+qXEOSWIGbneOcNZ7+5qm
	 jDOS+czlKofaQ==
Date: Mon, 7 Jul 2025 13:28:30 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Margolin, Michael" <mrgolin@amazon.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next v2] RDMA/efa: Extend admin timeout error print
Message-ID: <20250707102830.GV6278@unreal>
References: <20250703182314.16442-1-mrgolin@amazon.com>
 <20250706072523.GQ6278@unreal>
 <2ca6de0f-e3d7-4d11-affc-259fd9deff40@amazon.com>
 <20250707062808.GT6278@unreal>
 <f8fc9034-41b4-4b2f-8032-1bc9d2bcdb99@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8fc9034-41b4-4b2f-8032-1bc9d2bcdb99@amazon.com>

On Mon, Jul 07, 2025 at 12:51:40PM +0300, Margolin, Michael wrote:
> 
> On 7/7/2025 9:28 AM, Leon Romanovsky wrote:
> > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> > 
> > 
> > 
> > On Sun, Jul 06, 2025 at 07:32:05PM +0300, Margolin, Michael wrote:
> > > On 7/6/2025 10:25 AM, Leon Romanovsky wrote:
> > > > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> > > > 
> > > > 
> > > > 
> > > > On Thu, Jul 03, 2025 at 06:23:14PM +0000, Michael Margolin wrote:
> > > > >         reinit_completion(&comp_ctx->wait_event);
> > > > > 
> > > > > @@ -557,17 +559,19 @@ static int efa_com_wait_and_process_admin_cq_interrupts(struct efa_comp_ctx *com
> > > > >                 if (comp_ctx->status == EFA_CMD_COMPLETED)
> > > > >                         ibdev_err_ratelimited(
> > > > >                                 aq->efa_dev,
> > > > > -                             "The device sent a completion but the driver didn't receive any MSI-X interrupt for admin cmd %s(%d) status %d (ctx: 0x%p, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
> > > > > +                             "The device sent a completion but the driver didn't receive any MSI-X interrupt for admin cmd %s(%d) status %d (id: %d, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
> > > > >                                 efa_com_cmd_str(comp_ctx->cmd_opcode),
> > > > >                                 comp_ctx->cmd_opcode, comp_ctx->status,
> > > > > -                             comp_ctx, aq->sq.pc, aq->sq.cc, aq->cq.cc);
> > > > > +                             comp_ctx->cmd_id, aq->sq.pc, aq->sq.cc,
> > > > > +                             aq->cq.cc);
> > > > >                 else
> > > > >                         ibdev_err_ratelimited(
> > > > >                                 aq->efa_dev,
> > > > > -                             "The device didn't send any completion for admin cmd %s(%d) status %d (ctx 0x%p, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
> > > > > +                             "The device didn't send any completion for admin cmd %s(%d) status %d (id: %d, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
> > > > >                                 efa_com_cmd_str(comp_ctx->cmd_opcode),
> > > > >                                 comp_ctx->cmd_opcode, comp_ctx->status,
> > > > > -                             comp_ctx, aq->sq.pc, aq->sq.cc, aq->cq.cc);
> > > > > +                             comp_ctx->cmd_id, aq->sq.pc, aq->sq.cc,
> > > > > +                             aq->cq.cc);
> > > > I have very strong feeling that you don't really use these prints in real life.
> > > > 
> > > > For example, comp_ctx->cmd_id is printed with %d, while code and comment
> > > > around cmd_id in __efa_com_submit_admin_cmd() suggests that it needs to be 0x%X.
> > > > 
> > > > It has a lot of information separated to LSB and MSB bits which are not readable
> > > > while printing with %d.
> > > > 
> > > > You are also printing comp_ctx->status, which is clear from if/else section.
> > > > 
> > > > So no, I don't buy this claim for "additional debug information", while
> > > > existing is not used.
> > > What do you mean by that?!?
> > If you take a close look on the prints, you will see the reasons.
> > For example, you print comp_ctx->status which can be only 0 or 1,
> > while it is already clear what its value from the print itself.
> > 
> > > These errors are extremely rare and are not manually reproducible, that's
> > > why we want to collect as much information as we can when it happens.
> > Do it out-of-tree, there is no need in upstream code for internal debug
> > sessions.
> 
> It's not for internal debug, it is used in production. Why would I upstream
> internal debug prints?

It is used in internal cloud for the NICs not available to the rest of
the world. So yes, it is your internal debug print.

> 
> > > I'm less bothered by the format as long as we have the info we need.
> > Like I said, it is clear that you never actually relied on this information.
> > Better if you completely delete these prints and keep them out-of-tree.
> 
> Not sure that I follow, can you please elaborate on what "relying" means
> from your POV?

"relied" == "used"

> 
> Michael
> 

