Return-Path: <linux-rdma+bounces-18076-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QC2wBYp9smkcNAAAu9opvQ
	(envelope-from <linux-rdma+bounces-18076-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 09:47:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2067426F212
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 09:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AAC893020985
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 08:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C891A38AC9C;
	Thu, 12 Mar 2026 08:46:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4418138B135
	for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773305208; cv=none; b=bcsbohbumbzEwDfCVERoNWVkHBpzgS3YjF8FgRxsueZQiuLmbIn9pD7LBJtEbpLTn57s7SHCwxtriCZdb+P+LIgBAGxXCXH/P1PGDsx10yKVCOlNVlJPV+WIr/wqCCRbf784r1IjQexgSrzZvsAx4WmJeH5qahBBqdDVq6w1z+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773305208; c=relaxed/simple;
	bh=/mZilDisdviIicDgh987PANEInYCM0ltIoHh+VCYsYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIgGiZT87HiqcqELI0uU09Uwt2pr6vwLPrprd1JduQ3OqiiU6vbu7Uk/sDh5T8AQj7fhZTe2BZV55ybxEDagifXFUuCkJbh2SNzeRAXXOyGP4A7ojY+cY5IkGLGpAaGRMc752ODABo5AuZI5iNar/KZTR+JlfYHyjXgy5JXskMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1w0bgR-0000cN-2D; Thu, 12 Mar 2026 09:46:19 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1w0bgN-004zeL-0D;
	Thu, 12 Mar 2026 09:46:16 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1w0bgO-0000000FFGc-19Ts;
	Thu, 12 Mar 2026 09:46:16 +0100
Date: Thu, 12 Mar 2026 09:46:16 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
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
Message-ID: <abJ9WAOrOn5qFmwp@pengutronix.de>
References: <20260310104743.907818-1-bjorn@kernel.org>
 <20260310104743.907818-3-bjorn@kernel.org>
 <580debbb-8f6c-4b60-95ef-22c68480ded1@bootlin.com>
 <b3825c0d-02e5-4625-831f-4346ce4eabd2@lunn.ch>
 <085bb0a9-85d3-4d62-9ac4-3461b61da5f3@bootlin.com>
 <438dae03-4dac-4e66-9f4d-e08b0434c9b4@lunn.ch>
 <20260311195052.1202174f@kernel.org>
 <abJJY8whzSOB8O-X@pengutronix.de>
 <ebab1d3e-8967-444b-be54-437e4dfe3c7e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ebab1d3e-8967-444b-be54-437e4dfe3c7e@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,vger.kernel.org,davemloft.net,gmail.com,google.com,marvell.com,redhat.com,nvidia.com,bootlin.com,broadcom.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-18076-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,pengutronix.de:mid,pengutronix.de:url]
X-Rspamd-Queue-Id: 2067426F212
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 08:49:39AM +0100, Maxime Chevallier wrote:
> 
> 
> On 12/03/2026 06:04, Oleksij Rempel wrote:
> > On Wed, Mar 11, 2026 at 07:50:52PM -0700, Jakub Kicinski wrote:
> >> On Wed, 11 Mar 2026 20:26:39 +0100 Andrew Lunn wrote:
> >>>> For that we have what we need with phy_link_topology, as each PHY has
> >>>> its index, we should be good to go in that regard hopefully :)  
> >>>
> >>> So depth would be local to a component? We could have two PHY
> >>> components, each with a different index, and depth = 0?
> >>>
> >>> I _think_ Jakub's depth was more at a global level? But then it would
> >>> need to be passed down as we do the enumeration.
> >>
> >> Oh, sorry, I responded without reading the whole discussion :)
> >> No, I imagined the depth would be within a single component, 
> >> so under control of a single driver (instance). The ordering
> >> between components should be defined by PHY topology etc so
> >> it's outside of the loopback config.
> > 
> > As for me, it is problematic to help the user to understand the datapath
> > depth on a switch. For example:
> > 
> > CPU -- xMII --- MAC1 [loop] --- fabric --- MAC2 [loop] --- xMII -- PHY
> >                                     \----- MACx [loop] ---
> > 
> > ... each port has two xMII loop configurations: towards the xMII or towards
> > the fabric. From a driver perspective, a loop towards the xMII is
> > "remote." However, from a system perspective, a "remote" loop on MAC1 is
> > a local loop at depth=0, whereas a "local" loop on MAC2 is a local loop
> > at depth=1.
> 
> What's important is to specify clearly in the documentation from which
> end do we start, where representing the topology. From your scenario
> here, each block is already well represented and exposed, and if we use
> local depth definitions we should be fine ?

I guess my main problem is to imagine depth representation in two
separate directions for the user. So, the kernel documentation should
describe what is the starting point of view depending on the device
type. For example:
- PHY has typically xMII and MDI end points, so the loop towards the xMII
  is the local loop and towards the MDI is the remote loop.
- a switch/bridge has mutiple, application specific end points. So, we
  have a starting point of view from the fabric. Every loop pointing from
  the fabric towards the outside world of the switch is the remote loop,
  independent on connection type (xMII or MDI).

Correct?

> > Other example would be where we have a chain of components which are
> > attached on the system in a unexpected direction, where the MDI
> > interface is pointing towards the main CPU, so the remote loopbacks
> > became to local loop.
> 
> I have a few of these types of setup on my desk, where 3 PHY devices are
> daisy-chained, we don't support that for now. If we one day add support
> for standalone PHYs acting as media converters, I expect we'll be able
> to tell which end is pointing where, and let it up to the user to figure
> out what "remote" and "local" means in that case.
> 
> > 
> > One more issue is the test data generator location. The data generator
> > is not always the CPU. We have HW generators located in components like
> > PHYs or we may use external source (remote loopback).
> 
> There were discussions about PRBS, I think the same idea of "pinpointing
> which block we want to use" can be applied for both loopback and
> generation ?

Yes, the same apply for the counters. If we represent the data path as
pipe with different components like loopbacks, PRBS, etc on different
stages of the pipe, the same we have with counters. For example
industrial or automotive PHYs have separate counters for xMII and MDI.
A low depth loopback would not triggers some of counters.

Since I do not wont push all of this right now, i suggest to use more
abstract topology representation to make it easily extendable. 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

