Return-Path: <linux-rdma+bounces-18441-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cO4gDdUMvWkS6QIAu9opvQ
	(envelope-from <linux-rdma+bounces-18441-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 10:01:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D152D7A85
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 10:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 921E9306830A
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 08:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983E237AA8D;
	Fri, 20 Mar 2026 08:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8dV2r4B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59601376BFD;
	Fri, 20 Mar 2026 08:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773997130; cv=none; b=ZHM9EfLWqHWV/kS9oN3HBs62qlg0JlzGQMkWwypHAH8r3fJhSgaVzhQg3lf2E2n2Voigf9xtaIGdOMiXBDLvKwt89HHjCJuEFOPFGJCTSWUH0HCcXJ7E88OkIVdy0OySS/twhUbxOVr1RbRfmy3OLGpILZvgiwwd9HSAB2ZmYBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773997130; c=relaxed/simple;
	bh=n31d8NYjTDg4u78LNNFct5Yi6pJSfLNaOmI/4D6Nfd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MROhQWoE/B/15DjKDxObCCBjU1KZwwj1kJPkbWPGZN4EcXGb0LBgqaV7oMuNOflUcryKO/GMrN+4ESvMAHZkhopfVBus2Ek+XvhWlCRELak8LvyKmVecxtrL+W1wZ2nfkwG9URl5iZjxqIj3MR1Rioza/ipotRpF4tKIFKKt3vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8dV2r4B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43224C4CEF7;
	Fri, 20 Mar 2026 08:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773997130;
	bh=n31d8NYjTDg4u78LNNFct5Yi6pJSfLNaOmI/4D6Nfd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z8dV2r4Boh1D1IuphrQlWfJnmQpdloXi1stlxvXmqkpYR6hPrWdzARWamdzUfnhKs
	 YG+2Z08r1+zpyIVsOkQaoz9tB+tJCjk/L2fwF0daCQE63Wm4bRTFUUJsK1kNOEHNUq
	 CYutHtVbRpiAa5c7HWiri+OeL2xK91WStI4k20NpWUBLolEH+K4AZv0aEZW85p92cK
	 v2MV6UYacKg9MB4QZhVONNjF2KkAHU/p1tvGUsw4Zc3v4WAgwDGhFelBvyJg2VHSJC
	 xFSPn4mnGQdT2FEOzGokyqvcNYfFUl5h+2Y79CYi3spDxkGNF/nuyZyPCQmNrqpVym
	 m1VImU44ndqnw==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Gal Pressman <gal@nvidia.com>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v7 4/4] selftests: rss_drv: Add RSS indirection table resize tests
Date: Fri, 20 Mar 2026 09:58:24 +0100
Message-ID: <20260320085826.1957255-5-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320085826.1957255-1-bjorn@kernel.org>
References: <20260320085826.1957255-1-bjorn@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18441-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCPT_COUNT_TWELVE(0.00)[21];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 51D152D7A85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add resize tests to rss_drv.py. Devices without dynamic table sizing
are skipped via _require_dynamic_indir_size().

resize_periodic: set a periodic 4-entry table, shrink channels to
fold, grow back to unfold. Check the exact pattern is preserved. Has
main and non-default context variants.

resize_below_user_size_reject: send a periodic table with user_size
between the big and small device table sizes. Verify that shrinking
below user_size is rejected even though the table is periodic. Has
main and non-default context variants.

resize_nonperiodic_reject: set a non-periodic table (equal N), verify
that channel reduction is rejected.

resize_nonperiodic_no_corruption: verify a failed resize leaves both
the indirection table contents and the channel count unchanged.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 .../selftests/drivers/net/hw/rss_drv.py       | 233 +++++++++++++++++-
 1 file changed, 229 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_drv.py b/tools/testing/selftests/drivers/net/hw/rss_drv.py
