Return-Path: <linux-rdma+bounces-20047-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGuKI37B+mnRSQMAu9opvQ
	(envelope-from <linux-rdma+bounces-20047-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 06:20:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EAA4D6153
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 06:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D51B13047DE6
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 04:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235C32FD68B;
	Wed,  6 May 2026 04:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uDZwHRhp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F032C11FD;
	Wed,  6 May 2026 04:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778041204; cv=fail; b=EgXGJ+Cbl+nyi1KHIrblJzz7uVQgtQfDxMKsp0yXnC0UdnDBS2l7TfOl5OdW5SM2hwQbto6x6nPjRLbtsF5F+Uh9F3hStu5lhA2Jut/BlsrKKMW73chpWs4s9lhpSPl7wTIvFHHEezNuMm2AoB+wUZ01LHk8uJUCdq9/+w3Inb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778041204; c=relaxed/simple;
	bh=N83lk0wX7xT9+7rVXinkIDUSvEEW17b5KUHLiI4UHl8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jFIobXmA2A4OD6B1Elndma3UdCEriyKxHvTjjc3j5ejKDdM9Ycbxp4tFgTn9fQQl38mCfrdI/p7Y0BDijDhRwNV1RPLwp99ZR2vQRXyVzgnkE/5NU0EakWGuVBljEEjA184rBsLo6GeQqInAMAOkSgP5lndMMnv5blGGD2maNGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uDZwHRhp; arc=fail smtp.client-ip=40.107.209.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNqFnavlLSKUWTd4+znzOcgr/hOKs2WBMXj5NDkYa1zwcExXBXVQ3q3D33+oU565L/RhZHiLsgP3VCEk2SdAwFP/BrNg53RWll4fbR7GtpWBIOIzMsdBsigTSM5ndI3iFD/uhfhNuKPuHqduNQXZaL49qa6+jjDJS/KHYnh/lvRsrms2AwP8x3vAWiiSUN3u6a2L4VddGnxupz3sj+gCeyeZlb6tMp1RurQXCyqz2gDdDAVXwCtCdUc13vG0h9gCXs/5OxGSyp+ZF8i17R9+fQuUCdfxaW8Jxh1syKziHVyUfI13oMB+HhSx3+7eH+riPe3q27w79i/dCUXvvL8q7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2N/hiz7Zg2lo/6Nyng7DTYEq2hpdjpPKxiPud/Invk=;
 b=eGTgiXwj2Zp64Xr2Oehs/5kbWb8h44HgQXaVB2TJRYGHY16MnpWYJvM3o6F4kpULQSqURYDpWAkFBbpgFn3QDDehCuGdWCYuvxPfkrpXI8RhiTeDjxe7S0nFy0qRxvLLiJjnQAiTUicZGMekh2rhRA6xsE8OU4WpevpBTyvrCkVtVZJDMn8MThnpmd2BqKGkuOdIhd737V1DmlUoKPLInwXYAiT+J19tsSQ575qrxQi/AcIQj/j8h2xJrTikdhZhEUuup/edFdhvxUA/dSX7tLZXXXZzn4ja9DodjDlIaXcZBW3V7kKGJHdDGm8VbKri31Mf5rkQIiP/NqN7Tb6uzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2N/hiz7Zg2lo/6Nyng7DTYEq2hpdjpPKxiPud/Invk=;
 b=uDZwHRhpZcK8C2t9xMnhqlEAqJtJoCh+0KlfGTPgQWdav1LgvRe0G3938u5lt7AitkTPDn87ovq4bjaESftQUBGsyegHnWMVfdGlKBG2z+sXDfKn7RWOI+Hf1jS2hFd+wy3+MBfgLsH0Qzsfc6kqQoXld8oCDWjo9cYpMMX577I=
Received: from PH7PR17CA0063.namprd17.prod.outlook.com (2603:10b6:510:325::27)
 by DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Wed, 6 May
 2026 04:19:56 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::37) by PH7PR17CA0063.outlook.office365.com
 (2603:10b6:510:325::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Wed,
 6 May 2026 04:19:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 04:19:55 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 23:19:53 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Abhijit Gangurde <abhijit.gangurde@amd.com>, Allen Hubbe
	<allen.hubbe@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net-next 1/4] RDMA/ionic: Update copyright year to 2026
