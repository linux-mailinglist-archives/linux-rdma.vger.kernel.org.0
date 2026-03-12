Return-Path: <linux-rdma+bounces-18058-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNvnLhMqsmleJQAAu9opvQ
	(envelope-from <linux-rdma+bounces-18058-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 03:50:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5658926C743
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 03:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C1E03008C18
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 02:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F6B382385;
	Thu, 12 Mar 2026 02:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+cK7ckP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784CD38229D;
	Thu, 12 Mar 2026 02:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773283855; cv=none; b=XAi/7bKrRwYZYwtGPDJzyywaxnNWgEQVn2PVBCvgp5KgjVJU2ohMi3jBLEPknIGc0lhQctEIe9gA3s+TTzGgfFI3PEs7YFOu1WUndGqJ/gBhE0Acfd9AN+9qarDDoQCinX4p/DGJgySTirNSYNJKcnzAmw7w/iGO5wDJVpWxHiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773283855; c=relaxed/simple;
	bh=7mGPCSMXUpoxC0Kcp76fViZTxvoAMqIrNUhS6so+8nA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S7eNGxFY7GuEQE2Ns1vko98XcSORvCtXmICuV33aA/1tI9SexFHmUtJU3ref5x8bRxphl4A9ZP0WKGPEiIxXMLWRl7j/GdvW5kh4hky42L5akpAsynKUQ+SqvKjPzrgUsZ5dyb7ZD0sIIaqpJNMQE1GLOw9JESaHfjQYoBErAcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+cK7ckP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DE4C4CEF7;
	Thu, 12 Mar 2026 02:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773283855;
	bh=7mGPCSMXUpoxC0Kcp76fViZTxvoAMqIrNUhS6so+8nA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i+cK7ckPpFbBhlaMH2FelpZRGeCVT7YvuSMNk5XFKYauBtEqwZiqZUsfFfEAUPlFH
	 N4kNEE1qOQD4amd/9Dj3qBe/DVcJGhfsX9Jj1Z2uNBZRJV0pyIv2PViNakdzVOq8P8
	 okOSGBv1VjAEnWMLgh+ROhdSd3C5I21VVeTVT/TKm6BwUL+wzyvYI9EzDtIoIeiX0d
	 KBKfpiVyDisKfpkRJOTAz4GTsWkoGWopM1YkVXwNACcz0xg9UbPOFJ/m4fqoy5euM5
	 hNT6ra1CkxW+Hy2IxPfH/3WviIqQOyrzS2+Lx/hIxmoTNvhoxS8ynZ9Ghq4eWkESe/
	 KAsgX+APR7wPA==
Date: Wed, 11 Mar 2026 19:50:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, =?UTF-8?B?QmrDtnJu?=
 =?UTF-8?B?IFTDtnBlbA==?= <bjorn@kernel.org>, netdev@vger.kernel.org, "David
 S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Naveen Mamindlapalli <naveenm@marvell.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Danielle Ratson
 <danieller@nvidia.com>, Hariprasad Kelam <hkelam@marvell.com>, Ido Schimmel
 <idosch@nvidia.com>, Kory Maincent <kory.maincent@bootlin.com>, Leon
 Romanovsky <leon@kernel.org>, Michael Chan <michael.chan@broadcom.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>, Russell King <linux@armlinux.org.uk>, Saeed
 Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>, Tariq Toukan
 <tariqt@nvidia.com>, Willem de Bruijn <willemb@google.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 02/11] ethtool: Add loopback netlink UAPI
 definitions
Message-ID: <20260311195052.1202174f@kernel.org>
In-Reply-To: <438dae03-4dac-4e66-9f4d-e08b0434c9b4@lunn.ch>
References: <20260310104743.907818-1-bjorn@kernel.org>
	<20260310104743.907818-3-bjorn@kernel.org>
	<580debbb-8f6c-4b60-95ef-22c68480ded1@bootlin.com>
	<b3825c0d-02e5-4625-831f-4346ce4eabd2@lunn.ch>
	<085bb0a9-85d3-4d62-9ac4-3461b61da5f3@bootlin.com>
	<438dae03-4dac-4e66-9f4d-e08b0434c9b4@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18058-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[bootlin.com,kernel.org,vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,marvell.com,redhat.com,nvidia.com,broadcom.com,pengutronix.de,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5658926C743
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 11 Mar 2026 20:26:39 +0100 Andrew Lunn wrote:
> > For that we have what we need with phy_link_topology, as each PHY has
> > its index, we should be good to go in that regard hopefully :)  
> 
> So depth would be local to a component? We could have two PHY
> components, each with a different index, and depth = 0?
> 
> I _think_ Jakub's depth was more at a global level? But then it would
> need to be passed down as we do the enumeration.

Oh, sorry, I responded without reading the whole discussion :)
No, I imagined the depth would be within a single component, 
so under control of a single driver (instance). The ordering
between components should be defined by PHY topology etc so
it's outside of the loopback config.

