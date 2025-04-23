Return-Path: <linux-rdma+bounces-9721-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAB9A9876B
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 12:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 809F9444498
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 10:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3607270566;
	Wed, 23 Apr 2025 10:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a/WFgYVU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C531DE4E6;
	Wed, 23 Apr 2025 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745404271; cv=fail; b=ZWQWTCHkN5U6hJouWR7udY2Pq+/Rv743WtaddT7NAzvASe8yoellS70cuBoiyL0n5NJYhnNkb8WNWYjNCWAqOu9tL1g9noSQBMR94O8wNHxL6VCLwHMQz/LyyrCgikQyeU60WUnjjb3RMFb1JKOt3mg57qeAqyum0nS0VTSzEmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745404271; c=relaxed/simple;
	bh=JlEz5WGMcigDCsewheJylPUHLXoNiSrGoBGpt85gZxA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C6b57R2QN119bGJydkOXCg+S808iTYQxg1e+fMPtC0ptRammqsXaWFH3N3fvf7pAM3R2SSIUACtW5HKaZ/IvFlhy5NGa01xPRWASspi9M3SuyfUV4SbwT+fYpPh9yqwcrnn3Qgl0lZXDfr9uLYKgJzGIhzj+Oq6EMmJwtYYsTIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a/WFgYVU; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkdwJp/oScapzEWkHRX3hs1PGOieQTmLBpBUV58jRhKcDpIYL5cytv0oDzacbxcmONZONYrI6Yopc2MdWrtX1hjHaUxvoS/nM1Mo+a4czGCHBcdOhDCsGNx3DzUr7i/h8z47+TZn7h5DSr7Txu8mLLvbpGCbJvDAoWtgKJalfxxUB8gCj2Hy6mPVpeYFtDD5TR8UJ2+ALxA4nSvOA9d74AD8ZvR85+VL8qBHmfFyOiViqGojewKzjhBFGNEPB9ZPO8Uy7rgdf0Wg+SbHMwmyO2OF0ybAU71pyFIPjA8KivFYowF1uI/XqLC1QEDUcHpEZ/LjkgC7DEPlszhPg2HKgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMIJULS23VTxOnvDN8mze4OcB/b2blxiCJKUIGEVwsU=;
 b=zC48J/YLFyMu/jLUpAj99PnFI6wKKf/c2G9YxNfj0YThhXzGKUVgoNxk6CPd3Oyfv6PHX2rjsS9m2sZYaV2suY0B1L0vC6nL/6cmsEndsIJh4sigT0iHWn9NiF9rRydkAdVHXg/7DxeD4vfBbmHEthvyOJSt+Lqdwb/H/SNTLv9Dmxpqg0Ax0gWg9Y21jXGEjAGb0NjLeeLVnUurcI5uxixqz9dy9EclYwfb/X/4hPYFUZcRmrPL1d7mi0xDnbK5NxUtKXcEAtun/WzdZbFNn+8lGBvryH1zPP9VeJUKioBzT39fsb55fsKYdB0wMQFHWyIGk5Tp/CJGJo3yRJZGUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMIJULS23VTxOnvDN8mze4OcB/b2blxiCJKUIGEVwsU=;
 b=a/WFgYVUxSnJw5+IFjSOEXhEy9dC8DYrKU/3/bTVsNuLr3t6keNJoRJGjmTBEW4YBekq6vA3QKQ9wQrgw1InAM9906rKzADkphDn+uelyzruRm8og4SpLiV/uvQRJ86/qi8oYhyRzVz6fDosOQR0+OuNNqVJodSM2RvI6GZJmys=
