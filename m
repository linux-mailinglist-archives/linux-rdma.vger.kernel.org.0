Return-Path: <linux-rdma+bounces-17782-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEjnNiLSrmlhJAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17782-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 14:58:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEAC23A2EC
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 14:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F29E23193905
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 13:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6793C3BF4;
	Mon,  9 Mar 2026 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="gZPy3hYT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E328038F93A;
	Mon,  9 Mar 2026 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773064213; cv=none; b=qj7WtHks3MeJQKHkosreRUI0oy3V9rGtFKpSrT+fJ4hjZf5uJbMnrKhKTzeYMVG29N9CL0tRcfbyJHKfFrojkmtVEYOI8DPBNKC4oeALkQ74Y+7a5CD/5P16+gTgDNpmJHmMxYvnUWmxteyTR1vDjSwlRXH0Xb5VHV51UA8ViRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773064213; c=relaxed/simple;
	bh=c5rbStFtRclgiSzvw6Wajg3dT9AmwlIozEnmfYWKfDI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOt8b1HBryQ4Wh+4uXfNx+l1IylAME3wDWgkSoONQ6DvaS/dJQ1EMDzAQeFcxQTGMI+jwAtVwUYC/XcuOUy3sIdIQSrNG6XsNg2ONHyDLiusJ9/npjOMAUY1fBcgWAYKcFjVFz/3h9k9y3bTyvUaKW+hj7H/SAnfY6ZuPIl3I0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=gZPy3hYT; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629DEZjp3370975;
	Mon, 9 Mar 2026 06:49:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=a
	kjPAeN4UU1pVhpAh0/pX4vkrwNQX9jrXGKG4Tjn5g8=; b=gZPy3hYTAezuffUcl
	PtZCaze4fk8R2QRzEel6u08j/AzRqKhZ5jlgBiRkZyTsaiqyRgs5Sle4TD4jHZBr
	WWwfTBc5TKOQ8+zW7Vh5EvObtVIsbQ3qrdCZI7yQfSSlddK7tKAvT/3OW/0TkTD8
	3DjzGUu28rzlGgv9hi76UwxodEXgBeWc1Jx/toEcWg8Zyfo6CozxvZsw1dfMNhVc
	86/GVwAUgw4/jGNBGDrJMJ2Pt5V+qma2VFvCORaufi3h+NbBkBBNUUX8v1uPZsdc
	CDIAQQ8FW/h7QOxlZ2f583RJgTGwGfjqeP0ilZu7vtu8H0ednm3bFOItIDOM7aep
	0mISg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4crj8quqj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 06:49:41 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Mar 2026 06:49:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 9 Mar 2026 06:49:40 -0700
Received: from naveenm-PowerEdge-T630 (unknown [10.29.37.44])
	by maili.marvell.com (Postfix) with ESMTP id BAED73F7068;
	Mon,  9 Mar 2026 06:49:34 -0700 (PDT)
Date: Mon, 9 Mar 2026 19:19:33 +0530
From: Naveen Mamindlapalli <naveenm@marvell.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
CC: <netdev@vger.kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman
	<horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
        Tariq Toukan
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Danielle Ratson <danieller@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, Russell King <linux@armlinux.org.uk>
Subject: Re: [RFC net-next v2 0/6] ethtool: Generic loopback support
Message-ID: <aa7P7UUUG1p5RVwO@naveenm-PowerEdge-T630>
References: <20260308124016.3134012-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260308124016.3134012-1-bjorn@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEyNSBTYWx0ZWRfXxbwr9nYX6sci
 p92XabexOPDjwsQ4MZLYO+zMNC1zLXtqdkoUF2BDD7DSnYd9C8r8smSW75FKMqDU+BxaQdF+7Wh
 0WDpyRgbA/mj1eGCeCaqwaA4rhtShvzKqiPV4ql52Z5KhSzbxPBhU1JkpnWjCtD+TLFWqfTuwzw
 Sur2PdcB8+4E+4xaarZLVcjfOYeWfgCqiKf17/d2dvp95rDcp74cME7VFkYkl4FFu0zM9KzY4RC
 WhBSXEm9Y8ID6WUrfNn9V7pwnq5R6kKZKxBtFjsLtKZfC/eqhDr6clJzvrFQs29Fx16ivOBpKkP
 3LWS07rCuW48qWykMWkB7pQVtPnF5addflmM6zF4O/bpVtOhe7ml9e37gDjpWYELcrnzOfnJsda
 Obqdu72gmLztUMvnHpJjIataXEWBfCxyeTFOXtQHS55mpOlYNJ90AENh4Kiobs/K/Q5cUbR2uNG
 LdROTsFl9BBpHLjb/VQ==
