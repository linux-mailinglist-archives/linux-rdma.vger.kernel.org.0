Return-Path: <linux-rdma+bounces-17010-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHiVMJsJl2nvtwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17010-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 14:01:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED8C15ECCE
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 14:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8E78302BA61
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 13:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C0530ACEB;
	Thu, 19 Feb 2026 13:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iijQUlJj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE641CEAC2;
	Thu, 19 Feb 2026 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771506064; cv=none; b=s0qCK1f96mgIGDlJBGHel/xzzBU9XXuFCwwvxigGy4nT5lk2XDUwOovHmCWvcYt8g2a+EUZrzEnGNARlYQPi57PeKYIl27kCcMXNGv7HqmquekQvtGQI0pvVI079I/8Bg5+TZ8g5wG8PQOx7HPytBOR10LgReUQc1CaBaTOlbIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771506064; c=relaxed/simple;
	bh=55waRmjJ7guMBnCIazhGBHO12IzwYkWgvePwNekWG3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iTLC2BOtx5WeG4lpPe6pYLcLmJmkL3wd+BtZRDneaXpPNuckIkMI/BtbmPWelzeP7H/FvOVdr472WyTRd1ISpOF0AhvEr8XwMxZ6Xnu+wu2M6uLTe9Ls7ZJjcesv4BLEyFaYqZNLs96X6kR9HHNRd3lMY7cVYpKDoOraRKrbtoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iijQUlJj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5D7C4CEF7;
	Thu, 19 Feb 2026 13:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771506064;
	bh=55waRmjJ7guMBnCIazhGBHO12IzwYkWgvePwNekWG3E=;
	h=From:To:Cc:Subject:Date:From;
	b=iijQUlJjaWEIcHnzWiBIowKLXuq3YAXF/+Qw0TvhEXbL9XX19soSWIV1ijyOqVQUi
	 j0KmPCOz8ehoDnscB65wydlIgJ9iXwLkxyM6nbwYFAxkRWkLUFieDb8F7k7quzBoFv
	 MzPNG8QbySBjIoKGmeZbSqI6ezlHbcHnjtrbkTZNdi5HzPUx2ivCPoQPEVAjfNa8mX
	 eulNN9cGcAXXw8i3PdhAG1cSYMp9DS+LqatZcXSBP8lAPuZscOrIRSyMXUGxgrTsn0
	 rdPRBBC0BU4j49Lc5z6xVwz6gVkw/Iiy9PyflS4QrO1bd80cJpyLlvIaZm+UIYhOr/
	 JjuEq98CKHg3A==
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
	linux-rdma@vger.kernel.org
Subject: [RFC net-next 0/4] ethtool: CMIS module diagnostic loopback support
Date: Thu, 19 Feb 2026 14:00:41 +0100
Message-ID: <20260219130050.2390226-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.05 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.71)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17010-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,kernel.org,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6ED8C15ECCE
X-Rspamd-Action: no action

Hi!

Background
==========

This series adds initial ethtool support for CMIS loopback.

The Common Management Interface Specification (CMIS) is an
industry-standard used by host devices (like switches and routers) to
talk to high-speed optical transceivers (like QSFP-DD, OSFP, and
QSFP112).

Ethtool already supports mechanism updating the transceiver firmware
via CMIS, and this series builds on top of this work.

In CMIS, four different types of loopback are defined by the
specification, characterized by the location of the loopback on Host
(electrical) or Media (optical) Side and the direction of the signal
being looped-back:

* Media Side Output (Tx->Rx) Loopback
* Media Side Input (Rx->Tx) Loopback
* Host Side Output (Tx->Rx) Loopback
* Host Side Input (Rx->Tx) Loopback 

To detect and enable loopback in a CMIS transceiver, the following
registers are used:

* Detect Support: Read Page 13h, Byte 128 indicate if the hardware
  supports host-side or media-side loopback.

* Enable Loopback: Write to Page 13h, Bytes 180–184. Each bit in these
  registers typically corresponds to a specific lane (0–7). Setting a
  bit to 1 requests loopback for that lane.


Implementation
==============

Patch 1/4 ethtool: module: Define CMIS loopback YAML spec and UAPI
  Adds the netlink YAML specification and UAPI for module loopback.
  Defines a flags enum with the four CMIS 5.2 diagnostic loopback
  types (media-side output/input, host-side output/input) and two new
  module attributes: loopback-capabilities (supported modes) and
  loopback-enabled (active modes). Regenerates the UAPI header.

Patch 2/4 ethtool: module: Add CMIS loopback GET/SET support
  Implements the core loopback GET/SET logic for CMIS modules. Reads
  capabilities from Page 01h Byte 142 and controls loopback via Page
  13h Bytes 180-183, using the existing get/set_module_eeprom_by_page
  driver ops. No new ethtool_ops callbacks are introduced.
  
Patch 3/4 ethtool: module: refactor fw flash init to reuse CMIS
  helpers Refactors module_flash_fw_work_init() to reuse the
  module_is_cmis() helper and ethtool_cmis_page_init() introduced in
  patch 2, removing open-coded CMIS type checking and manual EEPROM
  page setup from the firmware flash path.

Patch 4/4 net/mlx5e: Implement set_module_eeprom_by_page ethtool
  callback Adds EEPROM write support to mlx5 by implementing
  set_module_eeprom_by_page, mirroring the existing read path via the
  MCIA register. This enables the loopback SET path which requires
  both get and set callbacks.


Limitations
===========

Only four modes are supported host/media-side near-/far-end. No
per-lane support.

I'm working on kselftest; It's not part of the RFC.


RFC
===

I'm not familiar with the mlx5 internals, and need guidance if my
set_module_eeprom_by_page() hack is the right way forward. I've tested
this on a transceiver in a CX7 NIC, and it did switch on the loopback
mode, so it's somewhat working.

I'd like input from other NIC vendors, if the
{set,get}_module_eeprom_by_page() is the right interface/ops from a
driver POV.

Extensibility; Is this the right interface?


Related work
============

* New loopback modes [1].
* PHY loopback [2]
* bnxt_en: add .set_module_eeprom_by_page() support [3]
* ethtool: qsfp transceiver reset, interrupt and presence pin control
  [4]

[1] https://lore.kernel.org/netdev/20251024044849.1098222-1-hkelam@marvell.com/
[2] https://lore.kernel.org/netdev/20240911212713.2178943-1-maxime.chevallier@bootlin.com/
[3] https://lore.kernel.org/netdev/20250310183129.3154117-8-michael.chan@broadcom.com/
[4] https://lore.kernel.org/netdev/20250513224017.202236-1-mpazdan@arista.com/


Björn Töpel (4):
  ethtool: module: Define CMIS loopback YAML spec and UAPI
  ethtool: module: Add CMIS loopback GET/SET support
  ethtool: module: refactor fw flash init to reuse CMIS helpers
  net/mlx5e: Implement set_module_eeprom_by_page ethtool callback

 Documentation/netlink/specs/ethtool.yaml      |  27 ++
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  52 ++-
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |   6 +-
 .../net/ethernet/mellanox/mlx5/core/port.c    |  34 +-
 include/linux/ethtool.h                       |  12 +
 .../uapi/linux/ethtool_netlink_generated.h    |  22 ++
 net/ethtool/module.c                          | 302 ++++++++++++++++--
 net/ethtool/netlink.h                         |   2 +-
 8 files changed, 397 insertions(+), 60 deletions(-)


base-commit: 37a93dd5c49b5fda807fd204edf2547c3493319c
-- 
2.53.0


