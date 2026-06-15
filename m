Return-Path: <linux-rdma+bounces-22238-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UARuHXkGMGr1LwUAu9opvQ
	(envelope-from <linux-rdma+bounces-22238-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 16:04:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E683D686EAA
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 16:04:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baidu.com header.s=selector1 header.b=OKzOesEt;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22238-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22238-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=baidu.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 132513020EB7
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 14:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202783F39F6;
	Mon, 15 Jun 2026 14:04:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from outbound.baidu.com (mx24.baidu.com [111.206.215.185])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 7BB923EBF15;
	Mon, 15 Jun 2026 14:04:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781532271; cv=none; b=dqNksKVmUGRC+hCTDBJiloLnrzr3FehnMbzukNm/9liCZpi3v5JRFxz4RmsSFQJqp/U1hbDspH3VWdc6UZv4ToFTN6LpMm89PUVxF+d4VOhMx5dEFEg8Ium4PvuNpwx7AgG7ANwQlQyNq/kDaX0plcMkknluBAAdve7kskJZfb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781532271; c=relaxed/simple;
	bh=fZIDeo/UETUWo+zN9NsMRtt6NEvaH/DlgCy1mFw0bw0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MKdGpFk1qlon/EmP41XWoZ0qKmdvvvrxHuXqwjC4ZOwSa1u0zFt7h4kGODeAhRr7f8LUGIfnHn65LXrWC3luRe2Abi3InRRvWI0o0lwuMK3DmxX6laA9HHQm5A/k+rUc4MCSsfEztGUzOtZsBJmOAiU+q/7ns+XDlwE6A7PifyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=OKzOesEt; arc=none smtp.client-ip=111.206.215.185
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <gal@nvidia.com>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][net-next] net/mlx5: Remove broken and unused mlx5_query_mtppse()
Date: Mon, 15 Jun 2026 22:04:06 +0800
Message-ID: <20260615140406.1828-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc4.internal.baidu.com (172.31.50.48) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1781532254;
	bh=4ayGKE1flGpCwegEA/QWJEj3l8FOvkEDo03ek+YbCcM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=OKzOesEtKIzs34NMq+C3OTw5CbcFGmMbqRl0R9QyT0FrbRwaOkH57mncIjwMTY6QU
	 eNWMHBc99SUF8UbYpHjvRuRPfQOnOE0RlrJbCOctY2qWDIgPY9+romL1i27kK0CEUy
	 F/dkShc3siKjABJFYJ8PcloTddMB3DePb2Blzj9PsbQKtQYPtH66kfHWsQujmCpxvo
	 3Mr+T679zE4YrIJZOmHHBR/W/xCb+e+ylBOjrarSBMWiC3bYV/ZuSW1CO1XTLGB2JM
	 aVKpgVnSffFwgwbrPMNzEajFRAbcRY9cH1nBPj9m0Q5QXgef/B/4uHfoM4mpRinU0M
	 UAhJrwIIq/yXQ==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[baidu.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[baidu.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:gal@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lirongqing@baidu.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22238-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[lirongqing@baidu.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[baidu.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lirongqing@baidu.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E683D686EAA

From: Li RongQing <lirongqing@baidu.com>

mlx5_query_mtppse() reads the Event Trigger Pin (MTPPSE) register but
reads the returned arm and mode values from the input buffer 'in'
instead of the output buffer 'out', so it always returns the values
that were written rather than the actual hardware state, making the
query useless.

The function has no in-tree callers. Remove it rather than fix it.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h |  1 -
 drivers/net/ethernet/mellanox/mlx5/core/port.c      | 19 -------------------
 2 files changed, 20 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 1507e88..a1001d5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -296,7 +296,6 @@ void mlx5_core_reps_aux_devs_remove(struct mlx5_core_dev *dev);
 void mlx5_fw_reporters_create(struct mlx5_core_dev *dev);
 int mlx5_query_mtpps(struct mlx5_core_dev *dev, u32 *mtpps, u32 mtpps_size);
 int mlx5_set_mtpps(struct mlx5_core_dev *mdev, u32 *mtpps, u32 mtpps_size);
-int mlx5_query_mtppse(struct mlx5_core_dev *mdev, u8 pin, u8 *arm, u8 *mode);
 int mlx5_set_mtppse(struct mlx5_core_dev *mdev, u8 pin, u8 arm, u8 mode);
 
 struct mlx5_dm *mlx5_dm_create(struct mlx5_core_dev *dev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
index ee8b976..ddbe9ca 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
@@ -908,25 +908,6 @@ int mlx5_set_mtpps(struct mlx5_core_dev *mdev, u32 *mtpps, u32 mtpps_size)
 				    sizeof(out), MLX5_REG_MTPPS, 0, 1);
 }
 
-int mlx5_query_mtppse(struct mlx5_core_dev *mdev, u8 pin, u8 *arm, u8 *mode)
-{
-	u32 out[MLX5_ST_SZ_DW(mtppse_reg)] = {0};
-	u32 in[MLX5_ST_SZ_DW(mtppse_reg)] = {0};
-	int err = 0;
-
-	MLX5_SET(mtppse_reg, in, pin, pin);
-
-	err = mlx5_core_access_reg(mdev, in, sizeof(in), out,
-				   sizeof(out), MLX5_REG_MTPPSE, 0, 0);
-	if (err)
-		return err;
-
-	*arm = MLX5_GET(mtppse_reg, in, event_arm);
-	*mode = MLX5_GET(mtppse_reg, in, event_generation_mode);
-
-	return err;
-}
-
 int mlx5_set_mtppse(struct mlx5_core_dev *mdev, u8 pin, u8 arm, u8 mode)
 {
 	u32 out[MLX5_ST_SZ_DW(mtppse_reg)] = {0};
-- 
2.9.4


