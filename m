Return-Path: <linux-rdma+bounces-15227-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B790FCDF32E
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Dec 2025 02:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AB363008EB1
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Dec 2025 01:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA991E3DDE;
	Sat, 27 Dec 2025 01:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q/C/FR2I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B391D7E5C
	for <linux-rdma@vger.kernel.org>; Sat, 27 Dec 2025 01:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766797531; cv=none; b=rObeIWbxRGv4WoFyP1VAPjxncn2a6r3/nZVhfpGRTjSUP9bqe/z4Ae35MAa31GUU7owPgTiyVNgpCTIHa9svNfL11V5+i/3tjOEHtJDdeVKOZi5Llkm+YO/iGU6e9U1+594eK0WiPaXr43VVStcQRvhIcT8C2z2AAUW3A1umm2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766797531; c=relaxed/simple;
	bh=eTr7E1hFI0Z638AR6xMWYsCe44y0ITPF2x1s3wMhlwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uchr7BD2OyThwFR1AgkAuQg4xAjFm8V560iYdOm8XfPyVGg1WOJnklaaiMH1ZS9ezIhz5qVQ0O/+p6aXO1xm8bDaNuYC7u+mHdTDAhqHC1FGnYKp9MixpqJV5DHfHr1pEB9cwuv0wOM/nLa76soKMz0yuCNb2pubVf6bhgXmh7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q/C/FR2I; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <deb756fc-dc58-4689-ac0e-632944830871@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766797517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=snbVay3909GxwajTMVnM4uHMZklR3MVO4iSpela2JZE=;
	b=Q/C/FR2IQ9dAIYXYr4GmLY58VMUGISKKgf5ViUoIJNjYj4DB+4+0nXezW07iPTjdaqCtze
	ZniiLmM6hLNW053AKx7I4ViXQpahAbwwna5ej9j5DOaGUkzUGEkH3Ig4I7goVmFFyExvrD
	XPd9nOkMe5z9s9bqTy/bYFCiFniR/PM=
Date: Fri, 26 Dec 2025 17:05:09 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] IB/rxe: ODP: Fix missing umem_odp->umem_mutex unlock
To: Li Zhijian <lizhijian@fujitsu.com>, linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, zyjzyj2000@gmail.com, jgg@ziepe.ca,
 leon@kernel.org, Daisuke Matsuda <dskmtsd@gmail.com>
References: <20251226094112.3042583-1-lizhijian@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20251226094112.3042583-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/12/26 1:41, Li Zhijian 写道:
> rxe_odp_map_range_and_lock() should unlock umem_odp->umem_mutex on error.
>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_odp.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> index 8b6a8b064d3c..d22b08da2713 100644
> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -178,8 +178,10 @@ static int rxe_odp_map_range_and_lock(struct rxe_mr *mr, u64 iova, int length, u
>   			return err;
>   
160 static int rxe_odp_map_range_and_lock(struct rxe_mr *mr, u64 iova, 
int length, u32 flags)
161 {
162     struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
163     bool need_fault;
164     int err;
165
166     if (unlikely(length < 1))
167         return -EINVAL;
168
169     mutex_lock(&umem_odp->umem_mutex);
170
171     need_fault = rxe_check_pagefault(umem_odp, iova, length);
172     if (need_fault) {
173         mutex_unlock(&umem_odp->umem_mutex);
174
175         /* umem_mutex is locked on success. */
176         err = rxe_odp_do_pagefault_and_lock(mr, iova, length,
177                             flags);
178         if (err < 0)

179             return err;

If the function rxe_odp_do_pagefault_and_lock() succeeds and run here, 
the mutex lock umem_mutex should be held.

Thus, if rxe_check_pagefault fails, the mutex lock umem_mutex should be 
released.

as such, I am fine with this.

But IMO, the commit log is too simple. The above explanations should be 
added into the commit logs.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

180
181         need_fault = rxe_check_pagefault(umem_odp, iova, length);
182         if (need_fault)
183             return -EFAULT;
184     }
185
186     return 0;
187 }

>   		need_fault = rxe_check_pagefault(umem_odp, iova, length);
> -		if (need_fault)
> +		if (need_fault) {
> +			mutex_unlock(&umem_odp->umem_mutex);
>   			return -EFAULT;
> +		}
>   	}
>   
>   	return 0;

-- 
Best Regards,
Yanjun.Zhu


