Return-Path: <linux-rdma+bounces-20317-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHLkOrXWAGovNQEAu9opvQ
	(envelope-from <linux-rdma+bounces-20317-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 21:04:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E1A505DFD
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 21:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7CB23005E8D
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 19:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BF631F9B4;
	Sun, 10 May 2026 19:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tjam84jR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE77D20B22;
	Sun, 10 May 2026 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778439854; cv=none; b=tEw/e9EgUhdTu5SGKAm7gweo/WfAWXB/N8kw4CvmFEUxqMhm65CHgxNWAq45FYsvGHHNkzhOQKKDxCHAOVLrn1UtHb1fX0qAWm0UPdCDUkwhH10sWumhqISs5onknJHzuwxDpMgB/cM0lWtHeEp9D4hOiYQH76p7gdwMC2Hu60Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778439854; c=relaxed/simple;
	bh=imk9coTRb2HVMl2F/BETlKrXnTt+A/4l5suRxPpIGzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARU3g6EXIljkCw97P4mFAwF+haS+L7pWxtZNca6Eq7NLBz1kSI9RnBvMz0kyJ1OHphipL8s3JP8ZmMVmiJz/DDTQ1hZjrgroahcvFMIZLlzlxLulxAOpPByHyd4V9ypoOxm90/bjD0QAJNDQuWmfyzAr6m8+e71p3v6OAVI1aKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tjam84jR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6657C2BCB8;
	Sun, 10 May 2026 19:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778439853;
	bh=imk9coTRb2HVMl2F/BETlKrXnTt+A/4l5suRxPpIGzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tjam84jR3CrwUodCn72/gz1X4HYiPIxGBJ+mStB89AQSG44MMbzb7VnJmbV4l5vaO
	 zxsorkzIFz7QKLvN2sV3NY+8F71JELF7gissRJZlXLgIQUgJgwvyaZ+DRzy3Y/7jXL
	 3z9OaA6UoBpxnIAsGtIBEQk2zngmnFMSTMck0aKQABWZhSm9aG0ndEWcKYceHQYokC
	 hZcKNQa+kC7pWYcxMQWcGho6qkWZrzbaa70Qg7yFIPa9Rw7mXGt46KEvzoxLslSiUy
	 Sycumzwy7YIeHR4O0LvKaIheJfFz6nKCQFbNSEVpmgWxP6mSWe/hMXH6fmAcDRil3A
	 fZhBqf/jIbS3A==
From: Simon Horman <horms@kernel.org>
To: tariqt@nvidia.com
Cc: 'Simon Horman' <horms@kernel.org>,
	cpaasch@openai.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	saeedm@nvidia.com,
	leon@kernel.org,
	mbloch@nvidia.com,
	kliteyn@nvidia.com,
	vdogaru@nvidia.com,
	kees@kernel.org,
	valex@nvidia.com,
	erezsh@nvidia.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gal@nvidia.com,
	dtatulea@nvidia.com
Subject: Re: [PATCH net-next 1/3] net/mlx5: HWS, Check if device is down while polling for completion
Date: Sun, 10 May 2026 20:03:51 +0100
Message-ID: <20260510190351.1422486-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507173443.320465-2-tariqt@nvidia.com>
References: <20260507173443.320465-2-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 54E1A505DFD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-20317-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net/mlx5: HWS, Check if device is down while polling for completion

This commit adds a check to abort polling for hardware completions if the
device state indicates an internal error. This returns -ETIMEDOUT early to
avoid long timeouts when the hardware stops generating completions.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
> index 6dcd9c2a78aa8..eae02bc742218 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
> @@ -422,6 +422,18 @@ int mlx5hws_bwc_queue_poll(struct mlx5hws_context *ctx,
>  	if (!got_comp && !drain)
>  		return 0;
>  
> +	if (unlikely(ctx->mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR)) {
> +		/* If the device is down for any reason (e.g. FLR), the HW will
> +		 * no longer generate completions.
> +		 * Note that ETIMEDOUT is returned here because the BWC layer
> +		 * already has a special handling for timeouts - it breaks the
> +		 * rehash / resize / shrink loops to avoid chain of timeouts.
> +		 */
> +		mlx5_core_warn_once(ctx->mdev,
> +				    "BWC poll: device is down, polling for completion aborted\n");
> +		return -ETIMEDOUT;
> +	}
> +
>  	queue_full = mlx5hws_send_engine_full(&ctx->send_queue[queue_id]);
>  	while (queue_full || ((got_comp || drain) && *pending_rules)) {

Could this lead to a CPU stall if the device goes down during the polling loop?

The hardware state check is placed outside the while loop. The loop has a
60-second timeout (MLX5HWS_BWC_POLLING_TIMEOUT) and lacks cond_resched(),
meaning it can peg the CPU while spinning.

If the hardware fails and stops generating completions while we are already
inside the loop, the driver's health thread on another CPU might detect the
failure and set ctx->mdev->state to MLX5_DEVICE_STATE_INTERNAL_ERROR.

Since the check is outside the loop, we would fail to detect the state change
and continue to spin uselessly for the remainder of the 60 seconds, which
could trigger a soft lockup panic.

Should the state check be moved inside the polling loop, perhaps using
READ_ONCE() on ctx->mdev->state to ensure the compiler does not hoist the
lockless read?

>  		ret = mlx5hws_send_queue_poll(ctx, queue_id, comp, burst_th);

