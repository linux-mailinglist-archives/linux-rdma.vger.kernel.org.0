Return-Path: <linux-rdma+bounces-21762-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y2KlGVZpIWorGAEAu9opvQ
	(envelope-from <linux-rdma+bounces-21762-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 14:02:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E939463FADC
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 14:02:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=HXuyltHl;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21762-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21762-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34A1B3158ADD
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 11:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F54646AF08;
	Thu,  4 Jun 2026 11:46:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011050.outbound.protection.outlook.com [40.93.194.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78543427A06;
	Thu,  4 Jun 2026 11:46:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573614; cv=fail; b=gNEM9pjrI0bW+eLNV8uDzlxUxAC4OHUThFXvhsjujx7EuTnaasVKaBYl1vN5oosOfxQcle1LwWjVE5VYqJ6fRxUVnzdSDV0vjr3UP7H4fCfdsz2KnFwW2cWx4Ry9MVfNEd1h0CaGJHuagbGgXr7bUGWD4/TLm773DDI2zwR/hFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573614; c=relaxed/simple;
	bh=C7h9eXgyWriC/eX9VFn4FbsK1Ku1lIhzVLpIVRRm5Z4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zr6jiaFpsxbp9NnxOXfSeuGDn3BydVzRanPiV9ioNhsKL7c5U2YFqAQ8bUEbCWXYcDRcX6ZynSOKTAkUEIxYK01E1JOvTgAyiHUP6b6wGodf7MPD9WOwAF6TIhMjNyOi8PfndYViZyceImu3cIHGGbmoR22OmfFc6pa2zevkpbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HXuyltHl; arc=fail smtp.client-ip=40.93.194.50
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9KBrmtcmXxtdqgtR79SDOiH4b6TkhBvdfxRvMwrihH97XLneGoCSg0wmhgAnH63q0IAEqSzGKrMVZgnF87Cy7GXjrrKJkG37I4Yhb0bhB4sZ4UOMBcsWUtbKyocc1tpsbkUcMEMwsmSxEpugF3cJp+ZaHvC5shfVV1odkxsN3Gxi+gDRHQN8+p+9F+etFFLU9Ank51TfJulJFsUx/I7278uRnvt+EkNNCFsplFRY+O4fWFJL5yzKUNDr03xUFDTpT2FiVpbKRzL7l/1NuxnJjxGhNIHS796NQ8Wj3KqO4HhZv5xZj7CJf4IKZWotjrH7K8L8zoRH6Vd2utSBYHTrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b27XPRHdieH6Y2xuNa9vsG7YGjBa97giI7XMv6eGUDs=;
 b=bFS9YWshpHnye0lc8OqH0BJT1VHaaenrpxoTTiAUBJfKTPuCU2CSqrKWB00LInApU3rYutlT0LZxt70+3hElpvoWeN8Ox4/lm+JYtp28qiWZ4EcIin3Hs9JU/cf2LDX0T+DyNAvAUmsN0tWkQmTqbbYFT9h1DHAxBpOqxY74Q4bLqsxl8mlnOzVHoMQC+4fPcureOA/M1cCOfIrNkvuL4e0pBZ6scW77yFL39Tgy8uCUqVAdGvOmBVgO/mzhD33OLy3EisaE7lQtkqR14Y0SS+Fo1mxUhNNb4UI3vdjVyABsv7MEuFG7m5NECtOP0nTEnciiCy0xazZZNcDco4tF8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b27XPRHdieH6Y2xuNa9vsG7YGjBa97giI7XMv6eGUDs=;
 b=HXuyltHlFZyYMCaSW2euLMSJWmRZqjRt2cRdw+roaaj0b6d7uoLrt45NHKmZT3+QDNb6hGRRYFuK4bvJKDVs0I9O5JZbzWLpkeijBxSBQ6wWedl+eqW4qOPKjF8tIyrK89fKAWqX75E4j0+rSL4QBCqAzocbGUCQERuZnpYPP9k48w3Ld8T6WybzYyXvcQ0oiZO7RV1zGRfEszNikdZC/qujrVqLqxASSngAm9Rp4N6uW+Vc0tKNG1HjS58fEG9zMWor68OJ16ZAFREckMleDXvjOf6qme7FCS7fTLfp4ZwVjUpSEGEEqceXuJuaVygXdW6x+f0atlebYv+uDGzfHQ==
Received: from MW4PR03CA0071.namprd03.prod.outlook.com (2603:10b6:303:b6::16)
 by BL1PR12MB5801.namprd12.prod.outlook.com (2603:10b6:208:391::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 11:46:41 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::7f) by MW4PR03CA0071.outlook.office365.com
 (2603:10b6:303:b6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 11:46:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 11:46:40 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 04:46:36 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 4 Jun 2026 04:46:35 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Jun 2026 04:46:30 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Simon Horman <horms@kernel.org>, Maher Sanalla
	<msanalla@nvidia.com>, Parav Pandit <parav@nvidia.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next 12/15] net/mlx5: LAG, add MPESW over SD LAG support
Date: Thu, 4 Jun 2026 14:44:52 +0300
Message-ID: <20260604114455.434711-13-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260604114455.434711-1-tariqt@nvidia.com>
References: <20260604114455.434711-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|BL1PR12MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: 90d3410e-3244-4a08-e5bc-08dec22ef12b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	xg/ZTpDJ6M3Z0lHiD2f6EJuLKroPW56O3k9BquyC6DxmANLnIQWaU/IAORAlxBGo5+93y0Vak1ScSxcu0dr+vtouUWW5oiUXgAeqMiK3gb6HFvoH4jJ2PPHp1ccBpRMAzgpbuUnzi2uUehtcPMV58spOGYh/4TRRDRYReXcBet9DjToN8ZsSquLn+RsPoTqptKBp48zBOuoLKh/KgYeSo6tCeQbjwd81k8uhGBwgb1PXDj/VaotXCLPgIFDAbkVUeJmaLJXIQ0LTl+tmFBhpMuL8Zc6mlJZq7ONAkuj8KLrB1tvuxUeown2TCSPDLytDtQC8pA9NuJ2zI3SP2LX2kyE8xUF7YGKjMMeJFKlKT26ytkXFz0l496BTBRjNZYSLqywwBXV+SjD27sdaRwqGfsnpQx6zDKgPbomZ7SH+tyKUGzQq0eMhz/cw0/IkCHWlcT7A3T6o9B1WehOQvcTCJIij68cGputGkiV/2wmiws1DMCBoz1QptpPl7Nf0P74q+0AE8bOZI+Lgp4LpUhtUCqvfPBZWWbM30K5aA23d+lpDma+RnSWQWQbY++S8OqBsw+Bb6s4EPJvfxi+7u2w3mAk7R5VK3p2VdrNfY6u2+hDUx/eRwSD2jEnul01aMWNlNGKHcG+mCegyDhWGa+wl699NXGmcT17pcFz8AcRZyTQyyHcgRHaL6nsBvI2L31JTaaSZ2bZboIv4fkqhe8pb7b+LyvkF2+NsHl5d0FnmELg=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PndICmx78XGrhhw2OlAgUNj22TkRddRca03zdnnA+ig29wZGr8EEj+RjuEPxgayambJB9ThvTuBvd3pxdCBsShkB6DHeG1pp7VSrHtWSyagwrk1kCuQSJp05u3Gm0TpGMo9f8m4OJmOlAgjiSIHCsKf25RynssC/gs3+bgFxVqSiwzjqicx8xqzMbmKJkIqpwlB+CXcgifLB7bJKzyLq16OZiayVExfDJhN+E+/RB0oKnjUSH5khQyDofHuX1Ewt3lfoGwYHua2tRhUvlZ4DqrmdoJRUFfb8YthIetTHJal5hJ2HRu/BleWLYdzI3NbAZAJd946dhb5yaWxo3I7I3Z7GwObRId284NhCKfweIbqVLk4XiJnQQEyTkWHcBE+gc+hZC+SspQOjW+GSAGStQpKH17QqPhYTytS4vXhZalilGjlC+4b3v1mldHqEdgL3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 11:46:40.3391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d3410e-3244-4a08-e5bc-08dec22ef12b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5801
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-21762-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:horms@kernel.org,m:msanalla@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:moshe@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,Nvidia.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E939463FADC

From: Shay Drory <shayd@nvidia.com>

Enable MPESW LAG creation over SD LAG members, forming a composite LAG
hierarchy. This allows bonding multiple SD groups together under a
single MPESW configuration with shared FDB.

When enabling composite MPESW, the individual SD LAG shared FDB
configurations are temporarily torn down and recreated when the
composite LAG is disabled.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c |  6 ++
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |  8 ++
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c   | 95 +++++++++++++++++--
 .../ethernet/mellanox/mlx5/core/lag/mpesw.h   |  4 +
 4 files changed, 105 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 9566fbf59fdb..25a9012e3014 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -2545,6 +2545,7 @@ void mlx5_lag_disable_change(struct mlx5_core_dev *dev)
 	struct mlx5_core_dev *primary;
 	struct mlx5_lag *ldev;
 	struct lag_func *pf;
+	bool mpesw;
 	int i;
 
 	ldev = mlx5_lag_dev(dev);
@@ -2553,6 +2554,9 @@ void mlx5_lag_disable_change(struct mlx5_core_dev *dev)
 
 	primary = mlx5_sd_get_primary(dev) ?: dev;
 	mlx5_devcom_comp_lock(primary->priv.hca_devcom_comp);
+	mpesw = ldev->mode == MLX5_LAG_MODE_MPESW;
+	if (mpesw)
+		mlx5_mpesw_sd_devcoms_lock(ldev);
 	mutex_lock(&ldev->lock);
 
 	ldev->mode_changes_in_progress++;
@@ -2564,6 +2568,8 @@ void mlx5_lag_disable_change(struct mlx5_core_dev *dev)
 	}
 
 	mutex_unlock(&ldev->lock);
+	if (mpesw)
+		mlx5_mpesw_sd_devcoms_unlock(ldev);
 	mlx5_devcom_comp_unlock(primary->priv.hca_devcom_comp);
 
 	if (!sd_devcom)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
index 34350b0a7307..3a90d360d724 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
@@ -157,6 +157,14 @@ __mlx5_lag_is_sd(struct mlx5_lag *ldev, struct mlx5_core_dev *dev)
 	return pf && pf->group_id != 0;
 }
 
