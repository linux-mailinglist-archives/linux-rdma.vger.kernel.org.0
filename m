Return-Path: <linux-rdma+bounces-16132-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJLsF8HxeWnT1AEAu9opvQ
	(envelope-from <linux-rdma+bounces-16132-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:23:45 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 099B9A0436
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B76A7301DB99
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 11:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DDC33DEF7;
	Wed, 28 Jan 2026 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4Nq8o3f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3E02D9EDC;
	Wed, 28 Jan 2026 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599286; cv=none; b=W02BX7768GpeVQ1eEO6/26kCIGhiLJt7lSCkXbs+vdESMeFaUzuz1Gr6UY5rz0SrrMuvvjuoCkcWIlcFAFEgSyC0+L9HKsP99MTHj1ya3ieS8IuAp46slUaegcNYuXPlv16cMoX8zpLUZVktbYFn1GX1ZcDivnbItbZXRHCftnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599286; c=relaxed/simple;
	bh=RcNC7ajtZO93y2kR8qbqgL3LBjq5vZlEqWbWUZ97gFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9ZZRlXnk2fOylQYZVLcMfDHXMtOTAIj7BoG7CShq72WP8QUH6aDtFhM4jHMp4sUnUbpvtRyKQJdpRYISoTdp662QzispAqISs0KE8ekiIBCb35MxGMwand2bGqpsBLDwpNxgmVJCAd9hm0vQOGXt5G5+V2uyrv7VZf7eGIeDaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4Nq8o3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B68EC4CEF1;
	Wed, 28 Jan 2026 11:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769599285;
	bh=RcNC7ajtZO93y2kR8qbqgL3LBjq5vZlEqWbWUZ97gFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b4Nq8o3fCXx0FDgmtXIfNAjrlw/nomtT4FV+RlBYv5vJDcqQpEsAVC+IDaUThfD54
	 T0kdfd+QLrQMW8Wyw6HzovMb8kBxSSFuR+5mNa/9rVNgeMyDHf7rGcL8a41k4dcg74
	 p+eSk7FT3kkn2/gJffltIHbl9ScxFdkNATA4HRA67q9UIk4GLTAcUfmH9tvfuwbw8U
	 OOkCn7IuljSE3NZP/87ZexqP9pB2/3Str2phSo6CkBAODgdy3uQ4VMuHTGLWyfY9u/
	 rX+fr7UjGRYm0s//GQUMkkh3RbtvPgEOfL1yGYSQlLRi5zRXZfVazXnBiax/aH3qJr
	 MkafyUnlhMEkA==
Date: Wed, 28 Jan 2026 13:21:22 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Liu Jian <liujian56@huawei.com>, dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com, wenjia@linux.ibm.com, mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org,
	guangguan.wang@linux.alibaba.com, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH net v2] net/smc: fix one NULL pointer dereference in
 smc_ib_is_sg_need_sync()
Message-ID: <20260128112122.GE12149@unreal>
References: <20250828124117.2622624-1-liujian56@huawei.com>
 <20250909094532.GD341237@unreal>
 <20260126044501.GA18724@j66a10360.sqa.eu95>
 <20260127120004.GT13967@unreal>
 <20260128055051.GA79132@j66a10360.sqa.eu95>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260128055051.GA79132@j66a10360.sqa.eu95>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16132-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email]
