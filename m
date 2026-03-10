Return-Path: <linux-rdma+bounces-17874-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPNNMKcosGn/ggIAu9opvQ
	(envelope-from <linux-rdma+bounces-17874-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 15:20:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 650A2251C2C
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 15:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3FF1130A04F7
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 14:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152F438D6B5;
	Tue, 10 Mar 2026 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sXCRWIRH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784AF38A719;
	Tue, 10 Mar 2026 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773151229; cv=none; b=MiocItg8WXHC570lji1sV1rhx/P8In+eLWY5L5JIXVt392y/EkvtYhlpJ+uFyDh3f8FZCrkZopmSWAyZ9QbLe+tnAbK91CSbSow9punXrNgf99N4A/ge56Blit3/NH//icRAZGBgFa6XVQdvo1X08s+igPeCDZDBw71OjB9xn1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773151229; c=relaxed/simple;
	bh=c13Ob5An2Z5jZg04NEZ5/Qxh95gomzo6F3s+20mTp+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fn0HHeAvr9qJBQXAn0j+zyW9wUGtJR1N0C1v8osDIdAa9Gr88GH4U+7ZdgwrMeogXQzD084VvB4sqJuH8SrBeacBpRJAcSfsnD8XZdMpuA1KTOJlAKxZrlnEbrWtm1ln0xiIWuZLL0PjDQyjOW3fhwwRLrYraS+sURknDHG1UTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sXCRWIRH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EeHd/ZybSY2zgGCEtcHa35o3a0Fm3fDG9nqlIyLDHXY=; b=sXCRWIRH3qfLpY6/9mGx0a5/Hx
	LvUmAIBn4LGkvuorqZ+saw5eOsK6UMKrNWhSGpPZZ6c4OihYBUXFOPWnkjy/MN3XbXI1ow5Vy7HZw
	Ej3ch/eAx7MryxeDDn5iDq8PCfDcDkLFTOQZFF5Gdp38yNA9b41Uhn0rGzcTjhY/d7Uc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vzxd8-00B2Gi-J2; Tue, 10 Mar 2026 15:00:14 +0100
Date: Tue, 10 Mar 2026 15:00:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Naveen Mamindlapalli <naveenm@marvell.com>
Cc: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [RFC net-next v2 0/6] ethtool: Generic loopback support
Message-ID: <de9f5282-6270-4bb5-b9bf-d80cbc977f14@lunn.ch>
References: <20260308124016.3134012-1-bjorn@kernel.org>
 <aa7P7UUUG1p5RVwO@naveenm-PowerEdge-T630>
 <87tsupnjbc.fsf@all.your.base.are.belong.to.us>
 <aa/Jt36h3EuhpPKf@naveenm-PowerEdge-T630>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa/Jt36h3EuhpPKf@naveenm-PowerEdge-T630>
X-Rspamd-Queue-Id: 650A2251C2C
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
	TAGGED_FROM(0.00)[bounces-17874-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch,bootlin.com,broadcom.com,marvell.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Action: no action

> > > Since the GSERM is not a phylib phy_device, both the MAC PCS
> > > loopback and the SerDes loopbacks fall under the MAC component
> > > in your model.
> > >
> > > Mapped to the v2 model:
> > >   component  name         supported    description
> > >   MAC        mac          near-end     PCS-level loopback
> > >   MAC        serdes-ned   near-end     digital only
> > >   MAC        serdes-nea   near-end     analog
> > >   MAC        serdes-fed   far-end      line-side
> > >
> > > The SerDes NED and NEA both have the same (component, direction).
> > > Both are (MAC, near-end) -- but exercise fundamentally different
> > > hardware paths. The name field distinguishes them as per your model,
> > 
> > Ok! ...and MAC+serdes makes sense from your PoV? Or do we need a new
> > component "SERDES" (as Maxime points out in another reply)?
> > 
> 
> In my earlier comment I mapped the SerDes loopbacks under the MAC
> component to fit the current model, but a separate SERDES component
> as Maxime suggests would be a better fit for our hardware.
> 
> On OcteonTX2 SoC, MAC (PCS) and SerDes are separate hardware blocks.
> Each block has its own loopback controls.
> 
> With a SERDES component, the mapping becomes cleaner:
>   component  name         supported
>   MAC        mac          near-end
>   SERDES     serdes-ned   near-end
>   SERDES     serdes-nea   near-end
>   SERDES     serdes-fed   far-end

If Linux where to drive the SERDES, what part of Linux would it be?
Generic PHY? How does your SERDES hardware block fit into 802.3? Which
clause describes it?

Thanks
	Andrew

