Return-Path: <linux-rdma+bounces-21819-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d2soA6tKImoTUwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21819-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 06:03:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE9D644FD4
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 06:03:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=rE7HcEjH;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21819-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21819-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC09030226A0
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 04:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE26C2FE56E;
	Fri,  5 Jun 2026 04:00:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1894C2773E5;
	Fri,  5 Jun 2026 04:00:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780632032; cv=none; b=ovDhNlJ/E3/+uEa4xS8gqFgrlqKjjl8aokgHcjUeZ/7tki9SGTqYyvw7PZ2Nd7/ACjSgn7CBdloeD/t9yzZDDajlxn+s5132pmWdSjaaLlUP1zkSwxDyfW1rsR4SDM6+pXSvFOfXAE341Cn3jy0c4avroZe6bzKBSpWvIA/sCu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780632032; c=relaxed/simple;
	bh=ssVepqQO0pAFjh5eOWKCXQUfSAThy7uGzZOvQ/biCXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKb35M7lRXD/hVehN30ohaZhQ2svSJfLMRQUJF/Q2oDoSzqcij4MVSKG9a/rWuymPVLc5dmXhgVHjVp166VfpuQ7eDT/xOiLHea9J6jUZaOjkftBUSMFtLzRQrucbI1rujTYOzLw5rudt/fUSRt+TcAYdZJd3sRNJTByBOFzXPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rE7HcEjH; arc=none smtp.client-ip=115.124.30.119
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780632026; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=WjvFR5I7aT6sxM14afkrMm8W9jawGkW5mpGdPwuQ0pI=;
	b=rE7HcEjHsPzR4Y0gEj9cYQMCen1F0Wp+SykFFGOORKkTIUDk5vd6LwbHn7Zs+m4eA42cJiaRiCX3InzOvh87+E+k8rDV2mXbJpzMNgz7OTbABDUF+lgxi6Rl18a9gZQsi2B3+rNQX+JjR+yBclCfP/1nPrUrgQH05B0bnsGa3CE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X4Bwyea_1780632025;
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0X4Bwyea_1780632025 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 05 Jun 2026 12:00:26 +0800
Date: Fri, 5 Jun 2026 12:00:25 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Paolo Abeni <pabeni@redhat.com>
Cc: alibuda@linux.alibaba.com, davem@davemloft.net,
	dust.li@linux.alibaba.com, edumazet@google.com, kuba@kernel.org,
	sidraya@linux.ibm.com, wenjia@linux.ibm.com, mjambigi@linux.ibm.com,
	horms@kernel.org, tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	oliver.yang@linux.alibaba.com, pasic@linux.ibm.com,
	leonro@nvidia.com
Subject: Re: [PATCH net-next v2 1/2] net/smc: transition to RDMA core CQ
 pooling
