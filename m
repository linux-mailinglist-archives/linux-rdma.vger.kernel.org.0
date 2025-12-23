Return-Path: <linux-rdma+bounces-15172-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7492BCD81D6
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 06:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DFAE30402CD
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 05:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D562F5328;
	Tue, 23 Dec 2025 05:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eXzmWJ8S"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881BC2F5319
	for <linux-rdma@vger.kernel.org>; Tue, 23 Dec 2025 05:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766466626; cv=none; b=b4j3tGmLmRvIeOZW6bRsUW3evKe6IjFrwHsxSMzUGY6LxFd36N0pYNBtLuR5MHto70CitDHLpwSSuKKy62Fx2i27GmswF0jIE2m1dsAhuvF1hYPV5g58fFUwEzJTrBqB+e1Tl7365IxhQGSkM3jOoY5GsgopzBuq/LnUEwe9DNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766466626; c=relaxed/simple;
	bh=iHOKXO6mFnd2IPu0P1IzGCgmip4n7PSZh5Os51Tl0TE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i9EWQAKLknIopSJMv6s5KfymByi0oxiHnip3Zvcttfm6cguUbw+ALK/WOwZKwfA5KSOM18L0My6ud22qeJcjIshD+jifRfLYK/xpamrS41ObPa8+EesuILHz4LDKOqqlx1ruknpX+sYOnoCB/bzaDp9FU1FN01CK6uzbOO3+lbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eXzmWJ8S; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4a8e3365-cb74-4531-99dc-9d2911045d4b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766466621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4QeBoNROkomjuU3Lz0zt3FxaiFZ9Nf7Z3nsvvVkkVfA=;
	b=eXzmWJ8Swwa0dtNuUgUMHJ3RPLGmHUakq4hW6xasz8C5o5EGFCRpuukLo+PAy27pfQW5OV
	tkFAYTTAqIv4dOobW0FhPInDC8TSlTlJjGx4B0ik+d6YDjcpjJHeL91St8TqLoMeZKBIa2
	2yJnf0iSn98y+tqqqtdnZomP251LeAw=
Date: Mon, 22 Dec 2025 21:10:11 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/1] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, zyjzyj2000@gmail.com,
 jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20251223044129.6232-1-yanjun.zhu@linux.dev>
 <ea716013-0149-40fa-b781-b0968980b7bd@embeddedor.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <ea716013-0149-40fa-b781-b0968980b7bd@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/12/22 21:03, Gustavo A. R. Silva 写道:
>
>
> On 12/23/25 13:41, Zhu Yanjun wrote:
>> From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
>>
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> Use the new TRAILING_OVERLAP() helper to fix the following warning:
>>
>> 21 drivers/infiniband/sw/rxe/rxe_verbs.h:271:33: warning: structure 
>> containing a flexible array member is not at the end of another 
>> structure [-Wflex-array-member-not-at-end]
>>
>> This helper creates a union between a flexible-array member (FAM) and a
>> set of MEMBERS that would otherwise follow it.
>>
>> This overlays the trailing MEMBER struct ib_sge sge[RXE_MAX_SGE]; onto
>> the FAM struct rxe_recv_wqe::dma.sge, while keeping the FAM and the
>> start of MEMBER aligned.
>>
>> The static_assert() ensures this alignment remains, and it's
>> intentionally placed inmediately after the related structure --no
>> blank line in between.
>>
>> Lastly, move the conflicting declaration struct rxe_resp_info resp;
>> to the end of the corresponding structure.
>>
>> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>> V2->V3: Replace struct ib_sge with struct rxe_sge
>
> What are you doing?

Because struct rxe_sge differs from struct ib_sge, I aligned it to use 
the same structure.

Yanjun.Zhu

>
> You're making a mess of this whole thing. Please, don't make changes
> to my patches on your own.
>
> -Gustavo
>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_verbs.h | 18 +++++++++++-------
>>   1 file changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h 
>> b/drivers/infiniband/sw/rxe/rxe_verbs.h
>> index fd48075810dd..3ffd7be8e7b1 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
>> @@ -219,12 +219,6 @@ struct rxe_resp_info {
>>       u32            rkey;
>>       u32            length;
>>   -    /* SRQ only */
>> -    struct {
>> -        struct rxe_recv_wqe    wqe;
>> -        struct ib_sge        sge[RXE_MAX_SGE];
>> -    } srq_wqe;
>> -
>>       /* Responder resources. It's a circular list where the oldest
>>        * resource is dropped first.
>>        */
>> @@ -232,7 +226,15 @@ struct rxe_resp_info {
>>       unsigned int        res_head;
>>       unsigned int        res_tail;
>>       struct resp_res        *res;
>> +
>> +    /* SRQ only */
>> +    /* Must be last as it ends in a flexible-array member. */
>> +    TRAILING_OVERLAP(struct rxe_recv_wqe, wqe, dma.sge,
>> +        struct rxe_sge        sge[RXE_MAX_SGE];
>> +    ) srq_wqe;
>>   };
>> +static_assert(offsetof(struct rxe_resp_info, srq_wqe.wqe.dma.sge) ==
>> +          offsetof(struct rxe_resp_info, srq_wqe.sge));
>>     struct rxe_qp {
>>       struct ib_qp        ibqp;
>> @@ -269,7 +271,6 @@ struct rxe_qp {
>>         struct rxe_req_info    req;
>>       struct rxe_comp_info    comp;
>> -    struct rxe_resp_info    resp;
>>         atomic_t        ssn;
>>       atomic_t        skb_out;
>> @@ -289,6 +290,9 @@ struct rxe_qp {
>>       spinlock_t        state_lock; /* guard requester and completer */
>>         struct execute_work    cleanup_work;
>> +
>> +    /* Must be last as it ends in a flexible-array member. */
>> +    struct rxe_resp_info    resp;
>>   };
>>     enum {
>
-- 
Best Regards,
Yanjun.Zhu