Date: Tue, 5 May 2026 21:19:32 -0700
Message-ID: <20260506041935.1061-2-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260506041935.1061-1-eric.joyner@amd.com>
References: <20260506041935.1061-1-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|DM6PR12MB4090:EE_
X-MS-Office365-Filtering-Correlation-Id: 9582b7f4-b9e1-42c2-3a2b-08deab26ba7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	sURuw6BVrJhZ6Y+1QldXX9E3azOhHdPPS02o9vzAMoqAjy5lO3K/FBK+fV6Wm0KA0bYe27Bn4sNBpceMyVNW2IMfo5+4TQmIvajGpXZhBJ0qYbu6YtgP8lbd42gMxv0M3im4Ce7f8EChqlOaYJ3zOPPMfqyg8ozxEXQNUZzvL2qU11tAQu4cDQQ7jN2TT2ct6GaXrh8Ur0XGaenucLsrwT52qCmGYLWihATIuBHgflgKG1wborbstwU1CAH+zTHAi1BygtN4J+DySbvDrgDKtjG8IZ4IHcW7SWvijfTUzF3MIWFQ57PvJNKbjgdJgj47Qiz8slJX4TWAEJEZ/tVnu4JevthDECoZleAe9t4XH7PXOxEqLi7jLkbe7n+Kyxnu8eAdz/MMC7mypQowf47GsQQ0gA3M8Ihdrl97X1uTAg2l8X1jSw84dT5UQwQ4/DPeVfw/LBAHRc2yR4Yhvs8DoroBhyO0xEUkdgGYtMnsD7L0WacbYHWDgKQ2hi9B++gxseBT8vWXUP/Ff/3DtBl3SK3Mf7WxeYcUKsP2Qg6ozwrlIsI84S7t63xzMxyxWCforLz8PVckzc30TckRimYgTy3Sf8RGCgDad3ZIFJNf9I9Zoc39iWcXLj54afgmFBYS2geT06U6dPTFu/ENc1OEvkINgppCSFdzd4JevYIX07g5t4v5H4Y5/PMXT5/j7AE5o0GbwxHg2x1E/wsaJH0Jc5aIDH9ur0t2D5LUP8Gtqts=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vUBFbaEwKIM4G07vPLTLbVXBt5dZAbBplyeNoAyYWnwyL7v2CWE0nbPo6AUG88s2u+fuxIiTkV0RxqNb6Mk6ASU6KtijxYp+f8tnqeEARTRPhxbuRgsPqQoOaSceUmaWS6BvuqnY/qiozRfMO1Kkp6e59V4PzKOj3Joeh2fgXwri39pWW0GFQn9OZIFpH6IgdDMz+RkU+pT9Un/ReL9/alKINek/L8izpJ1wXYK1BTbDOHoGurNumfUBrYfvSboipdGBpJxuOJ9mO6aNfCXzvS82Mr0UZtbguyRiGN6EhjXlF2nRYMK+l4WdLpZIZbdb5xWCTeO6urOVUWKcVDeYPa6JsafyKzAW0wOG4ujLbiYm44dKhFIU9qEtq8IGrPqqnvenQR9VeFtpkBPKhSytAyIRe2yyg+YW4uF+/d+7kgD1NKh3vAj68xs0ARs9R+6n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 04:19:55.8119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9582b7f4-b9e1-42c2-3a2b-08deab26ba7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090
X-Rspamd-Queue-Id: 08EAA4D6153
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20047-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 drivers/infiniband/hw/ionic/Kconfig             | 2 +-
 drivers/infiniband/hw/ionic/ionic_admin.c       | 2 +-
 drivers/infiniband/hw/ionic/ionic_controlpath.c | 2 +-
 drivers/infiniband/hw/ionic/ionic_datapath.c    | 2 +-
 drivers/infiniband/hw/ionic/ionic_fw.h          | 2 +-
 drivers/infiniband/hw/ionic/ionic_hw_stats.c    | 2 +-
 drivers/infiniband/hw/ionic/ionic_ibdev.c       | 2 +-
 drivers/infiniband/hw/ionic/ionic_ibdev.h       | 2 +-
 drivers/infiniband/hw/ionic/ionic_lif_cfg.c     | 2 +-
 drivers/infiniband/hw/ionic/ionic_lif_cfg.h     | 2 +-
 drivers/infiniband/hw/ionic/ionic_pgtbl.c       | 2 +-
 drivers/infiniband/hw/ionic/ionic_queue.c       | 2 +-
 drivers/infiniband/hw/ionic/ionic_queue.h       | 2 +-
 drivers/infiniband/hw/ionic/ionic_res.h         | 2 +-
 14 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/ionic/Kconfig b/drivers/infiniband/hw/ionic/Kconfig
