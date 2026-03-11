Return-Path: <linux-rdma+bounces-17936-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIO+HlMJsWnhpwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17936-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 07:18:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 362F725CC0F
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 07:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD849302E0CA
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 06:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9FC3644C1;
	Wed, 11 Mar 2026 06:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KU92Tt4X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99401A6805;
	Wed, 11 Mar 2026 06:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773209933; cv=none; b=FHsl6/BTb7K3CetV0+KmdQuxXWNmq+B9Smw5FC86MNj3W/cvShzQ2S6PS97k89Hg9yaRkDpeTNPD7HvGzWuxye1uEB5OVAdaVa1SvpZMAbL2ODxP88RarXNKzXlCU/4th0OikYcZIMlBEI2pYFCrA1Lrc+vo7PWQOY2hsz3+Fss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773209933; c=relaxed/simple;
	bh=ejDGsQ47zpnLGljXdA5s4QT3V/VArMFCHQ3Yr6APDmk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3e+LFSdPGPOTt+vZoDlR5ghshtcnZNmf+yDIsTczZlEH8LXIk9OnuUXLnSv598YftqGuBr38UZaXcYx3Tlq7Yj9TL5PXE7gS62aHitAO0XzZRzmANSSRwQ4PMfRWz/2MR8blBsirk7OXub/cces6FKYFeo+t0LgD5vaTUHLKW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KU92Tt4X; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AHflUK1846326;
	Tue, 10 Mar 2026 23:18:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=H
	rJSDndbxbUQL/bgGjxwzb81tDICXmRDxfW92KqCoNc=; b=KU92Tt4XW1VK/8LwG
	vMATmjZwEhoYN/Bfc/N3+Hoct43ahj+PHl1WBRWFUgHOHcDNSUZcIfkBHmwO6WjB
	8Wjtn+VejLdcr2B8M+hX5dPcw9BggfqX4gz9kB8N9pRE0ieSYmlQUaSxo4ViRrMV
	hjROMsa0Z8Bb4lF4XB2ZiACc1sjMFWt6w16in9vemrjBYtqd4gCAXvE2OamACqrW
	SVux908r7+5iz8L5V4BvcuuuRbyhDDoQ3cLvKdNPSmZ5oMMAMBUqMa2EntCTvP0V
	rXLPP6kuW0NY1J9JFBPyoo7S82vY/d2NKXhB0eEs6AtfM1QntOLc3wCBIZuFyUJK
	EItHA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cte6ukpcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 23:18:28 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Mar 2026 23:18:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 10 Mar 2026 23:18:27 -0700
Received: from naveenm-PowerEdge-T630 (unknown [10.29.37.44])
	by maili.marvell.com (Postfix) with ESMTP id B18C13F707A;
	Tue, 10 Mar 2026 23:18:20 -0700 (PDT)
Date: Wed, 11 Mar 2026 11:48:19 +0530
From: Naveen Mamindlapalli <naveenm@marvell.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
CC: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
        "Andrew
 Lunn" <andrew+netdev@lunn.ch>,
        Donald Hunter <donald.hunter@gmail.com>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Maxime
 Chevallier" <maxime.chevallier@bootlin.com>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Danielle Ratson <danieller@nvidia.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Ido Schimmel <idosch@nvidia.com>,
        "Kory Maincent" <kory.maincent@bootlin.com>,
        Leon Romanovsky
	<leon@kernel.org>,
        Michael Chan <michael.chan@broadcom.com>,
        Oleksij Rempel
	<o.rempel@pengutronix.de>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>,
        Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
        Russell King
	<linux@armlinux.org.uk>,
        Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan
	<shuah@kernel.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Willem de Bruijn
	<willemb@google.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next 00/11] ethtool: Generic loopback support
