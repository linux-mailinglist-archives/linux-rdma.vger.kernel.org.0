Return-Path: <linux-rdma+bounces-17043-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id E8W9ApKKmWnbUwMAu9opvQ
	(envelope-from <linux-rdma+bounces-17043-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Feb 2026 11:36:02 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5233516CAAA
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Feb 2026 11:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 319383017C06
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Feb 2026 10:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1423101A0;
	Sat, 21 Feb 2026 10:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UGaahZF/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E83E2DC334
	for <linux-rdma@vger.kernel.org>; Sat, 21 Feb 2026 10:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771670157; cv=none; b=OxQvdlwYQcTtm57ygRApwLiobBHq0KYLL3H7tN/iY9ZoejhHc6fG6ucang5ijA/u8eZcgrYAl8bSYlLUjfnVjn5GvLf6/g9cvUCEdvWIJhWp3v38hbJV3DxLgT9tsPD76h2VtE5ePHc7e8BKlnua5hGi2wReTsl70vkaVeyYP8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771670157; c=relaxed/simple;
	bh=ulTVtfaASoKXFustj9syc6Bc+KIy70JPVLK+RH/aKPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NhSLkximguSbnCf2LQdBCTWloUFwO6KE9u8/CMNmwaw01Y7xqcAZa/Tb5o50AdmrGxcOSYB0Qanl/xYoWBzavneazs4cKeL8OD0td1c94Bk0DNKpbugwiqyEHprrkw2DhvDtKqdeJipL82dApHY6+E5lwRVg5Emx1nHccWovdUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UGaahZF/; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2ce6c1d6-2634-415a-aa26-e998b4dc0135@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771670153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cOoC5gesS0WjTY2cqKr+D5Qo2tvCkmMpzgMO3IpIWLQ=;
	b=UGaahZF/Xwu7yzA3x1ioaW9wxNR4vAiEHKB1EkBuRO6tLw2lGKos8eZOVNhiuKsZtkWnAJ
	8roCYGgQtqmqwMuH/+O4u0WjrOVCf90W+1IrHkjStvBN8RrNh9N/IZOoIIm71YqEWi7hwr
	eLwkMg2wckBZKLDVNLnsWiCt97RELnI=
Date: Sat, 21 Feb 2026 02:35:48 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] RDMA/rxe: Generate async error for r_key violations
To: Evan Green <evgreen@meta.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: wguay@meta.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <20260220185533.252759-1-evgreen@meta.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260220185533.252759-1-evgreen@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-17043-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[meta.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux.dev:email,meta.com:email]
X-Rspamd-Queue-Id: 5233516CAAA
X-Rspamd-Action: no action


在 2026/2/20 10:55, Evan Green 写道:
> Table 63 of the IBTA spec lists R_Key violations as a class C
> error. 9.9.3.1.3 Responder Class C Fault Behavior indicates an
> affiliated asynchronous error should be generated at the responder
> if the error can be associated to a QP but not a particular RX WQE.
>
> Relevant portion of the spec:
> C9-222.1.1: For an HCA responder using Reliable Connection service, for
> a Class C responder side error, the error shall be reported to the
> requester by generating the appropriate NAK code as specified in Table 63
> Responder Error Behavior Summary on page 448. If the error can be related
> to a particular QP but cannot be related to a particular WQE on that
> receive queue (e.g. the error occurred while executing an RDMA Write
> Request without immediate data), the error shall be reported to the
> responder’s client as an Affiliated Asynchronous error. See Section
> 10.10.2.3 Asynchronous Errors on page 576 for details. If the error can be
> related to a particular WQE on a given receive queue, the QP shall be
> placed into the error state and the error shall be reported to the
> responder’s client as a Completion error.
>
> Generate an affiliated asynchronous error upon Rkey violations
> if the opcode does not carry an immediate. This causes async
> events at the responder for all ops that generate R_Key violations
> except WRITE_WITH_IMM, where the error can ride in with the RX WQE.
>
> Signed-off-by: Evan Green <evgreen@meta.com>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>
> ---
>
> Changes in v2:
>   - Add spec paragraph to commit message (Yanjun)

Thank you very much. I’m fine with that. Let’s wait for comments from 
Leon or Jason.

Best Regards,

Zhu Yanjun


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
> index fb149f37e91d..d92f80d16f78 100644
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

-- 
Best Regards,
Yanjun.Zhu


