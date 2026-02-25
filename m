Return-Path: <linux-rdma+bounces-17157-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Cs7Icv2nmm+YAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17157-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 14:19:07 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0FB197E76
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 14:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F17E30E3817
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 13:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0723B8D57;
	Wed, 25 Feb 2026 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rIrXY/aq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF6E3806AD;
	Wed, 25 Feb 2026 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772025287; cv=none; b=nK/RTjUIsANYCRcU/XvJ+xC+bKyNbx4ihl8lPA1M8wdGfoKqTX36oYdsvOH9gZbdGebwPj93m0cHuHBVZaHGd0Jz5asafN7hMHHqdXn+nXmJn0md4fW2GBXDxWuIK9BzQk+g+l7gMZnSj1cjkn1Z1cs7QRXoLwbclkvkc2D7F8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772025287; c=relaxed/simple;
	bh=aTvApzSmhsx3i8f6A4J1xSCz6d2Ep/DfaFoz7BBAfN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/b661h7VacVBwWdYxX6dOVHn6APn3XcBoRU2iaKvrivMcrPXt0p3jTLhZwEUzzYs5a7x6ZhL8Pf+kQ59rvgpTBChwvqXTzKKpIHL+i/abdjCKAAv875ectIDT5bGedNsvZ29SqqfIhJg1a5RCZnh2KGcGksy0UvSJOV++cWTqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rIrXY/aq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=V1+Ntv+RUqoddPpGOqsWbuLmZ4rXolW+1kYjHHyQJzY=; b=rIrXY/aq+6BksWJBBA3WXmD9lI
	uuvdT9vo5+lvU00C94EZYe9GKB7C7ALFmb1FK1gkhwlPTV3cFxppocaAi/B414Ycl5zOnFY7Q3UEH
	1f/V/fLY0SFgtaC5gF9ovntT5nZwDBVbDbesZ03yoaCXeXASJtsRCvHed3Nc3FDKZ/88=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vvEil-008kJi-RH; Wed, 25 Feb 2026 14:14:31 +0100
Date: Wed, 25 Feb 2026 14:14:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Michael Chan <michael.chan@broadcom.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [RFC net-next 0/4] ethtool: CMIS module diagnostic loopback
 support
Message-ID: <4c51f18c-5eb1-4a9e-93b9-70cf7a4fd387@lunn.ch>
References: <20260219130050.2390226-1-bjorn@kernel.org>
 <415c4922-cc8d-4e35-bbac-3a532f44d238@lunn.ch>
 <20260219160519.323041bf@kernel.org>
 <3b0949fa-0b05-4bce-86c0-2a7a058865a5@lunn.ch>
 <20260220131254.03874c4c@kernel.org>
 <CAJ+HfNgXqpqDYsmAa-mpHnO82aDgC7XbyVw3TmXk-ySFmGA-JQ@mail.gmail.com>
 <20260223150401.7993b11a@kernel.org>
 <CAJ+HfNjmRjr6VtRijmN9=4zPwxstw9B8D-_XVn3hwJzNHka1Jw@mail.gmail.com>
 <363527d6-1f29-4399-83a7-978785d1e11f@lunn.ch>
 <CAJ+HfNhwM82H-sgbz0+WJGRjXJc8Ww0aCnp_YTNi-CB4aBMi=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+HfNhwM82H-sgbz0+WJGRjXJc8Ww0aCnp_YTNi-CB4aBMi=w@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17157-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,bootlin.com,vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch,broadcom.com,marvell.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED0FB197E76
X-Rspamd-Action: no action

> > Suddenly does something else.
> 
> Indeed!
> 
> > Is this an ABI break? How do we make this reliable so implementing
> > more loopbacks at different levels does not change how you use
> > --set-loopback?
> 
> Isn't this somewhat similar to what we have with ifindex/phy_index,
> but potentially unstable when modules are swapped/changed?

If you hot plug hardware, a new PHY pops into existence, i don't think
it is too unreasonable for the hot plugable parts to change ids. I
would however expect the fixed parts to keep there IDs.

But here we are talking about software, a kernel upgrade/downgrade
causing the IDs to change.
 
> Instead of ids, use string name and/or topology indices (e.g.
> phy_index)? All three -- owner, phy_index, name tuple?

Probably.

	Andrew

