Return-Path: <linux-rdma+bounces-17028-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBQeCEmll2ns4AIAu9opvQ
	(envelope-from <linux-rdma+bounces-17028-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Feb 2026 01:05:29 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0FD163C7C
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Feb 2026 01:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A8D4300A7CA
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Feb 2026 00:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5778D9460;
	Fri, 20 Feb 2026 00:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUAcO3n6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1221E632;
	Fri, 20 Feb 2026 00:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771545922; cv=none; b=eSnuWj8inwd40mJtvOfE8uyqIsNuK4rri3Muw2SeTgKuMVUxeOmD9kS/PIvcQngTC6KhI9Bs2SqsiH62hhZ7LUORJk4YUpcp3RvK0EOOoBHy2cvR0ilPHUptaUmNiRSLyJiqTGdq1RcjkrveLa3vFkLjb9ZA/SDt52fMxPJawpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771545922; c=relaxed/simple;
	bh=SkTrMj4eXt3nTVo9h0OBB3gwiLBGTaCMvYNhKAmia7o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KpAjtSXKkmKX73tmq3R63Q76VTiH0ZABZBLWNHdZVaNU+U+pOjoh/mpowC/QOAlKO0NAXJ1PtKzfmDh09HtFbTgkDuZjJwTldx5iQ/3dV8jUyKtuWTiGYOM5+ii0Hwou7RSza26Knz0j/OraNyu6i43YXNFAKFNKHDzswv/GyH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUAcO3n6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B91C4CEF7;
	Fri, 20 Feb 2026 00:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771545921;
	bh=SkTrMj4eXt3nTVo9h0OBB3gwiLBGTaCMvYNhKAmia7o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XUAcO3n62KXOBpFIGD90VFCRelrza4tLdN+GoOumLa4B9uimvXV6diAm4DnOr982N
	 EUdZ4ZWhGXGZzRdqQMirGtvRKqKfsPTdO34F2TRMZVuSuqHkPMuQ5rzMiNZom1Eylx
	 HQtynJbRELSNhyV9DEStrQ4NFLVvbUgwgnxReRHz0kbEz39ogDquuNKr3DGumDRB9T
	 6dyoPt1bLqHXhYRjFiZVQ64e+Qx4gRvRDHU5Lzt+lvUlOdpWl99En0keP1SgcI6TNP
	 b37UrdBAUyXgYhiEYQjTa8LrvC5SnExBlkRjVzSKrXzY0m9mK2Qd2uCdMRK9D75Azj
	 78lM+8IvDiFeQ==
Date: Thu, 19 Feb 2026 16:05:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Saeed Mahameed
 <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Michael Chan <michael.chan@broadcom.com>,
 Hariprasad Kelam <hkelam@marvell.com>, Ido Schimmel <idosch@nvidia.com>,
 Danielle Ratson <danieller@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
Subject: Re: [RFC net-next 0/4] ethtool: CMIS module diagnostic loopback
 support
Message-ID: <20260219160519.323041bf@kernel.org>
In-Reply-To: <415c4922-cc8d-4e35-bbac-3a532f44d238@lunn.ch>
References: <20260219130050.2390226-1-bjorn@kernel.org>
	<415c4922-cc8d-4e35-bbac-3a532f44d238@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17028-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch,bootlin.com,broadcom.com,marvell.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8D0FD163C7C
X-Rspamd-Action: no action

On Thu, 19 Feb 2026 16:51:47 +0100 Andrew Lunn wrote:
> > We might want to take a step back and think about loopback some more.
> >
> > Loopback can be done at a number of points in the device(s). Some
> > Marvell PHYs can do loopback in the PHY PCS layer. Some devices also
> > support loopback in the PHY SERDES layer. I've not seen it for Marvell
> > devices, but maybe some PHYs allow loopback much closer to the line?
> > And i expect some MAC PCS allow loopback.
> > 
> > So when talking about loopback, we might also want to include the
> > concept of where the loopback occurs, and maybe it needs to be a NIC
> > wide concept, not a PHY concept?  
> 
> I still think this is true. We want a generic kAPI for loopback, not a
> PHY loopback kAPI, and a MAC loopback kAPI, a PCS loopback kAPI, and
> an SFP loopback kAPI, and a CAN bus transceiver loopback kAPI,
> assuming CAN bus supports loopback?
> 
> So i think we need one ethtool API for loopback. We probably want an
> API call to enumerate what loopbacks are supported for a netdev. The
> MAC will fill in bits indicating what it can do. If the MAC has a PCS,
> it will ask the PCS what it can do. If there is a PHY, it will ask the
> PHY to fill in the bits indicating what it can do, if there is an SFP,
> it will ask it what it can do, and if there is a CAN bus transceiver,
> it will fill in its bits. And we probably want two values for each
> loopback location, is it looping the media side, or the MAC side?
> 
> So the return value lists all the different loopbacks associated to a
> netdev.
> 
> And then we need a set operation, to enable/disable a specific
> loopback, and a get operation to return the status of all the
> different loopbacks of a netdev. The MAC will again need to call into
> the PCS, the PHY, the SFP to implement these.
> 
> I'm not saying you need to implement all these, you just need to make
> what you do implement generic, and plumb it through the network stack
> so that others can later easily add PHY, PCS, and MAC loopback
> support. And from your background research, you know others are
> interested in this, so you might be able get some help with parts you
> are not particularly interested in.

Something like:

  struct {
     enum type;   // MAC, PHY, SFP
     int type_id; // if type=PHY - phy id
     int depth;   // counting from CPU, first loopback opportunity is 1
                  // second is 2, etc.
     bool direction; // towards CPU/host vs towards network
     char name[16];  // "pcs", "far", "near", "post-fec", whatever
  }

?

