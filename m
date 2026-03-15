Return-Path: <linux-rdma+bounces-18167-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Iy+KhPMtmlyIwEAu9opvQ
	(envelope-from <linux-rdma+bounces-18167-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Mar 2026 16:11:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2EF291255
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Mar 2026 16:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEA043025292
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Mar 2026 15:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2EE36F438;
	Sun, 15 Mar 2026 15:10:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A27D370D7B
	for <linux-rdma@vger.kernel.org>; Sun, 15 Mar 2026 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773587428; cv=none; b=cvvNzKesSbfsibJHSoxwWw8FZUu+YIkiquEe7TQeTaGd9Kqyb0RuipWVXReuWH1DQJg05c61hhbWWTaPDkIfZsww9QpUTKwDvORqNGLv8h3GkroRlVwdCN9Tc+WueNZo4RWPGPOqKEc5YVqc22DYmzNAYPUmHNmvko1duozIl+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773587428; c=relaxed/simple;
	bh=Qa1V7r4AhB22UlPVP7Mo0d/+CLYO6p016uQvDzPsgKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIRPWjDn5E5I9KtzhvYzPeMqqRcG+Kk8b5lajJSb44BFS2IZkpC4smiDKgKfl8MzwhiWaVa+g9glJq+K3lv9HwjountmxPAPlZPtzLACEGA52FRPDkJ2etHxSwkcRWPKAmnWAiWBMQhaf1DMZiK39xAOfg0WdjECPyiXVMQhUbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1w1n6E-0003EN-Ou; Sun, 15 Mar 2026 16:09:50 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1w1n6B-000QDS-3A;
	Sun, 15 Mar 2026 16:09:47 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1w1n6B-00000003djm-3O4a;
	Sun, 15 Mar 2026 16:09:47 +0100
Date: Sun, 15 Mar 2026 16:09:47 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
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
Message-ID: <abbLu-OjngRjcc09@pengutronix.de>
References: <20260310104743.907818-3-bjorn@kernel.org>
 <580debbb-8f6c-4b60-95ef-22c68480ded1@bootlin.com>
 <b3825c0d-02e5-4625-831f-4346ce4eabd2@lunn.ch>
 <085bb0a9-85d3-4d62-9ac4-3461b61da5f3@bootlin.com>
 <438dae03-4dac-4e66-9f4d-e08b0434c9b4@lunn.ch>
 <20260311195052.1202174f@kernel.org>
 <abJJY8whzSOB8O-X@pengutronix.de>
 <7c45ebf6-0cb2-4a4c-ac12-f4f9bb59c908@lunn.ch>
 <42abf88e-4fbf-4966-9490-8315f118ddea@bootlin.com>
 <873423y27k.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <873423y27k.fsf@all.your.base.are.belong.to.us>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rdma@vger.kernel.org
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bootlin.com,lunn.ch,kernel.org,vger.kernel.org,davemloft.net,gmail.com,google.com,marvell.com,redhat.com,nvidia.com,broadcom.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-18167-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,pengutronix.de:mid,pengutronix.de:url]
X-Rspamd-Queue-Id: 0C2EF291255
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Björn,

On Fri, Mar 13, 2026 at 08:11:11PM +0100, Björn Töpel wrote:
> Folks, thanks for the elaborate discussion (accidental complexity vs
> essential complexity comes to mind...)!

Sorry for overthinking :)

> Maxime Chevallier <maxime.chevallier@bootlin.com> writes:
> 
> > Hi Andrew,
> >
> >>> One more issue is the test data generator location. The data generator
> >>> is not always the CPU. We have HW generators located in components like
> >>> PHYs or we may use external source (remote loopback).
> >> 
> >> At the moment, we don't have a Linux model for such generators. There
> >> is interest in them, but nobody has actually stepped up and proposed
> >> anything. I do see there is an intersect, we need to be able to
> >> represent them in the topology, and know which way they are pointing,
> >> but i don't think they have a direct influence on loopback.
> >
> > If I'm following Oleksij, the idea would be to have on one side the
> > ability to "dump" the link topology with a finer granularity so that we
> > can see all the different blocks (pcs, pma, pmd, etc.), how they are
> > chained together and who's driving them (MAC, PHY (+ phy_index), module,
> > etc.), and on another side commands to configure loopback on them, with
> > the ability to also configure traffic generators in the future, gather
> > stats, etc.
> >
> > Another can of worms for sure, and probably too much for what Björn is
> > trying to achieve. It's hard to say if this is overkill or not, there's
> > interest in that for sure, but also quite a lot of work to do...
> 
> It's great to have these discussion as input to the first (minimal!)
> series, so we can extend/build on it later.
> 
> If I try to make sense of the above discussions...
> 
> Rough agreement on:
> 
>  - Depth/ordering should be local to a component, not global across the
>    whole path.

ack

>  - Cross-component ordering comes from existing infrastructure (PHY link
>    topology, phy_index).

ack

>  - The current component set (MAC/PHY/MODULE) is reasonable for a first
>    pass.

I do not have strong opinion here. 

>  - HW traffic generators and full topology dumps are interesting but out
>    of scope for now (Please? ;-)).

It didn't tried to push it here. My point is - image me or may be you,
will need to implement it in the next step. This components will need to
cooperate and user will need to understand the relation and/or topology.

The diagnostic is all about topology.

> So, maybe the next steps are:
> 
>  1. Keep the current component model (MAC/PHY/MODULE) and the
>     NEAR_END/FAR_END direction (naming need to change as Maxime said).

Probably good to document that NEAR_END/FAR_END or local/remote is
related to the viewpoint convention. Otherwise it will get confusing
with components which mount in a unusual direction (embedded worlds is
full of it :))

>  2. Add a depth (or order?) field to ETHTOOL_A_LOOPBACK_ENTRY as Jakub
>     suggested, local to each component instance. This addresses the
>     "multiple loopback points within one MAC" case without requiring a
>     global ordering. I hope it addresses what Oleksij's switch example
>     needs (multiple local loops at different depths within one
>     component) *insert that screaming emoji*.

ack. I guess "depth" fits to the "viewpoint" terminology.

>  3. Document the viewpoint convention clearly.

ack

>  4. Punt on the grand topology dump. Too much to chew.

ack

>  5. Don't worry about DSA CPU ports - they don't have a netif, so
>     loopback doesn't apply there today. If someone adds netifs for CPU
>     ports later, depth handles it.

ack

> TL;DR: Add depth, document the viewpoint convention, and ship
> it^W^Winterate.
> 
> Did I get that right?

I'm ok with it, but maintainers will have the last word.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

