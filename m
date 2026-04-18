Return-Path: <linux-rdma+bounces-19424-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKCmHBfX42krLQEAu9opvQ
	(envelope-from <linux-rdma+bounces-19424-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Apr 2026 21:10:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2ED42204D
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Apr 2026 21:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02C07302D082
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Apr 2026 19:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15E1331A6D;
	Sat, 18 Apr 2026 19:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5TF924w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E951C84BC;
	Sat, 18 Apr 2026 19:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776539331; cv=none; b=eHNYZw6BBTvnCS6zdZqrsY+XI+6rVAH3wmdkfm1EaWj7tgQCnuvOWBuIjfql4oMrITYlaDG5mBDNQpwp56ssLhTEYr5r8/UBj4vscQd9eB64qj7Lnx23AjuWXWT1SIjWPTUoZyvdoXQRjZCj+kDLn65Jha62hCubXU/MB3mBV8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776539331; c=relaxed/simple;
	bh=HajiuwXySR5e6ZvoEF+adUWZ3SC4ooGmpD4VTM1vopU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBAUgkvy7hMfU5Y+fiEYllkqhDAlzBJtACdMJYkGTQfSHLo3VfTOYJbJ1LvaFuGt3i5IKOILri2k3ZgXTurf4BGlZpjEG6xWTKEIL5xLZ/3A8rgE1bG3+nLjo23vRy6Rogs4UBh/xqqaXiXoWkvPnPaPle8cnQgGeXNkrCktF3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5TF924w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59F8C19424;
	Sat, 18 Apr 2026 19:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776539331;
	bh=HajiuwXySR5e6ZvoEF+adUWZ3SC4ooGmpD4VTM1vopU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a5TF924wvWIlJJPCqZOXRPLv+YwYDpREotmeruQWFpqB7AgrptwOYRtfY3wdFRtVk
	 r7RS1vlAIj1NDyaDanjq3Ml0Z5BzT/N/1K9xAVbsyehl4zW9/5WRuywub9kxTqgNLD
	 TKCYCl23rjDcWjDNMyzPAh2B1se8O5Q8AfoZJQBk0IqVm2FbPcGqjZIKYlfjEwebCG
	 OYl5pQxCVqRlptGKPOYGt7Ev9BfFsZL1w0FfQPrbDP0yim061KCdKMPiaoM5us9S9d
	 B4Bwc8YFuK3lt56tjnPPBhz+dm/IBtaIEfInOR2y8JqjDOrSc6Pnh94peUMhKGsK2O
	 2TJYvMdaxektA==
From: Jakub Kicinski <kuba@kernel.org>
To: tariqt@nvidia.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	borisp@nvidia.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	mbloch@nvidia.com,
	daniel.zahka@gmail.com,
	willemdebruijn.kernel@gmail.com,
	cratiu@nvidia.com,
	raeds@nvidia.com,
	rrameshbabu@nvidia.com,
	dtatulea@nvidia.com,
	kees@kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gal@nvidia.com
Subject: Re: [PATCH net 1/2] net/mlx5e: psp: Fix invalid access on PSP dev registration fail
Date: Sat, 18 Apr 2026 12:08:48 -0700
Message-ID: <20260418190848.204170-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417050201.192070-2-tariqt@nvidia.com>
References: <20260417050201.192070-2-tariqt@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,redhat.com,lunn.ch,davemloft.net,nvidia.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-19424-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE2ED42204D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/mlx5e: psp: Fix invalid access on PSP dev registration fail

This commit updates PSP device registration to use a local variable,
only saving the PSP device pointer if psp_dev_create() succeeds. This
prevents an error pointer from being stored in priv->psp->psp.

> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
[ ... ]
> @@ -1070,29 +1070,37 @@ static struct psp_dev_ops mlx5_psp_ops = {
[ ... ]
>  void mlx5e_psp_register(struct mlx5e_priv *priv)
>  {
> +	struct mlx5e_psp *psp = priv->psp;
> +	struct psp_dev *psd;
> +
[ ... ]
> -	priv->psp->psp = psp_dev_create(priv->netdev, &mlx5_psp_ops,
> -					&priv->psp->caps, NULL);
> -	if (IS_ERR(priv->psp->psp))
> +	psd = psp_dev_create(priv->netdev, &mlx5_psp_ops, &psp->caps, NULL);
> +	if (IS_ERR(psd)) {
>  		mlx5_core_err(priv->mdev, "PSP failed to register due to %pe\n",
> -			      priv->psp->psp);
> +			      psd);
> +		return;
> +	}
> +	psp->psp = psd;
>  }

When psp_dev_create() fails, this function now returns without setting
psp->psp, leaving it as NULL. However, priv->psp remains allocated and
non-NULL.

Does this leave the RX datapath vulnerable to a NULL pointer dereference?

If priv->psp is non-NULL, the NIC RX initialization path can still call
mlx5_accel_psp_fs_init_rx_tables(), which creates hardware flow steering
rules to intercept UDP traffic.

If a UDP packet triggers these rules, the hardware flags the CQE with
MLX5E_PSP_MARKER_BIT. The RX fast-path sees the marker and invokes
mlx5e_psp_offload_handle_rx_skb(), which dereferences the pointer
unconditionally:

u16 dev_id = priv->psp->psp->id;

Since priv->psp->psp is NULL, this will cause a kernel panic. Should
priv->psp be cleaned up, or the error propagated, to prevent flow rules
from being installed when registration fails?
-- 
pw-bot: cr

