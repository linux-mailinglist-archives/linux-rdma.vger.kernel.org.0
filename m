Return-Path: <linux-rdma+bounces-17857-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DPVOjz4r2mmdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17857-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 11:53:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54205249BF0
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 11:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABCB331E13C6
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 10:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B8D3806B8;
	Tue, 10 Mar 2026 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpTOLp1Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2563314D2;
	Tue, 10 Mar 2026 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773139703; cv=none; b=uOgSQgLKyvVkyXT2k8rRJKRCnUlgFH+IZHBlWorEP9Infmzrm02BfulRpUq1pJaOc+/O4at9kidvIZAG0BZ0BxSikFTmUt7Wv86OAb+fIAnDH484UpSU96w08KJTOjDDABsPi2VCvkqxDg+LQb4bIMBwhZpd4Hmv55E0bSlkqJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773139703; c=relaxed/simple;
	bh=wUmXm68rgXvP51p2cWDEQwObxflbVjVTx5cn/rY7UKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oo50qIl90ORdTyQMaZFCVt+LfakvrAcRRec/Vqk+zO8t6cbgX2FB1thlo5VuRwrI4fQnOna3qDFyDAPjLv7Zoyjbds0J+EmCdBIIQSNvWYUCvbfRDVc13EwEoHIPDbuXbisGRD9dloMFtWK+1qE4L+mj+NNf86Q1kRu2p5BhcgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpTOLp1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF84C19423;
	Tue, 10 Mar 2026 10:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773139703;
	bh=wUmXm68rgXvP51p2cWDEQwObxflbVjVTx5cn/rY7UKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GpTOLp1Q+TZtXw0MzpmV3ME/AypFYUOQ0PkgmWloZDv3xpD77Kf5g0H4s0GHLKBxQ
	 Byl3P8hKpobK3us/CjYSBwlBwngfnShGS3+c+yhUyVvUugjvwyHlNgFUgeFazC2iIe
	 hNYLdk4BGpLACh88UtNe9CJh9evCcASBJja3DuI3qyVEC7FK+f06vhIutsC7pf3PtC
	 XQA5Oj3rr4eCWUj2njpaCXNl6WBM3fiOypNO5MWhzxDsxQJ04qxms7IpQapk5I1WUv
	 zws1pgD5Gi5wAknJszdDS5g60SZ3P8JN+K7rjxL/YeDPSqFqjtd1lhZYuyjp3vM8xP
	 aWJwhkwdYIrMQ==
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
Subject: [PATCH net-next 05/11] selftests: drv-net: Add loopback driver test
Date: Tue, 10 Mar 2026 11:47:35 +0100
Message-ID: <20260310104743.907818-6-bjorn@kernel.org>
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
X-Rspamd-Queue-Id: 54205249BF0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.01 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17857-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,loopback_drv.py:url,lib.py:url]
X-Rspamd-Action: no action

Add a selftest for the ethtool loopback UAPI exercising module
loopback via the loopback GET/SET netlink commands.

Works on any device that reports module loopback entries. Tests cover
enable near-end and far-end, disable, direction switching (mutual
exclusivity), idempotent enable, and rejection while interface is up.
Devices without module loopback support are skipped.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../selftests/drivers/net/hw/loopback_drv.py  | 226 ++++++++++++++++++
 2 files changed, 227 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/loopback_drv.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 91df028abfc0..1c341aaa88c6 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -31,6 +31,7 @@ TEST_PROGS = \
 	iou-zcrx.py \
 	irq.py \
 	loopback.sh \
+	loopback_drv.py \
 	nic_timestamp.py \
 	nk_netns.py \
 	pp_alloc_fail.py \
diff --git a/tools/testing/selftests/drivers/net/hw/loopback_drv.py b/tools/testing/selftests/drivers/net/hw/loopback_drv.py
new file mode 100755
index 000000000000..05374db42ae9
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/loopback_drv.py
@@ -0,0 +1,226 @@
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


