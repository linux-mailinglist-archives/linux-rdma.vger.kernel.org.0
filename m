Return-Path: <linux-rdma+bounces-4288-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F6294D2D2
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 17:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F133A1F21904
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 15:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF57B198833;
	Fri,  9 Aug 2024 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KbWeM3p5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4FE19754A;
	Fri,  9 Aug 2024 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723215596; cv=none; b=h5JtWo1M0AAoDWMyDjYZyEeDpWsLXU3eFVHI8pPJpO+VIttlUF3SsyVrSDPvRBf8qD5JRMEpho5zOctZcRT347dNfnsMEKIFHJEc9qGrgcfuXdMAzg6oThwi7WSEXwpsBEGNEmlvkWQiljPb6anXZYi7MaKSe1cl10nefgt9PwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723215596; c=relaxed/simple;
	bh=WqXq0Zf95jFH70eCWzKcIJ01DY7xhirTTh/KCWVhDZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBi3G+TCV44YmhCKw4rh0/5MxbY13njZPzqpG7NRhSCtq07s6Yi/7h1WWNP89RuLgtRF502mEF6Oejdai1+tr59J6g2AKZ6xwd7SKNYYsgDdhqa3c3kBV2coSEl7QiQHNWVA+eFbk0woqnUT2tNR88EyRAEBLPBC9hMtYRR49FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KbWeM3p5; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723215586; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=kumHyBWzVRO0ncr0y36Hp9pmYU0wJNsCLgahOma009M=;
	b=KbWeM3p5LPYfP7PgiZ1gig1eiIpPEf7sQ2IevHvR3GmCDryJV44Izd5Sb3YFOnIJqaPwWo1sW+1INnVML+uMb+JJ7UDHxSoKe6BSFZB9fYYcWGrwmmjnvi9Amxz7iAg1lLkJl5AP7HVN8iycluwVh4L2qpiQb41P/UljqaucnJ8=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WCQSGmU_1723215584)
          by smtp.aliyun-inc.com;
          Fri, 09 Aug 2024 22:59:45 +0800
Date: Fri, 9 Aug 2024 22:59:44 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Liu Jian <liujian56@huawei.com>, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org
Cc: jgg@ziepe.ca, leon@kernel.org, zyjzyj2000@gmail.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next 3/4] net/smc: fix one NULL pointer dereference
 in smc_ib_is_sg_need_sync()
Message-ID: <20240809145944.GC103152@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20240809083148.1989912-1-liujian56@huawei.com>
 <20240809083148.1989912-4-liujian56@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809083148.1989912-4-liujian56@huawei.com>

On 2024-08-09 16:31:47, Liu Jian wrote:
>BUG: kernel NULL pointer dereference, address: 0000000000000238
>PGD 0 P4D 0
>Oops: 0000 [#1] PREEMPT SMP PTI
>CPU: 3 PID: 289 Comm: kworker/3:1 Kdump: loaded Tainted: G           OE
>Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
>Workqueue: smc_hs_wq smc_listen_work [smc]
>RIP: 0010:dma_need_sync+0x5/0x60
>...
>Call Trace:
> <TASK>
> ? dma_need_sync+0x5/0x60
> ? smc_ib_is_sg_need_sync+0x61/0xf0 [smc]
> smcr_buf_map_link+0x24a/0x380 [smc]
> __smc_buf_create+0x483/0xb10 [smc]
> smc_buf_create+0x21/0xe0 [smc]
> smc_listen_work+0xf11/0x14f0 [smc]
> ? smc_tcp_listen_work+0x364/0x520 [smc]
> process_one_work+0x18d/0x3f0
> worker_thread+0x304/0x440
> kthread+0xe4/0x110
> ret_from_fork+0x47/0x70
> ret_from_fork_asm+0x1a/0x30
> </TASK>
>
>If the software RoCE device is used, ibdev->dma_device is a null pointer.
>As a result, the problem occurs. Null pointer detection is added to
>prevent problems.
>
>Signed-off-by: Liu Jian <liujian56@huawei.com>

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

Best regard,
Dust

>---
> net/smc/smc_ib.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
>index 382351ac9434..059822cc3fde 100644
>--- a/net/smc/smc_ib.c
>+++ b/net/smc/smc_ib.c
>@@ -748,6 +748,8 @@ bool smc_ib_is_sg_need_sync(struct smc_link *lnk,
> 		    buf_slot->sgt[lnk->link_idx].nents, i) {
> 		if (!sg_dma_len(sg))
> 			break;
>+		if (!lnk->smcibdev->ibdev->dma_device)
>+			break;
> 		if (dma_need_sync(lnk->smcibdev->ibdev->dma_device,
> 				  sg_dma_address(sg))) {
> 			ret = true;
>-- 
>2.34.1
>

