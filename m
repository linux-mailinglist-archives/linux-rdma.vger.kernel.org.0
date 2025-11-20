Return-Path: <linux-rdma+bounces-14639-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 21464C741F7
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 14:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 146724E7E08
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 13:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B5033B6CC;
	Thu, 20 Nov 2025 13:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sTKT9MfQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010066.outbound.protection.outlook.com [40.93.198.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF29E33A717;
	Thu, 20 Nov 2025 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763644428; cv=fail; b=jh6HF32R5pAr5DzxIVPAshJPQDrceUoth7VeZH5DXFvliyG9+8WiH+TNvs7FWWZ81jdq/sUDT7qnkfO78NedGPfXjJ9N7IwkxAGpNezNffJr9Iih4Zi9OJzys2DWjN8yUT5X4XpjgqiV0z3DuXw0c4tcdUsKQxTtrbfGiXbfvbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763644428; c=relaxed/simple;
	bh=Qkb6pNUnyaj/v81+ET9DNUBziUveBX//R0BNmlCVy9g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sb5saBodj4nKG0rbTvb2Xbowqc13RvbFN/k8fi12AmP4G78BwfZguXOeTxkUIZcmw4FaI0EkvllVdKN3yYvd9mlfLNqOUy7hLPtlOxhPkXFxhF++9eRsZoURe63q9PYEXL1OZZvecX4Lv51QiZ9iXB+pShvXWVSGECAejlbmoLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sTKT9MfQ; arc=fail smtp.client-ip=40.93.198.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pgeg59kNllmsQPJn8jwyWBGmBX045kFHXD+jwZVlbP761DoOFOIg7WmHmnxpZ8eY50w/R13adXI9jdb3xd4j3ZN4YjA7kf2uG1tQmWadgUWcRiWZxLP1BmZorZSrArXAPLG9kDFbFe52qL5UU273YVh7XezJLJ2pFmttRiAJYuHbHWSyz8fnnv9JGaaJxUyrzlWmEGBt4eJb+VMM96XvP7osE6z/vsWdyuuD5m+AhpBrIXK6mqjjzRHgXLQ+vJEqC2GndeTH4bs4zDq2XtEwVV7NuJR+OInUe+BaJYeoXvw36L3yqAVQyHxGDDpM8VSR+TKvlyh8AZW8GycDimgUIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dB0KCazrhTv9T4oxZp74zais9T3F8hs6VqNcq2QNfQM=;
 b=PDJgbCphXz524hWb5G6AJGNjKf6dMiI1AYAS6e/e1TpmejklZw3v1Lw5rM1MkE9hB1s7zg7dfFpYK4FjLMkHp2vvLnQ4ECaboZAb5Ad4I8Rhuw5SKeXAyKlw8BVxyoJDSRLks8k4xVF1q7sj0T7FdARnndjj6CnarPg5sM5IDGgRnTKvcgUn8ZkpMZzJaZUQ7Pi1DgCT2fIJzOCsZ9mkbl04bfRoMJQqFV2qDwsZKzvwbnYsWzAoOxrQ5I8pIYbAStLou2PpFvEaLNghTK37qgjA6KZh9TA2UKmjUGGvcD65j/8aNWL+rIXX3nbjC3VsuUwHOZEW4tdc2uDy/W5cQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dB0KCazrhTv9T4oxZp74zais9T3F8hs6VqNcq2QNfQM=;
 b=sTKT9MfQnYXxlvRGd6OllE2RHmxyxdIzSEE6WBykklILNu1QUemAKFvf27DwaU+EMHZwuLtZ+9GiHSmvssuKPJ1bGoCsmit5fiWgq8qo3XlhfbXh8HxY2HpFVz3DjCk0iZiJNwf2E9v+z7zv1ymD58pMNR/mM9pANKFSp9tDCJgY5nj/rySpAyKRPP9ejs5eApJFDO0ncj8NIMsbWzAnjiKx4kfeERlt8Nz9DjHCnfUNFA7zQNU2PXUatceMWaK/J+46AYUWWKAqdywkB9Mh7L9lDvmAYr/mwW1rpG29dX4SBZVwDc3IYP6z9xXNmo0K+Gx00hVxdosEHXckf07AEg==
Received: from BY3PR10CA0004.namprd10.prod.outlook.com (2603:10b6:a03:255::9)
 by CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:13:41 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:255:cafe::45) by BY3PR10CA0004.outlook.office365.com
 (2603:10b6:a03:255::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:13:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:13:41 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:13:21 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:13:20 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 20
 Nov 2025 05:13:14 -0800
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
Subject: [PATCH net-next 02/14] documentation: networking: add shared devlink documentation
Date: Thu, 20 Nov 2025 15:09:14 +0200
Message-ID: <1763644166-1250608-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1763644166-1250608-1-git-send-email-tariqt@nvidia.com>
References: <1763644166-1250608-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|CY3PR12MB9555:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c07bc5-75b9-47f0-6dbd-08de2836a049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EK7vN3SloDSJ+sSapITP8HxVcvNqgNR2IQr+8pT3612RHUKN5SZOiS7hbd/F?=
 =?us-ascii?Q?82GIl6R9hS9uQxh2BC8PXXFRl3FUwcZ03Tr43Bx0pX00c8wRqiPYbFLixpPd?=
 =?us-ascii?Q?rfkSxcF2Ob8Fym/aX8pxNTdEHsqWZq/C/w1f9TH7ZxSkRxkH2YhrkAGKQr1P?=
 =?us-ascii?Q?m+zOqbxL1C6lJRT2wZHoqA7oLsE9fRozIgVZfuDG1tx7XYqfUWk19KWvvthk?=
 =?us-ascii?Q?+w1niwapr4dlxmCkcSRwu8zE2fMMsPVFMBYG4v5uNMYyJUuSkX7fmXd/Y6cr?=
 =?us-ascii?Q?6qo9ge5lsnHZxS4G6JM7kvmfnUahsJj8IaHc8cNKL4VtTTot0W3tJKJxbFDc?=
 =?us-ascii?Q?RHEnfYebrHS/zKhMcrPpj6TJFe2NZRhMLYy69On+mBpr0xaI5EMwpdSAOq+/?=
 =?us-ascii?Q?/BxlkXIHRPOPnnwAuD79gFaDPp8XKHA9S/tpc8vBY4o4aq+FS5fy8w+KxHgf?=
 =?us-ascii?Q?Rffi70ML4PyJb1pKSRSq9YA3Ls8S8jS7XstaSOBWrMT0S2OIgBWUSISm2Bgp?=
 =?us-ascii?Q?1UCxZEA9V1Kd4QwomJTDYufDdb2qUsVVGPMRutpSw9iFCke4lRVS4i4X//ls?=
 =?us-ascii?Q?Z8Od6OkNA0UrJY639lJAkRBsIO292i90LNksuQHISyKdIB8cNUApGHabJIz0?=
 =?us-ascii?Q?1UtjpVxturTPqO55XaPjdC6BBjY5uHidJFbgvrpBw8g8IvRCqz1BOtKUpPej?=
 =?us-ascii?Q?DJ7NMizMTSHP1cWxA3cTI+0FetYYySdYmFX1kJ16OViFxHZCxvBKja1mIA87?=
 =?us-ascii?Q?z5mgSvQhf4UBCU82FuEKdmjR91fi8NuzodOBzac14+h93vu2ygr6iFWulTUS?=
 =?us-ascii?Q?HFbdbsvBOD1y2nWe0KmofANLy2IYJt6pi86lHiEHs9JTiP7WxtzBVnIjPrGi?=
 =?us-ascii?Q?uthz3lWIOo8WuB4H3LzUxBDUPfIWuZhEdq1oChpdWrG0wIXUZmgrQFiu9LJE?=
 =?us-ascii?Q?sNT0P3D8nNtVlvuvUDah2+ppinGHtJk4f9aKGO6y5Tkn0wu3C76VPYHfZXsb?=
 =?us-ascii?Q?PGzjPIL+J0/Xwv7f/OV5sDQxv1bxnbsWh2d1begxJ/HSsDWnJCRCdwSM7wC3?=
 =?us-ascii?Q?KnklVi1JW92oxkfd92z8t1j9/qSGEmqEygrvo5WhsNIqvI793qERlU2kL/YV?=
 =?us-ascii?Q?RCo8zK/MKo/QYDOGKnWAu0MXFksI92GTnXZ+8vNY1FZ0ky4P9mgrJuYyDhCD?=
 =?us-ascii?Q?4yRUofm00G+eeEQuqHNUFDVuW/qAm1HnuUNWqk8wuPXoiKEGl2gEfYSRyOHh?=
 =?us-ascii?Q?ubbgXX9KLDxfWSZDRCQH91YdS/bMSGKCNyUXnLWwieN22zwadFADshxL5PhV?=
 =?us-ascii?Q?yh0d95TbGpnXCATZwgfgw4PkSmLWlJ5U0x8BVTV9pd+rDO0rUPpr1Vq4K2eT?=
 =?us-ascii?Q?5fTi51kPEQXHo6NXB3fZDGfYj+TLe46dRoOQr5E9Okjy9FPCjquoaYVn6M0H?=
 =?us-ascii?Q?UbdjUhahhweT2WtCFVFaQTFGtWVcNIVUw1qCfvwU8iYMhoKa8v9OVQd0q49v?=
 =?us-ascii?Q?fm0MAf6drMTrAysF7Kp0qDbBYh3e1PY4EUqUy36pgEUx3qeb02Db2BApi/XD?=
 =?us-ascii?Q?Vv7N8uRhVV2PPFu2xlg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:13:41.4786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c07bc5-75b9-47f0-6dbd-08de2836a049
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9555

From: Jiri Pirko <jiri@nvidia.com>

Document shared devlink instances for multiple PFs on the same chip.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../networking/devlink/devlink-shared.rst     | 66 +++++++++++++++++++
 Documentation/networking/devlink/index.rst    |  3 +
 2 files changed, 69 insertions(+)
 create mode 100644 Documentation/networking/devlink/devlink-shared.rst

diff --git a/Documentation/networking/devlink/devlink-shared.rst b/Documentation/networking/devlink/devlink-shared.rst
new file mode 100644
index 000000000000..8377d524998f
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
+6. **Set nested devlink instance** dor the PF devlink instance
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
index 35b12a2bfeba..d14a764e9b1d 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -68,6 +68,9 @@ general.
    devlink-resource
    devlink-selftests
    devlink-trap
+   devlink-linecard
+   devlink-eswitch-attr
+   devlink-shared
 
 Driver-specific documentation
 -----------------------------
-- 
2.31.1


