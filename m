Return-Path: <linux-rdma+bounces-17863-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMxVGGj4r2mmdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17863-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 11:54:32 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F28249C28
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 11:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75C7C30E11DD
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 10:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18093876B8;
	Tue, 10 Mar 2026 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kclfX8XI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8021C3822BD;
	Tue, 10 Mar 2026 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773139739; cv=none; b=DoG8IMMIuIWqYvirWmuEbqcOWjzdKIVh/nxTCQubtAyUrXoDIDTVZWn9QdPDzNf9ye9cchp5R+KZLdFEokkHwEINAJ2zQ3x7poP1RYckHmjIYpjwP7cCMYF/d4cUmrliUf0bYMhnIz5b5Xjm9l82/xDrtLRV7LyqMfy6Zw3pmgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773139739; c=relaxed/simple;
	bh=QjfuMRNUKR1O0Ord6LYD+ihG6XFTihVz0FFS1WwUfO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g15P+nRfwzuS43z/JHfO5fXYXqjWzOGZkDpTyFsEAaSnHtPgLGtsDGsr5AKwbTHiesbp/M7J8/bhCeIwVMo9qutQEYEn5yWHqSeIUsOLJEuSwTvvvq3s4QVu8E/tQe5+mS8jytun2iz4zuKi5lDRfXpJh1uNBUytH9rCxVoCHAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kclfX8XI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6C9C2BCB5;
	Tue, 10 Mar 2026 10:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773139739;
	bh=QjfuMRNUKR1O0Ord6LYD+ihG6XFTihVz0FFS1WwUfO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kclfX8XIN7KO3wWbJ9CL0MxrA0z15wEkNAh/YD5sbd4gVcIAN8njIjeYVNK7XYc9G
	 wft7Mt35ZKf8sYN67xqVRXU0178C0MYdErb+undUdZwHCqRbWQ+RamT7pPN2RaSFQq
	 GYesZEqcPmdNFR3bXkSHj2LNt6kDY72Vmj91AsITkAxYU2/J2/+rQ7NLZrLqZyLcqE
	 pB4IQti6QEVXpMEcq8vZMl/3JMYSAk+RBvSpB4zLJ26wMjh+A6qMngYGOql7uGlJPI
	 8Qnd1azCIGpCxkndZtSiLIpbfVXZE2d0mYHpQqt5OdwKp+8753MKfARUE/v901ob3w
	 R/zC7FgbU6o2Q==
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
Subject: [PATCH net-next 11/11] selftests: drv-net: Add CMIS loopback netdevsim test
Date: Tue, 10 Mar 2026 11:47:41 +0100
Message-ID: <20260310104743.907818-12-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310104743.907818-1-bjorn@kernel.org>
References: <20260310104743.907818-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D1F28249C28
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.96 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17863-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.py:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,loopback_nsim.py:url]
X-Rspamd-Action: no action

Extend loopback_nsim.py with netdevsim-specific tests for CMIS module
loopback. These tests seed the EEPROM via debugfs and verify
register-level behavior.

Tests cover: no-module GET, all/partial capability reporting, EEPROM
byte verification for enable/disable and direction switching,
rejection of unsupported directions, rejection without CMIS
support, and combined MAC + MODULE dump.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 .../selftests/drivers/net/hw/loopback_nsim.py | 207 +++++++++++++++++-
 1 file changed, 206 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/loopback_nsim.py b/tools/testing/selftests/drivers/net/hw/loopback_nsim.py
index 5edc999d920b..26e74718098a 100755
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
@@ -15,6 +18,20 @@ from lib.py import KsftSkipEx, KsftFailEx, ksft_disruptive
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
 DIR_NEAR_END = {'near-end'}
@@ -35,6 +52,54 @@ def _dfs_write_u32(cfg, path, val):
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
@@ -118,6 +183,138 @@ def test_set_mac_unknown_name(cfg):
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
+    ksft_eq(host[0]['supported'], DIR_NEAR_END | DIR_FAR_END)
+    ksft_eq(media[0]['supported'], DIR_NEAR_END | DIR_FAR_END)
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
+    ksft_eq(mod_entries[0]['supported'], DIR_NEAR_END)
+
+
+@ksft_disruptive
+def test_set_verify_eeprom(cfg):
+    """SET near-end and verify the EEPROM control byte directly."""
+    _nsim_seed_cmis(cfg, CMIS_LB_CAP_ALL)
+
+    ip(f"link set dev {cfg.ifname} down")
+    defer(ip, f"link set dev {cfg.ifname} up")
+
+    _set_loopback(cfg, 'module', 'cmis-host', 'near-end')
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
+    _set_loopback(cfg, 'module', 'cmis-host', 'near-end')
+    defer(_set_loopback, cfg, 'module', 'cmis-host', 0)
+
+    # Switch to far-end
+    _set_loopback(cfg, 'module', 'cmis-host', 'far-end')
+
+    # Near-end (Host Input, Byte 183) should be disabled
+    val = _nsim_read_page_byte(cfg, 0x13, 183)
+    ksft_eq(val, 0x00, "Near-end should be disabled after switch")
+    # Far-end (Host Output, Byte 182) should be enabled
+    val = _nsim_read_page_byte(cfg, 0x13, 182)
+    ksft_eq(val, 0xff, "Far-end should be enabled after switch")
+
+
+@ksft_disruptive
+def test_set_unsupported_direction(cfg):
+    """SET with unsupported direction should fail."""
+    _nsim_seed_cmis(cfg, CMIS_LB_CAP_HOST_INPUT)  # only near-end
+
+    ip(f"link set dev {cfg.ifname} down")
+    defer(ip, f"link set dev {cfg.ifname} up")
+
+    try:
+        _set_loopback(cfg, 'module', 'cmis-host', 'far-end')
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
+        _set_loopback(cfg, 'module', 'cmis-host', 'near-end')
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
     with NetDrvEnv(__file__) as cfg:
         cfg.ethnl = EthtoolFamily()
@@ -127,6 +324,14 @@ def main() -> None:
             test_set_mac_near_end,
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


