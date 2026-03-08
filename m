Return-Path: <linux-rdma+bounces-17717-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4D6MBEZvrWme2wEAu9opvQ
	(envelope-from <linux-rdma+bounces-17717-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 13:44:54 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E3D23047D
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 13:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6F2730680BD
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 12:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7134E371040;
	Sun,  8 Mar 2026 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNWbPla8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E5727F749;
	Sun,  8 Mar 2026 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772973653; cv=none; b=tQoB+i7u80HgSKyjS2vfoKU12PauHbqWR9wKlupnJd852422n2jElc71d0nQIYHr9Zta18YQbhO49EFweGF0u0XKUFvPlE+WtNl+4aJ0Twd+2oTJzJ1uxcIqPpsMEgQqiQbGh8XF4OJnQVwaYKte7bHKb74I61btKRg11KEBM98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772973653; c=relaxed/simple;
	bh=2grjSFFYRY6f1rOWikPMtaX7YwYNLtL6HeCQhRoibfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P6PgMKLnD7NGNmkhn1nE0EFCbEzun3AOGf2+1F0EVCcybw2dBVntB6XMMXAOENgs7E6DShdrzHgOzL50AD/EJ8HEd6p4Gf8JsJzZyy1KKSC5LEP2lr1orC72tkTzNw7xRCsvZn6UZajB2uL86yoaZHBEI+rQIjir9UttNyPmSUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNWbPla8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2CBC116C6;
	Sun,  8 Mar 2026 12:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772973652;
	bh=2grjSFFYRY6f1rOWikPMtaX7YwYNLtL6HeCQhRoibfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VNWbPla8yZEy1Eq0vjIjmJxKX+lF8V5Jdh7WD4wzjauSXu5kO6fzZo8nK1YOHIZ5J
	 FMUF9TChOoW1ZcbyDiALYAdpzGHgL22fLA3P9dxB48Ur3UgN1mBQHeWOF90+jWHXWZ
	 snQkZSJcMQwpONpDzcyBvFu9GeuCGmAhF/KYrln+O1pnm9DfgrIKlAwp/CQ5DJIAui
	 cX7cP3nOoKVy+MmuTqXxjnQSPJ6uGSpmSG788N8UykH1BY6E3t77UicayHmxM1iou/
	 vYqz7v8gZ9xEgUzVnIw3TLgfb9d/z1jW0oBS/6O48NCn9t2MIW1i+mcOkTeSc46XWq
	 RXDgbNf05bAQg==
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
Subject: [RFC net-next v2 6/6] selftests: drv-net: Add CMIS loopback netdevsim test
Date: Sun,  8 Mar 2026 13:40:12 +0100
Message-ID: <20260308124016.3134012-7-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308124016.3134012-1-bjorn@kernel.org>
References: <20260308124016.3134012-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A2E3D23047D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.93 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17717-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.971];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lib.py:url,loopback_nsim.py:url]
X-Rspamd-Action: no action

Add loopback_nsim.py with netdevsim-specific tests for CMIS module
loopback. These tests seed the EEPROM via debugfs and verify
register-level behavior.

Tests cover: no-module GET, all/partial capability reporting, EEPROM
byte verification for enable/disable and direction switching,
rejection of unsupported directions, and rejection without CMIS
support.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 .../selftests/drivers/net/hw/loopback_nsim.py | 249 ++++++++++++++++++
 1 file changed, 249 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/loopback_nsim.py

diff --git a/tools/testing/selftests/drivers/net/hw/loopback_nsim.py b/tools/testing/selftests/drivers/net/hw/loopback_nsim.py
new file mode 100755
index 000000000000..ae126da671bb
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/loopback_nsim.py
@@ -0,0 +1,249 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""Netdevsim-specific tests for ethtool CMIS module loopback.
+
+Seeds the CMIS EEPROM via debugfs and verifies register-level
+behavior that can only be checked with controlled EEPROM contents.
+"""
+
+import errno
+import os
+
+from lib.py import ksft_run, ksft_exit, ksft_eq
+from lib.py import KsftSkipEx, KsftFailEx, ksft_disruptive
+from lib.py import EthtoolFamily, NlError
+from lib.py import NetDrvEnv, ip, defer
+
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
+# Direction flags as YNL returns them (sets of flag name strings)
+DIR_NONE = set()
+DIR_NEAR_END = {'near-end'}
+DIR_FAR_END = {'far-end'}
+
+
+def _nsim_dfs_path(cfg):
+    """Return the per-port debugfs path for the netdevsim device."""
+    return cfg._ns.nsims[0].dfs_dir
+
+
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
+    _nsim_write_page_byte(cfg, 0x01, 0x8E, CMIS_DIAG_PAGE13_BIT)
+    _nsim_write_page_byte(cfg, 0x13, 0x80, caps)
+
+
+def _nsim_clear_cmis(cfg):
+    """Clear CMIS identity bytes left by previous tests."""
+    _nsim_write_page_byte(cfg, 0x00, 0, 0)
+    _nsim_write_page_byte(cfg, 0x01, 0x8E, 0)
+    _nsim_write_page_byte(cfg, 0x13, 0x80, 0)
+
+
+def _get_loopback(cfg):
+    """GET loopback and return the list of entries."""
+    result = cfg.ethnl.loopback_get({
+        'header': {'dev-index': cfg.ifindex}
+    })
+    return result.get('entry', [])
+
+
+def _set_loopback(cfg, component, name, direction):
+    """SET loopback for a single entry."""
+    cfg.ethnl.loopback_set({
+        'header': {'dev-index': cfg.ifindex},
+        'entry': [{
+            'component': component,
+            'name': name,
+            'direction': direction,
+        }]
+    })
+
+
+def test_get_no_module(cfg):
+    """GET on a device with no CMIS module returns no entries."""
+    _nsim_clear_cmis(cfg)
+
+    try:
+        entries = _get_loopback(cfg)
+        ksft_eq(len(entries), 0, "Expected no entries without CMIS module")
+    except NlError as e:
+        ksft_eq(e.error, errno.EOPNOTSUPP,
+                "Expected EOPNOTSUPP without CMIS module")
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
+    ksft_eq(val, 0xFF, "Host Side Input control byte should be 0xFF")
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
+    ksft_eq(val, 0xFF, "Far-end should be enabled after switch")
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
+def main() -> None:
+    with NetDrvEnv(__file__) as cfg:
+        cfg.ethnl = EthtoolFamily()
+
+        ksft_run([
+            test_get_no_module,
+            test_get_all_caps,
+            test_get_partial_caps,
+            test_set_verify_eeprom,
+            test_set_direction_switch_eeprom,
+            test_set_unsupported_direction,
+            test_set_no_cmis,
+        ], args=(cfg, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.53.0


