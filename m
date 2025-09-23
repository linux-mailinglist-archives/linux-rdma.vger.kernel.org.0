Return-Path: <linux-rdma+bounces-13593-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD2EB95B13
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 13:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C0CE4816F3
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 11:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D41322537;
	Tue, 23 Sep 2025 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="p09P/wZx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB04D322763
	for <linux-rdma@vger.kernel.org>; Tue, 23 Sep 2025 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758627657; cv=none; b=XmPvrgVf7j7bg31qDh4C7apYw8lzHYlNouw7t/WfyrZgGa/FVJdmPfQrB/X5h5cq6BiDHMxOmDJzk2WeZ2OpiqFxFhRbR2Fa/XlrPRGulApX87uVklYnJ1xLuzbqyWjS4LjgAFcRpttqTxS4d7QpTt2A9B8hN0xgbZKnA8YEwq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758627657; c=relaxed/simple;
	bh=UScOWjCmWbFjwS/dCq07vT9PWUwgxf1QQaMsCHpJsIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IpfECj5GJn/P36xQwN4f1OISabDtBpK5aNON/8DLUmwwCrwp1IOu1xBd+GACeB7+3mx1plqMBhTytCARTN51zvpMgxosr9AMYfAAYxcXzrjyZh4j/KwsJfyTb6D+hscm4opfTpdvh4K3cE2405TB89EYdPK9MsWi1+Mi4c9OUxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=p09P/wZx; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:To:Date:Message-ID:CC;
	bh=2anwBVX0Vt4JtwsOWiV8fXiDXLg47Y7tHF4ltZkhhIA=; b=p09P/wZx42CMSH7Za+eTcjd63L
	7rFfF3N0bBUUAdCaob6Vi1impTr0biJwLpW4GeXns120ZsUdXmYN4aMKMi1tfpDmTCwBarILr1ssZ
	Hfel+LdYyahUhcqOeyZlzbRgcG41E/SuUj+QqznyUdbKP8prD+MV64028P2Z9EGFPiAQBZfCA0lUO
	lLMO4OSx/XFTsKlXVzLAe55YS7Zpxfo3zGqSn1eGhLg5LRkTGy2RrbGEtLTsoxc2mqXqffEjtA2mj
	DpUPeyXqP1bYYnTfLYxoiRJFNZDjSELyvgcVHgBDRHT0rPBMefwAx3Any4+AmBcVMqO0YRoo9GA7k
	r6OFbCggjlv9gxbm+IY4Tu8YeIGsjzu8gUxolmAU0tAmYwWOt1/hJm/v2Sjf87S0kiH5kNa1+ij6+
	an8mY67gMRb0ryKDwCOjaSh6FYRR2dK5Z2OVLbc8Om/KXHP+slBeW20IXAsja5K5HeKrYr3wjpTSG
	8kldsM3TSYsZp46LutkWZzyx;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1v11O3-005Z62-0K;
	Tue, 23 Sep 2025 11:40:47 +0000
Message-ID: <9e1fb308-35c5-4ea0-9dbf-2f5bc297e8be@samba.org>
Date: Tue, 23 Sep 2025 13:40:45 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/siw: avoid hiding errors in siw_post_send()
To: Bernard Metzler <bernard.metzler@linux.dev>, linux-rdma@vger.kernel.org
References: <20250904173608.1590444-1-metze@samba.org>
 <81f8377e-9872-40cc-8aab-736ac2c548ee@linux.dev>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <81f8377e-9872-40cc-8aab-736ac2c548ee@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 05.09.25 um 20:37 schrieb Bernard Metzler:
