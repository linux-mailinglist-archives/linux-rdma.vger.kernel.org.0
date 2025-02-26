Return-Path: <linux-rdma+bounces-8113-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F5EA457CB
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 09:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E57188A6DB
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 08:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B973F22424F;
	Wed, 26 Feb 2025 08:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NeWJjflv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22D322424D
	for <linux-rdma@vger.kernel.org>; Wed, 26 Feb 2025 08:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740557488; cv=none; b=HfEzm64pUmCDBioz4j0xNNLbQ2CWjAUa8+OfcewO2AD98GyU18JCytI8bSRldBXj6DgohNSFqltZnnRDR9VJbp0FAeF3dtV8wMQJrISa1vRpSakOSSqbZNdry/YfUk1R56Ls36uRgP0YpmXfJUYYT3xjfmPWAnLsqzSr/COPCV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740557488; c=relaxed/simple;
	bh=c2nX0Z7KssjyZmmlzlpGmH9rmjGL9ARrjwnRUgnZuNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9HozhFAg74Z2cJZ2lwgxbmRIodgwJNPaAHEA3/03TL4pgz8SS5jDvYILwKOMSOKIb3Z4gD42KQpjkIQpLt0HxrEqh33/t6BZH7rPtFz1YcoH+LSmY4kIVcba6TVVoOdMSo691hjFBm9jEzE9wbSIOghHl5B0ofbXNeNgnYJTsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NeWJjflv; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c39999a9-7f81-4251-8caf-e41d35863583@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740557484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vQZGiPobJFLUFPmIT/bFFxZNZZw9MWEJvpreh0oySZg=;
	b=NeWJjflvy2xGHhypijuPIh/CTKLQ3VrMWMyyKqs1KtNdLlm1SZrB/pvt7D+STB6lpT774/
	R5bZLO5oLmZoFQ2Z47swrvchDxkaMgP9AQnVzBmGqywpDfqg6hvrwMiUztjgRHQ3IAqc6/
	IH3xdSga7a7WVKGctupDP+hXmiiiTqc=
Date: Wed, 26 Feb 2025 09:11:21 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] RDMA/core: fix a NULL-pointer dereference in
 hw_stat_device_show()
To: Roman Gushchin <roman.gushchin@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, Maher Sanalla <msanalla@nvidia.com>,
 Parav Pandit <parav@mellanox.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250224232048.1423635-1-roman.gushchin@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250224232048.1423635-1-roman.gushchin@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/2/25 0:20, Roman Gushchin 写道:
