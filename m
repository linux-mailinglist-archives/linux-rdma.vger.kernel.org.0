Return-Path: <linux-rdma+bounces-8591-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D31EA5D731
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 08:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D5BF168558
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 07:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A29A1E9B00;
	Wed, 12 Mar 2025 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QECA4D8l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A639419D087
	for <linux-rdma@vger.kernel.org>; Wed, 12 Mar 2025 07:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741763954; cv=none; b=Q0734SirdtVRmJvu2Nd1g+FQqngjiBsu4qg8wByqjua1zYATKlG33UOW1Cq2aVUpyieBc8ARJrfKmZ1k9j21xHfPDj6pE8aNjKMQlg4IUlWrk3AS/G1W074dw3KyilmC+oL6/p3/Ddo+hQ70WDZghKni8k03xXEII7Tz+2YvH6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741763954; c=relaxed/simple;
	bh=qpb5Bi3+ehebnPAAJE/iTme474AeaTlqvE9Tp+sODxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Uo0ksLyp9FaMmwjwiuoPTu5Pega69HjbbgZxDJr5HToaz9MQSVHfpWTWFhEPuWb0MrqHU1if1NTmI4RZZKAqwMB/SX/RXmwtS0wX8bfU4OUF653ytI50Wi479OWvkpX9byUJ/RR+x/8hs4OjNOgnAuhtkjqNpN4/amm+RRCOlt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QECA4D8l; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0fbeb3f2-7074-404c-8915-72fa12f1cbcf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741763944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qwx7qRe1wYNnGijfvRoMToL/lWBGbSFfjGdVDPId27I=;
	b=QECA4D8lzwUlNfkNszcU/ypkIWd8s7FIeqFwi4xFBcGhqbcV0Zj/weeMkga8OZ1dEAz9DO
	GWXWHAJnMHRosUX4QvOvSAwkVLBLN68MvUyNd4/ZH1Ls+1RSYqHyxVOx6tXDBPJhTt3Id8
	A2VJU6bGQbykINEBV4TzD3C5HjRGNA8=
Date: Wed, 12 Mar 2025 08:19:00 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next] RDMA/rxe: Improve readability of ODP pagefault
 interface
To: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
 linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
 zyjzyj2000@gmail.com
References: <20250312065937.1787241-1-matsuda-daisuke@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250312065937.1787241-1-matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/3/12 7:59, Daisuke Matsuda 写道:
> Use a meaningful constant explicitly instead of hard-coding a literal.
> 
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_odp.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> index a82e5011360c..94f7bbe14981 100644
> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -37,8 +37,9 @@ const struct mmu_interval_notifier_ops rxe_mn_ops = {
>   	.invalidate = rxe_ib_invalidate_range,
>   };
>   
> -#define RXE_PAGEFAULT_RDONLY BIT(1)
> -#define RXE_PAGEFAULT_SNAPSHOT BIT(2)
> +#define RXE_PAGEFAULT_DEFAULT 0
> +#define RXE_PAGEFAULT_RDONLY BIT(0)
> +#define RXE_PAGEFAULT_SNAPSHOT BIT(1)
>   static int rxe_odp_do_pagefault_and_lock(struct rxe_mr *mr, u64 user_va, int bcnt, u32 flags)
>   {
>   	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
> @@ -222,7 +223,7 @@ int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
>   		    enum rxe_mr_copy_dir dir)
>   {
>   	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
> -	u32 flags = 0;
> +	u32 flags = RXE_PAGEFAULT_DEFAULT;
>   	int err;
>   
>   	if (length == 0)
> @@ -236,7 +237,7 @@ int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
>   		break;
>   
>   	case RXE_FROM_MR_OBJ:
> -		flags = RXE_PAGEFAULT_RDONLY;
> +		flags |= RXE_PAGEFAULT_RDONLY;

The above "|=" is different from the original "=". I am not sure if it 
is correct or not. But in this function, because flags is set 0 at 
first. Thus, the result is the same.

Except the above, I am fine with this commit.
Thanks a lot.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

>   		break;
>   
>   	default:
> @@ -312,7 +313,8 @@ int rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
>   	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
>   	int err;
>   
> -	err = rxe_odp_map_range_and_lock(mr, iova, sizeof(char), 0);
> +	err = rxe_odp_map_range_and_lock(mr, iova, sizeof(char),
> +					 RXE_PAGEFAULT_DEFAULT);
>   	if (err < 0)
>   		return err;
>   


