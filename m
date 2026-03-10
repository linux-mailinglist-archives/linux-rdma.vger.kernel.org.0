Return-Path: <linux-rdma+bounces-17852-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PX3Nkj3r2mmdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17852-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 11:49:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 478B6249AD4
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 11:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 609B03142045
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 10:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243BA374747;
	Tue, 10 Mar 2026 10:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDV4lwiW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8058313298;
	Tue, 10 Mar 2026 10:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773139672; cv=none; b=Xds1YnDt3kh5QP33z+LwkPVgaFt+DIJKnCVhi7fcFslYmQpbF7oLPMHzKvAcpncKwKzHqIYOPKYJbz5ziHmkILXOrcRSsDsCNOL+xbhSr3JA4NrR/riPShRiSwrb2TFVpaW5D2bFPi3JFKFytS3wQ9CUwuk7GbItJxpDzAhzWcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773139672; c=relaxed/simple;
	bh=7B21ULlz+HkbtuwJWheYOsnVMGIsw3sf0QCldUc8W3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hYEtXT0iT6Ha86BtsBwfI7qO8HY2ASARZJwwmFli2dZL4+c9TqKVV5k0PHRQmltXZGErSJbkmhwkrU7PLOaxBbO3gIvBSEw7turbTIWTu0eR1OfN8zX+Nh1R2wk3wkLWKAAK2ewI1i9DlsIhGKoW52+dzmeshBRto/DDU8O73HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDV4lwiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF1DC2BC86;
	Tue, 10 Mar 2026 10:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773139672;
	bh=7B21ULlz+HkbtuwJWheYOsnVMGIsw3sf0QCldUc8W3A=;
	h=From:To:Cc:Subject:Date:From;
	b=JDV4lwiWSTlfUae2g4iK3fiCEv1vf3DOOwwCyYpmbtjG3lsIH3wWuszeMDtpONUnl
	 +5fMuXF5nza7hx5D9ZZfuNU14ELv5Ef/xanqDIux9N6kN23HME2OY2Jkwg7qo7HA1N
	 cWprgRuO0hSgHXII8kJMzzWjRlM/+ci5s3HU3PUEKRjP0/RZIFM5N3acOCZVQE5Wzn
	 KSBi2WA3jh7sgHeSQZu2x6Nm3IPfFhRUIuA6yd1PmxKoJun7UjmKQoiWOK+XLGZqrb
	 iPxyyXW5wLCaOmI8q6JVeTlnFC6dM/XUn+/3GGWcI8tbLqSNDh/LntkNGtXdmN4zz4
	 UrVWfnrsmcxqA==
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
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next 00/11] ethtool: Generic loopback support
Date: Tue, 10 Mar 2026 11:47:30 +0100
Message-ID: <20260310104743.907818-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 478B6249AD4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.17 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.83)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17852-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,kernel.org,bootlin.com,marvell.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,marvell.com,bootlin.com,broadcom.com,pengutronix.de,gmail.com,armlinux.org.uk,google.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,loopback_nsim.py:url,loopback_drv.py:url]
X-Rspamd-Action: no action

Hi!

Background
==========

This series adds a generic ethtool loopback framework with GET/SET
netlink commands, using a component/id/name/direction model that can
(Hopefully! Please refer to "Open questions" below.) represent
loopback points across the network path (MAC, MODULE, PHY, PCS).

This is the v1 proper of the loopback series, reworked based on
feedback from previous RFC v2 [1].

The main change since the RFC v2 is that LOOPBACK_GET no longer
returns an array of entries in a single doit reply. Instead, it uses
the dumpit infrastructure -- each loopback entry is a separate netlink
message in a DUMP response. This follows the same pattern as PHY_GET
and the perphy helpers in net/ethtool/netlink.c, as suggested by
Maxime.

A filtered DUMP (with a dev-index in the header) lists all loopback
entries for that netdev; an unfiltered DUMP iterates over all netdevs.
The doit handler is also available: when the request includes an
ETHTOOL_A_LOOPBACK_ENTRY nest with component + name, it returns that
specific entry.

The loopback model remains the same: LOOPBACK_GET/SET with a generic
component/name/direction model that can represent loopback points
across the data path -- MODULE, PHY, MAC, and PCS. This series wires
up MODULE/CMIS and MAC as the first users; PHY and PCS return
-EOPNOTSUPP for now.

Loopback lookup and enumeration
===============================

