Return-Path: <linux-rdma+bounces-19655-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jrENL87J8GkKYwEAu9opvQ
	(envelope-from <linux-rdma+bounces-19655-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 16:53:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 409F64875C0
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 16:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48D9030A858E
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 14:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F8443E4A3;
	Tue, 28 Apr 2026 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CValI+4L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3639343DA4F;
	Tue, 28 Apr 2026 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777387642; cv=none; b=L2YMubDEWx+AYTQy6rKiGIdLnMScE+TZHeJgT83xjG4fcuILA5jPWkuvZJ+JVmleZvbX5aS2TNNr4XqSOgB5e0yRcSZKWLOAodE2iR9Xdpa0K09g1Fag+5IJkLyBZ06soE3nVbOJxBFAhNR1vIiSqECdxMnMomSP3Avj2veOVYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777387642; c=relaxed/simple;
	bh=1fYfsj4yZWZDDBERVik02Ea+1v3rF+nqDOOTddpHTY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWTW6nKvWa8MAnsMCRfq8vhvUqM2hFpZN3e84kDx3RSsFMrhC/6oWN+Afky8rfgzb/QBdj8RLhsk2j3uXKUHqtj9vJQTGrE92MGpSPCrdPVP1zF5sfHK9KiMyi4hdHyXKOFcz8t3PmWt5MOcHSpaxTTnHfIS6CwlNRPBf3Al9ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CValI+4L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDD4C2BCB7;
	Tue, 28 Apr 2026 14:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777387642;
	bh=1fYfsj4yZWZDDBERVik02Ea+1v3rF+nqDOOTddpHTY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CValI+4LuVwcLzwIIJWeWWj2KnaCv8LSGUFBnpeAO5fiE/s6oTnTLzZG8XwwxQgB4
	 PhppZCZnPf54VgwAd2xhoGAlblRyaLjDrMlmUrP/NJSpfJ/JA4DLdsciJy4Lb+dW+C
	 oCTYFsaSzxVz4c71UldGeF/8FRdOq9eW8HJdjEQGMAeAo4v+ALNva6W+pgsoAR5bDc
	 zvpuX/w58GLIzIulpz9BCrYYXmyyLd4rMxVzdmi2XE1fvcT6YKRW5nElllOlcTa+sj
	 1puv1mtSgqfffmN2yFluKOBn+VQzC53fdP8trwcC+jzxLGVKp1ZQQ+x00RNTb80hfE
	 jq7mDHFsUs5/g==
Date: Tue, 28 Apr 2026 17:47:15 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>, Nimrod Oren <noren@nvidia.com>
Subject: Re: [PATCH net-next 3/3] net/mlx5: use internal dma pools for frag
 buf alloc
Message-ID: <20260428144715.GR440345@unreal>
References: <20260428052920.219201-1-tariqt@nvidia.com>
 <20260428052920.219201-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428052920.219201-4-tariqt@nvidia.com>
X-Rspamd-Queue-Id: 409F64875C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19655-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]

On Tue, Apr 28, 2026 at 08:29:20AM +0300, Tariq Toukan wrote:
> From: Nimrod Oren <noren@nvidia.com>
> 
> Add mlx5_dma_pool alloc/free paths, and wire mlx5_frag_buf allocation
> and free paths to use them.
> 
> mlx5_frag_buf_alloc_node() now selects an mlx5_dma_pool to allocate
> fragments from, instead of directly allocating full coherent pages.
> 
> mlx5_frag_buf_free() frees from the respective pool.
> 
> mlx5_dma_pool_alloc() keeps allocation fast by maintaining pages with
> available indexes at the head of the list, so the common allocation path
> can take a free index immediately. New backing pages are allocated only
> when no free index is available.
> 
> mlx5_dma_pool_free() returns released indexes to the pool and frees a
> backing page once all of its indexes become free. This avoids keeping
> fully free pages for the lifetime of the pool and reduces coherent DMA
> memory footprint.
> 
> Signed-off-by: Nimrod Oren <noren@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/alloc.c   | 185 ++++++++++++++----
>  include/linux/mlx5/driver.h                   |   2 +
>  2 files changed, 154 insertions(+), 33 deletions(-)

<...>

> +	if (WARN_ONCE(idx >= blocks_per_page,
> +		      "mlx5 dma pool invalid idx: %lu (max %d)\n",
> +		      idx, blocks_per_page - 1))
> +		return;

<...>

> +	if (WARN_ONCE(test_bit(idx, page->bitmap),
> +		      "mlx5 dma pool double free: idx=%lu block_shift=%u\n",
> +		      idx, pool->block_shift))
> +		goto unlock;

<...>

> +	if (WARN_ONCE(size <= 0, "mlx5_frag_buf non-positive size: %d\n", size))
> +		return -EINVAL;

<...>

> +	if (WARN_ONCE(node < 0 || node >= nr_node_ids || !node_possible(node),
> +		      "mlx5_frag_buf invalid node ID: %d\n", node))
> +		return -EINVAL;

All WARN_ONCE() instances in this patch and the previous one are not
reachable. WARN_ONCE() should be used to detect states that are truly
impossible, not cases where the internal API is being misused.

There is no need for defensive programming when dealing with
in-kernel or in-driver APIs.

Thanks

