Return-Path: <linux-rdma+bounces-18313-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oF6tHAObumnaZQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18313-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 13:30:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7F82BB7FA
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 13:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66FD7318B6B9
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 12:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3D53BE173;
	Wed, 18 Mar 2026 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0hy57gK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B77C3AE707;
	Wed, 18 Mar 2026 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773836772; cv=none; b=Z/eQlg23VfBPpk7NIGVJXAcA/M9ui+iSrNEBbR4VtmJgEXLoZUe2ci/gEl6Y2XodZFVPNwt/DXdDQrrmpEjcyBQkwfW7IPBDPXrvPT8xOH9q4L0RmrefzQTXV64g7+pWdceGBDjRVBOpgVvQRMsH85JvGRieT/xzLK+1K0S+L4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773836772; c=relaxed/simple;
	bh=HiIrxnViFiv3CENReMPpm2EcFig1Z7enJx9zIM/ax64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nfv4kGQBUF3o6P6lLzMCk5SLN27u+s7iQCT0CX4K7OvgTvFE4ZrguEehGAf+eIoG7uNT6D9INTUB0sjxAmB1g2l6ivYS8jZKj6NtWLGEA2qzwhzjWSOkqu44G1GuCkEpdWYXuCmvyWgpE80wYYEkOpqSuiRjkn71VMFMAQaICs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0hy57gK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B8EC19421;
	Wed, 18 Mar 2026 12:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773836771;
	bh=HiIrxnViFiv3CENReMPpm2EcFig1Z7enJx9zIM/ax64=;
	h=From:To:Cc:Subject:Date:From;
	b=d0hy57gKaCRE7/Gy685aggvfqdNH9RI0CxnHqU/JTOSOj+cecRGy+LAXdUx0hOCw8
	 6jPfy0npEiKRXa/kvPBDPkBMkRQuXQVuoXIOhO+J58bSKfSR7ZkQ8VvQbb4BKsGf3Q
	 wSU/mKDf+uX0keUZz8Rr6+7h7QJZVfM+vHDuQeT41YjHUizSHZekDAa9hwdKylKa/c
	 VQvdrOqA+n56g0ltBSWXNFQEHAjBo06rsgB+vh2r31N1DVk6C7zb9q9+tmXqql+ws7
	 ml1e94bQhiFvdyg0SUxi65FS4vncg2QY0D6k26GB5H+avw/AvZ/xN1Cmpcp1nhB1BT
	 Ot+IXsDwYqqfQ==
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
Subject: [PATCH net-next v6 0/4] ethtool: Dynamic RSS context indirection table resizing
Date: Wed, 18 Mar 2026 13:25:57 +0100
Message-ID: <20260318122603.264550-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18313-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rss_drv.py:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB7F82BB7FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi!

Some NICs (e.g. bnxt) change their RSS indirection table size based on
the queue count, because the hardware table is a shared resource. The
ethtool core locks ctx->indir_size at context creation, so drivers
have to reject channel changes when RSS contexts exist.

This series adds resize helpers and wires them up in bnxt. It also
adds tracking of the user provided indirection table size to the
ethtool core.

Patch 1 tracks the user-provided indirection table size (user_size)
in ctx->indir_user_size for non-default RSS contexts and in
dev->ethtool->rss_indir_user_size for context 0. It is set when the
indirection table is configured via netlink or ioctl, and cleared to
zero on reset-to-default.

IFF_RXFH_CONFIGURED is removed, and replaced with rss_indir_user_size.
The flag is redundant now that user_size captures the same
information.

Patch 2 adds core resize helpers:
  ethtool_rxfh_indir_can_resize() - read-only validation for context 0
  ethtool_rxfh_indir_resize() - fold/unfold context 0 table in place
  ethtool_rxfh_ctxs_can_resize() - validate all non-default contexts
  ethtool_rxfh_ctxs_resize() - resize all non-default contexts,
    with locking and RSS_NTF notifications

Patch 3 uses the resize helpers in bnxt_set_channels().

Patch 4 adds HW tests in rss_drv.py (devices without dynamic table
sizing are skipped):
  resize_periodic - fold/unfold with a non-default [3,2,1,0]
    sub-table (user_size=4), verifying exact content preservation
    (main + ctx)
  resize_below_user_size_reject - periodic sub-table with user_size
    between big and small device table sizes; verifies that shrinking
    below user_size is rejected even when the table is periodic
    (main + ctx)
  resize_nonperiodic_reject - non-periodic table blocks channel
    reduction, with an extra periodic context to exercise
    multi-context validation (main + ctx)
  resize_nonperiodic_no_corruption - failed resize leaves table
    contents and channel count unchanged (main + ctx)

