Return-Path: <linux-rdma+bounces-15872-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOOaNImccWmdKAAAu9opvQ
	(envelope-from <linux-rdma+bounces-15872-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 04:42:01 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E53EB61697
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 04:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACD9D7C409F
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 03:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71B336C0C8;
	Thu, 22 Jan 2026 03:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUnv8nrS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B815038A9CB;
	Thu, 22 Jan 2026 03:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769053204; cv=none; b=M6INUJxw8z42YpUEQ/dUdr1ZZP4PY2mez/q1vHle5mOIXB5WBbruDS6sjn/varb4Nnbq8tPclUBDrNQNs+oLv9qIRJRw1yje262ZfLVi1pg3PHIgMUYZ53+pyVy3TmjM3nzAM34kFcVa2mmn4v6Owvq/gnOZggZu4aJBvn+KYkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769053204; c=relaxed/simple;
	bh=9EAuucdgVUmMBZuMvSvGkSA4F06QTDcJca8tRndCmAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1VajqRxslI7jxtnewrQATmfIn1dXZCo28IJFBpkatKO3pSIMR1tngcBLorRUdjsY1SwvG2IYAV9WWMjeVfpAJGPssNVkgYvhC3H8m14ZUKp/mfGX4K52M1cQ/5qXs7C8RIY++PSO1uThBrr3scjYDeIBpXrMMb5Eb5rvut6yvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUnv8nrS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89C5C116C6;
	Thu, 22 Jan 2026 03:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769053202;
	bh=9EAuucdgVUmMBZuMvSvGkSA4F06QTDcJca8tRndCmAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eUnv8nrSrrtHVIPtT8ddCD52tU2Y3MH2iyDoLgHl4bWcv0CoA8oONbl2KmWDPmCg5
	 IDr6MI1byROGQcpi5NTjyfGN8jupgnetQximrYkAAYZ6j6fYHym0BLNNDmnfOZ72Ko
	 usmE4iTgUn9Cpei/Vz6b/WWrj9r0XonWLUmA3V1r+LySbJ0JPLAstPlZQt+GYtwiW3
	 XkEy38xSvhgzTipXhIZFx9OCccAngr41ECtbGj7AvEicDtDbAK/k7yrCq210IG84bN
	 +U2VD7Y0nHJz1H+n2pt4bSQIV9wcSym+CRAj3ASAzdPV3MkPD1A67xiHFc3tlgXLkX
	 nY121ajmJp90A==
From: Jakub Kicinski <kuba@kernel.org>
To: tariqt@nvidia.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	cratiu@nvidia.com,
	saeedm@nvidia.com,
	cjubran@nvidia.com,
	davem@davemloft.net,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	mbloch@nvidia.com,
	moshe@nvidia.com,
	jiri@nvidia.com,
	edumazet@google.com,
	gal@nvidia.com,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	jiri@resnulli.us,
	krzk@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	rdunlap@infradead.org,
	leon@kernel.org,
	corbet@lwn.net
Subject: Re: [net-next,V5,11/15] net/mlx5: Expose a function to clear a vport's parent
Date: Wed, 21 Jan 2026 19:40:01 -0800
Message-ID: <20260122034001.2579161-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <1768895878-1637182-12-git-send-email-tariqt@nvidia.com>
References: <1768895878-1637182-12-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	URIBL_MULTI_FAIL(0.00)[linux.dev:server fail,dfw.mirrors.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-15872-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,davemloft.net,vger.kernel.org,google.com,lunn.ch,gmail.com,resnulli.us,redhat.com,infradead.org,lwn.net];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E53EB61697
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net/mlx5e: Skip ESN replay window setup for IPsec crypto offload

This patch fixes a WARN_ON being triggered for crypto offload by adding
a check to skip the replay window setup when the offload type is not
XFRM_DEV_OFFLOAD_PACKET.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> index a8fb4bec369c..63aa23f5c49e 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> @@ -430,7 +430,8 @@ void mlx5e_ipsec_build_accel_xfrm_attrs(struct mlx5e_ipsec_sa_entry *sa_entry,
>  		attrs->replay_esn.esn = sa_entry->esn_state.esn;
>  		attrs->replay_esn.esn_msb = sa_entry->esn_state.esn_msb;
>  		attrs->replay_esn.overlap = sa_entry->esn_state.overlap;
> -		if (attrs->dir == XFRM_DEV_OFFLOAD_OUT)
> +		if (attrs->dir == XFRM_DEV_OFFLOAD_OUT ||
> +		    attrs->type != XFRM_DEV_OFFLOAD_PACKET)
>  			goto skip_replay_window;

At this point in mlx5e_ipsec_build_accel_xfrm_attrs(), attrs->type has not
been initialized yet. The function starts with memset(attrs, 0, ...) which
sets attrs->type to 0 (XFRM_DEV_OFFLOAD_UNSPECIFIED).

The assignment attrs->type = x->xso.type happens later after the
skip_replay_window label. This means the condition attrs->type !=
XFRM_DEV_OFFLOAD_PACKET evaluates as 0 != 2 which is always true.

As a result, the replay window setup will be skipped for all inbound
configurations, not just crypto offload. Should this check use x->xso.type
instead of attrs->type, or should attrs->type be assigned earlier in the
function before this check?

