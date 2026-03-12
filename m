Return-Path: <linux-rdma+bounces-18059-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GhcKakqsmleJQAAu9opvQ
	(envelope-from <linux-rdma+bounces-18059-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 03:53:29 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A29F26C7B3
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 03:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7791E310F898
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 02:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8501D37C93F;
	Thu, 12 Mar 2026 02:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5GDGT0J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A8533F8B7;
	Thu, 12 Mar 2026 02:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773283929; cv=none; b=i05jOnYggNNgTvtANwGFMX2iE6udwXcRniuz2wnIw7FOWc8D6wyfwpzNtJHYtHp3n4pjGHyBQLB3p6JprSvQ8UzwdXldjJziyaH+Um0YSgoOHTwYCBXXnmt2aIvKT/Kw/npS49Fwi+NhUTcWX+cK1weOhZf6z1weaEObexSmA9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773283929; c=relaxed/simple;
	bh=HSQM8TeR1XXEYwjyd/8yZVZDhU1JDCBPTz3eH73z4SU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kDTM3S+Zelz+CgNgiJtxkGQUKV6Mc04IMoZ8Rp0tbXZsvgZhafLz7rt9cJduX5+JgfuadDYLKcoyjv185pQxVRsAlLC6WkwsCp45PuFQ5r3rAfpxmD4XrjiPLKPLYMSzNCbP6Uozlt6t+Q2UD0JQ3i6fy6iHtnf6y6pLuknq8pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5GDGT0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D316CC4CEF7;
	Thu, 12 Mar 2026 02:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773283928;
	bh=HSQM8TeR1XXEYwjyd/8yZVZDhU1JDCBPTz3eH73z4SU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b5GDGT0J0hEjhisaOmnXr8/vuMQePX3qEmTUq34G2of2P0hHrLavg6UdnQVTuz9Ph
	 FgaPCsdPV5KMMQJRnWlx6i6peeavTzlJzYBt8EL6wnQ8CnzUwBYT0GGIEZn82I3vp3
	 3n0kv9GPoTD4li+sc+65Alkbnro70m6p61WTDbq932rO+V1AIgCX2yjCG/odMBexQY
	 RqoKYUEbKZZ+7u0Atlo870sC3T7HUi+Th6mzAFPCGUZJzQ1rRiqd9J/h0smUEu5v/8
	 Sxwv3ifmNWiO3shHM7wI/ftat1waXWMK/qPESKFk+BhAr34q3wEq+bHgICAN+bk4Jz
	 A0CkwKxE3r3QQ==
From: Jakub Kicinski <kuba@kernel.org>
To: bjorn@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	danieller@nvidia.com,
	michael.chan@broadcom.com,
	saeedm@nvidia.com,
	piergiorgio.beruto@gmail.com,
	naveenm@marvell.com,
	maxime.chevallier@bootlin.com,
	linux-kselftest@vger.kernel.org,
	kory.maincent@bootlin.com,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	edumazet@google.com,
	o.rempel@pengutronix.de,
	pavan.chebbi@broadcom.com,
	willemb@google.com,
	hkelam@marvell.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	linux@armlinux.org.uk,
	andrew+netdev@lunn.ch,
	tariqt@nvidia.com,
	donald.hunter@gmail.com,
	pabeni@redhat.com
Subject: Re: [net-next,03/11] ethtool: Add loopback GET/SET netlink implementation
Date: Wed, 11 Mar 2026 19:51:49 -0700
Message-ID: <20260312025149.605627-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310104743.907818-4-bjorn@kernel.org>
References: <20260310104743.907818-4-bjorn@kernel.org>
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
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,broadcom.com,gmail.com,marvell.com,bootlin.com,vger.kernel.org,davemloft.net,google.com,pengutronix.de,armlinux.org.uk,lunn.ch,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[28];
	TAGGED_FROM(0.00)[bounces-18059-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A29F26C7B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
ethtool: Add loopback GET/SET netlink implementation

This commit adds kernel-side handlers for ETHTOOL_MSG_LOOPBACK_GET,
ETHTOOL_MSG_LOOPBACK_SET, and ETHTOOL_MSG_LOOPBACK_NTF messages.

> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 83c375840835..c9beca11fc40 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -846,6 +846,22 @@ void ethtool_mmsv_set_mm(struct ethtool_mmsv *mmsv, struct ethtool_mm_cfg *cfg);
>  void ethtool_mmsv_init(struct ethtool_mmsv *mmsv, struct net_device *dev,
>  		       const struct ethtool_mmsv_ops *ops);
>
> +/**
> + * struct ethtool_loopback_entry - Per-component loopback configuration
> + * @id: Optional component instance identifier, 0 means not specified
> + * @supported: Bitmask of supported directions
> + * @component: Loopback component
> + * @direction: Current loopback direction, 0 means disabled
> + * @name: Subsystem-specific name for the loopback point
> + */
> +struct ethtool_loopback_entry {
> +	enum ethtool_loopback_component component;
> +	u32 id;
> +	u32 supported;
> +	u32 direction;
> +	char name[ETH_GSTRING_LEN];
> +};

The kernel-doc field tags don't match the struct field order. The
documentation lists @id, @supported, @component, @direction, @name, but
the struct declares them as component, id, supported, direction, name.
Kernel-doc requires @field tags to follow the actual declaration order,
and scripts/kernel-doc will emit warnings for this mismatch.

[ ... ]

