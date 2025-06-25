Return-Path: <linux-rdma+bounces-11603-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00424AE73A0
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 02:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A3516873D
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 00:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE2F1FDA;
	Wed, 25 Jun 2025 00:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6bwZMuk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C576EBA4A;
	Wed, 25 Jun 2025 00:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750810091; cv=none; b=k4Igqtf9tnOFVdsLMTLA/EPetB5KT0TQc2I3TPx2J8k/gG/b4vk7IVmYmig06bgc5vy53B03N3eeE7q9COYh91eMDYBc1xpB5EsVmUOY+J0ZwZqDhJ5eWMongBrcJZWBJ3OCwDtifWDI6095i71mAo2z8bajpwPBVvrn/m7IHvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750810091; c=relaxed/simple;
	bh=VB6RjF5qIFd0dFoB+XW85/SNYXcGJtaEsdKLLYK1WQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tzv/okSWbfOIQBvL7LZXMDLAtxXeJjaluT3jrOBl7GxXrO0SnWGpKmbkvwUwYuIyzWocBMpT6qkLTeqVUAu0EH2dnovnkPPMX7Qtz2IoKEW127MTCQXoACz7QZ0wVb+8MPdWhOmEzr4RD3h+EX0/xeP0xe9BNFU6jVTeXWoOnsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6bwZMuk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFE2C4CEE3;
	Wed, 25 Jun 2025 00:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750810091;
	bh=VB6RjF5qIFd0dFoB+XW85/SNYXcGJtaEsdKLLYK1WQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I6bwZMukbdoONRb4Jlg6TvrF7KMpVs2OX+Gr+2XEB4kIB2ccz9xHcyWZT27elPMoO
	 FlC7Wa7+8NIGGcqeAaOQ/Wqw00mj+EoNEySkDr9yZdhPIj3WL05GtQ8wiwrVuZnuyH
	 06ewAsJjodRjvu440DMRFZrLJJAcexNlutxv2JWc0PW/qvDJcflXSKnHQmgmuXVOqe
	 4O6xdiqBOfozEUTd+3IfwXLsZ1HwhgNYNSbNQyYc1pGIrFGMKkvePgq83bedJ3AWwO
	 2HBRHYL9sHdik25lAvf6418pfzT4isaTbLhjrBvocTIpsGBiHMyhmNRWpabM3Ls7ww
	 hN58Xk2Ue0g1Q==
Date: Tue, 24 Jun 2025 17:08:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
 <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <moshe@nvidia.com>, Yevgeny Kliteynik
 <kliteyn@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>
Subject: Re: [PATCH net-next v2 7/8] net/mlx5: HWS, Shrink empty matchers
Message-ID: <20250624170809.2aac2c69@kernel.org>
In-Reply-To: <20250622172226.4174-8-mbloch@nvidia.com>
References: <20250622172226.4174-1-mbloch@nvidia.com>
	<20250622172226.4174-8-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Jun 2025 20:22:25 +0300 Mark Bloch wrote:
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
> index 0a7903cf75e8..b7098c7d2112 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
> @@ -3,6 +3,8 @@
>  
>  #include "internal.h"
>  
> +static int hws_bwc_matcher_move(struct mlx5hws_bwc_matcher *bwc_matcher);

Is there a circular dependency? Normally we recommend that people
reorder code rather that add forward declarations.

>  static u16 hws_bwc_gen_queue_idx(struct mlx5hws_context *ctx)
>  {
>  	/* assign random queue */
> @@ -409,6 +411,70 @@ static void hws_bwc_rule_cnt_dec(struct mlx5hws_bwc_rule *bwc_rule)
>  		atomic_dec(&bwc_matcher->tx_size.num_of_rules);
>  }
>  
> +static int
> +hws_bwc_matcher_rehash_shrink(struct mlx5hws_bwc_matcher *bwc_matcher)
> +{
> +	struct mlx5hws_bwc_matcher_size *rx_size = &bwc_matcher->rx_size;
> +	struct mlx5hws_bwc_matcher_size *tx_size = &bwc_matcher->tx_size;
> +
> +	/* It is possible that another thread has added a rule.
> +	 * Need to check again if we really need rehash/shrink.
> +	 */
> +	if (atomic_read(&rx_size->num_of_rules) ||
> +	    atomic_read(&tx_size->num_of_rules))
> +		return 0;
> +
> +	/* If the current matcher RX/TX size is already at its initial size. */
> +	if (rx_size->size_log == MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG &&
> +	    tx_size->size_log == MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG)
> +		return 0;
> +
> +	/* Now we've done all the checking - do the shrinking:
> +	 *  - reset match RTC size to the initial size
> +	 *  - create new matcher
> +	 *  - move the rules, which will not do anything as the matcher is empty
> +	 *  - destroy the old matcher
> +	 */
> +
> +	rx_size->size_log = MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG;
> +	tx_size->size_log = MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG;
> +
> +	return hws_bwc_matcher_move(bwc_matcher);
> +}
> +
> +static int hws_bwc_rule_cnt_dec_with_shrink(struct mlx5hws_bwc_rule *bwc_rule,
> +					    u16 bwc_queue_idx)
> +{
> +	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
> +	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
> +	struct mutex *queue_lock; /* Protect the queue */
> +	int ret;
> +
> +	hws_bwc_rule_cnt_dec(bwc_rule);
> +
> +	if (atomic_read(&bwc_matcher->rx_size.num_of_rules) ||
> +	    atomic_read(&bwc_matcher->tx_size.num_of_rules))
> +		return 0;
> +
> +	/* Matcher has no more rules - shrink it to save ICM. */
> +
> +	queue_lock = hws_bwc_get_queue_lock(ctx, bwc_queue_idx);
> +	mutex_unlock(queue_lock);
> +
> +	hws_bwc_lock_all_queues(ctx);
> +	ret = hws_bwc_matcher_rehash_shrink(bwc_matcher);
> +	hws_bwc_unlock_all_queues(ctx);
> +
> +	mutex_lock(queue_lock);

Dropping and re-taking caller-held locks is a bad code smell.
Please refactor - presumably you want some portion of the condition
to be under the lock with the dec? return true / false based on that.
let the caller drop the lock and do the shrink if true was returned
(directly or with another helper)

> +	if (unlikely(ret))
> +		mlx5hws_err(ctx,
> +			    "BWC rule deletion: shrinking empty matcher failed (%d)\n",
> +			    ret);
> +
> +	return ret;
> +}
> +
>  int mlx5hws_bwc_rule_destroy_simple(struct mlx5hws_bwc_rule *bwc_rule)
>  {
>  	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
> @@ -425,8 +491,8 @@ int mlx5hws_bwc_rule_destroy_simple(struct mlx5hws_bwc_rule *bwc_rule)
>  	mutex_lock(queue_lock);
>  
>  	ret = hws_bwc_rule_destroy_hws_sync(bwc_rule, &attr);
> -	hws_bwc_rule_cnt_dec(bwc_rule);
>  	hws_bwc_rule_list_remove(bwc_rule);
> +	hws_bwc_rule_cnt_dec_with_shrink(bwc_rule, idx);
>  
>  	mutex_unlock(queue_lock);

