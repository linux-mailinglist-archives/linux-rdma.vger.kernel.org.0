Return-Path: <linux-rdma+bounces-18605-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIXiKFH7w2k/vQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18605-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:12:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0B732799D
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E2983304B9A
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 14:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAD93F0750;
	Wed, 25 Mar 2026 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKZFm52x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A84A3EFD2E;
	Wed, 25 Mar 2026 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450234; cv=none; b=Bt3PDCpstGZ/f1Fr/4FiHEQsNMLhG2//w0+mK8K1tIZhqf9ThSDmGn2Ig8Y7XI0/UqwDBzRyoGuOUEHPopVQKedP369o/K1IRrdnHO5WiHLfCaLehvO/y7bQk5ULIP8CUXd8RN5IE0SJZSBKtnckAtX47wa67sfbmhCL4gnjdeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450234; c=relaxed/simple;
	bh=zIpYzNlg2Qs4p6fztuAWs9xqNAAsPOoNZSyYFUZdVF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OYs3o8Ro2LySv0aA94nWuAOO/Lhy9VeN6O6qlB4C3FIvwVCdWUdLSdyZCLXjaQsZVUEUyEW7/OFCd2/6eADWm47L9pkZcnxaxbmVJ+RAfqpGXtiNnpT6rA4tc35dZClLv0xA/xNmMUC2kvFc5op3A7lC1KSFF/44D2PcYa7Envs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKZFm52x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D7FC4CEF7;
	Wed, 25 Mar 2026 14:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774450233;
	bh=zIpYzNlg2Qs4p6fztuAWs9xqNAAsPOoNZSyYFUZdVF4=;
	h=From:To:Cc:Subject:Date:From;
	b=FKZFm52xJsajJq1M83SZl5gWipj9M3rkpXNXv1htSfkS9zEFQKk+dZe6PyB7N4TRV
	 6ZwqtHORf/V7/qPsyUxL+mhQMA7N0Y9Ufrg4cLdsS31TuD2UqNTap42A+iECk+EiXx
	 SOWRCWxJ6aOtJroEEhHaPqzNKurFjNC+MqGawLlF9wX7exxF9btdiYMgVENSz/xf+3
	 nfctFnBZWJzeiNvRRBPvLYeGVbCYxTRfn9wErrnbIveADYC50CSQ7AiFeg0ODMCrzd
	 im3QW2MUDpxgwyEjroLSEe1vxktncR6hJryCAyDrs50MISNY9wDcmlAbjT1s4HyPBJ
	 OMLZ5xBHRyvrg==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Naveen Mamindlapalli <naveenm@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Danielle Ratson <danieller@nvidia.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Leon Romanovsky <leon@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Willem de Bruijn <willemb@google.com>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v2 00/12] ethtool: Generic loopback support
Date: Wed, 25 Mar 2026 15:50:07 +0100
Message-ID: <20260325145022.2607545-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.11 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.77)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18605-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,kernel.org,bootlin.com,marvell.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,marvell.com,bootlin.com,broadcom.com,pengutronix.de,gmail.com,armlinux.org.uk,google.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loopback_nsim.py:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,loopback_drv.py:url]
X-Rspamd-Queue-Id: 4B0B732799D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi!

Background
==========

This series adds a generic ethtool loopback framework with GET/SET
netlink commands, using a component/name/id/depth model that
represents loopback points across the network path.

This is v2.

Design
======

The loopback model uses four axes to identify a loopback point:

 1. Component (MAC, PHY, MODULE) -- identifies the Linux driver
    boundary that owns the loopback. This maps to the Linux driver
    model, not to 802.3 sublayers directly.

 2. Name -- identifies the sublayer within the component using IEEE
    802.3 vocabulary (e.g. "mac", "pcs", "pma", "pmd", "mii" for MAC
    and PHY components; "cmis-host", "cmis-media" for MODULE). The
    name is a free-form string to avoid over-constraining the enum,
    but recommended names are documented with references to 802.3
    clauses.

 3. Id -- optional instance selector within a component type (e.g.
    PHY index from phy_link_topology, port number). Defaults to 0
    when there is only one instance.

 4. Depth -- ordering index within a component instance. When a
    component has multiple loopback points of the same type (e.g. two
    PCS blocks inside a rate-adaptation PHY), depth distinguishes
    them. Lower values are closer to the host, higher toward the
    line/media. Defaults to 0 when there is only one loopback point
    per (component, name) tuple.

