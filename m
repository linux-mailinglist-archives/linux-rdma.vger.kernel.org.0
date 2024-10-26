Return-Path: <linux-rdma+bounces-5528-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2799B1538
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Oct 2024 07:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA384B21D1A
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Oct 2024 05:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203A3143744;
	Sat, 26 Oct 2024 05:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fAbJF3Yq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A256033EA
	for <linux-rdma@vger.kernel.org>; Sat, 26 Oct 2024 05:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729921960; cv=none; b=SQ7hWiEkz13OkvkVB4gaV3R2PIpP2timn3zKNPFGrGe4CebgpNfESd4LPYmMARM6gXhYfLjM6YM/5ZjfN3HB+upx87R/7DxRnW8DCYb3niUiQ+fffM3NyiYYkX17hByrbLPaKaFmBeW+sO+vU/oNoct4CtiJE5JBMJ9ayqtZkPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729921960; c=relaxed/simple;
	bh=5iT3ad9AEursPjoJsI8fF/FPWtSFmlmHQRIHVxZQVck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6JdS6xgNmljeBMJIPQvP4WFgK/MmWGMS/YNdMTvDTI47eJRPCxR5vbLg4rqSUAoOTZszvFKft+XOU28o8M6HcUPJisj4sO3pXirPxKnJzhiURZKLxryoa6cTvQAmV7TcdrHJRJMoj6taZjPgfQi5To4h3SAHKw8Rzhxqba05cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fAbJF3Yq; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <267804d9-df81-489e-8d8b-6dcee7859ae0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729921955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=enQokKFOYCZYYwZXAmQFhPo+euRyjBi1gsc93ts0DdU=;
	b=fAbJF3YqrIELDr6U+qHcjMBXn16Re65o6Lb+zaZ2+EN6DJve43t/U96vjiqSX9qyFc3/DT
	PdldqddZn4kFZFILmSrwGzCoT8kcm1VdVihhFNbFpiAC5zlPSV9tcuTtEF3Ambaq0oebVB
	a7arvuI8mJBkfXOt+XhErE2ZaPmkcF8=
Date: Sat, 26 Oct 2024 07:52:31 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix the qp flush warnings in req
To: Honggang LI <honggangli@163.com>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
 linux-rdma@vger.kernel.org
References: <20241025152036.121417-1-yanjun.zhu@linux.dev>
 <ZxxMqWp0oCJxPq64@fc39>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <ZxxMqWp0oCJxPq64@fc39>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/10/26 3:58, Honggang LI 写道:
> On Fri, Oct 25, 2024 at 05:20:36PM +0200, Zhu Yanjun wrote:
>> ---
>>   drivers/infiniband/sw/rxe/rxe_req.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
>> index 479c07e6e4ed..87a02f0deb00 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_req.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
>> @@ -663,10 +663,12 @@ int rxe_requester(struct rxe_qp *qp)
>>   	if (unlikely(qp_state(qp) == IB_QPS_ERR)) {
>>   		wqe = __req_next_wqe(qp);
>>   		spin_unlock_irqrestore(&qp->state_lock, flags);
>> -		if (wqe)
>> +		if (wqe) {
>> +			wqe->status = IB_WC_WR_FLUSH_ERR;
>                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> Why not update wqe->status in function `flush_send_wqe()` ?

flush_send_wqe is to handle the cqe in cq queue. Please see the source 
code as below.

static int flush_send_wqe(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
{
     struct rxe_cqe cqe = {};
     struct ib_wc *wc = &cqe.ibwc;
     struct ib_uverbs_wc *uwc = &cqe.uibwc;
     int err;

     if (qp->is_user) {
         uwc->wr_id = wqe->wr.wr_id;
         uwc->status = IB_WC_WR_FLUSH_ERR;
         uwc->qp_num = qp->ibqp.qp_num;
     } else {
         wc->wr_id = wqe->wr.wr_id;
         wc->status = IB_WC_WR_FLUSH_ERR;
         wc->qp = &qp->ibqp;
     }

     err = rxe_cq_post(qp->scq, &cqe, 0);
     if (err)
         rxe_dbg_cq(qp->scq, "post cq failed, err = %d\n", err);

     return err;
}

This error occurs in send queue. Please see the source code as below.

static struct rxe_send_wqe *__req_next_wqe(struct rxe_qp *qp)
{
     struct rxe_queue *q = qp->sq.queue;
     unsigned int index = qp->req.wqe_index;
     unsigned int prod;

     prod = queue_get_producer(q, QUEUE_TYPE_FROM_CLIENT);
     if (index == prod)
         return NULL;
     else
         return queue_addr_from_index(q, index);
}

This is why we should set the error status in send queue error handler.

Thanks,

Zhu Yanjun

>
> thanks
>
-- 
Best Regards,
Yanjun.Zhu


