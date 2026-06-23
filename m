Return-Path: <linux-rdma+bounces-22432-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EMefHIhkOmpy7wcAu9opvQ
	(envelope-from <linux-rdma+bounces-22432-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2026 12:48:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCDD6B65FF
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2026 12:48:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KfqCk1jq;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22432-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22432-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 368BE3055422
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2026 10:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815ED3B777B;
	Tue, 23 Jun 2026 10:48:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536162E5B2A;
	Tue, 23 Jun 2026 10:48:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782211715; cv=none; b=mmINxg9q/M57dr9bJ1VNbrIvFokc2dj1aIqrjtaqWiKfbS79bjiXpEqN4i9StvQRVJ/a/SZ/APGHl3k3LVu02c/GXYVz503XgLs8W7+VbW5HAjckwAGtPS0ZGX6gvdI6ZFIN39nApHh0jHiOiAyjdqMVGsIL/Q8OwTtOWcOVUa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782211715; c=relaxed/simple;
	bh=n2p4Th3gouArNv5pPghXIZk0RERqOXxj3mYIeXpAXL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZOfGIO74NAWf3LdZuN+qyqNXU1JjfMqBOiykSDkb6wbXD3jzKiypqlpIr1pumJ8SiTlngZcyfipvNyNw8WZnirRS39CDYZEfQ1m8Q2CKt5fwJc060HIMCFTPllHxwqWSoJClb4AreO96nbb7uH+mPWrmPCijfBBywEY/gm5BuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfqCk1jq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BC91F000E9;
	Tue, 23 Jun 2026 10:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782211714;
	bh=6iYwGL29g0r1KYRaQ5SGC8YKey7qP0vNbUrVAYJ5Kjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KfqCk1jqqK7FDFQ+4uS8bbCe8iAjiIFgmi1Fi7Wdu9+sE7+qh4W9SAQsppAzWsDXX
	 Fp+zonrWugNUzhox+Ee5PPO3f6K69+G+Kzc1mqukFLOC8w4E4tVt07Mm9zR2hmE+8j
	 89rxy/qBFoE12nTG0G5O3p5byKLkaY7efEtuVDB3GeYf4Yimj4ixI/PdQ+a2qoUfVH
	 HaA0GEB58hrLJ1ZdNoqxiJwUZV24GSw1+P7LV+J3enVZzw9VoMnozn/M5kJJ5yl7yH
	 8vVYuaKsdarNpB8qRDSfA8zoe1wxGmTFiJMll+1umarl2IF0zjdv2i16jd6BOGlQtL
	 b0AJjnFYkAAtA==
From: Simon Horman <horms@kernel.org>
To: tariqt@nvidia.com
Cc: Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	cratiu@nvidia.com,
	eranbe@nvidia.com,
	feliu@nvidia.com,
	haiyangz@microsoft.com,
	lkayal@nvidia.com,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	mbloch@nvidia.com,
	noren@nvidia.com,
	saeedm@nvidia.com,
	gal@nvidia.com,
	alazar@nvidia.com,
	cjubran@nvidia.com,
	kees@kernel.org,
	eranbe@mellanox.com,
	saeedm@mellanox.com
Subject: Re: [PATCH net V3 1/3] net/mlx5e: Fix HV VHCA stats zero-sized buffer allocation
Date: Tue, 23 Jun 2026 11:46:26 +0100
Message-ID: <20260623104624.1073738-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622083646.593220-2-tariqt@nvidia.com>
References: <20260622083646.593220-2-tariqt@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-22432-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:cratiu@nvidia.com,m:eranbe@nvidia.com,m:feliu@nvidia.com,m:haiyangz@microsoft.com,m:lkayal@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:noren@nvidia.com,m:saeedm@nvidia.com,m:gal@nvidia.com,m:alazar@nvidia.com,m:cjubran@nvidia.com,m:kees@kernel.org,m:eranbe@mellanox.com,m:saeedm@mellanox.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0DCDD6B65FF

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev

Simon says: I think this issue can be addressed by reversing the order
that patches 1/3 and 2/3 appear in this patch-set.

---
net/mlx5e: Fix HV VHCA stats zero-sized buffer allocation

This commit fixes a zero-sized buffer allocation by using max_nch instead of
stats_nch when allocating the buffer for HV VHCA stats.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c
> index 195863b2c013e..06cbd49d4e98e 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c
> @@ -122,7 +128,7 @@ static void mlx5e_hv_vhca_stats_cleanup(struct mlx5_hv_vhca_agent *agent)
>  
>  void mlx5e_hv_vhca_stats_create(struct mlx5e_priv *priv)
>  {
> -	int buf_len = mlx5e_hv_vhca_stats_buf_size(priv);
> +	int buf_len = mlx5e_hv_vhca_stats_buf_max_size(priv);
>  	struct mlx5_hv_vhca_agent *agent;
>  
>  	priv->stats_agent.buf = kvzalloc(buf_len, GFP_KERNEL);

[Severity: High]
Does this change introduce a potential double-free regression on memory
allocation failure?

When mlx5e_hv_vhca_stats_destroy() cleans up the stats agent, it frees the
agent but does not set priv->stats_agent.agent to NULL.

Before this patch, kvzalloc() was called with 0 and returned ZERO_SIZE_PTR,
so it never returned NULL. It always proceeded to call
mlx5_hv_vhca_agent_create() which overwrote priv->stats_agent.agent.

Now that the buffer size is non-zero, if kvzalloc() fails it will return
NULL and take the early return path in mlx5e_hv_vhca_stats_create():

	priv->stats_agent.buf = kvzalloc(buf_len, GFP_KERNEL);
	if (!priv->stats_agent.buf)
		return;

This early return bypasses overwriting the dangling priv->stats_agent.agent.
If a subsequent device detach occurs, mlx5e_hv_vhca_stats_destroy() could
dereference and free this stale pointer again.

I noticed this was later addressed upstream in commit e600849cc1e0
("net/mlx5e: Fix HV VHCA stats agent registration race").