Direction uses IEEE 802.3 terminology: "local" (host TX -> looped back
-> host RX, traffic originating from host returns to host) and
"remote" (line RX -> looped back -> line TX, traffic from far end
returns to far end). Direction is defined from the component's own
viewpoint -- this convention holds regardless of where the component
sits in the system topology.

Cross-component ordering comes from existing infrastructure (PHY link
topology, phy_index). Multi-netdev shared-resource loopbacks (QSGMII,
port breakout) are out of scope; drivers should only expose loopbacks
they can scope to a single netdev.

A filtered DUMP (with a dev-index in the header) lists all loopback
entries for that netdev; an unfiltered DUMP iterates over all netdevs.
The doit handler supports exact lookup by (component, name, id).

V2 design rationale
===================

Why keep name as a string for now? The review discussed replacing name
with an enum. I decided not to do that in v2.

Pros:
 - enforces more consistency across drivers
 - makes userspace parsing simpler
 - makes selftests stricter
 - keeps the UAPI taxonomy explicit

Cons:
 - freezes the stage taxonomy before we fully understand the MAC side
 - risks forcing unlike hardware points into the same enum bucket
 - makes later extension more expensive
 - may standardize the spelling without standardizing the actual
   semantics
   
This series still does not attempt to model the full datapath as a DAG
or expose a generic topology dump. That would likely be useful for
future diagnostics, traffic generators, and deeper validation, but it
also looks like a larger design problem than loopback itself.

The intent of v2 is not to solve that larger problem now, but also not
to block it:

 - component gives the Linux ownership boundary
 - name keeps room for stage-specific vocabulary
 - id selects the component instance
 - depth orders loopback points within that instance

If a richer topology API is needed later, it should be additive rather
than requiring this loopback API to be replaced.

Oleksij's more topology-heavy use cases are therefore not fully solved
by this series, but the current model should still be extendable for
them.

CMIS support
============

The Common Management Interface Specification (CMIS) defines four
diagnostic loopback types, characterized by location (Host or Media
Side) and signal direction:

 - Host Side Input (Rx->Tx) -- local
 - Host Side Output (Tx->Rx) -- remote
 - Media Side Input (Rx->Tx) -- local
 - Media Side Output (Tx->Rx) -- remote

Support is detected via Page 13h Byte 128, and loopback is controlled
via Page 13h Bytes 180-183 (one byte per type, one bit per lane).

The CMIS helpers work entirely over get/set_module_eeprom_by_page, so
any driver that already has EEPROM page access gets module loopback
without new ethtool_ops or driver changes.

Currently, only mellanox/mlxsw, and broadcom/bnxt support CMIS
operations. I'll follow-up with mlx5 support.

Implementation
==============

Patch 1/12 ethtool: Add dump_one_dev callback for per-device sub-iteration
  Adds the dump_one_dev callback to ethnl_request_ops, the ifindex and
  pos_sub fields to ethnl_dump_ctx, and the dispatch logic in
  ethnl_default_start() and ethnl_default_dumpit(). No functional
  change; no command uses dump_one_dev yet.

Patch 2/12 ethtool: Convert per-PHY commands to dump_one_dev
  Converts PSE, PLCA, PHY, and MSE commands from the separate
  ethnl_perphy_{start,dumpit,done} handlers to use the generic
  dump_one_dev callback via a shared ethnl_perphy_dump_one_dev()
  function.

Patch 3/12 ethtool: Add loopback netlink UAPI definitions
  Adds the YAML spec and generated UAPI header for the new
  LOOPBACK_GET/SET commands. Each loopback entry carries a component
  type, optional id, name string, depth, supported directions
  bitmask, and current direction.