Message-ID: <abEJK8ombhGhaJWq@naveenm-PowerEdge-T630>
References: <20260310104743.907818-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260310104743.907818-1-bjorn@kernel.org>
X-Authority-Analysis: v=2.4 cv=SPlPlevH c=1 sm=1 tr=0 ts=69b10934 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8
 a=M5GUcnROAAAA:8 a=P-IC7800AAAA:8 a=Q-fNiiVtAAAA:8 a=ZgPwoTAcDLxxBmCnmrIA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA1MSBTYWx0ZWRfX9IrXg7T0eTSs
 7kEVkWwaflLk9RlVBrNsn/gQDpc0/ht6yGdKVz2XNuqIFuBbmb3Cbu6vvqHYY3QhvYiLUU0htn7
 xEeZmx9iyoDQTaOzjVb2BoP6PsWt/LndMdYChT+L+IVgIHZ3l2aYK+0RzsOMvVTyXp8N2eube88
 XZiQYc5RDBqw7naw4I389CuXtqSBsGIP3sObhx3WY/SIFzvbHN1OA4bWXwtx+WOac8NqjYrvuL5
 1tWx59HL0uqK2rTxAReeMPeQkKhmW2mG7K7AO0m2hwYcrm4KjxDLweOZiA3eJ857tPfsPwE+/Av
 ia/QW0xswlI3SKfIqdXDaIPvZIdbXG8LmBzGuWGTokY7AZHbbAh1p3ohCWUZV7hr3ss7zTo9HbU
 o2N6QFAabRm+fkY2GX3vOrPUcu8oMQQYR1lAnAnoqXUALOUg/Mg3hGHtBa0+0+lXELpRxrpY9Q/
 jYJYjW8ypHlkSn6LlPw==
