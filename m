Return-Path: <linux-rdma+bounces-22349-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lm15NCnyM2owJgYAu9opvQ
	(envelope-from <linux-rdma+bounces-22349-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 15:27:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBB66A07B5
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 15:27:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ePH305ta;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22349-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22349-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B177F30344EE
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 13:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7EE3C345C;
	Thu, 18 Jun 2026 13:26:50 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E02F3905E0;
	Thu, 18 Jun 2026 13:26:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781789210; cv=none; b=tPi3eTdMf0oFa6qd8LcAYJxypUQWbBOXXJ+30EUBlLW3kBrckasQuGrd7IQchJeaO3XKDNsk2CZhRComvxd8q+9VVgWqNnYF+inKlRo9RgafBOSCLDvhdEOJJSxIRnHmnBN3hG2f9/Mf9dTyaqYBExFufIcLw835YUgKG4VvAds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781789210; c=relaxed/simple;
	bh=QLElcu9hzb0P9ZXwyhxlrodftHCw/3tjsGb+QSKtCgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OkTb5D9RmDLAQXe3WCctNpUh8Nu7HeifXXfNnJP3CtBEvONOrzsGAi2fr9gRXlzDKxicUZcgbqqirNNDlTtojfWHAPmyXob70T6REBWRNn3RAgCqaHUOiYWFgzmI9jwYvXs84Mc3SHOy3mSjWazOnKIIDnvWBLEeXfp3GZAIfQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePH305ta; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866741F00ACA;
	Thu, 18 Jun 2026 13:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781789208;
	bh=oP8CklMUaboQLSuBeJTlR6jjiTi2cbJtmz4ndwNg7Hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ePH305taClEHRX7/p9PObb/G1F17AsBqD1kbzlA8VsxNnxeR/tdpMunsl/VAi3g6c
	 nCU3YpNI3iOaZZtZ7aVcwhVEyZu24FzADcHAc3LK6j0CKmHYLPyYIhrMdlUd5hfCZN
	 ah+iD48ZN/VukYANVT49OjnF54g0koiUcAsbdRoz6dle+YDdBYAhEwJEW24Lw4LMGX
	 9dFfgDwAgENyr8KGA14FItdKASNGvJshTz8VxG3YLMWr4Q6QFe8l+WgE0jq8vw4YAx
	 23DaOJ+hCdCKO5DCnoeC9K134vJVVDdjOAyeeqcUdUatB5D3BBQloFA9FZcXD85H5Z
	 cKQl69mYXkSIA==
From: Simon Horman <horms@kernel.org>
To: doruk@0sec.ai
Cc: Simon Horman <horms@kernel.org>,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	sd@queasysnail.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	borisp@nvidia.com,
	raeds@nvidia.com,
	ehakim@nvidia.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net/mlx5e: macsec: fix use-after-free of metadata_dst on RX SC delete
Date: Thu, 18 Jun 2026 14:18:58 +0100
Message-ID: <20260618131857.894379-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617100558.83654-1-doruk@0sec.ai>
References: <20260617100558.83654-1-doruk@0sec.ai>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22349-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:doruk@0sec.ai,m:horms@kernel.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:sd@queasysnail.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:borisp@nvidia.com,m:raeds@nvidia.com,m:ehakim@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5CBB66A07B5

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net/mlx5e: macsec: fix use-after-free of metadata_dst on RX SC delete

This commit fixes a use-after-free in the MACsec RX datapath by replacing
a synchronous metadata_dst_free() with dst_release() when an RX SC is
deleted. It also updates the datapath to use dst_hold_safe() to avoid
acquiring a reference to a dying destination entry.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
> @@ -829,7 +829,7 @@ static void macsec_del_rxsc_ctx(struct mlx5e_macsec *macsec, struct mlx5e_macsec
>  	 */
>  	list_del_rcu(&rx_sc->rx_sc_list_element);
>  	xa_erase(&macsec->sc_xarray, rx_sc->sc_xarray_element->fs_id);
> -	metadata_dst_free(rx_sc->md_dst);
> +	dst_release(&rx_sc->md_dst->dst);
>  	kfree(rx_sc->sc_xarray_element);

[Severity: Critical]
This is a pre-existing issue, but is it safe to synchronously call kfree()
on rx_sc->sc_xarray_element here?

The RX datapath accesses the xarray under rcu_read_lock() in
mlx5e_macsec_offload_handle_rx_skb(). If sc_xarray_element is fetched via
xa_load() by a concurrent reader just before xa_erase() runs, won't this
kfree() free the element while the reader is still accessing it, leading to
a use-after-free?

>  	kfree_rcu_mightsleep(rx_sc);
>  }

[ ... ]

> @@ -1697,8 +1697,8 @@ void mlx5e_macsec_offload_handle_rx_skb(struct net_device *netdev,
>  	sc_xarray_element = xa_load(&macsec->sc_xarray, fs_id);
>  	rx_sc = sc_xarray_element->rx_sc;

[Severity: Critical]
This isn't a bug introduced by this patch, but does xa_load() return NULL
if the fs_id has already been erased by xa_erase() in the deletion path?

If packets matched by hardware before the rule was deleted are still
lingering in the software RX queues, xa_load() might return NULL.
Dereferencing sc_xarray_element->rx_sc immediately after could cause a
NULL pointer dereference. Could we add a NULL check here before accessing
sc_xarray_element?

[Severity: Critical]
This is also a pre-existing issue, but is rx_sc fully initialized when it
becomes visible to RCU readers?

In mlx5e_macsec_add_rxsc(), it appears sc_xarray_element is published to
the xarray via xa_alloc() before rx_sc->md_dst is allocated and
initialized:

mlx5e_macsec_add_rxsc() {
    ...
    err = xa_alloc(&macsec->sc_xarray, &sc_xarray_element->fs_id, ...);
    ...
    rx_sc->md_dst = metadata_dst_alloc(0, METADATA_MACSEC, GFP_KERNEL);
    ...
}

Since xa_alloc() assigns the lowest available index, the new fs_id could be
recycled from a recently deleted SC. If a lingering packet with the old
fs_id is processed by the datapath, it could find the newly published
element and attempt to call dst_hold_safe(&rx_sc->md_dst->dst).

Because rx_sc->md_dst is still NULL at that moment, could this cause a NULL
pointer dereference?

>  	if (rx_sc) {
> -		dst_hold(&rx_sc->md_dst->dst);
> -		skb_dst_set(skb, &rx_sc->md_dst->dst);
> +		if (dst_hold_safe(&rx_sc->md_dst->dst))
> +			skb_dst_set(skb, &rx_sc->md_dst->dst);
>  	}
>  
>  	rcu_read_unlock();