> The following panic has been noticed in production on multiple hosts:
> 
> [42021.807566] BUG: kernel NULL pointer dereference, address: 0000000000000028
> [42021.814463] #PF: supervisor read access in kernel mode
> [42021.819549] #PF: error_code(0x0000) - not-present page
> [42021.824636] PGD 0 P4D 0
> [42021.827145] Oops: 0000 [#1] SMP PTI
> [42021.830598] CPU: 82 PID: 2843922 Comm: switchto-defaul Kdump: loaded Tainted: G S      W I        XXX
> [42021.841697] Hardware name: XXX
> [42021.849619] RIP: 0010:hw_stat_device_show+0x1e/0x40 [ib_core]
> [42021.855362] Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 49 89 d0 4c 8b 5e 20 48 8b 8f b8 04 00 00 48 81 c7 f0 fa ff ff <48> 8b 41 28 48 29 ce 48 83 c6 d0 48 c1 ee 04 69 d6 ab aa aa aa 48
> [42021.873931] RSP: 0018:ffff97fe90f03da0 EFLAGS: 00010287
> [42021.879108] RAX: ffff9406988a8c60 RBX: ffff940e1072d438 RCX: 0000000000000000
> [42021.886169] RDX: ffff94085f1aa000 RSI: ffff93c6cbbdbcb0 RDI: ffff940c7517aef0
> [42021.893230] RBP: ffff97fe90f03e70 R08: ffff94085f1aa000 R09: 0000000000000000
> [42021.900294] R10: ffff94085f1aa000 R11: ffffffffc0775680 R12: ffffffff87ca2530
> [42021.907355] R13: ffff940651602840 R14: ffff93c6cbbdbcb0 R15: ffff94085f1aa000
> [42021.914418] FS:  00007fda1a3b9700(0000) GS:ffff94453fb80000(0000) knlGS:0000000000000000
> [42021.922423] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [42021.928130] CR2: 0000000000000028 CR3: 00000042dcfb8003 CR4: 00000000003726f0
> [42021.935194] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [42021.942257] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [42021.949324] Call Trace:
> [42021.951756]  <TASK>
> [42021.953842]  [<ffffffff86c58674>] ? show_regs+0x64/0x70
> [42021.959030]  [<ffffffff86c58468>] ? __die+0x78/0xc0
> [42021.963874]  [<ffffffff86c9ef75>] ? page_fault_oops+0x2b5/0x3b0
> [42021.969749]  [<ffffffff87674b92>] ? exc_page_fault+0x1a2/0x3c0
> [42021.975549]  [<ffffffff87801326>] ? asm_exc_page_fault+0x26/0x30
> [42021.981517]  [<ffffffffc0775680>] ? __pfx_show_hw_stats+0x10/0x10 [ib_core]
> [42021.988482]  [<ffffffffc077564e>] ? hw_stat_device_show+0x1e/0x40 [ib_core]
> [42021.995438]  [<ffffffff86ac7f8e>] dev_attr_show+0x1e/0x50
> [42022.000803]  [<ffffffff86a3eeb1>] sysfs_kf_seq_show+0x81/0xe0
> [42022.006508]  [<ffffffff86a11134>] seq_read_iter+0xf4/0x410
> [42022.011954]  [<ffffffff869f4b2e>] vfs_read+0x16e/0x2f0
> [42022.017058]  [<ffffffff869f50ee>] ksys_read+0x6e/0xe0
> [42022.022073]  [<ffffffff8766f1ca>] do_syscall_64+0x6a/0xa0
> [42022.027441]  [<ffffffff8780013b>] entry_SYSCALL_64_after_hwframe+0x78/0xe2
> 
> The problem can be reproduced using the following steps:
>    ip netns add foo
>    ip netns exec foo bash
>    cat /sys/class/infiniband/mlx4_0/hw_counters/*
> 
> The problem is caused by reading hw counters from a non-initial
> net namespace. In this case casting the device pointer into
> an ib_device pointer using container_of() in hw_stat_device_show() is
> wrong and leads to a memory corruption. Instead, rdma_device_to_ibdev()
> should be used, which uses a back-reference


The function rdma_device_to_ibdev uses container_of to get struct 
ib_core_device firstly, then gets struct ib_device via the member 
variable owner in struct ib_core_device. It can work well.

But container_of(dev, struct ib_device, dev) is to get struct ib_device 
directly. Unfortunately, it caused a call trace. It seems that there is 
something wrong in struct ib_device. If we make further investigations, 
it will make us understand this problem better.

Anyway, it seems good to me.
Thanks,
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> (container_of(device, struct ib_core_device, dev))->owner.
> 
> Fixes: 467f432a521a ("RDMA/core: Split port and device counter sysfs attributes")
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Maher Sanalla <msanalla@nvidia.com>
> Cc: Parav Pandit <parav@mellanox.com>
> Cc: linux-rdma@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   drivers/infiniband/core/sysfs.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
> index 7491328ca5e6..0be77b8abeae 100644
> --- a/drivers/infiniband/core/sysfs.c
> +++ b/drivers/infiniband/core/sysfs.c
> @@ -148,7 +148,7 @@ static ssize_t hw_stat_device_show(struct device *dev,
>   {
>   	struct hw_stats_device_attribute *stat_attr =
>   		container_of(attr, struct hw_stats_device_attribute, attr);
> -	struct ib_device *ibdev = container_of(dev, struct ib_device, dev);
> +	struct ib_device *ibdev = rdma_device_to_ibdev(dev);
>   
>   	return stat_attr->show(ibdev, ibdev->hw_stats_data->stats,
>   			       stat_attr - ibdev->hw_stats_data->attrs, 0, buf);
> @@ -160,7 +160,7 @@ static ssize_t hw_stat_device_store(struct device *dev,
>   {
>   	struct hw_stats_device_attribute *stat_attr =
>   		container_of(attr, struct hw_stats_device_attribute, attr);
> -	struct ib_device *ibdev = container_of(dev, struct ib_device, dev);
> +	struct ib_device *ibdev = rdma_device_to_ibdev(dev);
>   
>   	return stat_attr->store(ibdev, ibdev->hw_stats_data->stats,
>   				stat_attr - ibdev->hw_stats_data->attrs, 0, buf,


