Return-Path: <linux-rdma+bounces-14989-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7D4CBC890
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Dec 2025 06:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E9B630084DA
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Dec 2025 05:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD432C9D;
	Mon, 15 Dec 2025 05:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CxxaLU8m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1709463
	for <linux-rdma@vger.kernel.org>; Mon, 15 Dec 2025 05:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765774870; cv=none; b=NRrk/it1dxX95ucZ9BC74plQmZNelWXBQnRXepXgprhEr+HJEb6jonA0kL+X/I/IJQM60zKzagRfSEc0uzMeUNCybjMH70wCG+R4vD5juiREAeAudtv5NjG7sFUp8KQdQkrL2JfamoGaMi/YRc1d68y4FJVh35NB8wJcIopm5jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765774870; c=relaxed/simple;
	bh=PGKIGhM6JOqh4tA01/PQ02/degopONq33NJq7DMRZRU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mMYx9/xA3S1QOBMQb+cSzuCBVibJZTNmzau/qaXFsol/tJaznJS1zlINCouz7tvuIDR/6R0EFBP9Q2nzWycrh5atP1oppJEyTJWD75ug6q71cofCefE2gcdTfEAZyTMU3TANuy/lgo83QkxZ9GZzRHDRP5jwFoT7k2BnwqgvHtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CxxaLU8m; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7e3a294f-5dc2-4e8c-aacc-0286c1592038@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765774856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JdDlNT0R0zxH9MqWFN44FIM8MXm2yWgNz6XShySExz8=;
	b=CxxaLU8mXs9Djm/rtP3CwkuQpKIrWHOZoz2o+FriLR69m/1OnMy6jV9h9FNatoevNpEHEA
	tBCe0rbZeYIGY9uZzenXXRpnRVpitmONiFh/f++q+tQeo68U7v4m7Je9JV+qEIG+mllkx3
	kWv1WleyfYoFJsL7wXu6h1BqouGn1xg=
Date: Sun, 14 Dec 2025 21:00:51 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH][next] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Zhu Yanjun <zyjzyj2000@gmail.com>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aRKu5lNV04Sq82IG@kspp> <20251202181334.GA1162842@nvidia.com>
 <5ac954bb-ad4d-4b4c-b23b-47350b428404@linux.dev>
 <20251204130559.GA1219718@nvidia.com>
 <80620d09-8187-45b1-a490-07c52733ac21@linux.dev>
 <2191ee0f-a528-4187-ae5b-5aba18741701@linux.dev>
In-Reply-To: <2191ee0f-a528-4187-ae5b-5aba18741701@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2025/12/5 20:41, Zhu Yanjun 写道:
> 
> 
> 在 2025/12/4 9:48, yanjun.zhu 写道:
>> On 12/4/25 5:05 AM, Jason Gunthorpe wrote:
>>> On Wed, Dec 03, 2025 at 09:08:45PM -0800, Zhu Yanjun wrote:
>>>>>        unsigned int        res_head;
>>>>>        unsigned int        res_tail;
>>>>>        struct resp_res        *res;
>>>>> +
>>>>> +    /* SRQ only. srq_wqe.dma.sge is a flex array */
>>>>> +    struct rxe_recv_wqe srq_wqe;
>>>>
>>>> drivers/infiniband/sw/rxe/rxe_resp.c: In function get_srq_wqe:
>>>> drivers/infiniband/sw/rxe/rxe_resp.c:289:41: error: struct 
>>>> rxe_recv_wqe has
>>>> no member named wqe
>>>>    289 |         qp->resp.wqe = &qp->resp.srq_wqe.wqe;
>>>>        |                                         ^
>>>
>>> I didn't try to fix all the typos, you will need to do that.
>>
>> Exactly. I will fix this problem. This weekend, I will send out an 
>> official commit.
> Hi, Jason
> 
> The followings are based on your commits and Leon's commits. And it can 
> pass the rdma-core tests.
> 
> I am not sure if this commit is good or not.

Hi, Jason && Leon

Any update? If this looks good to you, I will send out an official 
commit based on the following commit.

Thanks,
Yanjun.Zhu

> 
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/ 
> sw/rxe/rxe_verbs.c
> index 38d8c408320f..189eaa59a5fb 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -1524,7 +1524,8 @@ static const struct ib_device_ops rxe_dev_ops = {
>          INIT_RDMA_OBJ_SIZE(ib_ah, rxe_ah, ibah),
>          INIT_RDMA_OBJ_SIZE(ib_cq, rxe_cq, ibcq),
>          INIT_RDMA_OBJ_SIZE(ib_pd, rxe_pd, ibpd),
> -       INIT_RDMA_OBJ_SIZE(ib_qp, rxe_qp, ibqp),
> +       /* For resp.srq_wqe.dma.sge */
> +       INIT_RDMA_OBJ_SIZE(ib_qp, rxe_qp, ibqp) + 
> RXE_MAX_SGE*sizeof(struct ib_sge),
>          INIT_RDMA_OBJ_SIZE(ib_srq, rxe_srq, ibsrq),
>          INIT_RDMA_OBJ_SIZE(ib_ucontext, rxe_ucontext, ibuc),
>          INIT_RDMA_OBJ_SIZE(ib_mw, rxe_mw, ibmw),
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/ 
> sw/rxe/rxe_verbs.h
> index fd48075810dd..8c17f5f4e318 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -219,12 +219,6 @@ struct rxe_resp_info {
>          u32                     rkey;
>          u32                     length;
> 
> -       /* SRQ only */
> -       struct {
> -               struct rxe_recv_wqe     wqe;
> -               struct ib_sge           sge[RXE_MAX_SGE];
> -       } srq_wqe;
> -
>          /* Responder resources. It's a circular list where the oldest
>           * resource is dropped first.
>           */
> @@ -232,6 +226,12 @@ struct rxe_resp_info {
>          unsigned int            res_head;
>          unsigned int            res_tail;
>          struct resp_res         *res;
> +
> +       /* SRQ only. srq_wqe.dma.sge is a flex array */
> +       struct {
> +               struct rxe_recv_wqe     wqe;
> +               struct ib_sge           sge[RXE_MAX_SGE];
> +       } srq_wqe;
>   };
> 
>   struct rxe_qp {
> @@ -269,7 +269,6 @@ struct rxe_qp {
> 
>          struct rxe_req_info     req;
>          struct rxe_comp_info    comp;
> -       struct rxe_resp_info    resp;
> 
>          atomic_t                ssn;
>          atomic_t                skb_out;
> @@ -289,6 +288,7 @@ struct rxe_qp {
>          spinlock_t              state_lock; /* guard requester and 
> completer */
> 
>          struct execute_work     cleanup_work;
> +       struct rxe_resp_info    resp;
>   };
> 
>   enum {
> 
> Yanjun.Zhu
> 
>>
>> Yanjun.Zhu
>>
>>>
>>> Jason
>>
> 

-- 
Best Regards,
Yanjun.Zhu


