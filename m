Return-Path: <linux-rdma+bounces-14687-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D64C7DD0B
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 08:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C07AD3487D0
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 07:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781A62BE05A;
	Sun, 23 Nov 2025 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oBBFkxnx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010054.outbound.protection.outlook.com [52.101.193.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C766296BBE;
	Sun, 23 Nov 2025 07:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763882621; cv=fail; b=TCU1rVipIR1A7PI3Y5VYKwYBfO3O+nSAVDUaDNiaKNojepkEqA1wKJ36gPcu6a/MQSA0SDFX5o03dvANn6Ovw585WreXosm9p4C72Um4MxoMvgl15vt9oudtzgfWW5XDmJTwX924uxPti5rGHiYJ3tyw7BJF6oechYKYDt2vREY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763882621; c=relaxed/simple;
	bh=Qkb6pNUnyaj/v81+ET9DNUBziUveBX//R0BNmlCVy9g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwkJHTCsW3OroE5qdpyLZMW+o/YC/3CAAgO9L5Eu0ntFFjb8w/gFswXEDIMxp66AvN5GLXwmay2i9ErC1Xer3SYdHJUX0TW231K5YnULAFsWxUc34xqWz/udEoGtxkAIbRaTPMJIqVx4SN75TaTuyuCA/7SN3BLnvxyNlFWr2UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oBBFkxnx; arc=fail smtp.client-ip=52.101.193.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJg3bOYuY6Y3HjXPY8Ewa/4/5j8Nhtg51WezMRbbrjbWYINoR3DynlyI6SHhbrh3WAwMwZDSDjpM/H42QcQ3FjGUxWIUsA+u2+BDZJFPGadmXg6svD5vjm+gUZm4jkmqEOtJ8Cq3XuHFtopyIfYF/Qh95T0mVR0DN+hn1k+bLMVCBUiBOleAR6ive7PS22NYpM8PwFy9iP4syPcH0vuxutRXXhH16ukska4kO1c/GaxU6taJzz9/wYdc648qmJK0j8MI1WDB1JKt4DcHeqjggPfjp5SBgArxVbgxSK65JpcFLOTysL6guv3qBlXc0mPjbQUFHgs3pggs2NTqsKBpuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dB0KCazrhTv9T4oxZp74zais9T3F8hs6VqNcq2QNfQM=;
 b=A43m7XZpGNG/8tDF4D00iwfYwSai1JeMaCKwZt+CN44Aa2lWVYGYNdsld0kFqWDb9SIKXDPqEJZTvkcsFZAuddcUgB0/WCJ6GvFGh3Pc8Fbp6nEBg5enTRYZs9iwo1aoOy2+rhR8iqe3KFWSe1FY/xeIYKPXJHfH65UL6xmqy4oN/qsLlefpu2xFywS58sXCeSjnOat0nZjJAfq96mqL+o+IIAPTcNc74OmeSZlXImgEJ6EP9T5+ezlh9DVOvOIr2CseogPOkF78AAO2YDD/8giglQcDPQKRl+zzcLLzOTjAVKJ8g98BHJ6ARiD9zvoHtkVTDp0CdWWiqC9yBSgGtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dB0KCazrhTv9T4oxZp74zais9T3F8hs6VqNcq2QNfQM=;
 b=oBBFkxnxYy2oTRfYoGYEEgNw5Bjm6sEH7+z/ZN9BO64HSVlpaixpXGoXZRdSaJqbmpB/hUo/vsmlFwF7QDvjyg6VU7pgUi4FH39FJp7msbHOPsE16MHFms1Qo//ldxXovVvnCjXHs3ccsZSHfMjL/f2ohgA+mJwQ6pexu1rb2aeGjgPMpmdsegO6G78HFd3NamXREvzHvN6iWMJgzUaUDxPW9TpWcr0+9rtSbDJD/aFYwgGdHdMYjlajILaNSRW4ojC54mponCeiM3nUSRKi5geV5IiUSk4x2fMGtPe5ZloZWONNyVISxj80ZJnh0MTp3cPhoEtRswUoLMwz5nk4Sg==
Received: from CH0PR04CA0021.namprd04.prod.outlook.com (2603:10b6:610:76::26)
 by CYYPR12MB8891.namprd12.prod.outlook.com (2603:10b6:930:c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Sun, 23 Nov
 2025 07:23:32 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::a1) by CH0PR04CA0021.outlook.office365.com
 (2603:10b6:610:76::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.16 via Frontend Transport; Sun,
 23 Nov 2025 07:23:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Sun, 23 Nov 2025 07:23:32 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 22 Nov
 2025 23:23:24 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 22 Nov
 2025 23:23:23 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sat, 22
 Nov 2025 23:23:18 -0800
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
Subject: [PATCH net-next V2 02/14] documentation: networking: add shared devlink documentation
Date: Sun, 23 Nov 2025 09:22:48 +0200
Message-ID: <1763882580-1295213-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1763882580-1295213-1-git-send-email-tariqt@nvidia.com>
References: <1763882580-1295213-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|CYYPR12MB8891:EE_
X-MS-Office365-Filtering-Correlation-Id: e8b08e2a-b99e-4724-11db-08de2a613531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o8QI8FrrPNMjFIKJhxxr/UL3S6S8THTn0zfAuYgg0JeMIlPZTjmGLLNASuDz?=
 =?us-ascii?Q?l8aCH1PQvz3/kiv8Vf9Pk9nsSNoIbxAQkZIxVIb7x5whHSng50JQw+rSekdV?=
 =?us-ascii?Q?10D7zD9w0PZ2zJovFeLBd7+Q0TP9+yEP/nReqTdiUVumv9omKIpEkGGuKgZ5?=
 =?us-ascii?Q?vh2AT6tMtwuUWNIIs56bLNObcKYwSYbN0RCrv7SPzG0yke+mj6mLQ+hRZde7?=
 =?us-ascii?Q?4bLsibpA5pYc43rJS17wAWv77vo2pzzuHGNlW0LzNIdZPfke6mbhFGU//7NI?=
 =?us-ascii?Q?+vrplpSw2oYx3ZBOkIKI1B3rDnSEc1xqkb9NiOM3nO8MkjU4iY0tN50yuHqN?=
 =?us-ascii?Q?6e5iUK7OaE3Fhl0KhI4kGZFDGKwwGnBmCRMCS6YZdRzHa2QY9o8lMfOWnI4B?=
 =?us-ascii?Q?fRivcFdEDeFXMaiqEZqB2ne07PEDM0ucSLyHtwLYkV2ZuoMSgqXwIFMDQjMy?=
 =?us-ascii?Q?bIN3fxdsTOweq4T9fPQO7KmADdsIDomV/+sp77Ag/G6OAjV5xA86q2r9hcFx?=
 =?us-ascii?Q?vgfiph4P2n3EfFmyo3m/ZWSGnohf7vc/F/pKcsutI97RxPEFM6t/AVn/VPxM?=
 =?us-ascii?Q?7qvWfTgBBaoo68IrQmoGYdWcoFrZokMNy5OfTtNQKdBHtP+IOSBVvAJzxRw0?=
 =?us-ascii?Q?gmJMvLoIXP+PSscPorKs7djMtg0ncs58bNUpg/a2CpSBrMNk+ozuICg9ppGX?=
 =?us-ascii?Q?52bS4Gg/vBOjiMeYSnCxA3ZCRxpcolRZdMnmdWPfiqEpZnbcStgVUiys/geV?=
 =?us-ascii?Q?oK5yqnF0lERokT4llqcOeTKNCt039EHLOOizetsC0oj6oCx5Y9xGjewOsvz1?=
 =?us-ascii?Q?okuu4WwtdXrxA8j4p2xZgawP+b8NgYNyPfWMDGAel9OewKeyxeH+n/+fsFfc?=
 =?us-ascii?Q?mFEkCHomoxzjwxPErX5Og4/b7QbxGgBk1P8eChgVBLNIfH9QOuLqMBILXGzL?=
 =?us-ascii?Q?U/O0eI/7wregl7BFA2xTZ7cPVaL6V71a7p5IzIweov+e87oEXxjv0qSo+F4e?=
 =?us-ascii?Q?/1MEfGdvZusgShLNr4CoKIGKl8C7RRRtw/xFaxtIFxE+yPUgSR1eFYMt0pZj?=
 =?us-ascii?Q?cNyu04SJ40D9iu20RyTVmpMhsUWfYVHZemQZbFKdVo9ywIfhtQdBrwdJGPvA?=
 =?us-ascii?Q?3/S596brXYzaXe0JzAFCkN76qe5tMB0Sveb97iG0z0ClFnZZ35Pl92nvZ2c+?=
 =?us-ascii?Q?wsx+tuNltud9OwB6HZ1lCMZHyJlZkh50nWQ271SmHzBpms9gWpFMN86Vfv5K?=
 =?us-ascii?Q?7xVTlzSl9D6faxyoR1mO4z9+R19/5Fi+l8Ppkx+u2GfZ8IDkBL12V898m9FX?=
 =?us-ascii?Q?OozDMLQEQUKf8JzyaLIrsCt/Nff1oTHR0/0EpkupbyTlrmO0ELXfQIBzyVH2?=
 =?us-ascii?Q?ZD4m2c2t/c7LsqCt+6nCJztNMqYfrR8T3EaHqWMhUjwc08PE+g5f26/zc/38?=
 =?us-ascii?Q?4wa/7SAeEBBvJTz1NFPRae/1QhjKOVVCbbdeMFeHlXKjYoYclhPt0cl5OMYr?=
 =?us-ascii?Q?Y+2kZMhDyRRrGRvB0rVR3SEgQd/t9Y1ghDWB852ItKPPink9gf6o4vQjQWcu?=
 =?us-ascii?Q?ms3gkcsKxmKJkHGreYg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 07:23:32.4242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b08e2a-b99e-4724-11db-08de2a613531
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8891

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


