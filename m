Return-Path: <linux-rdma+bounces-17964-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLz2KfNKsWlCtAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17964-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 11:58:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 224B1262AA3
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 11:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 935EE319904E
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 10:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90753D47B7;
	Wed, 11 Mar 2026 10:51:49 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B89A2D7D3A
	for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2026 10:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773226309; cv=none; b=PVFz5+/b7dG9kZQxLKbiptdhHXPWMk/wJ9w4uP3aCS7YXuua6oCYAmdEqmF8PFp1lpqBdDHZIMRHVVgWI4uGrRxkGNWS0yWjD3h6A6QC4ulTpxmM51u0YRCclOTEiJC3et+ZD+3Urnba5/fVUCgwu4ljNHKfv98sGVGUqHoVo0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773226309; c=relaxed/simple;
	bh=aIPDFmWpiu2n2j6R0cgXmVexdXwuiIG9at9lCRrofUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHjql8gEdinaJcBTUYQU/QXvST2yN+lUXANmT6p+YLQVQv3CdFnOwhFqtL62CX6tA7Pp38s/o/fCT6nLwxJK+RcFMG44kUpFiKWtawGiQhzGp2t2YvYCdojrMxtEjYHqi0ii4fYbKJq/OIebUMqRNIY4/Ik7Juapiq75lzSjGXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1w0H9O-0004vc-L2; Wed, 11 Mar 2026 11:50:50 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1w0H9K-004qSb-2P;
	Wed, 11 Mar 2026 11:50:48 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1w0H9L-0000000DLHf-44Eu;
	Wed, 11 Mar 2026 11:50:47 +0100
Date: Wed, 11 Mar 2026 11:50:47 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
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
Message-ID: <abFJB6mZc-0qNbrd@pengutronix.de>
References: <20260310104743.907818-1-bjorn@kernel.org>
 <20260310104743.907818-3-bjorn@kernel.org>
 <580debbb-8f6c-4b60-95ef-22c68480ded1@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <580debbb-8f6c-4b60-95ef-22c68480ded1@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rdma@vger.kernel.org
X-Rspamd-Queue-Id: 224B1262AA3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,marvell.com,redhat.com,nvidia.com,bootlin.com,broadcom.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-17964-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.771];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,pengutronix.de:url,pengutronix.de:mid]
X-Rspamd-Action: no action

Hi all,

