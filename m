Return-Path: <linux-rdma+bounces-4748-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D4F96C278
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 17:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97EB41C21AC0
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 15:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B7B1DEFFD;
	Wed,  4 Sep 2024 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cRp4W00s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960BC2C95
	for <linux-rdma@vger.kernel.org>; Wed,  4 Sep 2024 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463875; cv=fail; b=XwMYtjK8LG360IDFevNHxVvEaGHN60/JMOQptALqML+jRogrNu3GFSe2iLQ7RcmjqG17iYwiYkgHASKaDthL6F9Sk/6/qSj7vD5aI/Xxr3UT33SBYklQr5ZKjYMMAjvr2bAV/69sOdr02I2KEqq6NnGF2B5jmHKZuBPgdO9yibo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463875; c=relaxed/simple;
	bh=XfGdmeJwrAdNQXtVJ/wcJICIKVlJzEmIZ4IS2AjexXE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kNTv3hG13S4qtbu1iEoKfYnO/HNEXViovEW+2Dd/tCRS73yEcJcOLjslFQAcFJwNFy+DcXwfpKzrHHp2WILjB1rX3KyTXYCGl3WS33DdBOuUlUbc76KBE1Erhtloi07boiN6CkPcssjvLDEGEfOLhvC2P4WviIRCvEy+3u0BJIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cRp4W00s; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSb1yZDKt4ny4sSm1pfb1JZugnInpiagOgIHF95JAAoueYh4/bpejHQ1wK0Hdj44bbV2HPrpGbx41W2ImyScAc98TefEvbv/MPm0c43cSv2mDE1v1DBG8g6Qc3YCLkfOAPR4c5GlEPP4fetX/4cVWILtYvlCYBs+/hr2iunEnBwPQu+TeweTP+EJykNhAzrjkS2rRnoQ4MSBr1K51CLVbKDeNhSFSP/PNF6x2RtkZXJt94bpSt9R+uM5o6ZJgo/SmCrbT90EULKWOzvxlFQDnq7dr29/PoK87ANZ+oS1Buq6GNDJBVpMrofGNVRbGhlTYqqJjFM+1NLfBL1DLSDt6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5HqaHeN2EHybHDUbaqlvfUmjZvJMB5U5BsFxBHNYks=;
 b=iJWAP4+W7dkAMcxlObpQzzsP1rtLQutk9xgP6SeBWY4Rg56DpWaNe/a0a9Jb5vald7I2EA9jKY3ZSsFNsg2cFyyqqi4xWA9sd7KrE0MjsGJv/sYi54ZYuEWycDt8MJIDZpKTbJfzYf/7sLVcpiki4h/i5j4CG8QPip1DajkwEkwBX0DgrEt89n+Dp9C6rsd7FoJlLV+HxAqYPkkwtd9CPc9S8p4CR2/dRNZv+CTEKJsS5DhnXxt9jmaNhNoXL5zwUbY9Bwmnd0GsVutTw4vJqMPIE6yQwCriPbNzZuU6G0zDc793ruKH7lnOe20kGiAfs+Zy+/eosZ/t8IaCqJWrJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5HqaHeN2EHybHDUbaqlvfUmjZvJMB5U5BsFxBHNYks=;
 b=cRp4W00sW3wEA5L8Y7RMbjoaA2d6kfVr+oLn6k2GHTXIkUjQhBv9e+VmgJ/zQqQwIf7VMJmHq8dhRxsKdkWTUJGFWY7/+P2s+4NzNy8u6ZNlpFJEsEEUIwPgpOnE1+w3gQxGLUXgmo+StB/6CJhf61X+54/3hUaaIXanIwM+hq1dgrMPnTax416rPIYbPmjsVd/GigHInWiHFhzpHeVvBMxz7e8s8hq4fwVINnEQ6nyzX3xAjAtQnuWTqzGjAqJLT7v51uOSqcxYlv1nRVRHzhBvySCXxPt95GKZHM58tP88NcAEaIt7BWjcpzgGu3qAgPSB8PUI2BthLay49vmwHg==
