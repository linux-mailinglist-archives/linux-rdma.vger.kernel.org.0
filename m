Return-Path: <linux-rdma+bounces-16002-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNlQNV7xdmmcZQEAu9opvQ
	(envelope-from <linux-rdma+bounces-16002-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 05:45:18 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E76483F34
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 05:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFBE93006B33
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 04:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE83230CDA9;
	Mon, 26 Jan 2026 04:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FtP+P/nw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E14A2BE643;
	Mon, 26 Jan 2026 04:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769402715; cv=none; b=Bc/v1Q3bckhOCcl7THUZzmiaVZCnADmNW6cpYcK7tryWea/5PKBeXhMO5702rgn6SEZja3Eb1pfaf4dO/+zEKsk+MKHB8GnY2G8IyMolUN3tWXkWKOr6j3K6A5NgjaeEO/GYo0mEiB5ac29f6GKrMwTekbo1AeDSlFctTfmzBJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769402715; c=relaxed/simple;
	bh=7JsM/gnRfDjeAFoXpMboMV0qznRqVcl8kGxzWzlrzLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtJ1N1Fl1Fmc+jGrJln5Uze6fo5Km9KKhotoIZbhjiYilJItzJ7HK+EQOkW6y9MMT8D53nGKFZvKG9YC6ihZESpAJ2lRgVgbQi8701Th+aumhWgGlFOJk2tBjiZqOdARbEy+8F38SI/UpzL72d85zXvae+TsN4kKRBvKN91CesY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FtP+P/nw; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769402702; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=qeRZ1JA5OEFGKF+6RQGHK7VQN10Ba7Jw8xgV9NzvLuw=;
	b=FtP+P/nw5fFT/78bsU0d0Bm+T57z/ReVz0NR7sY9x8rtIQGZ1UErynKEUqNu5Exe7FBwI9SbmOi3QvA5vqje/fxFf/yHKhYTXsAmPKKYyVa0ENswSNOChe2aoZDQH+muPtMaJoDdSEGQEUp4izFRT+iNksgIM2gdc9W7S8Fw2d8=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WxnZief_1769402701 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 26 Jan 2026 12:45:01 +0800
Date: Mon, 26 Jan 2026 12:45:01 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Leon Romanovsky <leon@kernel.org>
Cc: Liu Jian <liujian56@huawei.com>, alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com, sidraya@linux.ibm.com,
	wenjia@linux.ibm.com, mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org,
	guangguan.wang@linux.alibaba.com, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] net/smc: fix one NULL pointer dereference in
 smc_ib_is_sg_need_sync()
Message-ID: <20260126044501.GA18724@j66a10360.sqa.eu95>
References: <20250828124117.2622624-1-liujian56@huawei.com>
 <20250909094532.GD341237@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909094532.GD341237@unreal>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16002-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alibuda@linux.alibaba.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,linux.alibaba.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,j66a10360.sqa.eu95:mid]
X-Rspamd-Queue-Id: 4E76483F34
X-Rspamd-Action: no action

On Tue, Sep 09, 2025 at 12:45:32PM +0300, Leon Romanovsky wrote:
> On Thu, Aug 28, 2025 at 08:41:17PM +0800, Liu Jian wrote:
> > BUG: kernel NULL pointer dereference, address: 00000000000002ec
> > PGD 0 P4D 0
> > Oops: Oops: 0000 [#1] SMP PTI
> > CPU: 28 UID: 0 PID: 343 Comm: kworker/28:1 Kdump: loaded Tainted: G        OE       6.17.0-rc2+ #9 NONE
> > Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
> > Workqueue: smc_hs_wq smc_listen_work [smc]
> > RIP: 0010:smc_ib_is_sg_need_sync+0x9e/0xd0 [smc]
> > ...
> > Call Trace:
> >  <TASK>
> >  smcr_buf_map_link+0x211/0x2a0 [smc]
> >  __smc_buf_create+0x522/0x970 [smc]
> >  smc_buf_create+0x3a/0x110 [smc]
> >  smc_find_rdma_v2_device_serv+0x18f/0x240 [smc]
> >  ? smc_vlan_by_tcpsk+0x7e/0xe0 [smc]
> >  smc_listen_find_device+0x1dd/0x2b0 [smc]
> >  smc_listen_work+0x30f/0x580 [smc]
> >  process_one_work+0x18c/0x340
> >  worker_thread+0x242/0x360
> >  kthread+0xe7/0x220
> >  ret_from_fork+0x13a/0x160
> >  ret_from_fork_asm+0x1a/0x30
> >  </TASK>
> > 
> > If the software RoCE device is used, ibdev->dma_device is a null pointer.
> > As a result, the problem occurs. Null pointer detection is added to
> > prevent problems.
> > 
> > Fixes: 0ef69e788411c ("net/smc: optimize for smc_sndbuf_sync_sg_for_device and smc_rmb_sync_sg_for_cpu")
> > Signed-off-by: Liu Jian <liujian56@huawei.com>
> > ---
> > v1->v2:
> > move the check outside of loop.
> >  net/smc/smc_ib.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
> > index 53828833a3f7..a42ef3f77b96 100644
> > --- a/net/smc/smc_ib.c
> > +++ b/net/smc/smc_ib.c
> > @@ -742,6 +742,9 @@ bool smc_ib_is_sg_need_sync(struct smc_link *lnk,
> >  	unsigned int i;
> >  	bool ret = false;
> >  
> > +	if (!lnk->smcibdev->ibdev->dma_device)
> > +		return ret;
> 
> Please use ib_uses_virt_dma() function for that.
> 
> It is clearly stated in the code:
>   2784 struct ib_device {
>   2785         /* Do not access @dma_device directly from ULP nor from HW drivers. */
>   2786         struct device                *dma_device;     
> 
> Thanks
> 
>

Hi Leon,

Sorry for the late reply, I just noticed this and thank you for your review.
I agree completely with your feedback: we should not be accessing ibdev->dma_device
directly. Following your advice, replacing the

	if (!lnk->smcibdev->ibdev->dma_device)

check with ib_uses_virt_dma() is straightforward and absolutely the correct
thing to do for that part of the logic.

However, this has led me to a further challenge. The main purpose of the
smc_ib_is_sg_need_sync() function is to get the result of dma_need_sync().
This means that even after correctly using ib_uses_virt_dma(), the function
still needs to call dma_need_sync(ibdev->dma_device, ...), which forces us
right back into the direct access pattern we are trying to eliminate.

Since the RDMA doesn't currently offer a helper for this "check" functionality,
I'd like to propose adding one. What are your thoughts on a new helper like
the one below, which would allow us to solve this cleanly?

/* ib_verbs.h */
static inline bool ib_dma_need_sync(struct ib_device *dev, dma_addr_t dma_addr) {
	return !ib_uses_virt_dma(dev) && dma_need_sync(dev->dma_device, dma_addr);
}

Best wishes,
D. Wythe


