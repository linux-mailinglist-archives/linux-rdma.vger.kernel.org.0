Return-Path: <linux-rdma+bounces-6655-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5639F7B8E
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 13:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2117016DC45
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 12:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E571223E73;
	Thu, 19 Dec 2024 12:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFyHH90v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B01221447;
	Thu, 19 Dec 2024 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611857; cv=none; b=YUQEtzd1jywiZ5zwyxLm7H3LhCy0EvkOZ1WsIrGH01JiC21dYr2REuQaGSn3d5EhvGkPe36+Cp+chgopGzXx0bZ+ZDEeNVUTZf+M8WFj6xVOywWasisOGb5qL4JD4G3c+nV47NybhB+sFUPyDJF+6aDDYlEqMuusapLn/UCqhcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611857; c=relaxed/simple;
	bh=iTa+ur7lm+4z/RqHiWarKbLC9Qqkyo0J2aItQd06+kA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pF1AgxLtpreUBsA5hMgPGfmQqGpjNTMTKGsdYF0+VghDvG+n1vUZqbQdSCYK3O6yIrkGw9HYQx6Hrj5S2jsK7PLURVrbF3369erXAnLffHxY39MrIYOsrg9XUXPmRefu/nzkhJCy5jcQvHlam8vxp2jvJubon8DuNARzfRZfygA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFyHH90v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD090C4CECE;
	Thu, 19 Dec 2024 12:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734611857;
	bh=iTa+ur7lm+4z/RqHiWarKbLC9Qqkyo0J2aItQd06+kA=;
	h=From:To:Cc:Subject:Date:From;
	b=LFyHH90v7aIIaiYgtuCkgNduif2EcRXx+t1NKd7L1JnKgp9JhZhnEOSlm4mq5hs8Y
	 6KOUOnY+Ox80NZ6TDiY23JfeIOdNvobIpOdA6QS9ywdFu0dbA3FOY6XfpOIqDbUy8W
	 1ZINLSJE220I6N3v3/y0cFy5e7hAdIp8CQYlAm8x3XG2o46sRdpYygpXV7ipsBrDNa
	 mT5pP8APZt4w3AFD60pC2UIolum9bf1RKsZi0ABswVkGRLf8/MO7aXZWHnr+ft87oS
	 krYLDiy3AcMy44LN7D0yJ6eFAOmGg4MvU8cPpznL+wZzWC13I2wBNGcNOCYHbYVKDM
	 Mwe/5FBFWzAww==
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Jianbo Liu <jianbol@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH ipsec-next 1/2] xfrm: Support ESN context update to hardware for TX
Date: Thu, 19 Dec 2024 14:37:29 +0200
Message-ID: <874f965d786606b0b4351c976f50271349f68b03.1734611621.git.leon@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

Previously xfrm_dev_state_advance_esn() was added for RX only. But
it's possible that ESN context also need to be synced to hardware for
TX, so call it for outbound in this patch.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/networking/xfrm_device.rst                 | 3 ++-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c          | 3 +++
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c | 3 +++
 net/xfrm/xfrm_replay.c                                   | 1 +
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/xfrm_device.rst b/Documentation/networking/xfrm_device.rst
index bfea9d8579ed..66f6e9a9b59a 100644
--- a/Documentation/networking/xfrm_device.rst
+++ b/Documentation/networking/xfrm_device.rst
@@ -169,7 +169,8 @@ the stack in xfrm_input().
 
 	hand the packet to napi_gro_receive() as usual
 
-In ESN mode, xdo_dev_state_advance_esn() is called from xfrm_replay_advance_esn().
+In ESN mode, xdo_dev_state_advance_esn() is called from
+xfrm_replay_advance_esn() for RX, and xfrm_replay_overflow_offload_esn for TX.
 Driver will check packet seq number and update HW ESN state machine if needed.
 
 Packet offload mode:
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index bc3af0054406..e56e4f238795 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -6559,6 +6559,9 @@ static void cxgb4_advance_esn_state(struct xfrm_state *x)
 {
 	struct adapter *adap = netdev2adap(x->xso.dev);
 
+	if (x->xso.dir != XFRM_DEV_OFFLOAD_IN)
+		return;
+
 	if (!mutex_trylock(&uld_mutex)) {
 		dev_dbg(adap->pdev_dev,
 			"crypto uld critical resource is under use\n");
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index ca92e518be76..3dd4f2492090 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -980,6 +980,9 @@ static void mlx5e_xfrm_advance_esn_state(struct xfrm_state *x)
 	struct mlx5e_ipsec_sa_entry *sa_entry_shadow;
 	bool need_update;
 
+	if (x->xso.dir != XFRM_DEV_OFFLOAD_IN)
+		return;
+
 	need_update = mlx5e_ipsec_update_esn_state(sa_entry);
 	if (!need_update)
 		return;
diff --git a/net/xfrm/xfrm_replay.c b/net/xfrm/xfrm_replay.c
index bc56c6305725..e500aebbad22 100644
--- a/net/xfrm/xfrm_replay.c
+++ b/net/xfrm/xfrm_replay.c
@@ -729,6 +729,7 @@ static int xfrm_replay_overflow_offload_esn(struct xfrm_state *x, struct sk_buff
 		}
 
 		replay_esn->oseq = oseq;
+		xfrm_dev_state_advance_esn(x);
 
 		if (xfrm_aevent_is_on(net))
 			xfrm_replay_notify(x, XFRM_REPLAY_UPDATE);
-- 
2.47.0


