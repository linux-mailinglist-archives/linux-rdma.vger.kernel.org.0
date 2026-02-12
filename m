Return-Path: <linux-rdma+bounces-16779-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPTDIMuijWlh5gAAu9opvQ
	(envelope-from <linux-rdma+bounces-16779-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 10:52:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C870912C0A5
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 10:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA7CE300BD94
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 09:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59F82D8387;
	Thu, 12 Feb 2026 09:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KzsB5jse"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C7B2B9A4;
	Thu, 12 Feb 2026 09:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770889889; cv=none; b=eMn4hjfbExVOhVTzPaeRHRJ7BV+rQ2wOkRs4KppF2xQKlywJ0Dcjt7p08FkXLEwuyKEe4ZrwO1wGQb2j+M/418FRLZo/W8LpYoESrQZyKnrtRZsrt7PYmFB4JwDWdgXT1FezGxXGP7fGFwVH45fa+Cc1/CEdt4I/VqvB33wzpy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770889889; c=relaxed/simple;
	bh=B7sBeI2OHeGzGmEM1MDciZvw3RM4fLtNiVKVRT4HeoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDO+M2o+xl/1JcF6QcpxSsY8UZznVnC0rN91KfHGKmBnTEfHu51sHEZr9WUhYn9HqQCsaRKsdwn5dQhmcxqKcfc8eqiqwroKU89+W5H1ocug98pKjKTWvLjVis4NcdhP0kffXrRv65Xh1KIQmeBwngJ1MTIXIse/mMSj6kFk1O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KzsB5jse; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770889883; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=qpruaUwKwh867x0HVlxV3T2XoeP5v0Ct5QMf35UW6c8=;
	b=KzsB5jseH9KBJrEiaBxupfDEKfEu0bEOqa6aO3ELO30XhuxMCNY1Uhq+erULMCmoIhnoVVWXBsR2FHDxY8+B28Ig9EwiiGFm3utBQdmjYFNnwy4CWyVyTiYLH8DW08qlnqf+nAAas4TGSLfzqLHEMpKoXAo3x9n8YmEyzVZZaUQ=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0Wz4YnRr_1770888937 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Feb 2026 17:35:37 +0800
Date: Thu, 12 Feb 2026 17:35:37 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Dust Li <dust.li@linux.alibaba.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, oliver.yang@linux.alibaba.com,
	pasic@linux.ibm.com
Subject: Re: [PATCH RFC net-next] net/smc: transition to RDMA core CQ pooling
Message-ID: <20260212093537.GA27899@j66a10360.sqa.eu95>
References: <20260202094800.30373-1-alibuda@linux.alibaba.com>
 <aYx7Uh9MmJsPWUu4@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYx7Uh9MmJsPWUu4@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alibuda@linux.alibaba.com,linux-rdma@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email,linux.alibaba.com:dkim,j66a10360.sqa.eu95:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16779-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.alibaba.com:+]
X-Rspamd-Queue-Id: C870912C0A5
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 08:51:30PM +0800, Dust Li wrote:
> On 2026-02-02 17:48:00, D. Wythe wrote:
> >The current SMC-R implementation relies on global per-device CQs
> >and manual polling within tasklets, which introduces severe
> >scalability bottlenecks due to global lock contention and tasklet
> >scheduling overhead, resulting in poor performance as concurrency
> >increases.
> >
> >Refactor the completion handling to utilize the ib_cqe API and
> >standard RDMA core CQ pooling. This transition provides several key
> >advantages:
> >
> >1. Multi-CQ: Shift from a single shared per-device CQ to multiple
> >link-specific CQs via the CQ pool. This allows completion processing
> >to be parallelized across multiple CPU cores, effectively eliminating
> >the global CQ bottleneck.
> >
> >2. Leverage DIM: Utilizing the standard CQ pool with IB_POLL_SOFTIRQ
> >enables Dynamic Interrupt Moderation from the RDMA core, optimizing
> >interrupt frequency and reducing CPU load under high pressure.
> >
> >3. O(1) Context Retrieval: Replaces the expensive wr_id based lookup
> >logic (e.g., smc_wr_tx_find_pending_index) with direct context retrieval
> >using container_of() on the embedded ib_cqe.
> >
> >4. Code Simplification: This refactoring results in a reduction of
> >~150 lines of code. It removes redundant sequence tracking, complex lookup
> >helpers, and manual CQ management, significantly improving maintainability.
> 
> Excellent !
> 
> Some comments below.
> 
> >
> >Performance Test: redis-benchmark with max 32 connections per QP
> >Data format: Requests Per Second (RPS), Percentage in brackets
> >represents the gain/loss compared to TCP.
> >
> >| Clients | TCP      | SMC (original)      | SMC (cq_pool)       |
> >|---------|----------|---------------------|---------------------|
> >| c = 1   | 24449    | 31172  (+27%)       | 34039  (+39%)       |
> >| c = 2   | 46420    | 53216  (+14%)       | 64391  (+38%)       |
> >| c = 16  | 159673   | 83668  (-48%)  <--  | 216947 (+36%)       |
> >| c = 32  | 164956   | 97631  (-41%)  <--  | 249376 (+51%)       |
> >| c = 64  | 166322   | 118192 (-29%)  <--  | 249488 (+50%)       |
> >| c = 128 | 167700   | 121497 (-27%)  <--  | 249480 (+48%)       |
> >| c = 256 | 175021   | 146109 (-16%)  <--  | 240384 (+37%)       |
> >| c = 512 | 168987   | 101479 (-40%)  <--  | 226634 (+34%)       |
> >
> >The results demonstrate that this optimization effectively resolves the
> >scalability bottleneck, with RPS increasing by over 110% at c=64
> >compared to the original implementation.
> >
> >Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> >---
> > net/smc/smc_core.c |   8 +-
> > net/smc/smc_core.h |  16 ++-
> > net/smc/smc_ib.c   | 114 ++++++-------------
> > net/smc/smc_ib.h   |   5 -
> > net/smc/smc_tx.c   |   1 -
> > net/smc/smc_wr.c   | 267 ++++++++++++++++-----------------------------
> > net/smc/smc_wr.h   |  38 ++-----
> > 7 files changed, 150 insertions(+), 299 deletions(-)
> >
> >diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> >index 8aca5dc54be7..9590c8aed3dd 100644
> >--- a/net/smc/smc_core.c
> >+++ b/net/smc/smc_core.c
> >@@ -815,17 +815,11 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
> > 	lnk->lgr = lgr;
> > 	smc_lgr_hold(lgr); /* lgr_put in smcr_link_clear() */
> > 	lnk->link_idx = link_idx;
> >-	lnk->wr_rx_id_compl = 0;
> > 	smc_ibdev_cnt_inc(lnk);
> > 	smcr_copy_dev_info_to_link(lnk);
> > 	atomic_set(&lnk->conn_cnt, 0);
> 
> I think this isn't unlikey, we haven't signal the RDMA WRITE wr, so it
> shouldn't have CQEs when wc->status == 0.
> If we are here, wc->status should always != 0.
> 

