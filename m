Return-Path: <linux-rdma+bounces-3736-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9D992A210
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 14:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9851C21363
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 12:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2271459E9;
	Mon,  8 Jul 2024 12:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T29Q2Dku"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5CE145FED;
	Mon,  8 Jul 2024 12:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440160; cv=fail; b=MO78VBwsfaZjA87oT6EJdQslwZHk3vFhZbbgI9uLOOXxx5xe6X6lNdGe+qt5YthVeuvlLP93I5XCdMIrhVjnrilChGa90oVjPsQN7hceCM5A4W96hoJEFF/X0o2R1KwlBv2yyC5zIat7I/RuFixVWAfcifuMR2pufiCjO8qftww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440160; c=relaxed/simple;
	bh=9yEPtm3/NyIuXmtWlfORIqO0rwjP1BCWekvMgMNYfD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nBkEX8ovFwdvRg2whwW16VPCszZHQLcWrMxRBYTD7ZaXoUDVbK2JqMGMoJi5gyCZ48vVcxegLymUDkQ10+n3XAEYiR+NZyviuhF7R2790YGQjxnZfsxVF75uiYzXax2ZwkWAg8ICBUcIMbmkfGk2iuaEH/Qnd5mRXM/KZW0S0Pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T29Q2Dku; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjF86ygD+iVoX2aiw5q+D1B1w3QqVRgU4uhStfxGCdQrkEp3PCwPve8ccB0JcuWa3ewedPBjh4g+cmh8GP1Kx2fx1oaEMwUSrO26C/etDK7zCT8sHSCSaBROczQAzM6v87F2zdxySCfXz+XeeEQFkg1AWz13mIqeHP7Nml+Io8VZrzPj00ONllwJbDxJuZlln728B6iNFWp8HRYe3aAC5Oqp8kJTmr5cdsIim18ukR3TuLuOJij3/jIy2YyjeroIbo1xorksgOtqSQgnnBokhDyQXCPcmcAO7UQDxr4OU/aq5LCkrjXrAmTHoQU0TSm0UOggm94se6Pwm8snihpfSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHy6mp+NEGo2hOmzSrxx92RMBFLNBrleL5zl/MSu9Ng=;
 b=RFckwbYox2pA+LFQtsOIulfFed3MwxfIq51EBe1A/BJq7xICb7fWnn1dAI+5hpwuSG+/xlCGfTG36Z6BWCXvS9ize70VfPJnUnlngXKlDvAAjhLNxPrW8oJ4G6FhPx7thVSqMUsmbEVd2+CLQr5NBGYf/E3jqDHvcVdUMhB6scL+Okg3ckdcr2iodA0dRXgn46+cfYEhdwSf7lj5XGoSzQgHWkK5Znwele/Y/4GZqwcfYCDa47RjO0zCbJAdyihg+0d14cik9QLqV+gY1bUVkPfieBr0g6NKzd/4FDVrR5atUWeXvfQrD0qc+eCOLKh4GfuBVKl36uJt2S9wsN1XLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHy6mp+NEGo2hOmzSrxx92RMBFLNBrleL5zl/MSu9Ng=;
 b=T29Q2Dkuvrs+pPMByE/nNl0RnGqhzykCVQVaOuGxM0lryUzf9vwT4wfZ+VU57Zcg6HuVG8CSzNnokhf7ihMRyyxa6L827b9l2dmVv0j2bEZcDc/7cmH3YNdU4mBeP+nRuWXtlL8aDZk0FCF5N0pUJFpIweGb+xxgocDq28EL5n5KZKCmJAHKeLh1hDgucYvFKOUlhslLDlebp9V5Y8SSbM6HguBRCO0epuEXwCxSi7vxKWk5XKyx83rTaM4AiXIxgMu8rbDMp0Bk8mWJ2kHsdmbo0dUv3agbIUYimt8SxO4tqdxbB7tiVRUMeUZdi/QpLUf7PZ0pGR5rIWVKJRdQ8Q==
