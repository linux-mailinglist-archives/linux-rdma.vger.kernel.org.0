Return-Path: <linux-rdma+bounces-14762-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CD2C86EBA
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 21:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D702D352917
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 20:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAC533BBC5;
	Tue, 25 Nov 2025 20:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LXDu7K8w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010063.outbound.protection.outlook.com [52.101.201.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABF933BBA1;
	Tue, 25 Nov 2025 20:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101235; cv=fail; b=sp9rE0xshFiM0puXOHUeXLCJNT3/00ELlPvMisV5MCwTlZDxskU0rbQpOAKBWH8VdnwxC2CK+EeMek/k381bPr81vh0C6tfurpOYAaRMw8VlgvqGOQIRIFicH1g9Q2uB2mK4Dc5yxNDARshOP7MPQ7DoLLfJJYCAxl/gyn2/uHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101235; c=relaxed/simple;
	bh=z99eNkG/duyeJ25sI7Pg+NNKPUS4SiY9fQxCQqejLng=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YU9NQCOxsDFVXpq55wg+z/FGW9yIDk0QniOae8OFWX7Mc7t5leGeivAbTU7KOEKvt0eMyp1QLs0/T8AtK1httfKBjtoOd1x779ETzy7jjzUgCeCsvrWt7F8D98PrJBNZrXu9lCQMH1uRThsEFd4vNqtJoJmswCrLkoSx6+Yj4xY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LXDu7K8w; arc=fail smtp.client-ip=52.101.201.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQbONa2s3SGwZ1m5LBWwt3iqgKV8FXq/j+FaaNVYuAUL7DxiRfcXP83Q1FKNOYncPgNuRydBxlGk38Iq7tEt1hijbx47X/im4MRrYkhH+U1MPARrIC+v6RJZ6KfuJ5GQdLOlZnC2EhiW9Ssfr3AA3qsLi+TLuF6gzdWhIdjAv7lL4yQVB7odVCcsHrZigXButWv+5ofpR0XXli38owvYNeQOm5BlopgA69BE/h+jJy1RM3U6i175VIUF43eFo9QcLB2Wf7XhrFz69qJjePutGyeLaymdYzelbQLxfuc3+jp5uA/ofKsMah7NQVY835pqGI0rWidJIxeDo2c1JGJK9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/8ICGbVtbRN0OLs/S0EMf7KlmFl7M/RyZ323yBNYU8=;
 b=C0Q0hXsLUx7ve8iDmEyGGTYoSgEkM7rpBesocAxSHj6NmtaxNNElHRDT7XwIzgkmPn9Sjy+xCz8USX/b4h/gmGrTjLXsn6rBAYwAM2mecm1tf6uG2agG4IRAnoONB/oszmc6Fu9SMoW3RVfhyf9nA6X0k/c7vKFavEfg/cTTOg2gjAcKvhMCUDWFfaa9GmEs4MCZ4352TwwcJhohIqVosvPwA0g7Ll9jeMX3aJVNSercEpwuqxcRmthiScWJ/+pJYtZh/2mBfykgJnA6q85Diuq6l8C4uFzj6sTYHTFuYquSV/bfBeBfUaw18j1QqIH186cfZIvbbEW3B5FHyGHY2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/8ICGbVtbRN0OLs/S0EMf7KlmFl7M/RyZ323yBNYU8=;
 b=LXDu7K8wcJlcDsqlm9V+cpstMkJVwiGHzn/JiCC9CjdspH6aLyak08ZeCt4EetZDGCPpvBBPaS7kaerrnpDN2xLqdrVSvR1xdInUrvzbjbjum1PrzB2Lvi5PxwUB29OqB72isvzNrztNHaMuKRTun9xv4epOM3HWylty0MhXJJqrNd/nqCEZ2V57pb/lNtKSpAf8Ev/RExU9Rt5m0vvBC/3js8gpNzeEYZGpJ11E8mMV93qdCnKtjGWPoY0Vo+4hDQQUs528ZVqNzobZ9sp4VQm0lIBBOzXuXSHtIn07xv76EK6Z3O/fq3i+8JqKtKVNVNdawH/vM/g9IvnECm1R6w==
Received: from BY5PR16CA0028.namprd16.prod.outlook.com (2603:10b6:a03:1a0::41)
 by CY1PR12MB9582.namprd12.prod.outlook.com (2603:10b6:930:fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 20:07:09 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::b1) by BY5PR16CA0028.outlook.office365.com
 (2603:10b6:a03:1a0::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.11 via Frontend Transport; Tue,
 25 Nov 2025 20:07:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 20:07:08 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 12:06:48 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 12:06:47 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 25
 Nov 2025 12:06:42 -0800
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
Subject: [PATCH net-next V4 02/14] documentation: networking: add shared devlink documentation
Date: Tue, 25 Nov 2025 22:06:01 +0200
Message-ID: <1764101173-1312171-3-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|CY1PR12MB9582:EE_
X-MS-Office365-Filtering-Correlation-Id: a2965731-7955-405d-ba68-08de2c5e36a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DhNSeyuaYtPzojbgIG7wwQfUmiI7vKCDUG2XoN6UQb212Qko18HbiOTE004Q?=
 =?us-ascii?Q?AaFfZdV3vc5OjtsnNr4ApEJA9XeCaEhBiky+W1kQJHI8lOo/ereBoOVSuNXc?=
 =?us-ascii?Q?6YZxgYHPd9nPAHrNbaogItjHHFY3sDGqlh1csFaWrbHx0iX7pgw0CHg18ZwH?=
 =?us-ascii?Q?OXoLm8esZcQZQAFjGj7HY02+ci8qWxeEzbAd/IRm9EXTpnpQ8eWlTZ2R4rH0?=
 =?us-ascii?Q?/VCzFIkWJNlf5wkW+XwE2dqVXt5tiQffCTZaknJa5S1r/PTD8Ja+zCY8shPV?=
 =?us-ascii?Q?xo498P9WB5A1u+6hHWHJ7Lf7zmspDcdhqaUyOh5jmmqy10aKxgMww0Yb42gd?=
 =?us-ascii?Q?UPsTKv8F2UnMaYTSlu/FGHeVwMR8Suuok5UXk/LFmuc72VX0Jt4ySi3+yeRi?=
 =?us-ascii?Q?V2YT2jI7KAmGC06o/EZGq+unjb7t7/fxqX9dtZB7vXChATgy2KcZ7GcCpTT9?=
 =?us-ascii?Q?6PYN2Bm3ZNND57oI0HgD0wpNequRsqbS4Fd+tZWsVXQCaPYuc4Ae/MElA+TE?=
 =?us-ascii?Q?1ZojGT6Hd1r+aI89U3YE9MMHpAeKtB5V/gDiW8uDXrfT1Jz6GMOPKLmohW1B?=
 =?us-ascii?Q?o/7V8+v5H/7L/FLLUArX+g9i6CFMCt/XG6pBVIB/aneEST871FiU92Rsuw/d?=
 =?us-ascii?Q?Kt0dls8U80xJzvfyh60VyeaNy1LVHH83oPiJ1SfLZOfEYix3LJ/6/mg2TCwD?=
 =?us-ascii?Q?kw2BOHqtFzMBEz/5R5wJED+d8xI55NjjueNQ6rU7Lv8ZSx5nsxZhR6i2fU/N?=
 =?us-ascii?Q?HoaOB3ibKls/mIlealUkwf5N2fe8AXLn08SCwQ0lItw4sVZEUqM901riWtyK?=
 =?us-ascii?Q?XzgBIrBhSvrKiYpLWbLnHBb/svutQBWFvlVIvjSvraAaa3bxd2IUvlK1CTZF?=
 =?us-ascii?Q?HELG2H8F3vMigsLjOyF5sKVvDQ1IVgPW2GJJ9tpNFVeXcPV6Ye8UXlmPJg3k?=
 =?us-ascii?Q?QJKISHtp5sjoT3XBJ3kCIR8Xcsbf+DaC0p0szk5j6FX2XAMx1FZ2vQ5tJVJV?=
 =?us-ascii?Q?UHDzH/Eyy2y+yZTkp7c+3WQ9qHNgne5kGG0/dLFFHfdgz+du2Qjdj+aNpWIH?=
 =?us-ascii?Q?ChfSH/W+hMmRFKt0EvGZQYhxCgVazJpr4KMEIt/lv4Nr1kWjzyu2LCyNNYks?=
 =?us-ascii?Q?cTnUZCU12nzM4Z4kVDjJhgiI8zNvTkd6j+/Z//4IkqDoBRG9ylIBMEsX+0jf?=
 =?us-ascii?Q?V1zMEHceR8iOIqIG6U2BS6b5IP9o+KfMezYaqQnF8TUruVWKN3F6Mvqvd91l?=
 =?us-ascii?Q?9zz0FSJ7HRdLfjMX8g1j0HZhVmYl52wS0M7oAGLu+Uu23y3NfT+aaIXnxgwR?=
 =?us-ascii?Q?w0EUyPbfkJgRQ3CtxaRFNhd7ybQvoKoMaZ+YWGJeOHMwP4JCcIzfu5vn6Ptn?=
 =?us-ascii?Q?duqmnPmbiRgAsY9F0O3qP0/kqblTZHsbmnSPwryb5f8EOGjHvVuhYRA3IhMA?=
 =?us-ascii?Q?OCtsJFPcdHji9gmd2zS1xp16vzHN9SCzemNv+Ci4IdQ1WJhccwBj8bY+eu7j?=
 =?us-ascii?Q?79BzWbIVAZxFFlzhplYe6RvtZHO0m/ot5TRlVikBDf7vmif9G7y9MGunObCa?=
 =?us-ascii?Q?hdzRr3w4HVlAFQxniDk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 20:07:08.7039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2965731-7955-405d-ba68-08de2c5e36a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9582

From: Jiri Pirko <jiri@nvidia.com>

Document shared devlink instances for multiple PFs on the same chip.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../networking/devlink/devlink-shared.rst     | 66 +++++++++++++++++++
 Documentation/networking/devlink/index.rst    |  1 +
 2 files changed, 67 insertions(+)
 create mode 100644 Documentation/networking/devlink/devlink-shared.rst

diff --git a/Documentation/networking/devlink/devlink-shared.rst b/Documentation/networking/devlink/devlink-shared.rst
new file mode 100644
index 000000000000..be9dd6f295df
--- /dev/null
+++ b/Documentation/networking/devlink/devlink-shared.rst
@@ -0,0 +1,66 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================
+Devlink Shared Instances
+============================
+
+Overview
+========
+
+Shared devlink instances allow multiple physical functions (PFs) on the same
+chip to share an additional devlink instance for chip-wide operations. This
+should be implemented within individual drivers alongside the individual PF
+devlink instances, not replacing them.
+
+The shared devlink instance should be backed by a faux device and should
+provide a common interface for operations that affect the entire chip
+rather than individual PFs.
+
+Implementation
+==============
+
+Architecture
+------------
+
+The implementation should use:
+
+* **Faux device**: Virtual device backing the shared devlink instance
+* **Chip identification**: PFs are grouped by chip using a driver-specific identifier
+* **Shared instance management**: Global list of shared instances with reference counting
+
+Initialization Flow
+-------------------
+
+1. **PF calls shared devlink init** during driver probe
+2. **Chip identification** using driver-specific method to determine device identity
+3. **Lookup existing shared instance** for this chip identifier
+4. **Create new shared instance** if none exists:
+
+   * Create faux device with chip identifier as name
+   * Allocate and register devlink instance
+   * Add to global shared instances list
+
+5. **Add PF to shared instance** PF list
+6. **Set nested devlink instance** for the PF devlink instance
+
+Cleanup Flow
+------------
+
+1. **Cleanup** when PF is removed; destroy shared instance when last PF is removed
+
+Chip Identification
+-------------------
+
+PFs belonging to the same chip are identified using a driver-specific method.
+The driver is free to choose any identifier that is suitable for determining
+whether two PFs are part of the same device. Examples include VPD serial numbers,
+device tree properties, or other hardware-specific identifiers.
+
+Locking
+-------
+
+A global per-driver mutex protects the shared instances list and individual shared
+instance PF lists during registration/deregistration.
+
+Similarly to other nested devlink instance relationships, devlink lock of
+the shared instance should be always taken after the devlink lock of PF.
diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index 35b12a2bfeba..f7ba7dcf477d 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -68,6 +68,7 @@ general.
    devlink-resource
    devlink-selftests
    devlink-trap
+   devlink-shared
 
 Driver-specific documentation
 -----------------------------
-- 
2.31.1


