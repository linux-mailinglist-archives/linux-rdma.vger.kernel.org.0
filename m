Return-Path: <linux-rdma+bounces-17860-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LMrN2v4r2mmdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17860-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 11:54:35 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D31249C31
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 11:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C367318DE8E
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 10:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2DF38236A;
	Tue, 10 Mar 2026 10:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXSOXl/A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D55F30FC23;
	Tue, 10 Mar 2026 10:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773139721; cv=none; b=MHAQMCFZ4qjeElktpUjJdkwMQ3BndZApugGEdOZblRy1oC33VUiuCIKavkKvnmpiHm+FjR4UgyMLWctaS46eMN5gurt6EQmgouk3ExxstBTCjxZngJTDTOHVb3Zb2oMHOdvkuCViGPV0crKc5aE2jRvtMn5az8NbjZzE6+Nksfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773139721; c=relaxed/simple;
	bh=YvF2cb6VNBd6TdihjC7PxhVeN8lbvy5kF/3/KYsHq3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHw1g9OO+2kSX3svnWjkcvJuA6Rc8MnJEg6r9Te/hjHph4bHSxX25kKYkr/tKNJoDIslddrji7icEqiHsFtVG18jA1aqueEW0w4iiktDwGqQtm8ABI2jAv2BUzqXJjzFVQ5fSB+iiEKZKlUgGXlaZF7L6Rbzvo69pmTI155nRM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXSOXl/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6686C4AF0C;
	Tue, 10 Mar 2026 10:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773139721;
	bh=YvF2cb6VNBd6TdihjC7PxhVeN8lbvy5kF/3/KYsHq3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nXSOXl/AGDAGgXnyJ/o/+E6anugaScJt1Bbb7cAs7mbwy/vPA272zH+YdZs/es3YC
	 fYGuRpDDxJhseJ+cI/rCmmI07hRYYGY9OuJ3i6yB39dalO+Rbd5xrrjSDFmG2/02z8
	 aDHclPeaehP7Tr/ipDgms1xapj3gzloukojzKQRwwXBYsDQIatoY+61NpBDEca5bsZ
	 Bg7iQAmhcTktOEYKR/p5LeMnRMX4jonezRkud49CJG+tLejvcFUr6FiyjKXgc7Sr7z
	 pLftBar8mbMbpAAIQEMMoyJiZaMtAnt5/TFXZr4veMcmu+lLh/dWM6Bg/IZnhCkEPw
	 16cDs6Z2/38aw==
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
Subject: [PATCH net-next 08/11] selftests: drv-net: Add MAC loopback netdevsim test
Date: Tue, 10 Mar 2026 11:47:38 +0100
Message-ID: <20260310104743.907818-9-bjorn@kernel.org>
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
X-Rspamd-Queue-Id: 01D31249C31
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
	TAGGED_FROM(0.00)[bounces-17860-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,loopback_nsim.py:url,lib.py:url]
X-Rspamd-Action: no action

Add loopback_nsim.py with netdevsim-specific tests for MAC
loopback via the new ethtool_ops loopback callbacks:

 - test_get_mac_entry: verify MAC entry appears in dump with correct
   component, name, and supported directions
 - test_set_mac_near_end: SET near-end, verify via GET and debugfs
 - test_set_mac_disable: enable then disable
 - test_set_mac_unknown_name: SET with wrong name, expect EOPNOTSUPP

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../selftests/drivers/net/hw/loopback_nsim.py | 135 ++++++++++++++++++
 2 files changed, 136 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/loopback_nsim.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 1c341aaa88c6..d7041b9d7461 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -32,6 +32,7 @@ TEST_PROGS = \
 	irq.py \
 	loopback.sh \
 	loopback_drv.py \
+	loopback_nsim.py \
 	nic_timestamp.py \
 	nk_netns.py \
 	pp_alloc_fail.py \
diff --git a/tools/testing/selftests/drivers/net/hw/loopback_nsim.py b/tools/testing/selftests/drivers/net/hw/loopback_nsim.py
new file mode 100755
index 000000000000..5edc999d920b
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/loopback_nsim.py
@@ -0,0 +1,135 @@
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
+from lib.py import KsftSkipEx, KsftFailEx, ksft_disruptive
+from lib.py import EthtoolFamily, NlError
+from lib.py import NetDrvEnv, ip, defer
+
+# Direction flags as YNL returns them
+DIR_NONE = set()
+DIR_NEAR_END = {'near-end'}
+DIR_FAR_END = {'far-end'}
+
+
+def _nsim_dfs_path(cfg):
+    return cfg._ns.nsims[0].dfs_dir
+
+
+def _dfs_read_u32(cfg, path):
+    with open(os.path.join(_nsim_dfs_path(cfg), path)) as f:
+        return int(f.read().strip())
+
+
+def _dfs_write_u32(cfg, path, val):
+    with open(os.path.join(_nsim_dfs_path(cfg), path), "w") as f:
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
+    ksft_eq(mac_entries[0]['supported'], DIR_NEAR_END | DIR_FAR_END)
+    ksft_eq(mac_entries[0]['direction'], DIR_NONE)
+
+
+@ksft_disruptive
+def test_set_mac_near_end(cfg):
+    """SET MAC near-end and verify via GET and debugfs."""
+    ip(f"link set dev {cfg.ifname} down")
+    defer(ip, f"link set dev {cfg.ifname} up")
+
+    _set_loopback(cfg, 'mac', 'mac', 'near-end')
+    defer(_set_loopback, cfg, 'mac', 'mac', 0)
+
+    entries = _get_loopback(cfg)
+    mac = [e for e in entries if e['component'] == 'mac']
+    ksft_eq(mac[0]['direction'], DIR_NEAR_END)
+
+    dfs_dir = _dfs_read_u32(cfg, "ethtool/mac_lb/direction")
+    ksft_eq(dfs_dir, 1, "debugfs direction should be 1 (NEAR_END)")
+
+
+@ksft_disruptive
+def test_set_mac_disable(cfg):
+    """Enable then disable MAC loopback."""
+    ip(f"link set dev {cfg.ifname} down")
+    defer(ip, f"link set dev {cfg.ifname} up")
+
+    _set_loopback(cfg, 'mac', 'mac', 'near-end')
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
+        _set_loopback(cfg, 'mac', 'bogus', 'near-end')
+        raise KsftFailEx("Should have rejected unknown name")
+    except NlError as e:
+        ksft_eq(e.error, errno.EOPNOTSUPP,
+                "Expected EOPNOTSUPP for unknown name")
+
+
+def main() -> None:
+    with NetDrvEnv(__file__) as cfg:
+        cfg.ethnl = EthtoolFamily()
+
+        ksft_run([
+            test_get_mac_entry,
+            test_set_mac_near_end,
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


