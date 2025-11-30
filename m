Return-Path: <linux-rdma+bounces-14837-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 369CEC94DC1
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Nov 2025 11:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A433A1E9C
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Nov 2025 10:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B3C2836B1;
	Sun, 30 Nov 2025 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jucbLuek"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4943927AC4C;
	Sun, 30 Nov 2025 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764498409; cv=fail; b=kljvt73wCIo2FpVWQbIRIA5MXro5KTS9Ftc6+p3UOhULUbpw+XlyDag0gO4ggPvpVzNZx/++7hzQ44SI5WyZySZsGqWh6sVwVcyhFKtTZ9vYr/AbLtX612FClRAMhfl4Am/IF50uZVX+oV05dRamfI9ou2PwBBd29Q56Qbjd0NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764498409; c=relaxed/simple;
	bh=zESVC20t89WZcrp+AW8vI3xNImt5hbnHgl6RU2/UV6k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZDEzs4o7ROnoB8DofnObwIn/1aoa5xFtP3wUS9qN4/SDhEHpmjlz47M/AZSYNITEYMmyhIc2vM6AF46zwxvfr+qv+TKhrjA8UxLUShBiGx3gSC16Ij8QEpInoibHjzWMujX8oJxjErj+Zy8C9wO13dKBbi2Xang457MIU2lfck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jucbLuek; arc=fail smtp.client-ip=52.101.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcgNsnbhWUkjfTzoDMoMQUOzwSLNiXpKSaGEFTJS7olPYVAdiwolwT6luzxgTtNyoGoQyWu4ASigioPfXLzH4TY4dqhtdc24MQS+6x+9G63bKfB4jKpKiGHOJ7nwOrwsihNQlU4yS8WGSmVWornaCeb2ep7eoQomQkrOAqVyUyjeuV6issN773URV24zVEX+XzppUD94/S8gnKt1ghFHh0sFYTAdfMUiEcdxTPyralNAbNpE6+f76LWAeSRp8JTigJnj6RT6ggt0hpJeBul0LGJIIguAJlB8T+LdTTFzJfTp6XqHzUx/jJBsWwKhq8g5Pl5X2zoIUDIdQjqfAQAcSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6OJEFa0iwYEeiKXXHnqLoNrOEt/DelwXd506Hsk/Dg=;
 b=N6owKx+lNDUmTyKC8OFp8vQNrzY6ZoF/onnnzfTAzBn9XFYXnypqHqcBsUdXwYNm6+Eq5V7UIqBX1dCQS5yNNOOcOkQIE+KEambj0boMHJ6nlIywbz58L075CDlAvB61IN0L54lEXLXDBqsKy0jz6fQmkEEfRqW8t/Qk97sBQlXxU/EvQDsdBxG/iPQmsZARL8ReuL1K6hOMdjSt5922swS3T9aomEslceLUSkOT/KbvrVhFWNlbeSTqlmo0cFdCLNjMvSkhotW9tkKL95eRMMUW8sJ/QqqseKppKLY/hHFG3Sw7j0Y45J4JvyqUYFDOXLIcVjQfwF0J/jsovnulWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6OJEFa0iwYEeiKXXHnqLoNrOEt/DelwXd506Hsk/Dg=;
 b=jucbLuek+ouEPrAp7AO16d/pcaAnDpBV1+a6fV26vBMHGwr8kbOAoraNtvj2iBqbupGE5al+29vRL16NVyzG620PF/g/cmYvgR6eZayXFuZwTCfY9dYPmXWYsWkhmIEK12h6gIOHDI2yi78qOpKb6c+kUunuM+Ej+LfmBVIB5CPZOY4EAFw18XApWMuBBieQWaXLEmhdAaUdBjWN4RqX71yXbbxelVl4c884xcZVuflxFPEWnelxgsu/IOfCldr9hlY2sgq6s9+pfttGrlxhw4UpcNjhE4cWYkMsUAdgFY8XhzeY3CRJ46XTmlZ5s+X5gxZ8Bjn2t0O3uuV6S5C9Vw==
