Return-Path: <linux-rdma+bounces-14405-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8ACC4ECFA
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 16:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7D2188D7AC
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 15:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE1934A788;
	Tue, 11 Nov 2025 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AH/sxwr+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B55D2EAB79
	for <linux-rdma@vger.kernel.org>; Tue, 11 Nov 2025 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875469; cv=none; b=H0VYVjnaOlyUlBsY3OiH2hq8rVTeJ8zEzA1KsVyfb2GFWMc+pn0gdcSdo+w2jXkNYQqPh7CnwhvlRKX5tmJRnlbNm25+DSXKXSYpKb7iPZOt9xpoVbB0kp9WIXQenkNhFdzlrzkHth4bREcd91FxqogW/dOjNeTA3NvILOlMvlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875469; c=relaxed/simple;
	bh=tlRn2Zr6waGfESp+v75z26Egg0nYRqY7h018d106ygY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KDQ4DU+2bYCtVbG9uvtWkZwBbncZ1rfR0qMcGoza4+DAUgWvdkp6xxpilTgnI5Y0rnN2/Rw5c7VnUkKIf9kYcqqI337a0KR1512E1WbEprfbqDaeep7rel12D++6CYyenXngSGJCBS2/1el3gQK1P6vfe1JsbTYc0DZSbO9Zzog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AH/sxwr+; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b4d1988f-59ba-40a2-8d73-34fdecb4ff3f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762875464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bmRvIZCuGTuDP1eUFzMKvlZSU2aU2eVTuu31lnKyx8g=;
	b=AH/sxwr+BhLhqvyddla32yy/t/eDL9n80VI/XrOzQwOfxg+iZE9RiJA18GR6bdPtf3Fmyu
	TF08d+p3K/7G80I7IYWOUMVKRcyM2M6jra17u9yL3CS25PzPVzVewRgVD7Qr+nyf0+czn6
	Vi8yuw7WJ4hX+ldWR87emuQcXDpW4Cw=
Date: Tue, 11 Nov 2025 07:37:32 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH][next] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
To: Leon Romanovsky <leon@kernel.org>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aRKu5lNV04Sq82IG@kspp> <20251111115621.GO15456@unreal>
 <a9e5156b-2279-4ddd-992c-ca8ca7ab218a@embeddedor.com>
 <20251111141945.GQ15456@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20251111141945.GQ15456@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/11/11 6:19, Leon Romanovsky 写道:
> On Tue, Nov 11, 2025 at 09:14:05PM +0900, Gustavo A. R. Silva wrote:
>>
>> On 11/11/25 20:56, Leon Romanovsky wrote:
>>> On Tue, Nov 11, 2025 at 12:35:02PM +0900, Gustavo A. R. Silva wrote:
>>>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>>>> getting ready to enable it, globally.
>>>>
>>>> Use the new TRAILING_OVERLAP() helper to fix the following warning:
>>>>
>>>> 21 drivers/infiniband/sw/rxe/rxe_verbs.h:271:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>>>
>>>> This helper creates a union between a flexible-array member (FAM) and a
>>>> set of MEMBERS that would otherwise follow it.
>>>>
>>>> This overlays the trailing MEMBER struct ib_sge sge[RXE_MAX_SGE]; onto
>>>> the FAM struct rxe_recv_wqe::dma.sge, while keeping the FAM and the
>>>> start of MEMBER aligned.
>>>>
>>>> The static_assert() ensures this alignment remains, and it's
>>>> intentionally placed inmediately after the related structure --no
>>>> blank line in between.
>>>>
>>>> Lastly, move the conflicting declaration struct rxe_resp_info resp;
>>>> to the end of the corresponding structure.
>>>>
>>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>>> ---
>>>>    drivers/infiniband/sw/rxe/rxe_verbs.h | 18 +++++++++++-------
>>>>    1 file changed, 11 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
>>>> index fd48075810dd..6498d61e8956 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
>>>> @@ -219,12 +219,6 @@ struct rxe_resp_info {
>>>>    	u32			rkey;
>>>>    	u32			length;
>>>> -	/* SRQ only */
>>>> -	struct {
>>>> -		struct rxe_recv_wqe	wqe;
>>>> -		struct ib_sge		sge[RXE_MAX_SGE];
>>>> -	} srq_wqe;
>>>> -
>>>>    	/* Responder resources. It's a circular list where the oldest
>>>>    	 * resource is dropped first.
>>>>    	 */
>>>> @@ -232,7 +226,15 @@ struct rxe_resp_info {
>>>>    	unsigned int		res_head;
>>>>    	unsigned int		res_tail;
>>>>    	struct resp_res		*res;
>>>> +
>>>> +	/* SRQ only */
>>>> +	/* Must be last as it ends in a flexible-array member. */
>>>> +	TRAILING_OVERLAP(struct rxe_recv_wqe, wqe, dma.sge,
>>>> +		struct ib_sge		sge[RXE_MAX_SGE];
>>>> +	) srq_wqe;
>>> Will this change be enough?
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
>>> index fd48075810dd..9ab11421a585 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
>>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
>>> @@ -219,12 +219,6 @@ struct rxe_resp_info {
>>>           u32                     rkey;
>>>           u32                     length;
>>> -       /* SRQ only */
>>> -       struct {
>>> -               struct rxe_recv_wqe     wqe;
>>> -               struct ib_sge           sge[RXE_MAX_SGE];
>>> -       } srq_wqe;
>>> -
>>>           /* Responder resources. It's a circular list where the oldest
>>>            * resource is dropped first.
>>>            */
>>> @@ -232,6 +226,12 @@ struct rxe_resp_info {
>>>           unsigned int            res_head;
>>>           unsigned int            res_tail;
>>>           struct resp_res         *res;
>>> +
>>> +       /* SRQ only */
>>> +       struct {
>>> +               struct ib_sge           sge[RXE_MAX_SGE];
>>> +               struct rxe_recv_wqe     wqe;
>>> +       } srq_wqe;
>>>    };
>> The question is if this is really what you want?
>>
>> sge[RXE_MAX_SGE] is of the following type:
>>
>> struct ib_sge {
>>          u64     addr;
>>          u32     length;
>>          u32     lkey;
>> };
>>
>> and struct rxe_recv_wqe::dma.sge[] is of type:
>>
>> struct rxe_sge {
>>          __aligned_u64 addr;
>>          __u32   length;
>>          __u32   lkey;
>> };
>>
>> Both types are basically the same, and the original code looks
>> pretty much like what people do when they want to pre-allocate
>> a number of elements (of the same element type as the flex array)
>> for a flexible-array member.
>>
>> Based on the above, the change you suggest seems a bit suspicious,
>> and I'm not sure that's actually what you want?
> You wrote about this error: "warning: structure containing a flexible array
> member is not at the end of another structure".
>
> My suggestion was simply to move that flex array to be the last element
> and save us from the need to have some complex, magic macro in RXE.

Thanks, I agree with this approach. The macro is rather complicated, and 
this solution fixes the problem in a straightforward way.

Yanjun.Zhu

>
> Thanks
>
>> Thanks
>> -Gustavo
>>
>>
>>
>>
>>
-- 
Best Regards,
Yanjun.Zhu


