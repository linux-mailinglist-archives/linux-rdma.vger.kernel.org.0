Return-Path: <linux-rdma+bounces-14121-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA612C1C162
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Oct 2025 17:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B97B06E7339
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Oct 2025 15:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32453358D4;
	Wed, 29 Oct 2025 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NIUdyNcq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44B934AAF0;
	Wed, 29 Oct 2025 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752702; cv=fail; b=VDWMfVtCRHNgHYemUMINcefKJKdKXzNIln/OVds6EZSdzMSQjmHfU3Dsa59d6U18C4ffuoJUpHD/KfnhV5EnZln0lQKaijrLnonaF//zu9ZuU8WZa5uU8W1SfRsL+s5eWLxni04eCcFgEEMQCwknqM6AUrDQ/AgS7ELtXBlDa+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752702; c=relaxed/simple;
	bh=8onhok3Bjznq2C8TxvROtSpzoKBgtrycyCQSaM2oBzE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AYBD84fRqP+G98qNkwAHo8i+7BSBDB+I4Xp6CGkRKcDm3dXL2D6KHPC7U5LJ3dHs82aZ6hGgmTrDYdKBKzErm6f6f0MMI64uvYXb05UpZ78AXvpEk3qaPJ2MEIixI8eoSGFLeTVRE9UT2EsSK5hfGz1kJ+OjqyRiixivhg2AXco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NIUdyNcq; arc=fail smtp.client-ip=52.101.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcLcywbITFsVVk6DYvFVWJNnK1YwLqMMOFI7WWjRdEm2qVd9vWm02dsgJtLxcufF+zRn+YOnpUkiymK2AoQADpCUiwZ7CviXFO94TDKV21ahcjcgdagrClKGO0yKXuenyvHF5ABehtgtFe5UMPwjyEFMWMqhfoqQPCk+mEmAjhCit8zdTaop0kMF9w7JtyBA13oQvVy5CboYORQ2pzK775OD255it+Ls/z4jYMDi77eFWuFx/o1vr2tJPzjDeDiG5V+p4oojRkk4y4p9ePPer1qiKJcZGK7YnEZ0ICLgeA61r5FCA+mZ4vicoHd3+fvqLsXh2OQzB+Zo4vyMRdkMhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5eFEkA4sp8vQH3nsX3n4z6djJbKB1h5rqtxHuwwhYw=;
 b=OpuTH0s/IroLXul86BXMMddxgQMnN6qOA1HIZlelBxnfKPFoC1WrtzHkRGAV1nkqPqCEjzdjjY38x6M6YnU4a1x8AmQpXRPdxJ3/hSfOis/kSOA+X38ylZA1TH5UFHFyECax3aVhcZGP3fExEt5TBUvzsFIwVwLqpi+4mCLjHPUjS2mFXAh5w5nIIoeXv7jJe4UUkKAihXYilg/wkPlBW/ZN9UXaBNgTG/UbO2XNxYPHUKxQhMASa+ZA7DuQ8Zh5dPVoBC7NqPTE7D6s79Oq7u/flKAIZs7F2+n8THn3NaehrbDxLCBBNG+jD4nhWiRWBy5hcQ+TsAk632UH/aRr0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5eFEkA4sp8vQH3nsX3n4z6djJbKB1h5rqtxHuwwhYw=;
 b=NIUdyNcqz74J4OMo74IwiMrzavgxpj9vAt52BlFRAy01DONNJedrlpza8m5Jdn4tHcZZbuSEJnAPEXS1A8O5dncpcdBGlCwRkDUUNG9O1rHFC77CGl3FwDb9t5g7UbmIcgVjAVruPYytOHRJ8pAvnv96ERSrRjjHGm0kxOMW2+XhkREHljzge7Y7MHEy7kt8Ojd77KvR1v95PEHd/86xusvf3d+VNx2W2eiKXVtMLuV4l9EOxZJIVqUw1gNRkzHL38iv2dnZCXmUMcSCR/3eGA4Gr0903dy8o7i9eZD/mEHDEuKluSSL/gDXk2pGu7MUhjfIB8CCEa6q00CpcgBbgw==
