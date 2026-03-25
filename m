Return-Path: <linux-rdma+bounces-18614-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCXNHk8BxGmlvQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18614-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:37:51 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D41203282C7
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B643633888E0
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 14:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CECA40B6D6;
	Wed, 25 Mar 2026 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhxJ7RrR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB44F3F9F22;
	Wed, 25 Mar 2026 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450292; cv=none; b=GOk3l+KFI+Av6OJqPSa74iakvgIzgf9FB910LRX+G97BzndG/rqcgfVhoxljDVgBEPcVMt4m2cyhMw3roxH+Gk6MSK4AB1l/tb3D8Y1awJ8fYsEJGmWoc20dZsIDIWrqv/oR/YHAO8JLjIdOMlfuOiklCwWNQ9o7BJeUT6Vw1nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450292; c=relaxed/simple;
	bh=fSMK9B7+FATcYBRbXIwRswKyArIMAjAjIlrpc0XMGJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=esb7vfXdO5piriuatmkQOhj5lGVJL0v/SiZfGSlWR/Ef/qbh1+R8njiQZjKrC1HdOAVGKyCcNox9Z16UZ2RstbhzNIEGrRvjcggX5Xj8qRDsDwcKmHWAE9pLL7HedtCSYfX764PoJEOu69yxBROohrw/wNBmWiI1RuG5gGQkOs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhxJ7RrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF79C2BCB4;
	Wed, 25 Mar 2026 14:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774450291;
	bh=fSMK9B7+FATcYBRbXIwRswKyArIMAjAjIlrpc0XMGJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WhxJ7RrRpkDZpgTWfjc4VJddijHHsE2NRWf5dq+N/X2yjr8KVEkVVnz2k3eJB/UqT
	 jdEppXr+F2VAL2B+sveWdQlDL/O8sCkcmaAGyKyZXCwRNSR9rBnjiEvmlR6j/MXsf2
	 CI+hn7mc5Hpo/MqiHKaZcI1VkQ/1+Ux4nMpKiUdz7f+OMyk+Hsrt8lccs8m6++/b6y
	 WdcLvLVXGH/VU5H0T9q/Z3nVcml5aT95TgwbVGoBQQMN4QHmybK00E/h3+ScWBS5UB
	 X7Ae2M8QMHCdUZMLo03jLlq6ucI6uUgfttBJL4EItuh+GLtFP0q+c6zT5Tqo0rkThg
	 SsLzKsRIE0smg==
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
Subject: [PATCH net-next v2 09/12] selftests: drv-net: Add MAC loopback netdevsim test
Date: Wed, 25 Mar 2026 15:50:16 +0100
Message-ID: <20260325145022.2607545-10-bjorn@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18614-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.py:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,loopback_nsim.py:url]
X-Rspamd-Queue-Id: D41203282C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add loopback_nsim.py with netdevsim-specific tests for MAC loopback
via the new ethtool_ops loopback callbacks:

 - test_get_mac_entry: verify MAC entry appears in dump with correct
   component, name, and supported directions
 - test_set_mac_local: SET local, verify via GET and debugfs
 - test_set_mac_disable: enable then disable
 - test_set_mac_unknown_name: SET with wrong name, expect EOPNOTSUPP

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../selftests/drivers/net/hw/loopback_nsim.py | 138 ++++++++++++++++++
 2 files changed, 139 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/loopback_nsim.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 5a6037a71f8f..74b0e1937980 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -33,6 +33,7 @@ TEST_PROGS = \
 	irq.py \
 	loopback.sh \
 	loopback_drv.py \
+	loopback_nsim.py \
 	nic_timestamp.py \
 	nk_netns.py \
 	pp_alloc_fail.py \
