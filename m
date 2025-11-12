Return-Path: <linux-rdma+bounces-14413-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2919DC51314
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 09:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D57484EB8F3
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 08:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D009A2FD661;
	Wed, 12 Nov 2025 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="JRbVE0jL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A047F192B75
	for <linux-rdma@vger.kernel.org>; Wed, 12 Nov 2025 08:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937359; cv=none; b=Bn0N+EB58mBv7x48Ec3nRqxnDwkMBbHTdwEFbVTOPv77/uFtuGmht/MQgjPkws1vh7eKkyy1Z2TBVBq823IesUiPUxeoavd7+hOCkUZBCEU6T0ejn/CfxjtIE18z4S3+93wqiIsET9n3FnWclJvRLxrSHcsU4U1tAn52Tuh2LvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937359; c=relaxed/simple;
	bh=KdwRxz0E4L6h+Tsu/Xs65J0K6pzrmFwN0OGt2cFh/UE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAeAMiTLh4ia5ILK8Esjv/wO74Krp0VvOYbbzv4/CNThWyUsuCt7hEY6mukPwnoHTw5nQWLZI5DRlkfw4cXOIIXsraLdsY871LlWz8M0d84joemUuwn7JcjjbQx+2jkEv0C2w2T4CG/ijuUDRsW1dqCs1p0HPMELuPfhN6MgGds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=JRbVE0jL; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id J15ZvlzLWZx2iJ6XVvYjr3; Wed, 12 Nov 2025 08:49:17 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id J6XUvANw9HwAIJ6XUvzulN; Wed, 12 Nov 2025 08:49:16 +0000
X-Authority-Analysis: v=2.4 cv=LbQ86ifi c=1 sm=1 tr=0 ts=69144a0c
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=cM1T1WamysKh5OBvDc2ngA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=wqs6Pu8S3n5vyb6ov2UA:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=deQSiP9b3EF2jDqf/qhV6x7CE33isY6FNZMQ566O670=; b=JRbVE0jLHbMY3eRj93tVN9cwDu
	hmjfKh/3IlyiiwWXsQ6p8lwOu/Tvxu+TY3128QO/D++GI2rzKUE6RwDQj6ckDsckShaoLdvEdwhqA
	tcIpvHxo8zalrDgN19NoXM2CCFlI3nHtxn0GmOvVuyfzCgOYhrF3mJtVqRNsL/jHENN27N5wGZnQ/
	cLBEHSr20l9jlvNQou3QdRs6DC89wpKutbHA3LILWs+rLGQvk2yAUJvB0OTGN5l9xpLKdqNne0VHa
	ikfXQiVTi0quwuC+rgfgZeMn0LSyY5DVbTtoBQ8UFb1JHHS5GPMyUS+Oe/9xTSHcyX8gZBmgCA9qM
	0ASwQBBA==;
Received: from fp93c06c1b.tkyc210.ap.nuro.jp ([147.192.108.27]:47530 helo=[10.221.86.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vJ6XT-00000003qSB-2WKl;
	Wed, 12 Nov 2025 02:49:15 -0600
Message-ID: <d3336e9d-2b84-4698-a799-b49e3845f38f@embeddedor.com>
Date: Wed, 12 Nov 2025 17:49:05 +0900
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
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20251111141945.GQ15456@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 147.192.108.27
X-Source-L: No
X-Exim-ID: 1vJ6XT-00000003qSB-2WKl
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: fp93c06c1b.tkyc210.ap.nuro.jp ([10.221.86.44]) [147.192.108.27]:47530
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGSwa5hIegFg/tMskzEqrPk7nKWHQeYg95qqYSunZATIhrrZcKwaf/hmCeXo2+nbMMqHdYp808uslnN+cnT15tjbdXZxETQmgNq0rCR00r6RdMgrvPaW
 wKuO6P9z8IFyo1RwrblyXgk3x3GpM7f1IA1rBPsLRqjbvt09xkMX+vEbKnbJrAR6ROn4QeaMqU/UR4AjyTmWNgkhO13YIl9NP/rRluEjV4AMdBMq6MoHYpWv



On 11/11/25 23:19, Leon Romanovsky wrote:
> On Tue, Nov 11, 2025 at 09:14:05PM +0900, Gustavo A. R. Silva wrote:
>>
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
>>>
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
>>
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
> 
> You wrote about this error: "warning: structure containing a flexible array
> member is not at the end of another structure".
> 
> My suggestion was simply to move that flex array to be the last element
> and save us from the need to have some complex, magic macro in RXE.

Yep, but as I commented above, that doesn't seem to be the right change.

Look at the following couple of lines:

drivers/infiniband/sw/rxe/rxe_resp.c-286-       size = sizeof(*wqe) + wqe->dma.num_sge*sizeof(struct rxe_sge);
drivers/infiniband/sw/rxe/rxe_resp.c-287-       memcpy(&qp->resp.srq_wqe, wqe, size);

Notice that line 286 is the open-coded arithmetic (struct_size(wqe,
dma.sge, wqe->dma.num_sge) is preferred) to get the number of bytes
to allocate for a flexible structure, in this case struct rxe_recv_wqe,
and its flexible-array member, in this case struct rxe_recv_wqe::dma.sge[].

So, `size` bytes are written in qp->resp.srq_wqe, and the reason this works
seems to be because of the pre-allocation of RXE_MAX_SGE number of elements
for flex array struct rxe_recv_wqe::dma.sge[] given by:

struct {
	struct rxe_recv_wqe	wqe;
	struct ib_sge		sge[RXE_MAX_SGE];
} srq_wqe;

So, unless I'm missing something, struct ib_sge sge[RXE_MAX_SGE];
should be aligned with struct rxe_recv_wqe wqe::dma.sge[].

The TRAILING_OVERLAP() macro is also designed to ensure alignment in these
cases (and the static_assert() to preserve it). See this thread:

https://lore.kernel.org/linux-hardening/aLiYrQGdGmaDTtLF@kspp/

Thanks
-Gustavo





