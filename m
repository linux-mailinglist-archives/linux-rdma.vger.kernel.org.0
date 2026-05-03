Return-Path: <linux-rdma+bounces-19884-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IopNQCw92k1lAIAu9opvQ
	(envelope-from <linux-rdma+bounces-19884-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 22:28:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 815F04B74AA
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 22:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E15C5301B708
	for <lists+linux-rdma@lfdr.de>; Sun,  3 May 2026 20:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CA337474E;
	Sun,  3 May 2026 20:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="El20/30P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013066.outbound.protection.outlook.com [40.93.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD76375AB1;
	Sun,  3 May 2026 20:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777840083; cv=fail; b=dSJa4d0FkRYsMJN+9SDLXKPpNEvIEM/6f7X8/9tgHKDMSXR/mkKNS6Yk26ewbA/D9sczN47wpNoPy7HQ+LUySct6jSSt4QrSi+60WF57QEb7TGFvRNT1XK+/TofeQk3Sv8xH/fF2fLcSGjVoCScwB78AxpfFt3ko9e7PGMzKfAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777840083; c=relaxed/simple;
	bh=s7aNpT9bMW9weLUqePxTJKSahpTeFJSw/KNKxI0kj10=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ERyqWVt/dVJv+wUcdqKkZUKJqZ3lGAg0NHA3yncCeNDbPo/WaGjwfeUgkD9atUMr3rK3RHE1DdM9X5W6XLw79vEAHoxzAPeJK4k8jUIkCDGAMwtS/dV73Ju487Eoc5mo4pACRzQ86FToubwTetULnHibXB9PuQYgS4Ou0Eoj998=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=El20/30P; arc=fail smtp.client-ip=40.93.201.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzrGAYpyp8s9X61YWdlfTJJufZNc8dxaJx6oimemTJOD3rLqd03x/iW8A54n2sl544dDCDjLmQ5eYnNXc3LHEOGUzqi9+kXcj9mf9VOgZ60iD3McG/yIGk8hIV/p5xjYqI2qGc94k53I7M09ar55akCqCvxvnTqfCZAEJ9ulvPZr2KhEx4GugxiPdz5n/Dfxx5KbRW3tooFsP8WqmXAjvSZZPagAn+kfdyehC5Lp4/7Wuq3t+v1pyoAtIxT0xo1J5cn9+BlsUrc3EvUc0BH7iuIi1pmXNFQ/u5S3xdb+u/GOv12EpNwVmpY8W2MxluPP3lG9uXAfBHabURQQhLYywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtwS2qPSkT4azGUsJ18Dt8Elcdwg8WqCpZ8VculATGA=;
 b=wvnXiIgKuHts4HDrO9VheRb9e7Qka8hTtYacKKdn3LLNEzSEJGStNOr2mUnXjsyyTOgZM2p93gSdKiiPz8KtVHWds2GImlKu/Bg//GEtsoGhtqN0yDNB6d6M47+psSA80t1OzZhxepCxRp74lM6dCLnaPuuhspHv8OcJQ+uFd/nhks0S59VSub8EldD/3o9s3ctVGnIhxQh7cdV3PNGSRn7/8xIXV8K3QGDzURjMDLFk9g0fUpiL55ry/Zw4Unz2/KlZLw8ySwlHqqJ68SpqDoKUPochrlaz7sj0DapACGQtaF9c9sFdOsQCSdgsY1AdzNa+5obfZTgswzwPtVRRyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtwS2qPSkT4azGUsJ18Dt8Elcdwg8WqCpZ8VculATGA=;
 b=El20/30P6ATfZyhaFxC4BiuAxytuqoTXBPLOe0xfqqzjJjHOIFkf+5sGeh3xDYPTk21mz+LOkg4Qt17FIqvZCBd+Dxzdaqt6QsZoIcuh2i5KjdikiXqVJBpU8INbRcQO//OKgacZ7uJagz9UdqQthwqfsKdx5Wg/ybP7lPazVWMiUD6G9yB4Uh97xJTAvJOchE4nbmo0uoZ/Y7aTRd6MGa5dRrU+5gnOYfIQmGyXiRSTB8Suj7dEWbrl5KJirK2eUrP1VYkNXog55BzDoVCK8CJpZCDZTc2VD9kcM3FVWQA9wFqtkW2XPsiYZwgLv64e158sqoIyVYnzHGKygj0YSg==
Received: from BN9PR03CA0298.namprd03.prod.outlook.com (2603:10b6:408:f5::33)
 by DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.25; Sun, 3 May 2026 20:27:55 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:f5:cafe::17) by BN9PR03CA0298.outlook.office365.com
 (2603:10b6:408:f5::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Sun,
 3 May 2026 20:27:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Sun, 3 May 2026 20:27:55 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 3 May
 2026 13:27:54 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 3 May 2026 13:27:53 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 3 May 2026 13:27:47 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shay Drory <shayd@nvidia.com>, Or Har-Toov
	<ohartoov@nvidia.com>, Edward Srouji <edwards@nvidia.com>, Simon Horman
	<horms@kernel.org>, Maher Sanalla <msanalla@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, Kees Cook
	<kees@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next V3 1/7] net/mlx5: Lag: refactor representor reload handling
