Return-Path: <linux-rdma+bounces-3730-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD44692A1F7
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 14:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6405B284D66
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 12:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F28E137905;
	Mon,  8 Jul 2024 12:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XhDDr+B0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7588A13D8B8;
	Mon,  8 Jul 2024 12:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440132; cv=fail; b=rl72wJ7NNw26ETwZ635ADchaNtLIlUTtNYcPgnBEia2gze8SIyfUpXS0+FI71efOvsXzRkrmpqSh74vOV+Df2WTdGliS6uRMyAofOEYZn3mEbNVIvCOSgAfkdYmdJ5oI+NG10G2TGwJr8ud7FC4N9L62PS8wmLAkN7jpeiq06Wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440132; c=relaxed/simple;
	bh=nJTWuacp/PSwLXmNgypOE6XPWF8/NdP5C298zb5GcC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=f4jbSwnyIqcpJN1m1uJFRbG9xy84HhWyL0ycVPBKmTVGkLIYIGMiiPyAme+Xvdfv+nRdTdsywful7Elsjq5YUuz0oSKYO8RthFkO6FD/hvtPOtqUm+9hQTgcgmmPOxMbckvGrDoKg52T1vwojUBb0bmM2Gf1RBEfJZDF69qglws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XhDDr+B0; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWUM8FRgR6cxgdmj571sWPBsEO3px/oibMDytIdDu/E1LxEd3BcTgk5qiogYg8xfW/C9pyPjxFA81Cf1TKGs6Ps+EICpGjcLhtp2nIIpq3bj0y3KY+hQ9FUJxWSdSwc5YWF+rjKqiqwz02P7Ac8MCh4UZvDC+VDYsgKDRVIuvC27RKmHdHVHvgGxsjruOqBBqQSGxByCWG6BlAjkkAmqwsO3r3T1EGom10jSxiVdCNml7334x3y8N0U6zAl1a1Vpn2+RXWNvp9Rsybr1woWOvJgzMOcI9GHLooAy/cpO0GRRR2T8i1J9XU2oJgRdo++SRxaeGd0pR82YyyljnqCNtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mniGeUGEPsgHLRktUjpUAyHPIq75TXH8m7Krz8Zo9Y4=;
 b=Iyj0OVVoIqzT/QlTjlWRZv4BX80NCSlw0qYH4peGT8D87jNzyu1ASZq/h3sNhMNHSeVQ5IfCuttoabb4w3t96T8UawULOwTZ0WBUSua2Jk7W5oBAjvlyGh63RVkEF1uDFmqV8U+MxwBKvhXb70Fs+J4ZdRfZ/Acc0aExcghoCxFm9e1nzp7uYsqwrWwH3nwNhxOuduFQR9z3Ss7Xq3mXK5f+ups/Oa+C97vt60hqvwyUJfwJcRHDCLMRcnPF9HXYhbztjCd5OWMomtoOBCLDAthxwbXFHxHbnO45j0h6NCYA6EXSk1aPIBsUWKHJ2NCyi2P2TC8b8rIpLJzqQ0RBtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mniGeUGEPsgHLRktUjpUAyHPIq75TXH8m7Krz8Zo9Y4=;
 b=XhDDr+B0pTscTGESM0vOgSyuw+Ff835vI7fkgsqQDB0wZuJvkTH6hri8VJ0SIqzdxUnjY4vwV2EhobImtxKD5Zoca8ymWf3szKGIwWad6s/a3K0C5DrpxtqIpbAOuKfM4ELZ7Vf5Q1vFEfjaOyjI+c0bGAHNubd/jS8gidmkTk/i9Y0Bdk/aRniu8ENkXoKGxtgKPqX7lhYj3+i4f5S/hlyfyUB9vWNi80EAyVRWKB00RGeGZEIWbpMOw6jy/z7yUByjDdozunmQsC3AT+hsV9t20hfp7BQLAmXp8jk0xU9yxXqVWQsxrcZDME0WwkvBH6BzNFecLRJJxmT9ybmOIA==