index 2d1a33189076..bd59dace6e15 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_drv.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_drv.py
@@ -5,9 +5,9 @@
 Driver-related behavior tests for RSS.
 """
 
-from lib.py import ksft_run, ksft_exit, ksft_ge
-from lib.py import ksft_variants, KsftNamedVariant, KsftSkipEx
-from lib.py import defer, ethtool
+from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_ge
+from lib.py import ksft_variants, KsftNamedVariant, KsftSkipEx, ksft_raises
+from lib.py import defer, ethtool, CmdExitFailure
 from lib.py import EthtoolFamily, NlError
 from lib.py import NetDrvEnv
 
@@ -45,6 +45,18 @@ def _maybe_create_context(cfg, create_context):
     return ctx_id
 
 
+def _require_dynamic_indir_size(cfg, ch_max):
+    """Skip if the device does not dynamically size its indirection table."""
+    ethtool(f"-X {cfg.ifname} default")
+    ethtool(f"-L {cfg.ifname} combined 2")
+    small = len(_get_rss(cfg)['rss-indirection-table'])
+    ethtool(f"-L {cfg.ifname} combined {ch_max}")
+    large = len(_get_rss(cfg)['rss-indirection-table'])
+
+    if small == large:
+        raise KsftSkipEx("Device does not dynamically size indirection table")
+
+
 @ksft_variants([
     KsftNamedVariant("main", False),
     KsftNamedVariant("ctx", True),
@@ -76,11 +88,224 @@ def indir_size_4x(cfg, create_context):
         _test_rss_indir_size(cfg, test_max, context=ctx_id)
 
 
+@ksft_variants([
+    KsftNamedVariant("main", False),
+    KsftNamedVariant("ctx", True),
+])
+def resize_periodic(cfg, create_context):
+    """Test that a periodic indirection table survives channel changes.
+
+    Set a non-default periodic table ([3, 2, 1, 0] x N) via netlink,
+    reduce channels to trigger a fold, then increase to trigger an
+    unfold. Using a reversed pattern (instead of [0, 1, 2, 3]) ensures
+    the test can distinguish a correct fold from a driver that silently
+    resets the table to defaults. Verify the exact pattern is preserved
+    and the size tracks the channel count.
+    """
+    channels = cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
+    ch_max = channels.get('combined-max', 0)
+    qcnt = channels['combined-count']
+
+    if ch_max < 4:
+        raise KsftSkipEx(f"Not enough queues for the test: max={ch_max}")
+
+    defer(ethtool, f"-L {cfg.ifname} combined {qcnt}")
+
+    _require_dynamic_indir_size(cfg, ch_max)
+
+    ctx_id = _maybe_create_context(cfg, create_context)
+
+    # Set a non-default periodic pattern via netlink.
+    # Send only 4 entries (user_size=4) so the kernel replicates it
+    # to fill the device table. This allows folding down to 4 entries.
+    rss = _get_rss(cfg, context=ctx_id)
+    orig_size = len(rss['rss-indirection-table'])
+    pattern = [3, 2, 1, 0]
+    req = {'header': {'dev-index': cfg.ifindex}, 'indir': pattern}
+    if ctx_id:
+        req['context'] = ctx_id
+    else:
+        defer(ethtool, f"-X {cfg.ifname} default")
+    cfg.ethnl.rss_set(req)
+
+    # Shrink — should fold
+    ethtool(f"-L {cfg.ifname} combined 4")
+    rss = _get_rss(cfg, context=ctx_id)
+    indir = rss['rss-indirection-table']
+
+    ksft_ge(orig_size, len(indir), "Table did not shrink")
+    ksft_eq(indir, [3, 2, 1, 0] * (len(indir) // 4),
+            "Folded table has wrong pattern")
+
+    # Grow back — should unfold
+    ethtool(f"-L {cfg.ifname} combined {ch_max}")
+    rss = _get_rss(cfg, context=ctx_id)
+    indir = rss['rss-indirection-table']
+
+    ksft_eq(len(indir), orig_size, "Table size not restored")
+    ksft_eq(indir, [3, 2, 1, 0] * (len(indir) // 4),
+            "Unfolded table has wrong pattern")
+
+
+@ksft_variants([
+    KsftNamedVariant("main", False),
+    KsftNamedVariant("ctx", True),
+])
+def resize_below_user_size_reject(cfg, create_context):
+    """Test that shrinking below user_size is rejected.
+
+    Send a table via netlink whose size (user_size) sits between
+    the small and large device table sizes. The table is periodic,
+    so folding would normally succeed, but the user_size floor must
+    prevent it.
+    """
+    channels = cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
+    ch_max = channels.get('combined-max', 0)
+    qcnt = channels['combined-count']
+
+    if ch_max < 4:
+        raise KsftSkipEx(f"Not enough queues for the test: max={ch_max}")
+
+    defer(ethtool, f"-L {cfg.ifname} combined {qcnt}")
+
+    _require_dynamic_indir_size(cfg, ch_max)
+
+    ctx_id = _maybe_create_context(cfg, create_context)
+
+    # Measure the table size at max channels
+    rss = _get_rss(cfg, context=ctx_id)
+    big_size = len(rss['rss-indirection-table'])
+
+    # Measure the table size at reduced channels
+    ethtool(f"-L {cfg.ifname} combined 4")
+    rss = _get_rss(cfg, context=ctx_id)
+    small_size = len(rss['rss-indirection-table'])
+    ethtool(f"-L {cfg.ifname} combined {ch_max}")
+
+    if small_size >= big_size:
+        raise KsftSkipEx("Table did not shrink at reduced channels")
+
+    # Find a user_size
+    user_size = None
+    for div in [2, 4]:
+        candidate = big_size // div
+        if candidate > small_size and big_size % candidate == 0:
+            user_size = candidate
+            break
+    if user_size is None:
+        raise KsftSkipEx("No suitable user_size between small and big table")
+
+    # Send a periodic sub-table of exactly user_size entries.
+    # Pattern safe for 4 channels.
+    pattern = [0, 1, 2, 3] * (user_size // 4)
+    if len(pattern) != user_size:
+        raise KsftSkipEx(f"user_size ({user_size}) not divisible by 4")
+    req = {'header': {'dev-index': cfg.ifindex}, 'indir': pattern}
+    if ctx_id:
+        req['context'] = ctx_id
+    else:
+        defer(ethtool, f"-X {cfg.ifname} default")
+    cfg.ethnl.rss_set(req)
+
+    # Shrink channels — table would go to small_size < user_size.
+    # The table is periodic so folding would work, but user_size
+    # floor must reject it.
+    with ksft_raises(CmdExitFailure):
+        ethtool(f"-L {cfg.ifname} combined 4")
+
+
+@ksft_variants([
+    KsftNamedVariant("main", False),
+    KsftNamedVariant("ctx", True),
+])
+def resize_nonperiodic_reject(cfg, create_context):
+    """Test that a non-periodic table blocks channel reduction.
+
+    Set equal weight across all queues so the table is not periodic
+    at any smaller size, then verify channel reduction is rejected.
+    An additional context with a periodic table is created to verify
+    that validation catches the non-periodic one even when others
+    are fine.
+    """
+    channels = cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
+    ch_max = channels.get('combined-max', 0)
+    qcnt = channels['combined-count']
+
+    if ch_max < 4:
+        raise KsftSkipEx(f"Not enough queues for the test: max={ch_max}")
+
+    defer(ethtool, f"-L {cfg.ifname} combined {qcnt}")
+
+    _require_dynamic_indir_size(cfg, ch_max)
+
+    ctx_id = _maybe_create_context(cfg, create_context)
+    ctx_ref = f"context {ctx_id}" if ctx_id else ""
+
+    # Create an extra context with a periodic (foldable) table so that
+    # the validation must iterate all contexts to find the bad one.
+    extra_ctx = _maybe_create_context(cfg, True)
+    ethtool(f"-X {cfg.ifname} context {extra_ctx} equal 2")
+
+    ethtool(f"-X {cfg.ifname} {ctx_ref} equal {ch_max}")
+    if not create_context:
+        defer(ethtool, f"-X {cfg.ifname} default")
+
+    with ksft_raises(CmdExitFailure):
+        ethtool(f"-L {cfg.ifname} combined 2")
+
+
+@ksft_variants([
+    KsftNamedVariant("main", False),
+    KsftNamedVariant("ctx", True),
+])
+def resize_nonperiodic_no_corruption(cfg, create_context):
+    """Test that a failed resize does not corrupt table or channel count.
+
+    Set a non-periodic table, attempt a channel reduction (which must
+    fail), then verify both the indirection table contents and the
+    channel count are unchanged.
+    """
+    channels = cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
+    ch_max = channels.get('combined-max', 0)
+    qcnt = channels['combined-count']
+
+    if ch_max < 4:
+        raise KsftSkipEx(f"Not enough queues for the test: max={ch_max}")
+
+    defer(ethtool, f"-L {cfg.ifname} combined {qcnt}")
+
+    _require_dynamic_indir_size(cfg, ch_max)
+
+    ctx_id = _maybe_create_context(cfg, create_context)
+    ctx_ref = f"context {ctx_id}" if ctx_id else ""
+
+    ethtool(f"-X {cfg.ifname} {ctx_ref} equal {ch_max}")
+    if not create_context:
+        defer(ethtool, f"-X {cfg.ifname} default")
+
+    rss_before = _get_rss(cfg, context=ctx_id)
+
+    with ksft_raises(CmdExitFailure):
+        ethtool(f"-L {cfg.ifname} combined 2")
+
+    rss_after = _get_rss(cfg, context=ctx_id)
+    ksft_eq(rss_after['rss-indirection-table'],
+            rss_before['rss-indirection-table'],
+            "Indirection table corrupted after failed resize")
+
+    channels = cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
+    ksft_eq(channels['combined-count'], ch_max,
+            "Channel count changed after failed resize")
+
+
 def main() -> None:
     """ Ksft boiler plate main """
     with NetDrvEnv(__file__) as cfg:
         cfg.ethnl = EthtoolFamily()
-        ksft_run([indir_size_4x], args=(cfg, ))
+        ksft_run([indir_size_4x, resize_periodic,
+                  resize_below_user_size_reject,
+                  resize_nonperiodic_reject,
+                  resize_nonperiodic_no_corruption], args=(cfg, ))
     ksft_exit()
 
 
-- 
2.53.0


