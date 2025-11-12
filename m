Return-Path: <linux-rdma+bounces-14434-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C85AC518E1
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 11:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 140614FCE0D
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 09:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E87F30171C;
	Wed, 12 Nov 2025 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Duqb3qa8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from omta033.useast.a.cloudfilter.net (omta033.useast.a.cloudfilter.net [44.202.169.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF31A3016F4
	for <linux-rdma@vger.kernel.org>; Wed, 12 Nov 2025 09:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762941046; cv=none; b=Ko8nW5FxT5n5TR0XC8eTDEZEYsQtFSWJ5RGyeO+wTMJL8RGH/4JJx/RN17i304dKzrFwrbu20nyVr3s5h1AvPg7e9ZT2EAeoYwFPL40w4ea03e9j9dtEoinKd3/xdkkBd6qODwBOpD0P61L1n2IvoDhiixRhWu4J7co83KuqzFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762941046; c=relaxed/simple;
	bh=AC3MOhYO8DSa29GuaR3KdYqR1Gguu8KO06nIXg1bM1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a+RYllzp7Xg706+SkUQSTJlEvfaMbnkAWdd6hzDxp71kGRUkKJhQKIGAGjp1agT5pyVdFxSv07EAuzW9h40GjVfHQQ0ARwu+vPrDY2RMki/TMWIcXilc9Dya6WR5a8I9XATdnyTO/qkXpuPxmLINiZ8z9jd5vlBIgO84X9YvLEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=Duqb3qa8; arc=none smtp.client-ip=44.202.169.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6002b.ext.cloudfilter.net ([10.0.30.203])
	by cmsmtp with ESMTPS
	id IzDRvXkWSU1JTJ7UsvqJQ9; Wed, 12 Nov 2025 09:50:38 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id J7Urvx0dc74Z0J7Urv1uBy; Wed, 12 Nov 2025 09:50:38 +0000
X-Authority-Analysis: v=2.4 cv=BuidwZX5 c=1 sm=1 tr=0 ts=6914586e
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=/rTUtUX7FYEHxajpTiXOmQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=T12EsnaS-Ic_O6hANdoA:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/kv3ZpLKh6gznCrSgB5U7whYig4jSVMOfINntMIp8x0=; b=Duqb3qa867oEuxQl6tlQc9u4J5
	HmmBofuVhSAhZ3A2I3bMMNGs+XpzZSFp3SwSjjNo5wnv0eRfyhpmHT81I/NS2xlbADrS7ZhDhPbA6
	nEhHVMsB95su7zLFbQ2a5NUdF/gKn10BCdfHmQ3AMVS750xY/cVJ2KniWNRTkZJaFUjhAQANYxmWo
	FGqlZGiRaQPKrLnEr+3XsfKT3ygOzQG2U0W3sHykmjo0tA0zpN1YMbMzdT81sg/X8s+1AvL038hIQ
	kg5rXXnuAQMewwMFsVVpbUoqHDREbGnrjFEjGIFfNc5kcsC3/UTI+Y+LFXcDlgg6pu3qDwc3wzWv8
	nCPwkyXA==;
Received: from [61.251.99.135] (port=24341 helo=[10.28.115.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vJ7Uq-00000000ru5-21T2;
	Wed, 12 Nov 2025 03:50:37 -0600
Message-ID: <01dde656-f41f-48f1-944c-b69cf1c3543e@embeddedor.com>
Date: Wed, 12 Nov 2025 18:50:16 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
To: Leon Romanovsky <leon@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aRKu5lNV04Sq82IG@kspp> <20251111115621.GO15456@unreal>
 <a9e5156b-2279-4ddd-992c-ca8ca7ab218a@embeddedor.com>
 <20251111141945.GQ15456@unreal>
 <d3336e9d-2b84-4698-a799-b49e3845f38f@embeddedor.com>
 <20251112093226.GA17382@unreal>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20251112093226.GA17382@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 61.251.99.135
X-Source-L: No
X-Exim-ID: 1vJ7Uq-00000000ru5-21T2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([10.28.115.44]) [61.251.99.135]:24341
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBsZup9kM5v48eqmFo2XyJq7Kk+b4/HgeJLbnCc2g+x6X8w/KSP6crQ6vi9fag/Rc8AX/1F2oeN/wTT3+vXOEcchXdpLoo1EIE2G+gXRZfIELUaXJbT4
 ZPwIeJXBiCJU3+aRrsV1IQYqCVw2N6YevknOPxEIq7tuz0dbnsedWzymCdPqx73J3rtA571cDC7LM57lN2/uU3iVoMdzOnZ8qXHDVgENb8gMtDAGz/Ktn7FW



On 11/12/25 18:32, Leon Romanovsky wrote:
> On Wed, Nov 12, 2025 at 05:49:05PM +0900, Gustavo A. R. Silva wrote:
>>
>>
>> On 11/11/25 23:19, Leon Romanovsky wrote:
>>> On Tue, Nov 11, 2025 at 09:14:05PM +0900, Gustavo A. R. Silva wrote:
>>>>
>>>>
>>>> On 11/11/25 20:56, Leon Romanovsky wrote:
>>>>> On Tue, Nov 11, 2025 at 12:35:02PM +0900, Gustavo A. R. Silva wrote:
>>>>>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>>>>>> getting ready to enable it, globally.
>>>>>>
>>>>>> Use the new TRAILING_OVERLAP() helper to fix the following warning:
>>>>>>
>>>>>> 21 drivers/infiniband/sw/rxe/rxe_verbs.h:271:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>>>>>
>>>>>> This helper creates a union between a flexible-array member (FAM) and a
>>>>>> set of MEMBERS that would otherwise follow it.
>>>>>>
>>>>>> This overlays the trailing MEMBER struct ib_sge sge[RXE_MAX_SGE]; onto
>>>>>> the FAM struct rxe_recv_wqe::dma.sge, while keeping the FAM and the
>>>>>> start of MEMBER aligned.
>>>>>>
>>>>>> The static_assert() ensures this alignment remains, and it's
>>>>>> intentionally placed inmediately after the related structure --no
>>>>>> blank line in between.
>>>>>>
>>>>>> Lastly, move the conflicting declaration struct rxe_resp_info resp;
>>>>>> to the end of the corresponding structure.
>>>>>>
>>>>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>>>>> ---
>>>>>>     drivers/infiniband/sw/rxe/rxe_verbs.h | 18 +++++++++++-------
>>>>>>     1 file changed, 11 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
>>>>>> index fd48075810dd..6498d61e8956 100644
>>>>>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
>>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
>>>>>> @@ -219,12 +219,6 @@ struct rxe_resp_info {
>>>>>>     	u32			rkey;
>>>>>>     	u32			length;
>>>>>> -	/* SRQ only */
>>>>>> -	struct {
>>>>>> -		struct rxe_recv_wqe	wqe;
>>>>>> -		struct ib_sge		sge[RXE_MAX_SGE];
>>>>>> -	} srq_wqe;
>>>>>> -
>>>>>>     	/* Responder resources. It's a circular list where the oldest
>>>>>>     	 * resource is dropped first.
>>>>>>     	 */
>>>>>> @@ -232,7 +226,15 @@ struct rxe_resp_info {
>>>>>>     	unsigned int		res_head;
>>>>>>     	unsigned int		res_tail;
>>>>>>     	struct resp_res		*res;
>>>>>> +
>>>>>> +	/* SRQ only */
>>>>>> +	/* Must be last as it ends in a flexible-array member. */
>>>>>> +	TRAILING_OVERLAP(struct rxe_recv_wqe, wqe, dma.sge,
>>>>>> +		struct ib_sge		sge[RXE_MAX_SGE];
>>>>>> +	) srq_wqe;
>>>>>
>>>>> Will this change be enough?
>>>>>
>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
>>>>> index fd48075810dd..9ab11421a585 100644
>>>>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
>>>>> @@ -219,12 +219,6 @@ struct rxe_resp_info {
>>>>>            u32                     rkey;
>>>>>            u32                     length;
>>>>> -       /* SRQ only */
>>>>> -       struct {
>>>>> -               struct rxe_recv_wqe     wqe;
>>>>> -               struct ib_sge           sge[RXE_MAX_SGE];
>>>>> -       } srq_wqe;
>>>>> -
>>>>>            /* Responder resources. It's a circular list where the oldest
>>>>>             * resource is dropped first.
>>>>>             */
>>>>> @@ -232,6 +226,12 @@ struct rxe_resp_info {
>>>>>            unsigned int            res_head;
>>>>>            unsigned int            res_tail;
>>>>>            struct resp_res         *res;
>>>>> +
>>>>> +       /* SRQ only */
>>>>> +       struct {
>>>>> +               struct ib_sge           sge[RXE_MAX_SGE];
>>>>> +               struct rxe_recv_wqe     wqe;
>>>>> +       } srq_wqe;
>>>>>     };
>>>>
>>>> The question is if this is really what you want?
>>>>
>>>> sge[RXE_MAX_SGE] is of the following type:
>>>>
>>>> struct ib_sge {
>>>>           u64     addr;
>>>>           u32     length;
>>>>           u32     lkey;
>>>> };
>>>>
>>>> and struct rxe_recv_wqe::dma.sge[] is of type:
>>>>
>>>> struct rxe_sge {
>>>>           __aligned_u64 addr;
>>>>           __u32   length;
>>>>           __u32   lkey;
>>>> };
>>>>
>>>> Both types are basically the same, and the original code looks
>>>> pretty much like what people do when they want to pre-allocate
>>>> a number of elements (of the same element type as the flex array)
>>>> for a flexible-array member.
>>>>
>>>> Based on the above, the change you suggest seems a bit suspicious,
>>>> and I'm not sure that's actually what you want?
>>>
>>> You wrote about this error: "warning: structure containing a flexible array
>>> member is not at the end of another structure".
>>>
>>> My suggestion was simply to move that flex array to be the last element
>>> and save us from the need to have some complex, magic macro in RXE.
>>
>> Yep, but as I commented above, that doesn't seem to be the right change.
>>
>> Look at the following couple of lines:
>>
>> drivers/infiniband/sw/rxe/rxe_resp.c-286-       size = sizeof(*wqe) + wqe->dma.num_sge*sizeof(struct rxe_sge);
>> drivers/infiniband/sw/rxe/rxe_resp.c-287-       memcpy(&qp->resp.srq_wqe, wqe, size);
>>
>> Notice that line 286 is the open-coded arithmetic (struct_size(wqe,
>> dma.sge, wqe->dma.num_sge) is preferred) to get the number of bytes
>> to allocate for a flexible structure, in this case struct rxe_recv_wqe,
>> and its flexible-array member, in this case struct rxe_recv_wqe::dma.sge[].
>>
>> So, `size` bytes are written in qp->resp.srq_wqe, and the reason this works
>> seems to be because of the pre-allocation of RXE_MAX_SGE number of elements
>> for flex array struct rxe_recv_wqe::dma.sge[] given by:
>>
>> struct {
>> 	struct rxe_recv_wqe	wqe;
>> 	struct ib_sge		sge[RXE_MAX_SGE];
>> } srq_wqe;
> 
> So you are saying that it works because it is written properly, so what
> is the problem? Why do we need to fix properly working and written code
> to be less readable?

No one said the original code is not working as expected. The issue here is
that the FAM is not at the end, and this causes a -Wflex-array-member-not-at-end
warning. The change I propose places the FAM at the end, and the functionality
remains exactly the same.

You're probably not aware of the work we've been doing to enable
-Wflex-array-member-not-at-end in mainline. If you're interested, below you
can take a look at other similar changes I (and others) have been doing to
complete this work:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?qt=grep&q=-Wflex-array-member-not-at-end

> 
>>
>> So, unless I'm missing something, struct ib_sge sge[RXE_MAX_SGE];
>> should be aligned with struct rxe_recv_wqe wqe::dma.sge[].
> 
> It is and moving to the end of struct will continue to keep it aligned.

I think there is something you are missing here. The following pieces of
code are no equivalent:

struct {
	struct rxe_recv_wqe	wqe;
  	struct ib_sge		sge[RXE_MAX_SGE];
} srq_wqe;

struct {
  	struct ib_sge		sge[RXE_MAX_SGE];
	struct rxe_recv_wqe	wqe;
} srq_wqe;

What I'm understanding from your last couple of responses is that you think
the above are equivalent. My previous response tried to explain why that is
not the case.

> 
>>
>> The TRAILING_OVERLAP() macro is also designed to ensure alignment in these
>> cases (and the static_assert() to preserve it). See this thread:
>>
>> https://lore.kernel.org/linux-hardening/aLiYrQGdGmaDTtLF@kspp/
>>

Thanks
-Gustavo

