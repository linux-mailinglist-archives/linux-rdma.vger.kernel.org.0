Return-Path: <linux-rdma+bounces-12712-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7BFB24C00
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 16:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DF9723571
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 14:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CEF2F531A;
	Wed, 13 Aug 2025 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="riheHJ+i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584242F0673;
	Wed, 13 Aug 2025 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095528; cv=fail; b=RPvu/irQ/7tmpH23uDMFOijh9kNTgBVdJPtS0tqoy75vmTmBoI9JnpGapVVQDu8UY7cBnn2tFxG0YvBhBpFGoWVRF4enVLokGoude8uonM8g/GDR0+c2MqeKGmPyAFQ133akEx4a0Om6Pf047b0PmSjRdSXXSBEp6B8Skf5Kab8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095528; c=relaxed/simple;
	bh=Gue3iud2GRRdan5byNrxNuF/Hl7Yyw82lfOcJu184RM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R24UomKLHVxXslQYq3Vt6+R/hU28TUSI7v/iopwBVDabO6vtyspZpUnJ/uJ9JNb0ozCnvz6UynUe4GwZEkyWl5ZxiqYiFpNGQ1KhmPcDTrizk4zt/lwuyY8OZRxBpgK/QavcB3//zT8AH6haSgfvRiU5sFKDcDQl7vRXeNmegDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=riheHJ+i; arc=fail smtp.client-ip=40.107.244.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2xzBhrTgd1xqcuovWt7igqi4Ae7M13C2Ca1asCDyL3LcunlOwmzAeuWTh2XYP/V3ygkMt3wuQkJ0KzHZvOUUSuRrBRPd5AaMxjxGwDXCysBy03H4uR7xc2UBWyJRtPzSbRO0c8rKgBz4ngACOndyasn/a98dDI/xZXu1KQkECAzBEv2WOiJ9ChHjmPp1ABfJJ6Yzp6eY9j/LjvxK7XiqSxFKaVJIRmRuDWjqRidoECGAKbS4u2yQ6LGHTMFpvi3AGmvLOer3Jg9sF1QlmRW5XCirmVQE0U31sQdY4dC/QC25f2fINTOzRaCulPLDRglQL/iZjVg6BAkiPIGzwB/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44hKiA114csYRqAzqNq3GaZB4v9j/6d1nsGhor227/w=;
 b=n11hzMJUDFh8TXaemoX65KA4ZhWrpRD+UPcHlUg0/AJyh3Tzjfs4X/lodUTD/QrO0C/wZq2m7dqiWJnm/hKFgaBXicUlMEAbtR2C1idFxcNFOJpFSVFdYGEK9oYJR8Yr0dCjNTjQN5rKpmj7Mluqgmr2bBu4lbqkkFWe0YWFj+5y0LkHsoHb3W9kcU/l+S9vM6QwhH+AyDCBmR/xNAgR1L7NsSiN8Oe6dVkYFstdZAFw+455+C7Ehgak+0X7Zrbh+3n48kL8hMcXCqP7e/VlbR3XvXJYF1e6B90OmtUc+2V1nymtAQi+7y/je8tjefT189m4dj4yQlh4l39B4pAYAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44hKiA114csYRqAzqNq3GaZB4v9j/6d1nsGhor227/w=;
 b=riheHJ+iL9SSu6fUoBp6aEU48Sdz+/3H2oxT2id3Zz6LKi+BXhkygScMSUY4rbRgg0e+k0cu/6sbKzQ5P6MeNeGgcM625j3JjfX1+PG8jI/w7NVTIjxqaUGwYyXKLY3rA68V3q17tm219T0rshrKMXThoVcIcW0v3n0SrM+qXW+tPBiw5qhrFnfYLmzaJYWP8L/K1i6rdMXqaAyxTHrGHpGtbs/HoU35PaCTAKMS5IoOFdUp4lhgISjcoPokaQ3YM9lxCJ2yDZX1pKKn6K8YJHz1mzner74h7DofIzizMptC0+eUcPBnzUGwKKoar2vK107kBCs7aOa9WsXyVedQrw==
Received: from SA9PR10CA0015.namprd10.prod.outlook.com (2603:10b6:806:a7::20)
 by CH1PR12MB9622.namprd12.prod.outlook.com (2603:10b6:610:2b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 14:32:02 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::f5) by SA9PR10CA0015.outlook.office365.com
 (2603:10b6:806:a7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Wed,
 13 Aug 2025 14:32:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 14:32:00 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 07:31:44 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 13 Aug 2025 07:31:44 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 13 Aug 2025 07:31:40 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net 1/6] net/mlx5: Base ECVF devlink port attrs from 0
