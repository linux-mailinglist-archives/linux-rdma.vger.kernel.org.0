Return-Path: <linux-rdma+bounces-18396-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHFzHc/qu2kKqQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18396-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 13:23:43 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A20F82CB1D7
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 13:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9325B301E49A
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 12:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2503D1708;
	Thu, 19 Mar 2026 12:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RCgOmO+E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013026.outbound.protection.outlook.com [40.107.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E33D3A7828;
	Thu, 19 Mar 2026 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773922984; cv=fail; b=W5Ll3+u8kKaSPh6qOBliQn21NmOori6fagkP8z1VF3kxafGLNCzTmpi+4Nxed6mBRpE7/ulmc3ttwVQrCLYlX53W4MqbO/JgD8jmmCO877lVJuZGTQHS6KqCBeFoGibk1+2n188mnIGV5J1Hst82y1K+9mtRHULDXVW99AGE6aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773922984; c=relaxed/simple;
	bh=NcLIBMenWxBTo4xHdUo7XwP6Ssh9vJJEX52JPGWyEks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fbO4djDEvM6fWmxQSDukOD5pzF2sx8fLXxMI3eVF+z5ZmpFKfxLZOSfkapM7SuvAnE6vtR6EMqqAIP7GJ5AQdLrSGXYFp838KddJ1nLhZkF8S9fjEXegL7aPOdwYT5NGFJpN/XFql4T8gOx3fF18cXbm/SJE6/ID1MJPS/qc0GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RCgOmO+E; arc=fail smtp.client-ip=40.107.201.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCxho5PmrqLWtVcJWphzrL2Ke90dnAFdOE8munz8C/esbU1rdq9z/ZlUx/v78vSHbfLePJMTcs3/GZsmQkfkrZ81xnXgie2vIfzWqSrqCDgybwc5a9JV//qtWuT5xepJF1hBYJknda0dz+VW9TRh4mXhZ2vbXFEUNX3NhmkfGRdJ+jzvdJdTjQFSCDDjY46MQyyTAyIX7tIhmiQ/196XPcyjpq3X+5QsqRUTLnxTYF/eMp2eGT95WPF3NwPEvFHYpyeC4epPfzo8U1ulf2Qc9RbTl/mzPrq7QX+acgGZpU0fO6Og2yG/C2CEcG9x0JZiPlAnHl16YVPihtHVeSsukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2MCtm/472KloznikF2slJBJRkJ4Y8B64dKVmkjDcwE=;
 b=aBXzlj1xU5cbswkIDLPin04tlYY5YwTGDLvQIlQPFHQqvWjfnYA/vEdn76G0LIGk2hI5bhpeG9hZXsIjOpmt/qjF1d0P0jqk4bPiA06LUfqYl4aYajiac2SsVDi7W7Wy2kb7rcEcLZmBJLCsU9Fe7zl/HI8GFFB6gglVMaqKuz6S/CIpvkZygvL6Ea0Rafo64OTVQyPR/V17ddPqJeIfcCIgdqV5crArieSME0pCBRIYTfO7uPrjdtzHEzgK/RvTVDQ2UnvV4lOAWQbz/2G8khdJ0TfbrRRD4KveYVtr2zoR1jn2zQfrKK72IIk/26AAdHItQ49kt3NyFr9ZBQIMUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2MCtm/472KloznikF2slJBJRkJ4Y8B64dKVmkjDcwE=;
 b=RCgOmO+EgiZjTUJdZNF+j3QVqF8rqBU9qPgux3a/Q5fbakLHM8HSPF/Uwsqztlola2W9SV4DSxtYbs5XNcYst50EEuFy9pyff+8WzAhFB6e+9fHiwfZrYEyB62mTnw7QzH0mZmfN+ntgVxdY+yN5FQvdzYNoYJ+i5Ijvc2sp3nAAOPxVZ4knvdvvstNFLrjbP1xGoqRhhIsyoKcLBI1t/J7+qrDHl/QSR32rcyESOECLOp/JqKSUCgHjPUuToyJmUTxQieLhHST5RF72mFeqxpzyYVa825BHQ8GiBNq69ctrqW1QrK9b6pSNhJGeXJt0Ihh4BZsOgMpwHWhilrGimw==
Received: from SA1P222CA0179.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::9)
 by MN6PR12MB8566.namprd12.prod.outlook.com (2603:10b6:208:47c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 12:22:58 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::f7) by SA1P222CA0179.outlook.office365.com
 (2603:10b6:806:3c4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Thu,
 19 Mar 2026 12:22:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 12:22:56 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 05:22:50 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 19 Mar 2026 05:22:49 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Mar 2026 05:22:45 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>, "Parav
 Pandit" <parav@nvidia.com>, Simon Horman <horms@kernel.org>, Shay Drori
	<shayd@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Alexei Lazar <alazar@nvidia.com>
Subject: [PATCH mlx5-next 1/2] mlx5: Remove redundant iseg base
Date: Thu, 19 Mar 2026 14:22:10 +0200
Message-ID: <20260319122211.27384-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260319122211.27384-1-tariqt@nvidia.com>
References: <20260319122211.27384-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|MN6PR12MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: 94fc481a-a0d8-4d67-7621-08de85b24069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	hZfu7C4JsB1EntjFbxTp8qRV3LCFhfcm4Uh+NMbYnYeaQGHKp0HGqFTPyffi4b48DedUgR3yTpD74SoKsujbKxK0MA0DWegOZTAky163kASueD3mvR5gcx3st7UMgpnOKKwUMCaODdw0ZfMMyK9/oAF/AcmeXbjkRj9iosNw/XqmeW0I0kehmivwwWyZD2kxsrCGWmnIvooHpIqI2bTdhwqUAyD3N7W3Z5q67jABhfiK2yF1OI8upWrSEsvdXnEJwXhkIx70/di6Ysumfk8ieeu/p02ncEmxHPqEfpeCMALTN+iTH6hPZlwzPFgUNrrem6ihJGeMsvTUixY9fj7dVzAxFjrhhlSfdIC3ynTTrvFUZKor1lIeAE60wiu7LMXUYOUnPMLVWJtqhRIX2eYicyfjMhKise5+scrO8R13t6bRy3oFaFNS4iM6CT4E3mdsfwmUf2Yndc7+wvlu7TksGf/yUpuMs4EPZ9DeIpbsmKZMaItmW5jlF/YFvHCmMW48UYS6K26nZc+/GDlkamTAoJJaCWXupXLHyVNtqx8vTdEOm2t9oJwS1uE4TqZd0DibpZxg9fMMGexApiuE4Ksoo7w8f36LFNYhYvCh62iTy+NDY6dt7k1oLqzsroILlvHYncxpXn6X/Ib4g5uXs474QaVTTHejlzkwPqRKfUh9CWT65qmFXR59n89UBycSafgOK8d6XmHRnlzL12qaVfvPq3lUuM4b6gMnXV/W8Un7gosAQs4bJtmRCdMC+PlfdAnsX6UijJcr2DUWfxbmIuxK0Q==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ctp6kdyNEJ9/i7VjhQmf2/JOcHPoOLFmA0WSfytpoGvki3buwPfmJQE/TCWxIATHoPn4skrCdMSxrTDCDc8h6TNU0+S51lFcypxTTo644b3wmmN6ppZXC+gXkhKmNPoaJzewqp3YJNxgSua4g2pruK6eIUltW91rvZx04idpVMlsV4wSEAL08fbfZQDK6o9fhiajl0pPD55aahDh6U8X6F0IS7E5v40gvFNotqSMJ4zde6ibrOjVyMyQpqOCzz5mhT4rRl6ZgBCTwnxeVBKGl0WtFU+GT5T1rjS+Ak6v/OfMLkAK8z6mIZ10wlrPqrDxCPIJQoyQLF3B30ajwOzgUYQbfljwTJKR1UvF1IeVXzolXH6jQEYfn67JgIDUlpBvo+rrGO4c5fv7655v8UB1vy13/Ve2Oh9JNTh84uaZRPjFMGbNb5thpAdc/bUOB/DB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 12:22:56.3090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94fc481a-a0d8-4d67-7621-08de85b24069
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8566
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18396-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.967];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A20F82CB1D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Parav Pandit <parav@nvidia.com>

