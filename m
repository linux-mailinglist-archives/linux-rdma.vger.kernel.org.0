Return-Path: <linux-rdma+bounces-13599-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A04CB965E8
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 16:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 963694C0499
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 14:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F538233722;
	Tue, 23 Sep 2025 14:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FeTcNz5J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7315F25DB12
	for <linux-rdma@vger.kernel.org>; Tue, 23 Sep 2025 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638364; cv=none; b=ThPmiRB+7ShWd7a3J85SdRLLKpcjBUdzTak9GXNWVG3sEvIzSfPV/2vWpclt6RpVX4s8efQxBBk8vXHnogPx7TgoQkPK6QUK2Zhiit92QiAvvLJ1i6iVVMIrFN+SQ+anp0awejXB6XxwWAN8FWqujlPnLTr90aVUAp8egmuI/mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638364; c=relaxed/simple;
	bh=MAk5xKa2pVh8rYGGm6FtwO79gM/B65NU2J+UoIwsHqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hAjGH9Cmry+CbC5p50Em3Ol22IUcPVdJdpbfHPqMp8Tw6hMAU6MJYSqf5uu7+EOqgMxdkyITX8c/KtzFbpngA+QF3FDpbZacFOjv95TpOS9UGAX/9yopzhlRl7H2DYsZ2pjj0mzXmAvqfSzpTTlKbQd/itKqLLAINZ4E38wZMqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FeTcNz5J; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6d8be399-d409-46a1-a3e8-591cb76dcca2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758638355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=etzFaQ1hYbI0CGwxo1w2nxyUhSQX3/QeXbXaaCQxMyk=;
	b=FeTcNz5JEVDxxXCOkq7SvWQxTtki1JtD6Fv6umz2ztHOXPaMz17eYHgcsvAD+MQ/yCUo0j
	/Gkb6ZlMjW1tGg6jdri/VfryFCeXOLZYEr27xHL923THqyM5BaqkOJiPike3FdhvitlNm8
	RA6DWLsLI0kL+tzZX8PB+4JbESzXQ5o=
Date: Tue, 23 Sep 2025 16:39:08 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/siw: avoid hiding errors in siw_post_send()
To: Stefan Metzmacher <metze@samba.org>, linux-rdma@vger.kernel.org
References: <20250904173608.1590444-1-metze@samba.org>
 <81f8377e-9872-40cc-8aab-736ac2c548ee@linux.dev>
 <9e1fb308-35c5-4ea0-9dbf-2f5bc297e8be@samba.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Bernard Metzler <bernard.metzler@linux.dev>
