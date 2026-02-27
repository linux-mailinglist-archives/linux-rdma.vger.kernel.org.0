Return-Path: <linux-rdma+bounces-17280-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eL2kDC0VoWnoqAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17280-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 04:53:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF39A1B26B7
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 04:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BF8030E497A
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 03:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9FC33A71F;
	Fri, 27 Feb 2026 03:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsVdHpn0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA6233A70B;
	Fri, 27 Feb 2026 03:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772164382; cv=none; b=sSfdHlCOt+VsRz5ZvAux/bKZ8+z/zK8yt0bplRg9rbBipfrUkJtdgCTtef4u+TRy8GgzYZr5fGJ4xYladK77Tkaa1h7u3mGjYFTwmmBe9chHL0mdaG4/IJt+FNTxs2w8kgihhmOVCkbAoB8X2Xvmzh7WRmGx0atB52q+0vtPvYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772164382; c=relaxed/simple;
	bh=85iHLWRx8ynP5HbfuLYmK1cCtUJceJFWMGhV7uqh/Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6co+/SPyaJgD175NbmWH86O/4GGY0WTAIoY56lzDKOrKFipGS+ObUaH8VdXbhOr2tZtbqWHzaq86g447o4hENBhYVW6iHPCO33skX5Y1TQSyihna2Fl5B4UbyCPvo5IsWVK31sbuhTwx+QnqQ4u4OBbtxCso5V9sLMuy4hPSuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsVdHpn0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945F2C116C6;
	Fri, 27 Feb 2026 03:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772164382;
	bh=85iHLWRx8ynP5HbfuLYmK1cCtUJceJFWMGhV7uqh/Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IsVdHpn0G4PaDJLgkUUJQnMAYpTW/NwSMkIo6MHCCmDgL/nioWn/3Si6cA6NbFqRp
	 4RJaDBU8jEPtatwM5OsVYMdcqsScIn8noSD6nWmQUaPlR2AZzBjJ/emTHD7YfEfgmv
	 zYIGWS8yh7oPTgoz2TqnGB72IoB7J1ynDBrwTSJIrU/qBEs9ns1ug8lkrVpTJj/UAI
	 Z8FGoRNITGI9DGw5/eYIOugB5PcEll4En8hXyuxNGTYipQWr5JGm4mMuTsvXrVjRpV
	 bhGk/WvWy6+ZEbNYZc7x2R/eeAPAC8uyL8KnKlPh89rUAaZnYjNpKuokbBwBaw1/Cn
	 HZ9pqU48uBo6g==
From: Jakub Kicinski <kuba@kernel.org>
To: alibuda@linux.alibaba.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	linux-rdma@vger.kernel.org,
	sidraya@linux.ibm.com,
	horms@kernel.org,
	davem@davemloft.net,
	linux-s390@vger.kernel.org,
	mjambigi@linux.ibm.com,
	oliver.yang@linux.alibaba.com,
	edumazet@google.com,
	wenjia@linux.ibm.com,
	guwen@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	pasic@linux.ibm.com
Subject: Re: [net-next] net/smc: transition to RDMA core CQ pooling
Date: Thu, 26 Feb 2026 19:53:00 -0800
Message-ID: <20260227035300.2628494-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225024513.7861-1-alibuda@linux.alibaba.com>
References: <20260225024513.7861-1-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17280-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: CF39A1B26B7
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net/smc: transition to RDMA core CQ pooling

This commit refactors SMC-R completion handling to use the ib_cqe API
and RDMA core CQ pooling, replacing the previous per-device global CQs
and manual tasklet polling. The refactoring aims to eliminate scalability
bottlenecks by enabling multi-CQ parallelization and O(1) context retrieval.

> diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
> index 5feafa98ab1a..4a4924c5cade 100644
> --- a/net/smc/smc_wr.c
> +++ b/net/smc/smc_wr.c

[ ... ]

