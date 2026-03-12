Return-Path: <linux-rdma+bounces-18106-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJESGP7CsmmvPAAAu9opvQ
	(envelope-from <linux-rdma+bounces-18106-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 14:43:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60073272CD4
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 14:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8FCE301D48B
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 13:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE61344DBB;
	Thu, 12 Mar 2026 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3jPm94Rg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C2B1C8634;
	Thu, 12 Mar 2026 13:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773322503; cv=none; b=tMZqZezfwrhneWRMNZn+ap84BjR1o98E5taJSvhtFnXY/tImrle5IQEyp9mdCSLDXJPdF0HuM6+HtPm781YLvWowUK2FiLMBOlhxHC1PqpsT95MlBFU5FXg5H9fNc0fsH86DXoAh+V8iTyWcfdb6slrIECHkz4gxg8qVl3aiu8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773322503; c=relaxed/simple;
	bh=abUO5NxF+XyImsBCdfcJFCjnpcuM6MiArBEb0D0izAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUbLrs7/lIFPvQmObH3kEZQHVFnSYxI/tIy9EZO3yyAp09JORDFEcUlyv06WADVRfXY4bSzQ4fqDAaOSDkJXoxk50bPx3B4p/EfbsrltAXBG/qmhM8/xWrhobDlCyFoiJFLQJPZko/AMg8ksoH5VU/z1Q8SyU2qOOkTc66082+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3jPm94Rg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WeaIxKlII6s69sFLceD62Bw+/hchaQ0a2WTMKr2AUsU=; b=3jPm94Rg6Q6mQijMM2I9JcR1hR
	Is3f1RVkc8PlP9kB2MAORWFxAV8iqvJQ7kb+nzfgBVgyJPrD+W4Tm8dzzja/7pWS/J8U1+mP78SOy
	s2GtJP/i2RQAkOQqPZGezcfHf0jxn1HVJSvTY4Fcw6Du0mWqfa49LIEVxM23XDzEbP28=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w0gBU-00BKJp-8o; Thu, 12 Mar 2026 14:34:40 +0100
Date: Thu, 12 Mar 2026 14:34:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Naveen Mamindlapalli <naveenm@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Danielle Ratson <danieller@nvidia.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Leon Romanovsky <leon@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 02/11] ethtool: Add loopback netlink UAPI
 definitions
Message-ID: <7c45ebf6-0cb2-4a4c-ac12-f4f9bb59c908@lunn.ch>
References: <20260310104743.907818-1-bjorn@kernel.org>
 <20260310104743.907818-3-bjorn@kernel.org>
 <580debbb-8f6c-4b60-95ef-22c68480ded1@bootlin.com>
 <b3825c0d-02e5-4625-831f-4346ce4eabd2@lunn.ch>
 <085bb0a9-85d3-4d62-9ac4-3461b61da5f3@bootlin.com>
 <438dae03-4dac-4e66-9f4d-e08b0434c9b4@lunn.ch>
 <20260311195052.1202174f@kernel.org>
 <abJJY8whzSOB8O-X@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abJJY8whzSOB8O-X@pengutronix.de>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18106-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,bootlin.com,vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,marvell.com,redhat.com,nvidia.com,broadcom.com,armlinux.org.uk];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 60073272CD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> As for me, it is problematic to help the user to understand the datapath
> depth on a switch. For example:

Do you mean Ethernet switch? Or MII switch.

> 
> CPU -- xMII --- MAC1 [loop] --- fabric --- MAC2 [loop] --- xMII -- PHY
>                                     \----- MACx [loop] ---

In DSA, MAC1 is the CPU port of the switch. It is not represented by a
netif. Since there is no netif, you cannot use ethtool on it. So it is
impossible to apply loopback here.

This is one of the oddities of DSA. The CPU port and the conduit
interface on the host are just plumbing to make the setup work. In
terms of networking, they are not important. But sometimes you need to
get into the plumbing to find out why it is blocked up, statistics are
useful, and maybe loopback as well. We have discussed it a few times
that MAC1 should have a netif, but the conclusion is that developers
have a hard enough time with the conduit interface, adding yet another
oddball interface with no real purpose other than diagnostics is gone
to make the confusion even worse.

So i don't think depth is relevant here.

> ... each port has two xMII loop configurations: towards the xMII or towards
> the fabric. From a driver perspective, a loop towards the xMII is
> "remote." However, from a system perspective, a "remote" loop on MAC1 is
> a local loop at depth=0, whereas a "local" loop on MAC2 is a local loop
> at depth=1.

If you think about DSA and the Linux representation, the switch fabric
is not seen at all. All you have are user ports, those going to the
outside world. They act the same as interfaces directly connected to
the SoC. So "remote" and "local" must have the same meaning as an
interface directly connected to the host. And this is true for
switchdev in general, DSA is not special in any way.

> One more issue is the test data generator location. The data generator
> is not always the CPU. We have HW generators located in components like
> PHYs or we may use external source (remote loopback).

At the moment, we don't have a Linux model for such generators. There
is interest in them, but nobody has actually stepped up and proposed
anything. I do see there is an intersect, we need to be able to
represent them in the topology, and know which way they are pointing,
but i don't think they have a direct influence on loopback.

	Andrew

