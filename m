Return-Path: <linux-rdma+bounces-19501-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEd3KTcS6mmytQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19501-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 14:36:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 969F04520F7
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 14:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED76430C8358
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 12:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49D73EDAC5;
	Thu, 23 Apr 2026 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iY61JQJf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012002.outbound.protection.outlook.com [40.107.200.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9ED3EDAA9;
	Thu, 23 Apr 2026 12:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776947543; cv=fail; b=DbNZUu+pxZZbjv8xZI5SZ7WyYzJ3NfDRp9G08E4g9zDyXKhEzH0/Jl5aCSumLIUH+0yjkxi/Xvwc+s/HgCd+eTGkpw+ZeiBt0YxgSoZ4kqLUCR/CCBjjK7THBBY6JQmosg3qQ2pKol3l1yr1LKKXj7wT7TWeDzKyuu8SUG1mSnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776947543; c=relaxed/simple;
	bh=plyvs/hZLa4fUNXGqQVHDE+CUkygMadkO4FfDNC3ayw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbwG7G5BVqz23SJLv14Jw3o1dLnaHSunEjSrDI/4lix1PadnD1vAkw3OtdlEE4VaZAcbJLJtb3DnH0Fj28xYgJ2/9BmAK6yNihJZG1FktxQT3KiCRzrj6nf8A6dATQsm7t1Hs+oRDOd4HrS3pHAfBkXPGoWst6H92UVbcfIdv3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iY61JQJf; arc=fail smtp.client-ip=40.107.200.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FORwYLYIdv0J0xSCgaY3lR3zW73y3M0cfiMkmVXDmUSMYiCDY+ko+ds/5RTe29qCi8n4eworZta+oLdfItwy1UciWSk5mlhLWdOi6LPq2M4yQy3gZvcq7Tg7tAxL/xeEojmWc63Tyhe/C4QXnOJukGAIf1uZkjG5YJwSXOi9D/7uET1jOfZFcp/sdYcCZq4XY/D2og9DkA7hxwwf0uCL23bTF/miGYutp+umM93tjW2RVYw9pOJ6k3/ZZ8A5rTg6+3MVYAdN7Hz6nU5PjP6RCNgq8tJWcHZ9IRDdGOVqYZR2jUeIesZcQTMVYoO6bdlWk60XjUyG0c75obrb9rpyeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ORpUzBhe2SARf5gkym2WsNIFwamX8cJGIrZovrO7OE=;
 b=GpRB1zSw4Pufg5KGyAbwAM3yA8AZHWvlHeh1abFH83i6UwlDjhunNyaLSH0opJ8z9YW/8qBCuiEfJe/p9pI258qX2AUBMABS0RonKNSdCaRLDUO9RUCTzEURRScXMKqVjnKopmk3l3mVvyK0TZuAfkrUhPhUpESHFABp5UzTxIUVEsk9D4ROm6MS1zf9d/QrbCwepzEp/c/4x5/BaP9bBk60xSChGKZLyLV3S/Ub4bXGFEAR5zXT90hIsshQhJcg9wa3O+OgplIcrIxXhAbxCVPUILMVJr3W2zLD45bJqotfrKwQ+M4bRPA1eC2O6nqZx4xzWu1hXd0E08qaZA9DXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ORpUzBhe2SARf5gkym2WsNIFwamX8cJGIrZovrO7OE=;
 b=iY61JQJf3fk8ozVCrfKF15dVeXR8513dkUts7uI8ljwbV91CThgiq8DYrFzJaia/0+zV2CEyA4iBu6w06ETKvhvqWJh4pU2uLx7yhN61wevRgJQn66YUfvW0aNF+hyMWj3GXGfavQdzcb7v/nTm+73EOq2ER8bhD7qoZEOlZPZNWWJv8EA3YcShnGkZabDTTqOi+7ZA/tM+PYO9h1oe7iRo/DOYFqCSZywPDlPZNxn7oMfXByU0BrT65yPlWsBuiMRBHkaCqwm3mN5r0p3R2SDttvekSJpfxZAsAa1/V0pIdLBbcPJojwosaYBEHZy7pYzdZDHgdsfatLJ2jkG+IAg==
Received: from BN8PR04CA0062.namprd04.prod.outlook.com (2603:10b6:408:d4::36)
 by SJ1PR12MB6337.namprd12.prod.outlook.com (2603:10b6:a03:456::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 12:32:08 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:d4:cafe::19) by BN8PR04CA0062.outlook.office365.com
 (2603:10b6:408:d4::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.21 via Frontend Transport; Thu,
 23 Apr 2026 12:32:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.4 via Frontend Transport; Thu, 23 Apr 2026 12:32:07 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Apr
 2026 05:31:49 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 23 Apr 2026 05:31:49 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 23 Apr 2026 05:31:44 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Shay
 Drory <shayd@nvidia.com>, Simon Horman <horms@kernel.org>, Kees Cook
	<kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Gal Pressman <gal@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net V3 3/4] net/mlx5e: SD, Fix missing cleanup on probe/resume error
Date: Thu, 23 Apr 2026 15:31:03 +0300
Message-ID: <20260423123104.201552-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260423123104.201552-1-tariqt@nvidia.com>
References: <20260423123104.201552-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|SJ1PR12MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: eed4407d-40bd-4ad3-3d08-08dea1345542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	SM7woWEEWUb5gxWKaYRhaCcPShRxDnz193ZMwBcfmDvWWQQI1GeJaVP8bgIq2VQ3STQEOQQnyZgcFCRO49StUkxSGO65Z5Xeo4By0KdFavS37eiMv/khf5ndX90eRZ2CRh6XAFwYIFpyp2mhr/XHL7i8kUxE80xle/cWvLZm6pca084c3B9597UKvTfq6p4YrbvbE26PhY47ThuOm1vOPnkdXWepjFozed3SKMLfR6rVJyUWhm89SgzozEli/fob1nN/Dfsl37Hkm1+pQkf/T/LgEnr/slkD6WbWR+LRBfa2X0PWU+KEqUV9RnMfK/gxjQtwIlZahFGKj/kcC2XqtLQcW7ofZAwFW3y/XScQ9W2JJKKoil7q61dMQUIHcnKoYUOhtV1VROQKxY3UOmQz73THbV+jf8szCR4iw/iQh9v2bcmYas1fTO2/xFmpW5qwpUxn22a4qvZPwBoZ58C4y+/2O+YylWpm8bbuoviOgPU6ToTKm2mn0JFK++4KxGyLVJRjxWnh5/Pf3OECBbvzZgfksCXU1q1QaCT+KBufuFLulbaM7bIwmLQ0qt9iafqYnpyitfRsvMZG2EF6eXDHUM7//je05UcdwEKkaYiSwPrPe0HBVZNbd+/qOP4LOAELZ2P9/IQJ7DGK/o/CqMQtB+FJxzsbhrCtW783bUURFASPq9Qp/LhCgrKlUmoc78/BCsx5HwcIYw6C5HGUBZ98ien7sDexIE6MLUcHawoGyzzlaZCfoIRiua/yg+ZJjtpgpCGpI6tz4oHFSCWyelcVkw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xR2RRxbdHfvIGdnMVstMQMtDQ5ut+5SwgWqUd0KCR9MjcLpXm30FbKT1hUXyoYUCfM891I0LMJqIJtM8lATfpOLzrKFNEs/STd6H3+qib51Gl2PXh6vMmCccjjwCcOjn1nYa5fmabZZwtOlxvxBPFiodHj8i5BMnBd+sA/IVfK8jXDK8pd8oH0pHxFInOGGi7ZqL1pQTxI9zOag9fz+5p+y3woL53UnwvWYqW6/OyWZCL38F+3QT2pIh+Se2v959HWItVBFdXOJ22FRq4tgrGDL2ub6GpAEgM0/se8xVgTUSpMKdOA0/SxCM7QEs3C5kVyRBPPBCXZOyIyqn1MHX+G1NV60f0iZtQeVs5eVStSKS6Vghvmpg5ovHFa7qy4kNDIxelnGlTRUOW4RWkpsGUht7BJT0EWU1CDWFOxhIzW5BskZLKrixRCU/j+5ys23q
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 12:32:07.1903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eed4407d-40bd-4ad3-3d08-08dea1345542
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6337
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19501-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 969F04520F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shay Drory <shayd@nvidia.com>

When _mlx5e_probe() or _mlx5e_resume() fails, the preceding
successful mlx5_sd_init() is not undone, leaving the SD group in an
UP state without a matching cleanup.

Call mlx5_sd_cleanup() on the error path so the SD state is reset.

Fixes: 381978d28317 ("net/mlx5e: Create single netdev per SD group")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 22 +++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 5a46870c4b74..9c340ad2fe09 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -6774,9 +6774,16 @@ static int mlx5e_resume(struct auxiliary_device *adev)
 		return err;
 
 	actual_adev = mlx5_sd_get_adev(mdev, adev, edev->idx);
-	if (actual_adev)
-		return _mlx5e_resume(actual_adev);
+	if (actual_adev) {
+		err = _mlx5e_resume(actual_adev);
+		if (err)
+			goto sd_cleanup;
+	}
 	return 0;
+
+sd_cleanup:
+	mlx5_sd_cleanup(mdev);
+	return err;
 }
 
 static int _mlx5e_suspend(struct auxiliary_device *adev, bool pre_netdev_reg)
@@ -6912,9 +6919,16 @@ static int mlx5e_probe(struct auxiliary_device *adev,
 		return err;
 
 	actual_adev = mlx5_sd_get_adev(mdev, adev, edev->idx);
-	if (actual_adev)
-		return _mlx5e_probe(actual_adev);
+	if (actual_adev) {
+		err = _mlx5e_probe(actual_adev);
+		if (err)
+			goto sd_cleanup;
+	}
 	return 0;
+
+sd_cleanup:
+	mlx5_sd_cleanup(mdev);
+	return err;
 }
 
 static void _mlx5e_remove(struct auxiliary_device *adev)
-- 
2.44.0