X-Proofpoint-GUID: cjVnVQXPO4GJN_xKLf8zw50QHOow8SDa
X-Proofpoint-ORIG-GUID: cjVnVQXPO4GJN_xKLf8zw50QHOow8SDa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Rspamd-Queue-Id: 362F725CC0F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17936-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,kernel.org,bootlin.com,redhat.com,nvidia.com,marvell.com,broadcom.com,pengutronix.de,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,marvell.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[naveenm@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

On 2026-03-10 at 16:17:30, Björn Töpel (bjorn@kernel.org) wrote:
> Hi!
> 
> Background
> ==========
> 
> This series adds a generic ethtool loopback framework with GET/SET
> netlink commands, using a component/id/name/direction model that can
> (Hopefully! Please refer to "Open questions" below.) represent
> loopback points across the network path (MAC, MODULE, PHY, PCS).
> 
> This is the v1 proper of the loopback series, reworked based on
> feedback from previous RFC v2 [1].
> 
> The main change since the RFC v2 is that LOOPBACK_GET no longer
> returns an array of entries in a single doit reply. Instead, it uses
> the dumpit infrastructure -- each loopback entry is a separate netlink
> message in a DUMP response. This follows the same pattern as PHY_GET
> and the perphy helpers in net/ethtool/netlink.c, as suggested by
> Maxime.
> 
> A filtered DUMP (with a dev-index in the header) lists all loopback
> entries for that netdev; an unfiltered DUMP iterates over all netdevs.
> The doit handler is also available: when the request includes an
> ETHTOOL_A_LOOPBACK_ENTRY nest with component + name, it returns that
> specific entry.
> 
> The loopback model remains the same: LOOPBACK_GET/SET with a generic
> component/name/direction model that can represent loopback points
> across the data path -- MODULE, PHY, MAC, and PCS. This series wires
> up MODULE/CMIS and MAC as the first users; PHY and PCS return
> -EOPNOTSUPP for now.
> 
> Loopback lookup and enumeration
> ===============================
> 
> Each loopback entry is uniquely identified by the tuple (component,
> id, name). The kernel provides two GET paths:
> 
>  - Exact lookup (doit): the user specifies component + name (and
>    optionally id) in the request. The kernel dispatches to the right
>    component handler: for MAC, it calls the driver's
>    get_loopback(dev, name, id, entry) ethtool_op; for MODULE, it
>    calls ethtool_cmis_get_loopback(dev, name, entry). Returns a
>    single entry or -EOPNOTSUPP.
> 
>  - Index enumeration (dump): the kernel iterates a flat index space
>    across all components on a device. Each component's
>    get_loopback_by_index(dev, index, entry) is tried in order (MAC
>    first via ethtool_ops, then MODULE/CMIS). The dump stops when all
>    components return -EOPNOTSUPP. This integrates with the generic
>    dump_one_dev sub-iterator infrastructure added in patch 1.
> 
> SET takes one or more entries, each with component + name + direction,
> and dispatches to the driver's set_loopback() ethtool_op (MAC) or
> ethtool_cmis_set_loopback() (MODULE).
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
> Currently, only mellanox/mlxsw, and broadcom/bnxt support CMIS
> operations. I'll follow-up with mlx5 support.
> 
> Implementation
> ==============
> 
> Patch 1/11 ethtool: Add dump_one_dev callback for per-device sub-iteration
>   Replaces the per-PHY specific dump functions with a generic
>   sub-iterator infrastructure driven by a dump_one_dev callback in
>   ethnl_request_ops. When ops->dump_one_dev is set,
>   ethnl_default_start() saves the target device's ifindex for
>   filtered dumps, and ethnl_default_dumpit() delegates per-device
>   iteration to the callback. No separate start/dumpit/done functions
>   are needed.
> 
> Patch 2/11 ethtool: Add loopback netlink UAPI definitions
>   Adds the YAML spec and generated UAPI header for the new
>   LOOPBACK_GET/SET commands. Each loopback entry carries a component
>   type, optional id, name string, supported directions bitmask, and
>   current direction.
> 
> Patch 3/11 ethtool: Add loopback GET/SET netlink implementation
>   Implements GET/SET dispatch in a new loopback.c. GET uses the
>   dump_one_dev infrastructure for dump enumeration (by flat index)
>   and supports doit exact lookup by (component, id, name) via
>   parse_request. SET switches on the component and calls the right
>   handler per entry. No components are wired yet.
> 
> Patch 4/11 ethtool: Add CMIS loopback helpers for module loopback control
>   Adds cmis_loopback.c with the MODULE component handlers and wires
>   them into loopback.c's dispatch. GET enumerates entries by index
>   (ethtool_cmis_get_loopback_by_index) or looks up by name
>   (ethtool_cmis_get_loopback). SET (ethtool_cmis_set_loopback)
>   resolves name to control byte indices and enforces mutual
>   exclusivity.
> 
> Patch 5/11 selftests: drv-net: Add loopback driver test
>   Adds loopback_drv.py with generic tests that work on any device
>   with module loopback support: enable/disable, direction switching,
>   idempotent enable, and rejection while interface is up.
> 
> Patch 6/11 ethtool: Add MAC loopback support via ethtool_ops
>   Extends struct ethtool_ops with three loopback callbacks for
>   driver-level MAC loopback: get_loopback (exact lookup by name/id),
>   get_loopback_by_index (dump enumeration), and set_loopback. Wires
>   the MAC component into loopback.c's dispatch. For dump enumeration,
>   MAC entries are tried first, then MODULE/CMIS entries follow at the
>   next index offset.
> 
> Patch 7/11 netdevsim: Add MAC loopback simulation
>   Implements the three ethtool loopback ops in netdevsim. Exposes a
>   single MAC loopback entry ("mac") with both near-end and far-end
>   support. State is stored in memory and exposed via debugfs under
>   ethtool/mac_lb/{supported,direction}.
> 
> Patch 8/11 selftests: drv-net: Add MAC loopback netdevsim test
>   Adds loopback_nsim.py with netdevsim-specific tests for MAC
>   loopback: entry presence, SET/GET round-trip with debugfs
>   verification, and error paths.
> 
> Patch 9/11 MAINTAINERS: Add entry for ethtool loopback
>   Adds a MAINTAINERS entry for the ethtool loopback subsystem covering
>   the core loopback and CMIS loopback netlink implementation, and the
>   associated selftests.
> 
> Patch 10/11 netdevsim: Add module EEPROM simulation via debugfs
>   Adds get/set_module_eeprom_by_page to netdevsim, backed by a
>   256-page x 128-byte array exposed via debugfs.
> 
> Patch 11/11 selftests: drv-net: Add CMIS loopback netdevsim test
>   Extends loopback_nsim.py with netdevsim-specific tests that seed the
>   EEPROM via debugfs: capability reporting, EEPROM byte verification,
>   combined MAC + MODULE dump, and error paths.
> 
> Changes since RFC v2
> ====================
> 
>  - Switched LOOPBACK_GET from doit-with-array to dumpit, where each
>    loopback entry is a separate netlink message. Uses the new generic
>    dump_one_dev sub-iterator infrastructure instead of duplicating the
>    perphy dump pattern. (Maxime)
> 
>  - u32 to u8 to represent the enums in the YAML. (Maxime)
>    
>  - Tried to document the YAML better. (Andrew)
> 
>  - Added doit exact lookup by (component, id, name) via
>    parse_request, so single-entry GET doesn't need a flat index.
> 
>  - Added MAC loopback support via three new ethtool_ops callbacks
>    (get_loopback(), get_loopback_by_index(), set_loopback()) with
>    netdevsim implementation and tests.
> 
>  - Added MAINTAINERS entry.
> 
> Limitations
> ===========
> 
> PHY and PCS loopback are defined in the UAPI but not yet implemented.
> 
> No per-lane support -- loopback is all-or-nothing (0xff/0x00) across
> lanes.
> 
> Open questions
> ==============
> 
>  - Is this the right extensibility model? I'd appreciate input from
>    other NIC vendors on whether component/name/direction is flexible
>    enough for their loopback implementations. Also, from the PHY/port
>    folks (Maxime, Russell)! Naveen, please LMK if the MAC side of
>    thing, is good enough for Marvell.

Hi Bjorn,

Is a SERDES component as Maxime suggested something you'd consider
for follow-up patches? It would be a natural fit for SoCs with a
separate SerDes hardware block.

Thanks,
Naveen

> 
>  - Are patches 10-11 (netdevsim EEPROM simulation + netdevsim-specific
>    tests) worth carrying? They drive the CMIS Page 13h registers from
>    debugfs, which gives good coverage without hardware, but it's
>    another netdevsim surface to maintain. If the consensus is that the
>    generic driver tests (patch 5) are sufficient, I'm happy to drop
>    them.
> 
>  - Extend mellanox/mlx5 with .set_module_eeprom_by_page() callback. I
>    got it to work in [6], but would like feedback from the Mellanox
>    folks.
> 
> Related work
> ============
> 
> [1] Generic loopback support, RFC v2
>   https://lore.kernel.org/netdev/20260219130050.2390226-1-bjorn@kernel.org/
> [2] CMIS loopback, RFC v1
>   https://lore.kernel.org/netdev/20260219130050.2390226-1-bjorn@kernel.org/
> [3] New loopback modes
>   https://lore.kernel.org/netdev/20251024044849.1098222-1-hkelam@marvell.com/
> [4] PHY loopback
>   https://lore.kernel.org/netdev/20240911212713.2178943-1-maxime.chevallier@bootlin.com/
> [5] bnxt_en: add .set_module_eeprom_by_page() support
>   https://lore.kernel.org/netdev/20250310183129.3154117-8-michael.chan@broadcom.com/
> [6] net/mlx5e: Implement set_module_eeprom_by_page ethtool callback
>   https://lore.kernel.org/netdev/20260219130050.2390226-5-bjorn@kernel.org/
> 
> 
> Björn Töpel (11):
>   ethtool: Add dump_one_dev callback for per-device sub-iteration
>   ethtool: Add loopback netlink UAPI definitions
>   ethtool: Add loopback GET/SET netlink implementation
>   ethtool: Add CMIS loopback helpers for module loopback control
>   selftests: drv-net: Add loopback driver test
>   ethtool: Add MAC loopback support via ethtool_ops
>   netdevsim: Add MAC loopback simulation
>   selftests: drv-net: Add MAC loopback netdevsim test
>   MAINTAINERS: Add entry for ethtool loopback
>   netdevsim: Add module EEPROM simulation via debugfs
>   selftests: drv-net: Add CMIS loopback netdevsim test
> 
>  Documentation/netlink/specs/ethtool.yaml      | 123 ++++++
>  MAINTAINERS                                   |   6 +
>  drivers/net/netdevsim/ethtool.c               | 147 +++++++
>  drivers/net/netdevsim/netdevsim.h             |  15 +
>  include/linux/ethtool.h                       |  23 +
>  .../uapi/linux/ethtool_netlink_generated.h    |  59 +++
>  net/ethtool/Makefile                          |   2 +-
>  net/ethtool/cmis_loopback.c                   | 407 ++++++++++++++++++
>  net/ethtool/loopback.c                        | 341 +++++++++++++++
>  net/ethtool/mse.c                             |   1 +
>  net/ethtool/netlink.c                         | 285 ++++--------
>  net/ethtool/netlink.h                         |  45 ++
>  net/ethtool/phy.c                             |   1 +
>  net/ethtool/plca.c                            |   2 +
>  net/ethtool/pse-pd.c                          |   1 +
>  .../testing/selftests/drivers/net/hw/Makefile |   2 +
>  .../selftests/drivers/net/hw/loopback_drv.py  | 226 ++++++++++
>  .../selftests/drivers/net/hw/loopback_nsim.py | 340 +++++++++++++++
>  18 files changed, 1820 insertions(+), 206 deletions(-)
>  create mode 100644 net/ethtool/cmis_loopback.c
>  create mode 100644 net/ethtool/loopback.c
>  create mode 100755 tools/testing/selftests/drivers/net/hw/loopback_drv.py
>  create mode 100755 tools/testing/selftests/drivers/net/hw/loopback_nsim.py
> 
> 
> base-commit: 52ede1bce557c66309f41ac29dd190be23ca9129
> -- 
> 2.53.0
> 
> 

