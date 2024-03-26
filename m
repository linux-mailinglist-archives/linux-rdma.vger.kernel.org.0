Return-Path: <linux-rdma+bounces-1588-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4EF88D148
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 23:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0F11C60F99
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 22:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374B413E40A;
	Tue, 26 Mar 2024 22:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niUVsVHK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67A813E021;
	Tue, 26 Mar 2024 22:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492800; cv=none; b=IyaCnX9AkTqakZF12f4/QEArm1V2DnqShkP2km+dS33QG7LEyuzUxWN9yq646Km8Z0Yhvr7sp5a+oNWD79iHDn9iXBZKvJE6z6OGQBTTMRX7RpKn3Wm8sjicQyV1LiretduXldE4JvPDQ1ATNkyz09N6l9zg7bCx/ssyOmkb5pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492800; c=relaxed/simple;
	bh=lulGfl/VARvXl3v+IQINE9T8HFeaXr5b7miTjpnKPBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aYRPBKlR55ue5TLUGjnBVE1jxa7Xv+6WEU0CLEF+ZGlOhYtE72gnzoDt9gD8LxRJ2H0iiUNi4roFk1zDEjknDyfOLUOKPKS11KXimBwiRg6lcQkx2Vk7B7iWXYtFLvlzs67ktYLIUsVUiW9gGLYEpXljbvrLPj2bG8m6sl+SLac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niUVsVHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FEBC433C7;
	Tue, 26 Mar 2024 22:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711492800;
	bh=lulGfl/VARvXl3v+IQINE9T8HFeaXr5b7miTjpnKPBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=niUVsVHKc3NZHc+8bduQh4f+aNkZPxgGbbD/cp6isZmq1TLeongbEUIco/kjnVt4w
	 vrcNPIFu1AXIefydV9FNMA85yIawUajQw4k+GVHqaRrM7sLk34fxC8PhMqn8zjPjon
	 Rvl0Yo4kcCNjUZ9dH+6oF++f+v39DMtxPzVXQfgmjT045TQ9zYUPXioxybMsAynosm
	 NrWCVpBujF9x8mXOInpLI1ROZ3A+ALXRjiJE0QikPWDETejt3OrZ5Xl6+UGQ3Dy6GX
	 Juc0uFFkx6qC3xK5BAjJBHy5fiq2zDKL3B6YNW+SF514M+hngUaYRuaQ1LmV9WSQdK
	 E6vkxMGcrXDBg==
From: Arnd Bergmann <arnd@kernel.org>
To: llvm@lists.linux.dev,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Vlad Buslov <vladbu@nvidia.com>,
	Roi Dayan <roid@nvidia.com>,
	Maor Dickman <maord@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] mlx5: avoid truncating error message
Date: Tue, 26 Mar 2024 23:38:03 +0100
Message-Id: <20240326223825.4084412-5-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326223825.4084412-1-arnd@kernel.org>
References: <20240326223825.4084412-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang warns that one error message is too long for its destination buffer:

drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c:1876:4: error: 'snprintf' will always be truncated; specified size is 80, but format string expands to at least 94 [-Werror,-Wformat-truncation-non-kprintf]

Reword it to be a bit shorter so it always fits.

Fixes: 70f0302b3f20 ("net/mlx5: Bridge, implement mdb offload")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
index 1b9bc32efd6f..c5ea1d1d2b03 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
@@ -1874,7 +1874,7 @@ int mlx5_esw_bridge_port_mdb_add(struct net_device *dev, u16 vport_num, u16 esw_
 				 "Failed to lookup bridge port vlan metadata to create MDB (MAC=%pM,vid=%u,vport=%u)\n",
 				 addr, vid, vport_num);
 			NL_SET_ERR_MSG_FMT_MOD(extack,
-					       "Failed to lookup bridge port vlan metadata to create MDB (MAC=%pM,vid=%u,vport=%u)\n",
+					       "Failed to lookup vlan metadata for MDB (MAC=%pM,vid=%u,vport=%u)\n",
 					       addr, vid, vport_num);
 			return -EINVAL;
 		}
-- 
2.39.2


