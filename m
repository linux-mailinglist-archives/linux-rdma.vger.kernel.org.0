Return-Path: <linux-rdma+bounces-15966-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDtnNoP/dWmMKQEAu9opvQ
	(envelope-from <linux-rdma+bounces-15966-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 12:33:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB2A8043C
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 12:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36B12300598D
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 11:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685B231AA82;
	Sun, 25 Jan 2026 11:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GQWBPhtT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011026.outbound.protection.outlook.com [40.107.208.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4440831A7E2;
	Sun, 25 Jan 2026 11:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769340785; cv=fail; b=VobOA9yby6lJQnxPIIv5ByF10BngA7/4Fk1hFnPX9UkoqMqDPi2LaNpuBeI9+H7b0Bk/ryicoPsAdEjfxp55aJKAMKIL1DrAwOLP1muVfaepbsHm40tIuqbfZ6WddiaVDd+NHCnhYdwTFGe/S5hl/2p44SRuCBO+YblWwVUay7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769340785; c=relaxed/simple;
	bh=85el+e9yjiJKWWpJvERoCcAZaS/7Gj3v6zUIfDjegKc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SVJNFrcMFQS6+GCFKhrcs92uL8wi7uxYdwYkvhpYGtt0YBqaGw2MOgHJXmu/NhSvNwP0P8jAAY+a8ZZq6fTn7umMigD3fUQCwRVSihba3rgF/Ei6UPtcS0YpV4gXb951ohCPWjqbJ7uyFnSO+4SAWMBB8//0w6Xdl3AqCnEpC2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GQWBPhtT; arc=fail smtp.client-ip=40.107.208.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XkB/+YUf/UicnAfgue9U3ahdGb9UGEf/uDofXDoFQGuZydcfXZxyAvxLnTB6/F3WbuNts9cJyP14Vf2kdL+P0vIs3SOXJFq4Bc2HB8I04YaihaT6t2sOS0TNmJ4MGdlFz5571F8C0sF4kHq4aVOqsGkwr6jPUcSExzhG/wkCx9N8JwOymbiZ1RxFFbPtco7MbEGHRidDkXWiOpSPISdk1qsr8+OI5Bc5H4KMCkMfF+hQqqmzrI+KC1G5rzjr1xplA0/5HHwsJM45qEMitydhokyrKQA/EeVodzDEkPQ7FKz9gAKNaoRBpgT2maN+CWRAk/85ShEurbe3IXCkQvIhKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGFG2VGNfa/wgyPVTfxQyM+YdbA0msjL7VB94k2sbdU=;
 b=LClvOtWWQxKNqvRKs3T9mhqdfA+iF3ggBPWwxlb68LcuTRo14wNVw8roCI8+VLNsO5eFRs7BYg2cyWyXMw3Kz+4xqGC80fXKUihfTmCL831pFVlN6pl4rvvq5V8p5lMUWnQrPXbISAcgQmYwSGsIz/zcalJ2Hb2vf3SAHmJfGJLSq68Dm38X369t926Yx7ULi39npD53BDsot0eLR8VDCrppjquK8nwnCot2CvihxghxU+xH+sfiVP1UiPDuzHjLJcFN13Kv2sE64NvwgH5UY/Gz7hKyXvER2nLB6Nw8KBM7T6aN0pcb5VmrQ0ITX3XobICloTcpiYRyP/6hekMxNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGFG2VGNfa/wgyPVTfxQyM+YdbA0msjL7VB94k2sbdU=;
 b=GQWBPhtTOFAIyWJcSbXlTQxrSc8pSKcD2HNQtPJx7gk2Zh5rjGyyuGYlfF/cKysPYZ/HNg20AEAvM02ANqo7ln6dGiqCFPIXZg6o+d+VLnrXlnSrEY670bcsBRAmAQvHzsfPvhKMyonxuZCX54rySNHR7SjUK47s8yUyeeYggPGGwEvipFvvhgnLIaM2xgf9ythCwiDS4ms/o9xUvjPu8Hencj4sAzlTbfemT+zvVBHgUES6VhfYvRvuXRp9Wl8LT8Pi4dMh9n7uAXNkvK1k7s0zlYgjN0Q8c4ZVIjnXrmpBLxBmLZuubsuBgIXd29vA970KZn1ob+HyKdgzNmfPpw==
Received: from MN2PR16CA0040.namprd16.prod.outlook.com (2603:10b6:208:234::9)
 by CH3PR12MB7668.namprd12.prod.outlook.com (2603:10b6:610:14d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Sun, 25 Jan
 2026 11:32:59 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::94) by MN2PR16CA0040.outlook.office365.com
 (2603:10b6:208:234::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Sun,
 25 Jan 2026 11:32:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Sun, 25 Jan 2026 11:32:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 03:32:50 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 03:32:50 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 25
 Jan 2026 03:32:44 -0800
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
Subject: [PATCH net-next V6 01/14] documentation: networking: add shared devlink documentation
Date: Sun, 25 Jan 2026 13:31:50 +0200
Message-ID: <1769340723-14199-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1769340723-14199-1-git-send-email-tariqt@nvidia.com>
References: <1769340723-14199-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|CH3PR12MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: d5c23b5f-5bf6-42e4-39b9-08de5c057e35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|30052699003|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nC5kCJrI9wgDrXlT21nfOmp8tm+pMKLI3krooa4RplmKOYSXSlpnVNSxUXce?=
 =?us-ascii?Q?z1F6cWAr8rVXAAF/9FGgnGqM6/OflmfG28OQCmIMbOM7YnTwYVzxgYQjIwVi?=
 =?us-ascii?Q?ugMHq8nwPccdRdL3/SSck2DqsITDRgptGCaTKtgnAUwtYUbP21xpF6X+PKyj?=
 =?us-ascii?Q?0da6ha8yoWTgg5x+Z7LOqObrLt4ZlGhtoBW7onvuhhUoxy/+H8OZu5WBxhFf?=
 =?us-ascii?Q?iiDNi3SLzDowlfFIVsX1xogQBHZAAO6bUsSicUpt1bPqCDEFsaZVCsZm/bhn?=
 =?us-ascii?Q?ZekIazYa3iT+ZAa2/AYlPFoKh2v9goL8cz5JqKZVNYjHnU55lQfLfiTdgvHH?=
 =?us-ascii?Q?CZt1AoaKs9mEx4PRXpiUQxQltfXPwH8zBhjsLcm4cUX7B/BTm5dIDu20oCjk?=
 =?us-ascii?Q?BZPaWu5MzBVyzF5dwaiRtW3Z0lnps972Ma/spWYMyldzn5QuMmnYJVbl7rzB?=
 =?us-ascii?Q?lPbeAp6gA8xf7Naxnq49v1TMaxCrOwlan3aT0zONCbobUhEHvyzZOIlau0S3?=
 =?us-ascii?Q?DQTBOttHdms9iYEo1cxaZSELHTbLTnMDlofSBlt/cCBAJfDMZ/5LUeU7dghp?=
 =?us-ascii?Q?kgyviyfVKG1e1ux0r02V/s8TB5uz9GS+3avuMd3QDR7NhMgBEfox6wQUAuxS?=
 =?us-ascii?Q?gIaqQulST0APHrAoqyT+dDFexk3sAFlZwN8oEyJR7Orx9wTT353PUsxhHsG8?=
 =?us-ascii?Q?MIEEEYBDzakMIUJyepDdxdkpiLojM00wk2YJqk+Ip2AstgvDZev7lwYPUG7G?=
 =?us-ascii?Q?YmIKl1DD1NwS5MgTlqHSAChTV1ak2qWsSWFaY6WphO4TlAZRrrnvD65QOZBz?=
 =?us-ascii?Q?zBX5GEbxJNTzVOEMi6hgNBuFP9oNBmCh9gVN1XW1Iv0awjgSiUYGoQ6NS9cA?=
 =?us-ascii?Q?qtNNwjIrl8N3gxlljfnt0doXyJ9oyUpQZx+fYzQmRrsnV7t+n7XvcDV9P2yF?=
 =?us-ascii?Q?o7nA81QQ6JqoHuJDwpJcBooX5vgVzFVjWULaFoAjA9INQTy0CYRYy7zbFtWz?=
 =?us-ascii?Q?ypN/+6uFNNzcM1m2dDSMq6lCPmznVBxHQeBoFI3oFizhr655aPonQghe0Uea?=
 =?us-ascii?Q?K3lc6kIidl/u6OC3KoG09StUwXC88192lVNK/hOOvyLtKAcmk4F4f8v9sbG9?=
 =?us-ascii?Q?RECwhN2Qn8C+utsbmWzCahX+HONY9izB9j2DRM9AYrNdAz0fDrx26I2XIv2Y?=
 =?us-ascii?Q?vswQQY6AQkkAXxHzfMmlOtu/BB+5MrdlcFl0zXnOkJrs8q8nJp01GouTAWz6?=
 =?us-ascii?Q?kscNPrAGxVCuJn4t1AcXuIDx4CT2jK7RqA7P5SRHDVgeySBJWZsE7g491bEJ?=
 =?us-ascii?Q?//HIxD2TWLAiex5N/E0gu9PP3TNdiedHgz0BfdpeSl8zehmGhdcrI8PyJkyC?=
 =?us-ascii?Q?Bk2hcJsCDVB0CpbarPdqsvg5SSLjnQ3le/5mfyWZV6ntbvr4nq5ZPFfI5JfW?=
 =?us-ascii?Q?0YKWXFzIUp0mAl1frwJHB7vDdn7nhsPfhzBrcIa5x6Lev5wAZkMMh65OhOon?=
 =?us-ascii?Q?GwNn/dI81ULt3kzk4iItozWHetSINalGYqxPWe/zWgaJARRQ+lxG3ql+jhk/?=
 =?us-ascii?Q?iYQv9ccQP11bnO8udSjOUEny8tflsxrCyXC9vEWzjZhS+dcMJ8s6si7DkI2I?=
 =?us-ascii?Q?1IfFtTZskDC4bpdTX7pMJbqYswimRfWKhOn0+UtSYHB2NH/oS+Z02zu0q2Oe?=
 =?us-ascii?Q?inqZ3w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(30052699003)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 11:32:59.3282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c23b5f-5bf6-42e4-39b9-08de5c057e35
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7668
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15966-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org,infradead.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3DB2A8043C
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Document shared devlink instances for multiple PFs on the same chip.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../networking/devlink/devlink-shared.rst     | 94 +++++++++++++++++++
 Documentation/networking/devlink/index.rst    |  1 +
 2 files changed, 95 insertions(+)
 create mode 100644 Documentation/networking/devlink/devlink-shared.rst

diff --git a/Documentation/networking/devlink/devlink-shared.rst b/Documentation/networking/devlink/devlink-shared.rst
new file mode 100644
index 000000000000..978d4aedfbb7
--- /dev/null
+++ b/Documentation/networking/devlink/devlink-shared.rst
@@ -0,0 +1,94 @@
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
+is implemented within individual drivers alongside the individual PF devlink
+instances, not replacing them.
+
+Multiple PFs may reside on the same physical chip, running a single firmware.
+Some of the resources and configurations may be shared among these PFs. The
+shared devlink instance provides an object to pin configuration knobs on.
+
+The shared devlink instance is backed by a faux device and provides a common
+interface for operations that affect the entire chip rather than individual PFs.
+A faux device is used as a backing device for the 'entire chip' since there's no
+additional real device instantiated by hardware besides the PF devices.
+
+Implementation
+==============
+
+Architecture
+------------
+
+The implementation uses:
+
+* **Faux device**: Virtual device backing the shared devlink instance
+* **Chip identification**: PFs are grouped by chip using a driver-specific identifier
+* **Shared instance management**: Global list of shared instances with reference counting
+
+API Functions
+-------------
+
+The following functions are provided for managing shared devlink instances:
+
+* ``devlink_shd_get()``: Get or create a shared devlink instance identified by a string ID
+* ``devlink_shd_put()``: Release a reference on a shared devlink instance
+* ``devlink_shd_get_priv()``: Get private data from shared devlink instance
+
+Initialization Flow
+-------------------
+
+1. **PF calls shared devlink init** during driver probe
+2. **Chip identification** using driver-specific method to determine device identity
+3. **Get or create shared instance** using ``devlink_shd_get()``:
+
+   * The function looks up existing instance by identifier
+   * If none exists, creates new instance:
+     - Creates faux device with chip identifier as name
+     - Allocates and registers devlink instance
+     - Adds to global shared instances list
+     - Increments reference count
+
+4. **Set nested devlink instance** for the PF devlink instance using
+   ``devl_nested_devlink_set()`` before registering the PF devlink instance
+
+Cleanup Flow
+------------
+
+1. **Cleanup** when PF is removed
+2. **Call** ``devlink_shd_put()`` to release reference (decrements reference count)
+3. **Shared instance is automatically destroyed** when the last PF removes (device list becomes empty)
+
+Chip Identification
+-------------------
+
+PFs belonging to the same chip are identified using a driver-specific method.
+The driver is free to choose any identifier that is suitable for determining
+whether two PFs are part of the same device. Examples include:
+
+* **PCI VPD serial numbers**: Extract from PCI VPD
+* **Device tree properties**: Read chip identifier from device tree
+* **Other hardware-specific identifiers**: Any unique identifier that groups PFs by chip
+
+Locking
+-------
+
+A global mutex (``shd_mutex``) protects the shared instances list during
+registration/deregistration.
+
+Similarly to other nested devlink instance relationships, devlink lock of
+the shared instance should be always taken after the devlink lock of PF.
+
+Reference Counting
+------------------
+
+Each shared devlink instance maintains a reference count (``refcount_t refcount``).
+The reference count is incremented when ``devlink_shd_get()`` is called and
+decremented when ``devlink_shd_put()`` is called. When the reference count
+reaches zero, the shared instance is automatically destroyed.
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
2.40.1


