Return-Path: <linux-rdma+bounces-12887-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 916E2B330CC
	for <lists+linux-rdma@lfdr.de>; Sun, 24 Aug 2025 16:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D36441F23
	for <lists+linux-rdma@lfdr.de>; Sun, 24 Aug 2025 14:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0302DF3C6;
	Sun, 24 Aug 2025 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F6DTGXvu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A5F2DECD3;
	Sun, 24 Aug 2025 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756046958; cv=fail; b=sV/ZotmgwembjbCIjtdRgi/SpsuSniWVO1i5fV2VS4CRyYZJ97bnV1N7qdfumCssWotzbXa7L3Zo2MnOBGblfAXghy1qFbPNS+0Jhr9jxnhrmw+VGuhGcOb5Co3MF6yk7U7HbJrEHfPrE67OyluAC67IpBMTtOVvipq+L+yn7yU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756046958; c=relaxed/simple;
	bh=Fq/F2VQT9Qhhu3xRijKVRv8KPfRxWEZmKrPN9fu5t00=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kjOltcui1xl9+0tAKXs3ay0YJJ1IRZ8dIV7wMdfl2gAD+pm4JczCzX7PcxSOoZZiQpsIgT+L9QveCdLq5XUZToT+7RSCsNveLvEqoehVN4VwSIlNNInVPkaj3JXpDtkDmrxFAJCjDG0kfZBCE0Mvvzok7HsVFsD2U9Qn+xPUpAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F6DTGXvu; arc=fail smtp.client-ip=40.107.212.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKHAUnKyCAnvIbXagG7hKB2PbaKqJLNQ3QFGt5NKShohHmZoLp9dbvthTSsbChLhks156CHC3LLD/N5Z/St0cVWVt4G0RzLhDayRA8B7kBwiXXH/D4jd8u+ggtcfmRWPc6n283n5uCJ6qwVCAzpzvHkLG430brVYtjDkTwEDQvgA40m05G+Xnex1GNJ3peXT7g/xoifx7auv4InokUALK0NTZeQZ3e70aNfLy6k0a56i7/GCE9srr7xaK9MaTk0c/L7RVNZLDk+9yl1WJvd0k4Uy97Y1zd0VMYlSwCdDVdDcorcQDFg5X+stbEEFuKCgOx2uwW13xmvPVAa/vK5K+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sx/ZBxqp1qFK/7vHeYOxHEYU1zg6OnUssf1Ew4k+SHQ=;
 b=hsl12zvNQFwOIjrLfc5cMIbLl0XDPyChyHaBhO8xcyCe3XE8ehcFzB+e54acIAoXIbWhzQ57viiH4fPC31+lue660g6U157MNbF8quV/TxhT1lHsEHvzT+V6hNHAzPB1T6XSwSBDqD2+QPBqNSg0XoRN449kbRmsokD5wT0IfCQuHSnhJtw0W3uWQOLIDjYJ0Tlrfd8weOKddr5+4M/Jm4oNSAzhLGM+iaiHLNAf266HvwDw5GYZAiQ+gUiVLPgsNLp182+lkW0s8eJ+Xyed2VHQ6p4yOvIYsvy6L21sKVaK/4CrnEgLDdY74tXR5VAECmVOgMT9PQV60N1QDh2kjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sx/ZBxqp1qFK/7vHeYOxHEYU1zg6OnUssf1Ew4k+SHQ=;
 b=F6DTGXvuaDicLRCW+7qpknYbgiXmfLyMIIRI+FQjR6jJaKhl9DY2nVsv2ZX0+ilYkqwsHxpKNpxJhg9h1yoA7+XUwFCP+L+1RDMJY3nSG8WyKvbHuMYD0WLrJ6fhNznGUjTlgTGNx4qkY+5tXScIxUoFwLo/oxzjypZ/bpS4Uk2IGm/v/Cnf71Ko5blATNj0A0BDYx4U2h/t7ihkCuDshi1eW/Vl+4F0PGUBJQ3vY+ubZn/1pCJq6yZZGYj/sy7Q5wP3Qrebu57Iz0frOW/5WbRm6kA3gd5V4hD96ZGShyz7pDRmQf48tzsmMnsdU459H77JniMzlSVFzz7Ybr3UqQ==