Patch 4/12 ethtool: Add loopback GET/SET netlink implementation
  Implements GET/SET dispatch in a new loopback.c. GET uses the
  dump_one_dev infrastructure for dump enumeration (by flat index)
  and supports doit exact lookup by (component, id, name) via
  parse_request. SET switches on the component and calls the right
  handler per entry. No components are wired yet.

Patch 5/12 ethtool: Add CMIS loopback helpers for module loopback control
  Adds cmis_loopback.c with the MODULE component handlers and wires
  them into loopback.c's dispatch. GET enumerates entries by index
  (ethtool_cmis_get_loopback_by_index) or looks up by name
  (ethtool_cmis_get_loopback). SET (ethtool_cmis_set_loopback)
  resolves name to control byte indices and enforces mutual
  exclusivity.

Patch 6/12 selftests: drv-net: Add loopback driver test
  Adds loopback_drv.py with generic tests that work on any device
  with module loopback support: enable/disable, direction switching,
  idempotent enable, and rejection while interface is up.

Patch 7/12 ethtool: Add MAC loopback support via ethtool_ops
  Extends struct ethtool_ops with three loopback callbacks for
  driver-level MAC loopback: get_loopback (exact lookup by name/id),
  get_loopback_by_index (dump enumeration), and set_loopback. Wires
  the MAC component into loopback.c's dispatch. For dump enumeration,
  MAC entries are tried first, then MODULE/CMIS entries follow at the
  next index offset.

Patch 8/12 netdevsim: Add MAC loopback simulation
  Implements the three ethtool loopback ops in netdevsim. Exposes a
  single MAC loopback entry ("mac") with both local and remote
  support. State is stored in memory and exposed via debugfs under
  ethtool/mac_lb/{supported,direction}.

Patch 9/12 selftests: drv-net: Add MAC loopback netdevsim test
  Adds loopback_nsim.py with netdevsim-specific tests for MAC
  loopback: entry presence, SET/GET round-trip with debugfs
  verification, and error paths.

Patch 10/12 MAINTAINERS: Add entry for ethtool loopback
  Adds a MAINTAINERS entry for the ethtool loopback subsystem covering
  the core loopback and CMIS loopback netlink implementation, and the
  associated selftests.

Patch 11/12 netdevsim: Add module EEPROM simulation via debugfs
  Adds get/set_module_eeprom_by_page to netdevsim, backed by a
  256-page x 128-byte array exposed via debugfs.

Patch 12/12 selftests: drv-net: Add CMIS loopback netdevsim test
  Extends loopback_nsim.py with netdevsim-specific tests that seed the
  EEPROM via debugfs: capability reporting, EEPROM byte verification,
  combined MAC + MODULE dump, and error paths.

Changes since v1
================

 - Split dump_one_dev infrastructure patch into two: one adding the
   generic callback infrastructure, one converting per-PHY commands
   to use it. (Jakub)

 - Used Jakub's suggested pattern for filtered dumps: initialize both
   ifindex and pos_ifindex in _start(), then break early in the loop
   when pos_ifindex diverges, avoiding a separate single-device code
   path. (Jakub)

 - Dropped PCS as a top-level component. Components now map to Linux
   driver boundaries: MAC, PHY, MODULE. Sublayer granularity (pcs,
   pma, pmd, mii) lives in the name attribute using IEEE 802.3
   vocabulary. (Maxime)

 - Renamed near-end/far-end to local/remote per IEEE 802.3
   terminology. (Maxime)

 - Added depth field to ETHTOOL_A_LOOPBACK_ENTRY for ordering
   multiple loopback points within a single component instance (e.g.
   rate-adaptation PHY with two PCS blocks). (Jakub)

 - Documented the viewpoint convention: direction is always from the
   component's own perspective, local = toward host, remote = toward
   line, regardless of system topology. (Oleksij)

 - Expanded component doc strings to explain that the name attribute
   uses IEEE 802.3 sublayer vocabulary. (Andrew, Maxime)