index de6f10e9b6e9..3fda9c46ee73 100644
--- a/drivers/infiniband/hw/ionic/Kconfig
+++ b/drivers/infiniband/hw/ionic/Kconfig
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-# Copyright (C) 2018-2025, Advanced Micro Devices, Inc.
+# Copyright (C) 2018-2026, Advanced Micro Devices, Inc.
 
 config INFINIBAND_IONIC
 	tristate "AMD Pensando DSC RDMA/RoCE Support"
diff --git a/drivers/infiniband/hw/ionic/ionic_admin.c b/drivers/infiniband/hw/ionic/ionic_admin.c
index 37e24450d129..6e3cf87025b6 100644
--- a/drivers/infiniband/hw/ionic/ionic_admin.c
+++ b/drivers/infiniband/hw/ionic/ionic_admin.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
+/* Copyright (C) 2018-2026, Advanced Micro Devices, Inc. */
 
 #include <linux/interrupt.h>
 #include <linux/module.h>
diff --git a/drivers/infiniband/hw/ionic/ionic_controlpath.c b/drivers/infiniband/hw/ionic/ionic_controlpath.c
index 7051a81cca94..850435ec0072 100644
--- a/drivers/infiniband/hw/ionic/ionic_controlpath.c
+++ b/drivers/infiniband/hw/ionic/ionic_controlpath.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
+/* Copyright (C) 2018-2026, Advanced Micro Devices, Inc. */
 
 #include <linux/module.h>
 #include <linux/printk.h>
diff --git a/drivers/infiniband/hw/ionic/ionic_datapath.c b/drivers/infiniband/hw/ionic/ionic_datapath.c
index aa2944887f23..4ca4ec2eebd4 100644
--- a/drivers/infiniband/hw/ionic/ionic_datapath.c
+++ b/drivers/infiniband/hw/ionic/ionic_datapath.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
+/* Copyright (C) 2018-2026, Advanced Micro Devices, Inc. */
 
 #include <linux/module.h>
 #include <linux/printk.h>
diff --git a/drivers/infiniband/hw/ionic/ionic_fw.h b/drivers/infiniband/hw/ionic/ionic_fw.h
index adfbb89d856c..0806c148faf2 100644
--- a/drivers/infiniband/hw/ionic/ionic_fw.h
+++ b/drivers/infiniband/hw/ionic/ionic_fw.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
+/* Copyright (C) 2018-2026, Advanced Micro Devices, Inc. */
 
 #ifndef _IONIC_FW_H_
 #define _IONIC_FW_H_
