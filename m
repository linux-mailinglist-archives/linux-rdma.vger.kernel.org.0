Return-Path: <linux-rdma+bounces-17290-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOxoNkVloWnIsQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17290-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 10:35:01 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C1D1B5685
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 10:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E037309222B
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 09:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94521393DE3;
	Fri, 27 Feb 2026 09:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iT4yGQpi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC660389479;
	Fri, 27 Feb 2026 09:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772184843; cv=none; b=Jf9vHJZXh+xoTSi0yIEMoMmI4sqjrK/ecEmIYZDbDZ4pQpRqQMFh00lm7+W8fOg7U//r3vjH4dm2bmRgWRr5a3AXSSnT/16bY1i1KgsC/cDwE+ciWzKet6yGtNaeBXjPWVzEg/XA8tFshfgcmwJLrBRvzNmsTs+/Fp3LPzrNlGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772184843; c=relaxed/simple;
	bh=td37NIOHY2ji/tXN+dKOtfkkarM64lekDKEUZkkeiZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IK8r1XdwPdfBFaPbrhf7R2sVH2OHAMn+zbFtcSkGdcVV4RorSm6YBqP1DGLk4/VTN1vByg+gu1XoZA+6c20z/ciQO25SHlA5Uz6p2Nv8zQRHkXFvGyPxCchL2g7EBXPhzE+aieVd2OopAx1DMBCAXwFNaS1Ft4ZvaKO4CFxc5dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iT4yGQpi; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772184835; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=Q+XIwkWLlcITtwiYjH9sK/PetlqVXTB9ZTWf1c5WVTo=;
	b=iT4yGQpiDhNcZKtBzsrBj6Yy9t7nOf9Bg/htmJzp1v2kvrH4qpGXH3XmMAkp5JbYUHUvI9c+bOYvWE4mCVGC4JHY63bvr53C+ZokijJCkbWoaNMi/DNutHnfaBRgWmqsKCyhHmxuBOT80XMr2BCEk1winmQXB+Uj3bv8OwZyk0c=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0Wzu.X7H_1772184834 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Feb 2026 17:33:55 +0800
Date: Fri, 27 Feb 2026 17:33:54 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Jakub Kicinski <kuba@kernel.org>
Cc: alibuda@linux.alibaba.com, netdev@vger.kernel.org, pabeni@redhat.com,
	linux-rdma@vger.kernel.org, sidraya@linux.ibm.com, horms@kernel.org,
	davem@davemloft.net, linux-s390@vger.kernel.org,
	mjambigi@linux.ibm.com, oliver.yang@linux.alibaba.com,
	edumazet@google.com, wenjia@linux.ibm.com, guwen@linux.alibaba.com,
	tonylu@linux.alibaba.com, dust.li@linux.alibaba.com,
	linux-kernel@vger.kernel.org, pasic@linux.ibm.com
