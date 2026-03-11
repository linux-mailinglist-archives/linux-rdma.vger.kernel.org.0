Return-Path: <linux-rdma+bounces-17970-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPDdHNOIsWnkDAAAu9opvQ
	(envelope-from <linux-rdma+bounces-17970-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 16:22:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AA926664B
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 16:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6ABF8302E54A
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 15:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874E03E0231;
	Wed, 11 Mar 2026 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LoJXAhtc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3A03DE43F;
	Wed, 11 Mar 2026 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773242556; cv=none; b=bYJmSUFhPIpAUuHm0HSnQ1K+eCNZkG/p8ePWg5GZS/OWKkvtZWP106AImzIpIDMeG/acrs2K/Qfdr0ZkL/DESWMWITiNdg83fP6dXOTssguIvqwYF2qCUFDrd+9zTN/bKF/b1n30g4zKg9ns9ectZrabOIy49HXzX4SKjZjrqis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773242556; c=relaxed/simple;
	bh=qRFaiSQZwzv5h4i/Ybr/t2QfiHGzsnHsVpAR43PfvTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbkP+R9KkEm2xAU4i8wJBXcmnvOjkNjAZTmRzeVkKI0vc5dtA8JUOe6s+3sU8F0mQfrab4TThUjTtA10gdGVZwfujiB87qkeS6v0BRWSUS307LWKbGNkoCp5sGflTsliTE37CQ15mYrjcm26Xw4uIwYqq4VYnbGUuRp99lp3PQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LoJXAhtc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=awh0Ys+3NgjrpC6UGam9rqfb3tVburlcVjXEfbIFJUg=; b=LoJXAhtcw/p/TmLcLDol+6TfAr
	n+gzN1WlSSjDfZ+KVYD2zLUzh+ZRhAV4O0/Z9LZiX71FrJ40yADJe5Wf/GlkdlGHgwPawWltLUXDn
	gYkwFnPVRkyqOmKTt4AArs0/lE6i5ApsQMAdYTZKNjTfVRkGjzc3EUAzruq5/P6JCgxU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w0LO7-00BCSM-MJ; Wed, 11 Mar 2026 16:22:19 +0100
Date: Wed, 11 Mar 2026 16:22:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Naveen Mamindlapalli <naveenm@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Danielle Ratson <danieller@nvidia.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Leon Romanovsky <leon@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 02/11] ethtool: Add loopback netlink UAPI
 definitions
Message-ID: <b3825c0d-02e5-4625-831f-4346ce4eabd2@lunn.ch>
References: <20260310104743.907818-1-bjorn@kernel.org>
 <20260310104743.907818-3-bjorn@kernel.org>
 <580debbb-8f6c-4b60-95ef-22c68480ded1@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <580debbb-8f6c-4b60-95ef-22c68480ded1@bootlin.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17970-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,marvell.com,redhat.com,nvidia.com,bootlin.com,broadcom.com,pengutronix.de,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 19AA926664B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> If we take an example with a 10G PHY, we may have :
> 
> +----SoC-----+
> |            |
> |  MAC       |- drivers/net/ethernet
> |   |        |
> | Base-R PCS |- could be in drivers/net/pcs, or directly
> |   |        | in the MAC driver
> |   |        |
> |  SerDes    |- May be in drivers/phy, maybe handled by firmware,
> |   |        |  maybe by the MAC driver, maybe by the PCS driver ?
> +---|--------+
>     |
>     | 10GBase-R
>     |
> +---|-PHY+
> |   |    |
> | SerDes | \
> |   |    | |
> |  PCS   | |
> |   |    |  > All of that handled by the drivers/net/phy PHY driver
> |  PMA   | |
> |   |    | |
> |  PMD   | /
> +---|----+
>     |
>     v 10GBaseT

We should also keep in mind this is a "simple" PHY. If you have a PHY
which does rate adaptation it looks more like:

+---|-PHY+
|   |    |
| SerDes |
|   |    |
|  PCS   |
|   |    |
|  MAC   |
|   |    |
| packet |
| buffer |
|   |    |
|  MAC   |
|   |    |
|  PCS   |
|   |    |
|  PMA   |
|   |    |
|  PMD   |
+---|----+
    |
    v 10GBaseT

So there is potentially 5 more loopback points?

Jakub proposal had the concept of 'depth'. Maybe we need that to
handle having the same block repeated a few times as you go towards
the media?

We should also think about when we have a PHY acting as a MII
converter. You see the Marvell PHY placed between the MAC and the SFP
cage. That has a collection of blocks which can do loopback. And then
we could have either a Base-T module/PHY in the cage, with more of the
same blocks, or a fibre modules with loopback.

     Andrew