> On 04.09.2025 19:36, Stefan Metzmacher wrote:
>> When we hit situations like "sq full", "too many sge's" or similar
>> things while queueing sqes, we should remember the error before
>> rv = siw_activate_tx(qp); clears the return value.
>>
>> Currently we hide such errors and confuse the caller
>> which is waiting (most likely forever) for a post completion
>> to arrive.
>>
> I agree with that overall observation. Thanks for pointing it out.
> 
>> Also if we already queued some sqes with success we need to process
> This is what we already do. But we hide the initial error.
> 
> One tricky question is what to return if we have both an immediate
> error and an error happening during starting/processing the send queue.
> I think it is best to return the immediate error in that case since
> the caller relates it with the bad_wr content. The caller may
> even understand that if bad_wr is not assigned it is not an
> immediate error.
> 
> 
>> them as no error happened, but at the end we need to return the
>> error relative to the bad_wr to the caller.
>>
>> Cc: Bernard Metzler <bernard.metzler@linux.dev>
>> Cc: linux-rdma@vger.kernel.org
>> Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
>> Signed-off-by: Stefan Metzmacher <metze@samba.org>
>> ---
>>   drivers/infiniband/sw/siw/siw_verbs.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
>> index 556a2b4b42ed..a3f548652c37 100644
>> --- a/drivers/infiniband/sw/siw/siw_verbs.c
>> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
>> @@ -770,6 +770,8 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
>>       unsigned long flags;
>>       int rv = 0;
>> +    size_t num_queued = 0;
> 
> I don't like counters which are actually used as boolean.
> Introducing an immediate error value and assigning it if needed
> should be sufficient.
> 
> 
>> +    int error = 0;
>>       if (wr && !rdma_is_kernel_res(&qp->base_qp.res)) {
>>           siw_dbg_qp(qp, "wr must be empty for user mapped sq\n");
>> @@ -948,9 +950,24 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
>>           sqe->flags |= SIW_WQE_VALID;
>>           qp->sq_put++;
>> +        num_queued++;
>>           wr = wr->next;
>>       }
>> +    if (unlikely(rv < 0)) {
>> +        /*
>> +         * If at least one was queued
>> +         * we should start the tx, but
>> +         * still return an error with
>> +         * the bad_wr at the end.
>> +         */
>> +        error = rv;
>> +        if (num_queued == 0) {
>> +            spin_unlock_irqrestore(&qp->sq_lock, flags);
>> +            goto skip_direct_sending;
>> +        }
>> +    }
>> +
>>       /*
>>        * Send directly if SQ processing is not in progress.
>>        * Eventual immediate errors (rv < 0) do not affect the involved
>> @@ -982,6 +999,9 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
>>       up_read(&qp->state_lock);
>> +    if (unlikely(error != 0))
>> +        rv = error;
>> +
>>       if (rv >= 0)
>>           return 0;
>>       /*
> 
> I unfortunately do not have access to build/test infrastructure until
> September 18th, but just a source tree and an editor. Sorry about that.
> What I would have in mind as a good patch is the following below
> (untested, maybe even with spelling errors). Maybe you can take it from
> there and test?
> 
> Thanks very much!
> Bernard.
> 
> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
> index 2b2a7b8e93b0..7780e39b4e3e 100644
> --- a/drivers/infiniband/sw/siw/siw_verbs.c
> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
> @@ -769,7 +769,7 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
>      struct siw_wqe *wqe = tx_wqe(qp);
> 
>      unsigned long flags;
> -    int rv = 0;
> +    int rv = 0, imm_err = 0;
> 
>      if (wr && !rdma_is_kernel_res(&qp->base_qp.res)) {
>          siw_dbg_qp(qp, "wr must be empty for user mapped sq\n");
> @@ -958,6 +958,14 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
>       * processing, if new work is already pending. But rv must be passed
>       * to caller.
>       */
> +    if (unlikely(rv < 0)) {
> +        /*
> +         * Immediate error
> +         */
> +        siw_dbg_qp(qp, "Immediate error %d\n", rv);
> +        imm_err = rv;
> +        *bad_wr = wr;
> +    }
>      if (wqe->wr_status != SIW_WR_IDLE) {
>          spin_unlock_irqrestore(&qp->sq_lock, flags);
>          goto skip_direct_sending;
> @@ -982,15 +990,10 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
> 
>      up_read(&qp->state_lock);
> 
> -    if (rv >= 0)
> -        return 0;
> -    /*
> -     * Immediate error
> -     */
> -    siw_dbg_qp(qp, "error %d\n", rv);
> +    if unlikely(imm_err)
> +        return imm_err;
> 
> -    *bad_wr = wr;
> -    return rv;
> +    return (rv >= 0) ? 0 : rv;
>   }

I think the last line whould be wrong as it won't set *bad_wr at all,
so I used this instead:

        if (likely(rv >= 0))
                 return 0;

        *bad_wr = NULL;
        return rv;

But that's wrong as it will trigger the BUG_ON in net/rds/ib_send.c

         /* XXX need to worry about failed_wr and partial sends. */
         failed_wr = &first->s_wr;
         ret = ib_post_send(ic->i_cm_id->qp, &first->s_wr, &failed_wr);
         rdsdebug("ic %p first %p (wr %p) ret %d wr %p\n", ic,
                  first, &first->s_wr, ret, failed_wr);
         BUG_ON(failed_wr != &first->s_wr);
         if (ret) {

But leaving it uninitialized on error would also likely cause problems.


The comment on ib_post_send() says:
... if an immediate error is returned, the QP state shall not be affected,

So may such non immediate errors should be reported as QP state changes
instead? So that ib_post_send() would return 0..

metze