Subject: Re: [net-next] net/smc: transition to RDMA core CQ pooling
Message-ID: <20260227093354.GA130906@j66a10360.sqa.eu95>
References: <20260225024513.7861-1-alibuda@linux.alibaba.com>
 <20260227035300.2628494-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227035300.2628494-1-kuba@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17290-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	URIBL_MULTI_FAIL(0.00)[j66a10360.sqa.eu95:server fail,linux.alibaba.com:server fail,tor.lore.kernel.org:server fail,linux.dev:server fail];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alibuda@linux.alibaba.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,linux.alibaba.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78C1D1B5685
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 07:53:00PM -0800, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net/smc: transition to RDMA core CQ pooling
> 
> This commit refactors SMC-R completion handling to use the ib_cqe API
> and RDMA core CQ pooling, replacing the previous per-device global CQs
> and manual tasklet polling. The refactoring aims to eliminate scalability
> bottlenecks by enabling multi-CQ parallelization and O(1) context retrieval.
> 
> > diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
> > index 5feafa98ab1a..4a4924c5cade 100644
> > --- a/net/smc/smc_wr.c
> > +++ b/net/smc/smc_wr.c
> 
> [ ... ]
> 
> > @@ -63,55 +60,52 @@ void smc_wr_tx_wait_no_pending_sends(struct smc_link *link)
> >  	wait_event(link->wr_tx_wait, !smc_wr_is_tx_pend(link));
> >  }
> >
> > -static inline int smc_wr_tx_find_pending_index(struct smc_link *link, u64 wr_id)
> > +static void smc_wr_tx_rdma_process_cqe(struct ib_cq *cq, struct ib_wc *wc)
> >  {
> > -	u32 i;
> > +	struct smc_link *link = wc->qp->qp_context;
> >
> > -	for (i = 0; i < link->wr_tx_cnt; i++) {
> > -		if (link->wr_tx_pends[i].wr_id == wr_id)
> > -			return i;
> > -	}
> > -	return link->wr_tx_cnt;
> > +	/* terminate link */
> > +	if (wc->status)
> > +		smcr_link_down_cond_sched(link);
> > +}
> > +
> > +static void smc_wr_reg_process_cqe(struct ib_cq *cq, struct ib_wc *wc)
> > +{
> > +	struct smc_link *link = wc->qp->qp_context;
> > +
> > +	if (wc->status)
> > +		link->wr_reg_state = FAILED;
> > +	else
> > +		link->wr_reg_state = CONFIRMED;
> > +	smc_wr_wakeup_reg_wait(link);
> >  }
> >
> > -static inline void smc_wr_tx_process_cqe(struct ib_wc *wc)
> > +static void smc_wr_tx_process_cqe(struct ib_cq *cq, struct ib_wc *wc)
> >  {
> > -	struct smc_wr_tx_pend pnd_snd;
> > +	struct smc_wr_tx_pend *tx_pend, pnd_snd;
> > +	struct smc_ib_send_wr *send_wr;
> >  	struct smc_link *link;
> >  	u32 pnd_snd_idx;
> >
> >  	link = wc->qp->qp_context;
> >
> > -	if (wc->opcode == IB_WC_REG_MR) {
> > -		if (wc->status)
> > -			link->wr_reg_state = FAILED;
> > -		else
> > -			link->wr_reg_state = CONFIRMED;
> > -		smc_wr_wakeup_reg_wait(link);
> > -		return;
> > -	}
> > +	send_wr = container_of(wc->wr_cqe, struct smc_ib_send_wr, cqe);
> > +	pnd_snd_idx = send_wr->idx;
> > +
> > +	tx_pend = (pnd_snd_idx == link->wr_tx_cnt) ? link->wr_tx_v2_pend :
> > +		&link->wr_tx_pends[pnd_snd_idx];
> > +
> > +	tx_pend->wc_status = wc->status;
> > +	memcpy(&pnd_snd, tx_pend, sizeof(pnd_snd));
> > +	/* clear the full struct smc_wr_tx_pend including .priv */
> > +	memset(tx_pend, 0, sizeof(*tx_pend));
> >
> > -	pnd_snd_idx = smc_wr_tx_find_pending_index(link, wc->wr_id);
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
> >  	} else {
> > -		link->wr_tx_pends[pnd_snd_idx].wc_status = wc->status;
> > -		if (link->wr_tx_pends[pnd_snd_idx].compl_requested)
> > +		if (tx_pend->compl_requested)
>                     ^^^^^^
> 
> Does this read the correct field? The code above memsets tx_pend to zero,
> so compl_requested is always 0 and complete() is never called.
> 
> The refactoring created a local copy pnd_snd before the memset:
> 
> memcpy(&pnd_snd, tx_pend, sizeof(pnd_snd));
> memset(tx_pend, 0, sizeof(*tx_pend));
> 
> But then it reads from the zeroed tx_pend instead of pnd_snd. Should this be
> pnd_snd.compl_requested instead?
> 
> This affects smc_wr_tx_send_wait(), which sets compl_requested and waits for
> the completion that never arrives, causing LLC message timeouts.
> 

Nice catch! It should indeed be pnd_snd.compl_requested here since tx_pend has been zeroed.
Will fix in v2.

> >  			complete(&link->wr_tx_compl[pnd_snd_idx]);
> > -		memcpy(&pnd_snd, &link->wr_tx_pends[pnd_snd_idx],
> > -		       sizeof(pnd_snd));
> > -		/* clear the full struct smc_wr_tx_pend including .priv */
> > -		memset(&link->wr_tx_pends[pnd_snd_idx], 0,
> > -		       sizeof(link->wr_tx_pends[pnd_snd_idx]));
> >  		memset(&link->wr_tx_bufs[pnd_snd_idx], 0,
> >  		       sizeof(link->wr_tx_bufs[pnd_snd_idx]));
> >  		if (!test_and_clear_bit(pnd_snd_idx, link->wr_tx_mask))
> 
> [ ... ]
> 
> > @@ -550,7 +472,7 @@ void smc_wr_remember_qp_attr(struct smc_link *lnk)
> >  	lnk->wr_tx_cnt = min_t(size_t, lnk->max_send_wr,
> >  			       lnk->qp_attr.cap.max_send_wr);
> >  	lnk->wr_rx_cnt = min_t(size_t, lnk->max_recv_wr,
> > -			       lnk->qp_attr.cap.max_recv_wr);
> > +			       lnk->qp_attr.cap.max_recv_wr - 1);	/* -1 for ib_draib_rq() */
>                                                                                         ^^^^^^^^^^^^^^
> This isn't a bug, but there's a typo in the comment: ib_draib_rq() should be
> ib_drain_rq().

Will fix in v2. Thanks.

D. Wythe

> 
> >  }
> 
> [ ... ]
> -- 
> pw-bot: cr

