Return-Path: <linux-rdma+bounces-14241-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B53BC317DC
	for <lists+linux-rdma@lfdr.de>; Tue, 04 Nov 2025 15:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD0C4631C0
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Nov 2025 14:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD6432E741;
	Tue,  4 Nov 2025 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d7cwP4lv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010032.outbound.protection.outlook.com [40.93.198.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC0B2FBDF9;
	Tue,  4 Nov 2025 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265802; cv=fail; b=SUNeWqvqwIiO5rbwfVVMT32e38evZIhpAJTJSXdWrL4hmLqhMgamL76I+inVe09KWos7QebDQxGSfWBa997rYYwyrVStrHH5hAWoRcQvsAzzkNh/Y8+NZMJjHBSOj5vEmGNfpExcFwvU5xGB1/y8pyXe5vUK2il5QD5s9busrfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265802; c=relaxed/simple;
	bh=Tb4FnQ3HozZWaGop5cNXRYejZ8Hr3R+KfJO0Ops3Z00=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NhHynf0ia7ANmnfdKyhhRlp+cKCsvXFcrezqiC8yqrKiJBJIJD7FognSL8tUpL0bq7kI0MXU50yJot6cpbSE5n4jyN9X5uV1Y8g8zGLG6DT7XPCKnpqcfOKXT2VFsqVPoDEGWJTYZ82dNibWPwNeaf0N7ho6HMvUK41T+r+ITyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d7cwP4lv; arc=fail smtp.client-ip=40.93.198.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0e9byVV4ARVHudV16Q6yu7/JpnRwRi2urewXTkARYjgAqXweUIQcG2/glHIALyaDEXljAIBgxOPDoNxhxmUPyqgWDrZ/u9Aiaapb+eSt1hYtbe9wr7qQ4ycYL+85aMyyn1+tTHDtvDqnfyEnBQbJKNp6NSG6PDHIdxLZ4AaYcw1GciQdIUZ//RESYjrdoTqQzS01ylHmCG+oahiHAMFwykGmMOcLEtniN0nQ5QheG6FW4fJXBo6WZgexLS387ZNLPRaZFiwl0sjRjSiXarJup8LQU+qJhc2fBq5t0Rm01SdVmU1MumLIy2CRTkZig2zeqRUYOzgDKHR7PPcWgKw+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTMyKOJot+f9ChWHefXnbJ2yyEOZmYrPfbOrp90jPps=;
 b=WUn03SQ3A6RB60iVC0Z5uaTkb4lkJQX1ohgZp5c769mq1SQtoDOtp7XYcpaGEXD5yoxnFapfk9koFp0J/sXhk6/bgj4UXRzQjYm0xTH6hQWA1brnR2lE1gevA513/pgcRnZm0aRZZ6gsmVcRiByO6LGoX/xU8orstEmCoUJ6WAprZOhRK5CxrBzYkTtnNMw8FR5Gx2jeOfRlS8kq16MYMilmqFxiinOhcU1TfYKdvwocWUKNFA9PPVsltBBFxsCxy+ZVEis9LxJOX/a5b46S0zM4mAp7PtrifevYxyxVZoJHMhQB3/8RF8x6ZWl0l+mJELfk01gZSbPCHiFdEVfYsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTMyKOJot+f9ChWHefXnbJ2yyEOZmYrPfbOrp90jPps=;
 b=d7cwP4lvLrMD5uOAg/cUJe8BTy/xx4MqFa8aVJNG95Xbg3U7TGQHMv9zejhkzjDdh7Cbd9TLTCvzok84kytC1xzyAe6yarbfbdvZZoma8wDyRfZOHOK0NcXaIE8aqXPKIdFMcebgIW7zy5VTMwnzJ186FyUFBZfFIQwXhBwnKhSHmCscDcaNZbarpX+GRc1CZ6vfMfnY6WB4okYEryAFf2gsZdkpPSzSX1C+jYbIvZzDUAhEu135e0su+zn8Y3pqvrTtifqisCVt+3dRjC6ZRhcUIpu9UfrdDy+ghjYy//FjVoeqw8F2qesZAeYgrcJHo/bx2F/z1mC6+STU24ItpA==
Received: from BN9PR03CA0328.namprd03.prod.outlook.com (2603:10b6:408:112::33)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 14:16:32 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:112:cafe::1c) by BN9PR03CA0328.outlook.office365.com
 (2603:10b6:408:112::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.15 via Frontend Transport; Tue,
 4 Nov 2025 14:16:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 14:16:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 06:16:12 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 06:16:11 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 4 Nov
 2025 06:16:07 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Alex Lazar
	<alazar@nvidia.com>
Subject: [PATCH net] net/mlx5e: Fix return value in case of module EEPROM read error
Date: Tue, 4 Nov 2025 16:15:36 +0200
Message-ID: <1762265736-1028868-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|CH2PR12MB4087:EE_
X-MS-Office365-Filtering-Correlation-Id: 1042cf18-39f1-49f7-8e2f-08de1bacc11f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?va+al8M2O+4N5tb29EpWpWrcNE18fbNDslW5oW4hloBnm4ltIyhljT0bOQOx?=
 =?us-ascii?Q?Q/kZ3Qn485XwBgoBGzKSu0BHpQorz+Fozjl89nv3GI+SvDK8PTrmneRO+/KL?=
 =?us-ascii?Q?fuYHrsBDTMo7jZyK6gvADruLfrGZqNi3rmXZdX0Gvw9cwYErTsMC1kDA4vMQ?=
 =?us-ascii?Q?JVpHoorPrxhowr6pOpB0pqblvoXJH1SqFSUMG6lbbbwAyBL2JQwic0zvAUoj?=
 =?us-ascii?Q?UTgOCQ5MzEMHULpAdxg9xPt3HvafSh5VVngf63yw0dxx7PwroEsYNPEjV1Ak?=
 =?us-ascii?Q?zzrAk59OLqtX9CYIiBX3Y5Z5UyhdmaoHoMf2CCkWvoY68/tLfll9tod5n46D?=
 =?us-ascii?Q?8FgOpl50jqw6cNfVequ0I1jMNlZxAD+ecEEIaijvUdnpHa4npSRcv/mF9sVW?=
 =?us-ascii?Q?teG1ZePJ6aPPmUa/qwrzKBk5xLJRcFGa+GnqwjV1v1AQsFk+SjE4JXSOhC2h?=
 =?us-ascii?Q?szydJWKJv+JnH4DgwTtX9uUD8cj9kWM/yc1LKAoDcZd+a2t6T2axGrIBPIvZ?=
 =?us-ascii?Q?BJQxEou1QDcKxpvfw9N2wJUMGtv4KedBNjNiqIDDCQQ1MVrngvKkGIdxnGx5?=
 =?us-ascii?Q?9+a+0dcFKfP/Q6IkePLIQ8TfqnsO7I3lmV7di1V5F2awzjcgbMTQoDDL3GDc?=
 =?us-ascii?Q?wKQFK5a1L+KkzrOOhghu+b2XGGeb/F9XMvyoiCuoSHNdqfzGylWKRgEIvJC3?=
 =?us-ascii?Q?0d9Un59t5razitqN+XGpZ45rOfEDKAQMvfdXPoLmANKASlcQB19+BpZRJW12?=
 =?us-ascii?Q?kIOUrpxUPp81OL9waCXiVni8NGMQPe1xi5nEei9BME8pcp3bcAxFUpB4QtCs?=
 =?us-ascii?Q?EIgYSE4kPLQEIViyRpncwQ6GDVk2z+NijWKPbqOwns0nzEHR7CsDwUE8waFz?=
 =?us-ascii?Q?L5EuABjhB4unEgBskc/s/8a1DzWXwft+gROWh6PDx7mqmmtsHtZTUcutsq4n?=
 =?us-ascii?Q?x2N5Yw4brUCEYJodLMNpRgGHXquDennbqttRIYGAlFylXOgZhwruz2OZDNhm?=
 =?us-ascii?Q?xs4gbhHFD+Srs1QGt9r+o60Wgh1tiPzFE///gFoYPVpLeQkPa2MKbXC9SpK5?=
 =?us-ascii?Q?htcA44hWq0OcwwKkbmLqgfh31mobXtG2H97DAhWEFEnaTXosiR+VDe0tL6Mi?=
 =?us-ascii?Q?TcK3SXLgdCVWqMNKt91dlyARjlU6b3LAgEiKNnMfReKKBdfkxb7cSKpr/afp?=
 =?us-ascii?Q?Z/QADh2pZHnm/1IL+bN4BkIr+a0XraVIKD+74RtqrScUfVHcjg6PDOUD1lgZ?=
 =?us-ascii?Q?n6C7fBtPnh+vuEQMpJOPti3bfnEGac2/+X0hBSY2Vs2roRcfEeVZE/nuzeMd?=
 =?us-ascii?Q?klsDEiVMAb1yojSYQwX/SfQ8sQF1IpxQLLBO9clAcE5yibIvOPufrI/bp4Jf?=
 =?us-ascii?Q?ylzCl54GCAPW33A7Px3mpd1PHDfK/pJfbFKq1PjrhGK9wKPNtR3CRXiS6nyJ?=
 =?us-ascii?Q?GdL+PApNZ9ms9jzfHU98xGZCB+QHQBI4XlLhHadCMBjyyph1IUObUGKvfyv6?=
 =?us-ascii?Q?XCjuzmez470MRTzV0l09PFkE3uZTRy/IvK1ujCZndx3+Xrk3EzR04pPhL8vq?=
 =?us-ascii?Q?p1Cs0bMqkEnYBVFaHpI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:16:31.9812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1042cf18-39f1-49f7-8e2f-08de1bacc11f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087

From: Gal Pressman <gal@nvidia.com>

mlx5e_get_module_eeprom_by_page() has weird error handling.

First, it is treating -EINVAL as a special case, but it is unclear why.

Second, it tries to fail "gracefully" by returning the number of bytes
read even in case of an error. This results in wrongly returning
success (0 return value) if the error occurs before any bytes were
read.

Simplify the error handling by returning an error when such occurs. This
also aligns with the error handling we have in mlx5e_get_module_eeprom()
for the old API.

This fixes the following case where the query fails, but userspace
ethtool wrongly treats it as success and dumps an output:

  # ethtool -m eth2
  netlink warning: mlx5_core: Query module eeprom by page failed, read 0 bytes, err -5
  netlink warning: mlx5_core: Query module eeprom by page failed, read 0 bytes, err -5
  Offset		Values
  ------		------
  0x0000:		00 00 00 00 05 00 04 00 00 00 00 00 05 00 05 00
  0x0010:		00 00 00 00 05 00 06 00 50 00 00 00 67 65 20 66
  0x0020:		61 69 6c 65 64 2c 20 72 65 61 64 20 30 20 62 79
  0x0030:		74 65 73 2c 20 65 72 72 20 2d 35 00 14 00 03 00
  0x0040:		08 00 01 00 03 00 00 00 08 00 02 00 1a 00 00 00
  0x0050:		14 00 04 00 08 00 01 00 04 00 00 00 08 00 02 00
  0x0060:		0e 00 00 00 14 00 05 00 08 00 01 00 05 00 00 00
  0x0070:		08 00 02 00 1a 00 00 00 14 00 06 00 08 00 01 00

Fixes: e109d2b204da ("net/mlx5: Implement get_module_eeprom_by_page()")
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Alex Lazar <alazar@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 53e5ae252eac..893e1380a7c9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -2125,14 +2125,12 @@ static int mlx5e_get_module_eeprom_by_page(struct net_device *netdev,
 		if (!size_read)
 			return i;
 
-		if (size_read == -EINVAL)
-			return -EINVAL;
 		if (size_read < 0) {
 			NL_SET_ERR_MSG_FMT_MOD(
 				extack,
 				"Query module eeprom by page failed, read %u bytes, err %d",
 				i, size_read);
-			return i;
+			return size_read;
 		}
 
 		i += size_read;

base-commit: e120f46768d98151ece8756ebd688b0e43dc8b29
-- 
2.31.1