X-Proofpoint-GUID: JfkpMwsJt62-ifdgQzfmh_TYGH4Kb4Cr
X-Proofpoint-ORIG-GUID: JfkpMwsJt62-ifdgQzfmh_TYGH4Kb4Cr
X-Authority-Analysis: v=2.4 cv=WbwBqkhX c=1 sm=1 tr=0 ts=69aecff5 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8
 a=M5GUcnROAAAA:8 a=P-IC7800AAAA:8 a=Q-fNiiVtAAAA:8 a=wHvoYhKdVLinnAuvZsgA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-09_01,2025-10-01_01
X-Rspamd-Queue-Id: 3EEAC23A2EC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17782-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch,bootlin.com,broadcom.com,marvell.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,loopback_drv.py:url,marvell.com:dkim,loopback_nsim.py:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[naveenm@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

On 2026-03-08 at 18:10:06, Björn Töpel (bjorn@kernel.org) wrote:
> Hi!
> 
> Background
> ==========
> 
> This is the v2 RFC of the CMIS loopback series, reworked based on
> feedback from v1 [1].
> 
> The main change is that loopback is no longer bolted onto the existing
> module interface. Instead, it gets its own netlink commands
> (LOOPBACK_GET/SET) with a generic component/name/direction model that
> can represent loopback points across the entire data path -- MODULE,
> PHY, MAC, and PCS. This series wires up MODULE/CMIS as the first user;
> the other component types return -EOPNOTSUPP for now.
> 
> The Common Management Interface Specification (CMIS) defines four
> diagnostic loopback types, characterized by location (Host or Media
> Side) and signal direction:
> 
>  - Host Side Input (Rx->Tx) -- near-end
>  - Host Side Output (Tx->Rx) -- far-end
>  - Media Side Input (Rx->Tx) -- near-end
>  - Media Side Output (Tx->Rx) -- far-end
> 
> Support is detected via Page 13h Byte 128, and loopback is controlled
> via Page 13h Bytes 180-183 (one byte per type, one bit per lane).
> 
> The CMIS helpers work entirely over get/set_module_eeprom_by_page, so
> any driver that already has EEPROM page access gets module loopback
> without new ethtool_ops or driver changes.
> 
> Implementation
> ==============
> 
> Patch 1/6 ethtool: Add loopback netlink UAPI definitions
>   Adds the YAML spec and generated UAPI header for the new
>   LOOPBACK_GET/SET commands. Each loopback entry carries a component
>   type, optional id, name string, supported directions bitmask, and
>   current direction.
> 
> Patch 2/6 ethtool: Add loopback GET/SET netlink implementation
>   Implements GET/SET dispatch in a new loopback.c. GET collects
>   entries from each subsystem. SET switches on the component and
>   calls the right handler per entry. No components are wired yet.
> 
> Patch 3/6 ethtool: add CMIS loopback helpers for module loopback control
>   Adds cmis_loopback.c with the MODULE component handlers. GET reads
>   Page 13h and appends one entry per supported loopback point
>   ("cmis-host" and/or "cmis-media"). SET resolves name to control
>   byte indices and enforces mutual exclusivity -- switching directions
>   first disables the active one in a separate EEPROM write, then
>   enables the new one.
> 
> Patch 4/6 selftests: drv-net: Add loopback driver test
>   Adds loopback_drv.py with generic tests that work on any device
>   with module loopback support: enable/disable, direction switching,
>   idempotent enable, and rejection while interface is up.
> 
> Patch 5/6 netdevsim: Add module EEPROM simulation via debugfs
>   Adds get/set_module_eeprom_by_page to netdevsim, backed by a
>   256-page x 128-byte array exposed via debugfs. This enables
>   testing the CMIS loopback path without hardware.
> 
> Patch 6/6 selftests: drv-net: Add CMIS loopback netdevsim test
>   Adds loopback_nsim.py with netdevsim-specific tests that seed the
>   EEPROM via debugfs: capability reporting, EEPROM byte verification,
>   and error paths for unsupported or missing CMIS support.
> 
> Limitations
> ===========
> 
> Only MODULE/CMIS is wired up. PHY, MAC, and PCS loopback are defined
> in the UAPI but not yet implemented.
> 
> No per-lane support -- loopback is all-or-nothing (0xFF/0x00) across
> lanes.
> 
> Extending to PHY/MAC/PCS
> =========================
> 
> PHY loopback can walk phy_link_topology to enumerate PHYs by phyindex
> and call phy_loopback() directly. MAC and PCS loopback can route
> through phylink via new mac_set_loopback()/pcs_set_loopback()
> callbacks. Drivers that don't use phylink could add new ethtool_ops.
> The dispatch framework already handles all component types.
> 
> Open questions
> ==============
> 
>  - Is this the right extensibility model? I'd appreciate input from
>    other NIC vendors on whether component/name/direction is flexible
>    enough for their loopback implementations. Also, from the PHY/port
>    folks (Maxime, Russell)!

Hi Bjorn,

The component/name/direction model in v2 fits our hardware well.

I am working on loopback support for Marvell OcteonTX2.
The MAC (RPM block) supports a PCS-level loopback. In addition,
the on-chip SerDes (GSERM) is managed by embedded firmware and
supports three more loopback modes:
  NED (Near-End Digital) -- digital domain, before the analog front-end
  NEA (Near-End Analog) -- through the full analog front-end
  FED (Far-End Digital) -- line-side traffic looped back

Since the GSERM is not a phylib phy_device, both the MAC PCS
loopback and the SerDes loopbacks fall under the MAC component
in your model.

Mapped to the v2 model:
  component  name         supported    description
  MAC        mac          near-end     PCS-level loopback
  MAC        serdes-ned   near-end     digital only
  MAC        serdes-nea   near-end     analog
  MAC        serdes-fed   far-end      line-side

The SerDes NED and NEA both have the same (component, direction).
Both are (MAC, near-end) -- but exercise fundamentally different
hardware paths. The name field distinguishes them as per your model,

I can work on MAC + SerDes loopback driver support for CN10K and
post patches on top of your series once MAC component dispatch is
in place.

Thanks,
Naveen

> 
>  - The MODULE id field is currently unused. For multi-module setups it
>    could serve as a port selector. It could also help detect module
>    swaps -- a hash of the CMIS vendor serial number (Page 00h, Bytes
>    168-183), vendor name, and part number would give userspace a
>    stable identifier to verify the module hasn't changed since
>    loopback was configured. Worth adding now, or defer until there's a
>    concrete user?
> 
>  - Are patches 5-6 (netdevsim EEPROM simulation + netdevsim-specific
>    tests) worth carrying? They drive the CMIS Page 13h registers from
>    debugfs, which gives good coverage without hardware, but it's
>    another netdevsim surface to maintain. If the consensus is that the
>    generic driver tests (patch 4) are sufficient, I'm happy to drop
>    them.
> 
> Related work
> ============
> 
> [1] CMIS loopback v1
>   https://lore.kernel.org/netdev/20260219130050.2390226-1-bjorn@kernel.org/
> [2] New loopback modes
>   https://lore.kernel.org/netdev/20251024044849.1098222-1-hkelam@marvell.com/
> [3] PHY loopback
>   https://lore.kernel.org/netdev/20240911212713.2178943-1-maxime.chevallier@bootlin.com/
> [4] bnxt_en: add .set_module_eeprom_by_page() support
>   https://lore.kernel.org/netdev/20250310183129.3154117-8-michael.chan@broadcom.com/
> 
> 
> Björn Töpel (6):
>   ethtool: Add loopback netlink UAPI definitions
>   ethtool: Add loopback GET/SET netlink implementation
>   ethtool: add CMIS loopback helpers for module loopback control
>   selftests: drv-net: Add loopback driver test
>   netdevsim: Add module EEPROM simulation via debugfs
>   selftests: drv-net: Add CMIS loopback netdevsim test
> 
>  Documentation/netlink/specs/ethtool.yaml      | 115 ++++++
>  drivers/net/netdevsim/ethtool.c               |  79 ++++
>  drivers/net/netdevsim/netdevsim.h             |  11 +
>  include/linux/ethtool.h                       |  28 ++
>  .../uapi/linux/ethtool_netlink_generated.h    |  52 +++
>  net/ethtool/Makefile                          |   2 +-
>  net/ethtool/cmis_loopback.c                   | 338 ++++++++++++++++++
>  net/ethtool/loopback.c                        | 248 +++++++++++++
>  net/ethtool/netlink.c                         |  20 ++
>  net/ethtool/netlink.h                         |   8 +
>  .../selftests/drivers/net/hw/loopback_drv.py  | 227 ++++++++++++
>  .../selftests/drivers/net/hw/loopback_nsim.py | 249 +++++++++++++
>  12 files changed, 1376 insertions(+), 1 deletion(-)
>  create mode 100644 net/ethtool/cmis_loopback.c
>  create mode 100644 net/ethtool/loopback.c
>  create mode 100755 tools/testing/selftests/drivers/net/hw/loopback_drv.py
>  create mode 100755 tools/testing/selftests/drivers/net/hw/loopback_nsim.py
> 
> 
> base-commit: 0bcac7b11262557c990da1ac564d45777eb6b005
> -- 
> 2.53.0
> 
> 

