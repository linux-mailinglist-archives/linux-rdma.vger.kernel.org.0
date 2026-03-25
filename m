Return-Path: <linux-rdma+bounces-18611-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGvwKeEAxGmlvQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18611-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:36:01 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D15D328215
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C476D31F0178
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 14:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBB73FFAAE;
	Wed, 25 Mar 2026 14:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pa6hIt7r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D503FEB1B;
	Wed, 25 Mar 2026 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450273; cv=none; b=n7+d+GDlLTDrzKLwvs5sBX6FuxYqW3fxwMRD2Lmli2/fR8sw6Y9qI+I6R6Srj1x2D4GyAr2+gDHBdUiB+wVyGjxfeUB+C1IBWJ84jkToPdE+vsb9JzN+ixAmpdvq250ILfd4eSx7bBCpWifcGpkJgpZlybgsFTVKWj9tvNuvO2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450273; c=relaxed/simple;
	bh=Ln70k+Ew5lUs03kdLTgoObxn1tC6NB4Q3fZApdGNOL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HfYl9/3qE2550z5T+nyYiZCXSfHu0dghj5pyJExgAPpQIuO7lyuWfjpAANnHfqJ+nM6XViQl+DjWk/WTiFfU0hrfiComcUZG89E5REUhyJ34AptLS9ZCuezVCzeq9tbO0BxATQoxj5VCKl5xz8S7gRolEYN78s8zLUsYhoLcXCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pa6hIt7r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036E3C19423;
	Wed, 25 Mar 2026 14:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774450272;
	bh=Ln70k+Ew5lUs03kdLTgoObxn1tC6NB4Q3fZApdGNOL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pa6hIt7rhVJAOBw1PLMhpW4yV2rK4kbASBH63qosX17RY5Rd29tbPOt8SKPaB66pl
	 i57+k4ZknP4/QbxfF06v4VTcDaUcctdRMSqvbLrMRqLawqs/cIVnVQwDAD36eVpFir
	 9X8FoLqNSqrLBWuO35Coz7ZO6FRwVZDdXFCnlGAWIq1jfBgAeYrI/WKcWZTlu7ZJYh
	 aM7BLgSbLn8iWvsnanEqz+/W1tF08ufRjQ3cuaHqkM9wZ6Ux6L+KHP8W3Q3L5RLb6y
	 TOQqHeVAuqdafRoMCdR/j32721c8M+qfiqo69rE4lIy8eLwo2+QrS1O/PAh5JBL6P1
	 QAxZ4MX1v/brA==
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
Subject: [PATCH net-next v2 06/12] selftests: drv-net: Add loopback driver test
Date: Wed, 25 Mar 2026 15:50:13 +0100
Message-ID: <20260325145022.2607545-7-bjorn@kernel.org>
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
X-Spamd-Result: default: False [0.96 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18611-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,loopback_drv.py:url,lib.py:url]
X-Rspamd-Queue-Id: 0D15D328215
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a selftest for the ethtool loopback UAPI exercising module
loopback via the loopback GET/SET netlink commands.

Works on any device that reports module loopback entries. Tests cover
enable local and remote, disable, direction switching (mutual
exclusivity), idempotent enable, and rejection while interface is up.
Devices without module loopback support are skipped.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../selftests/drivers/net/hw/loopback_drv.py  | 227 ++++++++++++++++++
 2 files changed, 228 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/loopback_drv.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 3c97dac9baaa..5a6037a71f8f 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -32,6 +32,7 @@ TEST_PROGS = \
 	iou-zcrx.py \
 	irq.py \
 	loopback.sh \
+	loopback_drv.py \
 	nic_timestamp.py \
 	nk_netns.py \
 	pp_alloc_fail.py \