Received: from CH2PR14CA0030.namprd14.prod.outlook.com (2603:10b6:610:60::40)
 by IA1PR12MB6531.namprd12.prod.outlook.com (2603:10b6:208:3a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:26:42 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::82) by CH2PR14CA0030.outlook.office365.com
 (2603:10b6:610:60::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Sun,
 30 Nov 2025 10:26:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Sun, 30 Nov 2025 10:26:42 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 30 Nov
 2025 02:26:28 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 30 Nov
 2025 02:26:27 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 30
 Nov 2025 02:26:23 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Danielle Costantino
	<dcostantino@meta.com>
Subject: [PATCH net-next 4/4] net/mlx5e: Use standard unit definitions for bandwidth conversion
Date: Sun, 30 Nov 2025 12:25:34 +0200
Message-ID: <1764498334-1327918-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1764498334-1327918-1-git-send-email-tariqt@nvidia.com>
References: <1764498334-1327918-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|IA1PR12MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: ba5c2fe5-fd71-4ec2-0332-08de2ffaf478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wz5zpLccxZ6vzuCo9qEHqzCMvQBT6XEdyv/PcZ7wmXsHgQr4SUCbuAMoorOt?=
 =?us-ascii?Q?ZFuYH+t2D6gxpur0xSKiVp76EK2T11Gi7nkL2mkSx2nhl500RUIeI11CaESC?=
 =?us-ascii?Q?WJZ5XrHmnB8rEPXc6mR3m+ibvF0AAHHQz/3b6NXvtVlzj5Xy9BvPPH3fCDPJ?=
 =?us-ascii?Q?j6X9mis3YkkYCQ1cTflt7pQTb2Mfdv3V0UKwPoZCOCROJHYu0+sQkmNp3Nyx?=
 =?us-ascii?Q?ewNo3KoLXJIhfKibtfmBD1TeZeQOMIeOoUijYZRx+Uq8V1GvtBNCYDd5k3ZT?=
 =?us-ascii?Q?gxRm8w2/aWrffXpiF5L+8hPrbBeadB7FUsYwEB3efLR5NL3eBaqquD7TmFHu?=
 =?us-ascii?Q?aP/bktHg/no35PIF3veNATSfoU7vT4l1+lGPN8cPn1jQRjoJxGtZiT8lSYQ7?=
 =?us-ascii?Q?WeEaHqDofCMJtOukOzgpbOcz4IfLftWQRXQrLVDaUCMm2Ma0OzLC/EXtTerb?=
 =?us-ascii?Q?zE/Bdq0UfykzFrXAAI5DA35oOnTFna4h72hdgUT+ENlg/l4WP/t6+VikdQUn?=
 =?us-ascii?Q?uesZ0Zqm4TBqm/JPxPEDYoHZrp2+zr3y0HmVJPONDQ9GjCkTwwekXhBsLMSH?=
 =?us-ascii?Q?15NCuV1T81GW9ezzNbh7Wm4P+LBkVscXn49vh73piyte6uusueJuvyXCR2RI?=
 =?us-ascii?Q?9+/PANnJyYDz5ONbyu+hHBfOm52gN5G9AXskgCRqZx9HHHXcJbyfSOqMxVGb?=
 =?us-ascii?Q?FK7nSLBS/m1g76JFDETTG15nA/nW/5Rl+iZ23l8dBZyCtzwwJVtEm4VXfPX7?=
 =?us-ascii?Q?g3Qank/62TOvxqCV0bcVprGWo68/r3T0PUkpIHi1KttHwSVyQUKUObN+yN6O?=
 =?us-ascii?Q?u4J0y+i/bJP6DV5ZJqv9EOyXWXKoa/L+LX20kj5teHrk7A1Fs6hg9FIt42ER?=
 =?us-ascii?Q?b48sLXgYiLaBvTtSYCRs8IL87VAS/dGEQizyfQ5cv6ukvg3YgMzYJYmh2xP3?=
 =?us-ascii?Q?RPQcP5g9bRKzCq0P3wUl2iECBeUg5txnLfiuX5mIKUm5XckKVj1zGkFoPiTl?=
 =?us-ascii?Q?h2Yzx83vamB3uYO8O3aNASRMubrBvW4nIn9XNxmymvR4pPurmNTFA6ydAMrW?=
 =?us-ascii?Q?CeKMO7tBfIj2I22RIJspAHrEtSKTtRhc4lytb8hnGaFeQm5IuCt9PzsI0OAi?=
 =?us-ascii?Q?1QCDKSMCH/FYA6X9a/Js+Fzs4JR5lp8gPJRU1c6KZslzCzb8pWXqpsUrgccC?=
 =?us-ascii?Q?DwZwDGJO6kgC2UauVlyrYji1zz3SN5tLLNC6jH5/ZsHNPLyAwoVgravsQ/QV?=
 =?us-ascii?Q?HGlfL3V0UNFhnMItSflcpmqhyNoxrv6Ea6eaiUzxJxRIEiNvp0CFI98sbNru?=
 =?us-ascii?Q?YLgrN41t5mwxf9lpOga0fjEgZXV9yJxq0jWWg7ruaNPzouvkrAS6Nguzv7oD?=
 =?us-ascii?Q?XDJ4L0drBid7E5Mh0gOO0ijiHkoPAqaRsOV5RTgQ9LZk9NMOIhdH/oz0u7Xe?=
 =?us-ascii?Q?wrerJKzo+cgworjaKmit6fQocVYkl7z62WmvZUMbOnhALFsGV05qet6Q4bzH?=
 =?us-ascii?Q?AC6xfYXAcin5w6R/5AcH9MKhyQ6IQkXyeAGRDaygW7SUFFbZrLbgCoYDCImy?=
 =?us-ascii?Q?saezr0jpZS9+BQ1vldc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:26:42.1367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5c2fe5-fd71-4ec2-0332-08de2ffaf478
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6531

From: Gal Pressman <gal@nvidia.com>

MLX5E_100MB and MLX5E_1GB defines are confusing, MLX5E_100MB is not
equal to 100 * MEGA, and MLX5E_1GB is not equal to one GIGA, as they
hide the Kbps rate conversion required for ieee_maxrate.

Replace hardcoded bandwidth conversion values with standard unit
definitions from linux/units.h. Rename MLX5E_100MB/MLX5E_1GB to
MLX5E_100MB_TO_KB/MLX5E_1GB_TO_KB to clarify these are conversion
factors to Kbps, not absolute bandwidth values.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_dcbnl.c  | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
index 79f9d43b09b3..fddf7c207f8e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
@@ -31,14 +31,15 @@
  */
 #include <linux/device.h>
 #include <linux/netdevice.h>
+#include <linux/units.h>
 #include "en.h"
 #include "en/port.h"
 #include "en/port_buffer.h"
 
 #define MLX5E_MAX_BW_ALLOC 100 /* Max percentage of BW allocation */
 
-#define MLX5E_100MB (100000)
-#define MLX5E_1GB   (1000000)
+#define MLX5E_100MB_TO_KB (100 * MEGA / KILO)
+#define MLX5E_1GB_TO_KB   (GIGA / KILO)
 
 #define MLX5E_CEE_STATE_UP    1
 #define MLX5E_CEE_STATE_DOWN  0
@@ -572,10 +573,10 @@ static int mlx5e_dcbnl_ieee_getmaxrate(struct net_device *netdev,
 	for (i = 0; i <= mlx5_max_tc(mdev); i++) {
 		switch (max_bw_unit[i]) {
 		case MLX5_100_MBPS_UNIT:
-			maxrate->tc_maxrate[i] = max_bw_value[i] * MLX5E_100MB;
+			maxrate->tc_maxrate[i] = max_bw_value[i] * MLX5E_100MB_TO_KB;
 			break;
 		case MLX5_GBPS_UNIT:
-			maxrate->tc_maxrate[i] = max_bw_value[i] * MLX5E_1GB;
+			maxrate->tc_maxrate[i] = max_bw_value[i] * MLX5E_1GB_TO_KB;
 			break;
 		case MLX5_BW_NO_LIMIT:
 			break;
@@ -614,8 +615,8 @@ static int mlx5e_dcbnl_ieee_setmaxrate(struct net_device *netdev,
 
 	memset(max_bw_value, 0, sizeof(max_bw_value));
 	memset(max_bw_unit, 0, sizeof(max_bw_unit));
-	upper_limit_100mbps = U8_MAX * MLX5E_100MB;
-	upper_limit_gbps = U8_MAX * MLX5E_1GB;
+	upper_limit_100mbps = U8_MAX * MLX5E_100MB_TO_KB;
+	upper_limit_gbps = U8_MAX * MLX5E_1GB_TO_KB;
 
 	for (i = 0; i <= mlx5_max_tc(mdev); i++) {
 		if (!maxrate->tc_maxrate[i]) {
@@ -624,12 +625,12 @@ static int mlx5e_dcbnl_ieee_setmaxrate(struct net_device *netdev,
 		}
 		if (maxrate->tc_maxrate[i] <= upper_limit_100mbps) {
 			max_bw_value[i] = div_u64(maxrate->tc_maxrate[i],
-						  MLX5E_100MB);
+						  MLX5E_100MB_TO_KB);
 			max_bw_value[i] = max_bw_value[i] ? max_bw_value[i] : 1;
 			max_bw_unit[i]  = MLX5_100_MBPS_UNIT;
 		} else if (maxrate->tc_maxrate[i] <= upper_limit_gbps) {
 			max_bw_value[i] = div_u64(maxrate->tc_maxrate[i],
-						  MLX5E_1GB);
+						  MLX5E_1GB_TO_KB);
 			max_bw_unit[i]  = MLX5_GBPS_UNIT;
 		} else {
 			netdev_err(netdev,
-- 
2.31.1


