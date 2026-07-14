Return-Path: <linux-rdma+bounces-23219-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dnwZOdtyVmoT5wAAu9opvQ
	(envelope-from <linux-rdma+bounces-23219-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 19:33:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC55757789
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 19:33:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NQbym8GK;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23219-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23219-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D657D308A53D
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 17:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093AF30567F;
	Tue, 14 Jul 2026 17:30:41 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B985E2EB859;
	Tue, 14 Jul 2026 17:30:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784050240; cv=none; b=VOlVIdCw64pOk7DtQvfyZkSYgskhee/mFt5SxxI2LLvNrb0M4G8875tifLtRLXvFx/2Mgf+V1+FNTEZUtieqe/pOz1eJftlFskxNKw5j31/fDoO2sClo1dOogsj+dEgtxCQ43PZHuf4Tq+EJ3CtlFxP6rvoDLJQ7/Q6R+FeO3t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784050240; c=relaxed/simple;
	bh=NCSxxIN+16TO8oaSsaNS2Mogz4ThQYqHl2gC/sOvu2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jet3MPPSwTI+YlvjaiLJENEXFmL+LK3/B22rPVkMyt+viVM1eMFLzq99akE7T8uhzGBwOJ+BmS/sQ97kmYAAnPRnt9VvMTX6nkGpx5bsi7W4P9SUJe/j2YXFXtuCTeoETIvyWB/EpjtI/VSIHG2KbHD8VOWwhd9ZZCPEZu9NpUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQbym8GK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07391F000E9;
	Tue, 14 Jul 2026 17:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784050239;
	bh=mEGj/NqZol7hv1wLOMTOXP7Nm1D+jQYiyzR3lYzmyeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NQbym8GKyZCVW7eFWE0P6wJQs4eFFBrXWzv/Vn30JvafBupWkudY06xJpu8/zeGb0
	 aufCHFeb9q6wzS1hPb5qUBTdJz6bRl4syheFDQhcyEEduH0DK2sM+lTmxckvAjPFAE
	 7L80lSbyYi7v0kvlB1VXQVGShIc1vuC+TCRUH187Ph/KUCCc/QCTFukXC0CndOwx4F
	 fAamgw3+yC3oDX90WF3jWNpHIyy90rmdB9sW6121os3z3dcwo+mNGEqVb6cPr90B/D
	 aHx5RhURW+L0tpOYZc0YbUaumI5ZKv/g5UgcX4sVbxzlYfnFscaRXEVR3gVM88G2if
	 WvShQevZ48RAA==
From: Simon Horman <horms@kernel.org>
To: tariqt@nvidia.com
Cc: Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	aleksandr.loktionov@intel.com,
	borisp@nvidia.com,
	cmi@nvidia.com,
	cratiu@nvidia.com,
	daniel.zahka@gmail.com,
	dtatulea@nvidia.com,
	gal@nvidia.com,
	jacob.e.keller@intel.com,
	jianbol@nvidia.com,
	lkayal@nvidia.com,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	mbloch@nvidia.com,
	raeds@nvidia.com,
	rrameshbabu@nvidia.com,
	saeedm@nvidia.com,
	sdf@fomichev.me,
	sdf.kernel@gmail.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next 13/15] net/mlx5e: psp: Make PSP steering config dynamic
Date: Tue, 14 Jul 2026 18:30:21 +0100
Message-ID: <20260714173021.1862773-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707130858.969928-14-tariqt@nvidia.com>
References: <20260707130858.969928-14-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23219-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:aleksandr.loktionov@intel.com,m:borisp@nvidia.com,m:cmi@nvidia.com,m:cratiu@nvidia.com,m:daniel.zahka@gmail.com,m:dtatulea@nvidia.com,m:gal@nvidia.com,m:jacob.e.keller@intel.com,m:jianbol@nvidia.com,m:lkayal@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:raeds@nvidia.com,m:rrameshbabu@nvidia.com,m:saeedm@nvidia.com,m:sdf@fomichev.me,m:sdf.kernel@gmail.com,m:willemdebruijn.kernel@gmail.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,m:sdfkernel@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,vger.kernel.org,redhat.com,intel.com,nvidia.com,gmail.com,fomichev.me];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6EC55757789

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
--- Patch [13]: [PATCH net-next 13/15] net/mlx5e: psp: Make PSP steering config dynamic ---
commit 133d9a32cbf9c1b939ae4ca8473c41624c313951
Author: Cosmin Ratiu <cratiu@nvidia.com>

net/mlx5e: psp: Make PSP steering config dynamic

This commit changes PSP steering tables to only be created when PSP
configuration is enabled on a device, instead of at device initialization
time. This avoids imposing steering overhead on all UDP packets when PSP
is not being used.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
> index b526b3898c22e..3f212e46fc2f9 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
> @@ -220,18 +220,7 @@ static inline void mlx5e_accel_tx_finish(struct mlx5e_txqsq *sq,
>  
>  static inline int mlx5e_accel_init_rx(struct mlx5e_priv *priv)
>  {
> -	int err;
> -
> -	err = mlx5_accel_psp_fs_init_rx_tables(priv);
> -	if (err)
> -		goto out;
> -
> -	err = mlx5e_ktls_init_rx(priv);
> -	if (err)
> -		mlx5_accel_psp_fs_cleanup_rx_tables(priv);
> -
> -out:
> -	return err;
> +	return mlx5e_ktls_init_rx(priv);
>  }
>  
>  static inline void mlx5e_accel_cleanup_rx(struct mlx5e_priv *priv)
> @@ -242,12 +231,6 @@ static inline void mlx5e_accel_cleanup_rx(struct mlx5e_priv *priv)
>  
>  static inline int mlx5e_accel_init_tx(struct mlx5e_priv *priv)
>  {
> -	int err;
> -
> -	err = mlx5_accel_psp_fs_init_tx_tables(priv);
> -	if (err)
> -		return err;
> -
>  	return mlx5e_ktls_init_tx(priv);
>  }

[Severity: Critical]
Does removing the unconditional table creation here prevent PSP tables
from being restored on device attach or resume?

Since mlx5_accel_psp_fs_cleanup_tx_tables() is still called during device
detach or suspend, the PSP steering tables are destroyed. However, because
mlx5e_accel_init_tx() no longer recreates them, the tables appear to remain
missing after a suspend/resume or detach/attach cycle.

Because software psp_assoc structures remain bound to active sockets, could
this leave the device in a state where the hardware TX steering table (which
contains the CRYPTO_ENCRYPT action) is missing?

If so, would this cause egress traffic to bypass encryption and be
transmitted in plaintext?

