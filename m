Return-Path: <linux-rdma+bounces-12984-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62435B3A9EE
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Aug 2025 20:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837911C82473
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Aug 2025 18:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2266127144E;
	Thu, 28 Aug 2025 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jsrw5Ifs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1047E26C384
	for <linux-rdma@vger.kernel.org>; Thu, 28 Aug 2025 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756405510; cv=none; b=hGWN/LbYcsSxIDkkPV28qcHarac8du7zJvNae9CeC8ZlumEzOO7xhYs9EhG1LgrOlkxszQEiunghCyH70yxMTc/bezxCN2qnSw9l4AJTF5tCBX8TKPqmyWO7K024X/fh/GKEDVv9YZxLH4x/rJiFCGPTBFrO1fFmEqZ+4yhrjPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756405510; c=relaxed/simple;
	bh=hpaSKE3WtHuE6a+u4hpsb3KCTUiTjdLRE1SvVNQGDnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CobTHT4pcBMIYwtJx3LDFsrBBlqkhGSs0xMIgm+RSt13z3t/6tS3ZPL6zk62J3G2q/rw8FrvB4I/F3LklWjVRJ0oT1kd+Tq1+4vVx8w4MSsfZMHrQJTftH7Nvdfm5kvyi5FRvmL9IxCbR+Y/WV/JIqejP22XdyZO5iZ9wmSPwbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jsrw5Ifs; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2a18ff00-e11e-433a-9aff-0bf080c4d7a4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756405495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ETOgMV+PV9EU6Bdc35DpJPU1qLYFlBsKyZZaq+wO1wQ=;
	b=Jsrw5IfsSpH2nF/buGrsE2dafqX9bGCpz3S040Md7wt0bpYO4/YnewZZ0R3Y1+KxfYHnLF
	l+SBaZG2SlFMpO0gBpOLuLKGPLYfLrIvgsSdDoGFERS5WbiV/a4L6ZuKvUf9rPc5Cu5uxA
	4ze9DRPcnlXadt5lBoTG2mzwyOOWg+Y=
Date: Thu, 28 Aug 2025 11:24:43 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] net/smc: fix one NULL pointer dereference in
 smc_ib_is_sg_need_sync()
To: Liu Jian <liujian56@huawei.com>, alibuda@linux.alibaba.com,
 dust.li@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com,
 mjambigi@linux.ibm.com, tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, guangguan.wang@linux.alibaba.com
Cc: linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250828124117.2622624-1-liujian56@huawei.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20250828124117.2622624-1-liujian56@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/28/25 5:41 AM, Liu Jian wrote:
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
>   <TASK>
>   smcr_buf_map_link+0x211/0x2a0 [smc]
>   __smc_buf_create+0x522/0x970 [smc]
>   smc_buf_create+0x3a/0x110 [smc]
>   smc_find_rdma_v2_device_serv+0x18f/0x240 [smc]
>   ? smc_vlan_by_tcpsk+0x7e/0xe0 [smc]
>   smc_listen_find_device+0x1dd/0x2b0 [smc]
>   smc_listen_work+0x30f/0x580 [smc]
>   process_one_work+0x18c/0x340
>   worker_thread+0x242/0x360
>   kthread+0xe7/0x220
>   ret_from_fork+0x13a/0x160
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
> 
> If the software RoCE device is used, ibdev->dma_device is a null pointer.
> As a result, the problem occurs. Null pointer detection is added to
> prevent problems.

Normally, SoftRoCE relies on the DMA capabilities of the underlying NIC 
device. In SMC, if DMA will play an important role in the subsequent 
operations, we can leverage the NIC device’s DMA.

If DMA is not required for the upcoming actions, then this kind of 
checking is sufficient.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> 
> Fixes: 0ef69e788411c ("net/smc: optimize for smc_sndbuf_sync_sg_for_device and smc_rmb_sync_sg_for_cpu")
> Signed-off-by: Liu Jian <liujian56@huawei.com>
> ---
> v1->v2:
> move the check outside of loop.
>   net/smc/smc_ib.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
> index 53828833a3f7..a42ef3f77b96 100644
> --- a/net/smc/smc_ib.c
> +++ b/net/smc/smc_ib.c
> @@ -742,6 +742,9 @@ bool smc_ib_is_sg_need_sync(struct smc_link *lnk,
>   	unsigned int i;
>   	bool ret = false;
>   
> +	if (!lnk->smcibdev->ibdev->dma_device)
> +		return ret;
> +
>   	/* for now there is just one DMA address */
>   	for_each_sg(buf_slot->sgt[lnk->link_idx].sgl, sg,
>   		    buf_slot->sgt[lnk->link_idx].nents, i) {