> @@ -63,55 +60,52 @@ void smc_wr_tx_wait_no_pending_sends(struct smc_link *link)
>  	wait_event(link->wr_tx_wait, !smc_wr_is_tx_pend(link));
>  }
>
> -static inline int smc_wr_tx_find_pending_index(struct smc_link *link, u64 wr_id)
> +static void smc_wr_tx_rdma_process_cqe(struct ib_cq *cq, struct ib_wc *wc)
>  {
> -	u32 i;
> +	struct smc_link *link = wc->qp->qp_context;
>
> -	for (i = 0; i < link->wr_tx_cnt; i++) {
> -		if (link->wr_tx_pends[i].wr_id == wr_id)
> -			return i;
> -	}
> -	return link->wr_tx_cnt;
> +	/* terminate link */
> +	if (wc->status)
> +		smcr_link_down_cond_sched(link);
> +}
> +
> +static void smc_wr_reg_process_cqe(struct ib_cq *cq, struct ib_wc *wc)
> +{
> +	struct smc_link *link = wc->qp->qp_context;
> +
> +	if (wc->status)
> +		link->wr_reg_state = FAILED;
> +	else
> +		link->wr_reg_state = CONFIRMED;
> +	smc_wr_wakeup_reg_wait(link);
>  }
>
> -static inline void smc_wr_tx_process_cqe(struct ib_wc *wc)
> +static void smc_wr_tx_process_cqe(struct ib_cq *cq, struct ib_wc *wc)
>  {
> -	struct smc_wr_tx_pend pnd_snd;
> +	struct smc_wr_tx_pend *tx_pend, pnd_snd;
> +	struct smc_ib_send_wr *send_wr;
>  	struct smc_link *link;
>  	u32 pnd_snd_idx;
>
>  	link = wc->qp->qp_context;
>
> -	if (wc->opcode == IB_WC_REG_MR) {
> -		if (wc->status)
> -			link->wr_reg_state = FAILED;
> -		else
> -			link->wr_reg_state = CONFIRMED;
> -		smc_wr_wakeup_reg_wait(link);
> -		return;
> -	}
> +	send_wr = container_of(wc->wr_cqe, struct smc_ib_send_wr, cqe);
> +	pnd_snd_idx = send_wr->idx;
> +
> +	tx_pend = (pnd_snd_idx == link->wr_tx_cnt) ? link->wr_tx_v2_pend :
> +		&link->wr_tx_pends[pnd_snd_idx];
> +
> +	tx_pend->wc_status = wc->status;
> +	memcpy(&pnd_snd, tx_pend, sizeof(pnd_snd));
> +	/* clear the full struct smc_wr_tx_pend including .priv */
> +	memset(tx_pend, 0, sizeof(*tx_pend));
>
> -	pnd_snd_idx = smc_wr_tx_find_pending_index(link, wc->wr_id);
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
>  	} else {
> -		link->wr_tx_pends[pnd_snd_idx].wc_status = wc->status;
> -		if (link->wr_tx_pends[pnd_snd_idx].compl_requested)
> +		if (tx_pend->compl_requested)
                    ^^^^^^

Does this read the correct field? The code above memsets tx_pend to zero,
so compl_requested is always 0 and complete() is never called.

The refactoring created a local copy pnd_snd before the memset:

memcpy(&pnd_snd, tx_pend, sizeof(pnd_snd));
memset(tx_pend, 0, sizeof(*tx_pend));

But then it reads from the zeroed tx_pend instead of pnd_snd. Should this be
pnd_snd.compl_requested instead?

This affects smc_wr_tx_send_wait(), which sets compl_requested and waits for
the completion that never arrives, causing LLC message timeouts.

>  			complete(&link->wr_tx_compl[pnd_snd_idx]);
> -		memcpy(&pnd_snd, &link->wr_tx_pends[pnd_snd_idx],
> -		       sizeof(pnd_snd));
> -		/* clear the full struct smc_wr_tx_pend including .priv */
> -		memset(&link->wr_tx_pends[pnd_snd_idx], 0,
> -		       sizeof(link->wr_tx_pends[pnd_snd_idx]));
>  		memset(&link->wr_tx_bufs[pnd_snd_idx], 0,
>  		       sizeof(link->wr_tx_bufs[pnd_snd_idx]));
>  		if (!test_and_clear_bit(pnd_snd_idx, link->wr_tx_mask))

[ ... ]

> @@ -550,7 +472,7 @@ void smc_wr_remember_qp_attr(struct smc_link *lnk)
>  	lnk->wr_tx_cnt = min_t(size_t, lnk->max_send_wr,
>  			       lnk->qp_attr.cap.max_send_wr);
>  	lnk->wr_rx_cnt = min_t(size_t, lnk->max_recv_wr,
> -			       lnk->qp_attr.cap.max_recv_wr);
> +			       lnk->qp_attr.cap.max_recv_wr - 1);	/* -1 for ib_draib_rq() */
                                                                                        ^^^^^^^^^^^^^^
This isn't a bug, but there's a typo in the comment: ib_draib_rq() should be
ib_drain_rq().

>  }

[ ... ]
-- 
pw-bot: cr

