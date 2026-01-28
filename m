Return-Path: <linux-rdma+bounces-16134-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKOZNOnyeWnT1AEAu9opvQ
	(envelope-from <linux-rdma+bounces-16134-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:28:41 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7063BA0637
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D7041300FFA8
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 11:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940C334DCFF;
	Wed, 28 Jan 2026 11:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fD9onBhi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010010.outbound.protection.outlook.com [52.101.46.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42E334EEF7;
	Wed, 28 Jan 2026 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599669; cv=fail; b=Qzg/+Xmi11X9/QXYc7Hrms8MLMKUAbOg7+VWpntnimQgYvigV/oyeXWafj8zx5y4yYOfOkcIo74qWQtUOkOkg3BKW0tkZCeyYVWmvOK7Y/kJsVE4pRRxkFYcg+1MMQ/tvKLZt6c5X9Vbv8uZPL8LUkcliajQNzaB50TBV2Gl/P4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599669; c=relaxed/simple;
	bh=Px4IPIY6SwUyEEZFZ/FdSudSxntNHlDUPcL2co0azRE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tQN5Tzyh7efYOocLwjHv9Xo1FHp6w82oQRAgVWtm1uc5yngUfZgfTVfzHJe4l6Nkk2ExDUC/Kxzd/P72Bl/YeHO4q0SsiW6W8TCBVfDPYxadWwA89cM0f7CxO2QK4u8eyn2rrsRLMDwJgnKlA6dRSfik8BTXWiYXMIfUNl52PUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fD9onBhi; arc=fail smtp.client-ip=52.101.46.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yyzOGg7f54OHzEYRCkeHOLWq6aofjgICIV4zwtSeB8eovIFgrYVUfy1oTeiAzEDJU0FhvIY2Np+2xI2i4nVqdqCvrGbs1ZIhicRapAsrksOJlpzNAqylEBO5cdkTIMsOScG6+7CsD3uZrUoghrp7HyjPaZI3qSZSC4l8cxvzFfeJYZoddBKgOBk0i+zdLOFGZ1a/wl4Axm4svVryfPBGpl6f0u8R/QyH80613VnGB9KwCXXVLZSSG16Di01huetVv71um4U5EPdzM1V3ir7IjGqjSl5JzmK9CGgJ0JcSIUj+BVJKctKMZzuy+4XZaV7jkFnpwc522OEou30NB87RDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYM8Tenv7+fBmCxmfjmrZBh5DZ7QWZYDmeM5IxQxc1A=;
 b=D26iLKoDmrGcAD5/T4zy/bPhhSm8CoBvoURVwVW6/+/C8bwrCavMddQq4lGdlpUEvmrdMyp7Ral1GVkZzNNyxvYHjvnDzMQZvxpn33F+5aKG2FbONR/dnpZmEpWtkVJTlGXpBHi4bMAwwMw9Lf+n2XJyAWiA1HR4QBwWlRReal+bu6Pkc7DyP9fIC63f1d+1Bf+l1DEpeF1c74v9mgrhm2eMD1nu7zy6YiLLg9gkR995Rq0o2ymm8uRbgkqLIWiuUkKfulPTfzLb8ZwAFUyCop5GpqLIVqdLomiORGregabVMTaqrM1KaZfG7onfkFVcVgE46SBlecjNhDmVGvrQCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYM8Tenv7+fBmCxmfjmrZBh5DZ7QWZYDmeM5IxQxc1A=;
 b=fD9onBhiEmoGOqJvbbIZiNztu1uSkiQ9HEsE7ovR3OHm8SvZBC70+z3/FJkvAgZf2aYVPq+HRJjyB3p1PfHCZIT1B8KB7tM1vydH0lKOl5z/nejWOExdEf0q10HRZkHZDRLSwxb973t1EIp7gvKLCRwf/ZNjvmzNf9R9CtFRJpFtcSa3D7kttHCr/MIkhy21A3/bLXwQHTObXSb1Phbintc5duyQVjgyO50IvN3+j913gg3zog1mWNCVYlHc0G55m0TD2FjMXwFAvzsirlwkN6u47MawLzBR78b47+EVVmOHNa9HadraQ8C8px2Wkb6rK6Dztk/HaX+Oy9r9K8Kg0A==
Received: from PH8P221CA0058.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::7)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 11:27:43 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:510:349:cafe::5) by PH8P221CA0058.outlook.office365.com
 (2603:10b6:510:349::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Wed,
 28 Jan 2026 11:27:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 11:27:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 03:27:30 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 03:27:29 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 28
 Jan 2026 03:27:23 -0800
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
Subject: [PATCH net-next V7 01/14] documentation: networking: add shared devlink documentation
Date: Wed, 28 Jan 2026 13:25:31 +0200
Message-ID: <20260128112544.1661250-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260128112544.1661250-1-tariqt@nvidia.com>
References: <20260128112544.1661250-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: e90648d8-a89b-4b15-ffd4-08de5e604096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|30052699003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fIyd+suL6H9ZikbpmAaviSVyPhi6JUFOM34zCPNmv0yBTSP2JdcdVOBKm7pR?=
 =?us-ascii?Q?QnzDn9ehevOmiotk1eoI/Xlw+rhLwvwlPgW+0hz7/YSCMaXUluJgj5pXHWAq?=
 =?us-ascii?Q?23DsLWC5hqX7EzTzxDeYuZqKnts9RDN20Yqt5KwGR6YeN2ZVSSkbph6kTuOm?=
 =?us-ascii?Q?gwB5026RmZAzV//9UbRlINQ7GopGHlBCM5e0ZWBOUKNxTROoXSv0hZhtg52l?=
 =?us-ascii?Q?u4jnUXT6K+FPY3hlCyXzPuwe5pzMG9fe1qKz2NiOQOT5RekWdV5vK/xc7VzG?=
 =?us-ascii?Q?5GvH7DBw9T5wPvboP8giJ6nVccQb2Vex4WmF1iloGICPvTu2QhQFPMKERxMI?=
 =?us-ascii?Q?Ht0TWzD9qeKSGkxredbEF+HWlMmlnvk9CbXuTpabtJlDhhQrWJq8tNa7G3iY?=
 =?us-ascii?Q?Ey24yqJOYnjIy5PZIyAsYjsYKQGGFAS6F3Tz5CEV9+bFdlboqZ8fBLT6mEWs?=
 =?us-ascii?Q?+k4eBOhISIiY5/wqwz1Xc+cbrf1oKsW1Kmha59/w0voCVVwQRO96W7fxrjIn?=
 =?us-ascii?Q?xWWGjH6rC2JLZu3QiGz+nJvaPpqJozk9wvA2N23zVtVbkzBvXI8bJ8Xx+i3g?=
 =?us-ascii?Q?W4QnMZa9z98rJeGpXYuQZnayoR+lWJ0Oc8LYMowA2sRyZgkdoWI8Jen6mHOJ?=
 =?us-ascii?Q?rn2d6Fnf4DtEXbEBGLJ/6JhFjYNmLWFVi2mDAqE5MLcBL//dfLbXvuBAeoI+?=
 =?us-ascii?Q?5YrAzTbOp6qVREyrOP0u8vF7e9zS3O+jGwh1wb9WytSSca3vvaIG3xlmWqcb?=
 =?us-ascii?Q?GWN6IwKZuX5A7iXR6SVe3Ef6qPqCuQuDL/AD0frNEA7zHPoEKI/AO+04esam?=
 =?us-ascii?Q?7jDcYOFso6HH+AtVbALZmTEcExonH8c/7tcRlhDji46hrrvxj5ISEnQa5cfQ?=
 =?us-ascii?Q?Ebe8mOqkOMyGFuDAWFuvk1pJSHZpY3yTPLn+NBSuMmvkFeRurjY1GxhSzHHL?=
 =?us-ascii?Q?9Nhakxu29J5RWmQBsVgjeqJuunl2DVbwDD/o5S93aLxzMy6Db38ik3N6gJXU?=
 =?us-ascii?Q?QW95eNghA56lfrnk9axzQJFacFbZq5YNP+h4RN8FwdEDJooxepO//rsrXY2e?=
 =?us-ascii?Q?M7rmGooLfVo4oST/xGuU6Z8dOW6WEiRABJcexBVTfRfJ5PApbCrCwboNF30a?=
 =?us-ascii?Q?y3nnA6CMy+YZCrnr0u+Sy+96+XWM7/ULAEbvKifGNv5NDpPBjnB++y9/z3OY?=
 =?us-ascii?Q?/PzCcX5i6ZtPltMcM4RNzLyXtk+QF462BJADo+cAWFcJbfvj9N8rjWz2BluD?=
 =?us-ascii?Q?GxWIUPsmbZTBG9M+G12GgsbS5f02XY/Ro95L9EGqO8JAQvHma1msAaPYPgLk?=
 =?us-ascii?Q?ESfxMV/nyQhZ5KA/WKvM0181mb4pfSCrn2mluoAtM3Kcrwj8Qa+4WyfMYKBi?=
 =?us-ascii?Q?JvBPQplJI+9UmXlxTIa+kXh+TL4pXEzdTru/fV5n6JzNHmz/8axTiG4GrT9l?=
 =?us-ascii?Q?QEAhIOjqdwiQNP8/Ir0P3XuyT9DlhojSx/g1LM4UNShAvX0VR5X5C7Fu1YRk?=
 =?us-ascii?Q?r9BAa3nNdBUvCEjwwiT1MNiHcNmPK9vDBNE76FaN6XZaUuWNAimGTadAZLCx?=
 =?us-ascii?Q?M2LIKsryDRVm665HQf4GK6gR6KXXt+IRu9SX5pnIr756/T6v83uiMLa4Jihz?=
 =?us-ascii?Q?HzxhCiX+BA5Tw+Nn+TOs5gowFCHHI2D2klt33kUCZ8H+GvXXaTcvkfklPTxG?=
 =?us-ascii?Q?TDvLSA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(30052699003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 11:27:42.5306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e90648d8-a89b-4b15-ffd4-08de5e604096
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org,infradead.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16134-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7063BA0637
X-Rspamd-Action: no action

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