diff --git a/drivers/infiniband/hw/ionic/ionic_hw_stats.c b/drivers/infiniband/hw/ionic/ionic_hw_stats.c
index f72c9837e135..3c845d8b1be1 100644
--- a/drivers/infiniband/hw/ionic/ionic_hw_stats.c
+++ b/drivers/infiniband/hw/ionic/ionic_hw_stats.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
+/* Copyright (C) 2018-2026, Advanced Micro Devices, Inc. */
 
 #include <linux/dma-mapping.h>
 
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.c b/drivers/infiniband/hw/ionic/ionic_ibdev.c
index 0382a64839d2..356ad9fe150f 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.c
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
+/* Copyright (C) 2018-2026, Advanced Micro Devices, Inc. */
 
 #include <linux/module.h>
 #include <linux/printk.h>
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.h b/drivers/infiniband/hw/ionic/ionic_ibdev.h
index 63828240d659..7a8e4b59da1c 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.h
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
+/* Copyright (C) 2018-2026, Advanced Micro Devices, Inc. */
 
 #ifndef _IONIC_IBDEV_H_
 #define _IONIC_IBDEV_H_
diff --git a/drivers/infiniband/hw/ionic/ionic_lif_cfg.c b/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
index f3cd281c3a2f..800555eb47ac 100644
--- a/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
+++ b/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
+/* Copyright (C) 2018-2026, Advanced Micro Devices, Inc. */
 
 #include <linux/kernel.h>
 
diff --git a/drivers/infiniband/hw/ionic/ionic_lif_cfg.h b/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
index 20853429f623..18e7c7f13579 100644
--- a/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
+++ b/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
+/* Copyright (C) 2018-2026, Advanced Micro Devices, Inc. */
 
 #ifndef _IONIC_LIF_CFG_H_
 
diff --git a/drivers/infiniband/hw/ionic/ionic_pgtbl.c b/drivers/infiniband/hw/ionic/ionic_pgtbl.c
index e74db73c9246..40ac3b703862 100644
--- a/drivers/infiniband/hw/ionic/ionic_pgtbl.c
+++ b/drivers/infiniband/hw/ionic/ionic_pgtbl.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
+/* Copyright (C) 2018-2026, Advanced Micro Devices, Inc. */
 
 #include <linux/mman.h>
 #include <linux/dma-mapping.h>
diff --git a/drivers/infiniband/hw/ionic/ionic_queue.c b/drivers/infiniband/hw/ionic/ionic_queue.c
index aa897ed2a412..c8fea41c0363 100644
--- a/drivers/infiniband/hw/ionic/ionic_queue.c
+++ b/drivers/infiniband/hw/ionic/ionic_queue.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
+/* Copyright (C) 2018-2026, Advanced Micro Devices, Inc. */
 
 #include <linux/dma-mapping.h>
 
diff --git a/drivers/infiniband/hw/ionic/ionic_queue.h b/drivers/infiniband/hw/ionic/ionic_queue.h
index d18020d4cad5..3db1fc664184 100644
--- a/drivers/infiniband/hw/ionic/ionic_queue.h
+++ b/drivers/infiniband/hw/ionic/ionic_queue.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
+/* Copyright (C) 2018-2026, Advanced Micro Devices, Inc. */
 
 #ifndef _IONIC_QUEUE_H_
 #define _IONIC_QUEUE_H_
diff --git a/drivers/infiniband/hw/ionic/ionic_res.h b/drivers/infiniband/hw/ionic/ionic_res.h
index 46c8c584bd9a..bfb9dcf5851b 100644
--- a/drivers/infiniband/hw/ionic/ionic_res.h
+++ b/drivers/infiniband/hw/ionic/ionic_res.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
+/* Copyright (C) 2018-2026, Advanced Micro Devices, Inc. */
 
 #ifndef _IONIC_RES_H_
 #define _IONIC_RES_H_
-- 
2.17.1


