Return-Path: <linux-rdma+bounces-18060-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MG8dJdYqsmleJQAAu9opvQ
	(envelope-from <linux-rdma+bounces-18060-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 03:54:14 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3640926C7CA
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 03:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED5073146CF0
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 02:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D45374E50;
	Thu, 12 Mar 2026 02:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKcQeRfl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6836E271A6D;
	Thu, 12 Mar 2026 02:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773283940; cv=none; b=DxzdwfLjUlTM63eGjidrAvM2fA2lbkhw3T0IiK1ZzUtXafbK837bN8VgwHdyzTDXbf0IZ9QSLZmp+ZIjY/tqifTm1l/U9HDmK+/jE7FWM3FEPfIUSziQLnZrTfK//WDlOKiAHm5YlU+IfXTSdXTuo7UedyPqdjyAPymkC2sEwN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773283940; c=relaxed/simple;
	bh=dtJL0BSJSk7aYNEFi6aBgskZKtAcqReoaIFIhwi4QjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PajCaTVq4YIBhhUAw/2bMHOvXBGvrbPZE4iPuG/IDobhTvJzYKwTTVeS5Y0i2IPFeES1WRH2KzAnl1+1fDjuRSgdXIht3JeEu9mnJ9v1IJ26pIeTn8RLTE2D/G5pEfZNonY5FhEJqXaplCqEtNBt8dfNWQTVsy+OEv4Oh+7QAoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKcQeRfl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF27EC4CEF7;
	Thu, 12 Mar 2026 02:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773283940;
	bh=dtJL0BSJSk7aYNEFi6aBgskZKtAcqReoaIFIhwi4QjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZKcQeRflf1SOj6r/lAOEIc31RI0jydeEhsG8vMY1oJhtrRDOr4Mts1vbEb5YFRnBR
	 JJDi22q8SwqmfpGD6b/fW4uRkEYi08kWwtssUsElxb3ML6j5taeHt7dIIV28mD++83
	 p6GJgTgyoDcwNMrgW+CAGwSPRbB0Y5hsABbDSWYafL3XmwGjnWR7IGilEvnwg3gdxG
	 GKyGB02LV0HhLhDhgr4p26vhCvgyug7b0OnwQ5KjIL38IxevfvF/zQCPUimm2DFiIo
	 na5WZDZR956mL4mj5y5+2ic0k/xwJTJOhorXUrUPO9i9heM42YuhMBw+JNZ/ktL+oP
	 60W2F2FHDsOtw==
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
Subject: Re: [net-next,10/11] netdevsim: Add module EEPROM simulation via debugfs
Date: Wed, 11 Mar 2026 19:52:09 -0700
Message-ID: <20260312025209.605854-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310104743.907818-11-bjorn@kernel.org>
References: <20260310104743.907818-11-bjorn@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-18060-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 3640926C7CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
netdevsim: Add module EEPROM simulation via debugfs

This patch adds get/set_module_eeprom_by_page ethtool ops to netdevsim
for testing kernel features that depend on module EEPROM access. The
EEPROM is backed by a 256-page x 128-byte array exposed via debugfs.

> diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
> index 84bc025885f7..7ef96a747643 100644
> --- a/drivers/net/netdevsim/ethtool.c
> +++ b/drivers/net/netdevsim/ethtool.c
> @@ -247,6 +247,68 @@ static int nsim_set_loopback(struct net_device *dev,
>  	return 1;
>  }
>
> +static u8 *nsim_module_eeprom_ptr(struct netdevsim *ns,
> +				  const struct ethtool_module_eeprom *page_data,
> +				  u32 *len)
> +{
> +	u32 offset;
> +	u8 page;
> +
> +	if (page_data->offset < NSIM_MODULE_EEPROM_PAGE_LEN) {
> +		page = 0;
> +		offset = page_data->offset;
> +	} else {
> +		page = page_data->page;
                     ^^^^

Does this need bounds checking? The page_data->page value comes from userspace
via ethtool and is used directly as an array index at the return statement
below. The module.pages array is defined as:

    u8 pages[NSIM_MODULE_EEPROM_PAGES][NSIM_MODULE_EEPROM_PAGE_LEN]

where NSIM_MODULE_EEPROM_PAGES is 256. A userspace caller could provide a page
number >= 256, leading to an out-of-bounds access:

    return ns->ethtool.module.pages[page] + offset;

This can result in reading or writing (via nsim_set_module_eeprom_by_page)
adjacent kernel memory.

> +		offset = page_data->offset - NSIM_MODULE_EEPROM_PAGE_LEN;
> +	}
> +
> +	*len = min_t(u32, page_data->length,
> +		     NSIM_MODULE_EEPROM_PAGE_LEN - offset);
                                                  ^^^^^^

Can offset exceed NSIM_MODULE_EEPROM_PAGE_LEN here? When page_data->offset >=
128, the code calculates:

    offset = page_data->offset - NSIM_MODULE_EEPROM_PAGE_LEN

If page_data->offset is large (e.g., 300), the resulting offset would be 172.
At the min_t calculation:

    NSIM_MODULE_EEPROM_PAGE_LEN - offset = 128 - 172 = -44

This underflows when cast to u32, becoming a large unsigned value. The return
statement then accesses:

    ns->ethtool.module.pages[page] + offset

where offset can be > 128, reading past the page boundary. Each page is only
NSIM_MODULE_EEPROM_PAGE_LEN (128) bytes, but offset isn't validated to be
within this range.

> +	return ns->ethtool.module.pages[page] + offset;
> +}
> +
> +static int
> +nsim_get_module_eeprom_by_page(struct net_device *dev,
> +			       const struct ethtool_module_eeprom *page_data,
> +			       struct netlink_ext_ack *extack)
> +{
> +	struct netdevsim *ns = netdev_priv(dev);
> +	u32 len;
> +	u8 *ptr;
> +
> +	if (ns->ethtool.module.get_err)
> +		return -ns->ethtool.module.get_err;
> +
> +	ptr = nsim_module_eeprom_ptr(ns, page_data, &len);
> +	if (!ptr)
> +		return -EINVAL;
> +
> +	memcpy(page_data->data, ptr, len);
> +
> +	return len;
> +}
> +
> +static int
> +nsim_set_module_eeprom_by_page(struct net_device *dev,
> +			       const struct ethtool_module_eeprom *page_data,
> +			       struct netlink_ext_ack *extack)
> +{
> +	struct netdevsim *ns = netdev_priv(dev);
> +	u32 len;
> +	u8 *ptr;
> +
> +	if (ns->ethtool.module.set_err)
> +		return -ns->ethtool.module.set_err;
> +
> +	ptr = nsim_module_eeprom_ptr(ns, page_data, &len);
> +	if (!ptr)
> +		return -EINVAL;
> +
> +	memcpy(ptr, page_data->data, len);
> +
> +	return 0;
> +}

[ ... ]

> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
> index 2e322b9410d2..f6b2063d41c9 100644
> --- a/drivers/net/netdevsim/netdevsim.h
> +++ b/drivers/net/netdevsim/netdevsim.h
> @@ -82,6 +82,16 @@ struct nsim_ethtool_pauseparam {
>  	bool report_stats_tx;
>  };
>
> +#define NSIM_MODULE_EEPROM_PAGES	256
> +#define NSIM_MODULE_EEPROM_PAGE_LEN	128
> +
> +struct nsim_ethtool_module {
> +	u32 get_err;
> +	u32 set_err;
> +	u8 pages[NSIM_MODULE_EEPROM_PAGES][NSIM_MODULE_EEPROM_PAGE_LEN];
> +	struct debugfs_blob_wrapper page_blobs[NSIM_MODULE_EEPROM_PAGES];
> +};

[ ... ]

