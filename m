Return-Path: <linux-rdma+bounces-14833-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFC0C94D9A
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Nov 2025 11:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A80DD34489F
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Nov 2025 10:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CA127280F;
	Sun, 30 Nov 2025 10:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W/QDf6DU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012020.outbound.protection.outlook.com [40.107.200.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108F2236437;
	Sun, 30 Nov 2025 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764498389; cv=fail; b=jYdmzHs0sLrM0ZKKQ+pNudB+65nF0BA/b20MWLjyS3N9CMOH5iIU/Yw3C6KvXI1+FC80fio9qZ1sN5RzUnIYy6PhzV3RRg09osVLnQfYZZWweDHfqOI6t/lj2aDQBr58IUIAx5Wxrf0In2fWQALcWfuUyxT6TEPHsKlLbcmFDeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764498389; c=relaxed/simple;
	bh=9SiwrrUh988HoXdcy5iWfEFTBME0KaksRiNyLafIawU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nNRNp2PDCiWbUlHoxyL4lPkIaUW2tqF6Iyj8+646eQTLhOilL7Zl7TGCPliEWLRef5PSywyZLtUOsg0E2ciU7BxXHzGqqqI48/UtJS+Zb2wFd2Rm2NWQn3JDo/r49RNkrgetwp/LABouBtcTF6LYmAknN1wi68wSwkSo/uWPwtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W/QDf6DU; arc=fail smtp.client-ip=40.107.200.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hbB16hrqA8lGYrwdQFbyFx+Qpc46cFS9aCGzCTN0EwgbnAprdBjgXXxtoL0j7Vjur/kLMYjobm0qnvu8WILOjgCW2HtoV8rFWaE05XE3CxWmIwQH0gyfYIIgAEjsWef0EmO3uq8kl7gosEIlEJfB0X48qhLImK426Y2fyfpeM0G3FNm0m0zraQFoEH3Ky+8RFLz3WdCOiSF5il9GlWAuJGb7nNbdYKsBB4L23PljBbeM7Xibt4cweBSd5JFHhFn7YI8h3RQ+L4b+pHVAj6BRnW3R7wrLSOwNvPCrFqZIttDz//fAHdDfmBAYzXUQyY1gzXo79u/3utRnvqqCrRY5Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKopBs5FjQCZb38Oe+lBXgfnyPmJdZAm/eVhC3ercTo=;
 b=rz/V44GRNZxggNChs4akSuab5PxWljNd+LrhiKAF9TTrpNGKxzuoxR3dvgvRc3FOO5WGcN0CSEuzTxZCen9Mlzrii0LF9hY/yI19CR7x4+7XQvw96b8hBA10rAHOgj3WUIKXE7Qh/+3uW6uXgx/VeJM4BbxIx+vKI+mEieRfeqCd8Y0wsFyApNPd78I0T0ztGEo3n3lbTqG7CwIkIx5s/jVjr+FqgeU7EGVaypqtm+XHbYgELlCdRoA8y38og0C1XSAqW8MuzLinxJ0cpbABEN1LkzmlFOARlQ9dpoEgKncwxGevYijCR5iRsaafH0PUr4dfK4Jz/0qqZkBkvGg9HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKopBs5FjQCZb38Oe+lBXgfnyPmJdZAm/eVhC3ercTo=;
 b=W/QDf6DUjihn72FUeOjMzQT8Vc175ZNwV7Ivzphx6D607ME+/SF/+kVLciz0q7FMaVWL1wxWbAFOLN50uOqsZ7LfmidwV99VIrsojZktJMKt1v8b7M9mbWKjlr00IUxwWPmBxc1agy1fn80ui7TTIBqx85vmwX91rfYeJFctGsup5H1PxDzQUTZXjVllVgdXllWEar84oy5B8msmxxtvrBVCgKhoh9B/X8+Zq5bdK2Zl/i5vLZCxuIMIl7hDS++lqudEu2fPponzDS+nsL7QcnxW4WeWV+CM2I/e2j8fWtCbMLXo8kGU0CBZX9nMJUuhIfESlNglM92CyYCplb7WvQ==
Received: from SJ0PR13CA0143.namprd13.prod.outlook.com (2603:10b6:a03:2c6::28)
 by MW6PR12MB8915.namprd12.prod.outlook.com (2603:10b6:303:23e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:26:23 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::24) by SJ0PR13CA0143.outlook.office365.com
 (2603:10b6:a03:2c6::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Sun,
 30 Nov 2025 10:26:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Sun, 30 Nov 2025 10:26:23 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 30 Nov
 2025 02:26:08 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 30 Nov
 2025 02:26:08 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 30
 Nov 2025 02:26:04 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Danielle Costantino
	<dcostantino@meta.com>
Subject: [PATCH net-next 0/4] net/mlx5e: Enhance DCBNL get/set maxrate code
Date: Sun, 30 Nov 2025 12:25:30 +0200
Message-ID: <1764498334-1327918-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|MW6PR12MB8915:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cb904ea-6839-44e0-f2dd-08de2ffae905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qHiuI/Fi6NbMfozpzmaxWK0lSap2KJ7tHSQDM2eGgIfUz2n7LrzqgrlIVDYr?=
 =?us-ascii?Q?XABDWwFKG2rzugjtUFb/XKW5TQuoF58oDRyaVn2V2aRj0i+3gRX8Aiw/RnlN?=
 =?us-ascii?Q?y7D0YdnmQ6wqAD5MhL99EF9SA2h6OiJ6K3XJyM1ZFE1tZB1Ev+gIogeK1JUw?=
 =?us-ascii?Q?LRUhtJize9vgQgwMBPm/tMFKXLkQ0MZog/pzof4ZyjqKwqtoqv5Ntm0oNzKe?=
 =?us-ascii?Q?YST0j7f48eZBszTSt7JCgjxpkbT5NX7n0JHElJ60GT6deG3ODTK7DlQZ+3pr?=
 =?us-ascii?Q?d3WoIAZ1biVkPtMJl1vA/IZ/hCvl8wwrmKSRnGxoJQ9ikPY8BYIJ47rk9jhc?=
 =?us-ascii?Q?Gc3iplZMinoBbiTremzO8AAKmMBRipAGyh6l9JOKkG4BU2JLUVaZfYXmeiDe?=
 =?us-ascii?Q?F+bYgJoN6+4uYmFuKWIezkV5SA8RR9EguB8zt2TW07jgmb7ZSWD+cNz489KJ?=
 =?us-ascii?Q?pw82uT4KFMALe1G8SQE7V00dAzkx3tTLxO3b2zFJgwKft6VJgr0rVpblI7he?=
 =?us-ascii?Q?1WZot3PMEMx1UxkvVmgaxx/sYI2H1pa0DKbpsIANyNPwqXoDFQI6irA3wTQ6?=
 =?us-ascii?Q?tTTorfLCaIquYHkNqVnj9TCA800XDoPJldPL/vgCw7WAkEGFTDwzD4L9mYLX?=
 =?us-ascii?Q?OAv97S9KfG3sG/HRfxvVaemycvPCZm3bZwz6s2EniNfQBJuB+dEgWjaKoUPG?=
 =?us-ascii?Q?6iFIBpP8a0yvadxIHpTcOh6Fg3SGNZaX4uYiepZm2hB+q0CLpqB7uiKLcm3v?=
 =?us-ascii?Q?0f4/IFgGbNwFBqGdQtUwlCfFeaQFmnMUhOVgOiUulSUSfoZ0B0W8B7emn6JT?=
 =?us-ascii?Q?qHIkMFftZajcIG+PYyNQNUKoSL3JYuLG9m16p98oNxjFET8YXSZCb23qem3w?=
 =?us-ascii?Q?gWdCYipPQCn0LzZxE/xHy4d8Bkqxc/TdozmSxM6bGnB/Vcm2y6K9fS945bHu?=
 =?us-ascii?Q?UcAx4GHK7QhyHwxF4BaC+JDDVva5yM9hfLlivf9LY2yvYbQ9pWgHI0UEbqE/?=
 =?us-ascii?Q?yBa/iJ+19JIJvL7f2sj3uFcvx2nwWqZi9hQynWem5Pz2o81TCREt37l6wGRy?=
 =?us-ascii?Q?H3DdDdKEH5uLJq//ufuTPw3MDaLG0LtoI5GDVQokcD6qKfzG16uIMfCDeXux?=
 =?us-ascii?Q?HbTmrrgs77LZdbvuplWBb9o7B1jkiPny8I18RfBLPi5bHItYBCit9jaL84Zr?=
 =?us-ascii?Q?doV20K8pcxvAtgCDfFqPHKMP30MDSTszWWXOiOFCiytbMqits/hPD42eIRaa?=
 =?us-ascii?Q?kHr4teAkGcNbIewHzS4R2EH2ZwUXl8ow8PfKNb6oj0bwfajLwlSSejf7LDuk?=
 =?us-ascii?Q?TZJmX9Adk1WQI6r43RcA/MPy3nUgoh+rBUrU9o/TqF6ShL33NVri9XgoTx8F?=
 =?us-ascii?Q?t16Dd2d2nE71eSeBl/46QrM0pGQPabe5EfrToST3l8A3atIJHgj+Dnz5Ys/I?=
 =?us-ascii?Q?/dVYPFPh6md2Pw5qjqCwNuBI8OQRbJxB6jHlyoe036OBh+1ywFjAbHimw8No?=
 =?us-ascii?Q?Z3xQVF7drS0QpupKxGy1FiK/saeZCSDSN6r+ueSphmNmQePbyFAsNn7kw01q?=
 =?us-ascii?Q?o+Mxe8iiurJiuU3963Q=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:26:23.0071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb904ea-6839-44e0-f2dd-08de2ffae905
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8915

Hi,

This series by Gal introduces multiple small code quality improvements
for the DCBNL operations mlx5e_dcbnl_ieee_[gs]etmaxrate().

No functional change.

Regards,
Tariq

Gal Pressman (4):
  net/mlx5e: Use u64 instead of __u64 in ieee_setmaxrate
  net/mlx5e: Rename upper_limit_mbps to upper_limit_100mbps
  net/mlx5e: Use U8_MAX instead of hard coded magic number
  net/mlx5e: Use standard unit definitions for bandwidth conversion

 .../ethernet/mellanox/mlx5/core/en_dcbnl.c    | 23 ++++++++++---------
 1 file changed, 12 insertions(+), 11 deletions(-)


base-commit: 0177f0f07886e54e12c6f18fa58f63e63ddd3c58
-- 
2.31.1


