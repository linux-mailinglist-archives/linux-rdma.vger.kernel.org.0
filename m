Return-Path: <linux-rdma+bounces-12979-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE47B39E0F
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Aug 2025 15:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9603A3AF186
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Aug 2025 13:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEACD2652AF;
	Thu, 28 Aug 2025 13:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NdiOrjfM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C3313C9C4;
	Thu, 28 Aug 2025 13:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386249; cv=none; b=jqzrhFlpmIaKBAxZv36qSUfGimclMPl+ozKBCPu1QN+VjS3T1zwArseqXycYMXFFmhkJzseJGtpE0q7LWzeqSw2dWkJjQTn5leWi0pYwDScdMN2BZIwXwggQkj+//onuF+xzmrWQNVtsk6pUt9fd09nu4YYqc7gcybyIYEu8Hhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386249; c=relaxed/simple;
	bh=87R04Ox+ehTuM5qn/vfSbAZfNCAWzfGxR1PC7L0e8jI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fuOa9beAwOOgOxHA9aelSq/a8Go9wQ/FXSspzBNH0UT4jj2ZBIPQiODensJcT3hrPlMR2UQJjSG3OsUmlhIDreBT0QbEsWBLgrOyBnFXj2iVgSt6J+tsI8y/xGK/NpOzO/ubamJIIo6+P+xpApQFcC6b0jmZkmQRc04W0iwCB0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NdiOrjfM; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756386242; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=C1ejW/71ETj9A3bcLkx0oDuGH2F9c7HT+2BpATISzr4=;
	b=NdiOrjfM5LMPhTXFvYPUnTmA/DYXZa9J3oojkvB86LBeEFeD/Doqi8o+2PIjuyaz8+8+7PnjQBt3opFq/hG4OVD9MqSJ27rZYspItI6CqGK4bYf4ze7fNEC2mYbIN9h8fMw7H+GBWblboBn8SEPB+jOWIVkgHLo8ESSRHx7e58I=
Received: from 30.221.116.45(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WmnCu3f_1756386240 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 Aug 2025 21:04:01 +0800
Message-ID: <e32aa255-6ee7-421a-a7d2-8425627eabc1@linux.alibaba.com>
Date: Thu, 28 Aug 2025 21:04:00 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/smc: fix one NULL pointer dereference in
 smc_ib_is_sg_need_sync()
To: Liu Jian <liujian56@huawei.com>, alibuda@linux.alibaba.com,
 dust.li@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com,
 mjambigi@linux.ibm.com, tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250828124117.2622624-1-liujian56@huawei.com>
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <20250828124117.2622624-1-liujian56@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2025/8/28 20:41, Liu Jian 写道:
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

LGTM.
Reviewed-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>

