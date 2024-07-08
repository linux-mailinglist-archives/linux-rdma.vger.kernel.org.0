Return-Path: <linux-rdma+bounces-3724-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C98DA92A1D9
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 14:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72AE41F22653
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 12:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCF0839E2;
	Mon,  8 Jul 2024 12:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZmADDVzj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D08824B5;
	Mon,  8 Jul 2024 12:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440113; cv=fail; b=rCPk1NTRscrpeudRsO13D6SPMvYvEjWxvzxvN9VqPtrTHmfPXWeDJJhiID3S+8DVdwwNXL4TaGEDXO4H7OO9XZy2DdTgOKDI+e19cw/2lJMylfF653ujoukT8ItTLpG8vFFtelawxEfpalcjSthPQ7Y42J7QO0mnw3Lbi0l0Rmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440113; c=relaxed/simple;
	bh=1hvRehAXZDVhCW7uc7+JCoX47DALhabAhghNikm7DZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bPWOnVBW9WhnJDdCKHRp4Gji3QmfQTNcnW5TDBo43qJrquBN5YdLNypvxA+cUQYLBBC3ltu2kSobmj3dDp9O3In3HFSjvU1BZa0A/n0Ud9ZqixZSGBhCajpqF06SL+q3pBZvmEtdu/g/toviDaS9KNRDi7wFWvWxdpjYLb66ReA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZmADDVzj; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4g0oE/m0cvNS1hZG90CnJ/+8Cd2d6DHwTDRxdZmEq6Zdo9uGPSmLnk1fqYVuAM5Bj76CbHghnXfewH4gSNwRE4aMCwnHHDr00PKT97zYwt9Fi2dq4IJIry69Xy2lvzYCsHKkQ64EmeytuhKtG239AjgOL7yioRTxWy7d2S14sq692t/a0IJSNimm0QVNpQMq+RZKysEwchx37PjmJKVyH0T0/9ci8fDFH+4BOcrT2FRL9ERhM/OiBhDYpVGJEuggMD3uzJiaOsDDlkNnYUdPRjNyCbAjePO1GdVC97AVb4FSKdZIKJswZT9w4KCfPZ/FcdCfOm7tZL5bTaGgWI3RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=teXHsE8IPOQawmuB6+cxetBZFmw6RHnXZPiujYDUvus=;
 b=ToiS3QnmvcMRq3UNNXdo19HkzypbIpgqFeppI11VwQitwKNY4WLKdNB3p+E0WrLts5UjFqHfpIppLjdlM/OtH3wwWd8XvSToI7ZR/wqS/aYJp/MVj8A7NfTxJgV+3d4P23X/GZcdbcWIWMgCv3iHE4u3sVlSrZLWOFAeZcpYY33PbRchhtucX5v9FEMxHAdJqeXKBcUhMkymr5NIPVSDnhXttKTSPuPLqp1hr9KWSS80Nj0+CMvNrDMrL0X8kdYF8eVkZevIejMef2+4SNiTkuDuHGQb7lXpugUM2kXTLwaNzBnm3/6dJA33vyO9cEnCv/zELC49ImqciYPGs9jbQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teXHsE8IPOQawmuB6+cxetBZFmw6RHnXZPiujYDUvus=;
 b=ZmADDVzjL/lL4wk/o5PqzPzMtgqjZJpBnvmkszVkOMJOJzefnDe6XDXboTqgYHwuUqX+xBuRZvj8vF6wUdXjCiPOVdthuYWDeGoOJh8c1+Uw+DPqMv8oOic0ogKdUjPI82UJgfFSNQBYOttwFQcY0Uu90pMjhYi9kmnnM1FHpQOsL/cz1pKr7ohzAQ3urIAhx0PLbocLslFdeSFRUZaQwG/5eQU1lS5BnCHvzY+vlBoQaH37vbVkT4vwWHwmeGZkrAEYdAKb2LZM5nKxNeG9c0hfP/pTlibEU7Btey7MGLyQRMxJLfbIIHo1l8/klrlgQ5uCoFONFDsgBTn3cW+2rg==
