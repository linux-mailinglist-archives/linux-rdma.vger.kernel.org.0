Return-Path: <linux-rdma+bounces-15750-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEBAD3C1AA
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 09:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FE065A7759
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 08:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70C13D3D0E;
	Tue, 20 Jan 2026 08:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oKTS2uzA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010009.outbound.protection.outlook.com [52.101.61.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0588A3D3D0D;
	Tue, 20 Jan 2026 08:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896015; cv=fail; b=OSTeljoyQ6pO4bajBlrOLcnEB//bQtPO1jYKiKmOwfcUvdxXmTV+jrkCimriFnHRUThZFqVYQgcrN/pn+H0lTOjHd/iXJ5tm8reJCm+8azP84KuWNAa4NfIUiRS70qjqPD7zDimoaoqe3O11Qc0YWmb+EvqceEHWxsiflNDbM3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896015; c=relaxed/simple;
	bh=4eeUc9RIHIgWXag318UGpUedrMXCEQ+cUkvCB4gfNTs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FtWqdP+H+3jNmIRAo6r18cKG3LvqoP8tlBzXPj4oLzpWTwRPqT4LNsFxHFFUdbl8dDoOooRz/VjVIQrJFh3FPCgvgAIFw7eJzBqBCB65yESfyyAloqrvE2UvjXpaQp32+/94XruOeHDMLkV4FXJIZ4xSitL2TzZ68D7+YD97/Dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oKTS2uzA; arc=fail smtp.client-ip=52.101.61.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZcnF2dQVrZ8/MNANQvMkpOhN9Snji8GviS9+rc9Oo9ORN2fSWjQJeAyjs7vOdyBj4FDhX6B7WgSUrOHP3YZHyiKp1bJ81yJ50DR8NyeNn05iNQUdmYN/AEzryFGNqitcjnffELSGZO3Hec/JtK5EU9Q4oJ4hT1bVlFgyjTtQZNnKvqeTO0DwZ138IEj2tspPopER2wZmPBv+OtOmlA3He1rN8AevI8Si+hYj7BL2w9q2uz8Vi86NlujL9ptp2O6sIO0R+Kr4zhfHzG1PFJnm1PcDdh/Q9r0D8vR0+rP0RMfowHACXiD6JlrC7f9plFsVXXat0V9qfO5fx80PJ+uuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2unoNL8G4Xxr5VtprXpzS1NFU/fJvHFzPSMcT54g87Y=;
 b=RDYYdD1lQsAPIcKaA1o97eD0fJPOJ44SIZReSisGLZq5m0L0YtAptM9he0/ZulOjQ/l1jjXBgub3sgCVad2NYEnOWw3PNhqY0rHvryBbxqN4HKjHrMfErpBuRwJ3vtBXIgNJ8jQyUxPutOAJ/XNhHykxmrywZ4QYeNMuSbtJZEcCxXBh2GVbUWFufiQeUwYm28XObSVW5TVC93en8N7wTUtHSm8CBpdCk3Hr46xfZkazSTDoAFGPv/AOokG9OjhGkCNWBLRrcsne4o2kc1CkKp8k3vSEup9PArGslYHzAl+s+9PR9MGvZDq+8Zw9IdrfSXVYFgmipMLIh6TPBsSTkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2unoNL8G4Xxr5VtprXpzS1NFU/fJvHFzPSMcT54g87Y=;
 b=oKTS2uzA8kLCpo4h3mxVy0v0+BrfNpbeEPRBMpW6ZeYb93Lu51AZ1v0/IN4w04xmujHOMUeG/+iiXbhqPUfDiEPcef7wWDwnZoVtQHF7baBIsOCEt/dXI4/ivizTt8m7oTQ6jo/inT6M5E491P9R4VJVOpbe1T1bL2Sp8AX1dbWiC++hESZOuo7sIkoALDUXuRCvnhC7R8yp9hAGF8JYXvFYVG6c3KNgtaZovHPVB4iYJM8nNXo2X5MiubOtsqYKhHxk6jv5jS4hRf0etAlcrzTZPyivewcImlTBKxC40uWDwxZWpiON6X64q+vqrAMguDw6Dp6Txt3Q44Svr7ROKw==
Received: from BL0PR0102CA0020.prod.exchangelabs.com (2603:10b6:207:18::33) by
 DS7PR12MB5765.namprd12.prod.outlook.com (2603:10b6:8:74::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.12; Tue, 20 Jan 2026 08:00:05 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:207:18:cafe::76) by BL0PR0102CA0020.outlook.office365.com
 (2603:10b6:207:18::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 07:58:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 08:00:05 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 23:59:54 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 19 Jan 2026 23:59:53 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 19 Jan 2026 23:59:48 -0800
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
	<rdunlap@infradead.org>, Simon Horman <horms@kernel.org>, Krzysztof Kozlowski
	<krzk@kernel.org>
Subject: [PATCH net-next V5 15/15] net/mlx5: Document devlink rates
Date: Tue, 20 Jan 2026 09:57:58 +0200
Message-ID: <1768895878-1637182-16-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1768895878-1637182-1-git-send-email-tariqt@nvidia.com>
References: <1768895878-1637182-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|DS7PR12MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: 930ed7c7-b39d-4f40-4233-08de57f9ec11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eWmYSZudnrmVmRE73Ggnqiu98AL0CfWDKXwiA4aqAw/EPE/81jN0k69CQczv?=
 =?us-ascii?Q?nMSGfzl/6dNDBZWZ7dJzFALF3EbTLXlIVHs5n4d1wc3yvAe/s0gxB7zulWEF?=
 =?us-ascii?Q?LGmD1dyRiWW13SxA/OzrkP/70bSXrs71iMCD6n3T4d21Gu2LSEfjVjg2KJ7l?=
 =?us-ascii?Q?2ZOIecXHBufJvOKFehvKKCkchq79Y2HWtVK7xNRacXeHq1lg66vTenaAdapu?=
 =?us-ascii?Q?vgTMNB+2eKzeD/9ipWgJ3JS3cmCPK3VF20m+EvPdpb2tr+8NZMoPtY69WVRK?=
 =?us-ascii?Q?pPqjH54ZKlgs2fBjlmjYJPh/xLuDTHByTHyrB1dyd7YcDKeIQ8YF362AAFTv?=
 =?us-ascii?Q?Nf9q+nwZ/yN098KIgjMRJq8OV1G1RUSqWP8lXBSYvOCoQ/Tb7qQt2xZSuT1H?=
 =?us-ascii?Q?ixhJvzr2tPO2EwaRlPosY/vS0tZN5tVdy+sbcsB0LNEYLQIl28tbEkE87tMa?=
 =?us-ascii?Q?k7krQGDFKLMMGdfkh4G2O0Cc0GwXQI9h+8FMaZalSUsxVOVb9I8icTODDfad?=
 =?us-ascii?Q?2SKKC8wjw9yo7Dx2SKSdCFhTue39ZKfJFO0BaLaY76AJlvwg89W+UXWzXLxW?=
 =?us-ascii?Q?IVcsLq8oOtQOGBW2W6sQuDNrn4PiqgRW+nJRc4pqDudUb/lBEy0Q5PN+EDUF?=
 =?us-ascii?Q?TAG/kcTPao9yrsOgdT4mz/486T5ZAbvU+vAvu9y/8Nj8qqH9qLXSdqY/zXPP?=
 =?us-ascii?Q?YeVcflU15FMn7oaQxmgiY2aif8CHxtRm//Ny86edaP0k26n/BzEyl/+WKSQ0?=
 =?us-ascii?Q?fmOL+eP8UyBhgEhUlzdUAsJngWjmicAaX6tYyZWIcVSAUGNgn7VbT9lXYiDl?=
 =?us-ascii?Q?vxrWY1asMQ6p09WshJMLuYnyeEwlhmrwnp8KdyIbz4QZ5fTcNJiPkVT7z27l?=
 =?us-ascii?Q?igJ4xBcnE9/e3XbCrH7EsaQR7TXK2VqD8uAPlVilI5PtCD+W5f58i/ztc6Ir?=
 =?us-ascii?Q?Ot1dr62Qvu4G8qsf+I4u0534B1OshHwNztjLMTeruaEG0PqpUKAy1OLUU1kT?=
 =?us-ascii?Q?53/Zi13Qm84EaAUKkLxinU2r0psBJ8ujg87ZcgbnaqSbuXhjQ2GbAK1JboCo?=
 =?us-ascii?Q?WC99SSQBgzD4NFA5dB5KwwWtezg21PyuB4hUEPyKRoeeEXsyslWf7kfp5H25?=
 =?us-ascii?Q?5w3/+fDIrXV/77uRGoeVNUy4tD7dTXV2OAMlt7bu516CISbhoJ16LpTihrNL?=
 =?us-ascii?Q?HFwLOr2Eedv5/+x9qU61T5JKFHFi5ZNNfrC2VIJq6akv1Lo1NXJ0X/Gk5tSF?=
 =?us-ascii?Q?pSX9B32lXFwB0XKxtpgSlEO4RQfsxSfLY4AmaAEv6B85k4lT0mTD1crML/1J?=
 =?us-ascii?Q?mIOh0uXCtkf5iyN+ssn0jona/UotpdTkQ6pP7x2xVa0DtkN+Cw3pUiYa8oJX?=
 =?us-ascii?Q?8XOjEViSoUXMqeboyAzAxuFVUSzbuEaqyOCtW/TWw7RQKE8HvjuXqxBAJGyj?=
 =?us-ascii?Q?0bEvJSLLriLlUPU+ZsiPuO7WXrSA+2tnr061+BYyjQ7Go07Anprsknj9snrY?=
 =?us-ascii?Q?KR0deBHVSrx7AhmiEOniejWBYYORrEIZRPZQOS5pFQ59YGvOZT2DUCRWVZyl?=
 =?us-ascii?Q?TUYbozKOJ7WvyUgYFbCC5TjobvXRy33n7+thM/AYDtYuvepAwGUszZZ1o+86?=
 =?us-ascii?Q?1fkwH2eIl7ldCMJP4nP8I6m0zjEZGXaYL67+H0QXLjgki7PMh2wEVUL+qQiI?=
 =?us-ascii?Q?qhGGog=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 08:00:05.0292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 930ed7c7-b39d-4f40-4233-08de57f9ec11
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5765

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
2.44.0


