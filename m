Return-Path: <linux-rdma+bounces-5336-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 958A5996D5F
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 16:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55CD9283879
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 14:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F1D199FB0;
	Wed,  9 Oct 2024 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="I635BCsR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053DA198A32;
	Wed,  9 Oct 2024 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728483221; cv=none; b=aa/m54TS32m2FJdZnchvD0vee6nR7uz26sNlltRl+I4ZG0shQipoqAn1dRKS9v2sjFRw7MD+82kJwj6FedyEpoXDkmSIGYIWdgZPSSOqqefjW1tbBaHWigqjDKX3x7WVaFXmReOmA6TIYjXoE/Db5qXoimnD7iomq4gDi2pO49o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728483221; c=relaxed/simple;
	bh=ZGV4OkMYzwMYUiMF1vIbqfSwx1Sle7VLdz9HhEdj/BE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=okV+K3hJhx2CPDvQR3qDyw9qoalQitUjn7NytzWFWehnoqHyXlTqNABlwjejGVznQaCZ+v4ILevRuH5CsturleHcBE76mfFzXcHm03aIhVdLVyHwIwoSyIrqhPR8Pai0GtwhVATi7/yGnAtW+OFDusgkiK1htRpzQ9vqr/mxWpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=I635BCsR; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=a1Wwn7npiqzFsNRpMJ+6JXVmBOnB+HGGdwRrmxJ/sSY=;
	b=I635BCsRTmWDExrNajMHEJ3psS4NiQA4ENHv2ueGw567psgb/+8E6KkuCSSl23
	rUTuWxvyCuHdz3j7q4e5bEBaQm1ozb6bq+8kIarJP5c8oLegVHSBngsw7MPQk2tG
	14WaIClUxcq+FQsMpJZnNjDsQku23Kq5GW+wt0byewcS4=
Received: from [192.168.3.4] (unknown [123.121.183.169])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3X195jwZnNM1gAA--.10119S2;
	Wed, 09 Oct 2024 22:13:14 +0800 (CST)
Message-ID: <67b556bc-2d48-4e7b-a00a-6b38512c8e8f@163.com>
Date: Wed, 9 Oct 2024 22:13:12 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v8 1/6] RDMA/rxe: Make MR functions accessible
 from other rxe source code
To: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
 linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
 zyjzyj2000@gmail.com
Cc: linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com, lizhijian@fujitsu.com
References: <20241009015903.801987-1-matsuda-daisuke@fujitsu.com>
 <20241009015903.801987-2-matsuda-daisuke@fujitsu.com>
From: Zhu Yanjun <mounter625@163.com>
In-Reply-To: <20241009015903.801987-2-matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X195jwZnNM1gAA--.10119S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCry5Cw48KrWrtr45tFy8AFb_yoWrGF4fpF
	18tw15Ars3Xr4UuF4IyFWDZF4akwsxK3srG3sxt34YvFya9w43XFs29Fy2vas5AFWDua1f
	KF1xJrnrCw45GFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UsvttUUUUU=
X-CM-SenderInfo: hprx03thuwjki6rwjhhfrp/1tbiLxJzOGcGgtzZ8QABsg


在 2024/10/9 9:58, Daisuke Matsuda 写道:
> Some functions in rxe_mr.c are going to be used in rxe_odp.c, which is to
> be created in the subsequent patch. List the declarations of the functions
> in rxe_loc.h.
>
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_loc.h |  8 ++++++++
>   drivers/infiniband/sw/rxe/rxe_mr.c  | 11 +++--------
>   2 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index ded46119151b..866c36533b53 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -58,6 +58,7 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
>   
>   /* rxe_mr.c */
>   u8 rxe_get_next_key(u32 last_key);
> +void rxe_mr_init(int access, struct rxe_mr *mr);
>   void rxe_mr_init_dma(int access, struct rxe_mr *mr);
>   int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
>   		     int access, struct rxe_mr *mr);
> @@ -69,6 +70,8 @@ int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
>   	      void *addr, int length, enum rxe_mr_copy_dir dir);
>   int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
>   		  int sg_nents, unsigned int *sg_offset);
> +int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
> +		       unsigned int length, enum rxe_mr_copy_dir dir);
>   int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
>   			u64 compare, u64 swap_add, u64 *orig_val);
>   int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value);
> @@ -80,6 +83,11 @@ int rxe_invalidate_mr(struct rxe_qp *qp, u32 key);
>   int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
>   void rxe_mr_cleanup(struct rxe_pool_elem *elem);
>   
> +static inline unsigned long rxe_mr_iova_to_index(struct rxe_mr *mr, u64 iova)
> +{
> +	return (iova >> mr->page_shift) - (mr->ibmr.iova >> mr->page_shift);
> +}

The type of the function rxe_mr_iova_to_index is "unsigned long". In 
some 32 architecture, unsigned long is 32 bit.

The type of iova is u64. So it had better use u64 instead of "unsigned 
long".

Zhu Yanjun

> +
>   /* rxe_mw.c */
>   int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata);
>   int rxe_dealloc_mw(struct ib_mw *ibmw);
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index da3dee520876..1f7b8cf93adc 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -45,7 +45,7 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
>   	}
>   }
>   
> -static void rxe_mr_init(int access, struct rxe_mr *mr)
> +void rxe_mr_init(int access, struct rxe_mr *mr)
>   {
>   	u32 key = mr->elem.index << 8 | rxe_get_next_key(-1);
>   
> @@ -72,11 +72,6 @@ void rxe_mr_init_dma(int access, struct rxe_mr *mr)
>   	mr->ibmr.type = IB_MR_TYPE_DMA;
>   }
>   
> -static unsigned long rxe_mr_iova_to_index(struct rxe_mr *mr, u64 iova)
> -{
> -	return (iova >> mr->page_shift) - (mr->ibmr.iova >> mr->page_shift);
> -}
> -
>   static unsigned long rxe_mr_iova_to_page_offset(struct rxe_mr *mr, u64 iova)
>   {
>   	return iova & (mr_page_size(mr) - 1);
> @@ -242,8 +237,8 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sgl,
>   	return ib_sg_to_pages(ibmr, sgl, sg_nents, sg_offset, rxe_set_page);
>   }
>   
> -static int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
> -			      unsigned int length, enum rxe_mr_copy_dir dir)
> +int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
> +		       unsigned int length, enum rxe_mr_copy_dir dir)
>   {
>   	unsigned int page_offset = rxe_mr_iova_to_page_offset(mr, iova);
>   	unsigned long index = rxe_mr_iova_to_index(mr, iova);