Received: from SN7P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::7)
 by PH7PR12MB6739.namprd12.prod.outlook.com (2603:10b6:510:1aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.18; Sun, 24 Aug
 2025 14:49:10 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:806:124:cafe::8b) by SN7P222CA0022.outlook.office365.com
 (2603:10b6:806:124::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Sun,
 24 Aug 2025 14:49:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Sun, 24 Aug 2025 14:49:10 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 07:49:04 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 24 Aug 2025 07:49:04 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 24 Aug 2025 07:49:02 -0700
From: Edward Srouji <edwards@nvidia.com>
To: <edwards@nvidia.com>, <jgg@ziepe.ca>, <leon@kernel.org>
CC: <michaelgur@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] RDMA/mlx5: Fix page size bitmap calculation for KSM mode
Date: Sun, 24 Aug 2025 17:48:39 +0300
Message-ID: <20250824144839.154717-1-edwards@nvidia.com>
X-Mailer: git-send-email 2.21.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|PH7PR12MB6739:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d9ee1a1-8be8-4f48-49f8-08dde31d62c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GEUkj1s3S26QD06oJPQq8sMpWpNAAZYf3wmuw6Y+t/FeaYOooauHljHSinHF?=
 =?us-ascii?Q?zKfaq6uUrnWjjhr2+MQPh+oaz/Se+7nCnahml0muGdOdI3Hplwt4kUv6dNWW?=
 =?us-ascii?Q?kJCdGw0nsbazpqI/Mr0qSMW7cNFcYc+q52gvGxRd/jg7DGlLXSvFYjJX6Z7z?=
 =?us-ascii?Q?CtTHpWypNE684Bblkl861W9V/o0sSaruT9IOM/Q654zdojB/ZfpjL+T4j3s9?=
 =?us-ascii?Q?XAgYnUU88oh817wor4rIL3lgREcdfo6Nvfs/QfCpf69dTDwos7Y0B+3mFK5r?=
 =?us-ascii?Q?zr2RwLrdClyFgkRD+YagLMdJAPiCO5a02N5734++vwFEkWx3kVQlwLg9oi+J?=
 =?us-ascii?Q?90DDWeTM9XQqH4wGMbr/L6ATmtogd1n2XEWXC29In5SIYMeHzogZgIFX+6Et?=
 =?us-ascii?Q?QxKcGq4l2xnVA3229sHX6r4+/+8opTwHTW+Ix7ijLK+ZnChQJTDPHIXKizqj?=
 =?us-ascii?Q?sLNkJjxwvB81PsKllE3hFAuQXpmvv7qSK13+E/BPFIdONEhUfe66qzX4UAyP?=
 =?us-ascii?Q?Eimj4jI6e84ywWpTPF0PoCEtKDXnYoJDOH9Hkcgxdb7yDJ3EQobMdUJeifBc?=
 =?us-ascii?Q?rJxp8Iro9uWXYw5WNurg/1QVDCLV/u7zomUbTEfgQYYUZxJOrv0XpG0oyXVE?=
 =?us-ascii?Q?aWFFwkbvvDmgVeQxrcqAstkVd+xzetbqKJ9S6ByWI+ac4BXv32R7lJ9JHUxT?=
 =?us-ascii?Q?WThG2aDdnYNSuN5nQ2oZgTJtKnp0mu/Qa5Ptu57OAB3VZF0xgKOgUO8SMtEV?=
 =?us-ascii?Q?64phaC5LYrhIUU0GozoOlX3iIfwvVs+XINc48BKOifrIVAUg7NyXohw6nwZ9?=
 =?us-ascii?Q?yo8CEZDWHkqr381VklqwmeCej2wMFUOttB2j+ST2OzSpzcBreCHBl7IODjYJ?=
 =?us-ascii?Q?C4NHaI7cLvqszLXWoadPubYK8a/g5B7mbnw/VG78jT6Gb8PaQcADRFEaQHN4?=
 =?us-ascii?Q?Dm3BpHom8wGKuVUQtKJgPnqJBcPac783e/N+3nVBf1ygIf3sHB9Ixid9k1XA?=
 =?us-ascii?Q?FuZMgP+hib2psQApktYNvroPjW7UGwM948jSVQGt+7Ubia4/l2yApfuDrn0+?=
 =?us-ascii?Q?EL/6bf5VK6KC0+tDLyDa4iRQRS4ojgo5vp+Ao/4+Dh+dl0oYSl34PgGz9Cfo?=
 =?us-ascii?Q?pgpRhB0zSuP6/yzvnHFXr8puLcyRa7x/9nIWJ6f6RANOd8eegWAWbTlc63n/?=
 =?us-ascii?Q?TVWcNvo8KVK6ZfFWEpKe8c5iDhHEZI5zI3IdXD4gGLWeehkPk6pQeu/LdTUl?=
 =?us-ascii?Q?vJyb6h0R9NV89yB5sFSu1MoetBMwUs3jF0YSG7ePg5XwAIx4oFCcDEBzBfbz?=
 =?us-ascii?Q?KLLCaelBtgR3UnMWjQ3c74QAXVaKeZhb/VAkzZRYb0XvbiW7YU+LmK2n+DOf?=
 =?us-ascii?Q?XjjKJ2fynTexMAS078rq83A9pLgrELbSyTTwzI24CIhMYu1NkxqpCAr+FNf2?=
 =?us-ascii?Q?V4AO58KBu5Z2Nd1mbFnDTcVN7IMg4zS7X5nT+nZYtCYkKDvNrjqi8HgHAS2l?=
 =?us-ascii?Q?Q4ryU13MK14JuTNJr+BOubeAMIzfEHZewlDy?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 14:49:10.5947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9ee1a1-8be8-4f48-49f8-08dde31d62c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6739

When using KSM (Key Scatter-gather Memory) access mode, the HW requires
the IOVA to be aligned to the selected page size.
Without this alignment, the HW may not function correctly.

Currently, mlx5_umem_mkc_find_best_pgsz() does not filter out page sizes
that would result in misaligned IOVAs for KSM mode. This can lead to
selecting page sizes that are incompatible with the given IOVA.

Fix this by filtering the page size bitmap when in KSM mode, keeping
only page sizes to which the IOVA is aligned to.

Fixes: fcfb03597b7d ("RDMA/mlx5: Align mkc page size capability check to PRM")
Signed-off-by: Edward Srouji <edwards@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 4fc2c0ca2af3..fbb9803785ba 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1805,6 +1805,10 @@ mlx5_umem_mkc_find_best_pgsz(struct mlx5_ib_dev *dev, struct ib_umem *umem,
 
 	bitmap = GENMASK_ULL(max_log_entity_size_cap, min_log_entity_size_cap);
 
+	/* In KSM mode HW requires IOVA and mkey's page size to be aligned */
+	if (access_mode == MLX5_MKC_ACCESS_MODE_KSM && iova)
+		bitmap &= GENMASK_ULL(__ffs64(iova), 0);
+
 	return ib_umem_find_best_pgsz(umem, bitmap, iova);
 }
 
-- 
2.21.3


