Return-Path: <linux-rdma+bounces-4269-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BBE94CE27
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 12:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD65D1F254E3
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 10:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D6816728E;
	Fri,  9 Aug 2024 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qeY0k0eh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF9116D307;
	Fri,  9 Aug 2024 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723197728; cv=none; b=tHKksowGJINnbqnddx3KqW4t/D7ryBaC4uYpTE1spAuumjn0Y7/GdT/V/8IFHpd9IibwcgwmsHecZJseOWlmxbi9uVMi17+mf5cOSZvdX6OeuIyI/Hjj1kyzIJdY6ljjTFMShFFnn4mjDjFb91/41fPmdUxCrVgCetzLw1AnqJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723197728; c=relaxed/simple;
	bh=Kbxtk/rTG8xh8pLqLXt5XVBapXThRW3mletxNrIST94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FKyJMwbpIt8N1iPQCTYUi4Un5i5fRyCrBN7bBMYG1delEpHccev0FxmjTPbrG8NtxSvofwgsOwyFqbwTK6o8uY8XNaikeXRCO6/IDhb3Y9vwZx3kvajJg9qRpSPKZ5FUvzVhFZl4cOYaBuTZV236XGWXCdsSssu5nLni4byyKUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qeY0k0eh; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723197717; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BdKgcvydGioWnK8L6t2a5AjgNvCBYWhkiDknLVnvalI=;
	b=qeY0k0eh/QJvQI8LB++hPZM2yiapQpnzss3PovAxoNwFAWe+KoXnUNCXBW91bxyExx7B8baqZXRt3Ay1LancFjH5wrU7uWvjQ4oO8GFYXt8bOJrqyNXJug4IMkX3AXB/3y+Dx3HVFvGReS5WseTtH7f1J1l8x5pfIfKcTCG7lBY=
Received: from 30.221.129.232(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WCPmSH9_1723197714)
          by smtp.aliyun-inc.com;
          Fri, 09 Aug 2024 18:01:56 +0800
Message-ID: <c0a1aade-a6ee-482a-bc6e-da07a4c69cff@linux.alibaba.com>
Date: Fri, 9 Aug 2024 18:01:54 +0800
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
 wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
References: <20240809083148.1989912-1-liujian56@huawei.com>
 <20240809083148.1989912-4-liujian56@huawei.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20240809083148.1989912-4-liujian56@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/9 16:31, Liu Jian wrote:
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

LGTM.

Reviewed-by: Wen Gu <guwen@linux.alibaba.com>

>   		if (dma_need_sync(lnk->smcibdev->ibdev->dma_device,
>   				  sg_dma_address(sg))) {
>   			ret = true;

