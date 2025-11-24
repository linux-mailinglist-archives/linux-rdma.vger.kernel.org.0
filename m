Return-Path: <linux-rdma+bounces-14735-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4258CC82AFC
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 23:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B383B0043
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 22:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3C1338582;
	Mon, 24 Nov 2025 22:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cjhE/5DA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010016.outbound.protection.outlook.com [52.101.56.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5DB2F7ACD;
	Mon, 24 Nov 2025 22:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764023417; cv=fail; b=JmY0dkJK0df3Bbimc2d0c1W2lePfKoKA6VjWpFbIZun4eLLguA9bF/5OuRpAuWbfFeik/8v1A6gJJuA7+nGDM9IScotdNsRQvoHUmlD9fIF94PRpXal9ue7YlQO78cooO3+Z05ed3nSL5W8cgcwqK9bKCsKfRqDHaZMXeydAqtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764023417; c=relaxed/simple;
	bh=akdES0X+iKGn4rltOupcPwz7Jf/mU/JyeskXjIgx3P4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V1EGbRL3ruXnMDzrhgHddjJJj7v1/XgrAGm/7nxjuNkzF1aZRqQK5gaN5Y0RIzjM3ad/kdJ4sm5BsFgXFUsijnK3r+njh0Hpf54bt8pWIvabIBYhmzM2hubpnyYvxI4yOTzAt6ShkMFBnSD2+W8inJVSDUgNOzn2RsLb8q75q4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cjhE/5DA; arc=fail smtp.client-ip=52.101.56.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tor7J4t1+iBDcNHZKu1ukWEpsq2vfozYnK9cB7mHXjuTwF81GFEIwyi3dY4BH3F0otu0exiQLtuOUSl7h8mWQxN0IZUrvpJ+PdEdsUHKVUrtCMXQ9Yow0GMMLTJNDRkDg1cBfljrakDBrFX/2MkEWC04v0jrEDpofW/ysucRK8jUyHWRzPM4mZv7ZuzOpLrPEt4+GsFq/LPeFV8F/MSMbjTW8bbNstqndSupdDOUuIBMom//5mv2hQfNkMyjASAv53Y1ASXjzZltn3DoQovl6mLbWcoZHLt7qviorKloUcGzL2nzhnL9NJ5yfLjixl2QY0ebUwAJ38SHhygLAKMXAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTEHFT1VQ+M5GMuB3KgAYIkobtSsghZZ7vtK9OdaRq4=;
 b=h3/jDdDOF+WrJtGLzt0EzqSIsYJkphADWubQl/BEQ7vXbMP++ub32GlvFzO8xoO5tu0dvn+n6tnIM8wc3bAxkwKdq09HEQc+vT1gJfNsDs+m6cZ42LVaEB6se6oYqhxa+B7RaKz1ibO48rzyyXkmD9KDQrTOFvFSgcFGNUYqwOA/7kLo+514SLAw2J+K3wdIm6QtHvaOXIkWtyI8prarjfJILmNygJI+0RplU3Z40ci7D8ab7RxUnym7p4iJ4S3YRZLmOpeuEsucwP88cUJ3NdCIrnd5qTurClnE2VDq6+jwUiPNmbr4y8Vz0XaZh9VuSvarWY1QoMXKh+3fd0TFeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTEHFT1VQ+M5GMuB3KgAYIkobtSsghZZ7vtK9OdaRq4=;
 b=cjhE/5DAHG68Lsmx3/fWU3lR5sAWyz1GKBfI7zit/a5LM8QQGZc6SLsvF00B6jniPF/oSItHkXlxUZluEbrLeEcMfM+fy1OxiL5DuO6VcfSYILnQCSM5dG0ApS2Z7UCwzgFQ5jnr7K9R70L3wXO/GdpAjpCaWgdCPdu/EzlZ2BUX3USzfxnuAN7fYSrOmefCr5L9plYOu3B+qwaq/WY7UD/IQ2ntyXpfq/h9iPcqCyd29qtE5nF/QI/FK3bVDvkQ0VLz7HbX3iC9JXZBKxv6OwAMB0qZqZQV9TsIgO+rooG8HZNMQuErrInJvbAWO+ueJhYMapiVIsQzrahyLIG7Fg==
Received: from SA9PR13CA0040.namprd13.prod.outlook.com (2603:10b6:806:22::15)
 by BL3PR12MB6402.namprd12.prod.outlook.com (2603:10b6:208:3b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 22:30:11 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:22:cafe::1e) by SA9PR13CA0040.outlook.office365.com
 (2603:10b6:806:22::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.8 via Frontend Transport; Mon,
 24 Nov 2025 22:30:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 22:30:11 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 14:30:01 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 24 Nov 2025 14:30:00 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 24 Nov 2025 14:29:55 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V3 14/14] net/mlx5: Document devlink rates
Date: Tue, 25 Nov 2025 00:27:39 +0200
Message-ID: <1764023259-1305453-15-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1764023259-1305453-1-git-send-email-tariqt@nvidia.com>
References: <1764023259-1305453-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|BL3PR12MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: 92b93616-2a4d-4f98-2e87-08de2ba907d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YW4TdM1HrsSb36+k4pc3rcg3rgQbQUtxo/pOnAFSL97klOnJj2dGKSwWPdcu?=
 =?us-ascii?Q?4izBc10Y9c04DjAQTGXTbp3Ie/Ihim3m7DZqfSQgYnQbgdnWibstFNyQvBOs?=
 =?us-ascii?Q?LUL8/ogPJH5V0aieYICJlhSJg/ZqNMyMw/ioLzrNLPdsJ8ZfBwyKQvccBgv2?=
 =?us-ascii?Q?ntIGRYkgDpzd6RAcnSTBJjOK+xOAKObAbmRgn7OzyY0WEQxiFmEXHZOD9z3/?=
 =?us-ascii?Q?Zved637mDKLbvL2TTcVcmdaANap5NmnWtYy/N+ew2C1upz4RmgezjQImrvFz?=
 =?us-ascii?Q?oeQDsKcUC91aEYjD34QtI/wklsxgWrFw+qwisOnd0j3B3iHKLW8JVnP5Drl+?=
 =?us-ascii?Q?bXLZyAcn151lBxSnrRlFML1+fCdWPdxrBiKEY7LO4woRZVTu4SML2bNl+h2K?=
 =?us-ascii?Q?OI49FsVReIBTdK3bO7lH0YQBLJjs1sJXH3CoqL1SmwB83wQKyIUcVheUGeLs?=
 =?us-ascii?Q?BFsg0uZAv5ds9oIjcOgcnukLcqNxpVh+XXUqlUEiqaTEfY5+Z8w5+TAWcBYa?=
 =?us-ascii?Q?rNP6VVtzSTcF+TeZF8z8zd29uDDuNLpIbkrgXCjbdyuePRUCdFjJkCP2d/JD?=
 =?us-ascii?Q?7Ec8JoXFXAKX6fNpqW825u5Wbw49p1UHe/4rLAX76Y/zIUwv3iruiERiMOV2?=
 =?us-ascii?Q?OqdloIu9K/GH68MmoRUjiUvThkyl3f99J6Mxbb4Af3ScDcmDITZbCvVpfAHv?=
 =?us-ascii?Q?4KK5lZ77Z174GXu7Ft8zDX4OECVW/nI0fQN1pejmxzwZdUsAf4Jse99+4VoR?=
 =?us-ascii?Q?yOCqaVeP1DcuoAcYvTiPRYv6z01W9d6XmCqTffWWdobtj/byTGhOwzFCFXgU?=
 =?us-ascii?Q?WrDJb3BF1Zk95m7XWMLEKHqkjDM2WNzb0ZWv5b2t9A4/SoDzdu7R8gSySv6Y?=
 =?us-ascii?Q?Thee66TEjvxHcVEV8fZkM9DZ+zvE/Bm8HcltpkEL7uLhpC1xMP/iyu4Ced15?=
 =?us-ascii?Q?Zf+UoQyVwpTjIFgSiVEOBjGQnfL0IFy1Nz9mQoP5n0b1NKyG0EVzRQqUQslm?=
 =?us-ascii?Q?iRose0O+M9PPafQPBL/Vwoaaww3pUasU6Id15pnwhKJmB7/wv8U4XR+RNeti?=
 =?us-ascii?Q?RNRhVnKRAdBSQCtCEDrfF3ShNmquGqI0F5Ce/OCpnH1J9jMia6xtSxsfl0HD?=
 =?us-ascii?Q?m8U1S9bTCzPsuEQU4ypmPOZzoyocgXxnUYy51gYNCFRLCkLl0FKxpQPqVPmt?=
 =?us-ascii?Q?eyvo9XFEFw2SbsM3RRm+9vY4ozuZWoPLxAvkqdAX8fMaUaa81C28arPLyJqV?=
 =?us-ascii?Q?5V6LrUoWPWpapHxa6PvEgfOGCpzrvEApXrTFbMglF5cChn24q8cW8Hyc1vQV?=
 =?us-ascii?Q?Tj3eDJcKOnof4oNmY02djavuP4nkZT4kW0F2kZAckq3vmY0yggSY3r0jrFs5?=
 =?us-ascii?Q?cwD1EJeXPKpcjWBZmv2au+28+Pqsci7FXGpnsPJpjeE23FgP7vUgVo9kCHZH?=
 =?us-ascii?Q?HnkQNDAOvH6smnr4qkh2j4kir+5Z6h0xKpIg9ceLkPVGMEC2G08n2PfV6Zde?=
 =?us-ascii?Q?qN+HUOHHuwdfd/M+BUoKj3Qbo/R9RK/cTZfF5wE9PtU6T4d3GUJ4HL9mkb1O?=
 =?us-ascii?Q?9Zo3JVD9mayXdpekgvs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 22:30:11.2682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b93616-2a4d-4f98-2e87-08de2ba907d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6402

From: Cosmin Ratiu <cratiu@nvidia.com>

It seems rates were not documented in the mlx5-specific file, so add
examples on how to limit VFs and groups and also provide an example of
the intended way to achieve cross-esw scheduling.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/networking/devlink/mlx5.rst | 33 +++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
index 4bba4d780a4a..62c4d7bf0877 100644
--- a/Documentation/networking/devlink/mlx5.rst
+++ b/Documentation/networking/devlink/mlx5.rst
@@ -419,3 +419,36 @@ User commands examples:
 
 .. note::
    This command can run over all interfaces such as PF/VF and representor ports.
+
+Rates
+=====
+
+mlx5 devices can limit transmission of individual VFs or a group of them via
+the devlink-rate API in switchdev mode.
+
+User commands examples:
+
+- Print the existing rates::
+
+    $ devlink port function rate show
+
+- Set a max tx limit on traffic from VF0::
+
+    $ devlink port function rate set pci/0000:82:00.0/1 tx_max 10Gbit
+
+- Create a rate group with a max tx limit and adding two VFs to it::
+
+    $ devlink port function rate add pci/0000:82:00.0/group1 tx_max 10Gbit
+    $ devlink port function rate set pci/0000:82:00.0/1 parent group1
+    $ devlink port function rate set pci/0000:82:00.0/2 parent group1
+
+- Same scenario, with a min guarantee of 20% of the bandwidth for the first VFs::
+
+    $ devlink port function rate add pci/0000:82:00.0/group1 tx_max 10Gbit
+    $ devlink port function rate set pci/0000:82:00.0/1 parent group1 tx_share 2Gbit
+    $ devlink port function rate set pci/0000:82:00.0/2 parent group1
+
+- Cross-device scheduling::
+
+    $ devlink port function rate add pci/0000:82:00.0/group1 tx_max 10Gbit
+    $ devlink port function rate set pci/0000:82:00.1/32769 parent pci/0000:82:00.0/group1
-- 
2.31.1