In-Reply-To: <9e1fb308-35c5-4ea0-9dbf-2f5bc297e8be@samba.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 23.09.2025 13:40, Stefan Metzmacher wrote:
> Am 05.09.25 um 20:37 schrieb Bernard Metzler:
>> On 04.09.2025 19:36, Stefan Metzmacher wrote:
>>> When we hit situations like "sq full", "too many sge's" or similar
>>> things while queueing sqes, we should remember the error before
>>> rv = siw_activate_tx(qp); clears the return value.
>>>
>>> Currently we hide such errors and confuse the caller
>>> which is waiting (most likely forever) for a post completion
>>> to arrive.
>>>
>> I agree with that overall observation. Thanks for pointing it out.
>>
>>> Also if we already queued some sqes with success we need to process
>> This is what we already do. But we hide the initial error.
>>
>> One tricky question is what to return if we have both an immediate
>> error and an error happening during starting/processing the send queue.
>> I think it is best to return the immediate error in that case since
>> the caller relates it with the bad_wr content. The caller may
>> even understand that if bad_wr is not assigned it is not an
>> immediate error.
>>
>>
>>> them as no error happened, but at the end we need to return the
>>> error relative to the bad_wr to the caller.
>>>
>>> Cc: Bernard Metzler <bernard.metzler@linux.dev>
>>> Cc: linux-rdma@vger.kernel.org
>>> Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
>>> Signed-off-by: Stefan Metzmacher <metze@samba.org>
>>> ---
>>>   drivers/infiniband/sw/siw/siw_verbs.c | 20 ++++++++++++++++++++
>>>   1 file changed, 20 insertions(+)
>>>
>>> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
>>> index 556a2b4b42ed..a3f548652c37 100644
>>> --- a/drivers/infiniband/sw/siw/siw_verbs.c
>>> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
>>> @@ -770,6 +770,8 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
>>>       unsigned long flags;
>>>       int rv = 0;
>>> +    size_t num_queued = 0;
>>
>> I don't like counters which are actually used as boolean.
>> Introducing an immediate error value and assigning it if needed
>> should be sufficient.
>>
>>
>>> +    int error = 0;
>>>       if (wr && !rdma_is_kernel_res(&qp->base_qp.res)) {
>>>           siw_dbg_qp(qp, "wr must be empty for user mapped sq\n");
>>> @@ -948,9 +950,24 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
>>>           sqe->flags |= SIW_WQE_VALID;
>>>           qp->sq_put++;
>>> +        num_queued++;
>>>           wr = wr->next;
>>>       }
>>> +    if (unlikely(rv < 0)) {
>>> +        /*
>>> +         * If at least one was queued
>>> +         * we should start the tx, but
>>> +         * still return an error with
>>> +         * the bad_wr at the end.
>>> +         */
>>> +        error = rv;
>>> +        if (num_queued == 0) {
>>> +            spin_unlock_irqrestore(&qp->sq_lock, flags);
>>> +            goto skip_direct_sending;
>>> +        }
>>> +    }
>>> +
>>>       /*
>>>        * Send directly if SQ processing is not in progress.
>>>        * Eventual immediate errors (rv < 0) do not affect the involved
>>> @@ -982,6 +999,9 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
>>>       up_read(&qp->state_lock);
>>> +    if (unlikely(error != 0))
>>> +        rv = error;
>>> +
>>>       if (rv >= 0)
>>>           return 0;
>>>       /*
>>
>> I unfortunately do not have access to build/test infrastructure until
>> September 18th, but just a source tree and an editor. Sorry about that.
>> What I would have in mind as a good patch is the following below
>> (untested, maybe even with spelling errors). Maybe you can take it from
>> there and test?
>>
>> Thanks very much!
>> Bernard.
>>
>> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
>> index 2b2a7b8e93b0..7780e39b4e3e 100644
>> --- a/drivers/infiniband/sw/siw/siw_verbs.c
>> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
>> @@ -769,7 +769,7 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
>>      struct siw_wqe *wqe = tx_wqe(qp);
>>
>>      unsigned long flags;
>> -    int rv = 0;
>> +    int rv = 0, imm_err = 0;
>>
>>      if (wr && !rdma_is_kernel_res(&qp->base_qp.res)) {
>>          siw_dbg_qp(qp, "wr must be empty for user mapped sq\n");
>> @@ -958,6 +958,14 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
>>       * processing, if new work is already pending. But rv must be passed
>>       * to caller.
>>       */
>> +    if (unlikely(rv < 0)) {
>> +        /*
>> +         * Immediate error
>> +         */
>> +        siw_dbg_qp(qp, "Immediate error %d\n", rv);
>> +        imm_err = rv;
>> +        *bad_wr = wr;
>> +    }
>>      if (wqe->wr_status != SIW_WR_IDLE) {
>>          spin_unlock_irqrestore(&qp->sq_lock, flags);
>>          goto skip_direct_sending;
>> @@ -982,15 +990,10 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
>>
>>      up_read(&qp->state_lock);
>>
>> -    if (rv >= 0)
>> -        return 0;
>> -    /*
>> -     * Immediate error
>> -     */
>> -    siw_dbg_qp(qp, "error %d\n", rv);
>> +    if unlikely(imm_err)
>> +        return imm_err;
>>
>> -    *bad_wr = wr;
>> -    return rv;
>> +    return (rv >= 0) ? 0 : rv;
>>   }
> 
> I think the last line whould be wrong as it won't set *bad_wr at all,
> so I used this instead:
> 
>         if (likely(rv >= 0))
>                  return 0;
> 
>         *bad_wr = NULL;
>         return rv;
> 
> But that's wrong as it will trigger the BUG_ON in net/rds/ib_send.c
> 
>          /* XXX need to worry about failed_wr and partial sends. */
>          failed_wr = &first->s_wr;
>          ret = ib_post_send(ic->i_cm_id->qp, &first->s_wr, &failed_wr);
>          rdsdebug("ic %p first %p (wr %p) ret %d wr %p\n", ic,
>                   first, &first->s_wr, ret, failed_wr);
>          BUG_ON(failed_wr != &first->s_wr);
>          if (ret) {
> 
> But leaving it uninitialized on error would also likely cause problems.
> 
> 
> The comment on ib_post_send() says:
> ... if an immediate error is returned, the QP state shall not be affected,
> 


Yes, *bad_wr shall be only set if there is an immediate error
with WR processing. Otherwise, the provider should not touch it.
And yes, an immediate error shall not change the QP state - it
might be a transient condition like a SQ overflow etc, but also a
wrong WR opcode. These cases do not affect the SQ state, since the
faulty WR was not added to the SQ.

Non immediate errors should be errors which are happening during
SQ processing, like failing base and bound checks of memory
accesses of a SQE. Those cases shall create work completions on
the related CQ, signalling the failing original WR by its ID
and the failure cause.

The siw_post_send() routine handles two more error cases I think
you are pointing at:

(1) Errors during preparing SQ processing out of SQ idle
     state (if the SQ was empty when post_send() happened).
     Here the first SQE gets copied into QP's transmit
     processing context. This happens in siw_activate_tx().

(2) Errors during scheduling the start of SQ processing.
     This happens in siw_sq_start().
     Only (fatal) error possible is if there is no transmit
     thread available.

siw currently signals failures in (1, 2) as a return value
to the siw_post_send(). It assumes the caller will move the
QP to error state and retrieve all pending SQE's as flush
errors on the CQ.

It is debatable if errors in (1) should not be signaled
as a return value of post_send(), but be just translated
into a CQE with error code.

Based on your patch and our discussion I prepared a
patch which leaves handling of errors in (1, 2) unchanged,
but fixes the broken code overwriting the immediate
error. I'd be happy if you could check and test it. I'll
send it soon.

Thanks and best regards,
Bernard.
> So may such non immediate errors should be reported as QP state changes
> instead? So that ib_post_send() would return 0..
> 
> metze
> 
> 
> 


