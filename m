Return-Path: <linux-rdma+bounces-17058-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id teKRG/1knGmTFwQAu9opvQ
	(envelope-from <linux-rdma+bounces-17058-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 15:32:29 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F210017808C
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 15:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5F2B3055C44
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 14:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B2C28DF07;
	Mon, 23 Feb 2026 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3U3onoif"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9711E51E0;
	Mon, 23 Feb 2026 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771857063; cv=none; b=YO4hxvXVHlEIe+6UWU0yQMxbqSuw3Yqm3THmjaFJxZGgAK5ZAKNy0X2M36FKBqCQF+L53aNybToyUak6L9dPpiIFe5daOSLqy89M2HVi5sTSvoJWKGhCzFDYjPOH0qgAUq1VX0gzc9JnATQc1R00coiUBjnAZkaZQweLiBaM66Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771857063; c=relaxed/simple;
	bh=VLy7TFD8x+kVjQ8t/75GMC+XCfY9RhPBY9H5xGVc+PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jm5yDF4wDa3XCw/gwFzBZopZCe+d+Pvrehl93iUDOjBEr4lK0aJTaGlW4UxevDVl1YOiohzHKzRnbjBOXTgTOGfAt2iWh3/w0bvJjCM5WTTv3PlcR+RIFWU9l5A7OjHB4l9zAO04tq0S6AQjPPMNkuEWmB+js46GTxwv3ap69Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3U3onoif; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DsdjXdYOs4MYnI7eToMLE3q95higvKJA+OmON/SLWh8=; b=3U3onoifXy+eUTppbOL1FHeGcM
	1axoztlqOK0CBXmcQ00DcoBmUe6wHx4/WVT9ppP6WvlQAT8MwFS655uO2grMp9T+WvHtI2PeNetgo
	uUiPi4IlT7HlbH3UcI2zDo3Fvke4v1qZqmbZh+Zl3puYg9DuuXx2Sct2uxAmhi08hcOg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vuWxV-008TB1-NX; Mon, 23 Feb 2026 15:30:49 +0100
Date: Mon, 23 Feb 2026 15:30:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
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
Subject: Re: [RFC net-next 0/4] ethtool: CMIS module diagnostic loopback
 support
Message-ID: <74ff32e0-f883-40d4-be89-3276dc26cf0d@lunn.ch>
References: <20260219130050.2390226-1-bjorn@kernel.org>
 <415c4922-cc8d-4e35-bbac-3a532f44d238@lunn.ch>
 <20260219160519.323041bf@kernel.org>
 <3b0949fa-0b05-4bce-86c0-2a7a058865a5@lunn.ch>
 <20260220131254.03874c4c@kernel.org>
 <CAJ+HfNgXqpqDYsmAa-mpHnO82aDgC7XbyVw3TmXk-ySFmGA-JQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+HfNgXqpqDYsmAa-mpHnO82aDgC7XbyVw3TmXk-ySFmGA-JQ@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-17058-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch,bootlin.com,broadcom.com,marvell.com];
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
X-Rspamd-Queue-Id: F210017808C
X-Rspamd-Action: no action

> /* Loopback Direction (XXX is local/remote easier to understand?) */
> enum ethtool_loopback_dir {
>     ETHTOOL_LB_DIR_NEAR_END = 0,    /* Host -> Loop -> Host  */
>     ETHTOOL_LB_DIR_FAR_END,        /* Line -> Loop -> Line  */
> };

I like host->loop->host, it is much clearer than NEAR_END or
FAR_END. Where there is space, would use this description, even if it
is a bit verbose.

> struct ethtool_loopback_layer_cfg {
>     enum ethtool_loopback_layer layer;    /* ETHTOOL_LB_L_MAC, etc. */
>     enum ethtool_loopback_dir direction;  /* NEAR or FAR */
>     u32 lane_mask;                        /* Specific lanes */
>     u32  flags;                           /* patterns? reserved... */
>     bool enabled;
>     char name[16];

What would name be used for. I don't see it in your example. The nice
thing about netlink messages is that they are extendable, unlike
system calls. If there is no current use for a field, don't add it. It
can be added later when actually needed. So i would drop flags and
name.

Does CMIS, when used with a splitter cable, allow you to set loopback
on lanes? What is your use case for lane_mask?

> };
> 
> struct ethtool_loopback_cfg {
>     struct ethtool_loopback_layer_cfg *entries;
>     u32 num_layers;

What is num_layers used for?

> };
> 
> struct ethtool_ops {
>     /* ... */
> 
>     /* Query which layers/lane-combos are physically possible */
>     int (*get_loopback_caps)(struct net_device *dev,
>                              struct ethtool_loopback_cfg *caps);
> 
>     /* Get current active status for all layers */
>     int (*get_loopback_state)(struct net_device *dev,
>                               struct ethtool_loopback_cfg *state);
> 
>     /* Set one or more layer/lane configurations atomically */
>     int (*set_loopback)(struct net_device *dev,
>                         const struct ethtool_loopback_cfg *cfg,
>                         struct netlink_ext_ack *extack);
> };
> 
> As for layers; EXT vs PMD? EXT could be a loopback plug, whereas PMD
> would be CMIS, or whatever the driver detects.
> 
> Userland would be something like:
> 
> # ethtool --show-loopback eth0
> Loopback Status for eth0:
>   Layer: SW  | State: OFF
>   Layer: MAC   | State: OFF
>   Layer: PMA   | State: ON  | Lanes: 0x1 (Lane 0) | Direction: Near-End (Local)
>   Layer: PMD   | State: ON  | Lanes: 0xF (All)    | Direction: Far-End (Remote)

ETHTOOL_LINK_MODE_800000baseKR8_Full_BIT has 8 lanes, so 0xff would be
All in this case. Lanes adds quite a bit of complexity. Do we have a
real use case for it?

>   Layer: EXT   | State: ON  | Detected: External Loopback Plug
> 
> # ethtool --set-loopback <dev> [layer[:lanes][:direction]] ... [off]
> 
> # # Simple MAC loopback:
> # ethtool --set-loopback eth0 mac (Defaults: lanes=all, dir=near)
> # # Specific SerDes (PMA) lane:
> # ethtool --set-loopback eth0 pma:lane0
> # # Complex multi-layer (PMA Near + PMD Far):
> # ethtool --set-loopback eth0 pma:0x1:near pmd:all:far

Is this something we actually want? Again it adds complexity,
especially in the error handling, when pma:0x1:near works, but
pmd:all:far fails, and you need to unwind the pma:0x1:near. Is there a
use case for atomically setting two loopbacks, rather than having the
user make two different calls?

> # # Disable all loopbacks:
> ethtool --set-loopback eth0 off
> 
> Thoughts? Is this somewhat close to what you had in mind, Andrew?

I'm happy with the basic shape of this. I just needs the details
nailing down.

    Andrew

