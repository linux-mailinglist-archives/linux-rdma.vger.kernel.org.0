Return-Path: <linux-rdma+bounces-12988-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F72FB3B1A9
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Aug 2025 05:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7E695843AC
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Aug 2025 03:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD8322422B;
	Fri, 29 Aug 2025 03:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AjIzwqyd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FCC21D3F0;
	Fri, 29 Aug 2025 03:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756438357; cv=none; b=Fpht/hNySmqGjDdf+dYJW3rGO4f7r7h8LHpjc7flw/xBtdjAXiWqg058t+fspe9BbFz/sX61ePUTDUEf90Tj2wOa0BjEyyF1R/16Q2Qtcr1EwrGEWSmmPtDUC5RDsyb3CL3P8jxZgGw86udtXTYM4ns/gsd78xzG/wsz5/tcfMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756438357; c=relaxed/simple;
	bh=jUQbrcsjNBjt3pe3d9ipZTkMsmGGOJYkz9OYPhBGfCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZ2LlsJwTdxvhcJJQGltjLAyKynRfpOYfxrbA3jHQHP3rkR0mLp6xY5HGIur41iBHzu3MeeKFvQe4Tc7wZpzToMsg1tmRIVRKsuNpALRk5a/LvkqvFh0q9W33EfpROBWjePtdj/42w1BM6lRS3calulBdaTGGlj5a54pmNl+A6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AjIzwqyd; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756438345; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=JwkaZtdeycipElvzrMbmePNoAaY3D32TdQvKDMK/Sv0=;
	b=AjIzwqydb1SO63NLOvrkMPCVloJqXfwV95OhquPP4FHubwbZ00Vs9i55OZ+5HF/xHg8ls6s7ma50yv/D4e7iefn2aMIAATgITSYBCOljGzoxzG4sdvcaCdUzBroRw0D31LG63tEM8jIRKaAL9ec69E+T7s1Sf5fz611+kV1bh6g=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0Wmq001h_1756438344 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 29 Aug 2025 11:32:25 +0800
Date: Fri, 29 Aug 2025 11:32:24 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Liu Jian <liujian56@huawei.com>
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com, wenjia@linux.ibm.com, mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org,
	guangguan.wang@linux.alibaba.com, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] net/smc: fix one NULL pointer dereference in
 smc_ib_is_sg_need_sync()
Message-ID: <20250829033224.GA96384@j66a10360.sqa.eu95>
References: <20250828124117.2622624-1-liujian56@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828124117.2622624-1-liujian56@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Aug 28, 2025 at 08:41:17PM +0800, Liu Jian wrote:
> BUG: kernel NULL pointer dereference, address: 00000000000002ec
> PGD 0 P4D 0
> Oops: Oops: 0000 [#1] SMP PTI
> CPU: 28 UID: 0 PID: 343 Comm: kworker/28:1 Kdump: loaded Tainted: G        OE       6.17.0-rc2+ #9 NONE
> Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
> Workqueue: smc_hs_wq smc_listen_work [smc]
> RIP: 0010:smc_ib_is_sg_need_sync+0x9e/0xd0 [smc]
> ...
> Call Trace:
>  <TASK>
>  smcr_buf_map_link+0x211/0x2a0 [smc]
>  __smc_buf_create+0x522/0x970 [smc]
>  smc_buf_create+0x3a/0x110 [smc]
>  smc_find_rdma_v2_device_serv+0x18f/0x240 [smc]
>  ? smc_vlan_by_tcpsk+0x7e/0xe0 [smc]
>  smc_listen_find_device+0x1dd/0x2b0 [smc]
>  smc_listen_work+0x30f/0x580 [smc]
>  process_one_work+0x18c/0x340
>  worker_thread+0x242/0x360
>  kthread+0xe7/0x220
>  ret_from_fork+0x13a/0x160
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> 
> If the software RoCE device is used, ibdev->dma_device is a null pointer.
> As a result, the problem occurs. Null pointer detection is added to
> prevent problems.
> 
> Fixes: 0ef69e788411c ("net/smc: optimize for smc_sndbuf_sync_sg_for_device and smc_rmb_sync_sg_for_cpu")
> Signed-off-by: Liu Jian <liujian56@huawei.com>
> ---
> v1->v2:
> move the check outside of loop.
>  net/smc/smc_ib.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
> index 53828833a3f7..a42ef3f77b96 100644
> --- a/net/smc/smc_ib.c
> +++ b/net/smc/smc_ib.c
> @@ -742,6 +742,9 @@ bool smc_ib_is_sg_need_sync(struct smc_link *lnk,
>  	unsigned int i;
>  	bool ret = false;
>  
> +	if (!lnk->smcibdev->ibdev->dma_device)
> +		return ret;
> +
>  	/* for now there is just one DMA address */
>  	for_each_sg(buf_slot->sgt[lnk->link_idx].sgl, sg,
>  		    buf_slot->sgt[lnk->link_idx].nents, i) {

LGTM, thanks.

Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>


