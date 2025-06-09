Return-Path: <linux-rdma+bounces-11076-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33356AD1930
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jun 2025 09:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0633B3A8E8B
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jun 2025 07:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656A1281365;
	Mon,  9 Jun 2025 07:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fCvy01g7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB139280CE3
	for <linux-rdma@vger.kernel.org>; Mon,  9 Jun 2025 07:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749455058; cv=none; b=PwtElayqQdjnYflxXy1A9xfx/s2uqehYPuz5I7KNhDDCyf43Z/HOVx9SRWVJx90l43NNukzyhUZerAtwJlkt5sGfLj+SeAeWn/d6EKCCj1qgtFts5veV5ylCrByU9q3TRzVwdnTjbfZ158w6s66J1h6uruHa/eW9j7Ndi9PupI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749455058; c=relaxed/simple;
	bh=0mfA7Y8zJjkO5xNZ04pd5i0B7sxsAJi1lpq6sRx9Rgs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=CWq6PRTy4P7MR9NJ2l8Wkg/k2iwMWDPjFpzUKvD02FoiFZe8M/S+mmujjyXskRaR+cZFjIUVPC/soP505oNcb2Ha/cv5FE/znAwzalRP0Hrv/VB9P4xdJqw/WDF3DJGqbIcynJGmhfwcZ7Ks8c5qiEPjjP9WSZBXwaMtmctWJMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fCvy01g7; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6fdaca52-af46-43a3-bbf2-495b4dc948a9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749455052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5R09Ow+CZYRCQW/wPIMVjU9Egw6xQUVJlOM4uexyCH4=;
	b=fCvy01g7Fj/R83mR+E1c24JEZ6TzjrNIBtaPB9TEEuKU2Zp6d7scspg7H5bA9drX4IMNjH
	SlG/Nkk3uuwbFaM5mm9M2bA+2FG29PnQ3M+Z2K034TCYUfq8jGC6y5cX4Ro+28ls64BwBR
	Ud8U+7vWAt5r7yjTGi73+1DYmBQfN8s=
Date: Mon, 9 Jun 2025 09:43:56 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v2] RDMA/rxe: Remove redundant page presence
 check
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: Daisuke Matsuda <dskmtsd@gmail.com>, linux-rdma@vger.kernel.org,
 leon@kernel.org, jgg@ziepe.ca, zyjzyj2000@gmail.com
References: <20250608095916.6313-1-dskmtsd@gmail.com>
 <c63d3202-8a5d-448d-b802-f8a7e0275265@linux.dev>
In-Reply-To: <c63d3202-8a5d-448d-b802-f8a7e0275265@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2025/6/8 13:23, Zhu Yanjun 写道:
> 在 2025/6/8 11:59, Daisuke Matsuda 写道:
>> hmm_pfn_to_page() does not return NULL. ib_umem_odp_map_dma_and_lock()
>> should return an error in case the target pages cannot be mapped until
>> timeout, so these checks can safely be removed.
>>
>> Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_odp.c | 13 +------------
>>   1 file changed, 1 insertion(+), 12 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/ 
>> sw/rxe/rxe_odp.c
>> index dbc5a5600eb7..02841346e30c 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
>> @@ -203,8 +203,6 @@ static int __rxe_odp_mr_copy(struct rxe_mr *mr, 
>> u64 iova, void *addr,
>>           page = hmm_pfn_to_page(umem_odp->map.pfn_list[idx]);
>>           user_va = kmap_local_page(page);
>> -        if (!user_va)
>> -            return -EFAULT;
>>           src = (dir == RXE_TO_MR_OBJ) ? addr : user_va;
>>           dest = (dir == RXE_TO_MR_OBJ) ? user_va : addr;
>> @@ -286,8 +284,6 @@ static enum resp_states 
>> rxe_odp_do_atomic_op(struct rxe_mr *mr, u64 iova,
>>       idx = rxe_odp_iova_to_index(umem_odp, iova);
>>       page_offset = rxe_odp_iova_to_page_offset(umem_odp, iova);
>>       page = hmm_pfn_to_page(umem_odp->map.pfn_list[idx]);
> 
> The function hmm_pfn_to_page will finally be "(mem_map + ((pfn) - 
> ARCH_PFN_OFFSET))"
> 
> The procedure is as below:
> 
> hmm_pfn_to_page -- > pfn_to_page -- > __pfn_to_page -- > (mem_map + 
> ((pfn) - ARCH_PFN_OFFSET))
> 
> Thus, I am fine with it.
> 
>> -    if (!page)
>> -        return RESPST_ERR_RKEY_VIOLATION;
>>       if (unlikely(page_offset & 0x7)) {
> 
> Normally page_offset error handler should be after this line 
> "page_offset = rxe_odp_iova_to_page_offset(umem_odp, iova);"
> 
> Why is this error handler after hmm_pfn_to_page?
> 
>>           rxe_dbg_mr(mr, "iova not aligned\n");
>> @@ -352,10 +348,6 @@ int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, 
>> u64 iova,
>>           page_offset = rxe_odp_iova_to_page_offset(umem_odp, iova);
>>           page = hmm_pfn_to_page(umem_odp->map.pfn_list[index]);
>> -        if (!page) {
>> -            mutex_unlock(&umem_odp->umem_mutex);
>> -            return -EFAULT;
>> -        }
>>           bytes = min_t(unsigned int, length,
>>                     mr_page_size(mr) - page_offset);
>> @@ -398,10 +390,7 @@ enum resp_states rxe_odp_do_atomic_write(struct 
>> rxe_mr *mr, u64 iova, u64 value)
>>       page_offset = rxe_odp_iova_to_page_offset(umem_odp, iova);
>>       index = rxe_odp_iova_to_index(umem_odp, iova);
>>       page = hmm_pfn_to_page(umem_odp->map.pfn_list[index]);
>> -    if (!page) {
>> -        mutex_unlock(&umem_odp->umem_mutex);
>> -        return RESPST_ERR_RKEY_VIOLATION;
>> -    }
>> +
>>       /* See IBA A19.4.2 */
>>       if (unlikely(page_offset & 0x7)) {
> 
> Ditto, page_offset error handler is not after the line "page_offset = 
> rxe_odp_iova_to_page_offset(umem_odp, iova);" ?

Other than that, I am fine with this commit.
Thanks,

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> 
> Thanks
> Yanjun.Zhu
> 
>>           mutex_unlock(&umem_odp->umem_mutex);
> 

-- 
Best Regards,
Yanjun.Zhu


