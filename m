Return-Path: <linux-rdma+bounces-19823-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHAAGOor9GlA+wEAu9opvQ
	(envelope-from <linux-rdma+bounces-19823-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 06:28:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6827E4AA54C
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 06:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 406483020D34
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2026 04:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD822FF66B;
	Fri,  1 May 2026 04:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RXRAcZ3n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013024.outbound.protection.outlook.com [40.93.196.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4F42F745C;
	Fri,  1 May 2026 04:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777609081; cv=fail; b=qRPB4OaxkL7r6CfVbcmU8CMuMkYbosEWYQO3TWJoJAEcYQqVJ7wPedbjROE2yqhh+NyKbgDC6408qP962GAFI1qepZYeK4IIlKIvt3yAAksRcvchO/XqnAQCcMr7A71pjyaYcSxbcfI3c0edNTItgPU7cQZAEn2WqbkSXj93HSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777609081; c=relaxed/simple;
	bh=5MIInt+Y+u7mKnfRlPU99I8yEv7BH08wZEB2WflIYFw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cP2keY6HY7GYhz6f47Ctm3CDksoCObhKEeNF3UaVKDl5U5z+PzFo2s2vdDDyMK2VyfZRKbpvNv9RB/vNbzHvgRXhGlWVtqnOQoinXhNXmGDITe07IGqX8YLFDRj6X7EduOE8EO4a3Tx2H5dYbtvS0YrWP9b2erxZ4PeBOFzhCxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RXRAcZ3n; arc=fail smtp.client-ip=40.93.196.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8n59S7BeTcMxrmssCk5xasn+VUKZdbCjA6MJE9ViBtFDtqZQj/hx+fQJY31yir9vvbOXBBqhRhs5HhVKjw6G789NMDdIXGLpKQrX7iwexNIZecNt0IEsbZLSo2Aw5os9n2XRPeXaLS6PbS9uGhgMqTEwSkxtg48lUX6GRLIhTsKtk03XoXIQN9oHNaGPt2Ic6ZEQqAhugAT2KDQUEDqzRcq1yXKif1Yc+lW+xn9Ta6sXJrv6GvWjrRPtfU3w7VTO6u0QDhOyajoFyp2p1YFQ4G3bEQRPqFuharH1deGZPP8L1NGZYJm+NRL1ewgPZQjD6uZIL6t8AB3Dwc/BuCDrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYugGDI18ti/LwbPPrYqcQpKwQjMG5B0ihj2okDAXoE=;
 b=NY7tBHHGSorGqSTt1vRE0xI4aJik3g4wDdB3Lyn63zDo8ZZzHZrGEZZvKDMHe8PpJgYM4aft2Ahw5LCG3qhKso745hW3KTL9LyZXNRC27l/+jRb6Xe9si9DarBCjt3yo8uFEoBeHbHMgcMqItKPeBc76p2i2ArHHVDqtZM7B3p3ugE0wjfiNxmDNZTyIZnTlwM2f+OF2CJ7XNbltNKJS3p9gU7KM0Wm5VB+M6u/Rlyrww4FtG7X4o1A4UnEkH39n9OnXEIOqq2U/5hLXedYnGithHQV/qm6GiZxE7ZiHgU4lQHcbQSqw31DnBCeskEEoCXKpQdAKcx0Znh84hb5muQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYugGDI18ti/LwbPPrYqcQpKwQjMG5B0ihj2okDAXoE=;
 b=RXRAcZ3nNWNMe549PhUBTQBx1yYdMAj6bIbJKQrW3XaB8DK4W5nzIN6SyzJs3xLaTXEdzurwW9v/ZKgIaWyFl5TtFu024oI9P4MrvTBbBKuuE5ViQV3WXOljvQ60CORl6oaegFF8WqqNMQKovfvXFX5DtYS5+RdBrz/XB88IYINTcG96LH1gNKS6egTN822jTwNbovdBYTPyi2wrCvAWNwcY1epc2uMwciuvSOZFwX+Pac3HLxoQLCxznR+DCh+m7PbVx1U/TelW5+wIPfuWKJOZy4nXvgbbJ3McP6H8GUgPTnctgwJIHdA8JgBh+JhqH18Yuf36UHPLRx8flUvN5A==
Received: from DM6PR06CA0040.namprd06.prod.outlook.com (2603:10b6:5:54::17) by
 DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.22; Fri, 1 May 2026 04:17:45 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:5:54:cafe::c9) by DM6PR06CA0040.outlook.office365.com
 (2603:10b6:5:54::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.23 via Frontend Transport; Fri,
 1 May 2026 04:17:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.22 via Frontend Transport; Fri, 1 May 2026 04:17:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 21:17:27 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 21:17:26 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 30
 Apr 2026 21:17:19 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shay Drory <shayd@nvidia.com>, Or Har-Toov
	<ohartoov@nvidia.com>, Edward Srouji <edwards@nvidia.com>, Maher Sanalla
	<msanalla@nvidia.com>, Simon Horman <horms@kernel.org>, Gerd Bayer
	<gbayer@linux.ibm.com>, Moshe Shemesh <moshe@nvidia.com>, Kees Cook
	<kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next V2 1/7] net/mlx5: Lag: refactor representor reload handling
Date: Fri, 1 May 2026 07:16:27 +0300
Message-ID: <20260501041633.231662-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260501041633.231662-1-tariqt@nvidia.com>
References: <20260501041633.231662-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|DS2PR12MB9615:EE_
X-MS-Office365-Filtering-Correlation-Id: 32cedbe3-5287-4e22-e503-08dea73898ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	MENthB2JhaKxcYoH+ZQ8Fyvx0y88gV7V54Fa4jZf3l0NlniIS0zQSaTSK1K79ZpaJvx4olSoWHctNmOMN9OqiloBilshwtB3IduuGnyyImJhDWbVDCmQlooBAWwaKtYjDGSsK3Qf4JJ5ELo9JWoAy+zcTrXIPQSeunYpBCF2Eu6JGNmswv3r09jSgBv8SEWaFr2bIJPxfIIGt5cTUUTMR2rWheMWfiKGrSZp9Bqy0KOWhBsuem7/i8InmySGxk25JUkQxTvYBEbzd25pIy2uuUNTvXKJB93TAF3V+JpEk7b7Wljczqf6PXw+00+kwhuUBCflF4cse7Oi128DheEYOeNHdlkz8l1doCTvtU7hC2u/tiuVfFV0XDe380y5x4VvJzhrJtVLKEUcCtBpejKAL8HPDAgnMeHgI6mfos/sGHFJ4NtPPf/SNPYtcvL+BkRYiCPwSP8UWYQCdvSTWcvqVZmQI5G4p/KsHDIQnvtOukBSqM92mqVEMfGdXIhPbWyDCafS01KujnVd46HHjEpdmQC9BnbZryZgghagfGrNKuprFnHidKh1iVv5ygzlBS0+bxMhf51fnTwyvcGvNf+LDMdDfqoEdhrt8S0JRSLGyThCEX+oSt7IkGRhz1LNOHHKjKAnQJakLeTZ2coDfbQ0DSpgYrWseJQr0z7YU0Ath4hieez9PdMGiC4F6Cr8QbpBd6qZYLnkLjKQHPOAko4c5wxbr1d2vJABiS7DaoK+voI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	auWDZA/4UV9b5cElqL/sQdc9yfrvHj8SQm8Mq54YyGwTFcfwtNAz80msu3qv/IroMvBNblrUUxzlnZWFXmbLOyogc2TxrCXdh3110zNmEyt7IYnwoMikz/uBT5ksbgbiX5VUXyUOUyP3aO/jF5ix252FU4rAQM+I5uAggzhZ35JtdEjsdQ50cnReAtayl6wLvNK9E3WC0DW69KPewghos+P3KjiW26xp9ogvmE3Q25/vY7hXKxY0yfQpC7bL6T9lV0bCI65e4xEsDDXFN0de6MOV6bwPO/EfN+0RLvmI8g0UIf98j9DUFGHIf7Q57ETWo7T6ktFlMOj17orvgT43HBev8VNCPqHnA2+DYKJv3hFkvA7zCUC1uHRPGLKT3tXzaF7EDQARbsm/NoTJa9IUXxmCW7AtZf7AU944i99HPjW7kAmQIKMgQCFgNy3jsIBs
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 04:17:45.3277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cedbe3-5287-4e22-e503-08dea73898ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9615
X-Rspamd-Queue-Id: 6827E4AA54C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_FROM(0.00)[bounces-19823-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Mark Bloch <mbloch@nvidia.com>

Representor reload during LAG/MPESW transitions has to be repeated in
several flows, and each open‑coded loop was easy to get out of sync
when adding new flags or tweaking error handling. Move the sequencing
into a single helper so that all call sites share the same ordering
and checks

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 45 +++++++++++--------
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |  2 +
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c   | 12 ++---
 3 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 449e4bd86c06..a474f970e056 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -1093,6 +1093,27 @@ void mlx5_lag_remove_devices(struct mlx5_lag *ldev)
 	}
 }
 
