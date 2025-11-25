Return-Path: <linux-rdma+bounces-14774-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A804C86F63
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 21:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAE164ECDB5
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 20:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB6D34252A;
	Tue, 25 Nov 2025 20:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KbuedpPP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011018.outbound.protection.outlook.com [40.93.194.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3CB341ACA;
	Tue, 25 Nov 2025 20:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101309; cv=fail; b=fM7TAi5M+nqgdz6vDJtQnHA8WgNdhTsXh1kD6XFRAwGfZgnTXjQOJku3UQzPNYUkaTh6AEhH7zXS8pQiTEDWvOcSKfC5KD0rTbo1DYgrZZ6vopExldRJ9cSVrBBZzZlnzBXxfhYpKk/hR9RSBBLInrWUzkYg1XKzggdiAxsmjVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101309; c=relaxed/simple;
	bh=akdES0X+iKGn4rltOupcPwz7Jf/mU/JyeskXjIgx3P4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRaBaxusDT6ByZJW71KBHLF7nkAGtKbviblywjHX8ChvZpO3Xps5tU7EM1g5twng59GOLqGyzEiHM5mCGHR5A4LUZZrbeq3KWaMUG6d5vYHQObXLiBsc9u6FmPWDohO1QXpdmQXUmm52O8Bx6nXp3+sUWBMjoJn0g36MA81jhNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KbuedpPP; arc=fail smtp.client-ip=40.93.194.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q527NzDMfC2G4ArGu3gyx6WqmKfrguk0daGMItM5KXYtgtSvhBfraTGTH5ZmD5ePNIJ+HbKsKSQuJdvvwr9wZZO1J2GHxP/BAOg78Jmw9Gz9WCPWNs74CBH3QGXiy8givCcAG6oU+a62oMHXyoExL3aTsEqdJYEuU/I5E1KjUf5E/psPLv75pTOvefBBkOEPjPo1DEwfY4QR0HemrhUz0FQLaZ8hrW2NH5lC8fme5PULP3s2bfstBON6v2LiBGVr4vDLOC64mm59RAygc8/LmjB8k+vtw0zwYLW86DyjMjNPXAt6rnQ5a7HH0C8dHwmLS/cLtXOeH96ZSAnNm00dUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTEHFT1VQ+M5GMuB3KgAYIkobtSsghZZ7vtK9OdaRq4=;
 b=OwjyDdjOwx4h0nxmQydQtTX6lO9yQgEGcblSykSfcOrNK4HehXmWm31SSwjctZ/tlmLI7gLN7AE57odgBEd3Ndobr6/Dk81NzD4MyeElHrnCXH0B5u0tA9gHPFbKqQuPmKrzqYxF3JCWDb+p/8bfzXt+ZPVwjuf7wL4iZTMqCW1ORnK0b9if+3cRijYVsB5i21ZguJxQh4RpZASWPWBzzDQWwZtDru7G8SR5el+BFaXGCj6fIuK8wH2l0GXXbwVQQYk1X4AeZ/PAJvFau0Ov5vFhJzUe79OOPdNRDBUbyl/0Z/LuDay6j9Bybft5BOFU5E9FWDw0sEaCNM21TnvCHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTEHFT1VQ+M5GMuB3KgAYIkobtSsghZZ7vtK9OdaRq4=;
 b=KbuedpPPwHsQc9sJEaTuO2VoOTNIWld3VE7J1tqtR3NHhLEIlpyPESMn5BsY8R2w6R7J4PB7Mgksj+1VcU62tE93rwMCmXzGDDvir1AzU3/nlylx+lPkB2DHHOCDl+j6C/FD2J9rcz8p+m2sbNZrs6oIRh7LCqqTGm1Q4gZnigsPIINdz2uB8E6arbBM6xSH1AsLflk1p1QAoCxJag5K6pkpWVDcAdn3GRZTKSpggp1L/iUAMXVRNKZjBCEUOAhQ10j4hs/HWiC1uN7bkRDKjEpxnshmETSUBYJrBbueAlsDEI73zYOdtoqf5qlEa0yIArMl1kOgPA0JcpAj64qW4g==
Received: from BYAPR11CA0068.namprd11.prod.outlook.com (2603:10b6:a03:80::45)
 by SJ1PR12MB6244.namprd12.prod.outlook.com (2603:10b6:a03:455::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 20:08:24 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::d9) by BYAPR11CA0068.outlook.office365.com
 (2603:10b6:a03:80::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.11 via Frontend Transport; Tue,
 25 Nov 2025 20:08:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 20:08:22 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 12:07:57 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 12:07:56 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 25
 Nov 2025 12:07:51 -0800
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
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Randy Dunlap
	<rdunlap@infradead.org>
Subject: [PATCH net-next V4 14/14] net/mlx5: Document devlink rates
Date: Tue, 25 Nov 2025 22:06:13 +0200
Message-ID: <1764101173-1312171-15-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1764101173-1312171-1-git-send-email-tariqt@nvidia.com>
References: <1764101173-1312171-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|SJ1PR12MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe961fe-5fd8-4ad0-6cbe-08de2c5e628f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VMBTZMJ/nFsodT+BaLUKQcXdKq7F4O4d5fDlDG07Xa219d2h9gP21hqXqoBf?=
 =?us-ascii?Q?DMIN9++tQvtfNdGggMRSUNN8uh+83B9XyJ4Zo9j1Sh6GqeFEJDUt3jQWdxes?=
 =?us-ascii?Q?QcjgbgngPZmJJ0oK+smFgg8YGJA15TR4XyfTJhUACmJUxhgxcJdNMAPqOABg?=
 =?us-ascii?Q?do8/rEI32yGFBvv3Yh1aVg03qU5ZS+hcuP92t4e822BIby8ocznfWzCXwMS2?=
 =?us-ascii?Q?qfHMymQtbBhPv3+Vh3/rGu0belVibY0jyyqzIlE7b9JampqYRAMOvVXramwK?=
 =?us-ascii?Q?FwNHvlTBY1drmttC93Ek6hCBFBAPPpzD7MswWNwVeQgszMglpUMI4Afy+ZOQ?=
 =?us-ascii?Q?4//S6K2GQaIP1RRZ1D/VbPB1qejmyqN8taRAldLzhSxUxmSIzDQ23HDX+XNQ?=
 =?us-ascii?Q?jRjlRNCAxhFnLq+exk6U8LC85OLW4Su436f5S4Oo6Ldi8hCUAOraCHxJGiZV?=
 =?us-ascii?Q?0SUKw7FcVIpcTdj511zjyTV2qmKW0VTrHgHT4Gv+80+FgB8xprzuaNfQR1/V?=
 =?us-ascii?Q?KDH7tefn2VXt2U57U6trKU4bkSqrfF8ktx72K7sXV+O5AS2m+UmCLpcQWPy7?=
 =?us-ascii?Q?wv9Qf7/IcTTBR1Nn6nHYrwKSpk0lyPGL/mzjx12n879kPXhGMEwnlIqEWOr8?=
 =?us-ascii?Q?m6Z7rwK/1BWIMQYI2ISCKLkXdamuS6eSjLu86GxS+fsoR5P5AhedOpERWJVx?=
 =?us-ascii?Q?ID+y9hKqGHrrHEw5TJYNcgvHRAHlnzqB5iz+5mJOfcuLLf4V5RdhlDgMv6k8?=
 =?us-ascii?Q?62MsliaLvmFkiAMGDjMrrbd+VapAs1uTsmjAiJhOVk8e/2a0pPLXnB40HRuU?=
 =?us-ascii?Q?/twtr4Zwnt+7xtNRQyF2EwmX9Y7GOn4VYdDG5mWdOhtMKbYQqWoIfaNJuV/B?=
 =?us-ascii?Q?0NL0alaMDVLCXbjKHowZJiGho0iClldsxEwcsq263JMgh18NmPAZIwN9rs4l?=
 =?us-ascii?Q?GLpETRRA+/7wmmQv3OeZk/kPAR6RxVD3XHcGuvM7t+DrympfvyoOIJDOQwyI?=
 =?us-ascii?Q?ezekt6aSZjlhkv0ImsM2bpfmzyiowOBiGeKCwn3UIyNI7VIfkdYwPUOs7NCT?=
 =?us-ascii?Q?eodoQkYua6UeLTSi2rkGcw/5xFCo8zVdFI42wQdW1Q0mGP5R6zWpXgEgKbYt?=
 =?us-ascii?Q?LmMnxoZPSXN7Dp7PWgy1upM0bbB3+rkwTqCh0+yk4U5/pdhS5YcQsg+k6KCt?=
 =?us-ascii?Q?f1PW9SmNW+ZeYyVR2JwIWaT35HVIMzWSTXeOBQMqnOQy6vXaZpujCtttrg1B?=
 =?us-ascii?Q?zOzM81BFQty1Uykm7CbUAmHa0LpVIYIrWnrUPFoRwi9fv9HsfUR/PIETcwiN?=
 =?us-ascii?Q?EWocfjk8AsyBX5DD6cm2bOhJUs5XeElnk1AUF3CydL9Sn3vfjH+DIPzyttL1?=
 =?us-ascii?Q?Fewtyt2YVyNhTJfw2Ff65fCA6Jh2PF3K5s5a1/kty20nGZlUDqqV2dz1JHgq?=
 =?us-ascii?Q?SErBS0vapIQcivSjgoz2PQj4gi/795UOSdSx4mwDor4oXYiZlFX4EPs1ObXt?=
 =?us-ascii?Q?l7NOwgeceP2xLxsblgtGMac/HSkZX3L3rFNEap2DUeG8rzaTNTxK7ibdeHVw?=
 =?us-ascii?Q?GG35B9O1ZAPFhUjIKtM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 20:08:22.3924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe961fe-5fd8-4ad0-6cbe-08de2c5e628f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6244

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