Received: from BN1PR13CA0027.namprd13.prod.outlook.com (2603:10b6:408:e2::32)
 by BL1PR12MB5802.namprd12.prod.outlook.com (2603:10b6:208:392::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 15:44:50 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:e2:cafe::9f) by BN1PR13CA0027.outlook.office365.com
 (2603:10b6:408:e2::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.4 via Frontend Transport; Wed,
 29 Oct 2025 15:44:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 15:44:49 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 29 Oct
 2025 08:44:30 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 08:44:30 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 29
 Oct 2025 08:44:25 -0700
From: Edward Srouji <edwards@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Edward Srouji <edwards@nvidia.com>
Subject: [PATCH rdma-next 4/7] RDMA/mlx5: Change default device for LAG slaves in RDMA TRANSPORT namespaces
Date: Wed, 29 Oct 2025 17:42:56 +0200
Message-ID: <20251029-support-other-eswitch-v1-4-98bb707b5d57@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20251029-support-other-eswitch-v1-0-98bb707b5d57@nvidia.com>
References: <20251029-support-other-eswitch-v1-0-98bb707b5d57@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|BL1PR12MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d8efe46-a8e1-4321-2feb-08de1702183f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1RXRnNUSHJDMnd6ZG1tNWdhb1pXSkZSUWZZN1FTbFJqN1B0bFdsL0FIUHBG?=
 =?utf-8?B?eEhQNTh1aml2b0RJK2xzaDZocEhWS3lZU3U2QnVjSXJOOGs5K2FGaHlWeE9R?=
 =?utf-8?B?dTJRYm1HZHlvcy8vQkt2cU5LWmRQK0IrWmZxZ21lU0tTYnZUZDZTK2xuUjJt?=
 =?utf-8?B?MEhBK1VySm9WQ2R6TEQ2OVFyMkhPb2EvWldFU3hwRXd5R0NtM3VZZGwvTGFy?=
 =?utf-8?B?TTVlTkJKdnZ6ZTRjRmJyaGV3SGQ4Qzl6UFJCNkM0K3NOTVBBQ09LUHh3T0Yr?=
 =?utf-8?B?MnA5dnhPUzR0T0Z1OXpSQnlXUUM2SnBlcXhpRGtDa1ZEaThUYUlDR1ZTcHE4?=
 =?utf-8?B?TlYrNUFDcVI0ZVJETFVOaUZJSHFYK2xra0wwY3ZvRHVCZUxIdTY2bnpCWmEv?=
 =?utf-8?B?d0F6TWl5MzlJVkdSb1I0ODZwVTRsN3FEZS9vRDk2aGc3cTdhUnZ3dHRTbHNh?=
 =?utf-8?B?aEpsTFRzNWNSckYyc3hGS1hNVzd3cWtzcFRHYldYV0FMckp0ZGtFSzdWWngw?=
 =?utf-8?B?b2g2d2g5K1JHazE4Q2VpdDVPQmpVSjhPWnQwS2dJOHdmRFVvL0tYU2xCbHdh?=
 =?utf-8?B?WWY2OGJhVFcxMGFVbGczMFpScTVuWXlkRWNnSEN0UVpjY1RmTGt5SUJIUzRN?=
 =?utf-8?B?bWVaYzJwVUFxUk0zbVE1Q29RTlFoRFlJb3AxWmIrSGY0TDg2bWw4aEdCajNq?=
 =?utf-8?B?OWZYYVo0WlJDL3FQRmhRZHV0WHBuei9Zb3h5RWh0SmF2bzJWSXZXSy9HQnZa?=
 =?utf-8?B?ZzBqTnZ5SENSTGpWekduT0EwaGU4TVN0WVVwNCtqd3lPbUtncnVUTkFFVG4z?=
 =?utf-8?B?UmdMRVdSUlZYdEdjbHl0bTNTTThrV0dubFIra3FuWitTUWw3R2Y3MzlWbXBa?=
 =?utf-8?B?RWgrRmZ6VHZ0UXgvQ2V4eWl2MUhqTkZUM1JHWFluNlVsdGR2QzZIU01sc2xa?=
 =?utf-8?B?V0d2K2d4VFkreEp6Ym1rWG9XUHR0UGlhd25OWkpuVWVoa3lQZEVJVU01ZEVy?=
 =?utf-8?B?TmFYa3ZDQzFuQ2tCL2EwK3BRblhtSzRxUW9OSHFDbnJYSnRlbEJrVWhVanAv?=
 =?utf-8?B?aFYrYVhUc1BUVm1LRmdlTkx1RzlXL0NzbThKcEZPWlcxZ2kvNjl3L1FGZXox?=
 =?utf-8?B?UjcxdUZRY3BPRXR1cDFLVDIyUlVMSkdPODZrb0RMdTFKdDFWYmRVTGo2Umpy?=
 =?utf-8?B?bWMxc2ZTem5KVG9YYk53bDNiYVlZeWZob3JlUjVjRHVSRHlLVEVIL2RjMUc5?=
 =?utf-8?B?Q3p6b1c5QldzQTdsUEhXSmVLKzcrUUpjdXhsR2NnNkd6VFZNSFlYeFRnWDBU?=
 =?utf-8?B?MnVXbjhpZ1JoY2RUdmZPYWRlQ0pLbFp1SUNqWXFKKzJPRmZKT2tTZkZmbS8z?=
 =?utf-8?B?MTlyd21aZEpqWXZJZkRyc203ZDNzd2hNdUZrb2ExVHNURzFlOFFKUjlmSDg4?=
 =?utf-8?B?V0EydmlGQi9JUnVybmtlVzkzM3JxbUxYMVNDZGJ1bk8xMWZ6RGttQXFESmZO?=
 =?utf-8?B?SGM2NllEOTl6QjBkWFNnRDVUWFRMakw2ekdLL0lWY05rQU8vazdPeTcvV2xR?=
 =?utf-8?B?cExBL2NwbmpNMTVrcWtSWTRkNCtGZnRsZlNqM21GNzVpbFNLKy9YZm5YVUFD?=
 =?utf-8?B?MVRpMzRja3Q1bUhMdFZHWjUvVnp6cFNxcE55YktQLy9KWUc2cTZkUFhCOWJ2?=
 =?utf-8?B?NnJUVHNLNnBLclgrM2pUT2FYUFQ1L3VaM2NnYlhaMXN6N3EwckpaSEVWLzB2?=
 =?utf-8?B?UDVwTldvbXBacDJab0ozOGg0c1hiUWliODdhMHpOTFRCRlZSUlV6ak5WSkpU?=
 =?utf-8?B?VWl5SFE3cTZXclBSdFI3SzNIVVRwaEpQaFJoTUo0ZmVEd21DRzVaRkxFUnM0?=
 =?utf-8?B?S0dwOUFKZlVKM2dtNFR5TWQ5ZDBVQzhvRjZ1TGw4VlZuMzQ3WEZQbnYwVEpi?=
 =?utf-8?B?NmZCbGlaamlHektQUFFxaFN5ekhWQStKczQvWXY3OGZlWUNMaXVUMHpKY3Nm?=
 =?utf-8?B?UFVYVHRYMXdiekdjM1M5blhsZXd2cUhuVmltQTk5SGdMN1l5NERMbWR0UEpx?=
 =?utf-8?B?bjdxWjZhcDBuc0xudzEyVVRrSENZcDFGRUo2ejhzZTBiTzZObEI4bXBJMkJy?=
 =?utf-8?Q?c0h4WqX9Xyhu/LQDGUbMhj9ux?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:44:49.5587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8efe46-a8e1-4321-2feb-08de1702183f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5802

From: Patrisious Haddad <phaddad@nvidia.com>

In case of a LAG configuration change the root namespace core device for
all of the LAG slaves to be the core device of the master device for
RDMA_TRANSPORT namespaces, in order to ensure all tables are created
through the master device.
Once the LAG is disabled revert back to the native core device.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/hw/mlx5/ib_rep.c | 74 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/ib_rep.c b/drivers/infiniband/hw/mlx5/ib_rep.c
index cc8859d3c2f5..bbecca405171 100644
--- a/drivers/infiniband/hw/mlx5/ib_rep.c
+++ b/drivers/infiniband/hw/mlx5/ib_rep.c
@@ -44,6 +44,63 @@ static void mlx5_ib_num_ports_update(struct mlx5_core_dev *dev, u32 *num_ports)
 	}
 }
 