Received: from MN2PR18CA0014.namprd18.prod.outlook.com (2603:10b6:208:23c::19)
 by PH7PR12MB6763.namprd12.prod.outlook.com (2603:10b6:510:1ad::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 12:02:34 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::53) by MN2PR18CA0014.outlook.office365.com
 (2603:10b6:208:23c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Mon, 8 Jul 2024 12:02:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 12:02:32 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:01:55 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:01:55 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 8 Jul 2024 05:01:51 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 8 Jul 2024 15:00:38 +0300
Subject: [PATCH vhost v3 14/24] vdpa/mlx5: Set mkey modified flags on all
 VQs
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240708-stage-vdpa-vq-precreate-v3-14-afe3c766e393@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|PH7PR12MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: 12db4ed9-2573-4fa9-e467-08dc9f45d938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkFTQWFTMnNyQTQ4SGtadFo4Y1A3cmRIanFKTjlacDhUeXRUaWt6VjBQMVl0?=
 =?utf-8?B?blVvd1JIcVYwdFo2YVpYNXlHeVFrcU8xa1Q3RGY1N2drbnpaUDVaRHJDNEdW?=
 =?utf-8?B?WGM0b2pNeFdrNEFuSG9EcjM3KzNONW9WTTlRcDgxMGU4cUJVanN4TWdGalZr?=
 =?utf-8?B?aTkzMk9yaWd5ZTFXK2FIc3FzRFArd3JobURabmk3d0grdy9FamV2bVNvRWxT?=
 =?utf-8?B?a2haV2Q2ekcwMnFMSGJLby92UUpvc2Ntc2M5VzMyODh1Tkd3OEFuVmJyWmZE?=
 =?utf-8?B?TFFWY2tiMlIxZ0RHRUZXNVVQVEtadUhkRWYzVFA5aGJQbDlxMHpjeWFTNlY4?=
 =?utf-8?B?OHpacmEvRkdJMUhqOUZ0bUx6YmYvL3ZuUktPeVh3TElPT0FEVzlEUEhaaVBS?=
 =?utf-8?B?d0hqUkRmbFVNcWlldE91LzRNVlJ5c3ZIeVJETndMaDE0QWo3RTFoSzFjV216?=
 =?utf-8?B?U0luRzdlb3Q2Ym55TEVYLzR3U0tCYmoyeXF5QXA1RXNyeG45Smh5L0t6SVNK?=
 =?utf-8?B?RjVzK0R4SUtaUCswajlFVG80M05tNURkcDRleUpWSlZNdW52ZS9td2dweWFa?=
 =?utf-8?B?RTllbTJtRWNrMVJGQWRXWVVVSy91SHdoWDdXTlAybE9LcnFRc3lCcDcxeHFB?=
 =?utf-8?B?UUpKVUZTekJjVk5OYWNBOU50UDN5TnM1TjFtOXZpcU1zVnFBSDI5SzdXbkhi?=
 =?utf-8?B?REZlNDlLWE5kY2Rla0FPMjZmSG5iK2c4Zk1Dclp3U1QwNTk2ZXcxNll0Kzdl?=
 =?utf-8?B?WUJUNHJpOEYxVHI1VzQ0eERKMU1wRnlPU1hkRHZqQjhpaURKbWxoSnhXbGNi?=
 =?utf-8?B?bW5PWkZBRlBaMEoxTGVwWVZDYTdEbUV4cVM4QjFYRElhN2ZHY2ZGMjdFbzVI?=
 =?utf-8?B?MUlnUmNHRm9hRk10dUZOQ0xMdE83ZHEwdmY4YjN6R3RNWmdxcFdDZnNmVnhD?=
 =?utf-8?B?clkveHVZZVpFbmJBYTUwclRIenJwYXZROVlNbytDb2VQUTJVTFNoaU1RamFI?=
 =?utf-8?B?TGV6dlgzeTZhVVUzVy8vVGdVV1laY2xVcHlSUDUvUXF6a0d2ZlY5QXErMGxu?=
 =?utf-8?B?TFdVQnlmWjd3c1VKaUl6M2pKL0ZoQ1JMMGJrS0ViaTROVnY3Qk5BRW91WDNy?=
 =?utf-8?B?V1g1VWdxejIrMFNidmh6Qm85VDl4dzlGL1h4ek8vV2U2RmpKeGZQMmk4MVFS?=
 =?utf-8?B?VG5PcXhkR1k4cnRXb3JBcXVEY2hPM2JtR3B5dC9RYTUyUExZTzNmMHVLRDJP?=
 =?utf-8?B?NjZWRFc5K2ZWd3VQODUvVzBWMTFrZHJER0Fxdm85dm0xSzYvNzV6WFRsZzda?=
 =?utf-8?B?SkNTaVVjWHZCSE5HL2tMb3I3cXZNK2FkYmJPcm1kYVlGTHpPVzQyemtROE1s?=
 =?utf-8?B?T25aS2tkZTI1dlh0T0RuRFVYRW93enlJZWsvZzRHcGNlbkpIWUhLY2llY0dz?=
 =?utf-8?B?NDVWZG1BNjBGbVFKVGtYLzRWK2xUTHFRTHBIek1FUi9mZVVTY3h4SXZTREpD?=
 =?utf-8?B?NDZXUXNVaG1vQkFrZUNpN2htU0dyeW8wSmszNWxnR05OMGNUVk90OEM5N0E2?=
 =?utf-8?B?V3ZlZHMxV3JpbFMvVHNMbjhDNWJaRHEyR0JBZC9jYVV2c2g3eE9aTHFKQkVj?=
 =?utf-8?B?bkRrTGdSRXhxbEdCVnhMUUhvKzdOWHAzaEx2THJDVEkzTS9EQ2FOS1U2THo1?=
 =?utf-8?B?L05BRytWV1hvT212aWZTVU4vcHlGdmRrNzlKN2w2MGRTREVQZVV0cHZuOVdn?=
 =?utf-8?B?V3pHZklpbDQwVTJRdHVORHdhbzFqcENrZE8velB3ZEVqNXpHUS9lREh5SmFQ?=
 =?utf-8?B?NjhzdnFhSmQ5WXp0RlF1eFpuMytCakxnTHIyaThOS0Z6VDU0TFB5Zm5vSTEx?=
 =?utf-8?B?VldWT2JubG5Ed3RpUHZKWlJYVDh1ckxKY09RRWxKNjBSWWswY3Z2QmNPaUVv?=
 =?utf-8?Q?lA8dBz19ak2HEBIXh4pAxtgzRJn6EHm+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:02:32.3680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12db4ed9-2573-4fa9-e467-08dc9f45d938
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6763

Otherwise, when virtqueues are moved from INIT to READY the latest mkey
will not be set appropriately.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 7f1551aa1f78..a8ac542f30f7 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2868,7 +2868,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 
 	mlx5_vdpa_update_mr(mvdev, new_mr, asid);
 
-	for (int i = 0; i < ndev->cur_num_vqs; i++)
+	for (int i = 0; i < mvdev->max_vqs; i++)
 		ndev->vqs[i].modified_fields |= MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_MKEY |
 						MLX5_VIRTQ_MODIFY_MASK_DESC_GROUP_MKEY;
 

-- 
2.45.2


