Return-Path: <linux-rdma+bounces-17711-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2amAEVpurWnN2wEAu9opvQ
	(envelope-from <linux-rdma+bounces-17711-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 13:40:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C40FB2303E1
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 13:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B44CF3027974
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 12:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3BE355F29;
	Sun,  8 Mar 2026 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbMy9rXH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADAA27F749;
	Sun,  8 Mar 2026 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772973624; cv=none; b=sHjjbZyoR3exrEyBpmmiipgT5YIUJYYBMJ7iKtfA/TFGckMyTgjpN9CbMWpb2fQuoyX0uAMopXrxDqCTtQAfqW3zYE+TmLZZ32XBUeGb3LnEG4II34m4ljOJ7WUfOmfnGOV4GcbgQd7quMsHMpvrvNYcWxUb3rhuG8upuouy7MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772973624; c=relaxed/simple;
	bh=uTdKTyk+KLX1pJPbOYt4oct+VIYy1cDoCpDZ51YjCCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eljKfm55yOW7aMMX1m8dlW3laeKGHsryWrz5aLDs2+KfvehbcVIl2MLf8M7XPG5DoV4PsflQ/CX3u8UAq2vHxNuyno4H/G1Z4y9ZFfMYXGSFyTNWsMsFUqxu2f3b/y/w7h2yHmjrzmIZz9Pa8AslghwjIJ5viD6CyHKRon9ZiRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbMy9rXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6505EC116C6;
	Sun,  8 Mar 2026 12:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772973623;
	bh=uTdKTyk+KLX1pJPbOYt4oct+VIYy1cDoCpDZ51YjCCE=;
	h=From:To:Cc:Subject:Date:From;
	b=hbMy9rXH/YrIMZoAb+zy+8nGikcUFBsKxyWQ1Evkpb71tjqhOcM0LICfE753N63Oj
	 nq2VZmhb4MWHSvHusrrZOZLoxoykPJFyiJ3UsM4mi049ceQGyzUEtNiN7Q+MXZOYBw
	 l0DVXm0z/Lg84zJfwBIDk+t4yMsmNEeGi3l9bmYgOQjoEtsxAnZ3wTajmuJlKwct2w
	 8lDpp74jp2w0YgYa+LZNYtkavn2r0enOeslwviqMaKolw9TxvXhhRhXqY+7SPHjfp7
	 4T9IDLZFVI/kR89RRp+PFnMfg6hoYI+tyCTGg7kF5k1dsTQUhUKDYo6JTWg7uwp4Mf
	 BWGxvuWVNZrEg==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: netdev@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Michael Chan <michael.chan@broadcom.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: [RFC net-next v2 0/6] ethtool: Generic loopback support
Date: Sun,  8 Mar 2026 13:40:06 +0100
Message-ID: <20260308124016.3134012-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C40FB2303E1
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-17711-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,kernel.org,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.966];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loopback_nsim.py:url]
X-Rspamd-Action: no action

Hi!

Background
==========

This is the v2 RFC of the CMIS loopback series, reworked based on
feedback from v1 [1].

The main change is that loopback is no longer bolted onto the existing
module interface. Instead, it gets its own netlink commands
(LOOPBACK_GET/SET) with a generic component/name/direction model that
can represent loopback points across the entire data path -- MODULE,
PHY, MAC, and PCS. This series wires up MODULE/CMIS as the first user;
the other component types return -EOPNOTSUPP for now.

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

Implementation
==============

Patch 1/6 ethtool: Add loopback netlink UAPI definitions
  Adds the YAML spec and generated UAPI header for the new
  LOOPBACK_GET/SET commands. Each loopback entry carries a component
  type, optional id, name string, supported directions bitmask, and
  current direction.

Patch 2/6 ethtool: Add loopback GET/SET netlink implementation
  Implements GET/SET dispatch in a new loopback.c. GET collects
  entries from each subsystem. SET switches on the component and
  calls the right handler per entry. No components are wired yet.

Patch 3/6 ethtool: add CMIS loopback helpers for module loopback control
  Adds cmis_loopback.c with the MODULE component handlers. GET reads
  Page 13h and appends one entry per supported loopback point
  ("cmis-host" and/or "cmis-media"). SET resolves name to control
  byte indices and enforces mutual exclusivity -- switching directions
  first disables the active one in a separate EEPROM write, then
  enables the new one.

