Return-Path: <linux-rdma+bounces-17967-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFJICzhhsWl/uQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17967-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 13:34:00 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8041D263A59
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 13:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 840823033ABE
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 12:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A592836BE;
	Wed, 11 Mar 2026 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DPVDkpNk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AB9282F06;
	Wed, 11 Mar 2026 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773232350; cv=none; b=D9PJqGqlnrqnTq6LrxeKlVEta869xaTu7dfENFvzRu2/x5W7yjymuWNcKw+TZ2jwNfScN2g0/FHKLgWMiLEVI2+XFylWPQ+s/U14X4s5flxH4tY32pAlVHepB+p/rfmzUHt0y5bbPnGNQX2/Y9BFQrhHND3dS8rTQMM8O17mQ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773232350; c=relaxed/simple;
	bh=EfswtQ+bfQldsFxLnGaOdunxx8Rw0Y2THgR3WeswKu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJ2Rr36o6msBgEpQp/JFijnt87KMExGTdhWLFBTDfCxeG7ysU26wRvs2okmyZluPvX8keyxrINhnoekVLhkHkEFIdNtBHcWFyzkRBXuqKwYdm2gktyrzSuuoDUn/aQVIeKtl6orBq1hGLNU8oRGUVvHmfgc+9lnzX/hCa8yS6+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DPVDkpNk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ud+bU28QEbGjEAThQdp/ZDIa/IK62B0c2KuGhHSSGNI=; b=DPVDkpNkRWuYw0FjHdYNfitYbb
	c2WZw1PNiO9HFQArynNIxMB39IEsOpr5iaUZLNgHJkXXj27dZxBT6/VfdiJKa3+okP8zkDpd6TrD5
	fiFk6IGOAzFD5yHr3RWcp0yq9OFkcfWWqL8mrmyN/0vFvOjRMT4pA8slSdu24raU+dxc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w0IjR-00BB5g-RP; Wed, 11 Mar 2026 13:32:09 +0100
Date: Wed, 11 Mar 2026 13:32:09 +0100
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
Message-ID: <0aa736b4-2c1c-4317-bcc1-1d4c9ad49380@lunn.ch>
References: <20260308124016.3134012-1-bjorn@kernel.org>
 <aa7P7UUUG1p5RVwO@naveenm-PowerEdge-T630>
 <87tsupnjbc.fsf@all.your.base.are.belong.to.us>
 <aa/Jt36h3EuhpPKf@naveenm-PowerEdge-T630>
 <de9f5282-6270-4bb5-b9bf-d80cbc977f14@lunn.ch>
 <abEEuPa3/cThM40a@naveenm-PowerEdge-T630>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abEEuPa3/cThM40a@naveenm-PowerEdge-T630>
X-Rspamd-Queue-Id: 8041D263A59
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17967-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

> > > With a SERDES component, the mapping becomes cleaner:
> > >   component  name         supported
> > >   MAC        mac          near-end
> > >   SERDES     serdes-ned   near-end
> > >   SERDES     serdes-nea   near-end
> > >   SERDES     serdes-fed   far-end
> > 
> > If Linux where to drive the SERDES, what part of Linux would it be?
> > Generic PHY? How does your SERDES hardware block fit into 802.3? Which
> > clause describes it?
> 
> Hi Andrew,
> 
> On OcteonTx2 SoC, the SerDes (GSERM) is a HW block integrated into the
> SoC die. It is not on an MDIO bus or any bus that Linux can enumerate.
> The block is fully managed by the firmware running on the SoC. The NIC
> driver configures it indirectly through firmware mailbox commands.
> 
> The data path looks like:
>   MAC (RPM) --- SerDes (GSERM) --- module/PHY
> 
> In 802.3 terms, the closest match would be PMA. The GSERM handles
> serialization/deserialization and the analog front-end.

A Linux Generic PHY is probably also PMA.

802.3 says very little about SERDES, it is not a well defined term. So
i think we want PCS and PMA, not SERDES as a loopback point.

       Andrew

