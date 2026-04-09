Return-Path: <linux-rdma+bounces-19151-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKQVEV+V12mGPwgAu9opvQ
	(envelope-from <linux-rdma+bounces-19151-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 14:02:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B120A3CA04C
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 14:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B01330A9515
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 11:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2D33C2787;
	Thu,  9 Apr 2026 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XF3kvLoC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012016.outbound.protection.outlook.com [52.101.48.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F328A3C4566;
	Thu,  9 Apr 2026 11:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775735816; cv=fail; b=keOsffCUex8oNCmUc+WvpWoQIBQz2SwelEFd6J9OnLtxFI8GvOuB7GYOZ9p4r4XnFYGKiGGAkOTEE2ql4nNUUxaD7/6LgecWw4+7ENvK585eVBYm5OcfBm/Qrzgbe3Eu6zUJFeHsGshOebfa9yUxWAUcW3nxZYTEOefgwj0p8Zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775735816; c=relaxed/simple;
	bh=Ug+oWjclY+uqPk3CMjalGiH+MhONpShFjctgqjI+GqI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=db9WfkZaQ3wCe037lwezjJkkgbZzl4zguCKh49omqJB3WdCXjgtaYY6djVMx6Y1FxQq3dfe1O0NtHhMgC1Y2vt9Kf4sjuMU9ycQ2tU1dgSMaDe3otWaRMW9RWFcUZ2ZTecAyIvVsXwxMUF/ghhgQPBjcEKMD0V7bg9xkgEGlynw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XF3kvLoC; arc=fail smtp.client-ip=52.101.48.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVuI7j/zu7Pet7zlQXvs6Z7YD0NaxUwy5rBqGrmUZ+QQshLcQqx1Ctcr6jZQHHPVuW2cgwP8SKW222BEouqyu8shgVxLzET+OBoGrrcx/HgXkdWtj7HuwxFoQzx+CkEDiElKKKkNi3eV4RwBn2ISN6ubYI9oe0cZfl3zfJMVUHaaz7UlL+WjXACEMl4V+Ebd2IXHHOagaXATfHVNoZVxr2YB6pfgCdA32UEEdT/mCTOlRcHWO7iiZFcSk9Hf+3bekJrgyVakml2kKF5KEJrmnd4rrFH8uwBwT49b3fFYb4zzMRJWuzsPMUSREZ+ZfKymcTpj6AmquDRUaaUnQWoccg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiPMS/WwQIrLn5fbfkZOvZ8Ivb7diUnkNCUo+NpNRgc=;
 b=PsJLSIx+WqVZDQDMA0fSg7Sdp4k7hjqyQzEHz9DaBRRqL+G0staYfq6bLJPTEmfE6M4r/uGlpmPZ/tnwyY1GKe07DVnFS1o+YmfoHdXfb8n0EK/NEPf6APTeTw1+ttVlgDAFwX9xBx3wYImFnmZ0/1XsCy8aps2tal8u1KGYS3r2JOXEVhxLF9hit0RMl7CcrzRrxlb+V25PbCEBIi4zG3aSvazGxRODMN8AKq9t6s2mIRXB8R+tr8QEYdopynNgIRtg+LTrsPRnqbFJSo4ECs3LWb0tXivZ79dku0ErnT7h1UFAAgXvj87AComxLgTX1g0bUXmnAoK33CqHP5eBqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiPMS/WwQIrLn5fbfkZOvZ8Ivb7diUnkNCUo+NpNRgc=;
 b=XF3kvLoCRMUIyY3dU3icSo8DQEkumZcvBiIRI6CjqQewvQBr8+iwhq0DrIGBdnDEwAGytCJkoHiVeV0qqmzgMb/1YY9RjsLtPNWHeHuMIrLSMF/k3NEJEdM7mQzvXHsCGfNG9UzB6TeUEJDeqrH9dQo5+9COxMWMLTuADEfuo38aEj05ybeTu6JXq7MXR9Z5eGUPRC2WDrByDpQYOWiW9byLbhgW7nDGNenglMYxuyoReSFaboH2NGmu5APvo3qCHFAdjQORgOFf9Xiwvv9Ax4Lm/9Pg2deNsga2nLDo3fIHkmua8OAsDIIwKwcRUFcf5F1j0MxVJGclw3adnnvLKA==
Received: from CH5P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::6)
 by SA0PR12MB4495.namprd12.prod.outlook.com (2603:10b6:806:70::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 11:56:49 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::4) by CH5P223CA0019.outlook.office365.com
 (2603:10b6:610:1f3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.40 via Frontend Transport; Thu,
 9 Apr 2026 11:56:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 11:56:49 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 04:56:35 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 9 Apr 2026 04:56:34 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Apr 2026 04:56:28 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Kees Cook
	<kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, Gerd Bayer
	<gbayer@linux.ibm.com>, Parav Pandit <parav@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next 1/7] net/mlx5: Lag: refactor representor reload handling
Date: Thu, 9 Apr 2026 14:55:44 +0300
Message-ID: <20260409115550.156419-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260409115550.156419-1-tariqt@nvidia.com>
References: <20260409115550.156419-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|SA0PR12MB4495:EE_
X-MS-Office365-Filtering-Correlation-Id: 6880a264-082b-4a17-8e2a-08de962f1500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	k0oUwvdA9AUzoQT+Rj4J64LT4jB2XIjs7MXcVrnMhBZNRwcjKnDw7XCrAcQVYDvIP2wuHs8CtDoa1b4pJvMvY8bBxSqQvqqoBpnY+6cOI7gb7bglTDxZrOOFywMbNpU63s6RGBhp4zdEnIOa6nFshDrEKNujC9Fl7n6c+FULAOYV3bC/jFWgtc1IR8tsO7xanpNt3zsnZP9GMSlzJ9m1h4oN/8+1jvYLgOHMYdl9e6oZH4+uw/lKntHU3sBvCgwQ0mbgVIW3WEBUcHL+d4DMPyKrmyxDShwpndt8G8IpccG3dRLjVXsU+s7mxh4GYTWyP0e4oyQ18rhzJMtfFpM0Ny0LSd321PikO27zAPNLjlweynzTxbqDXwZ/HEMyt4FqRFlVVlGBSCQUvyuIZKfxI8xmcFxyu/zbr2aQKIK+AA9/Dgqzz3x7mzcgFl6DpLyF6FCN9H0ODa66l2bHfA9UAlbJlpzDqZONfEcDPxT96GHavt0evp8kqsprkuRH4nsU/GVWh75t1vr54EYhp/piGJtflEsZa9GpTtxJHs646olDEYh2xw1N/F95rZ8GPXfDpL/KhXWCkVaSKtlAoBGJYeFKs/mlViSEd/fd1VxQR/pztGSZyLzbCk+KVfmw3wX6ZFXNWaqCgc7+FmcgRq4YRR+2k5Yt2Ja2/cjVPct5ISsO1X/4bqvy/3exZUtORTPx3zm885XA/4HjP8hGZuHgRpk7rJGShNGSnDUpxBqbK5u7acMZphcUezLwcyu33piw428Izj1Iuq8J5kE2VGHqOQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JJmaBHU0WlKX8YnocdfDAHWSzNTFlrU+vVKDZ5pkkLZqW70ippFTfmzr5ukTAOIecMGiYDRRZIVq23aQ4YLvRlEP99y9uOi8wSs2+xLn3NCT2q1tOrC7qYYAaFuShMr16dZxGZTDDUFLrA6CqutRAtYvSlLoawraNLAEF6HuOIZOq6hKGc7c49TAU99urG+cSI7RNDzkoumxSNHlBboRScXw69qM06uBwJ+WQnnzx/8G5GYmcqF1+miNAv+qflfqF7zh1t2UroaP7rNStZ+r43OHlSME9h8eTRw/XlBciTQAj3bTfCTm22d/ihEy6IW269/Ep0glNbQ/l4KdQdjssoFqU0PDJxVBnrA6SgUf9pjK9faVsr+i9wy29AZowR5D9tE6s+mrKeYf2gu7mUGUw7RXjP8jc2QTRduhnOj48a8rVIgAzs/s42CyPtmtxXoL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 11:56:49.1767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6880a264-082b-4a17-8e2a-08de962f1500
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4495
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-19151-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B120A3CA04C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 44 +++++++++++--------
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |  1 +
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c   | 12 ++---
 3 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 449e4bd86c06..c402a8463081 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -1093,6 +1093,27 @@ void mlx5_lag_remove_devices(struct mlx5_lag *ldev)
 	}
 }
 
