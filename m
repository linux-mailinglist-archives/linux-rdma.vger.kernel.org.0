Return-Path: <linux-rdma+bounces-17715-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKBXBvxurWme2wEAu9opvQ
	(envelope-from <linux-rdma+bounces-17715-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 13:43:40 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F09230452
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 13:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29EB1301F9F5
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 12:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43A5355F29;
	Sun,  8 Mar 2026 12:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBAT6vxV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8594A27F749;
	Sun,  8 Mar 2026 12:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772973643; cv=none; b=X/QTkY1fl/rQWTKaZyF6pRYL6mTUvXodDjXWdY+e2IeKOp/+TJAoIJOLZU206Mhi/rV5/5Luz6xj9Yc5BKQTOvwNfTP2T0oSk5JT9ubVIVA9gH+hp93otSlJ5xXHbeR/7Dwa2Cuu/sk6JSsRHCVAvj0btryT6KEr+fW9hF95Vs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772973643; c=relaxed/simple;
	bh=kvew3wDTsNSCELg3wrpyIX+U/cTVAQVLMk15hqq6t5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sUPYETEJtcBBunY7d7aYCUIrQUMOvrdWvjWrTGOI+zfd9pPC1xMhS0mMXxVqszgFMaD/7edbT6O32hoBKTp/v9DvrKFyMR/8oX1eOwOycxFUSJPHw5wniCd8UFrvyOBg+WfcudtAfPTy9bp+Wc0/ReXgff627R84AE56pESKNLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBAT6vxV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79F3C19423;
	Sun,  8 Mar 2026 12:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772973643;
	bh=kvew3wDTsNSCELg3wrpyIX+U/cTVAQVLMk15hqq6t5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gBAT6vxVeulyApxqYSRbLOm9NeIOua42QEwq+cs6Az17tmyyI7QGCD6rA2br91e6P
	 4VJ2NJAiaw66kcaaxjSrOZg+EQoqGYMJklKmvKoa+l9egGUyiRVaxe83eejoBtj6HT
	 SO/dJIyVYrqSFzouuNynfykPAERR9rsT61x1Z9lIU2ikA+wuswyg0LMx6mVfBBToOU
	 HloX3DNR/U5Jvvda9f5BaMLOUlFws2EC239fcdBz/xX9aVox8ZJqiqHxr/0Mot26b0
	 wxwkRdlVWtPqxpJLY3YUfbEcjVc2O29g85Y1wj3jpogpzeqMrSBAKcaWZYazM4eLu5
	 eZy0zHeN3yabA==
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
Subject: [RFC net-next v2 4/6] selftests: drv-net: Add loopback driver test
Date: Sun,  8 Mar 2026 13:40:10 +0100
Message-ID: <20260308124016.3134012-5-bjorn@kernel.org>
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
X-Rspamd-Queue-Id: B3F09230452
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.96 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17715-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.972];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.py:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add a selftest for the ethtool loopback UAPI exercising module
loopback via the loopback GET/SET netlink commands.

Works on any device that reports module loopback entries. Tests cover
enable near-end and far-end, disable, direction switching (mutual
exclusivity), idempotent enable, and rejection while interface is up.
Devices without module loopback support are skipped.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 .../selftests/drivers/net/hw/loopback_drv.py  | 227 ++++++++++++++++++
 1 file changed, 227 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/loopback_drv.py

