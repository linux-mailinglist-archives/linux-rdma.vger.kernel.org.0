Return-Path: <linux-rdma+bounces-14867-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 50355C9E0C8
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Dec 2025 08:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D450834885A
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Dec 2025 07:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D94C29A9E9;
	Wed,  3 Dec 2025 07:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GUoPlscJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED9D2367D5;
	Wed,  3 Dec 2025 07:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764747160; cv=none; b=WYqLPYnxARTBgJrAYDNKbtO3bQA9Oem/gWVHsduQvqeXT4nBcefICaktwO7N3x8HwRMNWYYdpxWAfu/2e6AYJ3SaU1yJ980Wjuxx/PmQRA+gDwqryt83yBhRxFb1MauTM2G5oUMsoV+cGxy2+yQkC0nKuuj/AiWmo/8j6UN/9hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764747160; c=relaxed/simple;
	bh=CIszX+WqJlaySNEUkphsMpt7rNYW5uo6q65IYHxvZDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mkVu6GsSfJbY42hXozeDyTD/00stoR66LNZ328XKSqpWwxcL3RPxMRN3TqhX0Ayykw7y16cz+yeCM9ePPlQinjYjeoFjds03LqU6UQsnlkiDcqxJfkBOSwrt6E3Vw27ogRg82siU1ZEDQZVvH/2x06i/3/Dh9GejnoWEghoVSjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GUoPlscJ; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=Jj81oIn+7aDd09grfBj22NwB657gpTWj7Bp7hugT0YY=;
	b=GUoPlscJt7AKpYxPbyF6ACZqw9ZzGRT9Smf+2sq8mt70uwqHjWEHg+x3kcV0ru
	Is1QRe8+88v/2N1/6QgvZ3lLHXwZCLpdhIwjYEp2wFPz6HYp9e5TMO/pTQ8XDUii
	ZgX/lP+BTjZbwQF5t+jmjivv8BeCTPH4NkUvr/HAeeY5k=
Received: from [IPV6:2601:647:6300:a030:158e:aca0:41e5:6cea] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBHC_OC5y9pMlEWGQ--.53437S2;
	Wed, 03 Dec 2025 15:32:22 +0800 (CST)
Message-ID: <81a8c562-4c98-4bdb-a61c-8aae457614ad@163.com>
Date: Tue, 2 Dec 2025 23:32:17 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
To: Jason Gunthorpe <jgg@nvidia.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aRKu5lNV04Sq82IG@kspp> <20251202181334.GA1162842@nvidia.com>
From: Zhu Yanjun <mounter625@163.com>
In-Reply-To: <20251202181334.GA1162842@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgBHC_OC5y9pMlEWGQ--.53437S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxury5GF15Zr13WrykKFWruFg_yoW5ArW7pa
	1rJwn0kr47XF1Y9F1kZw45ZFZ3twnFv34DGasFq3sIvr1rCF4IgFnxCr45Wr10qF4kCa1S
	qF1jyryDCanxGFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zREeH9UUUUU=
X-CM-SenderInfo: hprx03thuwjki6rwjhhfrp/1tbiYAcZOGkv4A7PbgAAsP


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
> I think this existing is just a mess, can we fix it properly?
>
> What this code wants to do is to have rxe_resp_info allocate a
> rxe_recv_wqe and have a maximum size of its flex array pre-allocated.
>
> Probably like this, though maybe we need a FLEX version of the
> INIT_RDMA_OBJ_SIZE macro to make it safer.
>
> Zhu, this seems like a good thing for you to look at?

Thanks. I’ll take a closer look at this.

I’ll provide my comments over the weekend.

Zhu Yanjun

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