+int mlx5_lag_reload_ib_reps(struct mlx5_lag *ldev, u32 flags, bool cont_on_fail)
+{
+	struct lag_func *pf;
+	int ret;
+	int i;
+
+	mlx5_ldev_for_each(i, 0, ldev) {
+		pf = mlx5_lag_pf(ldev, i);
+		if (!(pf->dev->priv.flags & flags)) {
+			struct mlx5_eswitch *esw;
+
+			esw = pf->dev->priv.eswitch;
+			ret = mlx5_eswitch_reload_ib_reps(esw);
+			if (ret && !cont_on_fail)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
 void mlx5_disable_lag(struct mlx5_lag *ldev)
 {
 	bool shared_fdb = test_bit(MLX5_LAG_MODE_FLAG_SHARED_FDB, &ldev->mode_flags);
@@ -1130,9 +1151,8 @@ void mlx5_disable_lag(struct mlx5_lag *ldev)
 		mlx5_lag_add_devices(ldev);
 
 	if (shared_fdb)
-		mlx5_ldev_for_each(i, 0, ldev)
-			if (!(mlx5_lag_pf(ldev, i)->dev->priv.flags & MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV))
-				mlx5_eswitch_reload_ib_reps(mlx5_lag_pf(ldev, i)->dev->priv.eswitch);
+		mlx5_lag_reload_ib_reps(ldev, MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV,
+					true);
 }
 
 bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev)
@@ -1388,10 +1408,8 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 		if (err) {
 			if (shared_fdb || roce_lag)
 				mlx5_lag_add_devices(ldev);
-			if (shared_fdb) {
-				mlx5_ldev_for_each(i, 0, ldev)
-					mlx5_eswitch_reload_ib_reps(mlx5_lag_pf(ldev, i)->dev->priv.eswitch);
-			}
+			if (shared_fdb)
+				mlx5_lag_reload_ib_reps(ldev, 0, true);
 
 			return;
 		}
@@ -1409,24 +1427,15 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 					mlx5_nic_vport_enable_roce(dev);
 			}
 		} else if (shared_fdb) {
-			int i;
-
 			dev0->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
 			mlx5_rescan_drivers_locked(dev0);
-
-			mlx5_ldev_for_each(i, 0, ldev) {
-				err = mlx5_eswitch_reload_ib_reps(mlx5_lag_pf(ldev, i)->dev->priv.eswitch);
-				if (err)
-					break;
-			}
-
+			err = mlx5_lag_reload_ib_reps(ldev, 0, false);
 			if (err) {
 				dev0->priv.flags |= MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
 				mlx5_rescan_drivers_locked(dev0);
 				mlx5_deactivate_lag(ldev);
 				mlx5_lag_add_devices(ldev);
-				mlx5_ldev_for_each(i, 0, ldev)
-					mlx5_eswitch_reload_ib_reps(mlx5_lag_pf(ldev, i)->dev->priv.eswitch);
+				mlx5_lag_reload_ib_reps(ldev, 0, true);
 				mlx5_core_err(dev0, "Failed to enable lag\n");
 				return;
 			}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
index 6c911374f409..daca8ebd5256 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
@@ -199,4 +199,6 @@ int mlx5_get_next_ldev_func(struct mlx5_lag *ldev, int start_idx);
 int mlx5_lag_get_dev_index_by_seq(struct mlx5_lag *ldev, int seq);
 int mlx5_lag_num_devs(struct mlx5_lag *ldev);
 int mlx5_lag_num_netdevs(struct mlx5_lag *ldev);
+int mlx5_lag_reload_ib_reps(struct mlx5_lag *ldev, u32 flags,
+			    bool cont_on_fail);
 #endif /* __MLX5_LAG_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
index 5eea12a6887a..edcd06f3be7a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
@@ -70,7 +70,6 @@ static int mlx5_lag_enable_mpesw(struct mlx5_lag *ldev)
 	int idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
 	struct mlx5_core_dev *dev0;
 	int err;
-	int i;
 
 	if (ldev->mode == MLX5_LAG_MODE_MPESW)
 		return 0;
@@ -103,11 +102,9 @@ static int mlx5_lag_enable_mpesw(struct mlx5_lag *ldev)
 
 	dev0->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
 	mlx5_rescan_drivers_locked(dev0);
-	mlx5_ldev_for_each(i, 0, ldev) {
-		err = mlx5_eswitch_reload_ib_reps(mlx5_lag_pf(ldev, i)->dev->priv.eswitch);
-		if (err)
-			goto err_rescan_drivers;
-	}
+	err = mlx5_lag_reload_ib_reps(ldev, 0, false);
+	if (err)
+		goto err_rescan_drivers;
 
 	mlx5_lag_set_vports_agg_speed(ldev);
 
@@ -119,8 +116,7 @@ static int mlx5_lag_enable_mpesw(struct mlx5_lag *ldev)
 	mlx5_deactivate_lag(ldev);
 err_add_devices:
 	mlx5_lag_add_devices(ldev);
-	mlx5_ldev_for_each(i, 0, ldev)
-		mlx5_eswitch_reload_ib_reps(mlx5_lag_pf(ldev, i)->dev->priv.eswitch);
+	mlx5_lag_reload_ib_reps(ldev, 0, true);
 	mlx5_mpesw_metadata_cleanup(ldev);
 	return err;
 }
-- 
2.44.0


