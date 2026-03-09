Return-Path: <linux-rdma+bounces-17798-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OMQKlP5rmliLAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17798-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 17:46:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0CE23CF79
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 17:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D07DF30101E7
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 16:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9702E238D52;
	Mon,  9 Mar 2026 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Gq0winLa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A663513C9C4;
	Mon,  9 Mar 2026 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074766; cv=none; b=WH27AY94/uUzomF1uy3/d41q14bY8JEDKPHZfloBA+BuyOU+gfFsmwjqfp1poulKCIivui7a3UbzPQsREW/g0kMkPWi1HD3+py/IWr1yzGbpfbCZ41Y/uylsC7+QJLf04iR/t8c6KEcLZzFy6gBacn2paeejrLs7A5lTEY3u8ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074766; c=relaxed/simple;
	bh=uz0zha8XCTRTVYQm7FQvWiVYpi6cE/sWUu1sJ0R6CMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5mnnaFSb1hIGYy2zC59uJW/YdrFR9ZCOkERuX5gWjD4LcUN2r2BEpHd4vwOn7hn8RbPiEZ0n7gyFT15XlUkT68ebk2N0SFaIjrIapFdsLEmOGTqefBr8CX3O1rYuncW7ZQjaLlKvZ8jq0ZxYj5QUa9AsfIRrSrTwoARxuITNyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Gq0winLa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cF6dQ6of8KNTxg6GJU1dTVuc0YFVokfSBivoZuIjv18=; b=Gq0winLaxtVoVDO0ReTdFhguaa
	Faz+Zb+l9KLR5Y7NQ+5CvAjmKyq8C/gy5sXqRSI5wjJY93/vhokm5h8dXJHu7TO4sxkNbJZfJx+MK
	6zB6cNO+Hc+BcDNzXENf1yaFnsYJmNhEIUf6ipM09r4zQFR0H8176WDv97PIbYBCUWM8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vzdjm-00AtRL-BM; Mon, 09 Mar 2026 17:45:46 +0100
Date: Mon, 9 Mar 2026 17:45:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Michael Chan <michael.chan@broadcom.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [RFC net-next v2 1/6] ethtool: Add loopback netlink UAPI
 definitions
Message-ID: <e138acb9-f2ab-4d76-a9b1-fa7299b1260f@lunn.ch>
References: <20260308124016.3134012-1-bjorn@kernel.org>
 <20260308124016.3134012-2-bjorn@kernel.org>
 <456697d6-c0d8-4edf-abd2-85062f4b25ab@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <456697d6-c0d8-4edf-abd2-85062f4b25ab@bootlin.com>
X-Rspamd-Queue-Id: 4F0CE23CF79
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17798-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch,broadcom.com,marvell.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

> > +    doc: |
> > +      Loopback component. Identifies where in the network path the
> > +      loopback is applied.
> > +    entries:
> > +      -
> > +        name: mac
> > +        doc: MAC loopback
> > +      -
> > +        name: pcs
> > +        doc: PCS loopback
> > +      -
> > +        name: phy
> > +        doc: PHY loopback
> > +      -
> > +        name: module
> > +        doc: Pluggable module (e.g. CMIS (Q)SFP) loopback
> 
> Should we also add "serdes" ?

What is the difference between SERDES and PCS?

Maybe we should also make it clear PHY means Ethernet PHY. The Marvell
Generic PHYs have

phy-mvebu-a3700-comphy.c:#define COMPHY_DIG_LOOPBACK_EN		0x23
phy-mvebu-cp110-comphy.c:#define MVEBU_COMPHY_LOOPBACK(n)		(0x88c + (n) * 0x1000)

which suggests it can also do loopback. We don't want PHY meaning two
different things.

And maybe we should comment that a Base-T SFP module which contains an
Ethernet PHY should appear under PHY, not module? When Linux is
driving the PHY, that should just happen. But if it is firmware
driving the PHY in the module, we should make our expectations of the
firmware clear.

	 Andrew

