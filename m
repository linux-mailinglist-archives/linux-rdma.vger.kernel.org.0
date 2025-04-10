Return-Path: <linux-rdma+bounces-9317-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F63A837D9
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 06:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EBF23AB4CC
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 04:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EE11F1534;
	Thu, 10 Apr 2025 04:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wpbdbpmh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1632684D13
	for <linux-rdma@vger.kernel.org>; Thu, 10 Apr 2025 04:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744259438; cv=none; b=QGbfrx/73kBDwVy2IcN5KBqsUeRnmQ6+gR5P2UMN70vv5gW7n3O39og7c6iYFfliPqcj9ANGpYlelwWhtEnOETugrMdWl25LhrhPVM9q0bRh8oq4OxhPSucV7BcAJqBGM0IziWdwzbO7iMfhGomGwy1Q3LCopS4ohO6NU7uxauo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744259438; c=relaxed/simple;
	bh=v56FT6wdfev/orI7h0IGGtpABYorq46hKEBr3q9jzUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b3TSmOJWsKr4FJhglI0vk90kCDLQQ8KLNS6LUrGyS5yXPjTyg2zPTvGUrBRTGhjDcfSrpFRPhANw5Q77CmLDkzsnrCOwEBMUtGKjQ2oC8J6eupfuL3MDHCZiv9T3Z7BEPycRIruJY9UE4FS1k/yP7lIA456KjobVqdMPwEibaFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wpbdbpmh; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3dc398e9-d3fd-48d4-b9de-6e86f5450abf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744259432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=deriVsJRzPJJfufRN/9/kDOLZ0Q8ZV4nOR2QaVz2Fgo=;
	b=wpbdbpmhfI7f1jLIMij3RAeeWSjzn0GkUkUaml7pOi1a0t2Fy48pjBLR5bL0hVfuNMJs53
	Hu+B0Q8ajgOxhGkqtzU6hohplqlZcuQKY/GKuZTG67H/MyfuUVzgvhV352wdYTog7oh3N/
	1j9xZOAab39DW5io17v0x1dcHmTirDg=
Date: Thu, 10 Apr 2025 06:30:30 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next] RDMA/rxe: Fix mismatched type declarations
To: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
 linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
 zyjzyj2000@gmail.com
References: <20250409102701.1275265-1-matsuda-daisuke@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250409102701.1275265-1-matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/4/9 12:27, Daisuke Matsuda 写道:
> Some functions return int values while they are defined as enum resp_states
> variables. This patch resolve the mismatches in rxe.
                         resolves ?
Thanks a lot.
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun
> 
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_loc.h | 14 +++++++-------
>   drivers/infiniband/sw/rxe/rxe_mr.c  | 12 ++++++------
>   drivers/infiniband/sw/rxe/rxe_odp.c | 11 ++++++-----
>   3 files changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index d27bd05ed21f..a3ce64249357 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -70,9 +70,9 @@ int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
>   	      void *addr, int length, enum rxe_mr_copy_dir dir);
>   int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
>   		  int sg_nents, unsigned int *sg_offset);
> -int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
> -			u64 compare, u64 swap_add, u64 *orig_val);
> -int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value);
> +enum resp_states rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
> +				     u64 compare, u64 swap_add, u64 *orig_val);
> +enum resp_states rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value);
>   struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
>   			 enum rxe_mr_lookup_type type);
>   int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
> @@ -192,8 +192,8 @@ int rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
>   			 u64 iova, int access_flags, struct rxe_mr *mr);
>   int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
>   		    enum rxe_mr_copy_dir dir);
> -int rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
> -			 u64 compare, u64 swap_add, u64 *orig_val);
> +enum resp_states rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
> +				   u64 compare, u64 swap_add, u64 *orig_val);
>   int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
>   			    unsigned int length);
>   #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
> @@ -208,9 +208,9 @@ static inline int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
>   {
>   	return -EOPNOTSUPP;
>   }
> -static inline int
> +static inline enum resp_states
>   rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
> -		     u64 compare, u64 swap_add, u64 *orig_val)
> +		  u64 compare, u64 swap_add, u64 *orig_val)
>   {
>   	return RESPST_ERR_UNSUPPORTED_OPCODE;
>   }
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index d40fbe10633f..1a74013a14ab 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -483,8 +483,8 @@ int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 start, unsigned int length)
>   /* Guarantee atomicity of atomic operations at the machine level. */
>   DEFINE_SPINLOCK(atomic_ops_lock);
>   
> -int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
> -			u64 compare, u64 swap_add, u64 *orig_val)
> +enum resp_states rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
> +				     u64 compare, u64 swap_add, u64 *orig_val)
>   {
>   	unsigned int page_offset;
>   	struct page *page;
> @@ -536,12 +536,12 @@ int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
>   
>   	kunmap_local(va);
>   
> -	return 0;
> +	return RESPST_NONE;
>   }
>   
>   #if defined CONFIG_64BIT
>   /* only implemented or called for 64 bit architectures */
> -int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
> +enum resp_states rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
>   {
>   	unsigned int page_offset;
>   	struct page *page;
> @@ -578,10 +578,10 @@ int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
>   	smp_store_release(&va[page_offset >> 3], value);
>   	kunmap_local(va);
>   
> -	return 0;
> +	return RESPST_NONE;
>   }
>   #else
> -int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
> +enum resp_states rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
>   {
>   	return RESPST_ERR_UNSUPPORTED_OPCODE;
>   }
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> index 02de05d759c6..fa5e8f5017cc 100644
> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -266,8 +266,9 @@ int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
>   	return err;
>   }
>   
> -static int rxe_odp_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
> -				u64 compare, u64 swap_add, u64 *orig_val)
> +static enum resp_states rxe_odp_do_atomic_op(struct rxe_mr *mr, u64 iova,
> +					     int opcode, u64 compare,
> +					     u64 swap_add, u64 *orig_val)
>   {
>   	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
>   	unsigned int page_offset;
> @@ -315,11 +316,11 @@ static int rxe_odp_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
>   
>   	kunmap_local(va);
>   
> -	return 0;
> +	return RESPST_NONE;
>   }
>   
> -int rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
> -			 u64 compare, u64 swap_add, u64 *orig_val)
> +enum resp_states rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
> +				   u64 compare, u64 swap_add, u64 *orig_val)
>   {
>   	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
>   	int err;