Received: from SJ0PR03CA0073.namprd03.prod.outlook.com (2603:10b6:a03:331::18)
 by SN7PR12MB6743.namprd12.prod.outlook.com (2603:10b6:806:26d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 15:31:08 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::c0) by SJ0PR03CA0073.outlook.office365.com
 (2603:10b6:a03:331::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 15:31:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 15:31:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 08:30:54 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 08:30:53 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 08:30:52 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <leonro@nvidia.com>, <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <saeedm@nvidia.com>, <tariqt@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 5/8] RDMA/mlx5: Split ODP mkey search logic
Date: Wed, 4 Sep 2024 18:30:35 +0300
Message-ID: <20240904153038.23054-6-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20240904153038.23054-1-michaelgur@nvidia.com>
References: <20240904153038.23054-1-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|SN7PR12MB6743:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dbccf17-48ae-4968-2ddc-08dcccf6994f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vtkjw8imDrpH21WdLH84Eo7NL1kKvARZ+MkINW+9YrgkvzkieMIXVeUEk7pH?=
 =?us-ascii?Q?natGIhNFCsLjiVxRMYclrSgvS2mE/jbnY4FoByHLitEYpCzsq457fgeZ1Hct?=
 =?us-ascii?Q?CvYR+7iiPLPekUD+WsYqSpaMI7gjws6ghMjcRYIIzqmZ6YwUrv8QUOczkjjh?=
 =?us-ascii?Q?mrCejqWCsFSqrG0YpUB3aX20F0ATs3Xlqlpb8Y9NFgSKt/IuM1nkPQnFVUYD?=
 =?us-ascii?Q?FKBo9cDpGqsWPZtZaF5N05y33BcO/g1NHtPoX2dAkD39yRgsxzHHMWGVtz4K?=
 =?us-ascii?Q?0jqYQJaqvOAbfTbEl5kwtP5tni18NPPO2GQHsOb7sbEOuaL745rPel9uS9Pr?=
 =?us-ascii?Q?skKv9qpw1v5PN0GbtkfFEMhNXi0EuemlHIZLQGn65i7nI2sKxBDGW6oLki7L?=
 =?us-ascii?Q?4hkGRScwXH17xYL85mObY9q0naX4MFHOUxC6bKGpTQqLyc2rFiKohGnEX7pP?=
 =?us-ascii?Q?Y/fmVseSZ9vkOB7obmhdw1Dn7Y1si3sptd3Rj7+N4ZK1VvhmQnKYY6pDCLIA?=
 =?us-ascii?Q?LUsb8znS5Jb7jHNi6TcfQduI80FuyT6UWdzCvBTgquVQ8xPJJg6ahp33cTyE?=
 =?us-ascii?Q?i0pFWWiCy3ykMta9qUpXcMSNihOhnAWF3pXt7BjbICDPzSCUlRwvLEyrYgwa?=
 =?us-ascii?Q?0APnX2PJpsQsxD/ikxiID0LtFlapD+Bi/uxgLx7Wysv12j7SDIHv8BdKR6Pv?=
 =?us-ascii?Q?b44HzebrgeJ2IO0f/S8dW1O1EIF03ix7EOeQPLsc0QVHCNK+QxaDKRvI5XJe?=
 =?us-ascii?Q?sOjHo9hhoYciSz7I2VrBaVB8jYlE3IyYirupT1lXwmXwV+NS04FcGesg8S5Z?=
 =?us-ascii?Q?bECHsiKbj7h/WJyhT7iU4+/64RWJo144bhUOpexe7vQJnE/xiNNYt5wMt9sy?=
 =?us-ascii?Q?Rzg0NYXsoQOMXY0evrN8TboV/uTJcuH1KUNdiNjs1GCNzlEAvlbnC2j+qQ87?=
 =?us-ascii?Q?mS0eO4jcQldvm+BkPukFSQc6CrMtE4xBKwATwPHsoe4hfXWneB9ykYJfTBZK?=
 =?us-ascii?Q?D1v1AwydTycqMRO6q0jhvpDmD9SSKEAU/WQQi7Pcqdkv7055iQDDM89zcv2D?=
 =?us-ascii?Q?S5QJVgWWWAnmjud3hA6lVbqDwlMrOGJ0bh5JIhPAyE0fZDUGDWqFBhDNfhwt?=
 =?us-ascii?Q?+aURIpKNVsoJ2iAu1xM8aEWGDo42GDVlztKerVpOlGvMiOB4nTd1MP/ZZMIh?=
 =?us-ascii?Q?0qPdWzPw7IihvfPb8+qEFiCwKzZ9IoxZ3Tb7Ny8QhgwiyJKPnVVNFrJ/qwHR?=
 =?us-ascii?Q?WE8HVs+DOWKWpAu+rBtaE/hhjC3HU1Ri8H6Uoz8gFDhUxgmWqaeU8hdXHCwv?=
 =?us-ascii?Q?c+mfkAaECUdtBdKCknyDfJ6PlfAjpwklTt1urxrP6yCwXZ6wS+/i5X0ErKAM?=
 =?us-ascii?Q?JsnfLXFwu3CzgMZTT0Q2ljKlFrhkAeuhpwZ/dDF1epTkUnPkReimgYdUuxRr?=
 =?us-ascii?Q?qqJ4z4sKyie5wBeM18sd8+6cwbCOUx0R?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 15:31:08.5579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dbccf17-48ae-4968-2ddc-08dcccf6994f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6743