Received: from CH0PR03CA0049.namprd03.prod.outlook.com (2603:10b6:610:b3::24)
 by MW4PR12MB7310.namprd12.prod.outlook.com (2603:10b6:303:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 10:31:06 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::5f) by CH0PR03CA0049.outlook.office365.com
 (2603:10b6:610:b3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Wed,
 23 Apr 2025 10:31:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 10:31:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 05:31:04 -0500
Received: from xhdipdslab48.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 23 Apr 2025 05:30:58 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH 06/14] net: ionic: Move header files to a common location
Date: Wed, 23 Apr 2025 15:59:05 +0530
Message-ID: <20250423102913.438027-7-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423102913.438027-1-abhijit.gangurde@amd.com>
References: <20250423102913.438027-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: abhijit.gangurde@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|MW4PR12MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: e6c75609-75c5-4879-fa6a-08dd8251f422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zEv1FwUUKTOlRrZH9CJOf2CHYPWAcKd9V8SeHPvkyrwL3lr28gw2KEcrY/jy?=
 =?us-ascii?Q?9sleZ7RlO0qnH/c5gVvAxhWtSkSIazcmK2LVy5SqiYX1gUuF7VriYlMyRKF+?=
 =?us-ascii?Q?YMd8KPSTbvEtaoKRr7Uy+dOvigpdLZNMiaVKUaw3i6dvWE2N5CfalXeB5kxs?=
 =?us-ascii?Q?kXFhRFI5xGJBDpVKZao3PsuZ1/gX9FDvmhoh7XD7XctU/QnFHpouf7yxczAG?=
 =?us-ascii?Q?0vQVBI4ZQ1aySiNvfKELI2rFobsoxZC8kPtg5okwII0OLzB7/UzlDOZvjg89?=
 =?us-ascii?Q?AuHSk1ny0+swjrysIvrcbYKew+xXl+EP3+duKK+kQ2sNm81P2ALOv6HL4RZK?=
 =?us-ascii?Q?ZbBsn89Uo6otfmS0lQ3G+LIKv2tQsI/RrX+YBk6FB1mu5coxc8T0t1LCOif7?=
 =?us-ascii?Q?ClnUC4fGk1PzGJGPj0Ga/7gacWfCccEephK8kmlarb0VBvFVJQ8qiXQOLv3e?=
 =?us-ascii?Q?ykpwKQOghTPEIrYWNSnEE3N1Tg8h+f5K9QuloboK5Q3fCO33axhhoXyZWNgX?=
 =?us-ascii?Q?DbPAzL29MKKX3xd9r9/293lY0CEAojEDCizPoyx9QZkrBjpnSAIjPX6ce5N0?=
 =?us-ascii?Q?1I4DpND1rYx3EOYq2Jy1Hah6GXdztjqCYIPtlKFu1iWCv9XoGxrchPvaFP4w?=
 =?us-ascii?Q?LFR/S+y/DxY2wWKDOu0g9ppWKLCM7MLohZXtoxAGlhqrAcC5EaXZOGoaMBUS?=
 =?us-ascii?Q?RGNoaYU8Hi2SI21RQfBNQuh9h1vHZDnTrj1RQd4OnT5hJI+zPXqsG7IWNzkL?=
 =?us-ascii?Q?tkHGweQ8wNbFoFc+252Riyg0OLJfeYUAj4TLfgLMyRWGbagiToGKJuX+qAF0?=
 =?us-ascii?Q?9SsDdAICs+BluOVEGiH9neU3650u4e0nNuGUXQ5kq3+Tm+NTa8aW4laB6lsJ?=
 =?us-ascii?Q?8WpKpIkhUPzL4DwsePIcdTRLDcFO+KXCsWTSxQrEd7hC5w6MNRWVCUQq/PBt?=
 =?us-ascii?Q?sspxdb2/ejH1qH9KxbivbJfzFeE4fTmR41RJQUbnuoqq6uB6JeJfvQEuqtMk?=
 =?us-ascii?Q?Ytub2FbPUsy7AoyDU8ZJfd8AetsvJ5kEQT5n49hh99izXBqVLTr6mj/sfPjr?=
 =?us-ascii?Q?d7GvOyJEqvdHjCXYxyxOzwBQV6Fg89S35LiE0HPmo92WYcHuMxAZZWfAq+iC?=
 =?us-ascii?Q?xC0kUUui3OUMWRE+3Y1o5KBLAnX+W0TMPJ/WhvYCs4UgUr7aBCSzVRJRmcZx?=
 =?us-ascii?Q?krGr+15nvY6jhhOXXfKjaiumxgeukgUTWNZsbpVftxFGMhBIy6LxTgXIQkA+?=
 =?us-ascii?Q?v2SWtkzI2YdiTojM/QjNv2DVSr2iUWPfGUCImrANN0PnJDMQgOsqXof9Z7uL?=
 =?us-ascii?Q?yNYy+aQdXS3seE2kbC3IycDfAmRpzlb7IoOo4lVo6zcTVFZbb1Ws5BehVrg5?=
 =?us-ascii?Q?pdBTxlCp5bZOJwMauMFqx+bPmYwFB+RbOjZBDHNOPPVq0cgyXn+jtxufgELQ?=
 =?us-ascii?Q?rpYX5COlHrZV44Spisr9KqiamIFbepL3UOR92IDrG8Ygq26+Bo2NSxUEhRDd?=
 =?us-ascii?Q?iqumdBTxI6M+6T2OHu6ib9nAFJLRjzWKaG+lZXCwDrkL4feISzLG6Ael4w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 10:31:05.5748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c75609-75c5-4879-fa6a-08dd8251f422
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7310

