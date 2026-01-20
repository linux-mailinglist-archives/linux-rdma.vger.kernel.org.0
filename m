Return-Path: <linux-rdma+bounces-15736-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46916D3C14C
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 09:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E41224094A2
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 07:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C253B95F6;
	Tue, 20 Jan 2026 07:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dbsqjajU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011036.outbound.protection.outlook.com [52.101.62.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942F33B8D78;
	Tue, 20 Jan 2026 07:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895920; cv=fail; b=mO9G0DQ3MHQo4rrpMd9DUcpr1GHMs1d75m0gT17pIiVmZfSy9yLTgOKI5hYfBB3Ng9kGNrNWpdSL7FQj0lTmUZpDwmx4L+8IvTpYup8SKHpgvqHeXueWuPPFdsWK073IKbQi72c5egayzEsNkAzpghuC/y2ZaVt9mO4R028mJ94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895920; c=relaxed/simple;
	bh=Px4IPIY6SwUyEEZFZ/FdSudSxntNHlDUPcL2co0azRE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OdlMXnzVAVhzDEyPJynaIFIpdpH5IZF6Muepyr7yEJGOGOPstXq7gJjmj7+P+mfEcVeNcccsT1m+X2N3vlql+LsLLmamdczDgu4GA2MYeiFhK1QQ3V0UCCwYAl/DQIGRGwSMJcAUYfrMB4ssqOpktrjksJ2v/H7oipoaEZLnoqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dbsqjajU; arc=fail smtp.client-ip=52.101.62.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xF1M4nUidc4IsNbZ8Det+qOzxBS3BHDBAPlObBMMbgxbLMIJRL8W6/0Tabf49eh6810bz/kd+naNCK8yQ39Y+d7H7GQJUXzVoW36qyF5+y2FUOpcDYnVBNyvej/ikOWd6Srui0qAonJuzL90OTGSLymJ+Dv4kExLMmIqt7qpyvWJLthluwZd3PnxH3xyVDanxRLyKRnS2E1xYDcTSZdHf42rCl+vdA6Ubd6NJaBA+fvAVtLNqAvIJeqSGb7Sdyxb+HOelu1MGGaLZxVKewipTjEKpy9kfdeQme/ZlegNiKuYOOWBZQSiEQOtmqN2XByyNCMP1siGDmZ6tH+8AV8JXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYM8Tenv7+fBmCxmfjmrZBh5DZ7QWZYDmeM5IxQxc1A=;
 b=MUB6WHh7QX7/2K/SuVVL9a2hU78n/szUzWENz4J7O/eaA0GuZxanjwJSZtS4Z071CSfRU6QzNVM4gOmeZnrnddNcCT6lLAowLMRuPW71oW5scfXt4YTKPm9U07QU5qVJs2D7oUIpHrPxAh0Jco8irJH9w6xVtXfTiLzJGnhAEFjvB2cEoCGhogVcVfIATXHNMN2Ge2Gk6m4Mh5NF/sJ1Jvwmt7EwOmjdXdJ//dRYb1rtAuE55jdMKqUpdPQscxRepxTFtXLZ0/J2BcWePAyjiJX3wAb7J6yTL7sL88J8kSznGH/Gg21wWuXAmmwWREF0OvXzeyfv81FxkaB7tw1TsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYM8Tenv7+fBmCxmfjmrZBh5DZ7QWZYDmeM5IxQxc1A=;
 b=dbsqjajU83bPjJsq0/atHtS0pcDh57VcmdQyEHe6eRcKv+l6dscSS1FsSoD4VF5eZX+fXdxr4gy6N6MYrI11q3rWyfmovlcXSsTuvS9NzFhEXv1hubFjXhRkU+fZNbh8o1WmiP1attbUzJ6QhrUtnkXzjQ7zceYyRlDacpp2GHrp4vGENUxaSesi5KfEQPSU9p7PfgCH/SebVOf29W6NpKxT9CEG/hR5Zm3SwsyfhjNyFDWNw8WGz9drH/Wtz0xPJnH7WEmCIR4gELschI1WDfW7fr1iFyHQ4O4qF+cKPmALi+DmcByxznKiiMgSNBInNGMqycNXxJITxXKRKVSNCg==
Received: from CH2PR14CA0060.namprd14.prod.outlook.com (2603:10b6:610:56::40)
 by DM4PR12MB7647.namprd12.prod.outlook.com (2603:10b6:8:105::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 07:58:33 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:56:cafe::27) by CH2PR14CA0060.outlook.office365.com
 (2603:10b6:610:56::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Tue,
 20 Jan 2026 07:58:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Tue, 20 Jan 2026 07:58:33 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 23:58:27 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 19 Jan 2026 23:58:26 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 19 Jan 2026 23:58:20 -0800
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
Subject: [PATCH net-next V5 01/15] documentation: networking: add shared devlink documentation
Date: Tue, 20 Jan 2026 09:57:44 +0200
Message-ID: <1768895878-1637182-2-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|DM4PR12MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: c61fc385-8a11-45a7-225e-08de57f9b543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|30052699003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fe2Hrs3kuPWgqNNq+2n1mNxusVCtIWxccJxwxT8DBOVhnQOMob/gg7o5pA94?=
 =?us-ascii?Q?lrvfaAqedUQlqIoOMzk1hoA96gv38fr/ZLQAHkAtLHwJT2GGjh6jVlCupZFx?=
 =?us-ascii?Q?SPGWf+o5JGDxuA/Vcdb+yS/fevJXsl8DyaUR4caINXp4rmwBvL0YKbxVDfXf?=
 =?us-ascii?Q?/PcHn2ABCZgF1FrQwcTAZgq5gPgHv9DBaehl52KgACbw3k+Ypteyw1kdK4Fp?=
 =?us-ascii?Q?CS8/nHldPxATmnA30i5R5jXjJv0lRXeuZKqk+iK71waoX9EIXZfT3jLyjpdz?=
 =?us-ascii?Q?ousLb9uGdS+Zc5sNA5QCE2GXSrtDAXkdgPOEIHmfhnakL6PX2UrWb8ciTeFI?=
 =?us-ascii?Q?Zy5CCmLcqx+6sqmWdzyUucjFk3uFYNmwrK24buRA3y1h2PNPHv7KVj4VgI5G?=
 =?us-ascii?Q?UiwU+3tftqC31nhMVR1GDbvj8O/Cijy/1CukqvWNhbz9XPhnagk3GXs/cX8Z?=
 =?us-ascii?Q?58H8h+9DlwgYttJ/bwvxlsAV081gfQvW+Tylh6PnRTo1V7XRZ1v6RkxMXD8a?=
 =?us-ascii?Q?G05WQyqiizWtYKRbtauL17Fi+qQrMaQhy/LCphB/VaFhDMtUMnx7PILMS3dw?=
 =?us-ascii?Q?BdLf591g67GT+qQB61GrMDS1tOZ2t6vECHboSq4sPz7DlEsP/yPSw2rcQ957?=
 =?us-ascii?Q?dKymPQPfsF3xME3rjevDGye4LVkBwoQg4iaH73UoCu1CvTVFPZHY2lMLOlJl?=
 =?us-ascii?Q?Y7fDFhVZZW1GgfZffKuCH2hLX0dJbVuMSGVpk87CtYspuGfdneRcPKWvk5QO?=
 =?us-ascii?Q?xgWFQytyjK+TVxTGXTuL5FNy3KlKU6v4AoQaoYM1wbrE25acre+n5IbHaYUF?=
 =?us-ascii?Q?El8KAy04pvcFZO7FfxAjrHI6PXBLvh6KNgOHprJTZqx3uKn/8nZc/pbSy5a7?=
 =?us-ascii?Q?6EERAwbrKdemkH8gOpqcDEGb4S5iOObb9CWP6chpe7whG4YCl4tF8OrsT0Vc?=
 =?us-ascii?Q?WNu3tyIoJS3Twv+0xkHIeiXOxLDkjUWR9n6iM+8GEsgSqU+OMgoi1ConUBgR?=
 =?us-ascii?Q?jpBKwg7zsAotvXmu5elJLhLh75mVW9CxtO3rSf1UYe7tnWcoODU5worVQnEL?=
 =?us-ascii?Q?NO264WxPL9LwMk39l0DhTJRiUSXc/YDr7KOBZ6E6LeJTeJOpGy+AWiWvX9qS?=
 =?us-ascii?Q?sExfkDR59u/l0VitvoA8E0kFxxiNZveG9RiW3CVxBmnFxa1Bd4AipQL+8dQw?=
 =?us-ascii?Q?wuSci9y36dACvqqsuEqF93t1hwMgh0Pi1rN/0WzwG7xwMJOCX9UjJTXZp3jJ?=
 =?us-ascii?Q?3D1L3dW6XN6Ty2yDJ1puA4GSaOA/So/QXJWt71Pnv5HZSdPhg63y3ExTrlru?=
 =?us-ascii?Q?sanqJCQQsnGPM6vp8Un0gFPvMuJjKQP1VHsytQQjzReO1OeNXok6HjLo73gm?=
 =?us-ascii?Q?N6B6gxfZuSsb3PYXQsp94SF7Ck/hnXFzzclEwBytFCEkN7sJV8hi9CnVP/FU?=
 =?us-ascii?Q?hSKv3YpKs7VUEz+FX3k+WNVLdFACPoH4eMNj5dbY5fy3FbJiGnGReeS4P33k?=
 =?us-ascii?Q?1yIHjdslH7qLZwWSyAjIxTi7jL7/nUQ24IqRuu9AegqvDLwelayXx9BTeVBM?=
 =?us-ascii?Q?fd9IC0CzCK3OPk8TxLVn5sr86Zxak+3PyGfrRm6DiPvYLsmhgRsfTJg9N0cd?=
 =?us-ascii?Q?YDTYq/N7wQanOBNyluGTc/N5HvPaK/yOu6qTmn5FpbTr3/D5FHsKczmw8YzH?=
 =?us-ascii?Q?PrkRRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(30052699003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:58:33.1307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c61fc385-8a11-45a7-225e-08de57f9b543
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7647

From: Jiri Pirko <jiri@nvidia.com>

Document shared devlink instances for multiple PFs on the same chip.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../networking/devlink/devlink-shared.rst     | 95 +++++++++++++++++++
 Documentation/networking/devlink/index.rst    |  1 +
 2 files changed, 96 insertions(+)
 create mode 100644 Documentation/networking/devlink/devlink-shared.rst

diff --git a/Documentation/networking/devlink/devlink-shared.rst b/Documentation/networking/devlink/devlink-shared.rst
new file mode 100644
index 000000000000..74655dc671bc
--- /dev/null
+++ b/Documentation/networking/devlink/devlink-shared.rst
@@ -0,0 +1,95 @@
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
2.44.0