+int mlx5_lag_reload_ib_reps(struct mlx5_lag *ldev, u32 flags)
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
+			if (ret)
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
@@ -1130,9 +1151,7 @@ void mlx5_disable_lag(struct mlx5_lag *ldev)
 		mlx5_lag_add_devices(ldev);
 
 	if (shared_fdb)
-		mlx5_ldev_for_each(i, 0, ldev)
-			if (!(mlx5_lag_pf(ldev, i)->dev->priv.flags & MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV))
-				mlx5_eswitch_reload_ib_reps(mlx5_lag_pf(ldev, i)->dev->priv.eswitch);
+		mlx5_lag_reload_ib_reps(ldev, MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV);
 }
 
 bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev)
@@ -1388,10 +1407,8 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 		if (err) {
 			if (shared_fdb || roce_lag)
 				mlx5_lag_add_devices(ldev);
-			if (shared_fdb) {
-				mlx5_ldev_for_each(i, 0, ldev)
-					mlx5_eswitch_reload_ib_reps(mlx5_lag_pf(ldev, i)->dev->priv.eswitch);
-			}
+			if (shared_fdb)
+				mlx5_lag_reload_ib_reps(ldev, 0);
 
 			return;
 		}
@@ -1409,24 +1426,15 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
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
+			err = mlx5_lag_reload_ib_reps(ldev, 0);
 			if (err) {
 				dev0->priv.flags |= MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
 				mlx5_rescan_drivers_locked(dev0);
 				mlx5_deactivate_lag(ldev);
 				mlx5_lag_add_devices(ldev);
-				mlx5_ldev_for_each(i, 0, ldev)
-					mlx5_eswitch_reload_ib_reps(mlx5_lag_pf(ldev, i)->dev->priv.eswitch);
+				mlx5_lag_reload_ib_reps(ldev, 0);
 				mlx5_core_err(dev0, "Failed to enable lag\n");
 				return;
 			}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