Move the required header files to a common location
for use by both Ethernet and RDMA drivers.

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 MAINTAINERS                                                   | 1 +
 drivers/net/ethernet/pensando/ionic/ionic.h                   | 2 +-
 drivers/net/ethernet/pensando/ionic/ionic_dev.h               | 4 +---
 drivers/net/ethernet/pensando/ionic/ionic_lif.h               | 2 +-
 .../net/ethernet/pensando => include/linux}/ionic/ionic_api.h | 4 ++--
 .../net/ethernet/pensando => include/linux}/ionic/ionic_if.h  | 0
 .../ethernet/pensando => include/linux}/ionic/ionic_regs.h    | 0
 7 files changed, 6 insertions(+), 7 deletions(-)
 rename {drivers/net/ethernet/pensando => include/linux}/ionic/ionic_api.h (99%)
 rename {drivers/net/ethernet/pensando => include/linux}/ionic/ionic_if.h (100%)
 rename {drivers/net/ethernet/pensando => include/linux}/ionic/ionic_regs.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96b827049501..76ee6f5004ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18874,6 +18874,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/networking/device_drivers/ethernet/pensando/ionic.rst
 F:	drivers/net/ethernet/pensando/
+F:	include/linux/ionic/
 
 PER-CPU MEMORY ALLOCATOR
 M:	Dennis Zhou <dennis@kernel.org>
diff --git a/drivers/net/ethernet/pensando/ionic/ionic.h b/drivers/net/ethernet/pensando/ionic/ionic.h
index 5abdaf2fa3a6..c591f6910efb 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic.h
@@ -6,7 +6,7 @@
 
 struct ionic_lif;
 
-#include "ionic_if.h"
+#include <linux/ionic/ionic_if.h>
 #include "ionic_dev.h"
 #include "ionic_devlink.h"
 
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index cf48a6cadfce..d404a83b6021 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -10,9 +10,7 @@
 #include <linux/skbuff.h>
 #include <linux/bpf_trace.h>
 
-#include "ionic_if.h"
-#include "ionic_regs.h"
-#include "ionic_api.h"
+#include <linux/ionic/ionic_api.h>
 
 #define IONIC_MAX_TX_DESC		8192
 #define IONIC_MAX_RX_DESC		16384
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
index aae4824d08fa..18b2a8a0f014 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
@@ -10,7 +10,7 @@
 #include <linux/dim.h>
 #include <linux/pci.h>
 #include "ionic_rx_filter.h"
-#include "ionic_api.h"
+#include <linux/ionic/ionic_api.h>
 
 #define IONIC_ADMINQ_LENGTH	16	/* must be a power of two */
 #define IONIC_NOTIFYQ_LENGTH	64	/* must be a power of two */
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_api.h b/include/linux/ionic/ionic_api.h
similarity index 99%
rename from drivers/net/ethernet/pensando/ionic/ionic_api.h
rename to include/linux/ionic/ionic_api.h
index 22d9fbb49575..e8460a485f55 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_api.h
+++ b/include/linux/ionic/ionic_api.h
@@ -5,8 +5,8 @@
 #define _IONIC_API_H_
 
 #include <linux/auxiliary_bus.h>
-#include "ionic_if.h"
-#include "ionic_regs.h"
+#include <linux/ionic/ionic_if.h>
+#include <linux/ionic/ionic_regs.h>
 
 /**
  * struct ionic_aux_dev - Auxiliary device information
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_if.h b/include/linux/ionic/ionic_if.h
similarity index 100%
rename from drivers/net/ethernet/pensando/ionic/ionic_if.h
rename to include/linux/ionic/ionic_if.h
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_regs.h b/include/linux/ionic/ionic_regs.h
similarity index 100%
rename from drivers/net/ethernet/pensando/ionic/ionic_regs.h
rename to include/linux/ionic/ionic_regs.h
-- 
2.34.1