Each loopback entry is uniquely identified by the tuple (component,
id, name). The kernel provides two GET paths:

 - Exact lookup (doit): the user specifies component + name (and
   optionally id) in the request. The kernel dispatches to the right
   component handler: for MAC, it calls the driver's
   get_loopback(dev, name, id, entry) ethtool_op; for MODULE, it
   calls ethtool_cmis_get_loopback(dev, name, entry). Returns a
   single entry or -EOPNOTSUPP.

 - Index enumeration (dump): the kernel iterates a flat index space
   across all components on a device. Each component's
   get_loopback_by_index(dev, index, entry) is tried in order (MAC
   first via ethtool_ops, then MODULE/CMIS). The dump stops when all
   components return -EOPNOTSUPP. This integrates with the generic
   dump_one_dev sub-iterator infrastructure added in patch 1.

SET takes one or more entries, each with component + name + direction,
and dispatches to the driver's set_loopback() ethtool_op (MAC) or
ethtool_cmis_set_loopback() (MODULE).

The Common Management Interface Specification (CMIS) defines four
diagnostic loopback types, characterized by location (Host or Media
Side) and signal direction:

 - Host Side Input (Rx->Tx) -- near-end
 - Host Side Output (Tx->Rx) -- far-end
 - Media Side Input (Rx->Tx) -- near-end
 - Media Side Output (Tx->Rx) -- far-end

Support is detected via Page 13h Byte 128, and loopback is controlled
via Page 13h Bytes 180-183 (one byte per type, one bit per lane).

The CMIS helpers work entirely over get/set_module_eeprom_by_page, so
any driver that already has EEPROM page access gets module loopback
without new ethtool_ops or driver changes.

Currently, only mellanox/mlxsw, and broadcom/bnxt support CMIS
operations. I'll follow-up with mlx5 support.

Implementation
==============

Patch 1/11 ethtool: Add dump_one_dev callback for per-device sub-iteration
  Replaces the per-PHY specific dump functions with a generic
  sub-iterator infrastructure driven by a dump_one_dev callback in
  ethnl_request_ops. When ops->dump_one_dev is set,
  ethnl_default_start() saves the target device's ifindex for
  filtered dumps, and ethnl_default_dumpit() delegates per-device
  iteration to the callback. No separate start/dumpit/done functions
  are needed.

Patch 2/11 ethtool: Add loopback netlink UAPI definitions
  Adds the YAML spec and generated UAPI header for the new
  LOOPBACK_GET/SET commands. Each loopback entry carries a component
  type, optional id, name string, supported directions bitmask, and
  current direction.

Patch 3/11 ethtool: Add loopback GET/SET netlink implementation
  Implements GET/SET dispatch in a new loopback.c. GET uses the
  dump_one_dev infrastructure for dump enumeration (by flat index)
  and supports doit exact lookup by (component, id, name) via
  parse_request. SET switches on the component and calls the right
  handler per entry. No components are wired yet.

Patch 4/11 ethtool: Add CMIS loopback helpers for module loopback control
  Adds cmis_loopback.c with the MODULE component handlers and wires
  them into loopback.c's dispatch. GET enumerates entries by index
  (ethtool_cmis_get_loopback_by_index) or looks up by name
  (ethtool_cmis_get_loopback). SET (ethtool_cmis_set_loopback)
  resolves name to control byte indices and enforces mutual
  exclusivity.

Patch 5/11 selftests: drv-net: Add loopback driver test
  Adds loopback_drv.py with generic tests that work on any device
  with module loopback support: enable/disable, direction switching,
  idempotent enable, and rejection while interface is up.

Patch 6/11 ethtool: Add MAC loopback support via ethtool_ops
  Extends struct ethtool_ops with three loopback callbacks for
  driver-level MAC loopback: get_loopback (exact lookup by name/id),
  get_loopback_by_index (dump enumeration), and set_loopback. Wires
  the MAC component into loopback.c's dispatch. For dump enumeration,
  MAC entries are tried first, then MODULE/CMIS entries follow at the
  next index offset.

Patch 7/11 netdevsim: Add MAC loopback simulation
  Implements the three ethtool loopback ops in netdevsim. Exposes a
  single MAC loopback entry ("mac") with both near-end and far-end
  support. State is stored in memory and exposed via debugfs under
  ethtool/mac_lb/{supported,direction}.

Patch 8/11 selftests: drv-net: Add MAC loopback netdevsim test
  Adds loopback_nsim.py with netdevsim-specific tests for MAC
  loopback: entry presence, SET/GET round-trip with debugfs
  verification, and error paths.

