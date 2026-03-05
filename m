Return-Path: <linux-rdma+bounces-17512-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEdVAUxFqWl53gAAu9opvQ
	(envelope-from <linux-rdma+bounces-17512-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 09:56:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9971E20DD13
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 09:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4FB7303A24C
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 08:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9AF37646C;
	Thu,  5 Mar 2026 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zloj5pfv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE47375ADD;
	Thu,  5 Mar 2026 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772700911; cv=none; b=Zmg8yZbiPyN6XHRowAXF3Dp1QBGZ0/py82ciV6lyUZSJk8AFrNJUZjrLeB8fb7kJTpNojTLqdBWQGwr5+L2KI50JdIsUuQQLlQyyfsfvkFxHtJpUlQc5lTSvty6T4ea9vv9jvZFMnQqSSX4BSTXLR7SicQV8ryc/rNiCgKhum8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772700911; c=relaxed/simple;
	bh=DVrsJVOrkw0OnczSWmZinkDGWZhxgL+dU3McgBCjGeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3jxZKNBcpe0p5/gknkgk6NUa1n/k7CX4nJFEXhBP4juRlQD9ncef+x0PRpDE+znXi04mIlrZoDK954f0lKreGmUTAko0570FZfjNqbDUETWX5X8XxVnMpDjKKZvNpLCc/wNaz0uzQbQlfPZyLvFE6JWIbJihE3yJazbdNuq7r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zloj5pfv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC22C116C6;
	Thu,  5 Mar 2026 08:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772700911;
	bh=DVrsJVOrkw0OnczSWmZinkDGWZhxgL+dU3McgBCjGeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zloj5pfv3Or46e3MGD3TQPAhhiF3AkIlrclkfMyuNsld0FREbMp9adZhcH1v7iPyv
	 pqHqwcfZ7QYyHaPxGiV47UCkLIjLIl/hpgQFoZVxSa8FHN7ee3B5Wz4VVP1uqq5NdZ
	 10Gr9///sH1qjmNwyOGy4DXwuxXqmo1TAsyqivJ4Ipps7TQMI2dc68sRqORXq7vIGc
	 EFb6s4nekNmK/pEDjFm//5pqTA8+6ziaDnHYAsrXaurdZfi7KLz7wMwJL9Glev29GB
	 t23HCaZeBGGAnzssYKKzFeEBx2+7a693UCIpbXxroCiAeyQPQ1qSh8vYunugW+sI6E
	 9LsWPc7EDqE1A==
Date: Thu, 5 Mar 2026 10:55:05 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Dust Li <dust.li@linux.alibaba.com>,
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
Subject: Re: [PATCH net-next v3] net/smc: transition to RDMA core CQ pooling
Message-ID: <20260305085505.GL12611@unreal>
References: <20260305022323.96125-1-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305022323.96125-1-alibuda@linux.alibaba.com>
X-Rspamd-Queue-Id: 9971E20DD13
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17512-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,alibaba.com:email,nvidia.com:email]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 10:23:23AM +0800, D. Wythe wrote:
> The current SMC-R implementation relies on global per-device CQs
> and manual polling within tasklets, which introduces severe
> scalability bottlenecks due to global lock contention and tasklet
> scheduling overhead, resulting in poor performance as concurrency
> increases.
> 
> Refactor the completion handling to utilize the ib_cqe API and
> standard RDMA core CQ pooling. This transition provides several key
> advantages:
> 
> 1. Multi-CQ: Shift from a single shared per-device CQ to multiple
> link-specific CQs via the CQ pool. This allows completion processing
> to be parallelized across multiple CPU cores, effectively eliminating
> the global CQ bottleneck.
> 
> 2. Leverage DIM: Utilizing the standard CQ pool with IB_POLL_SOFTIRQ
> enables Dynamic Interrupt Moderation from the RDMA core, optimizing
> interrupt frequency and reducing CPU load under high pressure.
> 
> 3. O(1) Context Retrieval: Replaces the expensive wr_id based lookup
> logic (e.g., smc_wr_tx_find_pending_index) with direct context retrieval
> using container_of() on the embedded ib_cqe.
> 
> 4. Code Simplification: This refactoring results in a reduction of
> ~150 lines of code. It removes redundant sequence tracking, complex lookup
> helpers, and manual CQ management, significantly improving maintainability.
> 
> Performance Test: redis-benchmark with max 32 connections per QP
> Data format: Requests Per Second (RPS), Percentage in brackets
> represents the gain/loss compared to TCP.
> 
> | Clients | TCP      | SMC (original)      | SMC (cq_pool)       |
> |---------|----------|---------------------|---------------------|
> | c = 1   | 24449    | 31172  (+27%)       | 34039  (+39%)       |
> | c = 2   | 46420    | 53216  (+14%)       | 64391  (+38%)       |
> | c = 16  | 159673   | 83668  (-48%)  <--  | 216947 (+36%)       |
> | c = 32  | 164956   | 97631  (-41%)  <--  | 249376 (+51%)       |
> | c = 64  | 166322   | 118192 (-29%)  <--  | 249488 (+50%)       |
> | c = 128 | 167700   | 121497 (-27%)  <--  | 249480 (+48%)       |
> | c = 256 | 175021   | 146109 (-16%)  <--  | 240384 (+37%)       |
> | c = 512 | 168987   | 101479 (-40%)  <--  | 226634 (+34%)       |
> 
> The results demonstrate that this optimization effectively resolves the
> scalability bottleneck, with RPS increasing by over 110% at c=64
> compared to the original implementation.
> 
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
> v3:
> - Rebase to latest net-next tree.
> - Remove a redundant blank line in smc_wr_alloc_link_mem().
> 
> v2:
> - Fix a logic bug in smc_wr_tx_process_cqe() where a zeroed field
>   was checked instead of the saved pnd_snd copy. (Jakub)
> - Fix typo in comment: s/ib_draib_rq/ib_drain_rq/.
> - Minor comment alignment fix in struct smc_link.
> ---
>  net/smc/smc_core.c |   9 +-
>  net/smc/smc_core.h |  28 ++--
>  net/smc/smc_ib.c   | 113 +++++-----------
>  net/smc/smc_ib.h   |   7 -
>  net/smc/smc_tx.c   |   1 -
>  net/smc/smc_wr.c   | 312 +++++++++++++++++++--------------------------
>  net/smc/smc_wr.h   |  40 ++----
>  7 files changed, 193 insertions(+), 317 deletions(-)

Thanks a lot for this important conversion, for RDMA API usage:

Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