Nice catch, I mixed this up with the rwwi version.

> 
> >+}
> >+
> >+static void smc_wr_reg_process_cqe(struct ib_cq *cq, struct ib_wc *wc)
> >-		       sizeof(*link->wr_tx_v2_pend));
> Why remove this memset ?
> 
> >-		memset(link->lgr->wr_tx_buf_v2, 0,
> >-		       sizeof(*link->lgr->wr_tx_buf_v2));
> >+		memset(link->lgr->wr_tx_buf_v2, 0, sizeof(*link->lgr->wr_tx_buf_v2));
> > 	} else {
> >-		link->wr_tx_pends[pnd_snd_idx].wc_status = wc->status;
> >-		if (link->wr_tx_pends[pnd_snd_idx].compl_requested)
> >+		if (tx_pend->compl_requested)
> > 			complete(&link->wr_tx_compl[pnd_snd_idx]);
> >-		memcpy(&pnd_snd, &link->wr_tx_pends[pnd_snd_idx],
> >-		       sizeof(pnd_snd));
> >-		/* clear the full struct smc_wr_tx_pend including .priv */
> >-		memset(&link->wr_tx_pends[pnd_snd_idx], 0,
> >-		       sizeof(link->wr_tx_pends[pnd_snd_idx]));
> 
> ditto
> 

Looks like I accidentally deleted this code, I will restore it in the
next version.

> >-		memset(&link->wr_tx_bufs[pnd_snd_idx], 0,
> >-		       sizeof(link->wr_tx_bufs[pnd_snd_idx]));
> >+		memset(&link->wr_tx_bufs[tx_pend->idx], 0, sizeof(link->wr_tx_bufs[tx_pend->idx]));
> > 		if (!test_and_clear_bit(pnd_snd_idx, link->wr_tx_mask))
> > 			return;
> > 	}
> > 
> >-	if (wc->status) {
> >+	if (unlikely(wc->status)) {
> > 		if (link->lgr->smc_version == SMC_V2) {
> > 			memset(link->wr_tx_v2_pend, 0,
> > 			       sizeof(*link->wr_tx_v2_pend));
> >@@ -128,44 +117,12 @@ static inline void smc_wr_tx_process_cqe(struct ib_wc *wc)
> > 		/* terminate link */
> > 		smcr_link_down_cond_sched(link);
> > 	}
> >+		smc_wr_rx_init_cqe(&link->wr_rx_ibs[i].cqe);
> >+		link->wr_rx_ibs[i].wr.wr_cqe = &link->wr_rx_ibs[i].cqe;
> >+		link->wr_rx_ibs[i].index = i;
> >+	}
> 
> Can we group all those xxx_init_cqe into a function and move them out of
> smc_wr_alloc_link_mem() ? All what smc_wr_alloc_link_mem() is all about
> allocating memory.
> 
> Maybe we can define a smc_wr_init_cqes() and call it in
> smc_wr_create_link() ?
> 
> 

Sounds reasonable, I'll implement this in the next version.
Additionally, other items like removing redundant fields and renaming
the index will also be addressed in the same update.

Thanks,
D. Wythe

> Best regards,
> Dust