Message-ID: <20260605040025.GB60671@j66a10360.sqa.eu95>
References: <20260528084819.6059-2-alibuda@linux.alibaba.com>
 <20260604083637.61737-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260604083637.61737-1-pabeni@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:alibuda@linux.alibaba.com,m:davem@davemloft.net,m:dust.li@linux.alibaba.com,m:edumazet@google.com,m:kuba@kernel.org,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:mjambigi@linux.ibm.com,m:horms@kernel.org,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:oliver.yang@linux.alibaba.com,m:pasic@linux.ibm.com,m:leonro@nvidia.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[alibuda@linux.alibaba.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21819-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alibuda@linux.alibaba.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.alibaba.com:from_mime,linux.alibaba.com:dkim,j66a10360.sqa.eu95:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5BE9D644FD4

On Thu, Jun 04, 2026 at 10:36:37AM +0200, Paolo Abeni wrote:
> From: AI Reviewer <ai@example.com>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev/
> ---
> net/smc: transition to RDMA core CQ pooling
> 
> The current SMC-R implementation relies on global per-device CQs
> and manual polling within tasklets, which introduces severe
> scalability bottlenecks due to global lock contention and tasklet
> scheduling overhead, resulting in poor performance as concurrency
> increases.
> 
> Refactor the completion handling to utilize the ib_cqe API and
> standard RDMA core CQ pooling.
> 
> > diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
> > index 9bb495707445e..a6d6b81830d38 100644
> > --- a/net/smc/smc_ib.c
> > +++ b/net/smc/smc_ib.c
> 
> [ ... ]
> 
> > @@ -657,38 +645,59 @@ void smc_ib_destroy_queue_pair(struct smc_link *lnk)
> >  	if (lnk->roce_qp)
> >  		ib_destroy_qp(lnk->roce_qp);
> >  	lnk->roce_qp = NULL;
> > +	if (lnk->ib_cq) {
> > +		ib_cq_pool_put(lnk->ib_cq, lnk->nr_cqe);
> > +		lnk->ib_cq = NULL;
> > +	}
> >  }
> >  
> >  /* create a queue pair within the protection domain for a link */
> >  int smc_ib_create_queue_pair(struct smc_link *lnk)
> >  {
> > +	int max_send_wr, max_recv_wr, rc;
> > +	struct ib_cq *cq;
> > +
> > +	/* include unsolicited rdma_writes as well,
> > +	 * there are max. 2 RDMA_WRITE per 1 WR_SEND.
> > +	 */
> > +	max_send_wr = 3 * lnk->lgr->max_send_wr + 1;	/* +1 for ib_drain_sq() */
> 
> [Severity: High]
> Does this calculation account for all possible work requests?
> 
> To support ib_drain_sq(), this patch increases SQ capacity by exactly 1,
> assuming standard data transmissions consume up to 3 WRs each. However, SMC
> also posts FastReg WRs (smc_wr_reg_send) and SMC-Rv2 LLC control messages
> (smc_wr_tx_v2_send) to the same SQ.
> 
> If these independent WRs are posted while data TX slots are saturated, the
> total in-flight WRs will consume the remaining +1 slot reserved for the drain
> WR.
> 
> When teardown occurs, ib_drain_sq() will attempt to post its dummy WR, but
> ib_post_send() will fail with -ENOMEM because the SQ is full. ib_drain_sq()
> responds to this failure by returning immediately without waiting for
> completions, unblocking teardown and freeing link structures while the
> hardware is still asynchronously flushing the SQ. When the softirq polls the
> flushed CQEs, it will access the freed ib_cqe pointers, leading to a
> use-after-free.
> 

Good catch. The +1 is indeed not enough.

The SQ has three independent producers but only the data path (3*N) was counted.
FastReg (link->wr_reg) and the SMC-Rv2 v2 SEND (link->wr_tx_v2_ib) are both link-unique,
so up to 3N + 2 WRs can be in flight when __ib_drain_sq() posts its drain WR.

With only +1 the __ib_drain_sq() may return without draining, and teardown frees the link
while WRs are still in flight.

The undersizing itself is pre-existing — 3*N never reserved room for FastReg/v2,
but it was harmless before. This series only turns it fatal by moving to ib_drain_qp(),
which actually posts a WR. Since it was benign on its own, I'll just fix it
here in the next revision rather than as a separate patch, bumping the 
reservation to +3 (drain + FastReg + v2).

> > +	max_recv_wr = lnk->lgr->max_recv_wr + 1;	/* +1 for ib_drain_rq() */
> > +
> > +	cq = ib_cq_pool_get(lnk->smcibdev->ibdev, max_send_wr + max_recv_wr, -1,
> > +			    IB_POLL_SOFTIRQ);
> 
> [ ... ]
> 
> > diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
> > index 59c92b46945c5..130bc6c26fb31 100644
> > --- a/net/smc/smc_wr.c
> > +++ b/net/smc/smc_wr.c
> 
> [ ... ]
> 
> > @@ -63,109 +60,67 @@ void smc_wr_tx_wait_no_pending_sends(struct smc_link *link)
> 
> [ ... ]
> 
> >  	if (pnd_snd_idx == link->wr_tx_cnt) {
> > -		if (link->lgr->smc_version != SMC_V2 ||
> > -		    link->wr_tx_v2_pend->wr_id != wc->wr_id)
> > -			return;
> > -		link->wr_tx_v2_pend->wc_status = wc->status;
> > -		memcpy(&pnd_snd, link->wr_tx_v2_pend, sizeof(pnd_snd));
> > -		/* clear the full struct smc_wr_tx_pend including .priv */
> > -		memset(link->wr_tx_v2_pend, 0,
> > -		       sizeof(*link->wr_tx_v2_pend));
> >  		memset(link->lgr->wr_tx_buf_v2, 0,
> >  		       sizeof(*link->lgr->wr_tx_buf_v2));
> 
> [Severity: High]
> This is a pre-existing issue, but while reviewing this code I noticed a
> potential memory leak and NULL pointer dereference in smc_wr_tx_put_slot().
> 
> In the error path of smc_wr_tx_put_slot(), the code attempts to clear the V2
> pending slots:
> 
> net/smc/smc_wr.c:smc_wr_tx_put_slot() {
>     ...
> 	} else if (link->lgr->smc_version == SMC_V2 &&
> 		   pend->idx == link->wr_tx_cnt) {
> 		/* Large v2 buffer */
> 		memset(&link->wr_tx_v2_pend, 0,
> 		       sizeof(link->wr_tx_v2_pend));
> 		memset(&link->lgr->wr_tx_buf_v2, 0,
> 		       sizeof(link->lgr->wr_tx_buf_v2));
>     ...
> }
> 
> Because these target variables are pointers, sizeof evaluates to 8 bytes. The
> memset() call zeroes the pointer variable itself rather than clearing the
> underlying structure, which leaks the allocated memory.
> 
> If smc_wr_tx_get_v2_slot() is called subsequently, it will attempt to
> dereference the now-NULL link->wr_tx_v2_pend, leading to a direct NULL pointer
> dereference.
> 
> Could this be updated to use sizeof(*link->wr_tx_v2_pend) similar to the code
> removed above?
> 
> [ ... ]
> 

Makes sense. Since this is pre-existing and unrelated to this series,
I'll send it as a separate patch.

> > @@ -431,94 +367,74 @@ static inline void smc_wr_rx_demultiplex(struct ib_wc *wc)
> >  {
> 
> [ ... ]
> 
> >  }
> >  
> > -static inline void smc_wr_rx_process_cqes(struct ib_wc wc[], int num)
> > +static void smc_wr_rx_process_cqe(struct ib_cq *cq, struct ib_wc *wc)
> >  {
> > -	struct smc_link *link;
> > -	int i;
> > +	struct smc_link *link = wc->qp->qp_context;
> >  
> > -	for (i = 0; i < num; i++) {
> > -		link = wc[i].qp->qp_context;
> > -		link->wr_rx_id_compl = wc[i].wr_id;
> > -		if (wc[i].status == IB_WC_SUCCESS) {
> > -			link->wr_rx_tstamp = jiffies;
> > -			smc_wr_rx_demultiplex(&wc[i]);
> > -			smc_wr_rx_post(link); /* refill WR RX */
> > -		} else {
> > -			/* handle status errors */
> > -			switch (wc[i].status) {
> > -			case IB_WC_RETRY_EXC_ERR:
> > -			case IB_WC_RNR_RETRY_EXC_ERR:
> > -			case IB_WC_WR_FLUSH_ERR:
> > -				smcr_link_down_cond_sched(link);
> > -				if (link->wr_rx_id_compl == link->wr_rx_id)
> > -					wake_up(&link->wr_rx_empty_wait);
> > -				break;
> > -			default:
> > -				smc_wr_rx_post(link); /* refill WR RX */
> > -				break;
> > -			}
> > +	if (wc->status == IB_WC_SUCCESS) {
> > +		link->wr_rx_tstamp = jiffies;
> > +		smc_wr_rx_demultiplex(wc);
> > +		smc_wr_rx_post(link, wc->wr_cqe); /* refill WR RX */
> 
> [Severity: Critical]
> Can this cause a use-after-free when racing with queue teardown?
> 
> The patch replaces smc_wr_drain_cq() with ib_drain_qp().
> ib_drain_rq() transitions the QP to IB_QPS_ERR and posts a dummy drain WR to
> wait for completions.
> 
> However, smc_wr_rx_process_cqe() unconditionally reposts a new WR when
> processing a successful packet completion. If a valid RX completion is polled
> in the softirq concurrently with ib_drain_rq(), the softirq will post a new WR
> after the drain WR has been posted.
> 
> Since the QP is in the ERR state, the new WR will be immediately completed
> with a flush error, but its CQE will be generated after the drain WR's CQE.
> This allows ib_drain_rq() to return and unblock link teardown, freeing
> link->wr_rx_ibs.
> 
> When the softirq subsequently polls the flush CQE for the newly posted WR,
> it will dereference wc->wr_cqe->done. Since wc->wr_cqe points to the freed
> smc_ib_recv_wr, this results in a use-after-free.
>

The analysis is right, and unlike the other two this one is introduced by this
series. The old smc_wr_drain_cq() was a pure counting wait that posted
no WR, so the unconditional repost was harmless. By switching to
ib_drain_qp(), which relies on the drain WR being the last WR on the
queue, the same repost now breaks that invariant and opens the UAF
window.

I'll fix it in the next revision by quiescing the repost path
before draining, so the drain WR is guaranteed to be the last one.

D. Wythe

> > +	} else {
> > +		/* handle status errors */
> > +		switch (wc->status) {
> > +		case IB_WC_RETRY_EXC_ERR:
> > +		case IB_WC_RNR_RETRY_EXC_ERR:
> > +		case IB_WC_WR_FLUSH_ERR:
> > +			smcr_link_down_cond_sched(link);
> > +			break;
> > +		default:
> > +			smc_wr_rx_post(link, wc->wr_cqe); /* refill WR RX */
> > +			break;
> >  		}
> >  	}
> >  }
> -- 
> This is an AI-generated review.