On Wed, Mar 11, 2026 at 08:33:26AM +0100, Maxime Chevallier wrote:
> Hi again Björn,
> 
> First, thanks for iterating so quick !
> 
> On 10/03/2026 11:47, Björn Töpel wrote:
> > Add the netlink YAML spec and auto-generated UAPI header for a unified
> > loopback interface covering MAC, PCS, PHY, and pluggable module
> > components.
> > 
> > Each loopback point is described by a nested entry attribute
> > containing:
> > 
> >  - component  where in the path (MAC, PCS, PHY, MODULE)
> >  - name       subsystem label, e.g. "cmis-host" or "cmis-media"
> >  - id         optional instance selector (e.g. PHY id, port id)
> >  - supported  bitmask of supported directions
> >  - direction  NEAR_END, FAR_END, or 0 (disabled)
> > 
> > Signed-off-by: Björn Töpel <bjorn@kernel.org>
> > ---
> >  Documentation/netlink/specs/ethtool.yaml      | 123 ++++++++++++++++++
> >  .../uapi/linux/ethtool_netlink_generated.h    |  59 +++++++++
> >  2 files changed, 182 insertions(+)
> > 
> > diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> > index 4707063af3b4..8bd14a3c946a 100644
> > --- a/Documentation/netlink/specs/ethtool.yaml
> > +++ b/Documentation/netlink/specs/ethtool.yaml
> > @@ -211,6 +211,49 @@ definitions:
> >          name: discard
> >          value: 31
> >  
> > +  -
> > +    name: loopback-component
> > +    type: enum
> > +    doc: |
> > +      Loopback component. Identifies where in the network path the
> > +      loopback is applied.
> > +    entries:
> > +      -
> > +        name: mac
> > +        doc: MAC loopback. Loops traffic at the MAC block.
> > +      -
> > +        name: pcs
> > +        doc: |
> > +          PCS loopback. Loops traffic at the PCS sublayer between the
> > +          MAC and the PHY.
> > +      -
> > +        name: phy
> > +        doc: |
> > +          Ethernet PHY loopback. This refers to the Ethernet PHY managed
> > +          by phylib, not generic PHY drivers. A Base-T SFP module
> > +          containing an Ethernet PHY driven by Linux should report
> > +          loopback under this component, not module.
> > +      -
> > +        name: module
> > +        doc: |
> > +          Pluggable module (e.g. CMIS (Q)SFP) loopback. Covers loopback
> > +          modes controlled via module firmware or EEPROM registers. When
> > +          Linux drives an Ethernet PHY inside the module via phylib, use
> > +          the phy component instead.
> 
> So to get back on Andrew's remarks, let's see if we can get something
> closer to 802.3.
> 
> Here, we have loopback at various locations, which all depends on the
> Ethernet standard you use.
> 
> It's usually in the PCS, PMA or PMD components. Thing is, we may have
> these in multiple places in our link.
> 
> If we take an example with a 10G PHY, we may have :
> 
> +----SoC-----+
> |            |
> |  MAC       |- drivers/net/ethernet
> |   |        |
> | Base-R PCS |- could be in drivers/net/pcs, or directly
> |   |        | in the MAC driver
> |   |        |
> |  SerDes    |- May be in drivers/phy, maybe handled by firmware,
> |   |        |  maybe by the MAC driver, maybe by the PCS driver ?
> +---|--------+
>     |
>     | 10GBase-R
>     |
> +---|-PHY+
> |   |    |
> | SerDes | \
> |   |    | |
> |  PCS   | |
> |   |    |  > All of that handled by the drivers/net/phy PHY driver
> |  PMA   | |
> |   |    | |
> |  PMD   | /
> +---|----+
>     |
>     v 10GBaseT
> 
> So even the "PCS" loopback component is a bit ambiguous, are we talking
> about the PHY PCS or the MAC PCS ?
> 
> Another thing to consider is that there may be multiple PCSs in the SoC
> (e.g. a BaseX and a BaseR PCS like we have in mvpp2), the one in use
> depends on the current interface between the MAC and the PHY.
> 
> Another open question is, do we deal with loopbacks that may affect
> multi-netdev links ? Like the multi-lane modes we discussed with fbnic,
> or even for embedded, interfaces such as QSGMII ?
> 
> As for the SerDes on the MAC side (say, the comphy on Marvell devices),
> can we say it's a PMA for 10GBase-KR ? Or is it something that's simply
> out of spec ?
> 
> So I'd say, maybe we should not have a PCS loopback component at all,
> but instead loopback at the well-defined components on our link, that is:
> 
>  - MAC => MAC loopack, PCS on the MAC side, SerDes on the SoC, etc.
>  - PHY => Loopbacks on the PCS/PHY/PMA withing the PHY device
>  - Module => For non-PHY (Q)SFPs
> 
> The important part would therefore to get the "name" part right, making
> sure we don't fall into driver specific names.
> 
> We can name that 'pcs', 'pma', 'pmd', or maybe even 'mii' ? Let's see :
> 
> +----SoC-----+
> |            |
> |  MAC       |- component = MAC, name = 'mac'
> |   |        |
> | Base-R PCS |- component = MAC, name = 'pcs'
> |   |        |
> |   |        |
> |  SerDes    |- component = MAC, name = 'mii' ?
> |   |        |
> +---|--------+
>     |
>     | 10GBase-R
>     |
> +---|-PHY+
> |   |    |
> | SerDes | - component = PHY, name = 'mii' ?
> |   |    |
> |  PCS   | - component = PHY, name = 'pcs'
> |   |    |
> |  PMA   | - component = PHY, name = 'pma'
> |   |    |
> |  PMD   |- component = PHY, name = 'pmd' or 'mdi' ?
> +---|----+
>     |
>     v 10GBaseT
> 
> Sorry that's a lot of questions and I don't expect you to have the
> answer, but as what you've come-up with is taking a good shape, it's
> important to decide on the overall design and draw some lines about
> what do we support, and how :(
> 
> > +  -
> > +    name: loopback-direction
> > +    type: flags
> > +    doc: |
> > +      Loopback direction flags. Used as a bitmask in supported, and as
> > +      a single value in direction.
> > +    entries:
> > +      -
> > +        name: near-end
> > +        doc: Near-end loopback; host-loop-host
> > +      -
> > +        name: far-end
> > +        doc: Far-end loopback; line-loop-line
> 
> I was browsing 802.3, it uses the terminlogy of "local loopback" vs
> "remote loopback", I suggest we use those.

I do not want to overload this initial series with complex topology problems,
but we must ensure the proposed UAPI does not block future extensions. I am
currently investigating automated datapath diagnostic, and a flat component +
name model will eventually fail us.

Looking at the current patch:
- component (MAC, PCS, PHY, MODULE)
- name (subsystem label)
- id (local instance selector)
- direction (near-end / far-end): These terms become highly ambiguous in
  branching topologies (like CPU port on DSA switches).

mixed loopbacks across complex interconnects, userspace will eventually need a
Directed Acyclic Graph (DAG) model.

By adopting a DAG topology now, we can reduce the load on the initial
implementation and bypass much of the ongoing naming discussions, as components
are identified by their topological relations rather than arbitrary string
labels.

Can we design the netlink attributes now to ensure we are not blocked from
adding the following fields later:

- node_id: Global system ID. This also allows us to attach more diagnostic
  points (e.g., hardware counters) to exact subcomponents.

- parent_node_id: Upstream pointer for tree reconstruction.

- action: Bitmask of hardware modes (e.g., LOOPBACK, GENERATE) to allow
  simultaneous operations on a single node. See 6.3.1.3.1 Loopback Modes in:
  https://www.ti.com/lit/ds/symlink/dp83tg720s-q1.pdf?ts=1773225830126

- supported_actions: Bitmask of capabilities (e.g., can this node do LOOPBACK
  and GENERATE simultaneously?).

- direction: Towards parent / from parent.

- operational_constraints: MTU limits (e.g., FEC corrupts loopbacks >1522
  bytes), clock injection requirements (e.g., stmmac requires external Rx
  clocks), and required interface modes (e.g. loopback on FEC works only in
  MII mode)

If we hardcode a flat list assumption into the framework now, it will break
when we try to automate tests across datapath forks (e.g., SoC -> DSA Switch ->
PHYs) or handle complex industrial PHYs... :)

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

