Return-Path: <linux-rdma+bounces-16793-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIG5JH4ujmmcAgEAu9opvQ
	(envelope-from <linux-rdma+bounces-16793-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 20:48:14 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9846130C6D
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 20:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 34EEF300B9C9
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 19:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4622777E0;
	Thu, 12 Feb 2026 19:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AKVUU79t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277A127453
	for <linux-rdma@vger.kernel.org>; Thu, 12 Feb 2026 19:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770925689; cv=none; b=RUn7vtR/OxWaI6wX3ZH5i0EMhVLgRJdEuSUIfqniBPOe+8E1KXrYHEY5gwMYmyhoAltQOEhixXI52rIm8PVOaPIU4LfrlOTVsVIHuSKs2UWWyK8P8ygsjOnA88Bt84gXA44K9S+G7hxrfpMbyGUvV15Y/m/SI3q13qxNdQp0SM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770925689; c=relaxed/simple;
	bh=u9mdQW7Y3W/uEX3SBY8tOvxz4vAU8bknYFtjd006j94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SAjrQJaWhf8D8V44KTGsjGAG3b35fVCMnTl8r6g45VfJ8xz72ZXYMYOfSn2fc+dzSu29OjsvMMEEzbqyasxZrPawbHtRvVI3at48npWEHzeAwyKZ9w9uKPb1a/VMnPXcELS1ZtTkyP8atnBciGTmv6oSmwPvE4IjFSY4xjSWCDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AKVUU79t; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9264c8bf-e3cd-46db-b1a9-63a556ecb1d4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770925674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYVaLuJy159Bv93SAdezH4SBBD4v8w4GIPszpgMuzBU=;
	b=AKVUU79tpSg9MX8RHoezy+/PkTv5E7l4F5caPGFjpemuRQsArWhRRrtpwz1CIihpyBz8u8
	fqV68B8HSDJX6fNCB4hTxwIbrHEDZLRWAsgVFBNsZSrmSmYbcfUURGVIIfvzh7lO+fYIvd
	is1nN6ktQuls3k/4WvsICmiOt31Smu8=
Date: Thu, 12 Feb 2026 11:47:50 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Generate async error for r_key violations
To: Evan Green <evgreen@meta.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: wguay@meta.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <20260212164355.3585961-1-evgreen@meta.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260212164355.3585961-1-evgreen@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16793-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[meta.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux.dev:email,meta.com:email]
X-Rspamd-Queue-Id: B9846130C6D
X-Rspamd-Action: no action

On 2/12/26 8:43 AM, Evan Green wrote:
> Table 63 of the IBTA spec lists R_Key violations as a class C
> error. 9.9.3.1.3 Responder Class C Fault Behavior indicates an
> affiliated asynchronous error should be generated at the responder
> if the error can be associated to a QP but not a particular RX WQE.

This paragraph should be the descriptions in the commit log.

"C9-222.1.1: For an HCA responder using Reliable Connection service, for
a Class C responder side error, the error shall be reported to the requester
by generating the appropriate NAK code as specified in Table 63 Re-
sponder Error Behavior Summary on page 448. If the error can be related
to a particular QP but cannot be related to a particular WQE on that re-
ceive queue (e.g. the error occurred while executing an RDMA Write Re-
quest without immediate data), the error shall be reported to the
responder’s client as an Affiliated Asynchronous error. See Section
10.10.2.3 Asynchronous Errors on page 576 for details. If the error can be
related to a particular WQE on a given receive queue, the QP shall be
placed into the error state and the error shall be reported to the re-
sponder’s client as a Completion error. See Section 10.10.2.2 Completion
Errors on page 575."

In this commit, a new asynchrounous event 
RESPST_ERR_RKEY_VIOLATION_EVENT is introduced and implemented based on 
9.9.3.1.3. It is not a bug fix. As such, no FIXES tag.

I am fine with this. I am just wondering if this similar feature has 
already been implemented in iWARP driver or not.

Thanks,
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> 
> Generate an affiliated asynchronous error upon Rkey violations
> if the opcode does not carry an immediate. This causes async
> events at the responder for all ops that generate R_Key violations
> except WRITE_WITH_IMM, where the error can ride in with the RX WQE.
> 
> Signed-off-by: Evan Green <evgreen@meta.com>
> 
> ---
> 
>   drivers/infiniband/sw/rxe/rxe_resp.c  | 56 ++++++++++++++++++++-------
>   drivers/infiniband/sw/rxe/rxe_verbs.h |  1 +
>   2 files changed, 44 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index 711f73e0bbb1..9faf8c09aa8e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -37,6 +37,7 @@ static char *resp_state_name[] = {
>   	[RESPST_ERR_MISSING_OPCODE_LAST_D1E]	= "ERR_MISSING_OPCODE_LAST_D1E",
>   	[RESPST_ERR_TOO_MANY_RDMA_ATM_REQ]	= "ERR_TOO_MANY_RDMA_ATM_REQ",
>   	[RESPST_ERR_RNR]			= "ERR_RNR",
> +	[RESPST_ERR_RKEY_VIOLATION_EVENT]	= "ERR_RKEY_VIOLATION_EVENT",
>   	[RESPST_ERR_RKEY_VIOLATION]		= "ERR_RKEY_VIOLATION",
>   	[RESPST_ERR_INVALIDATE_RKEY]		= "ERR_INVALIDATE_RKEY_VIOLATION",
>   	[RESPST_ERR_LENGTH]			= "ERR_LENGTH",
> @@ -423,6 +424,19 @@ static void qp_resp_from_atmeth(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
>   	qp->resp.resid = sizeof(u64);
>   }
>   
> +/* Transition to an rkey violation state. C9-222.1 requires an async event
> + * at the responder, but only if the error cannot be attached to an RX WQE.
> + * WRITE_WITH_IMM is the only op that might have that more precise RX WQE
> + * to pin the error on.
> + */
> +static enum resp_states get_rkey_violation_state(struct rxe_pkt_info *pkt)
> +{
> +	if (pkt->mask & RXE_IMMDT_MASK)
> +		return RESPST_ERR_RKEY_VIOLATION;
> +
> +	return RESPST_ERR_RKEY_VIOLATION_EVENT;
> +}
> +
>   /* resolve the packet rkey to qp->resp.mr or set qp->resp.mr to NULL
>    * if an invalid rkey is received or the rdma length is zero. For middle
>    * or last packets use the stored value of mr.
> @@ -486,14 +500,14 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
>   		mw = rxe_lookup_mw(qp, access, rkey);
>   		if (!mw) {
>   			rxe_dbg_qp(qp, "no MW matches rkey %#x\n", rkey);
> -			state = RESPST_ERR_RKEY_VIOLATION;
> +			state = get_rkey_violation_state(pkt);
>   			goto err;
>   		}
>   
>   		mr = mw->mr;
>   		if (!mr) {
>   			rxe_dbg_qp(qp, "MW doesn't have an MR\n");
> -			state = RESPST_ERR_RKEY_VIOLATION;
> +			state = get_rkey_violation_state(pkt);
>   			goto err;
>   		}
>   
> @@ -507,7 +521,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
>   		mr = lookup_mr(qp->pd, access, rkey, RXE_LOOKUP_REMOTE);
>   		if (!mr) {
>   			rxe_dbg_qp(qp, "no MR matches rkey %#x\n", rkey);
> -			state = RESPST_ERR_RKEY_VIOLATION;
> +			state = get_rkey_violation_state(pkt);
>   			goto err;
>   		}
>   	}
> @@ -521,7 +535,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
>   	}
>   
>   	if (mr_check_range(mr, va + qp->resp.offset, resid)) {
> -		state = RESPST_ERR_RKEY_VIOLATION;
> +		state = get_rkey_violation_state(pkt);
>   		goto err;
>   	}
>   
> @@ -586,7 +600,7 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
>   	err = rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
>   			  payload_addr(pkt), data_len, RXE_TO_MR_OBJ);
>   	if (err) {
> -		rc = RESPST_ERR_RKEY_VIOLATION;
> +		rc = get_rkey_violation_state(pkt);
>   		goto out;
>   	}
>   
> @@ -667,7 +681,7 @@ static enum resp_states process_flush(struct rxe_qp *qp,
>   
>   	if (res->flush.type & IB_FLUSH_PERSISTENT) {
>   		if (rxe_flush_pmem_iova(mr, start, length))
> -			return RESPST_ERR_RKEY_VIOLATION;
> +			return get_rkey_violation_state(pkt);
>   		/* Make data persistent. */
>   		wmb();
>   	} else if (res->flush.type & IB_FLUSH_GLOBAL) {
> @@ -1383,6 +1397,20 @@ static enum resp_states duplicate_request(struct rxe_qp *qp,
>   	return rc;
>   }
>   
> +static void do_qp_event(struct rxe_qp *qp, enum ib_event_type etype)
> +{
> +	struct ib_event event;
> +	struct ib_qp *ibqp = &qp->ibqp;
> +
> +	event.event = etype;
> +	event.device = ibqp->device;
> +	event.element.qp = ibqp;
> +	if (ibqp->event_handler) {
> +		rxe_dbg_qp(qp, "reporting QP event %d\n", etype);
> +		ibqp->event_handler(&event, ibqp->qp_context);
> +	}
> +}
> +
>   /* Process a class A or C. Both are treated the same in this implementation. */
>   static void do_class_ac_error(struct rxe_qp *qp, u8 syndrome,
>   			      enum ib_wc_status status)
> @@ -1476,14 +1504,9 @@ static void flush_recv_queue(struct rxe_qp *qp, bool notify)
>   	int err;
>   
>   	if (qp->srq) {
> -		if (notify && qp->ibqp.event_handler) {
> -			struct ib_event ev;
> +		if (notify && qp->ibqp.event_handler)
> +			do_qp_event(qp, IB_EVENT_QP_LAST_WQE_REACHED);
>   
> -			ev.device = qp->ibqp.device;
> -			ev.element.qp = &qp->ibqp;
> -			ev.event = IB_EVENT_QP_LAST_WQE_REACHED;
> -			qp->ibqp.event_handler(&ev, qp->ibqp.qp_context);
> -		}
>   		return;
>   	}
>   
> @@ -1613,6 +1636,13 @@ int rxe_receiver(struct rxe_qp *qp)
>   			state = RESPST_CLEANUP;
>   			break;
>   
> +		case RESPST_ERR_RKEY_VIOLATION_EVENT:
> +			if (qp_type(qp) == IB_QPT_RC)
> +				do_qp_event(qp, IB_EVENT_QP_ACCESS_ERR);
> +
> +			state = RESPST_ERR_RKEY_VIOLATION;
> +			break;
> +
>   		case RESPST_ERR_RKEY_VIOLATION:
>   			if (qp_type(qp) == IB_QPT_RC) {
>   				/* Class C */
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index fd48075810dd..981f521960e8 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -154,6 +154,7 @@ enum resp_states {
>   	RESPST_ERR_MISSING_OPCODE_LAST_D1E,
>   	RESPST_ERR_TOO_MANY_RDMA_ATM_REQ,
>   	RESPST_ERR_RNR,
> +	RESPST_ERR_RKEY_VIOLATION_EVENT,
>   	RESPST_ERR_RKEY_VIOLATION,
>   	RESPST_ERR_INVALIDATE_RKEY,
>   	RESPST_ERR_LENGTH,