Patch 9/11 MAINTAINERS: Add entry for ethtool loopback
  Adds a MAINTAINERS entry for the ethtool loopback subsystem covering
  the core loopback and CMIS loopback netlink implementation, and the
  associated selftests.

Patch 10/11 netdevsim: Add module EEPROM simulation via debugfs
  Adds get/set_module_eeprom_by_page to netdevsim, backed by a
  256-page x 128-byte array exposed via debugfs.

Patch 11/11 selftests: drv-net: Add CMIS loopback netdevsim test
  Extends loopback_nsim.py with netdevsim-specific tests that seed the
  EEPROM via debugfs: capability reporting, EEPROM byte verification,
  combined MAC + MODULE dump, and error paths.

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

Limitations
===========

PHY and PCS loopback are defined in the UAPI but not yet implemented.

No per-lane support -- loopback is all-or-nothing (0xff/0x00) across
lanes.

Open questions
==============

 - Is this the right extensibility model? I'd appreciate input from
   other NIC vendors on whether component/name/direction is flexible
   enough for their loopback implementations. Also, from the PHY/port
   folks (Maxime, Russell)! Naveen, please LMK if the MAC side of
   thing, is good enough for Marvell.

 - Are patches 10-11 (netdevsim EEPROM simulation + netdevsim-specific
   tests) worth carrying? They drive the CMIS Page 13h registers from
   debugfs, which gives good coverage without hardware, but it's
   another netdevsim surface to maintain. If the consensus is that the
   generic driver tests (patch 5) are sufficient, I'm happy to drop
   them.

 - Extend mellanox/mlx5 with .set_module_eeprom_by_page() callback. I
   got it to work in [6], but would like feedback from the Mellanox
   folks.

Related work
============

[1] Generic loopback support, RFC v2
  https://lore.kernel.org/netdev/20260219130050.2390226-1-bjorn@kernel.org/
[2] CMIS loopback, RFC v1
  https://lore.kernel.org/netdev/20260219130050.2390226-1-bjorn@kernel.org/
[3] New loopback modes
  https://lore.kernel.org/netdev/20251024044849.1098222-1-hkelam@marvell.com/
[4] PHY loopback
  https://lore.kernel.org/netdev/20240911212713.2178943-1-maxime.chevallier@bootlin.com/
[5] bnxt_en: add .set_module_eeprom_by_page() support
  https://lore.kernel.org/netdev/20250310183129.3154117-8-michael.chan@broadcom.com/
[6] net/mlx5e: Implement set_module_eeprom_by_page ethtool callback
  https://lore.kernel.org/netdev/20260219130050.2390226-5-bjorn@kernel.org/


Björn Töpel (11):
  ethtool: Add dump_one_dev callback for per-device sub-iteration
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

 Documentation/netlink/specs/ethtool.yaml      | 123 ++++++
 MAINTAINERS                                   |   6 +
 drivers/net/netdevsim/ethtool.c               | 147 +++++++
 drivers/net/netdevsim/netdevsim.h             |  15 +
 include/linux/ethtool.h                       |  23 +
 .../uapi/linux/ethtool_netlink_generated.h    |  59 +++
 net/ethtool/Makefile                          |   2 +-
 net/ethtool/cmis_loopback.c                   | 407 ++++++++++++++++++
 net/ethtool/loopback.c                        | 341 +++++++++++++++
 net/ethtool/mse.c                             |   1 +
 net/ethtool/netlink.c                         | 285 ++++--------
 net/ethtool/netlink.h                         |  45 ++
 net/ethtool/phy.c                             |   1 +
 net/ethtool/plca.c                            |   2 +
 net/ethtool/pse-pd.c                          |   1 +
 .../testing/selftests/drivers/net/hw/Makefile |   2 +
 .../selftests/drivers/net/hw/loopback_drv.py  | 226 ++++++++++
 .../selftests/drivers/net/hw/loopback_nsim.py | 340 +++++++++++++++
 18 files changed, 1820 insertions(+), 206 deletions(-)
 create mode 100644 net/ethtool/cmis_loopback.c
 create mode 100644 net/ethtool/loopback.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/loopback_drv.py
 create mode 100755 tools/testing/selftests/drivers/net/hw/loopback_nsim.py


base-commit: 52ede1bce557c66309f41ac29dd190be23ca9129
-- 
2.53.0