+static int mlx5_ib_set_owner_transport(struct mlx5_core_dev *cur_owner,
+					struct mlx5_core_dev *new_owner)
+{
+	int ret;
+
+	if (!MLX5_CAP_FLOWTABLE_RDMA_TRANSPORT_TX(cur_owner, ft_support) ||
+	    !MLX5_CAP_FLOWTABLE_RDMA_TRANSPORT_RX(cur_owner, ft_support))
+		return 0;
+
+	if (!MLX5_CAP_ADV_RDMA(new_owner, rdma_transport_manager) ||
+	    !MLX5_CAP_ADV_RDMA(new_owner, rdma_transport_manager_other_eswitch))
+		return 0;
+
+	ret = mlx5_fs_set_root_dev(cur_owner, new_owner,
+				   FS_FT_RDMA_TRANSPORT_TX);
+	if (ret)
+		return ret;
+
+	ret = mlx5_fs_set_root_dev(cur_owner, new_owner,
+				   FS_FT_RDMA_TRANSPORT_RX);
+	if (ret) {
+		mlx5_fs_set_root_dev(cur_owner, cur_owner,
+				     FS_FT_RDMA_TRANSPORT_TX);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void mlx5_ib_release_transport(struct mlx5_core_dev *dev)
+{
+	struct mlx5_core_dev *peer_dev;
+	int i, ret;
+
+	mlx5_lag_for_each_peer_mdev(dev, peer_dev, i) {
+		ret = mlx5_ib_set_owner_transport(peer_dev, peer_dev);
+		WARN_ON_ONCE(ret);
+	}
+}
+
+static int mlx5_ib_take_transport(struct mlx5_core_dev *dev)
+{
+	struct mlx5_core_dev *peer_dev;
+	int ret;
+	int i;
+
+	mlx5_lag_for_each_peer_mdev(dev, peer_dev, i) {
+		ret = mlx5_ib_set_owner_transport(peer_dev, dev);
+		if (ret) {
+			mlx5_ib_release_transport(dev);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int
 mlx5_ib_vport_rep_load(struct mlx5_core_dev *dev, struct mlx5_eswitch_rep *rep)
 {
@@ -88,10 +145,18 @@ mlx5_ib_vport_rep_load(struct mlx5_core_dev *dev, struct mlx5_eswitch_rep *rep)
 	else
 		return mlx5_ib_set_vport_rep(lag_master, rep, vport_index);
 
+	if (mlx5_lag_is_shared_fdb(dev)) {
+		ret = mlx5_ib_take_transport(lag_master);
+		if (ret)
+			return ret;
+	}
+
 	ibdev = ib_alloc_device_with_net(mlx5_ib_dev, ib_dev,
 					 mlx5_core_net(lag_master));
-	if (!ibdev)
-		return -ENOMEM;
+	if (!ibdev) {
+		ret = -ENOMEM;
+		goto release_transport;
+	}
 
 	ibdev->port = kcalloc(num_ports, sizeof(*ibdev->port),
 			      GFP_KERNEL);
@@ -127,6 +192,10 @@ mlx5_ib_vport_rep_load(struct mlx5_core_dev *dev, struct mlx5_eswitch_rep *rep)
 	kfree(ibdev->port);
 fail_port:
 	ib_dealloc_device(&ibdev->ib_dev);
+release_transport:
+	if (mlx5_lag_is_shared_fdb(lag_master))
+		mlx5_ib_release_transport(lag_master);
+
 	return ret;
 }
 
@@ -182,6 +251,7 @@ mlx5_ib_vport_rep_unload(struct mlx5_eswitch_rep *rep)
 				esw = peer_mdev->priv.eswitch;
 				mlx5_eswitch_unregister_vport_reps(esw, REP_IB);
 			}
+			mlx5_ib_release_transport(mdev);
 		}
 		__mlx5_ib_remove(dev, dev->profile, MLX5_IB_STAGE_MAX);
 	}

-- 
2.47.1

