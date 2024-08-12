Return-Path: <linux-rdma+bounces-4313-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C992794E591
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 05:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883BA1F22227
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 03:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB92413A3E8;
	Mon, 12 Aug 2024 03:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZyR9zHy5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA6D22619;
	Mon, 12 Aug 2024 03:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723433417; cv=none; b=JkvT+YS98INuSFTbI9xwgzg48QG8shr+EL7sd/Aau599i8nWB2Lsbr8SYnwk2mwlkwxE5j20gxhmgw28CVLfIs5ZH1ku0VYos3fOndyFLn3pktc/5w7T1X8Pndj113VXN3GbmNoPPtvWV/6xR57TrubD0Kfrvpjmpav/EBYs1FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723433417; c=relaxed/simple;
	bh=1NvmWuvWulL3lgZ13xqenqBuOevIJpdbCOZC9Oi1TZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AOQTpE3hw454S9S66s20OFoNaA0MSU3LhLf2Atgrjt5mDnppmgHQTvNTAu5SX3TD1XdqJBUUs+ZXkxVd1lIH2PeN1lqxLBP+pndCZ006DWLhk/CZB3mgGl8f9cwLoCcRzJwE8RYkzuhkfx7kp9N7VDDUQ0d68LIZd0Mmuzsc/L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZyR9zHy5; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723433412; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=O8AxRrJltn6s35naWtnuURaFKdxfIOs5dcReL1ZWDe8=;
	b=ZyR9zHy5xqgmF4jL8gDKTEoM7ty2EW3AfPubxpsPk4k7xJumDNsqHJKjkuHtLEqZ9TzkUweY84iKIIJfiC14oiUByUW8sFx0+CKi6ycUS1shAor9pf7dJVY5GSao7ujXsmx31Tu9ub85a+X4Y2f2m/si8Ks196U/GK/g6LgNt1s=
Received: from 30.221.149.129(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WCYCTXU_1723433410)
          by smtp.aliyun-inc.com;
          Mon, 12 Aug 2024 11:30:11 +0800
Message-ID: <37a5e33a-e47a-464e-9505-f88c9aa367b2@linux.alibaba.com>
Date: Mon, 12 Aug 2024 11:30:09 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/4] net/smc: fix one NULL pointer dereference in
 smc_ib_is_sg_need_sync()
To: Liu Jian <liujian56@huawei.com>, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org
Cc: jgg@ziepe.ca, leon@kernel.org, zyjzyj2000@gmail.com,
 wenjia@linux.ibm.com, jaka@linux.ibm.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
References: <20240809083148.1989912-1-liujian56@huawei.com>
 <20240809083148.1989912-4-liujian56@huawei.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20240809083148.1989912-4-liujian56@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/9/24 4:31 PM, Liu Jian wrote:
> BUG: kernel NULL pointer dereference, address: 0000000000000238
> PGD 0 P4D 0
> Oops: 0000 [#1] PREEMPT SMP PTI
> CPU: 3 PID: 289 Comm: kworker/3:1 Kdump: loaded Tainted: G           OE
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
> Workqueue: smc_hs_wq smc_listen_work [smc]
> RIP: 0010:dma_need_sync+0x5/0x60
> ...
> Call Trace:
>   <TASK>
>   ? dma_need_sync+0x5/0x60
>   ? smc_ib_is_sg_need_sync+0x61/0xf0 [smc]
>   smcr_buf_map_link+0x24a/0x380 [smc]
>   __smc_buf_create+0x483/0xb10 [smc]
>   smc_buf_create+0x21/0xe0 [smc]
>   smc_listen_work+0xf11/0x14f0 [smc]
>   ? smc_tcp_listen_work+0x364/0x520 [smc]
>   process_one_work+0x18d/0x3f0
>   worker_thread+0x304/0x440
>   kthread+0xe4/0x110
>   ret_from_fork+0x47/0x70
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>
> If the software RoCE device is used, ibdev->dma_device is a null pointer.
> As a result, the problem occurs. Null pointer detection is added to
> prevent problems.
>
> Signed-off-by: Liu Jian <liujian56@huawei.com>
> ---
>   net/smc/smc_ib.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
> index 382351ac9434..059822cc3fde 100644
> --- a/net/smc/smc_ib.c
> +++ b/net/smc/smc_ib.c
> @@ -748,6 +748,8 @@ bool smc_ib_is_sg_need_sync(struct smc_link *lnk,
>   		    buf_slot->sgt[lnk->link_idx].nents, i) {
>   		if (!sg_dma_len(sg))
>   			break;
> +		if (!lnk->smcibdev->ibdev->dma_device)
> +			break;
>   		if (dma_need_sync(lnk->smcibdev->ibdev->dma_device,
>   				  sg_dma_address(sg))) {
>   			ret = true;

Maybe you need add a fix tag ?