Running the tests:

  # On real hardware
  sudo NETIF=eth0 ./rss_drv.py

Changes v5 -> v6:

 - rss_set_prep_indir() returns user_size (>= 0) on success instead
   of using a u32 *user_sizep output parameter (Jakub)
 - Removed IFF_RXFH_CONFIGURED; netif_is_rxfh_configured() now checks
   dev->ethtool->rss_indir_user_size instead of priv_flags (Jakub)
 - Added ethtool_rxfh_indir_clear() helper for drivers that
   forcibly reset indirection tables. Sends ETHTOOL_MSG_RSS_NTF
   notification. Converted bnxt and mlx5 to use it (Jakub)
 - ethtool_rxfh_indir_can_resize()/ethtool_rxfh_indir_resize() wrap
   the internal resize logic for context 0, reading user_size from
   dev->ethtool->rss_indir_user_size. Removes the need for
   netif_is_rxfh_configured() guards in drivers (Jakub)
 - Removed netif_is_rxfh_configured() guards in bnxt_set_channels()
   and nsim_set_channels() (Jakub)
 - More consistent function names

Changes v4 -> v5:

 - Track user-provided indirection table size (user_size) as a resize
   floor. Added indir_user_size to ethtool_rxfh_context and
   rss_indir_user_size to ethtool_netdev_state. ethtool_rxfh_can_resize()
   and ethtool_rxfh_resize() now take a user_size parameter and reject
   shrinking below it. (Jakub)
 - Propagated user_size out of rss_set_prep_indir() and stored it on
   successful set in both netlink and ioctl paths.
 - resize_periodic test now sends a 4-entry sub-table (user_size=4)
   instead of replicating to full device table size
 - Added resize_below_user_size_reject test to verify user_size floor.
 - Removed "Open items" section - user_size tracking is now implemented.

Changes v3 -> v4:

 - Rebased onto net-next
 - Added Reviewed-by: from Michael
 - Added missing Cc: to make the pwbots happier

Changes v2 -> v3:

 - Changed ethtool_rxfh_can_resize() to return bool instead of int;
   true means resize is possible, false means it is not. Inverted
   callers accordingly. (Jakub)
 - Added Tested-by from Pavan

Changes v1 -> v2:

 - Dropped netdevsim support and netdevsim selftest (Jakub)
 - Split ethtool_rxfh_contexts_resize_all() into separate validate
   (ethtool_rxfh_ctxs_can_resize) and apply (ethtool_rxfh_ctxs_resize)
   so drivers can validate before closing the device (Jakub)
 - Shortened helper names (Jakub)
 - Replaced scoped_guard(mutex) with explicit mutex_lock/unlock
   (Jakub)
 - Removed defensive zero-size check, bare expressions instead of != 0
   comparisons, ! instead of == 0 (Jakub)
 - In bnxt, moved bnxt_check_rings() before RSS validation and
   deferred actual resize to after bnxt_close_nic() (Jakub, Michael)
 - Added comment that RSS table size only changes on P5 chips with
   older firmware (Michael)
 - Use non-default [3,2,1,0]xN pattern set via netlink to distinguish
   correct fold from driver resetting to defaults (Jakub)
 - Check exact indirection table pattern, not just set(indir) (Jakub)
 - Use ksft_raises() instead of try/except/else (Jakub)
 - Removed queue_count=8 from NetDrvEnv (Jakub)
 - Added ksft_variants to resize_nonperiodic_reject for ctx coverage
 - Added extra periodic context in reject test for multi-context
   validation coverage
 - Added resize_nonperiodic_no_corruption test


Björn Töpel (4):
  ethtool: Track user-provided RSS indirection table size
  ethtool: Add RSS indirection table resize helpers
  bnxt_en: Resize RSS contexts on channel count change
  selftests: rss_drv: Add RSS indirection table resize tests

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  35 ++-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   2 +-
 include/linux/ethtool.h                       |  13 +
 include/linux/netdevice.h                     |   7 +-
 net/ethtool/common.c                          | 175 +++++++++++++
 net/ethtool/ioctl.c                           |   9 +-
 net/ethtool/rss.c                             |  24 +-
 .../selftests/drivers/net/hw/rss_drv.py       | 233 +++++++++++++++++-
 9 files changed, 469 insertions(+), 31 deletions(-)


base-commit: 70729af783af1d66944918b33e5b345b500a5399
-- 
2.53.0