+static inline bool
+__mlx5_lag_dev_is_port(struct mlx5_lag *ldev, struct mlx5_core_dev *dev)
+{
+	struct lag_func *pf = mlx5_lag_pf_by_dev(ldev, dev);
+
+	return pf && xa_get_mark(&ldev->pfs, pf->idx, MLX5_LAG_XA_MARK_PORT);
+}
+
 static inline bool
 __mlx5_lag_is_active(struct mlx5_lag *ldev)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
index 2cb44084e239..50bfb450c71e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
@@ -15,7 +15,7 @@ static void mlx5_mpesw_metadata_cleanup(struct mlx5_lag *ldev)
 	u32 pf_metadata;
 	int i;
 
-	mlx5_ldev_for_each(i, 0, ldev) {
+	mlx5_lag_for_each(i, 0, ldev, MLX5_LAG_FILTER_ALL) {
 		dev = mlx5_lag_pf(ldev, i)->dev;
 		esw = dev->priv.eswitch;
 		pf_metadata = ldev->lag_mpesw.pf_metadata[i];
@@ -36,7 +36,7 @@ static int mlx5_mpesw_metadata_set(struct mlx5_lag *ldev)
 	u32 pf_metadata;
 	int i, err;
 
-	mlx5_ldev_for_each(i, 0, ldev) {
+	mlx5_lag_for_each(i, 0, ldev, MLX5_LAG_FILTER_ALL) {
 		dev = mlx5_lag_pf(ldev, i)->dev;
 		esw = dev->priv.eswitch;
 		pf_metadata = mlx5_esw_match_metadata_alloc(esw);
@@ -52,7 +52,7 @@ static int mlx5_mpesw_metadata_set(struct mlx5_lag *ldev)
 			goto err_metadata;
 	}
 
-	mlx5_ldev_for_each(i, 0, ldev) {
+	mlx5_lag_for_each(i, 0, ldev, MLX5_LAG_FILTER_ALL) {
 		dev = mlx5_lag_pf(ldev, i)->dev;
 		mlx5_notifier_call_chain(dev->priv.events, MLX5_DEV_EVENT_MULTIPORT_ESW,
 					 (void *)0);
@@ -65,6 +65,48 @@ static int mlx5_mpesw_metadata_set(struct mlx5_lag *ldev)
 	return err;
 }
 
+static void mlx5_mpesw_restore_sd_fdb(struct mlx5_lag *ldev)
+{
+	struct lag_func *pf;
+	int err, i;
+
+	mlx5_ldev_for_each(i, 0, ldev) {
+		pf = mlx5_lag_pf(ldev, i);
+		err = mlx5_lag_shared_fdb_create(ldev, NULL, 0, pf->group_id);
+		if (err)
+			mlx5_core_warn(pf->dev,
+				       "Failed to restore SD shared FDB (%d)\n",
+				       err);
+	}
+}
+
+static int mlx5_mpesw_teardown_sd_fdb(struct mlx5_lag *ldev)
+{
+	struct lag_func *pf;
+	int i;
+
+	mlx5_ldev_for_each(i, 0, ldev) {
+		pf = mlx5_lag_pf(ldev, i);
+		if (!pf->sd_fdb_active)
+			continue;
+		mlx5_lag_shared_fdb_destroy(ldev, pf->group_id);
+	}
+	return 0;
+}
+
+static bool mlx5_lag_has_sd_group(struct mlx5_lag *ldev)
+{
+	struct lag_func *pf;
+	int i;
+
+	mlx5_ldev_for_each(i, 0, ldev) {
+		pf = mlx5_lag_pf(ldev, i);
+		if (pf->group_id)
+			return true;
+	}
+	return false;
+}
+
 static int mlx5_lag_enable_mpesw(struct mlx5_lag *ldev)
 {
 	int idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
@@ -92,10 +134,17 @@ static int mlx5_lag_enable_mpesw(struct mlx5_lag *ldev)
 	if (err)
 		return err;
 
+	if (mlx5_lag_has_sd_group(ldev))
+		mlx5_mpesw_teardown_sd_fdb(ldev);
+
 	err = mlx5_lag_shared_fdb_create(ldev, NULL, MLX5_LAG_MODE_MPESW,
 					 MLX5_LAG_FILTER_ALL);
 	if (err) {
-		mlx5_core_warn(dev0, "Failed to create LAG in MPESW mode (%d)\n", err);
+		mlx5_core_warn(dev0,
+			       "Failed to create LAG in MPESW mode (%d)\n",
+			       err);
+		if (mlx5_lag_has_sd_group(ldev))
+			mlx5_mpesw_restore_sd_fdb(ldev);
 		mlx5_mpesw_metadata_cleanup(ldev);
 		return err;
 	}
@@ -105,9 +154,36 @@ static int mlx5_lag_enable_mpesw(struct mlx5_lag *ldev)
 
 void mlx5_lag_disable_mpesw(struct mlx5_lag *ldev)
 {
-	if (ldev->mode == MLX5_LAG_MODE_MPESW) {
-		mlx5_mpesw_metadata_cleanup(ldev);
-		mlx5_lag_shared_fdb_destroy(ldev, MLX5_LAG_FILTER_ALL);
+	if (ldev->mode != MLX5_LAG_MODE_MPESW)
+		return;
+
+	mlx5_mpesw_metadata_cleanup(ldev);
+	mlx5_lag_shared_fdb_destroy(ldev, MLX5_LAG_FILTER_ALL);
+	if (mlx5_lag_has_sd_group(ldev))
+		mlx5_mpesw_restore_sd_fdb(ldev);
+}
+
+void mlx5_mpesw_sd_devcoms_lock(struct mlx5_lag *ldev)
+{
+	struct mlx5_devcom_comp_dev *sd_devcom;
+	int i;
+
+	mlx5_ldev_for_each(i, 0, ldev) {
+		sd_devcom = mlx5_sd_get_devcom(mlx5_lag_pf(ldev, i)->dev);
+		if (sd_devcom)
+			mlx5_devcom_comp_lock(sd_devcom);
+	}
+}
+
+void mlx5_mpesw_sd_devcoms_unlock(struct mlx5_lag *ldev)
+{
+	struct mlx5_devcom_comp_dev *sd_devcom;
+	int i;
+
+	mlx5_ldev_for_each_reverse(i, MLX5_MAX_PORTS, 0, ldev) {
+		sd_devcom = mlx5_sd_get_devcom(mlx5_lag_pf(ldev, i)->dev);
+		if (sd_devcom)
+			mlx5_devcom_comp_unlock(sd_devcom);
 	}
 }
 
@@ -122,6 +198,7 @@ static void mlx5_mpesw_work(struct work_struct *work)
 		return;
 
 	mlx5_devcom_comp_lock(devcom);
+	mlx5_mpesw_sd_devcoms_lock(ldev);
 	mutex_lock(&ldev->lock);
 	if (ldev->mode_changes_in_progress) {
 		mpesww->result = -EAGAIN;
@@ -134,6 +211,7 @@ static void mlx5_mpesw_work(struct work_struct *work)
 		mlx5_lag_disable_mpesw(ldev);
 unlock:
 	mutex_unlock(&ldev->lock);
+	mlx5_mpesw_sd_devcoms_unlock(ldev);
 	mlx5_devcom_comp_unlock(devcom);
 	complete(&mpesww->comp);
 }
@@ -199,7 +277,8 @@ bool mlx5_lag_is_mpesw(struct mlx5_core_dev *dev)
 {
 	struct mlx5_lag *ldev = mlx5_lag_dev(dev);
 
-	return ldev && ldev->mode == MLX5_LAG_MODE_MPESW;
+	return ldev && ldev->mode == MLX5_LAG_MODE_MPESW &&
+	       __mlx5_lag_dev_is_port(ldev, dev);
 }
 EXPORT_SYMBOL(mlx5_lag_is_mpesw);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.h
index b767dbb4f457..5099723ba0f7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.h
@@ -33,8 +33,12 @@ void mlx5_lag_mpesw_disable(struct mlx5_core_dev *dev);
 int mlx5_lag_mpesw_enable(struct mlx5_core_dev *dev);
 #ifdef CONFIG_MLX5_ESWITCH
 void mlx5_lag_disable_mpesw(struct mlx5_lag *ldev);
+void mlx5_mpesw_sd_devcoms_lock(struct mlx5_lag *ldev);
+void mlx5_mpesw_sd_devcoms_unlock(struct mlx5_lag *ldev);
 #else
 static inline void mlx5_lag_disable_mpesw(struct mlx5_lag *ldev) {}
+static inline void mlx5_mpesw_sd_devcoms_lock(struct mlx5_lag *ldev) {}
+static inline void mlx5_mpesw_sd_devcoms_unlock(struct mlx5_lag *ldev) {}
 #endif /* CONFIG_MLX5_ESWITCH */
 
 #ifdef CONFIG_MLX5_ESWITCH
-- 
2.44.0