index 6c911374f409..db561e306fc7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
@@ -199,4 +199,5 @@ int mlx5_get_next_ldev_func(struct mlx5_lag *ldev, int start_idx);
 int mlx5_lag_get_dev_index_by_seq(struct mlx5_lag *ldev, int seq);
 int mlx5_lag_num_devs(struct mlx5_lag *ldev);
 int mlx5_lag_num_netdevs(struct mlx5_lag *ldev);
+int mlx5_lag_reload_ib_reps(struct mlx5_lag *ldev, u32 flags);
 #endif /* __MLX5_LAG_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
index 5eea12a6887a..4d68e3092a56 100644
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
+	err = mlx5_lag_reload_ib_reps(ldev, 0);
+	if (err)
+		goto err_rescan_drivers;
 
 	mlx5_lag_set_vports_agg_speed(ldev);
 
@@ -119,8 +116,7 @@ static int mlx5_lag_enable_mpesw(struct mlx5_lag *ldev)
 	mlx5_deactivate_lag(ldev);
 err_add_devices:
 	mlx5_lag_add_devices(ldev);
-	mlx5_ldev_for_each(i, 0, ldev)
-		mlx5_eswitch_reload_ib_reps(mlx5_lag_pf(ldev, i)->dev->priv.eswitch);
+	mlx5_lag_reload_ib_reps(ldev, 0);
 	mlx5_mpesw_metadata_cleanup(ldev);
 	return err;
 }
-- 
2.44.0


