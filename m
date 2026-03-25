Return-Path: <linux-rdma+bounces-18617-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIwmEW/7w2k/vQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18617-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:12:47 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B16593279C2
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7954033613C2
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 15:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D9B421F06;
	Wed, 25 Mar 2026 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrCUAqPh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC13421A08;
	Wed, 25 Mar 2026 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450312; cv=none; b=EEJuQijTjUz+s4nCM0wp806Z6C5o1PmKkXnOrsUr3BHZV7kg4PXdKJ7575LxV03E9LbulzOeUY25MEAgJJFcIzxRyLb/opl40zbq9ux6g5QHAwrs/lyOswpM2HOs5MY+pFQP0Y9sJ3o0+aseXTEe4TuxD6YU7JZK2rBCS3NnQL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450312; c=relaxed/simple;
	bh=XV2VZGrQGHPZfu3fYItxCRhQl+nUxXRBp7MCGOn/Dlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/acsxPL9rDOhG57DnJU02zUu6DuuDRdcqW6jmMkO7nY97V/fpe+Y609rZUzSFNEPaqoGrfpqRKFHVU7JpMMsHLPZ6+b3lnXPO/JfATBXuF6PVWlI7ZxQRKQI7exG0VlgNy9vaAQzlBYwPRfywgcnjryX9WykehwCSn90VMZ6o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrCUAqPh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A273C2BCB2;
	Wed, 25 Mar 2026 14:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774450311;
	bh=XV2VZGrQGHPZfu3fYItxCRhQl+nUxXRBp7MCGOn/Dlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LrCUAqPh5Um+8mpsOXho7nxZieU/M5EcjPtc3iRbEu5GG7rgY8mg3bOOF3bbcYl3j
	 agKr8NKwyQI4UmCke5pBCHzXwANooTOqASlQL1E3jHdr35FKHJarEjYe3b3rNzNj2Q
	 HH+jNXFsi5XiXjl8kczP1iykOMqrJmFSiXdBHO/OvE8jkbEzco7v10r+7EbhhHipf7
	 g/AggYFoReLYClXzuOotN2kvokTCYPiGv7Wh+Tul4Zqu9t8b6969J45fRsrFBXwEtC
	 qIT0TTNfPjO6XCIy8BtCpSEJO1WcGtgPZW8WAbro2/6ti5ZEeLIKqH4WGDXtd0S3a/
	 KnupZnT564yqA==
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
Subject: [PATCH net-next v2 12/12] selftests: drv-net: Add CMIS loopback netdevsim test
Date: Wed, 25 Mar 2026 15:50:19 +0100
Message-ID: <20260325145022.2607545-13-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325145022.2607545-1-bjorn@kernel.org>
References: <20260325145022.2607545-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.93 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18617-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loopback_nsim.py:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lib.py:url]
X-Rspamd-Queue-Id: B16593279C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extend loopback_nsim.py with netdevsim-specific tests for CMIS module
loopback. These tests seed the EEPROM via debugfs and verify
register-level behavior.

Tests cover: no-module GET, all/partial capability reporting, EEPROM
byte verification for enable/disable and direction switching,
rejection of unsupported directions, rejection without CMIS support,
and combined MAC + MODULE dump.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 .../selftests/drivers/net/hw/loopback_nsim.py | 207 +++++++++++++++++-
 1 file changed, 206 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/loopback_nsim.py b/tools/testing/selftests/drivers/net/hw/loopback_nsim.py
index d05be09f6c14..f824f5f5d791 100755
--- a/tools/testing/selftests/drivers/net/hw/loopback_nsim.py
+++ b/tools/testing/selftests/drivers/net/hw/loopback_nsim.py
@@ -1,10 +1,13 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
-"""Netdevsim-specific tests for MAC loopback via ethtool_ops.
+"""Netdevsim-specific tests for ethtool loopback.
 
 Verifies that MAC loopback entries appear in dumps, that SET
 operations update state correctly (both via GET and debugfs).
