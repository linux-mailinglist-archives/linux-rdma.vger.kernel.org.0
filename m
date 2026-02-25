Return-Path: <linux-rdma+bounces-17139-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MgSjGLx1nmnhVQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17139-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 05:08:28 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E951917DF
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 05:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 807A83070170
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 04:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A792F26AA93;
	Wed, 25 Feb 2026 04:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1bPPgICD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407F5155C82;
	Wed, 25 Feb 2026 04:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771992311; cv=none; b=LmDMjIJe80yh6ew+OVUWnegPCxHOs8HP3unGFuC3NqFiBlCcKb9nzA5PI582MY+mHRIlqK+V1eJ7w6eFU5jw6DZMY2ru0S+SRczrNEFhiEOVM3mJAmB0/iLEgLi3vVl8bT4vALZwSNNwnMeN4X85L3k5s4NXprZLsUyxZYFkT8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771992311; c=relaxed/simple;
	bh=cJ06q/fw3WsXFPLC/8eTk3S+ejVgOVNOD0S+Vosv5no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tr1L8qyxVa2YUb+PJDzkS8Ru87cXTgfIMwbvFs4aKJeq/CVcifC6l2l3Squ4Ui2o9bBiHB3se+oqRzgbe1sLTxltxAmZ0AMMGrMCd+UkDo4NQRN4eC8WKfkhZMT1wSFGD2u7hgtrdntmQuKAYtKHSSNFhiIEg9bVQbmpqikdXvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1bPPgICD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pZhEe297cSoC17GYSO4i3DL6T2OQvTRjX31WkRiymhg=; b=1bPPgICD9xnF1xHO+OU+8MGOfD
	G9n4GidWslpmUlPXxX7Y25/VKpkdHZBfZjb8BsGrQ1+Lk10BEeQOI/t6YRY/qnALj2JNPaBxI98rt
	Oc3Vyz0MNbaqcbOUslKez4jv1bY7nbG8jhEZBpOtIZZXze70Yuz/hK9mJjgPJZBEuPd0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vv68o-008gtt-0Z; Wed, 25 Feb 2026 05:04:50 +0100
Date: Wed, 25 Feb 2026 05:04:50 +0100
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
Message-ID: <363527d6-1f29-4399-83a7-978785d1e11f@lunn.ch>
References: <20260219130050.2390226-1-bjorn@kernel.org>
 <415c4922-cc8d-4e35-bbac-3a532f44d238@lunn.ch>
 <20260219160519.323041bf@kernel.org>
 <3b0949fa-0b05-4bce-86c0-2a7a058865a5@lunn.ch>
 <20260220131254.03874c4c@kernel.org>
 <CAJ+HfNgXqpqDYsmAa-mpHnO82aDgC7XbyVw3TmXk-ySFmGA-JQ@mail.gmail.com>
 <20260223150401.7993b11a@kernel.org>
 <CAJ+HfNjmRjr6VtRijmN9=4zPwxstw9B8D-_XVn3hwJzNHka1Jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+HfNjmRjr6VtRijmN9=4zPwxstw9B8D-_XVn3hwJzNHka1Jw@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-17139-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,bootlin.com,vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch,broadcom.com,marvell.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 02E951917DF
X-Rspamd-Action: no action

> # ethtool --show-loopback eth0
> Loopback endpoints for eth0:
>   id  owner  depth  direction          name       enabled
>    0  mac       1   host->loop->host   mac        off
>    1  phy       2   host->loop->host   phy-pcs    on
>    2  module    3   line->loop->line   cmis-far   off
> 
> # Enable endpoint 2
> ethtool --set-loopback eth0 id 2 on

We have to be careful about what is ABI here. Initially you plan to
implement module, so you will have:

# ethtool --show-loopback eth0
Loopback endpoints for eth0:
  id  owner  depth  direction          name       enabled
   0  module    1   line->loop->line   cmis-far   off

ethtool --set-loopback eth0 id 0 on

And then somebody implements loopback at the mac:

# ethtool --show-loopback eth0
Loopback endpoints for eth0:
  id  owner  depth  direction          name       enabled
   0  mac       1   host->loop->host   mac        off
   1  module    2   line->loop->line   cmis-far   off

You script doing

ethtool --set-loopback eth0 id 0 on

Suddenly does something else.

Is this an ABI break? How do we make this reliable so implementing
more loopbacks at different levels does not change how you use
--set-loopback?

	Andrew