diff --git a/tools/testing/selftests/drivers/net/hw/loopback_nsim.py b/tools/testing/selftests/drivers/net/hw/loopback_nsim.py
new file mode 100755
index 000000000000..d05be09f6c14
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/loopback_nsim.py
@@ -0,0 +1,138 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""Netdevsim-specific tests for MAC loopback via ethtool_ops.
+
+Verifies that MAC loopback entries appear in dumps, that SET
+operations update state correctly (both via GET and debugfs).
+"""
+
+import errno
+import os
+
+from lib.py import ksft_run, ksft_exit, ksft_eq
+from lib.py import KsftFailEx, ksft_disruptive
+from lib.py import EthtoolFamily, NlError
+from lib.py import NetDrvEnv, ip, defer
+
+# Direction flags as YNL returns them
+DIR_NONE = set()
+DIR_LOCAL = {'local'}
+DIR_REMOTE = {'remote'}
+
+
+def _nsim_dfs_path(cfg):
+    return cfg._ns.nsims[0].dfs_dir  # pylint: disable=protected-access
+
+
+def _dfs_read_u32(cfg, path):
+    with open(os.path.join(_nsim_dfs_path(cfg), path),
+              encoding="utf-8") as f:
+        return int(f.read().strip())
+
+
+def _dfs_write_u32(cfg, path, val):
+    with open(os.path.join(_nsim_dfs_path(cfg), path), "w",
+              encoding="utf-8") as f:
+        f.write(str(val))
+
+
+def _get_loopback(cfg):
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
+def test_get_mac_entry(cfg):
+    """GET should return the MAC loopback entry with correct attributes."""
+    entries = _get_loopback(cfg)
+    mac_entries = [e for e in entries if e['component'] == 'mac']
+
+    ksft_eq(len(mac_entries), 1, "Expected 1 MAC loopback entry")
+    ksft_eq(mac_entries[0]['name'], 'mac')
+    ksft_eq(mac_entries[0]['supported'], DIR_LOCAL | DIR_REMOTE)
+    ksft_eq(mac_entries[0]['direction'], DIR_NONE)
+
+
+@ksft_disruptive
+def test_set_mac_local(cfg):
+    """SET MAC local loopback and verify via GET and debugfs."""
+    ip(f"link set dev {cfg.ifname} down")
+    defer(ip, f"link set dev {cfg.ifname} up")
+
+    _set_loopback(cfg, 'mac', 'mac', 'local')
+    defer(_set_loopback, cfg, 'mac', 'mac', 0)
+
+    entries = _get_loopback(cfg)
+    mac = [e for e in entries if e['component'] == 'mac']
+    ksft_eq(mac[0]['direction'], DIR_LOCAL)
+
+    dfs_dir = _dfs_read_u32(cfg, "ethtool/mac_lb/direction")
+    ksft_eq(dfs_dir, 1, "debugfs direction should be 1 (LOCAL)")
+
+
+@ksft_disruptive
+def test_set_mac_disable(cfg):
+    """Enable then disable MAC loopback."""
+    ip(f"link set dev {cfg.ifname} down")
+    defer(ip, f"link set dev {cfg.ifname} up")
+
+    _set_loopback(cfg, 'mac', 'mac', 'local')
+    defer(_set_loopback, cfg, 'mac', 'mac', 0)
+
+    _set_loopback(cfg, 'mac', 'mac', 0)
+
+    entries = _get_loopback(cfg)
+    mac = [e for e in entries if e['component'] == 'mac']
+    ksft_eq(mac[0]['direction'], DIR_NONE, "Direction should be off")
+
+    dfs_dir = _dfs_read_u32(cfg, "ethtool/mac_lb/direction")
+    ksft_eq(dfs_dir, 0, "debugfs direction should be 0")
+
+
+@ksft_disruptive
+def test_set_mac_unknown_name(cfg):
+    """SET with unknown name should fail with EOPNOTSUPP."""
+    ip(f"link set dev {cfg.ifname} down")
+    defer(ip, f"link set dev {cfg.ifname} up")
+
+    try:
+        _set_loopback(cfg, 'mac', 'bogus', 'local')
+        raise KsftFailEx("Should have rejected unknown name")
+    except NlError as e:
+        ksft_eq(e.error, errno.EOPNOTSUPP,
+                "Expected EOPNOTSUPP for unknown name")
+
+
+def main() -> None:
+    """Run netdevsim loopback tests."""
+    with NetDrvEnv(__file__) as cfg:
+        cfg.ethnl = EthtoolFamily()
+
+        ksft_run([
+            test_get_mac_entry,
+            test_set_mac_local,
+            test_set_mac_disable,
+            test_set_mac_unknown_name,
+        ], args=(cfg, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.53.0


