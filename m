Return-Path: <linux-rdma+bounces-18554-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCXJNqD6wWlSYgQAu9opvQ
	(envelope-from <linux-rdma+bounces-18554-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 03:44:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 401423014AE
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 03:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB4DC3084AC4
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 02:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7FF3876B7;
	Tue, 24 Mar 2026 02:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWhAE/RL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7047E3446BE;
	Tue, 24 Mar 2026 02:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774320160; cv=none; b=rUk1hGrM2S5FqR3lG1H++RfyhwmDFwb3q2QZ9BVdO3Qw0S7z8J+G+xpHK4IwDZqsqJzF1hEGvarPsV8KjAkwBkLQTLDWJn0Jv6BYc8y0bmC6yxLzmM6fw6A6h3+G//2NHdXCpV1GOjGMjTyDJ3vdFlTI3Y8+Eq5cUwDDFpA8JJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774320160; c=relaxed/simple;
	bh=So9pRA/L0ISKsf9G/lUS0u/m64zRXRnY281HgviX69c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kY3t0lvDtAsK+aAfMzOrpYHir/24nUDjrrK79vpBeuhO67YSHIHfBiyAqkcL3Z1FK3Wf/v8lFMN8ZY8nonte7RXkvMAnrVN34+wjEgiahDQYYuvBSxjeSFhGYOtCQR4j52iGTIwmE7gfGgDRXDLD5edxPMOIipx+yT7IoWAhxfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWhAE/RL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406F8C4CEF7;
	Tue, 24 Mar 2026 02:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774320160;
	bh=So9pRA/L0ISKsf9G/lUS0u/m64zRXRnY281HgviX69c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XWhAE/RLZsKgSGcr+7pSKXtf/ABFAZkxlgvMt2V7XOBnNw0hWzLhVBruLaxeumU6b
	 gAMAoGUou8I0RRoD2HdZObE6Or0iCItiuBf+tygZtHCWeEpPfdqw4aNQR/uKnLJ6iw
	 U3DU3M4wnNcja3WKILmmQ0dzQmy5JQ1/bX9G8n0J3IghrKZVKILJuQh6ip2u05srkj
	 DPOnRJgyzuj92T0Lw6nbMb67XtPOHW6KtOuG2XN3Nz9uxhGj89B/u9ocH3WZ2Ghsyl
	 ASdy/RcM/S6mcKGpts6N2NIFt/RnYrOm2WgUfvQvfFooJTnxCbszGG51PjA7sGslX1
	 Nd4sM/hTFmsZg==
From: Jakub Kicinski <kuba@kernel.org>
To: tariqt@nvidia.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	moshe@nvidia.com,
	daniel@iogearbox.net,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	hawk@kernel.org,
	dtatulea@nvidia.com,
	ast@kernel.org,
	mbloch@nvidia.com,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	cjubran@nvidia.com,
	linux-rdma@vger.kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	gal@nvidia.com,
	saeedm@nvidia.com
Subject: Re: [PATCH net-next 5/5] net/mlx5e: XDP, Use page fragments for linear data in multibuf-mode
Date: Mon, 23 Mar 2026 19:42:34 -0700
Message-ID: <20260324024235.929875-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319075036.24734-6-tariqt@nvidia.com>
References: <20260319075036.24734-6-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,nvidia.com,iogearbox.net,google.com,lunn.ch,gmail.com,davemloft.net,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-18554-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 401423014AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net/mlx5e: XDP, Use page fragments for linear data in multibuf-mode

This commit optimizes XDP multi-buffer mode by splitting pages into fixed-
size fragments instead of allocating whole pages for the linear part of XDP
buffers. This reduces allocations significantly, especially on systems with
larger page sizes, improving performance by 15.80% on 4K pages and 31.62%
on 64K pages for XDP_DROP tests.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> index 592234780f2b..2270e2e550dd 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h

[ ... ]

> @@ -1081,6 +1085,8 @@ bool mlx5e_reset_rx_moderation(struct dim_cq_moder *cq_moder, u8 cq_period_mode,
>  bool mlx5e_reset_rx_channels_moderation(struct mlx5e_channels *chs, u8 cq_period_mode,
>  					bool dim_enabled, bool keep_dim_state);
>
> +void mlx5e_mpwqe_dealloc_linear_page(struct mlx5e_rq *rq);
> +
>  struct mlx5e_sq_param;
>  int mlx5e_open_xdpsq(struct mlx5e_channel *c, struct mlx5e_params *params,
>  		     struct mlx5e_sq_param *param, struct xsk_buff_pool *xsk_pool,

[ ... ]

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index 8b3c82f6f038..b376abc561fd 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c

[ ... ]

> @@ -385,10 +385,22 @@ static int mlx5e_rq_alloc_mpwqe_linear_info(struct mlx5e_rq *rq, int node,
>  	if (!li)
>  		return -ENOMEM;
>
> +	linear_frag_count =
> +		BIT(rq->mpwqe.page_shift - MLX5E_XDP_LOG_MAX_LINEAR_SZ);
> +	if (linear_frag_count > U16_MAX) {
> +		netdev_warn(rq->netdev,
> +			    "rq %d: linear_frag_count (%u) larger than expected (%u), page_shift: %u, log_max_linear_sz: %u\n",
> +			    rq->ix, linear_frag_count, U16_MAX,
> +			    rq->mpwqe.page_shift, MLX5E_XDP_LOG_MAX_LINEAR_SZ);
> +		kvfree(li);
> +		return -EINVAL;
> +	}
> +
> +	li->max_frags = linear_frag_count;
>  	rq->mpwqe.linear_info = li;
>
> -	/* additional page per packet for the linear part */
> -	*pool_size *= 2;
> +	/* Set to max to force allocation on first run. */
> +	li->frag_page.frags = li->max_frags;
>
>  	return 0;
>  }

[ ... ]

> @@ -1347,6 +1358,8 @@ void mlx5e_free_rx_descs(struct mlx5e_rq *rq)
>  			mlx5_wq_ll_pop(wq, wqe_ix_be,
>  				       &wqe->next.next_wqe_index);
>  		}
> +
> +		mlx5e_mpwqe_dealloc_linear_page(rq);
>  	} else {
>  		struct mlx5_wq_cyc *wq = &rq->wqe.wq;
>  		u16 missing = mlx5_wq_cyc_missing(wq);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> index feb042d84b8e..2ac38536afe9 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c

[ ... ]

> @@ -300,6 +300,35 @@ static void mlx5e_page_release_fragmented(struct page_pool *pp,
>  		page_pool_put_unrefed_netmem(pp, netmem, -1, true);
>  }
>
> +static int mlx5e_mpwqe_linear_page_refill(struct mlx5e_rq *rq)
> +{
> +	struct mlx5e_mpw_linear_info *li = rq->mpwqe.linear_info;
> +
> +	if (likely(li->frag_page.frags < li->max_frags))
> +		return 0;
> +
> +	if (likely(li->frag_page.netmem)) {
> +		mlx5e_page_release_fragmented(rq->page_pool, &li->frag_page);
> +		li->frag_page.netmem = 0;
> +	}
> +
> +	return mlx5e_page_alloc_fragmented(rq->page_pool, &li->frag_page);
> +}
> +
> +static void *mlx5e_mpwqe_get_linear_page_frag(struct mlx5e_rq *rq)
> +{
> +	struct mlx5e_mpw_linear_info *li = rq->mpwqe.linear_info;
> +	u32 frag_offset;
> +
> +	if (unlikely(mlx5e_mpwqe_linear_page_refill(rq)))
> +		return NULL;
> +
> +	frag_offset = li->frag_page.frags << MLX5E_XDP_LOG_MAX_LINEAR_SZ;
> +	WARN_ON(frag_offset >= BIT(rq->mpwqe.page_shift));
> +
> +	return netmem_address(li->frag_page.netmem) + frag_offset;
> +}
> +

[ ... ]

> @@ -702,6 +731,16 @@ static void mlx5e_dealloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
>  	bitmap_fill(wi->skip_release_bitmap, rq->mpwqe.pages_per_wqe);
>  }
>
> +void mlx5e_mpwqe_dealloc_linear_page(struct mlx5e_rq *rq)
> +{
> +	struct mlx5e_mpw_linear_info *li = rq->mpwqe.linear_info;
> +
> +	if (!li || !li->frag_page.netmem)
> +		return;
> +
> +	mlx5e_page_release_fragmented(rq->page_pool, &li->frag_page);
> +}

Does this function need to reset li->frag_page.netmem to 0 and
li->frag_page.frags to li->max_frags after releasing the page?

When an RQ is flushed and then reactivated (for example, in error recovery
via mlx5e_rx_reporter_err_rq_cqe_recover()), the following sequence occurs:

mlx5e_rx_reporter_err_rq_cqe_recover()
  mlx5e_flush_rq()
    mlx5e_free_rx_descs()
      mlx5e_mpwqe_dealloc_linear_page()
        mlx5e_page_release_fragmented()  [releases the page]
        [but doesn't reset netmem or frags]
  mlx5e_activate_rq()
    [RQ becomes active again]

When the next XDP multi-buffer packet arrives, mlx5e_mpwqe_get_linear_page_frag()
is called:

mlx5e_skb_from_cqe_mpwrq_nonlinear()
  mlx5e_mpwqe_get_linear_page_frag()
    mlx5e_mpwqe_linear_page_refill()
      if (likely(li->frag_page.frags < li->max_frags))
        return 0;  [skips allocation if frags < max_frags]
    netmem_address(li->frag_page.netmem) + frag_offset  [UAF]

If li->frag_page.frags was not reset to li->max_frags in
mlx5e_mpwqe_dealloc_linear_page(), the refill function will see frags <
max_frags and skip the allocation, then compute the address using the stale
netmem pointer that was already returned to the page pool.

Shouldn't this match the initialization in mlx5e_rq_alloc_mpwqe_linear_info()
which sets li->frag_page.frags = li->max_frags?
-- 
pw-bot: cr