Received: from BLAPR03CA0007.namprd03.prod.outlook.com (2603:10b6:208:32b::12)
 by DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Mon, 8 Jul
 2024 12:02:05 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::4a) by BLAPR03CA0007.outlook.office365.com
 (2603:10b6:208:32b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Mon, 8 Jul 2024 12:02:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 12:02:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:01:23 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:01:23 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 8 Jul 2024 05:01:20 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 8 Jul 2024 15:00:30 +0300
Subject: [PATCH vhost v3 06/24] vdpa/mlx5: Remove duplicate suspend code
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240708-stage-vdpa-vq-precreate-v3-6-afe3c766e393@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|DS0PR12MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f256d34-44fb-4455-477d-08dc9f45c8d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnhwRUNFRk5nenV2bmFFZEZtTS9iT3RaSEtiZ0YzcVQ3Znd4cGdXVm02b1VQ?=
 =?utf-8?B?YTNtK2E1ek95cEg0YVRidXVmUndmNEV1aXBEcHdYK2lmMkgxZndNQkdlTUxq?=
 =?utf-8?B?a2lZUlk5eTVlUVk3bWdtWnVTcDlLSFZua0xYVGpTSXFGTUtheTVwTGVocVZx?=
 =?utf-8?B?N1JGMjZsYlR5VkJzYVF0dWdiOGJhbExNWDVreGlsZmNsSDVoTmxxNDFab3Ux?=
 =?utf-8?B?ZGh4U3UxWi9Ka2dXVkJTUEJTdEs5bXpIbVNybkg4RVkyemxRMWNyMjc2NWx5?=
 =?utf-8?B?emI5OEVuQjNvRWtURlA3NktrWW9RVWlqTytNL1MzK3luamZtT256MUFSMGtm?=
 =?utf-8?B?bDhLT3BHcW9pQVZlUW1GMlo5RFNreVhQMXBKSm9TQVRKeTIrTWYyMU9UMVgy?=
 =?utf-8?B?MEJmaGpLbC9PbmJJMzYxTm9JQldRSy9LUVJ1d21iQTBCczNjelNRUmVKcGhZ?=
 =?utf-8?B?NW5naFB4amtiRVR0Y2ppQ29HUzdnZnRQQUpBYVZ6QzJpNGt3dWxwZkRud05y?=
 =?utf-8?B?ZjF4VmR0S2NUTGI1TGRPS1p1eDhnZ3UzL1RYMElsMTc4VnBpc3plY3oyWkd6?=
 =?utf-8?B?cFVnRFQ5ZmpxQlV3cnA3MWYrd1l4MEI1N0JSZWJtNmppWTFjTVFwYnVZbmxj?=
 =?utf-8?B?NFdiSy9GRmJSTXNzU21DeklyY1FiYnJ5QnVxT01mZ2piWHNjblJmVDg5NTVk?=
 =?utf-8?B?M2hac2VSVUFwVE8xMlAyN0hzZGZld1J4Qlk0Y2ZEUmRyUE5EY25naE5nYXA1?=
 =?utf-8?B?aDFhK2tzOUN6ODVqbTMxc1BTNWR4SUxmR2hNN3BoUXlod3lSY1REdXF2aVJ6?=
 =?utf-8?B?cTJJNDJtaHplKzlSZDF4aTN0UnRWZGtqTXRTRE9VMHBhQ1huWGR3UWN1b0RE?=
 =?utf-8?B?K1RGbEhyWE9QeEhYTFN0QXJPNk9hRjk0b1czRUlKTmh5Q3Q0MVRhbm5RRXpy?=
 =?utf-8?B?TkFJRG51VS84K0RJaVo4aEx1UTNFcm1wUUN5TFBFelRRVTlHeTZUd29DaVM3?=
 =?utf-8?B?L0F0cFNaTUhENWEyL0g4MDdYdVJ6ZHJpelprZW13Q3cwTDJYVHpueDgxZ1kr?=
 =?utf-8?B?Yi9TbENmc05ic1kvZ3JtYWc2N3c3Q3FIMjAwS2Z2U2hDczgzL1ZDbHBOTkF0?=
 =?utf-8?B?SVh1MkVtdTAvdWF5dEJMNlJ1cEVEUlBRcUVCWDZQcDZrMGQzT1dWbXQ1ajhh?=
 =?utf-8?B?S095SENqY2xqbzUyRVd2TzBzTG5va1NDclZIWVdDOFZsOXRwTnRUb1N0Qkpr?=
 =?utf-8?B?T3FGdG11cys5T2ZZcVpjM2tGZGNwTmRRWlhWVmNEMXRUV2ljdWNKRWNtVHhL?=
 =?utf-8?B?ZTVoRVFESjFzM2dIUkNXUmpCWTI0RlFtSEo1NE9FSlpKSnY2NGwrZ3dFaGlv?=
 =?utf-8?B?UHptYkEyajE2SkNuUkEzZGovcy93Qk52U2hoUlFsYks5Wi9RQ0JDT2hhcnox?=
 =?utf-8?B?VjgrVjM5WFJTOWttSlZUTnRCSnM1Rlc5N3BhUzFHZWt5TjJ2WHgweVR6TWJM?=
 =?utf-8?B?ZGNvNnpENFdyMnRXMXZzTHJ5WnNMQXJTYnZtaHZNYm5EZ3FpajZTaEVtNlhK?=
 =?utf-8?B?NFo3T01vbmdUVCtaUTVJUmttY0NvYmY2TTRncDFSWVFPTk82OUxzbmJjY2Nt?=
 =?utf-8?B?d2N3S05IY0t5WmNuZVdLVU1rTDFqMTU2ankwSWJXZm9CWS9NUzcyZ3lZemJY?=
 =?utf-8?B?akpLVmhkeW9Bdk44SVR6MzYzUDhSeklBMVpCYTM5NVlRaVAvKzgxVDlrclJC?=
 =?utf-8?B?MVRjV0pKem5hWXdEZVFQTCs4MWNvTzlxN2hONXVLWnlndlZvbVhJTTA4bXpH?=
 =?utf-8?B?cTM0U2xCVnY0TmZrRGx0a3kzL3hxOE1PcmN3TG56R2c5N2VwQkNVQnpJNlBZ?=
 =?utf-8?B?UVFUcTR3eDNBWGdmc25MeFRFeDN1SzkvM1pmbzlSS0xjbTlVZXJLTGdjL1M1?=
 =?utf-8?Q?yUXUVRzM6SRw14VYSNfNg9+h9jvDaMX2?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:02:04.8873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f256d34-44fb-4455-477d-08dc9f45c8d5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6440

Use the dedicated suspend_vqs() function instead.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 51630b1935f4..eca6f68c2eda 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3355,17 +3355,12 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
-	struct mlx5_vdpa_virtqueue *mvq;
-	int i;
 
 	mlx5_vdpa_info(mvdev, "suspending device\n");
 
 	down_write(&ndev->reslock);
 	unregister_link_notifier(ndev);
-	for (i = 0; i < ndev->cur_num_vqs; i++) {
-		mvq = &ndev->vqs[i];
-		suspend_vq(ndev, mvq);
-	}
+	suspend_vqs(ndev);
 	mlx5_vdpa_cvq_suspend(mvdev);
 	mvdev->suspended = true;
 	up_write(&ndev->reslock);

-- 
2.45.2


