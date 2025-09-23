Return-Path: <linux-rdma+bounces-13604-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0654B96C16
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 18:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCAFB7B7791
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 16:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528292E612F;
	Tue, 23 Sep 2025 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DHFYvH92"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5AE2E2286
	for <linux-rdma@vger.kernel.org>; Tue, 23 Sep 2025 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643742; cv=none; b=C6lCBon9JQvB/2Sc5j/PzpDu9+Y+YBB3KX3t3FtrV8HlHIqDBtD8k0G49IWq2+BF65f9GQAas9dAJJ3Ew7wU91KLm7PTwbaLD2yvhbg8wldJUXLsYk4+zFnjz6LmESWZIzMI+qV+Oz1msDjZMEIISsZ+aEwPZCtJcyelQswSYYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643742; c=relaxed/simple;
	bh=J/l7mW1nL0SJIPJCqe1DDGfYqMy+O6drdVjCqRb4NvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SfQlMuZiRvV/84wkavAsOwNTMSCGgweMWCrmx2OwYXU6+MORW7L5ancE/yw5QmWqjxOhko1JKWCeXJN2bW51wn056ymjZHWCftn6sO/c/MiWiQDnvKKH7+pAX+ztbiRCWznuiamOFHvpy9rvFWHszAW01Gh8rXdHOkI4QIiEDGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DHFYvH92; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <18c3ae79-a9f9-4e41-8ecc-c7748ea5157b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758643737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KxElBtR+4u1VXya3CHBGxbbaKcHx9+DqVXqSzNnH+VI=;
	b=DHFYvH92u2dJLoJ89e6uq9mRsQwjADXYZr7jjVDAnCxIImOo+hhcAncN1+DnGD1eSJMjIM
	x/VV7yG87kY6mrUIWtrArbYAoemkY2xjqd4PhiJgBiiBGkhMUer+VqXDUD2haXCAX+wVBc
	q63e3QB9jQ1Pcv+vcbq68Q1NdVC/xqM=
Date: Tue, 23 Sep 2025 18:08:52 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/siw: Always report immediate post SQ errors
To: Stefan Metzmacher <metze@samba.org>, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org
References: <20250923144536.103825-1-bernard.metzler@linux.dev>
 <502b6c51-1585-4496-8984-667cef5c3848@samba.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Bernard Metzler <bernard.metzler@linux.dev>
In-Reply-To: <502b6c51-1585-4496-8984-667cef5c3848@samba.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 23.09.2025 17:44, Stefan Metzmacher wrote:
> Am 23.09.25 um 16:45 schrieb bernard.metzler@linux.dev:
>> From: Bernard Metzler <bernard.metzler@linux.dev>
>>
>> In siw_post_send(), any immediate error encountered during
>> processing of the work request list must be reported to the
>> caller, even if previous work requests in that list were just
>> accepted and added to the send queue.
>> Not reporting those errors confuses the caller, which would
>> wait indefinitely for the failing and potentially subsequently
>> aborted work requests completion.
>> This fixes a case where immediate errors were overwritten
>> by subsequent code in siw_post_send().
>>
>> Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
>> Suggested-by: Stefan Metzmacher <metze@samba.org>
>> Signed-off-by: Bernard Metzler <bernard.metzler@linux.dev>
>> ---
>>   drivers/infiniband/sw/siw/siw_verbs.c | 25 ++++++++++++++-----------
>>   1 file changed, 14 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
>> index 35c3bde0d00a..efa2f097b582 100644
>> --- a/drivers/infiniband/sw/siw/siw_verbs.c
>> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
>> @@ -769,7 +769,7 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
>>       struct siw_wqe *wqe = tx_wqe(qp);
>>       unsigned long flags;
>> -    int rv = 0;
>> +    int rv = 0, imm_err = 0;
>>       if (wr && !rdma_is_kernel_res(&qp->base_qp.res)) {
>>           siw_dbg_qp(qp, "wr must be empty for user mapped sq\n");
>> @@ -955,9 +955,17 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
>>        * Send directly if SQ processing is not in progress.
>>        * Eventual immediate errors (rv < 0) do not affect the involved
>>        * RI resources (Verbs, 8.3.1) and thus do not prevent from SQ
>> -     * processing, if new work is already pending. But rv must be passed
>> -     * to caller.
>> +     * processing, if new work is already pending. But rv and pointer
>> +     * to failed work request must be passed to caller.
>>        */
>> +    if (unlikely(rv < 0)) {
>> +        /*
>> +         * Immediate error
>> +         */
>> +        siw_dbg_qp(qp, "Immediate error %d\n", rv);
>> +        imm_err = rv;
>> +        *bad_wr = wr;
>> +    }
>>       if (wqe->wr_status != SIW_WR_IDLE) {
>>           spin_unlock_irqrestore(&qp->sq_lock, flags);
>>           goto skip_direct_sending;
>> @@ -982,15 +990,10 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
>>       up_read(&qp->state_lock);
>> -    if (rv >= 0)
>> -        return 0;
>> -    /*
>> -     * Immediate error
>> -     */
>> -    siw_dbg_qp(qp, "error %d\n", rv);
>> +    if (unlikely(imm_err))
>> +        return imm_err;
>> -    *bad_wr = wr;
>> -    return rv;
>> +    return (rv >= 0) ? 0 : rv;
>>   }
> 
> 
> So the caller needs to set *bad_rw = NULL itself
> in order to detect if an immediate error happened or not...
> 
> I'm also fine with that, I just hope it's consistent across
> all drivers...
> 
Yes, that's what all providers do, if populating the devices
post_send() method.

Looking at the in-kernel interface, ib_post_send() even
checks if there is a valid bad_wr ptr at all, providing
a dummy pointer otherwise.
That, since all (!) ULP's in infiniband/ulp provide a
NULL bad_wr. They just do not care too much about unwinding
errors to a certain WR, or just send single entry WR
lists.

Thank you!
Bernard.


> Thanks!
> metze


