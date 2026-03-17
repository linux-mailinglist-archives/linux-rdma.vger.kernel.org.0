Return-Path: <linux-rdma+bounces-18233-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOlYJVbAuGnSiwEAu9opvQ
	(envelope-from <linux-rdma+bounces-18233-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 03:45:42 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 552B92A2E68
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 03:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 714033029C10
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 02:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FB3262FC0;
	Tue, 17 Mar 2026 02:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaZG9cFa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50EA54723;
	Tue, 17 Mar 2026 02:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773715536; cv=none; b=PGO92xmWFDCfeM3qSaychfzb7Xl4jSFfkEWzcx5L7xSia+9E785OXuFY/ZSZG9GLB3d439H+KlGWMebbO/z3OkpljLNFxy73YpNSe+pjGt2UYyXPgFzI/Xqky96zo900DJTctIDgGr/zUdPGW0lyP01IJ749wBUEpmCwCNB0feQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773715536; c=relaxed/simple;
	bh=o4KKEzECa0c9M2MuhD0pbm/LOj6Ot3Hiam15eo1ahHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TdIv+Kp3uvtNf3r0LwPURxKUvkFdvAHjobvhDZjTdfXbew9nr+1KlHRqhuP+MFC5mZTqMbJ0CTvBld5/hzg8btIi+EMHT/I4vR/BCD/flZNkOAvz6QkDZhOhzWhJy8qqxa7E/r2kGXVuhiJ+xiy7AebrvjFuNNsY9+6JoJj8r/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaZG9cFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A37CC19421;
	Tue, 17 Mar 2026 02:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773715536;
	bh=o4KKEzECa0c9M2MuhD0pbm/LOj6Ot3Hiam15eo1ahHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BaZG9cFalAXv2WDdl0pf+EDyBk7oQxbUGElaV9B3674mLjUkDZx7p9rgOH0s7rKuX
	 0gxlFsG75qG1MoA7VngD/uWJaCUM8+xWAZ+nCrXckr+pQOZZb8hZAvWVpJ7hCrtrPJ
	 8WCaMU7aKYOyWKHBhdcL28wVjTFLXaOXKUstfLJolJDERe27H/PJ5wQ/115Q/bJyUD
	 Mqyybm1vOOYe1O6fWFO5459cv7j5l0CehgG7lZzlGu7I4w3b0oHuSwn+CMnwreptov
	 IOC5AeXEckXk7hDcvSNSRTO73LC1n85NorhfKT6oUwqei+onGHsSfsLg0zs12PomMk
	 TN16J/NB+HSwA==
From: Jakub Kicinski <kuba@kernel.org>
To: alibuda@linux.alibaba.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	edumazet@google.com,
	tonylu@linux.alibaba.com,
	wenjia@linux.ibm.com,
	pabeni@redhat.com,
	guwen@linux.alibaba.com,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	mjambigi@linux.ibm.com,
	dust.li@linux.alibaba.com,
	oliver.yang@linux.alibaba.com,
	sidraya@linux.ibm.com,
	linux-s390@vger.kernel.org,
	horms@kernel.org,
	pasic@linux.ibm.com,
	linux-rdma@vger.kernel.org
Subject: Re: [net-next] net/smc: cap allocation order for SMC-R physically contiguous buffers
Date: Mon, 16 Mar 2026 19:45:34 -0700
Message-ID: <20260317024534.588136-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312082154.36971-1-alibuda@linux.alibaba.com>
References: <20260312082154.36971-1-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18233-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 552B92A2E68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net/smc: cap allocation order for SMC-R physically contiguous buffers

The alloc_page() cannot satisfy requests exceeding MAX_PAGE_ORDER, and
attempting such allocations will lead to guaranteed failures and potential
kernel warnings. For SMCR_PHYS_CONT_BUFS, cap the allocation order to
MAX_PAGE_ORDER. This ensures the attempts to allocate the largest possible
physically contiguous chunk succeed. For SMCR_MIXED_BUFS, if its order
exceeds MAX_PAGE_ORDER, skip the physical allocation attempt and fallback to
virtual memory immediately.

> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index e2d083daeb7e..a18730edb7e0 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -2314,6 +2314,10 @@ int smcr_buf_reg_lgr(struct smc_link *lnk)
>  	return rc;
>  }
>
> +/*
> + * smcr_new_buf_create may allocate a buffer smaller than the requested
> + * bufsize. Use buf_desc->len to determine the actual allocated size.
> + */
>  static struct smc_buf_desc *smcr_new_buf_create(struct smc_link_group *lgr,
>  						int bufsize)
>  {
> @@ -2326,18 +2330,22 @@ static struct smc_buf_desc *smcr_new_buf_create(struct smc_link_group *lgr,
>
>  	switch (lgr->buf_type) {
>  	case SMCR_PHYS_CONT_BUFS:
> +		bufsize = min(bufsize, (int)PAGE_SIZE << MAX_PAGE_ORDER);
> +		fallthrough;
>  	case SMCR_MIXED_BUFS:
>  		buf_desc->order = get_order(bufsize);
> -		buf_desc->pages = alloc_pages(GFP_KERNEL | __GFP_NOWARN |
> -					      __GFP_NOMEMALLOC | __GFP_COMP |
> -					      __GFP_NORETRY | __GFP_ZERO,
> -					      buf_desc->order);
> -		if (buf_desc->pages) {
> -			buf_desc->cpu_addr =
> -				(void *)page_address(buf_desc->pages);
> -			buf_desc->len = bufsize;
> -			buf_desc->is_vm = false;
> -			break;
> +		if (buf_desc->order <= MAX_PAGE_ORDER) {
> +			buf_desc->pages = alloc_pages(GFP_KERNEL | __GFP_NOWARN |
> +						      __GFP_NOMEMALLOC | __GFP_COMP |
> +						      __GFP_NORETRY | __GFP_ZERO,
> +						      buf_desc->order);
> +			if (buf_desc->pages) {
> +				buf_desc->cpu_addr =
> +					(void *)page_address(buf_desc->pages);
> +				buf_desc->len = bufsize;
> +				buf_desc->is_vm = false;
> +				break;
> +			}
>  		}
>  		if (lgr->buf_type == SMCR_PHYS_CONT_BUFS)
>  			goto out;

[ ... ]

> @@ -2476,7 +2484,7 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
>  		}
>
>  		SMC_STAT_RMB_ALLOC(smc, is_smcd, is_rmb);
> -		SMC_STAT_RMB_SIZE(smc, is_smcd, is_rmb, true, bufsize);
> +		SMC_STAT_RMB_SIZE(smc, is_smcd, is_rmb, true, buf_desc->len);
>  		buf_desc->used = 1;
>  		down_write(lock);
>  		smc_lgr_buf_list_add(lgr, is_rmb, buf_list, buf_desc);
>  		up_write(lock);
>  		break; /* found */
>  	}
>
>  	if (IS_ERR(buf_desc))
>  		return PTR_ERR(buf_desc);
>
>  	if (!is_smcd) {
>  		if (smcr_buf_map_usable_links(lgr, buf_desc, is_rmb)) {
>  			smcr_buf_unuse(buf_desc, is_rmb, lgr);
>  			return -ENOMEM;
>  		}
>  	}
>
>  	if (is_rmb) {
>  		conn->rmb_desc = buf_desc;
>  		conn->rmbe_size_comp = bufsize_comp;
>  		smc->sk.sk_rcvbuf = bufsize * 2;
>  		atomic_set(&conn->bytes_to_rcv, 0);
>  		conn->rmbe_update_limit =
>  			smc_rmb_wnd_update_limit(buf_desc->len);
>  		if (is_smcd)
>  			smc_ism_set_conn(conn); /* map RMB/smcd_dev to conn */
>  	} else {
>  		conn->sndbuf_desc = buf_desc;
>  		smc->sk.sk_sndbuf = bufsize * 2;
>  		atomic_set(&conn->sndbuf_space, bufsize);
                                                 ^^^^^^^

The comment added at smcr_new_buf_create() says "Use buf_desc->len to
determine the actual allocated size," but __smc_buf_create() still uses the
uncapped bufsize for several critical fields. Is this correct?

For SMCR_PHYS_CONT_BUFS, smcr_new_buf_create() now caps bufsize internally
to PAGE_SIZE << MAX_PAGE_ORDER (typically 4MB), so buf_desc->len can be
smaller than the requested bufsize.

However, __smc_buf_create() continues using the original uncapped bufsize
for:

    if (is_rmb) {
        conn->rmbe_size_comp = bufsize_comp;
        smc->sk.sk_rcvbuf = bufsize * 2;
    } else {
        smc->sk.sk_sndbuf = bufsize * 2;
        atomic_set(&conn->sndbuf_space, bufsize);
    }

The sndbuf_space mismatch is particularly concerning. Looking at
smc_tx.c:274, the comment states: "0 <= sndbuf_space <= sndbuf_desc->len".
When sndbuf_space exceeds sndbuf_desc->len, smc_tx_sendmsg() could calculate
writespace incorrectly:

    int writespace = atomic_read(&conn->sndbuf_space);

and the two-chunk copy loop might write beyond the actual buffer boundary.
This is reachable with default sysctl settings (SMCR_PHYS_CONT_BUFS) and
socket buffer sizes exceeding 4MB.

Should these assignments use buf_desc->len instead of bufsize? For example:

    atomic_set(&conn->sndbuf_space, buf_desc->len);
    smc->sk.sk_sndbuf = buf_desc->len * 2;
    smc->sk.sk_rcvbuf = buf_desc->len * 2;

And should rmbe_size_comp be recalculated from buf_desc->len? The
rmbe_size_comp value is sent to the peer via CLC messages in smc_clc.c:1125,
and an inflated value might cause the peer to believe the RMB is larger than
it actually is.

>  	}
>  	return 0;
>  }
-- 
pw-bot: cr

