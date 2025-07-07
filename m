Return-Path: <linux-rdma+bounces-11917-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA1BAFABE9
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 08:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051521897998
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 06:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024F8279788;
	Mon,  7 Jul 2025 06:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBOzBpx+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57C6272811
	for <linux-rdma@vger.kernel.org>; Mon,  7 Jul 2025 06:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751869692; cv=none; b=HU8EBlwP/FyaNuuE9aT7KJmCws7GRspAfcQof6tpQXMERLrTcRcuiIZ1gPZiGti8QD6Yk6+es+149pJYL5TnWwgq19xciZJGZQCMA5PdXy6K1sAhNegKHIwjW9VLRfIb7R9IhYVd6J3k/3OlD2a9M1Z2VDfRIhIoT59wxAb+ZkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751869692; c=relaxed/simple;
	bh=cuyUgLGo5dWccM/rlFTV2uU6M6lVLnBX/+Ysj65empY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWJuzMVzSOSnQ66VHtwFTYjfbv+nj6Ky0w5a+/fYwPBUUxlsrFXmsMldmLBICKAsfjzQfSi2zbWa+qidW5oVyBB/ceap+hOPuvxHBjrlHniX1Qb0gFnR0ar0MqHc/wRupD8dp6uIxxsJjPqYanG919LJBtr0lPqT6w/VU2qEcrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBOzBpx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6135C4CEE3;
	Mon,  7 Jul 2025 06:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751869692;
	bh=cuyUgLGo5dWccM/rlFTV2uU6M6lVLnBX/+Ysj65empY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nBOzBpx+gv3HS6syluIkLtKUhJpRqi5zfH+BIfKIXgYorgnCRfgtfwVa9dxQ/K+gJ
	 3g6nAUhL84I0iFKsD0UmZMbHyPmP0bgD4oBV6L4s3mGuE+We6vwESDwfCXQrC7UHcX
	 ofsLm9Mmy8pxm4dVLfVbUnBZxbl7Ev61AiMu8pRxQJZhR9HlTbiDC3cXwdgtGwTnXG
	 /5aanPDFjbuz5Ike8/Vz7LregbBAfnxY1CM2FE/UpK2eCsOmuoGl8GcTmLvRSJhm8Y
	 4+LyjKse3bPwUDwdIFnOth+rhwaoNEt/5pw63ki5F6dtgqcoG2XBeePvtdfEF9SUo1
	 +BlU0cic03cZw==
Date: Mon, 7 Jul 2025 09:28:08 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Margolin, Michael" <mrgolin@amazon.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next v2] RDMA/efa: Extend admin timeout error print
Message-ID: <20250707062808.GT6278@unreal>
References: <20250703182314.16442-1-mrgolin@amazon.com>
 <20250706072523.GQ6278@unreal>
 <2ca6de0f-e3d7-4d11-affc-259fd9deff40@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ca6de0f-e3d7-4d11-affc-259fd9deff40@amazon.com>

On Sun, Jul 06, 2025 at 07:32:05PM +0300, Margolin, Michael wrote:
> 
> On 7/6/2025 10:25 AM, Leon Romanovsky wrote:
> > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> > 
> > 
> > 
> > On Thu, Jul 03, 2025 at 06:23:14PM +0000, Michael Margolin wrote:
> > >        reinit_completion(&comp_ctx->wait_event);
> > > 
> > > @@ -557,17 +559,19 @@ static int efa_com_wait_and_process_admin_cq_interrupts(struct efa_comp_ctx *com
> > >                if (comp_ctx->status == EFA_CMD_COMPLETED)
> > >                        ibdev_err_ratelimited(
> > >                                aq->efa_dev,
> > > -                             "The device sent a completion but the driver didn't receive any MSI-X interrupt for admin cmd %s(%d) status %d (ctx: 0x%p, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
> > > +                             "The device sent a completion but the driver didn't receive any MSI-X interrupt for admin cmd %s(%d) status %d (id: %d, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
> > >                                efa_com_cmd_str(comp_ctx->cmd_opcode),
> > >                                comp_ctx->cmd_opcode, comp_ctx->status,
> > > -                             comp_ctx, aq->sq.pc, aq->sq.cc, aq->cq.cc);
> > > +                             comp_ctx->cmd_id, aq->sq.pc, aq->sq.cc,
> > > +                             aq->cq.cc);
> > >                else
> > >                        ibdev_err_ratelimited(
> > >                                aq->efa_dev,
> > > -                             "The device didn't send any completion for admin cmd %s(%d) status %d (ctx 0x%p, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
> > > +                             "The device didn't send any completion for admin cmd %s(%d) status %d (id: %d, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
> > >                                efa_com_cmd_str(comp_ctx->cmd_opcode),
> > >                                comp_ctx->cmd_opcode, comp_ctx->status,
> > > -                             comp_ctx, aq->sq.pc, aq->sq.cc, aq->cq.cc);
> > > +                             comp_ctx->cmd_id, aq->sq.pc, aq->sq.cc,
> > > +                             aq->cq.cc);
> > I have very strong feeling that you don't really use these prints in real life.
> > 
> > For example, comp_ctx->cmd_id is printed with %d, while code and comment
> > around cmd_id in __efa_com_submit_admin_cmd() suggests that it needs to be 0x%X.
> > 
> > It has a lot of information separated to LSB and MSB bits which are not readable
> > while printing with %d.
> > 
> > You are also printing comp_ctx->status, which is clear from if/else section.
> > 
> > So no, I don't buy this claim for "additional debug information", while
> > existing is not used.
> 
> What do you mean by that?!?

If you take a close look on the prints, you will see the reasons.
For example, you print comp_ctx->status which can be only 0 or 1,
while it is already clear what its value from the print itself.

> 
> These errors are extremely rare and are not manually reproducible, that's
> why we want to collect as much information as we can when it happens.

Do it out-of-tree, there is no need in upstream code for internal debug
sessions.

> 
> I'm less bothered by the format as long as we have the info we need.

Like I said, it is clear that you never actually relied on this information.
Better if you completely delete these prints and keep them out-of-tree.

Thanks

> 
> 
> Michael
> 
> > 
> > Thanks
> > 