Split the search for the ODP mkey when handling an rdma type page fault to
a helper function, later to be used in other page fault types.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 65 +++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 20ad2616bed0..05b92f4cac0e 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -819,6 +819,27 @@ static bool mkey_is_eq(struct mlx5_ib_mkey *mmkey, u32 key)
 	return mmkey->key == key;
 }
 
+static struct mlx5_ib_mkey *find_odp_mkey(struct mlx5_ib_dev *dev, u32 key)
+{
+	struct mlx5_ib_mkey *mmkey;
+
+	xa_lock(&dev->odp_mkeys);
+	mmkey = xa_load(&dev->odp_mkeys, mlx5_base_mkey(key));
+	if (!mmkey) {
+		mmkey = ERR_PTR(-ENOENT);
+		goto out;
+	}
+	if (!mkey_is_eq(mmkey, key)) {
+		mmkey = ERR_PTR(-EFAULT);
+		goto out;
+	}
+	refcount_inc(&mmkey->usecount);
+out:
+	xa_unlock(&dev->odp_mkeys);
+
+	return mmkey;
+}
+
 /*
  * Handle a single data segment in a page-fault WQE or RDMA region.
  *
@@ -846,32 +867,24 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 
 	io_virt += *bytes_committed;
 	bcnt -= *bytes_committed;
-
 next_mr:
-	xa_lock(&dev->odp_mkeys);
-	mmkey = xa_load(&dev->odp_mkeys, mlx5_base_mkey(key));
-	if (!mmkey) {
-		xa_unlock(&dev->odp_mkeys);
-		mlx5_ib_dbg(
-			dev,
-			"skipping non ODP MR (lkey=0x%06x) in page fault handler.\n",
-			key);
-		if (bytes_mapped)
-			*bytes_mapped += bcnt;
-		/*
-		 * The user could specify a SGL with multiple lkeys and only
-		 * some of them are ODP. Treat the non-ODP ones as fully
-		 * faulted.
-		 */
-		ret = 0;
-		goto end;
-	}
-	refcount_inc(&mmkey->usecount);
-	xa_unlock(&dev->odp_mkeys);
-
-	if (!mkey_is_eq(mmkey, key)) {
-		mlx5_ib_dbg(dev, "failed to find mkey %x\n", key);
-		ret = -EFAULT;
+	mmkey = find_odp_mkey(dev, key);
+	if (IS_ERR(mmkey)) {
+		ret = PTR_ERR(mmkey);
+		if (ret == -ENOENT) {
+			mlx5_ib_dbg(
+				dev,
+				"skipping non ODP MR (lkey=0x%06x) in page fault handler.\n",
+				key);
+			if (bytes_mapped)
+				*bytes_mapped += bcnt;
+			/*
+			 * The user could specify a SGL with multiple lkeys and
+			 * only some of them are ODP. Treat the non-ODP ones as
+			 * fully faulted.
+			 */
+			ret = 0;
+		}
 		goto end;
 	}
 
@@ -966,7 +979,7 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
 	}
 
 end:
-	if (mmkey)
+	if (!IS_ERR(mmkey))
 		mlx5r_deref_odp_mkey(mmkey);
 	while (head) {
 		frame = head;
-- 
2.17.2