+
+Seeds the CMIS EEPROM via debugfs and verifies register-level
+behavior that can only be checked with controlled EEPROM contents.
 """
 
 import errno
@@ -15,6 +18,20 @@ from lib.py import KsftFailEx, ksft_disruptive
 from lib.py import EthtoolFamily, NlError
 from lib.py import NetDrvEnv, ip, defer
 
+# CMIS register constants matching net/ethtool/cmis_loopback.c
+SFF8024_ID_QSFP_DD = 0x18
+
+# Page 01h, Byte 142: bit 5 = Page 13h supported
+CMIS_DIAG_PAGE13_BIT = 1 << 5
+
+# Page 13h, Byte 128: loopback capability bits
+CMIS_LB_CAP_MEDIA_OUTPUT = 1 << 0
+CMIS_LB_CAP_MEDIA_INPUT = 1 << 1
+CMIS_LB_CAP_HOST_OUTPUT = 1 << 2
+CMIS_LB_CAP_HOST_INPUT = 1 << 3
+CMIS_LB_CAP_ALL = (CMIS_LB_CAP_MEDIA_OUTPUT | CMIS_LB_CAP_MEDIA_INPUT |
+                    CMIS_LB_CAP_HOST_OUTPUT | CMIS_LB_CAP_HOST_INPUT)
+
 # Direction flags as YNL returns them
 DIR_NONE = set()
 DIR_LOCAL = {'local'}
@@ -37,6 +54,54 @@ def _dfs_write_u32(cfg, path, val):
         f.write(str(val))
 
 
+def _nsim_write_page_byte(cfg, page, offset, value):
+    """Write a single byte to a netdevsim EEPROM page via debugfs."""
+    if offset < 128:
+        page_file = os.path.join(_nsim_dfs_path(cfg),
+                                 "ethtool/module/pages/0")
+        file_offset = offset
+    else:
+        page_file = os.path.join(_nsim_dfs_path(cfg),
+                                 f"ethtool/module/pages/{page}")
+        file_offset = offset - 128
+
+    with open(page_file, "r+b") as f:
+        f.seek(file_offset)
+        f.write(bytes([value]))
+
+
+def _nsim_read_page_byte(cfg, page, offset):
+    """Read a single byte from a netdevsim EEPROM page via debugfs."""
+    if offset < 128:
+        page_file = os.path.join(_nsim_dfs_path(cfg),
+                                 "ethtool/module/pages/0")
+        file_offset = offset
+    else:
+        page_file = os.path.join(_nsim_dfs_path(cfg),
+                                 f"ethtool/module/pages/{page}")
+        file_offset = offset - 128
+
+    with open(page_file, "rb") as f:
+        f.seek(file_offset)
+        return f.read(1)[0]
+
+
+def _nsim_seed_cmis(cfg, caps=CMIS_LB_CAP_ALL):
+    """Seed the netdevsim EEPROM with CMIS module identity and
+    loopback capabilities.
+    """
+    _nsim_write_page_byte(cfg, 0x00, 0, SFF8024_ID_QSFP_DD)
+    _nsim_write_page_byte(cfg, 0x01, 0x8e, CMIS_DIAG_PAGE13_BIT)
+    _nsim_write_page_byte(cfg, 0x13, 0x80, caps)
+
+
+def _nsim_clear_cmis(cfg):
+    """Clear CMIS identity bytes left by previous tests."""
+    _nsim_write_page_byte(cfg, 0x00, 0, 0)
+    _nsim_write_page_byte(cfg, 0x01, 0x8e, 0)
+    _nsim_write_page_byte(cfg, 0x13, 0x80, 0)
+
+
 def _get_loopback(cfg):
     results = cfg.ethnl.loopback_get({
         'header': {'dev-index': cfg.ifindex}
@@ -120,6 +185,138 @@ def test_set_mac_unknown_name(cfg):
                 "Expected EOPNOTSUPP for unknown name")
 
 
+def test_get_no_module(cfg):
+    """GET on a device with no CMIS module returns no module entries."""
+    _nsim_clear_cmis(cfg)
+
+    entries = _get_loopback(cfg)
+    mod_entries = [e for e in entries if e['component'] == 'module']
+    ksft_eq(len(mod_entries), 0, "Expected no module entries without CMIS module")
+
+
+def test_get_all_caps(cfg):
+    """GET with all four CMIS loopback capabilities seeded."""
+    _nsim_seed_cmis(cfg, CMIS_LB_CAP_ALL)
+
+    entries = _get_loopback(cfg)
+    mod_entries = [e for e in entries if e['component'] == 'module']
+
+    # Expect 2 entries (one per name), each with both directions
+    ksft_eq(len(mod_entries), 2, "Expected 2 module loopback entries")
+
+    host = [e for e in mod_entries if e['name'] == 'cmis-host']
+    media = [e for e in mod_entries if e['name'] == 'cmis-media']
+    ksft_eq(len(host), 1, "Expected 1 cmis-host entry")
+    ksft_eq(len(media), 1, "Expected 1 cmis-media entry")
+
+    ksft_eq(host[0]['supported'], DIR_LOCAL | DIR_REMOTE)
+    ksft_eq(media[0]['supported'], DIR_LOCAL | DIR_REMOTE)
+
+    for e in mod_entries:
+        ksft_eq(e['direction'], DIR_NONE,
+                f"Expected direction=off for {e['name']}")
+
+
+def test_get_partial_caps(cfg):
+    """GET with only host-input capability advertised."""
+    _nsim_seed_cmis(cfg, CMIS_LB_CAP_HOST_INPUT)
+
+    entries = _get_loopback(cfg)
+    mod_entries = [e for e in entries if e['component'] == 'module']
+    ksft_eq(len(mod_entries), 1, "Expected 1 module loopback entry")
+    ksft_eq(mod_entries[0]['name'], 'cmis-host')
+    ksft_eq(mod_entries[0]['supported'], DIR_LOCAL)
+
+
+@ksft_disruptive
+def test_set_verify_eeprom(cfg):
+    """SET local loopback and verify the EEPROM control byte directly."""
+    _nsim_seed_cmis(cfg, CMIS_LB_CAP_ALL)
+
+    ip(f"link set dev {cfg.ifname} down")
+    defer(ip, f"link set dev {cfg.ifname} up")
+
+    _set_loopback(cfg, 'module', 'cmis-host', 'local')
+    defer(_set_loopback, cfg, 'module', 'cmis-host', 0)
+
+    # Host Side Input = Page 13h, Byte 183
+    val = _nsim_read_page_byte(cfg, 0x13, 183)
+    ksft_eq(val, 0xff, "Host Side Input control byte should be 0xff")
+
+    # Disable and verify
+    _set_loopback(cfg, 'module', 'cmis-host', 0)
+    val = _nsim_read_page_byte(cfg, 0x13, 183)
+    ksft_eq(val, 0x00, "Host Side Input should be 0x00 after disable")
+
+
+@ksft_disruptive
+def test_set_direction_switch_eeprom(cfg):
+    """Switch directions and verify both EEPROM bytes."""
+    _nsim_seed_cmis(cfg, CMIS_LB_CAP_ALL)
+
+    ip(f"link set dev {cfg.ifname} down")
+    defer(ip, f"link set dev {cfg.ifname} up")
+
+    _set_loopback(cfg, 'module', 'cmis-host', 'local')
+    defer(_set_loopback, cfg, 'module', 'cmis-host', 0)
+
+    # Switch to remote
+    _set_loopback(cfg, 'module', 'cmis-host', 'remote')
+
+    # Local (Host Input, Byte 183) should be disabled
+    val = _nsim_read_page_byte(cfg, 0x13, 183)
+    ksft_eq(val, 0x00, "Local should be disabled after switch")
+    # Remote (Host Output, Byte 182) should be enabled
+    val = _nsim_read_page_byte(cfg, 0x13, 182)
+    ksft_eq(val, 0xff, "Remote should be enabled after switch")
+
+
+@ksft_disruptive
+def test_set_unsupported_direction(cfg):
+    """SET with unsupported direction should fail."""
+    _nsim_seed_cmis(cfg, CMIS_LB_CAP_HOST_INPUT)  # only local
+
+    ip(f"link set dev {cfg.ifname} down")
+    defer(ip, f"link set dev {cfg.ifname} up")
+
+    try:
+        _set_loopback(cfg, 'module', 'cmis-host', 'remote')
+        raise KsftFailEx("Should have rejected unsupported direction")
+    except NlError as e:
+        ksft_eq(e.error, errno.EOPNOTSUPP,
+                "Expected EOPNOTSUPP for unsupported direction")
+
+
+@ksft_disruptive
+def test_set_no_cmis(cfg):
+    """SET on a device without CMIS loopback support should fail."""
+    _nsim_clear_cmis(cfg)
+
+    ip(f"link set dev {cfg.ifname} down")
+    defer(ip, f"link set dev {cfg.ifname} up")
+
+    try:
+        _set_loopback(cfg, 'module', 'cmis-host', 'local')
+        raise KsftFailEx("Should have rejected SET without CMIS support")
+    except NlError as e:
+        ksft_eq(e.error, errno.EOPNOTSUPP,
+                "Expected EOPNOTSUPP without CMIS support")
+
+
+def test_combined_dump(cfg):
+    """Dump should return both MAC and MODULE entries."""
+    _nsim_seed_cmis(cfg, CMIS_LB_CAP_ALL)
+    defer(_nsim_clear_cmis, cfg)
+
+    entries = _get_loopback(cfg)
+    mac_entries = [e for e in entries if e['component'] == 'mac']
+    mod_entries = [e for e in entries if e['component'] == 'module']
+
+    ksft_eq(len(mac_entries), 1, "Expected 1 MAC entry")
+    ksft_eq(len(mod_entries), 2, "Expected 2 MODULE entries")
+    ksft_eq(mac_entries[0]['name'], 'mac')
+
+
 def main() -> None:
     """Run netdevsim loopback tests."""
     with NetDrvEnv(__file__) as cfg:
@@ -130,6 +327,14 @@ def main() -> None:
             test_set_mac_local,
             test_set_mac_disable,
             test_set_mac_unknown_name,
+            test_get_no_module,
+            test_get_all_caps,
+            test_get_partial_caps,
+            test_set_verify_eeprom,
+            test_set_direction_switch_eeprom,
+            test_set_unsupported_direction,
+            test_set_no_cmis,
+            test_combined_dump,
         ], args=(cfg, ))
     ksft_exit()
 
-- 
2.53.0


