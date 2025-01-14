Return-Path: <linux-rdma+bounces-7003-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E54A102E9
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2025 10:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C08617A150E
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2025 09:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6011284A5A;
	Tue, 14 Jan 2025 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RdMGOuqm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF7E191F89
	for <linux-rdma@vger.kernel.org>; Tue, 14 Jan 2025 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736846531; cv=none; b=LENp1g/Jr1UMLZ2z5S61dA43l705MhxfpELZp7BYP1vONRWSKbSc8IiwzTyG2CltVrQTF1m//J/nJ3G1VyknqAKdsara1sT8R9ekP5Ho+0fD673QI3q0Obil9++V2Td5YFBwmL+YPXdyKQ2y7Gwqlq1gBlbEOXbDNUu4I2m5Hjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736846531; c=relaxed/simple;
	bh=NgzEvaMpanjjQLiCcx//8rUxRw36miyOFV1dPjEJQNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m6v8oCn0W1qFNP4I/RDYR0a1D4aAcusD8mDbgX5zP3SRHT5w4JLikrnYUqkhtY835DkH/zd1nduoONoG2sHdGGtt+hETPemwmR82farg+OfDXG7N9Bs6MRzyFFotWkB7KCmB26Zfy+y4AAxQLuxe+ZK8CbLrdVX4QIgXNW+FUOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RdMGOuqm; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <88445978-0523-477e-9713-05b563be847a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736846522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rQ/LkhxVtGRY2V5lPEE50vmclopEShRIzl5QLQgcGU=;
	b=RdMGOuqmhMMjLFTwyjxI8LQxtMyBNUQFOU+MeaAHmS4AwSsB6vwfaCb8FYQglNIX21W5w/
	ACU8XZRcsUF9AS5+O8if+N2GeQ4q/nEXLCihnC8whcyPW9h97kQ7iu8dnI6ydJVvx2jE9e
	oA94Grz9b7WT5BimfFCVmLTf/Yg+2nc=
Date: Tue, 14 Jan 2025 10:22:01 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rxe: Change the return type from int to bool
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>, "jgg@ziepe.ca"
 <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20250111102758.308502-1-yanjun.zhu@linux.dev>
 <947653a5-5cca-42f6-a85c-f74773f2148a@fujitsu.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <947653a5-5cca-42f6-a85c-f74773f2148a@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13.01.25 01:53, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 11/01/2025 18:27, Zhu Yanjun wrote:
>> The return type of the functions queue_full and queue_empty should be
>> bool.
>>
>> No functional changes.
>>
>> Fixes: 8700e3e7c485 ("Soft RoCE driver")
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Looks good to me

Thanks for your code review.

Zhu Yanjun

> 
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
> 
> 
>> ---
>>    drivers/infiniband/sw/rxe/rxe_cq.c    | 2 +-
>>    drivers/infiniband/sw/rxe/rxe_queue.h | 4 ++--
>>    drivers/infiniband/sw/rxe/rxe_verbs.c | 6 +++---
>>    3 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
>> index fec87c9030ab..a2df55e13ea4 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_cq.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_cq.c
>> @@ -88,7 +88,7 @@ int rxe_cq_resize_queue(struct rxe_cq *cq, int cqe,
>>    int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
>>    {
>>    	struct ib_event ev;
>> -	int full;
>> +	bool full;
>>    	void *addr;
>>    	unsigned long flags;
>>    
>> diff --git a/drivers/infiniband/sw/rxe/rxe_queue.h b/drivers/infiniband/sw/rxe/rxe_queue.h
>> index c711cb98b949..597e3da469a1 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_queue.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_queue.h
>> @@ -151,7 +151,7 @@ static inline u32 queue_get_consumer(const struct rxe_queue *q,
>>    	return cons;
>>    }
>>    
>> -static inline int queue_empty(struct rxe_queue *q, enum queue_type type)
>> +static inline bool queue_empty(struct rxe_queue *q, enum queue_type type)
>>    {
>>    	u32 prod = queue_get_producer(q, type);
>>    	u32 cons = queue_get_consumer(q, type);
>> @@ -159,7 +159,7 @@ static inline int queue_empty(struct rxe_queue *q, enum queue_type type)
>>    	return ((prod - cons) & q->index_mask) == 0;
>>    }
>>    
>> -static inline int queue_full(struct rxe_queue *q, enum queue_type type)
>> +static inline bool queue_full(struct rxe_queue *q, enum queue_type type)
>>    {
>>    	u32 prod = queue_get_producer(q, type);
>>    	u32 cons = queue_get_consumer(q, type);
>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
>> index 8a5fc20fd186..c88140d896c5 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
>> @@ -870,7 +870,7 @@ static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr)
>>    	struct rxe_send_wqe *send_wqe;
>>    	unsigned int mask;
>>    	unsigned int length;
>> -	int full;
>> +	bool full;
>>    
>>    	err = validate_send_wr(qp, ibwr, &mask, &length);
>>    	if (err)
>> @@ -960,7 +960,7 @@ static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
>>    	unsigned long length;
>>    	struct rxe_recv_wqe *recv_wqe;
>>    	int num_sge = ibwr->num_sge;
>> -	int full;
>> +	bool full;
>>    	int err;
>>    
>>    	full = queue_full(rq->queue, QUEUE_TYPE_FROM_ULP);
>> @@ -1185,7 +1185,7 @@ static int rxe_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags)
>>    {
>>    	struct rxe_cq *cq = to_rcq(ibcq);
>>    	int ret = 0;
>> -	int empty;
>> +	bool empty;
>>    	unsigned long irq_flags;
>>    
>>    	spin_lock_irqsave(&cq->cq_lock, irq_flags);