iseg_base and base_addr both point to BAR0, making iseg_base redundant.
Remove iseg_base and rely on base_addr instead, reducing the size of
struct mlx5_core_dev.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c                       | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c          | 3 +--
 drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c | 3 +--
 include/linux/mlx5/driver.h                             | 1 -
 4 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 9fb0629978bd..5b8987ddaa8e 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2740,7 +2740,7 @@ static int mlx5_ib_mmap(struct ib_ucontext *ibcontext, struct vm_area_struct *vm
 		if (PAGE_SIZE > 4096)
 			return -EOPNOTSUPP;
 
-		pfn = (dev->mdev->iseg_base +
+		pfn = (dev->mdev->bar_addr +
 		       offsetof(struct mlx5_init_seg, internal_timer_h)) >>
 			PAGE_SHIFT;
 		return rdma_user_mmap_io(&context->ibucontext, vma, pfn,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index b0bc4a7d4a93..661b211eeb95 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -950,8 +950,7 @@ static int mlx5_pci_init(struct mlx5_core_dev *dev, struct pci_dev *pdev,
 	    pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_COMP128))
 		mlx5_core_dbg(dev, "Enabling pci atomics failed\n");
 
-	dev->iseg_base = dev->bar_addr;
-	dev->iseg = ioremap(dev->iseg_base, sizeof(*dev->iseg));
+	dev->iseg = ioremap(dev->bar_addr, sizeof(*dev->iseg));
 	if (!dev->iseg) {
 		err = -ENOMEM;
 		mlx5_core_err(dev, "Failed mapping initialization segment, aborting\n");
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
index c45540fe7d9d..4391ef0bab5d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
@@ -37,7 +37,6 @@ static int mlx5_sf_dev_probe(struct auxiliary_device *adev, const struct auxilia
 	mdev->device = &adev->dev;
 	mdev->pdev = sf_dev->parent_mdev->pdev;
 	mdev->bar_addr = sf_dev->bar_base_addr;
-	mdev->iseg_base = sf_dev->bar_base_addr;
 	mdev->coredev_type = MLX5_COREDEV_SF;
 	mdev->priv.parent_mdev = sf_dev->parent_mdev;
 	mdev->priv.adev_idx = adev->id;
@@ -53,7 +52,7 @@ static int mlx5_sf_dev_probe(struct auxiliary_device *adev, const struct auxilia
 		goto mdev_err;
 	}
 
-	mdev->iseg = ioremap(mdev->iseg_base, sizeof(*mdev->iseg));
+	mdev->iseg = ioremap(mdev->bar_addr, sizeof(*mdev->iseg));
 	if (!mdev->iseg) {
 		mlx5_core_warn(mdev, "remap error\n");
 		err = -ENOMEM;
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 04dcd09f7517..b8b5af78284d 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -755,7 +755,6 @@ struct mlx5_core_dev {
 	} caps;
 	struct mlx5_timeouts	*timeouts;
 	u64			sys_image_guid;
-	phys_addr_t		iseg_base;
 	struct mlx5_init_seg __iomem *iseg;
 	phys_addr_t             bar_addr;
 	enum mlx5_device_state	state;
-- 
2.44.0


