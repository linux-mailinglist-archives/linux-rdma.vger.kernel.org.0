Return-Path: <linux-rdma+bounces-9461-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB4AA8ADC1
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 04:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32DCA3B225E
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 02:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64088227E94;
	Wed, 16 Apr 2025 02:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNT2UY8M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CDE15E96;
	Wed, 16 Apr 2025 02:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744768879; cv=none; b=hhRVZ2PbglAPsOiChken3s9LDEeE4MNdr3pA9GXfOS/SjsE7rK8JQ/EXc51y/b5shm9tNXb/G39Oe+JdUfWaF9xehhaeS26PSnZbDDEoUvxxQ2enu7N1VZmG6CaZGMB3RakN7v9ut2RtZXXUYUnVaug3h0CdqGTEr42H50K9F8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744768879; c=relaxed/simple;
	bh=nEhH+Ut3F8uAcBTMMylusgUEDdx1R8hJlDxeA1XhERM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZnvVDoCrMCUVuPQW7VbnigxBA2QR3LZ3aBk+O/Czudr77bgMLY5UW63s34JTIzfrPQaa+cwFK/EQFB8rhL5HPDyyw0K8OelztJodH3NglhXvNIq2NyMTEGJvBo0CXWyp07oK0jONlDNaLViM7Fike1QbYv4fp+eQw2mjY8vgdzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNT2UY8M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACD8C4CEE7;
	Wed, 16 Apr 2025 02:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744768878;
	bh=nEhH+Ut3F8uAcBTMMylusgUEDdx1R8hJlDxeA1XhERM=;
	h=From:To:Cc:Subject:Date:From;
	b=YNT2UY8MJqxDYqUJ5wOVCnB9hVE2OIYoH9ua3Jsl8ikpke4pgXQ/asbzniq2k6BCR
	 MozP5zzjg8tJbD5mQiFkgMliM7a8W1NLBIsJ9BVmoK4quZx6mXVGWVKinuczh1fuf5
	 //RyLjUHNwNAmqeJdzZib/Z5iYDBSfW9Mj9JwR4YS528YF9PnuIWzxjpqbULUCZY2p
	 0bBDRmCaM77RgngvZQ/Hr7DbPjK2GqMv+J8qP0h4/KBm6J4GtrKta9mBr1eyncVhOz
	 /TM+djOgA65n202CKo2H5z9OVSg6yFi+LEbWAXDUhUJP3zaBafTRwJI0FcvI6z9Xpc
	 ftGxL9LNkxUgg==
From: Kees Cook <kees@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>
Cc: Kees Cook <kees@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] net/mlx5e: ethtool: Fix formatting of ptp_rq0_csum_complete_tail_slow
Date: Tue, 15 Apr 2025 19:01:14 -0700
Message-Id: <20250416020109.work.297-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4652; i=kees@kernel.org; h=from:subject:message-id; bh=nEhH+Ut3F8uAcBTMMylusgUEDdx1R8hJlDxeA1XhERM=; b=owGbwMvMwCVmps19z/KJym7G02pJDOn/+TOF7J6w5O3gP7+K2c3bYuaKKNu1HkY3Dfdr8/6Y+ m5D6BK/jlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIl8v8bIsHCxYeglTgF3DrsT U57ImsS+XahxQJVjfen06b6zZ3rESTD8D874JvKu1Zfx+7S4O3s0ko6uy+1YcPeV1ZLjNyb/dli 7nQcA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The new GCC 15 warning -Wunterminated-string-initialization reports:

In file included from drivers/net/ethernet/mellanox/mlx5/core/en.h:55,
                 from drivers/net/ethernet/mellanox/mlx5/core/en_stats.c:34:
drivers/net/ethernet/mellanox/mlx5/core/en_stats.h:57:46: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (33 chars into 32 available) [-Wunterminated-string-initialization]
   57 | #define MLX5E_DECLARE_PTP_RQ_STAT(type, fld) "ptp_rq%d_"#fld, offsetof(type, fld)
      |                                              ^~~~~~~~~~~
drivers/net/ethernet/mellanox/mlx5/core/en_stats.c:2279:11: note: in expansion of macro 'MLX5E_DECLARE_PTP_RQ_STAT'
 2279 |         { MLX5E_DECLARE_PTP_RQ_STAT(struct mlx5e_rq_stats, csum_complete_tail_slow) },
      |           ^~~~~~~~~~~~~~~~~~~~~~~~~

This stat string is being used in ethtool_sprintf(), so it must be a
valid NUL-terminated string. Currently the string lacks the final NUL
byte (as GCC warns), but by absolute luck, the next byte in memory is a
space (decimal 32) followed by a NUL. "format" is immediately followed
by little-endian size_t:

struct counter_desc {
        char                       format[32];           /*     0    32 */
        size_t                     offset;               /*    32     8 */
};

The "offset" member is populated by the stats member offset:

 #define MLX5E_DECLARE_PTP_RQ_STAT(type, fld) "ptp_rq%d_"#fld, offsetof(type, fld)

which for this struct mlx5e_rq_stats member, csum_complete_tail_slow, is
32, or space, and then the rest of the "offset" bytes are NULs.

struct mlx5e_rq_stats {
	...
        u64                        csum_complete_tail_slow; /* 32     8 */

The use of vsnprintf(), within ethtool_sprintf(), reads past the end of
"format" and sees the format string as "ptp_rq%d_csum_complete_tail_slow ",
with %d getting resolved by MLX5E_PTP_CHANNEL_IX (value 0):

                       ethtool_sprintf(data, ptp_rq_stats_desc[i].format,
                                       MLX5E_PTP_CHANNEL_IX);

With an output result of "ptp_rq0_csum_complete_tail_slow", which gets
precisely truncated to 31 characters with a trailing NUL.

So, instead of accidentally getting this correct due to the NUL bytes
at the end of the size_t that happens to follow the format string, just
make the string initializer 1 byte shorter by replacing "%d" with "0",
since MLX5E_PTP_CHANNEL_IX is already hard-coded. This results in no
initializer truncation and no need to call sprintf().

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org
Cc: linux-rdma@vger.kernel.org
---
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c | 3 +--
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 1c121b435016..19664fa7f217 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -2424,8 +2424,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(ptp)
 	}
 	if (priv->rx_ptp_opened) {
 		for (i = 0; i < NUM_PTP_RQ_STATS; i++)
-			ethtool_sprintf(data, ptp_rq_stats_desc[i].format,
-					MLX5E_PTP_CHANNEL_IX);
+			ethtool_puts(data, ptp_rq_stats_desc[i].format);
 	}
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 8de6fcbd3a03..def5dea1463d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -54,7 +54,7 @@
 #define MLX5E_DECLARE_PTP_TX_STAT(type, fld) "ptp_tx%d_"#fld, offsetof(type, fld)
 #define MLX5E_DECLARE_PTP_CH_STAT(type, fld) "ptp_ch_"#fld, offsetof(type, fld)
 #define MLX5E_DECLARE_PTP_CQ_STAT(type, fld) "ptp_cq%d_"#fld, offsetof(type, fld)
-#define MLX5E_DECLARE_PTP_RQ_STAT(type, fld) "ptp_rq%d_"#fld, offsetof(type, fld)
+#define MLX5E_DECLARE_PTP_RQ_STAT(type, fld) "ptp_rq0_"#fld, offsetof(type, fld)
 
 #define MLX5E_DECLARE_QOS_TX_STAT(type, fld) "qos_tx%d_"#fld, offsetof(type, fld)
 
-- 
2.34.1


