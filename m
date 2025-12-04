Return-Path: <linux-rdma+bounces-14876-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A0CCA2645
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Dec 2025 06:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82AB53024180
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Dec 2025 05:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2162586E8;
	Thu,  4 Dec 2025 05:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="axeYvi3X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D992398FA3
	for <linux-rdma@vger.kernel.org>; Thu,  4 Dec 2025 05:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764824940; cv=none; b=rTBPC7Am4Nm9KnGSlB9gCGjJBL49sFg1bTJSk1pYXOxC8fbYHJDR5+o+reQL76GwfQmvF0RoYu6Q5d1cEf1GjrEP2pBAKyEP4lYwqNhVfb/xLhmpfFHitM1x046ijo8Y9yOtUqLQYX1qKVb82unLYcEiHu3RKs5vpZ5FTQylsNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764824940; c=relaxed/simple;
	bh=rkysJBKmBWU5tRwSxMdxSTg8zC/sl2ShZrtcNcm3FOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aKzlu1JDbpOQGkUPLlj/rUHPyNbUk1M8c607a4NCOxAAN1SUCQ24E+y4yqQxUxz2LsJ7SNWWaaPOPx21lHkFCy2wWmG0ilcbxi8V9DNZ9tXZM5axtFBaXckCZ03pFzC2aQO3DXKBTTTlUcly2X5xJ1dIDSRQrhmqaRDoJZtYWCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=axeYvi3X; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5ac954bb-ad4d-4b4c-b23b-47350b428404@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764824936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ne9RmrXxumOZj+MalhBuzRCKdFKIFcu4/kqNls92Qa4=;
	b=axeYvi3XbS2IXBDgZ/Ye+tkJ0Klg93POR59ZcGejdoCaeS+Jhr3Zmh8Y6lOhvRz2p2Jik2
	XPWaAm+n6Q/fNOa6iv3s72qwoNY4+c3ZnqJ/+PD0Xf1vl9jyhxYVTbFqGrw1KZZat9SbKB
	rUS+JcQJysLaQp39XrmRsIpVFAPAnAQ=
Date: Wed, 3 Dec 2025 21:08:45 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH][next] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
To: Jason Gunthorpe <jgg@nvidia.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aRKu5lNV04Sq82IG@kspp> <20251202181334.GA1162842@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20251202181334.GA1162842@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/12/2 10:13, Jason Gunthorpe 写道:
> On Tue, Nov 11, 2025 at 12:35:02PM +0900, Gustavo A. R. Silva wrote:
>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
>> index fd48075810dd..6498d61e8956 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
>> @@ -219,12 +219,6 @@ struct rxe_resp_info {
>>   	u32			rkey;
>>   	u32			length;
>>   
>> -	/* SRQ only */
>> -	struct {
>> -		struct rxe_recv_wqe	wqe;
>> -		struct ib_sge		sge[RXE_MAX_SGE];
>> -	} srq_wqe;
> 
> I think this existing is just a mess, can we fix it properly?
> 
> What this code wants to do is to have rxe_resp_info allocate a
> rxe_recv_wqe and have a maximum size of its flex array pre-allocated.
> 
> Probably like this, though maybe we need a FLEX version of the
> INIT_RDMA_OBJ_SIZE macro to make it safer.
> 
> Zhu, this seems like a good thing for you to look at?
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 38d8c408320f11..189eaa59a5fb14 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -1524,7 +1524,8 @@ static const struct ib_device_ops rxe_dev_ops = {
>   	INIT_RDMA_OBJ_SIZE(ib_ah, rxe_ah, ibah),
>   	INIT_RDMA_OBJ_SIZE(ib_cq, rxe_cq, ibcq),
>   	INIT_RDMA_OBJ_SIZE(ib_pd, rxe_pd, ibpd),
> -	INIT_RDMA_OBJ_SIZE(ib_qp, rxe_qp, ibqp),
> +	/* For resp.srq_wqe.dma.sge */
> +	INIT_RDMA_OBJ_SIZE(ib_qp, rxe_qp, ibqp) + RXE_MAX_SGE*sizeof(struct ib_sge),
>   	INIT_RDMA_OBJ_SIZE(ib_srq, rxe_srq, ibsrq),
>   	INIT_RDMA_OBJ_SIZE(ib_ucontext, rxe_ucontext, ibuc),
>   	INIT_RDMA_OBJ_SIZE(ib_mw, rxe_mw, ibmw),
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index fd48075810dd10..dda741ec3ac701 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -219,12 +219,6 @@ struct rxe_resp_info {
>   	u32			rkey;
>   	u32			length;
>   
> -	/* SRQ only */
> -	struct {
> -		struct rxe_recv_wqe	wqe;
> -		struct ib_sge		sge[RXE_MAX_SGE];
> -	} srq_wqe;
> -
>   	/* Responder resources. It's a circular list where the oldest
>   	 * resource is dropped first.
>   	 */
> @@ -232,6 +226,9 @@ struct rxe_resp_info {
>   	unsigned int		res_head;
>   	unsigned int		res_tail;
>   	struct resp_res		*res;
> +
> +	/* SRQ only. srq_wqe.dma.sge is a flex array */
> +	struct rxe_recv_wqe srq_wqe;

drivers/infiniband/sw/rxe/rxe_resp.c: In function get_srq_wqe:
drivers/infiniband/sw/rxe/rxe_resp.c:289:41: error: struct rxe_recv_wqe 
has no member named wqe
   289 |         qp->resp.wqe = &qp->resp.srq_wqe.wqe;
       |                                         ^

struct {
	struct rxe_recv_wqe	wqe;
	struct ib_sge		sge[RXE_MAX_SGE];
} srq_wqe;

IMO, it is better to move this struct to the end of the struct 
rxe_resp_info.

Yanjun.Zhu

>   };
>   
>   struct rxe_qp {
> @@ -269,7 +266,6 @@ struct rxe_qp {
>   
>   	struct rxe_req_info	req;
>   	struct rxe_comp_info	comp;
> -	struct rxe_resp_info	resp;
>   
>   	atomic_t		ssn;
>   	atomic_t		skb_out;
> @@ -289,6 +285,7 @@ struct rxe_qp {
>   	spinlock_t		state_lock; /* guard requester and completer */
>   
>   	struct execute_work	cleanup_work;
> +	struct rxe_resp_info	resp;
>   };
>   
>   enum {