Date: Sun, 3 May 2026 23:27:20 +0300
Message-ID: <20260503202726.266415-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260503202726.266415-1-tariqt@nvidia.com>
References: <20260503202726.266415-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|DM4PR12MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: 808bab6b-7434-44de-86e7-08dea9527550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	jRsXsZ3gLc9glgX9YuB6WZCxaA0ERgjujAtcL1TNVnZANw7NaAV2a92U9xOCONrxlIj9cmcieet7rbk2p02WfT634CWRnjNX+zWl0FbpjXI8hqtmI6bSMU0wvCtvmPyWA9w5pFdLFMY0kocNk/Ym7xlX/9SLwSvax8999B7l8Xeqmsj3zLkyxbIhq0CegObH3MLSWuE4i+Xp/2z3TjggCW8dmI2V95zcSlUzI+nb1y5rZoEJpvzpZK1i9EIF4G5Xj824ILsgr7ex7t6lSql91fB73LH5R+hzgPEqa4B2gPv807qvWVtq7QFdwWXzHmxBT1f4U32GrsK64S6reTV4P6A7lPGbwHrpqcqYemLLa6+DB2Y/Aj2PDF4slN7C+NrrmvNuT2D+KATqH8oTSuYmTAlrqhbbxkN6yoiccDALSNZAhB1EfmhTlfrGKVbhZONi84QQL4xeJfvcEf+DL3bf6sHC1r2N+biTOkVMLiY6mrhBpGVcz3Srv1MBahUDlQ3mobq65Xj+kFi4qjFrXvk3Jx5+K/F9FWkixBaNlO43FYpTB6Uxd9yxVEjaMULxPmrCmZh6yKeGdIwMgVN40guKmT4UzYHx5u2NWAAPHE80h5kZwgj9h0e5AvaIFDVqcb91bQj44dr295ym+TO5WwBEoQRNjIn/9A56mPafDbtr0thq2u5tn4WGDy9Vo86xmNlLPY5/LxGsCFqPvXRC3JDU9JdM0Q7McoD7SVdkPqEOaS8=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WbRGFYp/aLIBzjW2ZwJH7QyCaHOV/Jndc0hI9ePd6+vD0zhOJKkJchLlUzORFd7iBaj2DrBYUDbDGamWajeBLH+R6/F6221oYs66qOwt6kf2m0ppQuIqQ8Woj/JS/1XAXg1BpUkDvBM+au6DfQCft6PXoBU7KiCxQcvldVL5CH8yEk2tktAwLpXW7fpCRjrTAueRsi8K4IJvM99+ZlNDBmVACcp3mppSH3KsHXAi+IBTOpc7hQIN+Qn+d2ZnoxZMI5u7267jefxH/QBOmKry/w/pdkNew5XtnoWUOCG1I0mmnAudSmHOcujQNDpL9228bG5MyJ8rg2AIdQUWvW5vwRTQWwCtDrWKb2XH7KIggBPWzKBIWo3haqE5pqaWFxxs+oo14b7CTEszDbp5SQXGgf5JAgAfQH0XEp8bOjbtNIPv3Ip1xGTQS8Y2HTx4acVb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 20:27:55.1783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 808bab6b-7434-44de-86e7-08dea9527550
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6373
X-Rspamd-Queue-Id: 815F04B74AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19884-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Mark Bloch <mbloch@nvidia.com>

Representor reload during LAG/MPESW transitions has to be repeated in
several flows, and each open-coded loop was easy to get out of sync
when adding new flags or tweaking error handling. Move the sequencing
into a single helper so that all call sites share the same ordering
and checks.

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


