Return-Path: <linux-rdma+bounces-17023-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A68Ga0zl2kCvwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17023-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 17:00:45 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A46D3160760
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 17:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35F783011777
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 16:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1162234C802;
	Thu, 19 Feb 2026 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="C61XY+J1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B63A34BA49;
	Thu, 19 Feb 2026 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771516818; cv=none; b=aBW7lHACMvwXxvf8m6SdCokB2jXV9gSIYncXS/snicDSnK5k8Bz5w5JGR0Joq5hT1IKEkHp5cGsrpHEGrlqGwW24vp7R4GsHZhWp6ELFeK5BW0l9uC+ZUjHowiRWWimWEQEE+qB8BJBYk0NtjrYDtVc4vRt+hjQKhKycGP2CZCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771516818; c=relaxed/simple;
	bh=Hof1zE1EM5hEZsMZofuQELn9nB1DN3GqwwbgsrABHGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTDj8C/A457zTjuXwLZHe3ltPQ60Jus3IoBo+y280Q6O06zYUdsYVaUQJc7NZM3zUwYsR3bB39+fcCJ9c+JtnAUlYjCvZqwzKc7N05tXmK7YrDljh4mqAs4wtXPTxQtFuqtA5Yqlte6xRhQ41VevIcYoweazq0DqpVke8+XLfTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=C61XY+J1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GNz+UgohJmtmkQiCPBGRv7QOHwsgNjtEAhXiIcytNy0=; b=C61XY+J1BqEpLrURfi5JzkomIa
	hm0r41Ai0CN4kaeOGSZNLlIs53V6KAVwYBX6VpSHOII5c0cfR9TWG00HtB9IV7CroStu8BzZkzOAd
	PNHJFtfvcVehkKm80nzcS08Vu7KaDiNjl5NTC2UnQvdiXPtJ0bsFEJY2lpmlzjaY4u60=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vt6RZ-007wBo-Qf; Thu, 19 Feb 2026 16:59:57 +0100
Date: Thu, 19 Feb 2026 16:59:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
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
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [RFC net-next 2/4] ethtool: module: Add CMIS loopback GET/SET
 support
Message-ID: <cab8f239-d72c-4071-8584-7e331afd466f@lunn.ch>
References: <20260219130050.2390226-1-bjorn@kernel.org>
 <20260219130050.2390226-3-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219130050.2390226-3-bjorn@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-17023-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch,bootlin.com,broadcom.com,marvell.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A46D3160760
X-Rspamd-Action: no action

> + * struct ethtool_module_loopback_params - module loopback parameters
> + * @caps: The loopback types, %ETHTOOL_MODULE_LOOPBACK_TYPES_*,
> + *	supported by the module.
> + * @enabled: The loopback types, %ETHTOOL_MODULE_LOOPBACK_TYPES_*,
> + *	currently enabled by the module.
> + */
> +struct ethtool_module_loopback_params {
> +	u32 caps;
> +	u32 enabled;

You probably should be using ethtools bitset API for this.

    Andrew