X-Rspamd-Queue-Id: 099B9A0436
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 01:50:51PM +0800, D. Wythe wrote:
> On Tue, Jan 27, 2026 at 02:00:04PM +0200, Leon Romanovsky wrote:
> > On Mon, Jan 26, 2026 at 12:45:01PM +0800, D. Wythe wrote:
> > > On Tue, Sep 09, 2025 at 12:45:32PM +0300, Leon Romanovsky wrote:
> > > > On Thu, Aug 28, 2025 at 08:41:17PM +0800, Liu Jian wrote:
> > > > > BUG: kernel NULL pointer dereference, address: 00000000000002ec
> > > > > PGD 0 P4D 0
> > > > > Oops: Oops: 0000 [#1] SMP PTI
> > > > > CPU: 28 UID: 0 PID: 343 Comm: kworker/28:1 Kdump: loaded Tainted: G        OE       6.17.0-rc2+ #9 NONE
> > > > > Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> > > > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
> > > > > Workqueue: smc_hs_wq smc_listen_work [smc]
> > > > > RIP: 0010:smc_ib_is_sg_need_sync+0x9e/0xd0 [smc]
> > > > > ...
> > > > > Call Trace:
> > > > >  <TASK>
> > > > >  smcr_buf_map_link+0x211/0x2a0 [smc]
> > > > >  __smc_buf_create+0x522/0x970 [smc]
> > > > >  smc_buf_create+0x3a/0x110 [smc]
> > > > >  smc_find_rdma_v2_device_serv+0x18f/0x240 [smc]
> > > > >  ? smc_vlan_by_tcpsk+0x7e/0xe0 [smc]
> > > > >  smc_listen_find_device+0x1dd/0x2b0 [smc]
> > > > >  smc_listen_work+0x30f/0x580 [smc]
> > > > >  process_one_work+0x18c/0x340
> > > > >  worker_thread+0x242/0x360
> > > > >  kthread+0xe7/0x220
> > > > >  ret_from_fork+0x13a/0x160
> > > > >  ret_from_fork_asm+0x1a/0x30
> > > > >  </TASK>
> > > > > 
> > > > > If the software RoCE device is used, ibdev->dma_device is a null pointer.
> > > > > As a result, the problem occurs. Null pointer detection is added to
> > > > > prevent problems.
> > > > > 
> > > > > Fixes: 0ef69e788411c ("net/smc: optimize for smc_sndbuf_sync_sg_for_device and smc_rmb_sync_sg_for_cpu")
> > > > > Signed-off-by: Liu Jian <liujian56@huawei.com>
> > > > > ---
> > > > > v1->v2:
> > > > > move the check outside of loop.
> > > > >  net/smc/smc_ib.c | 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > > 
> > > > > diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
> > > > > index 53828833a3f7..a42ef3f77b96 100644
> > > > > --- a/net/smc/smc_ib.c
> > > > > +++ b/net/smc/smc_ib.c
> > > > > @@ -742,6 +742,9 @@ bool smc_ib_is_sg_need_sync(struct smc_link *lnk,
> > > > >  	unsigned int i;
> > > > >  	bool ret = false;
> > > > >  
> > > > > +	if (!lnk->smcibdev->ibdev->dma_device)
> > > > > +		return ret;
> > > > 
> > > > Please use ib_uses_virt_dma() function for that.
> > > > 
> > > > It is clearly stated in the code:
> > > >   2784 struct ib_device {
> > > >   2785         /* Do not access @dma_device directly from ULP nor from HW drivers. */
> > > >   2786         struct device                *dma_device;     
> > > > 
> > > > Thanks
> > > > 
> > > >
> > > 
> > > Hi Leon,
> > > 
> > > Sorry for the late reply, I just noticed this and thank you for your review.
> > > I agree completely with your feedback: we should not be accessing ibdev->dma_device
> > > directly. Following your advice, replacing the
> > > 
> > > 	if (!lnk->smcibdev->ibdev->dma_device)
> > > 
> > > check with ib_uses_virt_dma() is straightforward and absolutely the correct
> > > thing to do for that part of the logic.
> > > 
> > > However, this has led me to a further challenge. The main purpose of the
> > > smc_ib_is_sg_need_sync() function is to get the result of dma_need_sync().
> > > This means that even after correctly using ib_uses_virt_dma(), the function
> > > still needs to call dma_need_sync(ibdev->dma_device, ...), which forces us
> > > right back into the direct access pattern we are trying to eliminate.
> > 
> > I would like to challenge the use of dma_need_sync() in smc_ib.c. From
> > what I see, it is used to avoid calls to dma_sync_single_*_device()
> > which will be NOP anyway in that case.
> > 
> > Why did you copy that logic from XSK?
> > 
> 
> You are right. I just noticed that the DMA has already introduced a
> similar optimization.
> 
> The check in SMC was added back in 2022, while the DMA introduced
> the internal "skip redundant sync" mechanism in 2024 (commit f406c8e4b770).
> 
> Given this, it might be better to simply remove this redundant check
> from SMC now, which would also eliminate the need for direct access to
> ibdev->dma_device. I need to perform some tests to confirm this.

It may also be worth looking at this series from Chuck, which reuses the
recently introduced DMA API to remove the SG conversions:
https://lore.kernel.org/linux-rdma/20260128005400.25147-1-cel@kernel.org/

You might be able to apply a similar approach and drop SG from your
datapath entirely.

Thanks.

> 
> Thanks for your feedback.
> 
> D. Wythe
> 
> > > 
> > > Since the RDMA doesn't currently offer a helper for this "check" functionality,
> > > I'd like to propose adding one. What are your thoughts on a new helper like
> > > the one below, which would allow us to solve this cleanly?
> > > 
> > > /* ib_verbs.h */
> > > static inline bool ib_dma_need_sync(struct ib_device *dev, dma_addr_t dma_addr) {
> > > 	return !ib_uses_virt_dma(dev) && dma_need_sync(dev->dma_device, dma_addr);
> > > }
> > 
> > If we're discussing wrappers, it's likely better to provide a wrapper around
> > dma_sync_sg_for_cpu() for use in ib_dma_sync_sg_for_cpu(), rather than
> > open‑coding the logic.
> > 
> > Thanks
> > 
> > > 
> > > Best wishes,
> > > D. Wythe
> > > 
> > > 
> 

