Return-Path: <linux-rdma+bounces-13186-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9157EB4A8CA
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 11:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA171887318
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 09:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB39530F935;
	Tue,  9 Sep 2025 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jttF35M4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DBD30F94A;
	Tue,  9 Sep 2025 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411137; cv=none; b=rPNtMSjVZotAgT5uj+deRtQaBRDmZOM5mxdm0cxPDFbJ+nJ1w6jFHlhP3IHHILUySndXR5kVbvHEp9e8OAjVTlW2Tc2VhyWT+u1pYvVp/zjBeY1fOEuitm+YOwQfywj5Jhfxxn2/oYDwVXq4SHkCzrbFx8JDfxa6tgazbWuVEGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411137; c=relaxed/simple;
	bh=QUvP8GINuCzSF7JPaWUyPUnNE7WZ2BGlzy60uTCAee4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3ndxPEZuZSvcmoN61L/KvVVrWOA+HMVhVHf7Icaem0XIscWJk6T1K2VxdXs8jXo88NTSNKmIwP+qzFGH4adV+5sXl7sMkDIOKBvGzLRbWLWTNB4Re50rUfM294jfLSwgPvG5ULX1WLJ/swYM4cBJpp5vG7l+gMgK/HGdupCX/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jttF35M4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97723C4CEF4;
	Tue,  9 Sep 2025 09:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757411137;
	bh=QUvP8GINuCzSF7JPaWUyPUnNE7WZ2BGlzy60uTCAee4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jttF35M4NSuhz5upmy8/c9ZrRK2u7fT59c1LlHk0Yzx4DWtfMXJAL53GBruztjArX
	 DCT1hUaEPiv28UP+nP4618fMUegp/l4WQdFigfky2Hlvpc+Vciyc6PTEyxcw0kcGjB
	 7t38n6GJOzJG/4LPMU0n6HUk9ot3Pmcj0Jwm3iyt7nurt+AC5lqsu7LwtNKoLKLSGE
	 EwYaF6iGgKDDCz5D2Gp0utYfRj0s4l6dh5l3Cl5ZkZwxhyMQQpXPDDqkr4trE0OYos
	 hY26oLB2zfrWNh1wlODgIeGGeaXDjiHXr60wxOdrZLIaWjAR1lI6CAuIDX6PPW6Vn0
	 5plBbpkwoYfTA==
Date: Tue, 9 Sep 2025 12:45:32 +0300
From: Leon Romanovsky <leon@kernel.org>
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
Message-ID: <20250909094532.GD341237@unreal>
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

Please use ib_uses_virt_dma() function for that.

It is clearly stated in the code:
  2784 struct ib_device {
  2785         /* Do not access @dma_device directly from ULP nor from HW drivers. */
  2786         struct device                *dma_device;     

Thanks


> +
>  	/* for now there is just one DMA address */
>  	for_each_sg(buf_slot->sgt[lnk->link_idx].sgl, sg,
>  		    buf_slot->sgt[lnk->link_idx].nents, i) {
> -- 
> 2.34.1
> 
> 