Patch 4/6 selftests: drv-net: Add loopback driver test
  Adds loopback_drv.py with generic tests that work on any device
  with module loopback support: enable/disable, direction switching,
  idempotent enable, and rejection while interface is up.

Patch 5/6 netdevsim: Add module EEPROM simulation via debugfs
  Adds get/set_module_eeprom_by_page to netdevsim, backed by a
  256-page x 128-byte array exposed via debugfs. This enables
  testing the CMIS loopback path without hardware.

Patch 6/6 selftests: drv-net: Add CMIS loopback netdevsim test
  Adds loopback_nsim.py with netdevsim-specific tests that seed the
  EEPROM via debugfs: capability reporting, EEPROM byte verification,
  and error paths for unsupported or missing CMIS support.

Limitations
===========

Only MODULE/CMIS is wired up. PHY, MAC, and PCS loopback are defined
in the UAPI but not yet implemented.

No per-lane support -- loopback is all-or-nothing (0xFF/0x00) across
lanes.

Extending to PHY/MAC/PCS
=========================

PHY loopback can walk phy_link_topology to enumerate PHYs by phyindex
and call phy_loopback() directly. MAC and PCS loopback can route
through phylink via new mac_set_loopback()/pcs_set_loopback()
callbacks. Drivers that don't use phylink could add new ethtool_ops.
The dispatch framework already handles all component types.

Open questions
==============

 - Is this the right extensibility model? I'd appreciate input from
   other NIC vendors on whether component/name/direction is flexible
   enough for their loopback implementations. Also, from the PHY/port
   folks (Maxime, Russell)!

 - The MODULE id field is currently unused. For multi-module setups it
   could serve as a port selector. It could also help detect module
   swaps -- a hash of the CMIS vendor serial number (Page 00h, Bytes
   168-183), vendor name, and part number would give userspace a
   stable identifier to verify the module hasn't changed since
   loopback was configured. Worth adding now, or defer until there's a
   concrete user?

 - Are patches 5-6 (netdevsim EEPROM simulation + netdevsim-specific
   tests) worth carrying? They drive the CMIS Page 13h registers from
   debugfs, which gives good coverage without hardware, but it's
   another netdevsim surface to maintain. If the consensus is that the
   generic driver tests (patch 4) are sufficient, I'm happy to drop
   them.

Related work
============

[1] CMIS loopback v1
  https://lore.kernel.org/netdev/20260219130050.2390226-1-bjorn@kernel.org/
[2] New loopback modes
  https://lore.kernel.org/netdev/20251024044849.1098222-1-hkelam@marvell.com/
[3] PHY loopback
  https://lore.kernel.org/netdev/20240911212713.2178943-1-maxime.chevallier@bootlin.com/
[4] bnxt_en: add .set_module_eeprom_by_page() support
  https://lore.kernel.org/netdev/20250310183129.3154117-8-michael.chan@broadcom.com/


Björn Töpel (6):
  ethtool: Add loopback netlink UAPI definitions
  ethtool: Add loopback GET/SET netlink implementation
  ethtool: add CMIS loopback helpers for module loopback control
  selftests: drv-net: Add loopback driver test
  netdevsim: Add module EEPROM simulation via debugfs
  selftests: drv-net: Add CMIS loopback netdevsim test

 Documentation/netlink/specs/ethtool.yaml      | 115 ++++++
 drivers/net/netdevsim/ethtool.c               |  79 ++++
 drivers/net/netdevsim/netdevsim.h             |  11 +
 include/linux/ethtool.h                       |  28 ++
 .../uapi/linux/ethtool_netlink_generated.h    |  52 +++
 net/ethtool/Makefile                          |   2 +-
 net/ethtool/cmis_loopback.c                   | 338 ++++++++++++++++++
 net/ethtool/loopback.c                        | 248 +++++++++++++
 net/ethtool/netlink.c                         |  20 ++
 net/ethtool/netlink.h                         |   8 +
 .../selftests/drivers/net/hw/loopback_drv.py  | 227 ++++++++++++
 .../selftests/drivers/net/hw/loopback_nsim.py | 249 +++++++++++++
 12 files changed, 1376 insertions(+), 1 deletion(-)
 create mode 100644 net/ethtool/cmis_loopback.c
 create mode 100644 net/ethtool/loopback.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/loopback_drv.py
 create mode 100755 tools/testing/selftests/drivers/net/hw/loopback_nsim.py


base-commit: 0bcac7b11262557c990da1ac564d45777eb6b005
-- 
2.53.0


