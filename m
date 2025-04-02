Return-Path: <linux-rdma+bounces-9112-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 035A5A78A6F
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 10:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2621890F74
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 08:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BDCFC08;
	Wed,  2 Apr 2025 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gb9GUmO7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6161B1514F6
	for <linux-rdma@vger.kernel.org>; Wed,  2 Apr 2025 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743584323; cv=none; b=ArAyB+V7RofrlTwYwWwn+V60zHkigkIZvhWt2bcyPQUd+uWD1PptHyZrdBGXk15yzkBshWvJPvDvggZ+35gbmwRvy28fTg5MXvfKzNCoGZov5P9+eCwezBeDFBqkQhFHw8XaNWy3aJft6XNUWYV4kd6Ezy7wNLIx5LxcE6rfmjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743584323; c=relaxed/simple;
	bh=tG3IqQSM1JM8+zeznsJDYfGwMpe6GqfXuPUshXBYWNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nHiuZ36LtXrp3n4QVA4jQQ2bQEWBKPSBHzjvEgdQZlKdljrEqA1v4AS5OZKi95OqdU2Zl1PjuVYiHkcHBq80BAi9NJMWA9kPD8idPI0N1wTbi9kGvLcdVqT0J3DfbgVKSAYhHUEhvLlesSvjGk6EhRN4OvAskQHgH7crBVCvYXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gb9GUmO7; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a0eb561e-9fa9-46ab-bb0a-6e68a8e0d834@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743584318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nzfseE+lZYIxN42APnDpBaex01U5HHenpc2kDTQzd5k=;
	b=Gb9GUmO720zCgsplouJP090LeEgPOcTjCRF8e6DIAtCOEccgEIuRXhLqDF0tlCgAzp7l2K
	iUL/zicPP+qRai1oBX1kgBTvVWcbUZwyxBSdggEpfeDQ3MuWMt0V4vtEs+Eb9jfQB6WV9s
	gYDzaiXrntUhKq1dAHmdUGGfZUX8EVI=
Date: Wed, 2 Apr 2025 10:58:34 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Fix null pointer dereference in ODP MR check
To: Li Zhijian <lizhijian@fujitsu.com>, linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, zyjzyj2000@gmail.com, jgg@ziepe.ca,
 leon@kernel.org, matsuda-daisuke@fujitsu.com,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20250402032657.1762800-1-lizhijian@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250402032657.1762800-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/4/2 5:26, Li Zhijian 写道:
> The blktests/rnbd reported a null pointer dereference as following.
> Similar to the mxl5, introduce a is_odp_mr() to check if the odp
> is enabled in this mr.
> 
> Workqueue: rxe_wq do_work [rdma_rxe]
> RIP: 0010:rxe_mr_copy+0x57/0x210 [rdma_rxe]
> Code: 7c 04 48 89 f3 48 89 d5 41 89 cf 45 89 c4 0f 84 dc 00 00 00 89 ca e8 f8 f8 ff ff 85 c0 0f 85 75 01 00 00 49 8b 86 f0 00 00 00 <f6> 40 28 02 0f 85 98 01 00 00 41 8b 46 78 41 8b 8e 10 01 00 00 8d
> RSP: 0018:ffffa0aac02cfcf8 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff9079cd440024 RCX: 0000000000000000
> RDX: 000000000000003c RSI: ffff9079cd440060 RDI: ffff9079cd665600
> RBP: ffff9079c0e5e45a R08: 0000000000000000 R09: 0000000000000000
> R10: 000000003c000000 R11: 0000000000225510 R12: 0000000000000000
> R13: 0000000000000000 R14: ffff9079cd665600 R15: 000000000000003c
> FS:  0000000000000000(0000) GS:ffff907ccfa80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000028 CR3: 0000000119498001 CR4: 00000000001726f0
> Call Trace:
>   <TASK>
>   ? __die_body+0x1e/0x60
>   ? page_fault_oops+0x14f/0x4c0
>   ? rxe_mr_copy+0x57/0x210 [rdma_rxe]
>   ? search_bpf_extables+0x5f/0x80
>   ? exc_page_fault+0x7e/0x180
>   ? asm_exc_page_fault+0x26/0x30
>   ? rxe_mr_copy+0x57/0x210 [rdma_rxe]
>   ? rxe_mr_copy+0x48/0x210 [rdma_rxe]
>   ? rxe_pool_get_index+0x50/0x90 [rdma_rxe]
>   rxe_receiver+0x1d98/0x2530 [rdma_rxe]
>   ? psi_task_switch+0x1ff/0x250
>   ? finish_task_switch+0x92/0x2d0
>   ? __schedule+0xbdf/0x17c0
>   do_task+0x65/0x1e0 [rdma_rxe]
>   process_scheduled_works+0xaa/0x3f0
>   worker_thread+0x117/0x240
> 
> Fixes: d03fb5c6599e ("RDMA/rxe: Allow registering MRs for On-Demand Paging")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_loc.h  | 6 ++++++
>   drivers/infiniband/sw/rxe/rxe_mr.c   | 4 ++--
>   drivers/infiniband/sw/rxe/rxe_resp.c | 4 ++--
>   3 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index feb386d98d1d..0bc3fbb6554f 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -140,6 +140,12 @@ static inline int qp_mtu(struct rxe_qp *qp)
>   		return IB_MTU_4096;
>   }
>   
> +static inline bool is_odp_mr(struct rxe_mr *mr)

Previously I once discussed with Bob Pearson about the function names.
Perhaps it is better to rename is_odp_mr to rxe_is_odp_mr?

Since sometimes we debug in rdma, with a lot of functions with the same 
name, it is difficult to recognize the modules that this function 
belongs to.

Thus, in rxe module, it is better to add rxe_ prefix to the function 
name. But anyway, this commit is fine.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> +{
> +	return IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING) && mr->umem &&
> +	       mr->umem->is_odp;
> +}
> +
>   void free_rd_atomic_resource(struct resp_res *res);
>   
>   static inline void rxe_advance_resp_resource(struct rxe_qp *qp)
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index 868d2f0b74e9..432d864c3ce9 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -323,7 +323,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
>   		return err;
>   	}
>   
> -	if (mr->umem->is_odp)
> +	if (is_odp_mr(mr))
>   		return rxe_odp_mr_copy(mr, iova, addr, length, dir);
>   	else
>   		return rxe_mr_copy_xarray(mr, iova, addr, length, dir);
> @@ -536,7 +536,7 @@ int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
>   	u64 *va;
>   
>   	/* ODP is not supported right now. WIP. */
> -	if (mr->umem->is_odp)
> +	if (is_odp_mr(mr))
>   		return RESPST_ERR_UNSUPPORTED_OPCODE;
>   
>   	/* See IBA oA19-28 */
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index 54ba9ee1acc5..5d9174e408db 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -650,7 +650,7 @@ static enum resp_states process_flush(struct rxe_qp *qp,
>   	struct resp_res *res = qp->resp.res;
>   
>   	/* ODP is not supported right now. WIP. */
> -	if (mr->umem->is_odp)
> +	if (is_odp_mr(mr))
>   		return RESPST_ERR_UNSUPPORTED_OPCODE;
>   
>   	/* oA19-14, oA19-15 */
> @@ -706,7 +706,7 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
>   	if (!res->replay) {
>   		u64 iova = qp->resp.va + qp->resp.offset;
>   
> -		if (mr->umem->is_odp)
> +		if (is_odp_mr(mr))
>   			err = rxe_odp_atomic_op(mr, iova, pkt->opcode,
>   						atmeth_comp(pkt),
>   						atmeth_swap_add(pkt),