Received: from BLAPR03CA0021.namprd03.prod.outlook.com (2603:10b6:208:32b::26)
 by SN7PR12MB7809.namprd12.prod.outlook.com (2603:10b6:806:34e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 12:01:48 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::95) by BLAPR03CA0021.outlook.office365.com
 (2603:10b6:208:32b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Mon, 8 Jul 2024 12:01:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 12:01:48 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:01:08 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:01:07 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 8 Jul 2024 05:01:04 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 8 Jul 2024 15:00:26 +0300
Subject: [PATCH vhost v3 02/24] vdpa/mlx5: Make
 setup/teardown_vq_resources() symmetrical
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240708-stage-vdpa-vq-precreate-v3-2-afe3c766e393@nvidia.com>
References: <20240708-stage-vdpa-vq-precreate-v3-0-afe3c766e393@nvidia.com>
In-Reply-To: <20240708-stage-vdpa-vq-precreate-v3-0-afe3c766e393@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?utf-8?q?Eugenio_P=C3=A9rez?=
	<eperezma@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu
	<si-wei.liu@oracle.com>
CC: <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
X-Mailer: b4 0.13.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|SN7PR12MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: 4deaa71a-4e10-48b9-9936-08dc9f45bee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUxnUlBhMlhFM1l5WGpwZERLTno2ZlZ6THF4M2NUWTJTRzE1UEprRnY3MUxP?=
 =?utf-8?B?RzM1WHUrWm5WcVI0R2tSSXgxVVIzSDN3VlphT1owZDgxdC8zdEJtMUttQ2w5?=
 =?utf-8?B?KzlURWIrWEdGZjR5K2sreTZkMXlWZ2VreVJuUzhiYjRaa1Rva0VRdHZBSUc3?=
 =?utf-8?B?TlB3TzBzek5meWdFOHNRNGxDQ010c3V4RlJWVnV4TjMrYW5jbFVzUzkvSjE5?=
 =?utf-8?B?WDZhY0xDZUY2Q014SVpSTTlHSXdZOFhkRG95c1d1ekE2OFFoVUo1NEN6dXFX?=
 =?utf-8?B?OVo0VGpKS204UHUrN2dQL2lGeXlTNEllT0ZlL0Y3eVlHNU9JRHhZcy9xWkdN?=
 =?utf-8?B?aVUwVkRUN1ZmbnVGUW8zam42S2pCVm8zRitCdEFkcWdGR1RTa0ZVTTY2d09J?=
 =?utf-8?B?TDZ3cEhkbkVhWjRjc3pQU2J1SXJTeVN0bmRmSWI1UXFpdkRMbmdCcWpZN1BV?=
 =?utf-8?B?dDlSN1haWlZ0WHVVdWozMmhsKytFenhEZEM4MGp5aXdEZkZxV1RGbWM0TmJR?=
 =?utf-8?B?a2svcXY1ZHBaTS80KzhZTE1HYjR2UnVYMEw0TFVMdnZJR2pWclVmdWRaYTha?=
 =?utf-8?B?akpMU2RIL29oeGc5VlU0dUdVWDV0eDE4Wkd1V0I5Z0VDWHEzNVN5V2lvSGZB?=
 =?utf-8?B?MndmL1hITGVJVXBDNi9reVBTMUxXaTlzY3REUHEvSHF2YjNiczlYVVp3WDJW?=
 =?utf-8?B?eHM2VkVIRWRKbFhlYmlCNnlqYXBpd3d0aGpVRVVtTjM2UEVpblNKY0FSTHI2?=
 =?utf-8?B?UWZYejdnVDl5dGcrQVRjT0JNOTFRdnVDK29QWUJ2eWMzZVpKVFFQcDg1TzNR?=
 =?utf-8?B?bEhqa3NXSXl3VzMwSWR3cGQyVlkwY2U5Sis5b2x6SHJNU0FlZExvblA1NjZj?=
 =?utf-8?B?R2g1MW8wSTYzQ1pvc0I3VHFSUWdrRitVenZ5VFdxMW4yeWxGb2htL3Z3b1Vq?=
 =?utf-8?B?dEcyWHljSVp1NVlzOVB2SmppQ0crQXZPdDZJNkF3blRKeTNFaUpPekpFMUY4?=
 =?utf-8?B?UlVzb0RBSXRVUGorL1p6VWVjMUhNdko1d0FlRitER3E5TVRMUHRhSDlCTmdT?=
 =?utf-8?B?b25ST1RUNnBqZm91bkQwT3hDaVJINkgxSXFmeEVIcCtCTCtwNmE2emtxWkJ0?=
 =?utf-8?B?bWFTYnBSQXFSS3dqN1UyMzFMSVVSeU5PSUppcys4d1g1QXYzOXJ5N2JtUE5D?=
 =?utf-8?B?aERNK0NXb085S29TZ0pxbStKaHEwbm5FRzd6Y0FrYmozQ1l4ZlhLLzVXVjd3?=
 =?utf-8?B?K1FidXh4Rk5rRXlVTU5ZUUNWQTRaS1FpLzVhUjNRQnJkSFRXSEkwV0N3dXBt?=
 =?utf-8?B?MVBkYmhsdWkwVDVVQ0habS9zcXFhbjlLQktLZDQwMytTTlRkY1J0c211cEZh?=
 =?utf-8?B?RWlpU2NacXVKMm53T2tiRTNNcW5WbElXS3pWTGlNWVczUXlTSjEzMlh5cWE2?=
 =?utf-8?B?N1NjQlNUVkRXcURrZzY0NEM1RlVENnZNTnNRS09GWWpXTjFCNy94SVZMQ05y?=
 =?utf-8?B?SnA3VDhpRUNFaDlVbFZpUzJPRkk3b0hUZ1N3V1F3TDFFVDlnVnlMdjhrZ2FM?=
 =?utf-8?B?ZzVqTEIvUlVLRk5ROVZhcVZ6SkdkZzgxSWkxWWJmbk9FT0tYeXVKQVkrazk3?=
 =?utf-8?B?cE5UQVljTTRYd1dGT3A4Vlhmd3prSHkrYm1KYmxyK0l0UHlUU1RQdS9rYkJx?=
 =?utf-8?B?OFZ3WThnMXBiMGFjMjFiWDdkOFk4Q21aTDBvOXBHc3c0WkFzQVpEdCtuTWQ1?=
 =?utf-8?B?ekgveUxvSVlvczhiRW0xaStIQ2ttQzFkN0dXZmkzQ0dqVVdma21CRFMrUTJq?=
 =?utf-8?B?TjQraXhlbTR4TFlhUW9NMUdVcXdvSWM1eGQ1VUowNlJscVdaSlB0Nk14clhr?=
 =?utf-8?B?WTlYOUVmRkZoQUJrdkpiajc0L0l0WTlEOGpFZDNsUDRhWEw0alpkaUovNHp3?=
 =?utf-8?Q?O67iEArDj26bSFfBx+VYJJWzOwlJxwcQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:01:48.1686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4deaa71a-4e10-48b9-9936-08dc9f45bee0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7809

... by changing the setup_vq_resources() parameter type.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 3422da0e344b..1ad281cbc541 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -146,7 +146,7 @@ static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
 
 static void free_fixed_resources(struct mlx5_vdpa_net *ndev);
 static void init_mvqs(struct mlx5_vdpa_net *ndev);
-static int setup_vq_resources(struct mlx5_vdpa_dev *mvdev);
+static int setup_vq_resources(struct mlx5_vdpa_net *ndev);
 static void teardown_vq_resources(struct mlx5_vdpa_net *ndev);
 
 static bool mlx5_vdpa_debug;
@@ -2862,7 +2862,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 
 	if (teardown) {
 		restore_channels_info(ndev);
-		err = setup_vq_resources(mvdev);
+		err = setup_vq_resources(ndev);
 		if (err)
 			return err;
 	}
@@ -2873,9 +2873,9 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 }
 
 /* reslock must be held for this function */
-static int setup_vq_resources(struct mlx5_vdpa_dev *mvdev)
+static int setup_vq_resources(struct mlx5_vdpa_net *ndev)
 {
-	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
+	struct mlx5_vdpa_dev *mvdev = &ndev->mvdev;
 	int err;
 
 	WARN_ON(!rwsem_is_locked(&ndev->reslock));
@@ -2997,7 +2997,7 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 				goto err_setup;
 			}
 			register_link_notifier(ndev);
-			err = setup_vq_resources(mvdev);
+			err = setup_vq_resources(ndev);
 			if (err) {
 				mlx5_vdpa_warn(mvdev, "failed to setup driver\n");
 				goto err_driver;

-- 
2.45.2


