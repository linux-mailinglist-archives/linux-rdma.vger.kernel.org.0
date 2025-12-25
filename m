Return-Path: <linux-rdma+bounces-15220-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5373ECDDD2E
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Dec 2025 14:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F533305D669
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Dec 2025 13:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F4831BC8B;
	Thu, 25 Dec 2025 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TnE6Dw1s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012062.outbound.protection.outlook.com [40.93.195.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74B53203AB;
	Thu, 25 Dec 2025 13:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766669272; cv=fail; b=ZpT9bteK46CQ/VSs/4tq2bK3lYGPc2TTI4rihzfZ5ZqiL2BRZ0fpFnEBywZ7EhAHOKqRiz4Rc/sKT/zN+DyRsOMknjoIJxHt5qBRociqePxaBtMc/T73asLoxeDwlSDPnSKfaho1ercdalbtGZGk4W0l5E+m4FkQBKABR2CT/SE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766669272; c=relaxed/simple;
	bh=9Y6m3OcioX1jiPTBEU7CkYIu2sA2XLX4khZO8yndbVA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RQTLv7E+F0Lbr8DnwI/ZjhK02ADf70UQTboNVpL7ooU73ZWHdJLRg5N4OsHCEnbyuivNzhsCmn5fSJj5xTyr9SBRya/H2D7WQwFwZnCNoFoud5FuHJ+8uI8QWw4h/d7AkxSgFcs/5a6Ixnhtx5c613yU7+8aajV4eLHmo0J9fas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TnE6Dw1s; arc=fail smtp.client-ip=40.93.195.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8sR0wArtb8zvkrahxZbRMAxRDL/ety8oS+GHG3zk0yd+WrL2vmz1zo8GI4zLKlI44bQqLT5s/PaUVBtcUmaObApEHKtCZBK1YuClxkCYYFuIcotP5bfw0zQ7Ed9E4ME9E+n1TydLbWEADaeCkqX6x4E9+c6Re3EUs6Ab/BKkykxJ1uk+KvQRYb7HfvUvXkvf8bE14dRBZ7n7D87CNdnF9MI0YvPCZW4WXMHoqtgelkiFCs/yKwmOoingRvOJQwIjWGBZoO4a6j93pF2Lc/U88uGxHXLym2EtZBdHjjT95TT9MIWYJTokwXXknmsvYTE9JQnstQnzi7IPVc4U08oeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPsQqZeHZuWoSfJVHPWlhgmuQ/A7YSAlx+N3Juf7JT4=;
 b=XnFgWqDKHOI46fsiHDLDgWDV72ahd/GCRR7scQeKAynq6H/Qvw6p2jQczPVfkR0MSZlzt5ZHLP7hx0QakPBZA41BYp58HIukDi2tPFaLYL2cmyO5hDPxecm9OnKNheiy1yIK/Oj/iRkpLtHXFYtUc8Q6LfIDolceOhBYFUjgbtgUIS35cZBoTynqUJsU6c+ZQIeS7J4tZASEWVq6XyS5e1STFPNHmMgnohAxNnCNKsCkCfcFBJNZtrn2nkroCBy4fQLUNroRfgcjXV/SEU32thsz90sEX21DtPownGEPhg2bbun7CaPTi0Pvp6PGOQeRXGIG9VEXxUBf3AjRsYMD6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPsQqZeHZuWoSfJVHPWlhgmuQ/A7YSAlx+N3Juf7JT4=;
 b=TnE6Dw1sJ4orhIqTrZIvb7Kyt/olvihkW7ViKFN9xrVEpO8rtf3HMSHbbkZ3yPjE/0dObmyUL+FAmtKxNBZXirV2J7tDHsUTJ9oyYDU9EWCjc2r9uR1C2oST4RUHdWrV1wqXEHMCFa6Y+wgGqi0VLmyW4ZmeEwetc9FbQv+gh/tFcUR9Dg5zWMv+e5FtFZ+B0OBb2HvWVgERqAOp1ZvII8X7XpHL/4vw3g+CTfJxOjPa1oWvBmeK/+6Ububs/5T54OxxJa63rW1iC2MDGOcAvlSBAqiSUpVj5LMxxK27oDBUUgW2StjTzTt5J6VMhVaswPdKw2uKSpv2Dnbxqhtx/A==
Received: from SJ0PR05CA0068.namprd05.prod.outlook.com (2603:10b6:a03:332::13)
 by PH8PR12MB6697.namprd12.prod.outlook.com (2603:10b6:510:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Thu, 25 Dec
 2025 13:27:45 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::36) by SJ0PR05CA0068.outlook.office365.com
 (2603:10b6:a03:332::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.2 via Frontend Transport; Thu,
 25 Dec 2025 13:27:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Thu, 25 Dec 2025 13:27:44 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Dec
 2025 05:27:44 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 25 Dec 2025 05:27:43 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 25 Dec 2025 05:27:40 -0800
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net 4/5] net/mlx5e: Don't print error message due to invalid module
Date: Thu, 25 Dec 2025 15:27:16 +0200
Message-ID: <20251225132717.358820-5-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251225132717.358820-1-mbloch@nvidia.com>
References: <20251225132717.358820-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|PH8PR12MB6697:EE_
X-MS-Office365-Filtering-Correlation-Id: 82bf4540-f1b9-47bb-f430-08de43b96375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FfPObQQ8abtq+u/fGCSm6XQbzourzI+cBNMsRzdq/R/Tn+5RLB9fZPqfSSMy?=
 =?us-ascii?Q?pr1DBYABBqwkAkgid1qQpQQ/KCgZxypYcApHtk3sXSyku1Dsdkp6z3h1T77k?=
 =?us-ascii?Q?ca8QAxsxngMFVYW+99XXcE88/azlfoEQttNrqWNNHp8o/O9d3deAY8dmgwao?=
 =?us-ascii?Q?Nnf0gkmKXubER5DEkBbP8/r9ARe4JEPDKSXmcLkp/Jon0UgqTyQWCYtVBNdL?=
 =?us-ascii?Q?oYv8LGPO7IUgRC8c/LQnoeR30m1SkIIry307N6SxjNeYdrtnHpBgxap0d/YZ?=
 =?us-ascii?Q?RoYAontWpxSHmTHlFRQJ+QFiwD1cuG3ErdXvecxbYLLYsoitwqzMJ3LozG22?=
 =?us-ascii?Q?/weYsQys9r3arb55lvFhzM03bQ/LAlRIcY4aw9TphFY4zRE3viRkqgXPysv+?=
 =?us-ascii?Q?oLlDsA17nw59m+Qme4kb9VKpjsYXnG6jqv0nopQ0+JT7abnr2u+/5NlYOxPu?=
 =?us-ascii?Q?I3ZN2c+Np2KLXuJUaQnPzdR6PClQJtrk7LS2xpobD1Q/ZM/c0LQz1xSxE/Qc?=
 =?us-ascii?Q?z+pycwk5KXhvs52kgYrmn76X9KF/bmHYe+3ewhp5JKg24YjAIzim6xDsQIk9?=
 =?us-ascii?Q?3xuiGJSSwmUZgB4OZO9UORkbwa1HlA6B0JTmOYoMma2fKaOIkjI8+fAIF00S?=
 =?us-ascii?Q?gD2u1TvRlLc321ihM9AFX734g3gc7KwevH9uvewlk6Kbu0pgHd38+8vLq5F0?=
 =?us-ascii?Q?m8Ms7YAFzliYzgbRG6O7RRBMWQGs31ZS4suI3x21+WRQJlJmC/EP5cCc/dKd?=
 =?us-ascii?Q?cJpcdIrDwswNZHHLb9JrurWLz/hwvgClxnn/C03Sk0JV/cP3hsds3roCELBi?=
 =?us-ascii?Q?Zk7bvEi4irmgLD/bsJpQjVDNnvZRR7Ffj1nlAMxXqwKOBeJEP4TmG1ufCJmy?=
 =?us-ascii?Q?R5johPelSjZubupHPBmeexzJUhAzPlwqUmRjonSKKRl65cLWSvdO8ZWJsjSt?=
 =?us-ascii?Q?Xk0JjlkQyUyagOLF5SmxI85oAGxYJz224qO5WQ13B03dm6u49NagVBg0yj3x?=
 =?us-ascii?Q?utCLBZXbX3qmVMGOSQeJDFzdcbT2/NiMe2EzqnPbggIIId1apcV0jTAzh+bB?=
 =?us-ascii?Q?Ko3uMemh66cV1YYmtK6zZzV377MBGOclnSZrnwH4+p9n1EESGgr0CcAKateX?=
 =?us-ascii?Q?6Q3cXz/J+vHX+Na5I0EXICnUwMWfIc9RvrlhbAvYhJHGOPIOJxyH3nR7sjGV?=
 =?us-ascii?Q?yJS3UK55WY4JeEdlAjOLUvWk3G/8MgpM7cvOuvDEGnBryv26EXh6xXIRMHWR?=
 =?us-ascii?Q?jom+0/NFpHCmWry23F7gyauB9uOT+DhvfXQzbMKkutD4N87d7U+lfDVQCyHw?=
 =?us-ascii?Q?eipAFlRXng85LBaX+rfINUtDAf/qTiYJjqdAnpaTJxU4/JAN1VoaH/zHIQhA?=
 =?us-ascii?Q?7DpqBQD+5Oy5kriVHlasHAMYooXS6Eb6KAXmSCWutqIHdgCQlGn8Tlk55rwg?=
 =?us-ascii?Q?YG10VCNZ0dr4Dm2f/vfqkdo3m7E0AxHI3URwoBrScUxNX02MV2mB4ZUMDN/d?=
 =?us-ascii?Q?7rPhYx7KUGK8qPESzRRKS58SNjYj8YIzj+aHF5monTjjJrX0hGMdypyQ3bOi?=
 =?us-ascii?Q?z4i3oF+E6cPd8aQw9K4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2025 13:27:44.9156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82bf4540-f1b9-47bb-f430-08de43b96375
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6697

From: Gal Pressman <gal@nvidia.com>

Dumping module EEPROM on newer modules is supported through the netlink
interface only.

Querying with old userspace ethtool (or other tools, such as 'lshw')
which still uses the ioctl interface results in an error message that
could flood dmesg (in addition to the expected error return value).
The original message was added under the assumption that the driver
should be able to handle all module types, but now that such flows are
easily triggered from userspace, it doesn't serve its purpose.

Change the log level of the print in mlx5_query_module_eeprom() to
debug.

Fixes: bb64143eee8c ("net/mlx5e: Add ethtool support for dump module EEPROM")
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/port.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
index 8f36454dd196..7f8bed353e67 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
@@ -431,7 +431,8 @@ int mlx5_query_module_eeprom(struct mlx5_core_dev *dev,
 		mlx5_qsfp_eeprom_params_set(&query.i2c_address, &query.page, &offset);
 		break;
 	default:
-		mlx5_core_err(dev, "Module ID not recognized: 0x%x\n", module_id);
+		mlx5_core_dbg(dev, "Module ID not recognized: 0x%x\n",
+			      module_id);
 		return -EINVAL;
 	}
 
-- 
2.34.1


