Return-Path: <linux-rdma+bounces-13958-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B37BF6DA0
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Oct 2025 15:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 460035039AD
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Oct 2025 13:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD518338587;
	Tue, 21 Oct 2025 13:43:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEC433506F
	for <linux-rdma@vger.kernel.org>; Tue, 21 Oct 2025 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054189; cv=none; b=nMtQgSCqi8kQ/5orMUzX82WJxwGynlSWdLaedlksaSACB/K0HMRCqG5K+gSrTGs9HO9RV2bot44nK3oaJGN8Jy6FDraBFJ3azTKMN8YupgO2vJYnEWWgE/Zn/uGu1ZxRjOtSLQcOd3YrHmnuQNNZxTQkfqFy7cz60pAA/g62NoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054189; c=relaxed/simple;
	bh=S1GGoIt4wj+j2SMy9s5dUaCOH2nRIFNeYT/pZ91EcAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SBfjW7Fc1cUS3LHWpKrbC8myd8eR27m45Dc6JatG5h9cTmBEe8r0rvLLbAXfw0zT5FKoFRsl9R5sw/84h2jUI4AABagPH1DtXuR0Kp4MobDNuxcth9vBRI8B50MmoeTgSRvyik5MfVXC/QCLO3CqNxF6Fz2tsy5zKJf3lR7735s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4crYPQ3bsVz1T4G8;
	Tue, 21 Oct 2025 21:42:02 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 88931140123;
	Tue, 21 Oct 2025 21:42:55 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Oct 2025 21:42:55 +0800
Message-ID: <91be3a58-c7e4-7250-9826-a8294386f2a0@hisilicon.com>
Date: Tue, 21 Oct 2025 21:42:54 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] RDMA/rxe: fix null deref on srq->rq.queue after resize
 failure
Content-Language: en-US
To: Yi Liu <asatsuyu.liu@gmail.com>, <linux-rdma@vger.kernel.org>
CC: Zhu Yanjun <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
	"leon@kernel.org" <leon@kernel.org>
References: <CANQ=Xi1JW2zFuYzNCw9Ft7WhseiHk4w1prYKmBc-Hbn1N32XNQ@mail.gmail.com>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <CANQ=Xi1JW2zFuYzNCw9Ft7WhseiHk4w1prYKmBc-Hbn1N32XNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2025/10/21 10:20, Yi Liu wrote:
> A NULL pointer dereference can occur in rxe_srq_chk_attr() when
> ibv_modify_srq() is invoked twice in succession under certain error
> conditions. The first call may fail in rxe_queue_resize(), which leads
> rxe_srq_from_attr() to set srq->rq.queue = NULL. The second call then
> triggers a crash (null deref) when accessing
> srq->rq.queue->buf->index_mask.
> 
> Call Trace:
> <TASK>
> rxe_modify_srq+0x170/0x480 [rdma_rxe]
> ? __pfx_rxe_modify_srq+0x10/0x10 [rdma_rxe]
> ? uverbs_try_lock_object+0x4f/0xa0 [ib_uverbs]
> ? rdma_lookup_get_uobject+0x1f0/0x380 [ib_uverbs]
> ib_uverbs_modify_srq+0x204/0x290 [ib_uverbs]
> ? __pfx_ib_uverbs_modify_srq+0x10/0x10 [ib_uverbs]
> ? tryinc_node_nr_active+0xe6/0x150
> ? uverbs_fill_udata+0xed/0x4f0 [ib_uverbs]
> ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x2c0/0x470 [ib_uverbs]
> ? __pfx_ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x10/0x10 [ib_uverbs]
> ? uverbs_fill_udata+0xed/0x4f0 [ib_uverbs]
> ib_uverbs_run_method+0x55a/0x6e0 [ib_uverbs]
> ? __pfx_ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x10/0x10 [ib_uverbs]
> ib_uverbs_cmd_verbs+0x54d/0x800 [ib_uverbs]
> ? __pfx_ib_uverbs_cmd_verbs+0x10/0x10 [ib_uverbs]
> ? __pfx___raw_spin_lock_irqsave+0x10/0x10
> ? __pfx_do_vfs_ioctl+0x10/0x10
> ? ioctl_has_perm.constprop.0.isra.0+0x2c7/0x4c0
> ? __pfx_ioctl_has_perm.constprop.0.isra.0+0x10/0x10
> ib_uverbs_ioctl+0x13e/0x220 [ib_uverbs]
> ? __pfx_ib_uverbs_ioctl+0x10/0x10 [ib_uverbs]
> __x64_sys_ioctl+0x138/0x1c0
> do_syscall_64+0x82/0x250
> ? fdget_pos+0x58/0x4c0
> ? ksys_write+0xf3/0x1c0
> ? __pfx_ksys_write+0x10/0x10
> ? do_syscall_64+0xc8/0x250
> ? __pfx_vm_mmap_pgoff+0x10/0x10
> ? fget+0x173/0x230
> ? fput+0x2a/0x80
> ? ksys_mmap_pgoff+0x224/0x4c0
> ? do_syscall_64+0xc8/0x250
> ? do_user_addr_fault+0x37b/0xfe0
> ? clear_bhb_loop+0x50/0xa0
> ? clear_bhb_loop+0x50/0xa0
> ? clear_bhb_loop+0x50/0xa0
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Fix by aligning the error handling path in rxe_srq_from_attr() with
> rxe_cq_resize_queue(), which also uses rxe_queue_resize(): do not
> nullify the queue when resize fails.
> 
> Reported-by: Liu Yi <asatsuyu.liu@gmail.com>
> Link: https://paste.ubuntu.com/p/Zhj65q6gr9/
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Tested-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
> drivers/infiniband/sw/rxe/rxe_srq.c | 2 --
> 1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c
> b/drivers/infiniband/sw/rxe/rxe_srq.c
> index 3661cb627d28..2764dc00e2f3 100644
> --- a/drivers/infiniband/sw/rxe/rxe_srq.c
> +++ b/drivers/infiniband/sw/rxe/rxe_srq.c
> @@ -182,8 +182,6 @@ int rxe_srq_from_attr(struct rxe_dev *rxe, struct
> rxe_srq *srq,
> return 0;
> 
> err_free:
> - rxe_queue_cleanup(q);
> - srq->rq.queue = NULL;
> return err;

A minor suggestion, this err_free label doesn’t seem necessary any more.
You can return directly at the place where you jump to err_free currently.

Junxian

> }
> 
> --
> 2.34.1
> 

