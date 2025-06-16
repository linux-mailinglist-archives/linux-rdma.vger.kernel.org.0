Return-Path: <linux-rdma+bounces-11331-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 923B9ADAA9B
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 10:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCAAE1891F57
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 08:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4723026D4C0;
	Mon, 16 Jun 2025 08:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkscdBit"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AE02163B2;
	Mon, 16 Jun 2025 08:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750062270; cv=none; b=Tb9Gx9KVSAA7Ttcz40qGoVN/1TlMnMdff+k1HPaNq5JhWgp9HnE8ZRN+FdwkaFoC/vvr5Y+FMNW9PxNgIsTjVJr/rWuamGtmle+kGMHlQsZzP4iBbLWXNHq9/L/gphen0gBOnhUnWLsNZm/DRmbzxE25D2b9ZolCFL7lLkfs7F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750062270; c=relaxed/simple;
	bh=2wunBQAEUUjaoDkXd/pxyrdC4UwepMLxk2ExQRIJD3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uQW4z8EWtTGBZjvGfOgCxDABt9G2tmEarxwgHzcoJuUg99kP8f0hOhgjp27/j7BdoQ7qg+plNsJtxd5NUnwrBp7goKLDIJI1SfPmCoueh/0Ed93ZifjlnsEH/7yABiDyQ6rd/dtliVz5doUxxlHthxe1x5q8xxYblhhKR/PQUWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkscdBit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB09C4CEEA;
	Mon, 16 Jun 2025 08:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750062269;
	bh=2wunBQAEUUjaoDkXd/pxyrdC4UwepMLxk2ExQRIJD3Q=;
	h=From:To:Cc:Subject:Date:From;
	b=jkscdBit8Sid4gQDBvclhlpmB3PXZY2xMH3LQjEvjoyiaGbaaCe6UlYmqIjHpAt00
	 0KuPBjGNYh/jjuc3G88+khp530fPj5tS4wlSlQSsDueXpAKEtBqyEa279mjJKZQnfT
	 NYjNvrdcYasr+DXT205vDoTd+scc7MGjxEAf+qtu73Cd0jOZBnfJTPRrfvNo011oik
	 r68NLLC8PGiqyfRwqZwl4fYGah7QrBSe9Z6uuWAL7/nwLB0F521bNgOaofK18tXV4a
	 qnt8BnhEH8wGfUqFsoQoj41IqP8/bFIGyUxFFcRvQJbAu3bp+Bph2oyXOBQv4E4sEk
	 Amn26tXd++ySw==
From: Leon Romanovsky <leon@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Mark Zhang <markzhang@nvidia.com>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH net] net/mlx4e: Remove redundant definition of IB_MTU_XXX
Date: Mon, 16 Jun 2025 11:24:23 +0300
Message-ID: <aca9b2c482b4bea91e3750b15b2b00a33ee0265a.1750062150.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Zhang <markzhang@nvidia.com>

Remove them to avoid "redeclaration of enumerator" build error, as they
are already defined in ib_verbs.h. This is needed for the following
patch, which need to include the ib_verbs.h.

Fixes: 096335b3f983 ("mlx4_core: Allow dynamic MTU configuration for IB ports")
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx4/main.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
index febeadfdd5a5..03d2fc7d9b09 100644
--- a/drivers/net/ethernet/mellanox/mlx4/main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
@@ -49,6 +49,8 @@
 #include <linux/mlx4/device.h>
 #include <linux/mlx4/doorbell.h>
 
+#include <rdma/ib_verbs.h>
+
 #include "mlx4.h"
 #include "fw.h"
 #include "icm.h"
@@ -1246,14 +1248,6 @@ static ssize_t set_port_type(struct device *dev,
 	return err ? err : count;
 }
 
-enum ibta_mtu {
-	IB_MTU_256  = 1,
-	IB_MTU_512  = 2,
-	IB_MTU_1024 = 3,
-	IB_MTU_2048 = 4,
-	IB_MTU_4096 = 5
-};
-
 static inline int int_to_ibta_mtu(int mtu)
 {
 	switch (mtu) {
@@ -1266,7 +1260,7 @@ static inline int int_to_ibta_mtu(int mtu)
 	}
 }
 
-static inline int ibta_mtu_to_int(enum ibta_mtu mtu)
+static inline int ibta_mtu_to_int(enum ib_mtu mtu)
 {
 	switch (mtu) {
 	case IB_MTU_256:  return  256;
-- 
2.49.0


