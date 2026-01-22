Return-Path: <linux-rdma+bounces-15871-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEOIEpCdcWl6KQAAu9opvQ
	(envelope-from <linux-rdma+bounces-15871-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 04:46:24 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BCC61700
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 04:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D3B8C34EB8A
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 03:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197C440FDAA;
	Thu, 22 Jan 2026 03:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boNhZayU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE6440F8C2;
	Thu, 22 Jan 2026 03:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769053201; cv=none; b=jq8QULqtNXqWGixZ9NHsxXT/yE7XyruB6DNbMe/HAxj2Xde6eBXTGEG4jEhWYywnZcwv0IHE/Kt/lAJ4VfM9ShLg+SfjCqER+UvfYm74Ftvv6wDmmnUPlaX6kZMCfZsBNVMgqcPJqKJiXgTbFelID/XN4RwTHSdQXU+kpkq8P3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769053201; c=relaxed/simple;
	bh=8GvoOc9/1aLk3vlo7eEnFcRYL7gY5NKL6Hgs2VM3l4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFFktnbwdLoFshybl4ccNaEVwqfqUjKjYcgiTacQgxA5bdqpPDEbLHGpFVMXPetZ6qsLmCe+noe659c/6jYutrnwy9EPnCgrL7QRRBk1RfNJMKo3kpwHCFdkLpR33B6DG/nfuKj3BjSxjh7zTue3X9lLJQPWAbZJZSRqrsiKD3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boNhZayU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9241C116C6;
	Thu, 22 Jan 2026 03:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769053201;
	bh=8GvoOc9/1aLk3vlo7eEnFcRYL7gY5NKL6Hgs2VM3l4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=boNhZayUdjXhPz9WNaNNcjABniOA3wXYoaR2RaxT+jOSMz9rss7uQXwlK2zGCPZY5
	 XU/kJ4LSFPRSl+/ZOe6iinSDtnFAOlCBk/Pb0jTSvmr5ryLJ/qX8T0wUniQVQIW9No
	 FAZJOsJ6P+64zy9QiOuki79yMJHUudpZhBQGrke/ktXQTTxYcVwFwePGPS5Gv3gErk
	 U3Z1/wOkMT9t9MrJi9GCUF94XGImnIYmTksD9gHWZWBBQoD7VkWBKJJA8iVhiwcC2K
	 oJtkIaPeo1UTUBI2jKLmedFIyWesTbTcyKIG36yGLVkpsGAqeiBf+ROTlpTNOBohf3
	 3TSWb+vRF/A3g==
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
Subject: Re: [net-next,V5,10/15] net/mlx5: Add a shared devlink instance for PFs on same chip
Date: Wed, 21 Jan 2026 19:39:59 -0800
Message-ID: <20260122033959.2579113-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <1768895878-1637182-11-git-send-email-tariqt@nvidia.com>
References: <1768895878-1637182-11-git-send-email-tariqt@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-15871-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,davemloft.net,vger.kernel.org,google.com,lunn.ch,gmail.com,resnulli.us,redhat.com,infradead.org,lwn.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 21BCC61700
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net/mlx5: Add a shared devlink instance for PFs on same chip

Creates shared devlink infrastructure for mlx5 PFs on the same physical
chip, identified by chip serial number from PCI VPD.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
> new file mode 100644
> index 000000000000..abae5f0130e9
> --- /dev/null
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c

[ ... ]

> +int mlx5_shd_init(struct mlx5_core_dev *dev)
> +{
> +	u8 *vpd_data __free(kfree) = NULL;

The __free(kfree) annotation here combined with the early return below
looks problematic.

> +	struct pci_dev *pdev = dev->pdev;
> +	unsigned int vpd_size, kw_len;
> +	struct devlink *devlink;
> +	const char *sn;
> +	char *end;
> +	int start;
> +	int err;
> +
> +	if (!mlx5_core_is_pf(dev))
> +		return 0;
> +
> +	vpd_data = pci_vpd_alloc(pdev, &vpd_size);
> +	if (IS_ERR(vpd_data)) {
> +		err = PTR_ERR(vpd_data);
> +		return err == -ENODEV ? 0 : err;
> +	}

When pci_vpd_alloc() returns an ERR_PTR (e.g., -EIO or -ENOMEM) and the
function returns here, does the __free(kfree) cleanup call kfree() on an
ERR_PTR value? The kfree() implementation only handles NULL and
ZERO_SIZE_PTR safely via the ZERO_OR_NULL_PTR() check - ERR_PTR values
are large unsigned values that would pass this check and proceed to
virt_to_page() on an invalid address.

This same issue was raised by Krzysztof Kozlowski in review of V4:
https://lore.kernel.org/netdev/2df5ac80-5db6-4b8f-ab5b-b8b89237777f@kernel.org/

To fix this, either set vpd_data = NULL before the early return, or
remove the __free(kfree) annotation and handle cleanup manually.

[ ... ]