diff --git a/tools/testing/selftests/drivers/net/hw/loopback_drv.py b/tools/testing/selftests/drivers/net/hw/loopback_drv.py
new file mode 100755
index 000000000000..2d4652386159
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/loopback_drv.py
@@ -0,0 +1,227 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""Tests for ethtool loopback GET/SET with CMIS modules.
+
+Works on any device that reports module loopback entries. On devices
+without CMIS loopback support, tests are skipped.
+"""
+
+import errno
+
+from lib.py import ksft_run, ksft_exit, ksft_eq
+from lib.py import KsftSkipEx, KsftFailEx, ksft_disruptive
+from lib.py import EthtoolFamily, NlError
+from lib.py import NetDrvEnv, ip, defer
+
+# Direction flags as YNL returns them (sets of flag name strings)
+DIR_NONE = set()
+DIR_LOCAL = {'local'}
+DIR_REMOTE = {'remote'}
+
+
+def _get_loopback(cfg):
+    """GET loopback and return the list of entries (via DUMP)."""
+    results = cfg.ethnl.loopback_get({
+        'header': {'dev-index': cfg.ifindex}
+    }, dump=True)
+    entries = []
+    for msg in results:
+        if 'entry' in msg:
+            entries.extend(msg['entry'])
+    return entries
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
+def _require_module_entries(cfg):
+    """Return module loopback entries, skip if none available."""
+    entries = _get_loopback(cfg)
+    mod_entries = [e for e in entries if e['component'] == 'module']
+    if not mod_entries:
+        raise KsftSkipEx("No module loopback entries")
+    return mod_entries
+
+
+@ksft_disruptive
+def test_set_local(cfg):
+    """SET a module entry to local loopback and verify via GET."""
+    mod_entries = _require_module_entries(cfg)
+
+    near = [e for e in mod_entries
+            if 'local' in e['supported']]
+    if not near:
+        raise KsftSkipEx("No local capable module entry")
+
+    ip(f"link set dev {cfg.ifname} down")
+    defer(ip, f"link set dev {cfg.ifname} up")
+
+    target = near[0]
+    _set_loopback(cfg, 'module', target['name'], 'local')
+    defer(_set_loopback, cfg, 'module', target['name'], 0)
+
+    entries = _get_loopback(cfg)
+    updated = [e for e in entries
+               if e['name'] == target['name']
+               and 'local' in e['supported']]
+    ksft_eq(len(updated), 1)
+    ksft_eq(updated[0]['direction'], DIR_LOCAL)
+
+
+@ksft_disruptive
+def test_set_remote(cfg):
+    """SET a module entry to remote loopback and verify via GET."""
+    mod_entries = _require_module_entries(cfg)
+
+    far = [e for e in mod_entries
+           if 'remote' in e['supported']]
+    if not far:
+        raise KsftSkipEx("No remote capable module entry")
+
+    ip(f"link set dev {cfg.ifname} down")
+    defer(ip, f"link set dev {cfg.ifname} up")
+
+    target = far[0]
+    _set_loopback(cfg, 'module', target['name'], 'remote')
+    defer(_set_loopback, cfg, 'module', target['name'], 0)
+
+    entries = _get_loopback(cfg)
+    updated = [e for e in entries
+               if e['name'] == target['name']
+               and 'remote' in e['supported']]
+    ksft_eq(len(updated), 1)
+    ksft_eq(updated[0]['direction'], DIR_REMOTE)
+
+
+@ksft_disruptive
+def test_set_disable(cfg):
+    """Enable then disable loopback and verify."""
+    mod_entries = _require_module_entries(cfg)
+
+    near = [e for e in mod_entries
+            if 'local' in e['supported']]
+    if not near:
+        raise KsftSkipEx("No local capable module entry")
+
+    ip(f"link set dev {cfg.ifname} down")
+    defer(ip, f"link set dev {cfg.ifname} up")
+
+    target = near[0]
+    _set_loopback(cfg, 'module', target['name'], 'local')
+    defer(_set_loopback, cfg, 'module', target['name'], 0)
+
+    # Disable
+    _set_loopback(cfg, 'module', target['name'], 0)
+
+    entries = _get_loopback(cfg)
+    updated = [e for e in entries if e['name'] == target['name']]
+    ksft_eq(updated[0]['direction'], DIR_NONE,
+            "Direction should be off after disable")
+
+
+@ksft_disruptive
+def test_set_direction_switch(cfg):
+    """Enable local, then switch to remote. The kernel must disable
+    local before enabling remote (mutual exclusivity).
+    """
+    mod_entries = _require_module_entries(cfg)
+
+    both = [e for e in mod_entries
+            if 'local' in e['supported'] and 'remote' in e['supported']]
+    if not both:
+        raise KsftSkipEx("No entry with both local and remote support")
+
+    ip(f"link set dev {cfg.ifname} down")
+    defer(ip, f"link set dev {cfg.ifname} up")
+
+    target = both[0]
+    _set_loopback(cfg, 'module', target['name'], 'local')
+    defer(_set_loopback, cfg, 'module', target['name'], 0)
+
+    entries = _get_loopback(cfg)
+    updated = [e for e in entries if e['name'] == target['name']]
+    ksft_eq(updated[0]['direction'], DIR_LOCAL)
+
+    # Switch to remote
+    _set_loopback(cfg, 'module', target['name'], 'remote')
+
+    entries = _get_loopback(cfg)
+    updated = [e for e in entries if e['name'] == target['name']]
+    ksft_eq(updated[0]['direction'], DIR_REMOTE,
+            "Should have switched to remote")
+
+
+@ksft_disruptive
+def test_set_idempotent(cfg):
+    """Enable the same direction twice. Second call should not fail."""
+    mod_entries = _require_module_entries(cfg)
+
+    near = [e for e in mod_entries
+            if 'local' in e['supported']]
+    if not near:
+        raise KsftSkipEx("No local capable module entry")
+
+    ip(f"link set dev {cfg.ifname} down")
+    defer(ip, f"link set dev {cfg.ifname} up")
+
+    target = near[0]
+    _set_loopback(cfg, 'module', target['name'], 'local')
+    defer(_set_loopback, cfg, 'module', target['name'], 0)
+
+    # Second enable of the same direction should succeed
+    _set_loopback(cfg, 'module', target['name'], 'local')
+
+    entries = _get_loopback(cfg)
+    updated = [e for e in entries
+               if e['name'] == target['name']
+               and 'local' in e['supported']]
+    ksft_eq(updated[0]['direction'], DIR_LOCAL,
+            "Direction should still be local")
+
+
+@ksft_disruptive
+def test_set_while_up(cfg):
+    """SET while interface is UP should fail."""
+    mod_entries = _require_module_entries(cfg)
+
+    target = mod_entries[0]
+    direction = 'local'
+    if direction not in target['supported']:
+        direction = 'remote'
+
+    try:
+        _set_loopback(cfg, 'module', target['name'], direction)
+        raise KsftFailEx("Should have rejected SET while interface is up")
+    except NlError as e:
+        ksft_eq(e.error, errno.EBUSY,
+                "Expected EBUSY when interface is up")
+
+
+def main() -> None:
+    """Run loopback driver tests."""
+    with NetDrvEnv(__file__, nsim_test=False) as cfg:
+        cfg.ethnl = EthtoolFamily()
+
+        ksft_run([
+            test_set_local,
+            test_set_remote,
+            test_set_disable,
+            test_set_direction_switch,
+            test_set_idempotent,
+            test_set_while_up,
+        ], args=(cfg, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.53.0