Changes since RFC v2
====================

 - Switched LOOPBACK_GET from doit-with-array to dumpit, where each
   loopback entry is a separate netlink message. Uses the new generic
   dump_one_dev sub-iterator infrastructure instead of duplicating the
   perphy dump pattern. (Maxime)

 - u32 to u8 to represent the enums in the YAML. (Maxime)

 - Tried to document the YAML better. (Andrew)

 - Added doit exact lookup by (component, id, name) via
   parse_request, so single-entry GET doesn't need a flat index.

 - Added MAC loopback support via three new ethtool_ops callbacks
   (get_loopback(), get_loopback_by_index(), set_loopback()) with
   netdevsim implementation and tests.

 - Added MAINTAINERS entry.

Opens/limitations
=================

 - mlx5 CMIS support is still not part of the series.
 - PHY loopback is defined in the UAPI but not yet implemented.
 - No per-lane support -- loopback is all-or-nothing (0xff/0x00)
   across lanes.

Related work
============

[1] Generic loopback support, v1
  https://lore.kernel.org/netdev/20260310104743.907818-1-bjorn@kernel.org/
[2] Generic loopback support, RFC v2
  https://lore.kernel.org/netdev/20260219130050.2390226-1-bjorn@kernel.org/
[3] New loopback modes
  https://lore.kernel.org/netdev/20251024044849.1098222-1-hkelam@marvell.com/
[4] PHY loopback
  https://lore.kernel.org/netdev/20240911212713.2178943-1-maxime.chevallier@bootlin.com/
[5] bnxt_en: add .set_module_eeprom_by_page() support
  https://lore.kernel.org/netdev/20250310183129.3154117-8-michael.chan@broadcom.com/
[6] net/mlx5e: Implement set_module_eeprom_by_page ethtool callback
  https://lore.kernel.org/netdev/20260219130050.2390226-5-bjorn@kernel.org/


Björn Töpel (12):
  ethtool: Add dump_one_dev callback for per-device sub-iteration
  ethtool: Convert per-PHY commands to dump_one_dev
  ethtool: Add loopback netlink UAPI definitions
  ethtool: Add loopback GET/SET netlink implementation
  ethtool: Add CMIS loopback helpers for module loopback control
  selftests: drv-net: Add loopback driver test
  ethtool: Add MAC loopback support via ethtool_ops
  netdevsim: Add MAC loopback simulation
  selftests: drv-net: Add MAC loopback netdevsim test
  MAINTAINERS: Add entry for ethtool loopback
  netdevsim: Add module EEPROM simulation via debugfs
  selftests: drv-net: Add CMIS loopback netdevsim test

 Documentation/netlink/specs/ethtool.yaml      | 142 ++++++
 MAINTAINERS                                   |   6 +
 drivers/net/netdevsim/ethtool.c               | 147 +++++++
 drivers/net/netdevsim/netdevsim.h             |  15 +
 include/linux/ethtool.h                       |  28 ++
 .../uapi/linux/ethtool_netlink_generated.h    |  67 +++
 net/ethtool/Makefile                          |   2 +-
 net/ethtool/cmis_loopback.c                   | 407 ++++++++++++++++++
 net/ethtool/loopback.c                        | 351 +++++++++++++++
 net/ethtool/mse.c                             |   1 +
 net/ethtool/netlink.c                         | 284 ++++--------
 net/ethtool/netlink.h                         |  49 +++
 net/ethtool/phy.c                             |   1 +
 net/ethtool/plca.c                            |   2 +
 net/ethtool/pse-pd.c                          |   1 +
 .../testing/selftests/drivers/net/hw/Makefile |   2 +
 .../selftests/drivers/net/hw/loopback_drv.py  | 227 ++++++++++
 .../selftests/drivers/net/hw/loopback_nsim.py | 343 +++++++++++++++
 18 files changed, 1865 insertions(+), 210 deletions(-)
 create mode 100644 net/ethtool/cmis_loopback.c
 create mode 100644 net/ethtool/loopback.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/loopback_drv.py
 create mode 100755 tools/testing/selftests/drivers/net/hw/loopback_nsim.py


base-commit: d1e59a46973719e458bec78d00dd767d7a7ba71f
-- 
2.53.0


