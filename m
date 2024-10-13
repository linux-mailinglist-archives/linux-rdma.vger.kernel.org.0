Return-Path: <linux-rdma+bounces-5392-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51D899B86E
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Oct 2024 08:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0CA21C20D4C
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Oct 2024 06:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185F97A15A;
	Sun, 13 Oct 2024 06:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HQa436zD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306F22F34
	for <linux-rdma@vger.kernel.org>; Sun, 13 Oct 2024 06:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728800168; cv=none; b=mQ60l31MKtJwMjCk/yp9oBCl3KV737+Jx7wmZ4ZZBwrjfpMAmNlZ9SZAPSbq9WhyuJDLRgxK6KIwH8SCKb2UVnTQ6oLo1l6IRE9C78tN3r3o3KO8IJOYxnQ7uRngygDw/6Kmtt4LtM5+sO7I4giFpAWvVfgE93ZjenZKDoE7B7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728800168; c=relaxed/simple;
	bh=etsTbxVmRxXbrqH1Qp9DHH8lnH71FNLBz0At0Vtt2Dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qECPppJl/RF9zpy4RFWMSyyJetXgLCzVIWarmKqV0Jf/zU5l1LKT7zXK1/qaznuQH/y1kMLD6SamusRcGwkRz+/IRxtMIo7To7jjy3RNlvvPr+3TgUFxxhK6GfWPwBbbTfh8a366P0EGWcKURwIlGojYCnUVMLwZe7FexSRrxe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HQa436zD; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e4d71ae6-0a90-4fed-9ab2-6c0abec52756@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728800161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qmdUU/Ns1Liy81kYj6oLsm/ff69KJenMJwBJC0zggRI=;
	b=HQa436zDRrmRXaA/sWdTbQ6KW1bI8X2PB4N4v00IhDi+U6wf0obcHscW32hShx8acxPCf6
	QpsBPSadBAVV+muPZLt071SIH+JMkOOtL51YCBDrgK0OgIBomEaDjmDiG74DeEAYX79aB4
	cUS1Pak2yajffHLR/4ELIXzLCU07Nks=
Date: Sun, 13 Oct 2024 14:15:33 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v8 3/6] RDMA/rxe: Add page invalidation support
To: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
 linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
 zyjzyj2000@gmail.com
Cc: linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com, lizhijian@fujitsu.com
References: <20241009015903.801987-1-matsuda-daisuke@fujitsu.com>
 <20241009015903.801987-4-matsuda-daisuke@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20241009015903.801987-4-matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/10/9 9:59, Daisuke Matsuda 写道:
> On page invalidation, an MMU notifier callback is invoked to unmap DMA
> addresses and update the driver page table(umem_odp->dma_list). It also
> sets the corresponding entries in MR xarray to NULL to prevent any access.
> The callback is registered when an ODP-enabled MR is created.
> 
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>   drivers/infiniband/sw/rxe/Makefile  |  2 +
>   drivers/infiniband/sw/rxe/rxe_odp.c | 57 +++++++++++++++++++++++++++++
>   2 files changed, 59 insertions(+)
>   create mode 100644 drivers/infiniband/sw/rxe/rxe_odp.c
> 
> diff --git a/drivers/infiniband/sw/rxe/Makefile b/drivers/infiniband/sw/rxe/Makefile
> index 5395a581f4bb..93134f1d1d0c 100644
> --- a/drivers/infiniband/sw/rxe/Makefile
> +++ b/drivers/infiniband/sw/rxe/Makefile
> @@ -23,3 +23,5 @@ rdma_rxe-y := \
>   	rxe_task.o \
>   	rxe_net.o \
>   	rxe_hw_counters.o
> +
> +rdma_rxe-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) += rxe_odp.o
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> new file mode 100644
> index 000000000000..ea55b79be0c6
> --- /dev/null
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/*
> + * Copyright (c) 2022-2023 Fujitsu Ltd. All rights reserved.
> + */
> +
> +#include <linux/hmm.h>
> +
> +#include <rdma/ib_umem_odp.h>
> +
> +#include "rxe.h"
> +
> +static void rxe_mr_unset_xarray(struct rxe_mr *mr, unsigned long start,
> +				unsigned long end)
> +{
> +	unsigned long upper = rxe_mr_iova_to_index(mr, end - 1);
> +	unsigned long lower = rxe_mr_iova_to_index(mr, start);
> +	void *entry;
> +
> +	XA_STATE(xas, &mr->page_list, lower);
> +
> +	/* make elements in xarray NULL */
> +	xas_lock(&xas);
> +	xas_for_each(&xas, entry, upper)
> +		xas_store(&xas, NULL);
> +	xas_unlock(&xas);
> +}
> +
> +static bool rxe_ib_invalidate_range(struct mmu_interval_notifier *mni,
> +				    const struct mmu_notifier_range *range,
> +				    unsigned long cur_seq)
> +{
> +	struct ib_umem_odp *umem_odp =
> +		container_of(mni, struct ib_umem_odp, notifier);
> +	struct rxe_mr *mr = umem_odp->private;
> +	unsigned long start, end;
> +
> +	if (!mmu_notifier_range_blockable(range))
> +		return false;
> +
> +	mutex_lock(&umem_odp->umem_mutex);

guard(mutex)(&umem_odp->umem_mutex);

It seems that the above is more popular.

Zhu Yanjun
> +	mmu_interval_set_seq(mni, cur_seq);
> +
> +	start = max_t(u64, ib_umem_start(umem_odp), range->start);
> +	end = min_t(u64, ib_umem_end(umem_odp), range->end);
> +
> +	rxe_mr_unset_xarray(mr, start, end);
> +
> +	/* update umem_odp->dma_list */
> +	ib_umem_odp_unmap_dma_pages(umem_odp, start, end);
> +
> +	mutex_unlock(&umem_odp->umem_mutex);
> +	return true;
> +}
> +
> +const struct mmu_interval_notifier_ops rxe_mn_ops = {
> +	.invalidate = rxe_ib_invalidate_range,
> +};


