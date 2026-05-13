Return-Path: <linux-rdma+bounces-20566-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id j4QyIrZfBGpxHgIAu9opvQ
	(envelope-from <linux-rdma+bounces-20566-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 13:25:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB9453230E
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 13:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F41B031042AF
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 11:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F543401493;
	Wed, 13 May 2026 11:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="W6VLL/Xj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57363FF8A7
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671353; cv=none; b=swaqUvGWJc6IvXkE123EQaCqc01CMzWgCj1k5dQx/lD6LLRwgBpyio9OTdhUusPR1QNR9mCoHjIom3qMcY/l2/4Kd4vKbde3qzqSr2v1pqLpslhzeAybNJoZlSosGkx5VfcecgsE5lFRk1ChdZkL7b1ZBMgOZeOgCsbRsuY3gr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671353; c=relaxed/simple;
	bh=MaMJwaY1jyCxoJgJJwEYMbmhk/zTgU1mLcEV3YoPoKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ghmKrszjb1fpAk9WtJDYIZJ6feRrkPpu9CN4wqWhLKhVsKVPSeKmUD9J0jF3+Z/EO55G4rU9EYrbpPRacxCJfprhLcQ6iHTyo0sYs2tyAH2s60jdQnrGXv9dlE5bEoDffLLU2qDA4EyoQ7jNit0hQ7Zh7OA4fvpTa2r7jYyvenU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=W6VLL/Xj; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so45092205e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 04:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1778671350; x=1779276150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M/i2eA1a8q5KfMM5M8lDNpFGwLlluyiXuu0AO0XM8wY=;
        b=W6VLL/XjxnMsOoECNbKj8rg9knujVe2qn9Sl2EB/jxDawvlh4qXqmihPKkE4d1CMVd
         cYdpoPrVRlZxpxgcdf8lSPD4j+HT2GT/yHf/1RYrWWXgU84jVFpZYmaxrnjLEnBTVTDo
         t40aAL3elX9y9qMd8Tw9eVysNuw2r3bZnOiMeCsInIDNWgKKp+7QhwnBCT+bQ/gHRce9
         azhwL1zWTP3zTyQ29iAWy6EsqQ1rIMZ+/PfBkQB5U4fUgY5yWp4gX8u8hbxqF2yyFQwF
         rARfTctHJn6/XJfIjFMLig+NqUOs+j1xcQrNViJBJqkanKSgCx1UW1zJwMexQxs8Lh2i
         WJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778671350; x=1779276150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/i2eA1a8q5KfMM5M8lDNpFGwLlluyiXuu0AO0XM8wY=;
        b=eDzwjV/HwUkloteDBwHdpYU77dPK4jZaLQOXE7rmFheHXPUYn94dYKYBO2Hijq5i5k
         LFmv9Oool3+2AdgJoAc9j38In9kFqstTpFliluLHm5XEUJNjE8zfQW5fEc+We52CSYpr
         413LL+kOeXg6lUl5YY0XvUrSHbBQUbdYDKVPtCMZQSl9Xha5CoxRnIsh5+jGFiKdJHf/
         t6QO8CTeYB/zPESdL5L10vWNiUeFkNzi3zw+rDyhfhEzu176ZNTRR+RkZN2XN/FWhoLi
         BXOHEP9l3NM7qsEOB+qQWfe0joG4KJeyBWx8wYlo6A+ffWNswTVieaSGUnfn8+WGgNcS
         GqBw==
X-Forwarded-Encrypted: i=1; AFNElJ/LEFtg9M60FUQGA2nPYDE3i8nEsOz3BgQp8fzWSmjTcYtYP7xzGylmdFyLoqWUnAKHMKJVFHsPhz+Y@vger.kernel.org
X-Gm-Message-State: AOJu0YxM/6Vvbygm0ldlQWFWDwFrVGoZjP7uaPSViVrjMFcr62dqL6r0
	FlHokodTNBbYSlfsWVsovwbaL4tCLG5oLtr0R9Ut5iuRyqgV3lhI9e/1Q70tSNYZ6W6dw/wTzqG
	X8IJ7GY8=
X-Gm-Gg: Acq92OH/b8XDliabxfMDNjddOKXjWQswVWb8XpBmdiOdSKpY9S99SXbPObNb71VaKRH
	UmFlyHn0cLK/oMFwR+ubyRMBowbvcAS+V+OOrjokcBcPgUJUxnZjTDP7QE3aVQTF5U2yZ9x8GrE
	2kitw1AyN25tPB10WcoOyH6td46JrB01D5GRs/PXYwYsdM/Ajl7MDYcpV8fbwFHJrSa05m0NYhO
	LdD9hqH00o+Y/rzDjhfO0vl41QYeoy5AuLtx4iWly2FSClDPm8BqMd7eCVOMyjAzkaWUKXr01+Z
	zPOCA4aMJUDnk/g1Qm4UI9cnDgL1G79U0/yCT/MpQ9tB4e9JhXD6AKaSXNUtvvSXfoQrNsnL/0e
	xO+ceAg9+DWsuWg/V9/7unVqSyfrLf2U4iiqs4xHLTh11vqz3g1WimOtr3MbBuLwy54whASgOXC
	7YNvOIBGkJG+LBEHNq5YWx1boNzAH8/fukZkI=
X-Received: by 2002:a05:600c:4503:b0:48a:534a:eed8 with SMTP id 5b1f17b1804b1-48fc971f11bmr42812895e9.1.1778671349955;
        Wed, 13 May 2026 04:22:29 -0700 (PDT)
Received: from matt-Precision-5490.. ([104.28.20.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f438890sm47322865e9.23.2026.05.13.04.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 04:22:29 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Shahar Shitrit <shshitrit@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Feng Liu <feliu@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: [PATCH net v2] net/mlx5e: Fix use-after-free in mlx5e_tx_reporter_timeout_recover
Date: Wed, 13 May 2026 12:22:26 +0100
Message-ID: <20260513112226.140512-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1CB9453230E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[readmodwrite-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-20566-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[readmodwrite.com];
	DKIM_TRACE(0.00)[readmodwrite-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matt@readmodwrite.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,cloudflare.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,readmodwrite.com:mid,readmodwrite-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

From: Matt Fleming <mfleming@cloudflare.com>

mlx5e_tx_reporter_timeout_recover() accesses sq->netdev after
mlx5e_safe_reopen_channels() has torn down and freed the channel (and
its embedded SQs). Replace the three sq->netdev references with
priv->netdev which is safe because priv outlives channel teardown.

The netdev_err() call already used priv->netdev for this reason; make
the trylock/unlock and health_channel_eq_recover calls consistent.

This fixes the following KASAN splat:

  BUG: KASAN: use-after-free in mlx5e_tx_reporter_timeout_recover+0x1dd/0x360 [mlx5_core]
  Read of size 8 at addr ffff889860ed0b28 by task kworker/u113:2/5277

  Call Trace:
   mlx5e_tx_reporter_timeout_recover+0x1dd/0x360 [mlx5_core]
   devlink_health_reporter_recover+0xa2/0x150
   devlink_health_report+0x254/0x7c0
   mlx5e_reporter_tx_timeout+0x297/0x380 [mlx5_core]
   mlx5e_tx_timeout_work+0x109/0x170 [mlx5_core]
   process_one_work+0x677/0xf20
   worker_thread+0x51f/0xd90
   kthread+0x3a5/0x810
   ret_from_fork+0x208/0x400
   ret_from_fork_asm+0x1a/0x30

Fixes: 83ac0304a2d7 ("net/mlx5e: Fix deadlocks between devlink and netdev instance locks")
Cc: stable@vger.kernel.org
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
Changes in v2:
  - Add Cc: stable and Reviewed-by tags from Cosmin and Tariq.
  - Add people from the Fixes: commit and related discussion to Cc.
---

 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index afdeb1b3d425..8409ae73768f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -160,13 +160,13 @@ static int mlx5e_tx_reporter_timeout_recover(void *ctx)
 	 * channels are being closed for other reason and this work is not
 	 * relevant anymore.
 	 */
-	while (!netdev_trylock(sq->netdev)) {
+	while (!netdev_trylock(priv->netdev)) {
 		if (!test_bit(MLX5E_STATE_CHANNELS_ACTIVE, &priv->state))
 			return 0;
 		msleep(20);
 	}
 
-	err = mlx5e_health_channel_eq_recover(sq->netdev, eq, sq->cq.ch_stats);
+	err = mlx5e_health_channel_eq_recover(priv->netdev, eq, sq->cq.ch_stats);
 	if (!err) {
 		to_ctx->status = 0; /* this sq recovered */
 		goto out;
@@ -186,7 +186,7 @@ static int mlx5e_tx_reporter_timeout_recover(void *ctx)
 		   "mlx5e_safe_reopen_channels failed recovering from a tx_timeout, err(%d).\n",
 		   err);
 out:
-	netdev_unlock(sq->netdev);
+	netdev_unlock(priv->netdev);
 	return err;
 }
 
-- 
2.43.0

