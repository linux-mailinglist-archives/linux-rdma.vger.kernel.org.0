Return-Path: <linux-rdma+bounces-21738-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CRNNAYg7IWo3BgEAu9opvQ
	(envelope-from <linux-rdma+bounces-21738-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 10:47:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D036B63E201
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 10:47:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="CC+UpIE/";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21738-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21738-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D36473072416
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 08:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25A03E275F;
	Thu,  4 Jun 2026 08:36:58 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A22C3E1696
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2026 08:36:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562218; cv=none; b=nJxzMWmH2ZLv3/hXsDGVi81792izvPm6U1LzdVJBqfEYEOQ5HG1LOEjh3B0Xax5ZCZc49UQijhltlPUUIDa0PDsesok8aUp5IUCyP2Cq74VwvW1b1nYVYLMaVumG5T6fzgQsdmADZ6AJUlp++AhEvpm2o1tddyjidnhv1bohjmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562218; c=relaxed/simple;
	bh=nprcEBE1NGKw2i4OlDzdzgm0LU77LybYr+IdaJAH+j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2SpAnG7S4RBSXIIjNuI3WbqK3tV6XCgvWLkUd20yfMT9Gzlf+ePRyaBnJkwbS40IME/eu2Dm17LZfhpQ64MNDtB173ejXqj8LWrBeBDSVCF1Ge95Xdb1VtU2/Te3b0yF+FRCWU9a/TufESNXkhReDo/oAbPFVPti+omGjVrtLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CC+UpIE/; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780562216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ahCppztDq6+HeauIzaJ6zc0IwFK9+tiuCYjSpFg9FQY=;
	b=CC+UpIE/cVCl8DZaM2+qDS03lOBch8mZyCqfdZGch38jwAOF07RM3imlXJhtkZLlMbuub5
	wukW1RBr8XXLrR5wkKT5avs/sY91qDuHffNfFJ/TthjpGXUrWpwg916vijK9EJMXMgq5yA
	/T2kDoyl+Qcy9r2oAyurdl4dwvkxt7w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-AwHBzJWyOfCMpnNX2-oKBg-1; Thu,
 04 Jun 2026 04:36:52 -0400
X-MC-Unique: AwHBzJWyOfCMpnNX2-oKBg-1
X-Mimecast-MFC-AGG-ID: AwHBzJWyOfCMpnNX2-oKBg_1780562210
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B17C18004BB;
	Thu,  4 Jun 2026 08:36:49 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.23])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 670851800347;
	Thu,  4 Jun 2026 08:36:42 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: alibuda@linux.alibaba.com
Cc: davem@davemloft.net,
	dust.li@linux.alibaba.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	mjambigi@linux.ibm.com,
	horms@kernel.org,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	oliver.yang@linux.alibaba.com,
	pasic@linux.ibm.com,
	leonro@nvidia.com
Subject: Re: [PATCH net-next v2 1/2] net/smc: transition to RDMA core CQ pooling
Date: Thu,  4 Jun 2026 10:36:37 +0200
Message-ID: <20260604083637.61737-1-pabeni@redhat.com>
In-Reply-To: <20260528084819.6059-2-alibuda@linux.alibaba.com>
References: <20260528084819.6059-2-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:alibuda@linux.alibaba.com,m:davem@davemloft.net,m:dust.li@linux.alibaba.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:mjambigi@linux.ibm.com,m:horms@kernel.org,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:oliver.yang@linux.alibaba.com,m:pasic@linux.ibm.com,m:leonro@nvidia.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21738-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D036B63E201

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/
---
net/smc: transition to RDMA core CQ pooling

The current SMC-R implementation relies on global per-device CQs
and manual polling within tasklets, which introduces severe
scalability bottlenecks due to global lock contention and tasklet
scheduling overhead, resulting in poor performance as concurrency
increases.

Refactor the completion handling to utilize the ib_cqe API and
standard RDMA core CQ pooling.

> diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
> index 9bb495707445e..a6d6b81830d38 100644
> --- a/net/smc/smc_ib.c
> +++ b/net/smc/smc_ib.c

[ ... ]

> @@ -657,38 +645,59 @@ void smc_ib_destroy_queue_pair(struct smc_link *lnk)
>  	if (lnk->roce_qp)
>  		ib_destroy_qp(lnk->roce_qp);
>  	lnk->roce_qp = NULL;
> +	if (lnk->ib_cq) {
> +		ib_cq_pool_put(lnk->ib_cq, lnk->nr_cqe);
> +		lnk->ib_cq = NULL;
> +	}
>  }
>  
>  /* create a queue pair within the protection domain for a link */
>  int smc_ib_create_queue_pair(struct smc_link *lnk)
>  {
> +	int max_send_wr, max_recv_wr, rc;
> +	struct ib_cq *cq;
> +
> +	/* include unsolicited rdma_writes as well,
> +	 * there are max. 2 RDMA_WRITE per 1 WR_SEND.
> +	 */
> +	max_send_wr = 3 * lnk->lgr->max_send_wr + 1;	/* +1 for ib_drain_sq() */

[Severity: High]
Does this calculation account for all possible work requests?

To support ib_drain_sq(), this patch increases SQ capacity by exactly 1,
assuming standard data transmissions consume up to 3 WRs each. However, SMC
also posts FastReg WRs (smc_wr_reg_send) and SMC-Rv2 LLC control messages
(smc_wr_tx_v2_send) to the same SQ.

If these independent WRs are posted while data TX slots are saturated, the
total in-flight WRs will consume the remaining +1 slot reserved for the drain
WR.

When teardown occurs, ib_drain_sq() will attempt to post its dummy WR, but
ib_post_send() will fail with -ENOMEM because the SQ is full. ib_drain_sq()
responds to this failure by returning immediately without waiting for
completions, unblocking teardown and freeing link structures while the
hardware is still asynchronously flushing the SQ. When the softirq polls the
flushed CQEs, it will access the freed ib_cqe pointers, leading to a
use-after-free.

> +	max_recv_wr = lnk->lgr->max_recv_wr + 1;	/* +1 for ib_drain_rq() */
> +
> +	cq = ib_cq_pool_get(lnk->smcibdev->ibdev, max_send_wr + max_recv_wr, -1,
> +			    IB_POLL_SOFTIRQ);

[ ... ]

> diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
> index 59c92b46945c5..130bc6c26fb31 100644
> --- a/net/smc/smc_wr.c
> +++ b/net/smc/smc_wr.c

[ ... ]

> @@ -63,109 +60,67 @@ void smc_wr_tx_wait_no_pending_sends(struct smc_link *link)

[ ... ]

>  	if (pnd_snd_idx == link->wr_tx_cnt) {
> -		if (link->lgr->smc_version != SMC_V2 ||
> -		    link->wr_tx_v2_pend->wr_id != wc->wr_id)
> -			return;
> -		link->wr_tx_v2_pend->wc_status = wc->status;
> -		memcpy(&pnd_snd, link->wr_tx_v2_pend, sizeof(pnd_snd));
> -		/* clear the full struct smc_wr_tx_pend including .priv */
> -		memset(link->wr_tx_v2_pend, 0,
> -		       sizeof(*link->wr_tx_v2_pend));
>  		memset(link->lgr->wr_tx_buf_v2, 0,
>  		       sizeof(*link->lgr->wr_tx_buf_v2));

[Severity: High]
This is a pre-existing issue, but while reviewing this code I noticed a
potential memory leak and NULL pointer dereference in smc_wr_tx_put_slot().

In the error path of smc_wr_tx_put_slot(), the code attempts to clear the V2
pending slots:

net/smc/smc_wr.c:smc_wr_tx_put_slot() {
    ...
	} else if (link->lgr->smc_version == SMC_V2 &&
		   pend->idx == link->wr_tx_cnt) {
		/* Large v2 buffer */
		memset(&link->wr_tx_v2_pend, 0,
		       sizeof(link->wr_tx_v2_pend));
		memset(&link->lgr->wr_tx_buf_v2, 0,
		       sizeof(link->lgr->wr_tx_buf_v2));
    ...
}

Because these target variables are pointers, sizeof evaluates to 8 bytes. The
memset() call zeroes the pointer variable itself rather than clearing the
underlying structure, which leaks the allocated memory.

If smc_wr_tx_get_v2_slot() is called subsequently, it will attempt to
dereference the now-NULL link->wr_tx_v2_pend, leading to a direct NULL pointer
dereference.

Could this be updated to use sizeof(*link->wr_tx_v2_pend) similar to the code
removed above?

[ ... ]

> @@ -431,94 +367,74 @@ static inline void smc_wr_rx_demultiplex(struct ib_wc *wc)
>  {

[ ... ]

>  }
>  
> -static inline void smc_wr_rx_process_cqes(struct ib_wc wc[], int num)
> +static void smc_wr_rx_process_cqe(struct ib_cq *cq, struct ib_wc *wc)
>  {
> -	struct smc_link *link;
> -	int i;
> +	struct smc_link *link = wc->qp->qp_context;
>  
> -	for (i = 0; i < num; i++) {
> -		link = wc[i].qp->qp_context;
> -		link->wr_rx_id_compl = wc[i].wr_id;
> -		if (wc[i].status == IB_WC_SUCCESS) {
> -			link->wr_rx_tstamp = jiffies;
> -			smc_wr_rx_demultiplex(&wc[i]);
> -			smc_wr_rx_post(link); /* refill WR RX */
> -		} else {
> -			/* handle status errors */
> -			switch (wc[i].status) {
> -			case IB_WC_RETRY_EXC_ERR:
> -			case IB_WC_RNR_RETRY_EXC_ERR:
> -			case IB_WC_WR_FLUSH_ERR:
> -				smcr_link_down_cond_sched(link);
> -				if (link->wr_rx_id_compl == link->wr_rx_id)
> -					wake_up(&link->wr_rx_empty_wait);
> -				break;
> -			default:
> -				smc_wr_rx_post(link); /* refill WR RX */
> -				break;
> -			}
> +	if (wc->status == IB_WC_SUCCESS) {
> +		link->wr_rx_tstamp = jiffies;
> +		smc_wr_rx_demultiplex(wc);
> +		smc_wr_rx_post(link, wc->wr_cqe); /* refill WR RX */

[Severity: Critical]
Can this cause a use-after-free when racing with queue teardown?

The patch replaces smc_wr_drain_cq() with ib_drain_qp().
ib_drain_rq() transitions the QP to IB_QPS_ERR and posts a dummy drain WR to
wait for completions.

However, smc_wr_rx_process_cqe() unconditionally reposts a new WR when
processing a successful packet completion. If a valid RX completion is polled
in the softirq concurrently with ib_drain_rq(), the softirq will post a new WR
after the drain WR has been posted.

Since the QP is in the ERR state, the new WR will be immediately completed
with a flush error, but its CQE will be generated after the drain WR's CQE.
This allows ib_drain_rq() to return and unblock link teardown, freeing
link->wr_rx_ibs.

When the softirq subsequently polls the flush CQE for the newly posted WR,
it will dereference wc->wr_cqe->done. Since wc->wr_cqe points to the freed
smc_ib_recv_wr, this results in a use-after-free.

> +	} else {
> +		/* handle status errors */
> +		switch (wc->status) {
> +		case IB_WC_RETRY_EXC_ERR:
> +		case IB_WC_RNR_RETRY_EXC_ERR:
> +		case IB_WC_WR_FLUSH_ERR:
> +			smcr_link_down_cond_sched(link);
> +			break;
> +		default:
> +			smc_wr_rx_post(link, wc->wr_cqe); /* refill WR RX */
> +			break;
>  		}
>  	}
>  }
-- 
This is an AI-generated review.


