Return-Path: <linux-rdma+bounces-5940-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7E49C5291
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 10:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6180E1F233AE
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 09:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8AD2123C8;
	Tue, 12 Nov 2024 09:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MjzCpHZ8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806C220EA29;
	Tue, 12 Nov 2024 09:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731405537; cv=fail; b=t/QSddXlv2huUc8bppqB3mULM2zXbdmMa8Trv/q5MGZzohx/4EyQmBae+hfQOyu16iTI1b1kNNen1IohxT2hgn73F4ZtC5GgUObmvuJOCzITeG+1EO7Zl3nmziX5MbhpXvsvUMKiXjF/PIUFCWma+BVzWRblqW2d4lTp2LXcBYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731405537; c=relaxed/simple;
	bh=ncle9SeKtepsEI3IDufpeHD4ZWhqjBnrNRh212vFwYE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ga9kjdqUywEIXFYRNRyLkfnnuAE8PGw+VI8pAsZ8E3EviDHzt/iLkwKw6AwXD01WxWoPODOPQzrPr3G5kSs8fStlPqyiD22Jz7X/BgmIrGS1WrqD6dMI0yaW+9E/sI3sLavazzc+Id3DxyIQDxdgspAEIMho4dCxHsTXLAvicvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MjzCpHZ8; arc=fail smtp.client-ip=40.107.96.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dYD2Qov2yq5S9Ce+cbIOwej+/JMS3gV6sQ1WR0IxBv9Z0cxGlychHJ17K3uT0Ha1ApNOxuHt6SJ6Pg0NLLi/R52iLZd3ejdAxonCQgUhfRUQqJDHdcwgjP5O+8aWp8qrhDRCmOuRimG10coT15fZeyUmgSk7ZT2nKSGf+QY06SDQscYYGAnNGAbFWXuHoYn6cmngwiMPUm0ztIP6rZr6weR1KebJZUW3jD8rl5ROPHe40Dtesd/9r81mtGzZsgjRsm5+bZUDbRnJ+K0iewQ6kVWnp1U7PYmIVvDnNl0FhYdLVI+4xJyvg1ccX2MdkOG9xPqPiKlk5DasK1bqglDVyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WszNR1Ann5KlTSPBb8SuFfcM5mgaLX/yJ0umeESdJoU=;
 b=bld+73s29JyNWcZENJF8tgO7fNAWniIdwj8jeFHK+65su8YiE0L2ZvUwnMFQPCrGkbxqtAsWvUriQLbS1pb3dKzgQGuh3Vd9ku/rRx+X2s7ufImJLR2o1ZrxSgfboFrAMa6SZVGTPP9e9bzSsitY/dsz5cQDkasQeJY7GVMURlXQp0+zbKWNGf28JLJ6tKcnxmL6sWy5Zq+IIlyUNOICnz1mXgWPV5/Rzv9DK89d+/Ndlni51ksQgfINTaaAfjjt8WBt5q+h8rnW0LQ3+E1jhQLcGJN/kyFqs7XFfwD5e9B+SJhcuma1TlLT/ZksLw2t2N0llxY+YsHT+cxgKXZRkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WszNR1Ann5KlTSPBb8SuFfcM5mgaLX/yJ0umeESdJoU=;
 b=MjzCpHZ8Mez4xNCT9t+DUqZriObW8A7dZ+qO8O7f69HkbQaRZ0FKRJ2GUcWJUwrbo9Nt0I03LB9ZPxJcu2dogkVGNIsUL1pRnlywVXOQIuxdGq6ma3gUPr6S12tW6Fta91eFrdxJxuB0GeyxQzjfwlwtOeg4wDW+KFIv8FLCQVj7CtOit45HoiwEKM/euhKsYaSMszWQdkwyVJMyiLQvfF6pDWbTHiQuwd7+5RuCtFRzV+pm150vO65L2dFmMdi3QGVUdYTPQ3FG6xYoUdLfID4sxqiTUTmh4uDeIj6+GOumbE1wpKNN7vTxfZf7o+SIq5naeUXJbnwzxg03M78aMQ==
