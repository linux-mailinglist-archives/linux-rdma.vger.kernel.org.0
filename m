Return-Path: <linux-rdma+bounces-5359-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 534C59981F4
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 11:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01641F2103E
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 09:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B32F1C232C;
	Thu, 10 Oct 2024 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nevK7/F3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C4E1A08C5;
	Thu, 10 Oct 2024 09:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551904; cv=none; b=fFxnCcVAIo5z/u+n65Q/K4ZW/emcBxuYaAW/IgkLFkfmT6X2S1Kgypbj88ZLP1E5X4fCK6caEbT75ZatvS/WjF9iAPGupLeFBHC5AHVB+H2PGorTc2wPQYCm1Y0QG0pc/oYBnuSYiSpngE0h9I9yhSHJxjJCMAdo1HCPLPsYDiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551904; c=relaxed/simple;
	bh=o5MuIvxIUnivlFyLRicp072rOEjQXAWhefHm0FvmKBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ucyj3SzSLzQkSkkKllZTrPpj/c4x5nE9CW6O/knFHuvfiPFaH4wHRpBBy1S6SwgICtgPKNI1whVMht24KXw8qKjh/zkEw6PGrz4AbaHsAXsVaFO/bQJeFHIG1DCZVjprrFw86EFgbCJvosfGKUvnnUjscvJ5nmudHfkBbH/D7M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nevK7/F3; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <753c0fcb-0c6f-45a1-b132-4411c87374d3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728551898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LUpSL0X47miIjsCwsRHHTU9qz1EFobrV9JdRqDcum6s=;
	b=nevK7/F3GRka16cRzQTy8p/aqMPwjH4dC/S/Okz8D8TcL1FyvFWvumkjeQPmztUlfdFmuO
	t6xAj/0KnzKMQKYY0zkGMTeGUuvDN/kk4SsGiHHKDfrVufiEh1W67E9X/n5PaAKv4DWQbU
	3wptXHPAgDZcNBI6qgO5r+yWV+j5UXk=
Date: Thu, 10 Oct 2024 17:18:10 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v8 1/6] RDMA/rxe: Make MR functions accessible
 from other rxe source code
To: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
 'Zhu Yanjun' <mounter625@163.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "leon@kernel.org" <leon@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
References: <20241009015903.801987-1-matsuda-daisuke@fujitsu.com>
 <20241009015903.801987-2-matsuda-daisuke@fujitsu.com>
 <67b556bc-2d48-4e7b-a00a-6b38512c8e8f@163.com>
 <OS3PR01MB986550BAFCFA30D409F5A089E5782@OS3PR01MB9865.jpnprd01.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <OS3PR01MB986550BAFCFA30D409F5A089E5782@OS3PR01MB9865.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/10/10 15:24, Daisuke Matsuda (Fujitsu) 写道:
> On Wed, Oct 9, 2024 11:13 PM Zhu Yanjun wrote:
>>
>>
>> 在 2024/10/9 9:58, Daisuke Matsuda 写道:
>>> Some functions in rxe_mr.c are going to be used in rxe_odp.c, which is to
>>> be created in the subsequent patch. List the declarations of the functions
>>> in rxe_loc.h.
>>>
>>> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
>>> ---
>>>    drivers/infiniband/sw/rxe/rxe_loc.h |  8 ++++++++
>>>    drivers/infiniband/sw/rxe/rxe_mr.c  | 11 +++--------
>>>    2 files changed, 11 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
>>> index ded46119151b..866c36533b53 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
>>> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
>>> @@ -58,6 +58,7 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
>>>
>>>    /* rxe_mr.c */
>>>    u8 rxe_get_next_key(u32 last_key);
>>> +void rxe_mr_init(int access, struct rxe_mr *mr);
>>>    void rxe_mr_init_dma(int access, struct rxe_mr *mr);
>>>    int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
>>>    		     int access, struct rxe_mr *mr);
>>> @@ -69,6 +70,8 @@ int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
>>>    	      void *addr, int length, enum rxe_mr_copy_dir dir);
>>>    int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
>>>    		  int sg_nents, unsigned int *sg_offset);
>>> +int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
>>> +		       unsigned int length, enum rxe_mr_copy_dir dir);
>>>    int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
>>>    			u64 compare, u64 swap_add, u64 *orig_val);
>>>    int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value);
>>> @@ -80,6 +83,11 @@ int rxe_invalidate_mr(struct rxe_qp *qp, u32 key);
>>>    int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
>>>    void rxe_mr_cleanup(struct rxe_pool_elem *elem);
>>>
>>> +static inline unsigned long rxe_mr_iova_to_index(struct rxe_mr *mr, u64 iova)
>>> +{
>>> +	return (iova >> mr->page_shift) - (mr->ibmr.iova >> mr->page_shift);
>>> +}
>>
>> The type of the function rxe_mr_iova_to_index is "unsigned long". In
>> some 32 architecture, unsigned long is 32 bit.
>>
>> The type of iova is u64. So it had better use u64 instead of "unsigned
>> long".
>>
>> Zhu Yanjun
> 
> Hi,
> thanks for the comment.
> 
> I think the current type declaration doesn't matter in 32-bit OS.
> The function returns an index of the page specified with 'iova'.
> Assuming the page size is typical 4KiB, u32 index can accommodate
> 16 TiB in total, which is larger than the theoretical limit imposed
> on 32-bit systems (i.e. 4GiB or 2^32 Bytes).

But in 32 bit OS, this will likely pop out "type does not match" warning 
because "unsigned long" is 32 bit in 32-bit OS while u64 is always 64 
bit. So it is better to use u64 type. This will not pop out any warnings 
whether in 32bit OS or in 64bit OS.

Zhu Yanjun
> 
> Regards,
> Daisuke Matsuda
> 
>>
>>> +
>>>    /* rxe_mw.c */
>>>    int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata);
>>>    int rxe_dealloc_mw(struct ib_mw *ibmw);
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
>>> index da3dee520876..1f7b8cf93adc 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
>>> @@ -45,7 +45,7 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
>>>    	}
>>>    }
>>>
>>> -static void rxe_mr_init(int access, struct rxe_mr *mr)
>>> +void rxe_mr_init(int access, struct rxe_mr *mr)
>>>    {
>>>    	u32 key = mr->elem.index << 8 | rxe_get_next_key(-1);
>>>
>>> @@ -72,11 +72,6 @@ void rxe_mr_init_dma(int access, struct rxe_mr *mr)
>>>    	mr->ibmr.type = IB_MR_TYPE_DMA;
>>>    }
>>>
>>> -static unsigned long rxe_mr_iova_to_index(struct rxe_mr *mr, u64 iova)
>>> -{
>>> -	return (iova >> mr->page_shift) - (mr->ibmr.iova >> mr->page_shift);
>>> -}
>>> -
>>>    static unsigned long rxe_mr_iova_to_page_offset(struct rxe_mr *mr, u64 iova)
>>>    {
>>>    	return iova & (mr_page_size(mr) - 1);
>>> @@ -242,8 +237,8 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sgl,
>>>    	return ib_sg_to_pages(ibmr, s"gl, sg_nents, sg_offset, rxe_set_page);
>>>    }
>>>
>>> -static int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
>>> -			      unsigned int length, enum rxe_mr_copy_dir dir)
>>> +int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
>>> +		       unsigned int length, enum rxe_mr_copy_dir dir)
>>>    {
>>>    	unsigned int page_offset = rxe_mr_iova_to_page_offset(mr, iova);
>>>    	unsigned long index = rxe_mr_iova_to_index(mr, iova);
> 