Date: Wed, 13 Aug 2025 17:31:11 +0300
Message-ID: <1755095476-414026-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1755095476-414026-1-git-send-email-tariqt@nvidia.com>
References: <1755095476-414026-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|CH1PR12MB9622:EE_
X-MS-Office365-Filtering-Correlation-Id: da8147fc-a345-4ff5-ac36-08ddda762a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z5kPcAXpoHGHlboVG7pciEPlDLSRgzgcFpmrHtm/ZeGJ7HxKif34BX8EaIO7?=
 =?us-ascii?Q?BuEA/AZsRG1ReUZmfwNqMTCeKLaqltfmJbuDZqYNUPmIkDCgIr6PS3DlqEYz?=
 =?us-ascii?Q?6g4SmdOTL+eKELTT2vOxIof9iNEIgKUQupTvu6D5XQVuxogPU/+X+4uOl0yL?=
 =?us-ascii?Q?GZzxXcg9+31Db4QK/8K3xj1Yx8xQcvPioVONg6aXvTUBt9aQH7WMrifQwF/m?=
 =?us-ascii?Q?txRmyIQrBjRmWU7la12N8Mh/KatcVjVgotQHYyp4pg1TsU6edIlgfUTfYrPW?=
 =?us-ascii?Q?ffsImXfYs3wtqMzrzTsRHBiCgknvSi7cg4k35TfFnu6ZwvNLJRxiqgDbAiNq?=
 =?us-ascii?Q?/bB0+i0OsX7v4YX2/ehp1LVZVotJOK88DnJ3D+sT+Z8RpIIKr2AsZgRfqr6/?=
 =?us-ascii?Q?InPUx5E1qTmiCrSRyznupD1mRauITro3mj/BG2coSF2LesHfV3W7OS/Nn3qI?=
 =?us-ascii?Q?BQTb08leSQdPi4Otlt4ZuAL7oA52HiaTP2S7Sdn26q/yz7Gp//6LlUc3UpLX?=
 =?us-ascii?Q?jsyFBR5yp2T/rV0c6BCyAS9FkaYDiNCgjBdusJ2lk4Bz7fQA7amwxeY5K5q1?=
 =?us-ascii?Q?GmPkg0/FoVBLkbsfinQAqdl3xAeODxPuvF+egnbtMcpcGmnoQjZ7ZQV5RVOa?=
 =?us-ascii?Q?t9TZjS239eNp0Ue9lhZlirg5ES5EuVkCgO7aG0NZ7rr1o6ozVEsjAFrirMOg?=
 =?us-ascii?Q?SorUFzL4+tbNMaalHeTge5UrheNqcjqj/ijfzFvzXcbSFgxBWRAIZOoId2sL?=
 =?us-ascii?Q?QjiSDNIcJhiba+9yqX73nZLYm4uDTk+eH3pOhONMezrdO6e3oEBFiHvMYcgF?=
 =?us-ascii?Q?UNhLAR5rWOx/umBMszWI0xjVC724z8QRKxgCiMLq/BmhY+9kZ4c/oq0Mlvvy?=
 =?us-ascii?Q?/UGhBQGwh75NpGAWswqDDAm+ki+P4CTybVR4wl+IqLbUrdO5M/l1ozIuMnLd?=
 =?us-ascii?Q?B20qbVD1Gus8uB1EZxy54qHOWMmv8TmRzGFx9HABD7XjNTAfV0jSYe8rsWA+?=
 =?us-ascii?Q?H1OGqQs0KiSC9jLmaQQQT1OYfi8SatChj7y0xDgaOzd4QM+4GraxwJL4qo11?=
 =?us-ascii?Q?UBhDOkVfrkml+GmWsnkcnDVEQ2w2x0RUsxZa+f7Jew0icrzlKIH6ZO+vtceK?=
 =?us-ascii?Q?R6H/Vc2pv+3icEq2mBHzkrTbaiJXqWDxcgFF76NMQRVTMAnJGml1u0ioJzxa?=
 =?us-ascii?Q?MCuEr+icR3JgLDmlOP0hE+T7MYjrS+sTvUpIW8tg0ejC4v5JJ9fD1HLNHB+P?=
 =?us-ascii?Q?rbICcQzUXWppfW1HWuiM2/nDoCz7zxzKF4NC/I4XK+oWnvdSfVLqN4bnCGVG?=
 =?us-ascii?Q?PbtjOjglxtUVUobLeo4z3b7QHXPjRF+2mKOOtkHTJWvun3i8xXVSUN9bMJxm?=
 =?us-ascii?Q?Q3UY+rmEt8dVVa9S2ecgpZXtidWoXCn0ZHwwlAHzXGp05rA/qxLnCMVu2AQo?=
 =?us-ascii?Q?w/eLNt1s0+250uA1JyCp78MpyqlylhGMe14uDGND8ISqc6BkwaT+vkw2+Lkr?=
 =?us-ascii?Q?B5QgWjCKJVc+OTeCP1xS5WcLWrsvf4bCbPyJ?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 14:32:00.7525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da8147fc-a345-4ff5-ac36-08ddda762a6c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9622

From: Daniel Jurgens <danielj@nvidia.com>

Adjust the vport number by the base ECVF vport number so the port
attributes start at 0. Previously the port attributes would start 1
after the maximum number of host VFs.

Fixes: dc13180824b7 ("net/mlx5: Enable devlink port for embedded cpu VF vports")
Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index b7102e14d23d..c33accadae0f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -47,10 +47,12 @@ static void mlx5_esw_offloads_pf_vf_devlink_port_attrs_set(struct mlx5_eswitch *
 		devlink_port_attrs_pci_vf_set(dl_port, controller_num, pfnum,
 					      vport_num - 1, external);
 	}  else if (mlx5_core_is_ec_vf_vport(esw->dev, vport_num)) {
+		u16 base_vport = mlx5_core_ec_vf_vport_base(dev);
+
 		memcpy(dl_port->attrs.switch_id.id, ppid.id, ppid.id_len);
 		dl_port->attrs.switch_id.id_len = ppid.id_len;
 		devlink_port_attrs_pci_vf_set(dl_port, 0, pfnum,
-					      vport_num - 1, false);
+					      vport_num - base_vport, false);
 	}
 }
 
-- 
2.31.1