diff --git a/tools/testing/selftests/drivers/net/hw/loopback_drv.py b/tools/testing/selftests/drivers/net/hw/loopback_drv.py
new file mode 100755
index 000000000000..ab105664e07e
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
+DIR_NEAR_END = {'near-end'}
+DIR_FAR_END = {'far-end'}
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
+def _require_module_entries(cfg):
+    """Return module loopback entries, skip if none available."""
+    try:
+        entries = _get_loopback(cfg)
+    except NlError as e:
+        if e.error == errno.EOPNOTSUPP:
+            raise KsftSkipEx("Device does not support loopback")
+        raise
+    mod_entries = [e for e in entries if e['component'] == 'module']
+    if not mod_entries:
+        raise KsftSkipEx("No module loopback entries")
+    return mod_entries
+
+
+@ksft_disruptive
+def test_set_near_end(cfg):
+    """SET a module entry to near-end and verify via GET."""
+    mod_entries = _require_module_entries(cfg)
+
+    near = [e for e in mod_entries
+            if 'near-end' in e['supported']]
+    if not near:
+        raise KsftSkipEx("No near-end capable module entry")
+
+    ip(f"link set dev {cfg.ifname} down")
+    defer(ip, f"link set dev {cfg.ifname} up")
+
+    target = near[0]
+    _set_loopback(cfg, 'module', target['name'], 'near-end')
+    defer(_set_loopback, cfg, 'module', target['name'], 0)
+
+    entries = _get_loopback(cfg)
+    updated = [e for e in entries
+               if e['name'] == target['name']
+               and 'near-end' in e['supported']]
+    ksft_eq(len(updated), 1)
+    ksft_eq(updated[0]['direction'], DIR_NEAR_END)
+
+
+@ksft_disruptive
+def test_set_far_end(cfg):
+    """SET a module entry to far-end and verify via GET."""
+    mod_entries = _require_module_entries(cfg)
+
+    far = [e for e in mod_entries
+           if 'far-end' in e['supported']]
+    if not far:
+        raise KsftSkipEx("No far-end capable module entry")
+
+    ip(f"link set dev {cfg.ifname} down")
+    defer(ip, f"link set dev {cfg.ifname} up")
+
+    target = far[0]
+    _set_loopback(cfg, 'module', target['name'], 'far-end')
+    defer(_set_loopback, cfg, 'module', target['name'], 0)
+
+    entries = _get_loopback(cfg)
+    updated = [e for e in entries
+               if e['name'] == target['name']
+               and 'far-end' in e['supported']]
+    ksft_eq(len(updated), 1)
+    ksft_eq(updated[0]['direction'], DIR_FAR_END)
+
+
+@ksft_disruptive
+def test_set_disable(cfg):
+    """Enable then disable loopback and verify."""
+    mod_entries = _require_module_entries(cfg)
+
+    near = [e for e in mod_entries
+            if 'near-end' in e['supported']]
+    if not near:
+        raise KsftSkipEx("No near-end capable module entry")
+
+    ip(f"link set dev {cfg.ifname} down")
+    defer(ip, f"link set dev {cfg.ifname} up")
+
+    target = near[0]
+    _set_loopback(cfg, 'module', target['name'], 'near-end')
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
+    """Enable near-end, then switch to far-end. The kernel must disable
+    near-end before enabling far-end (mutual exclusivity).
+    """
+    mod_entries = _require_module_entries(cfg)
+
+    both = [e for e in mod_entries
+            if 'near-end' in e['supported'] and 'far-end' in e['supported']]
+    if not both:
+        raise KsftSkipEx("No entry with both near-end and far-end support")
+
+    ip(f"link set dev {cfg.ifname} down")
+    defer(ip, f"link set dev {cfg.ifname} up")
+
+    target = both[0]
+    _set_loopback(cfg, 'module', target['name'], 'near-end')
+    defer(_set_loopback, cfg, 'module', target['name'], 0)
+
+    entries = _get_loopback(cfg)
+    updated = [e for e in entries if e['name'] == target['name']]
+    ksft_eq(updated[0]['direction'], DIR_NEAR_END)
+
+    # Switch to far-end
+    _set_loopback(cfg, 'module', target['name'], 'far-end')
+
+    entries = _get_loopback(cfg)
+    updated = [e for e in entries if e['name'] == target['name']]
+    ksft_eq(updated[0]['direction'], DIR_FAR_END,
+            "Should have switched to far-end")
+
+
+@ksft_disruptive
+def test_set_idempotent(cfg):
+    """Enable the same direction twice. Second call should not fail."""
+    mod_entries = _require_module_entries(cfg)
+
+    near = [e for e in mod_entries
+            if 'near-end' in e['supported']]
+    if not near:
+        raise KsftSkipEx("No near-end capable module entry")
+
+    ip(f"link set dev {cfg.ifname} down")
+    defer(ip, f"link set dev {cfg.ifname} up")
+
+    target = near[0]
+    _set_loopback(cfg, 'module', target['name'], 'near-end')
+    defer(_set_loopback, cfg, 'module', target['name'], 0)
+
+    # Second enable of the same direction should succeed
+    _set_loopback(cfg, 'module', target['name'], 'near-end')
+
+    entries = _get_loopback(cfg)
+    updated = [e for e in entries
+               if e['name'] == target['name']
+               and 'near-end' in e['supported']]
+    ksft_eq(updated[0]['direction'], DIR_NEAR_END,
+            "Direction should still be near-end")
+
+
+@ksft_disruptive
+def test_set_while_up(cfg):
+    """SET while interface is UP should fail."""
+    mod_entries = _require_module_entries(cfg)
+
+    target = mod_entries[0]
+    direction = 'near-end'
+    if direction not in target['supported']:
+        direction = 'far-end'
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
+    with NetDrvEnv(__file__, nsim_test=False) as cfg:
+        cfg.ethnl = EthtoolFamily()
+
+        ksft_run([
+            test_set_near_end,
+            test_set_far_end,
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


