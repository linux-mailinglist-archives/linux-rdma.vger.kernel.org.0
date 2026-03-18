Return-Path: <linux-rdma+bounces-18317-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IB7iL5CaumnaZQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18317-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 13:29:04 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2132BB7A8
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 13:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 60E7530363ED
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 12:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385883D6660;
	Wed, 18 Mar 2026 12:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ub5/4M1E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4C93B5304;
	Wed, 18 Mar 2026 12:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773836792; cv=none; b=KNrm9EkgpenXWrEg0SBNJno0BNymiaekAD3UHWD3126j6EkNhj4ZzAm5h4VujTqwzA2UxiBw58P1w06h0T/P7OhcGUfQQusWvDdThh+y/xHr0i14EFFx4H1+U6Qw9/P9cs6yKy1I+ABIqNJ80VwQDlHHvUFTPrARKvKDTvPyVfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773836792; c=relaxed/simple;
	bh=n31d8NYjTDg4u78LNNFct5Yi6pJSfLNaOmI/4D6Nfd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VjG+Osh1en//Q72XC4IF0GzKiRdTaFdSWLwhpPwIP8b3GjwyRRgyihl1Do719s72cQtLStw41k88lR4JcUqXm+/PxtF7kMzSyEGLOINqTTTdnB+hRXPt3NrBTy57rmzJlXX+x/2IRgcMKYVxTUH/bzTtHjQ3JETCu6t93gA8u2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ub5/4M1E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE1BC19424;
	Wed, 18 Mar 2026 12:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773836791;
	bh=n31d8NYjTDg4u78LNNFct5Yi6pJSfLNaOmI/4D6Nfd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ub5/4M1Ey+kvsbJSYdzQS9wC6jUY79/M91IARgDNiSlppQl8zZEwvPPV7ilv/JebF
	 x8Mz2SDv6Kh3TbKB+EzAo4qGHak/bNH/VGczjjXJdpe2O3IwNMlUBxuufpae9mMdCB
	 MaU3p+sxyI6g2c5fuCgoVod4SULwxrvVzBPfr+aD/KVX+0Cm1wvtIUo4jMfL8AAZQP
	 DGC49R3SpY29j/pdeAmlb0FPyj6n9WfLIuzJRQiFZzDGCmzAvjtCtW5y7Z4SLH8Q2z
	 Bu315PKEIog/0Un+KCIECkgwgTJfompPU/38sKiy1HJ9KKJiwup2ocj4/sIsbFpxo9
	 l7NQhdRcL64Hw==
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
Subject: [PATCH net-next v6 4/4] selftests: rss_drv: Add RSS indirection table resize tests
Date: Wed, 18 Mar 2026 13:26:01 +0100
Message-ID: <20260318122603.264550-5-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318122603.264550-1-bjorn@kernel.org>
References: <20260318122603.264550-1-bjorn@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18317-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.py:url,rss_drv.py:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C2132BB7A8
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


