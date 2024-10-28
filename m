Return-Path: <linux-rdma+bounces-5588-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 013EC9B3BAA
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2024 21:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD04B1F22DC9
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2024 20:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90551E1328;
	Mon, 28 Oct 2024 20:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="US8JWQ2a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E632D1E0DFD
	for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2024 20:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147179; cv=none; b=kqtFnhseVOM4D7aIU8b//Eqh5hVXbEzelkk0A5J+bCFPBujiTE6FNL4tPNo2ROiwHkY+kL3G33wsf2DWdHJsxiFmupXHWI+qqqZFYM2IHjnUcMSavtalu0cisqa3Ox0fa0kjFOOv7mCIbSbLyH4CZBhOjPeJox0TfsJ0qjtK3Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147179; c=relaxed/simple;
	bh=K73twS9ZNiv/QnZpRSZucEJbRp8Szc3Ew1O3XtrHI5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9SAQpMggWk3Lbn6Ol6gyY2E2Luik84Ru84rPW5TVO3kdhRNLbLDzMgd7tnuZlq+M5h+7Ez6yH/p5q+w9fYzy2nD+0MiMxq9wLANqfaSpZ9UKHtZrY+5HLSPAAWFM5nSh7IMmxJUfHC5pv/6yc/D4Brt15hFKj71uycleU9RQjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=US8JWQ2a; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ebff6ffc-9471-4393-aa8b-bbfe158335ea@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730147173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJtp3D5sNaPQ5R+iB/evMchUa9BNhvaLU71XvBoElyU=;
	b=US8JWQ2aZ87q7EVcA3PPn6LGSVD4decHD9rk7WyWzLtvA1csrzG5j/RskZFLT5/lIbTnqi
	+VEaZI112BajQnXQbi2Aa0EdlsMJTYT8W/XoNB9sDW5ZHUzpopC6q4bkIgWl9BpRcBhqjc
	aM9l2/m6ziR6hIcn115dtlWRFTmr+I4=
Date: Mon, 28 Oct 2024 21:26:10 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v8 3/6] RDMA/rxe: Add page invalidation support
To: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "leon@kernel.org" <leon@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
References: <20241009015903.801987-1-matsuda-daisuke@fujitsu.com>
 <20241009015903.801987-4-matsuda-daisuke@fujitsu.com>
 <e4d71ae6-0a90-4fed-9ab2-6c0abec52756@linux.dev>
 <OS3PR01MB986527D371D3840D1534A555E54A2@OS3PR01MB9865.jpnprd01.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <OS3PR01MB986527D371D3840D1534A555E54A2@OS3PR01MB9865.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/10/28 8:25, Daisuke Matsuda (Fujitsu) 写道:
> On Sun, Oct 13, 2024 3:16 PM Zhu Yanjun wrote:
>> 在 2024/10/9 9:59, Daisuke Matsuda 写道:
>>> On page invalidation, an MMU notifier callback is invoked to unmap DMA
>>> addresses and update the driver page table(umem_odp->dma_list). It also
>>> sets the corresponding entries in MR xarray to NULL to prevent any access.
>>> The callback is registered when an ODP-enabled MR is created.
>>>
>>> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
>>> ---
>>>    drivers/infiniband/sw/rxe/Makefile  |  2 +
>>>    drivers/infiniband/sw/rxe/rxe_odp.c | 57 +++++++++++++++++++++++++++++
>>>    2 files changed, 59 insertions(+)
>>>    create mode 100644 drivers/infiniband/sw/rxe/rxe_odp.c
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/Makefile b/drivers/infiniband/sw/rxe/Makefile
>>> index 5395a581f4bb..93134f1d1d0c 100644
>>> --- a/drivers/infiniband/sw/rxe/Makefile
>>> +++ b/drivers/infiniband/sw/rxe/Makefile
>>> @@ -23,3 +23,5 @@ rdma_rxe-y := \
>>>    	rxe_task.o \
>>>    	rxe_net.o \
>>>    	rxe_hw_counters.o
>>> +
>>> +rdma_rxe-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) += rxe_odp.o
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
>>> new file mode 100644
>>> index 000000000000..ea55b79be0c6
>>> --- /dev/null
>>> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
>>> @@ -0,0 +1,57 @@
>>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>>> +/*
>>> + * Copyright (c) 2022-2023 Fujitsu Ltd. All rights reserved.
>>> + */
>>> +
>>> +#include <linux/hmm.h>
>>> +
>>> +#include <rdma/ib_umem_odp.h>
>>> +
>>> +#include "rxe.h"
>>> +
>>> +static void rxe_mr_unset_xarray(struct rxe_mr *mr, unsigned long start,
>>> +				unsigned long end)
>>> +{
>>> +	unsigned long upper = rxe_mr_iova_to_index(mr, end - 1);
>>> +	unsigned long lower = rxe_mr_iova_to_index(mr, start);
>>> +	void *entry;
>>> +
>>> +	XA_STATE(xas, &mr->page_list, lower);
>>> +
>>> +	/* make elements in xarray NULL */
>>> +	xas_lock(&xas);
>>> +	xas_for_each(&xas, entry, upper)
>>> +		xas_store(&xas, NULL);
>>> +	xas_unlock(&xas);
>>> +}
>>> +
>>> +static bool rxe_ib_invalidate_range(struct mmu_interval_notifier *mni,
>>> +				    const struct mmu_notifier_range *range,
>>> +				    unsigned long cur_seq)
>>> +{
>>> +	struct ib_umem_odp *umem_odp =
>>> +		container_of(mni, struct ib_umem_odp, notifier);
>>> +	struct rxe_mr *mr = umem_odp->private;
>>> +	unsigned long start, end;
>>> +
>>> +	if (!mmu_notifier_range_blockable(range))
>>> +		return false;
>>> +
>>> +	mutex_lock(&umem_odp->umem_mutex);
>>
>> guard(mutex)(&umem_odp->umem_mutex);
>>
>> It seems that the above is more popular.
> 
> Thanks for the comment.
> 
> I have no objection to your suggestion since the increasing number of
> kernel components use "guard(mutex)" syntax these days, but I would rather
> suggest making the change to the whole infiniband subsystem at once because
> there are multiple mutex lock/unlock pairs to be converted.

If you want to make the such changes to the whole infiniband subsystem, 
I am fine with it.

The "guard(mutex)" is used in the following patch.

https://patchwork.kernel.org/project/linux-rdma/patch/20241009210048.4122518-1-bvanassche@acm.org/

Zhu Yanjun

> 
> Regards,
> Daisuke Matsuda
> 
>>
>> Zhu Yanjun
>>> +	mmu_interval_set_seq(mni, cur_seq);
>>> +
>>> +	start = max_t(u64, ib_umem_start(umem_odp), range->start);
>>> +	end = min_t(u64, ib_umem_end(umem_odp), range->end);
>>> +
>>> +	rxe_mr_unset_xarray(mr, start, end);
>>> +
>>> +	/* update umem_odp->dma_list */
>>> +	ib_umem_odp_unmap_dma_pages(umem_odp, start, end);
>>> +
>>> +	mutex_unlock(&umem_odp->umem_mutex);
>>> +	return true;
>>> +}
>>> +
>>> +const struct mmu_interval_notifier_ops rxe_mn_ops = {
>>> +	.invalidate = rxe_ib_invalidate_range,
>>> +};
> 