Received: from BY5PR04CA0014.namprd04.prod.outlook.com (2603:10b6:a03:1d0::24)
 by SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Tue, 12 Nov
 2024 09:58:46 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::2a) by BY5PR04CA0014.outlook.office365.com
 (2603:10b6:a03:1d0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Tue, 12 Nov 2024 09:58:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.1 via Frontend Transport; Tue, 12 Nov 2024 09:58:45 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 12 Nov
 2024 01:58:42 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 12 Nov 2024 01:58:42 -0800
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 12 Nov 2024 01:58:40 -0800
From: Chiara Meiohas <cmeioahs@nvidia.com>
To: <dsahern@gmail.com>, <leonro@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <jgg@nvidia.com>,
	<stephen@networkplumber.org>, Chiara Meiohas <cmeiohas@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>
Subject: [PATCH v3 iproute2-next 3/5] rdma: Fix typo in rdma-link man page
Date: Tue, 12 Nov 2024 11:58:00 +0200
Message-ID: <20241112095802.2355220-4-cmeioahs@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241112095802.2355220-1-cmeioahs@nvidia.com>
References: <20241112095802.2355220-1-cmeioahs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|SN7PR12MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: eb7a0b8c-8967-4385-d5d0-08dd03009909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|61400799027|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xHH+dNol/Ugz5MIlzuzrUIUXbk05LVxQw/a/0F4zV7m2Ckt6Fr3u2P0gR0FG?=
 =?us-ascii?Q?l/FBTaXiluUt3SxFs4mKpbAiipQpveJ3IuhATJr5QrEVEgVtKuW6QbA+DAp9?=
 =?us-ascii?Q?Kb0QMtF5dTtNW6FkeTPIlPiZPteDT4xl5f0OSCbUK5m/WNICIdnnyIs0u0A9?=
 =?us-ascii?Q?eI34BqzMwszTwRVt1DPVA8MRAeLS7shUD5fprQRJtowLcEq6gMIyy1j4ArLJ?=
 =?us-ascii?Q?R7yCdco1lYt3PnyU14VBzWTEBxSjJCEbWTH7y9pffjJnKfw+ZEjDNcQ+jdGc?=
 =?us-ascii?Q?pNK9KO/aqT31GvHyO74aS0E6QTYz2Ix4k+8MBf6uJnJ7YBFEe3XGR5/icY0C?=
 =?us-ascii?Q?Dpdodx4YXeBjvq4RGIbVM6N6T21VgyTUbCLdSzZLT7RB0tI7jLpHZOHnE+G0?=
 =?us-ascii?Q?b6/dqNYy3Zi+gTctz4ejjU48Tm+aPZQSggduygmxkwurvCTR1Z744KDQ5tTQ?=
 =?us-ascii?Q?drna+L666DUcJOJ20TFsdjMLl/kMVW/6mvqLCKHS+UBvDjF5YQNrIOwhEYAJ?=
 =?us-ascii?Q?Y2km3H+OfKX2n1f//EvrezITF0V48t7mjo4y22yuSQGJm2SbrcxLjO+RuN2R?=
 =?us-ascii?Q?s0XrB5f1F0DVsKtUx1D/diPIigAOPwloW17qxaVAh35sfi72rZGjY+6UktIZ?=
 =?us-ascii?Q?wpc/j40LxG71JGu/cct8B9QQaAzSycdfo0O0s7mh3YsUCyolVD5UNFFKkVP7?=
 =?us-ascii?Q?qiBifYkNMJQsEDqQtIcQ93D3ZUOOcOVrjc8fG9R2Cl1kZgoS0uol0E3+tNDc?=
 =?us-ascii?Q?ugJqELgnySbi/C3ANeyBqJu5i4SO0cp9JXBgyqD0046jWJndXpAoW42A5M+x?=
 =?us-ascii?Q?pi9OjwHcYWIRRn8aSsKIXiK5BvosJZI4FWaabe349X1PEibbCtKYRYwIYUPG?=
 =?us-ascii?Q?geau4BEyMYu1eIt3atWTj/nmIL8Wdx89avzRxM4Me4hbQIdbBfSJd1IAQrD9?=
 =?us-ascii?Q?C15bXqZPTlThjKFKsDEQaDls8NXLYURCCVh/bOs0JWpTZpjk9bjj+lbGF9Oo?=
 =?us-ascii?Q?eH3mn2GK8rRFAdemC5U2sJx+uu9SEbn8FkFK5m97FcQ++NRikENbsVIK68zn?=
 =?us-ascii?Q?XgXLZDzhB4vTzsTbeKtR0baTUX1HU4YZal4XyRNRx9VBWkZCJrCumMsuOwD2?=
 =?us-ascii?Q?LR2HNpeC0GJfOqZvMNB7nYb/x3iUucKKpBVhg0U901JCT0ydHAK5pydxJsyc?=
 =?us-ascii?Q?DtOtVXr21uRrvJlk+Uzzg3U4vo1nfvM+qe17LzFd8GRdwW6GrGkBFgntfd53?=
 =?us-ascii?Q?SorWtucfMH6QCGHC4S92h8a7EA0xrZt66yNMzxMwpYnUSB1M6EBYVQ9ZkxRv?=
 =?us-ascii?Q?Xhc/jfRK/IrB6jUGwNqYOOgkgKOjGgEdF91X+bb+7jft5lPYNWm59SAkZtZU?=
 =?us-ascii?Q?Ivr4dIIJxuhsfxQ4kKXg0QBekBDjelHSJO0fYQ4KzM4GDmai/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(61400799027)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 09:58:45.8764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7a0b8c-8967-4385-d5d0-08dd03009909
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6744

From: Chiara Meiohas <cmeiohas@nvidia.com>

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
---
 man/man8/rdma-link.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/man8/rdma-link.8 b/man/man8/rdma-link.8
index 32f80228..5e4a5307 100644
--- a/man/man8/rdma-link.8
+++ b/man/man8/rdma-link.8
@@ -6,7 +6,7 @@ rdma-link \- rdma link configuration
 .ad l
 .in +8
 .ti -8
-.B devlink
+.B rdma
 .RI "[ " OPTIONS " ]"
 .B link
 .RI  " { " COMMAND " | "
-- 
2.44.0


