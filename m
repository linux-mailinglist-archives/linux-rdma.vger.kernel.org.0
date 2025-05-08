Return-Path: <linux-rdma+bounces-10141-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 169A5AAF275
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 07:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E84827BB161
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 05:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5432222BA;
	Thu,  8 May 2025 05:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QKvWPCrS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FE92116F1;
	Thu,  8 May 2025 05:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746680490; cv=fail; b=RXMD998gDLkmivipCWhlBOByMJKwEAPK4iJqxfSTfATcVyyRtH2BhIOmznrlwTi1lzmxosy+Tq+tkPIldikawSCfSub/YpIqO3qG5K4lMH/YI8xuq83WYWTfJa0CXZjIB9VPMK8kmpaV5kBP62QuKn1PJgsSmWRssvYHkf+ge8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746680490; c=relaxed/simple;
	bh=nfiv2olqZelXPo8mPmdAJLJL84t1fM6/5NHM833ruOU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTj/RQvU6UbzIdk4vYNyRkaDYTUWuYKykczd+V9MzIuidM2BFVb1ZJtEMTIo3ITC2JguGkeWhT6mAoFsPEEzxUybMiAo9SA18F/g7C8UjVB0QOxFwNEVk0vv3H4Ig3jBF/P6eB3P0yblJPtMVs+OUe/k/JmnqZ28dWs4QZ3sYx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QKvWPCrS; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXugb7RTweJQjQ1WXkyZfXCzidehRz+EUsH5Ez89raIB8F2X01RoAou2nM69dYtHEGqO/yy/4hJnPObkBR32UD33sYKXL6moszZvG5gW/WPG09VZMkrpLANUzMo/rc6wlyOYa4quGpcM5rpbwx783kOuskknqZONIhAqjffVPsr9RPViIUv6RlxUDUbHzjMrHVN7U+3lfbzZ3F+WTJ2gGDidPPO0CxU4onsyHUtaZCIUUuXKoyE9SB7mOhpYHd+qsAp8y1gQ7aNiigxB9a0OXgj4A/dvDlUPVdetBezrNYEo2zGQ3sIf9cLIgsXwK2DRpE9uFXUrcS0+34CDcPkrqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bwxM5KIrYBxPEJpScenkz5tSUvr+Ee9yqnjqXXZNOQ=;
 b=eMgxAuD/tCsTz3IVG6c/RH0KXRyjFmWyD8ARfd2dWtAYEJsN+QNmyXn/4UQPWSmUB22pQN3xCHWvHKVLI9lo2Lwdm73/OFCyJjalFs8NntJnWL3ZytRyiUyRs+C8EwrH2CI2S2AZbZT40SZnYAsjT65NjlVopdn/G4Wc6k0ZLgahuJ29q/qLbHAcFKyu97IpSIgVBpA14QKqrie3was6tH8Ksiael2iucx+5A8f3/wXjFAHYpS4B+eKXTj2Dd0TLdg6zmH5zdRRr4GK5x9zLoY1Gmy9UtNTWjjlZ2DzydhZ8QtJEaODVVO8giwrs6F4Fwm3nvdnwISRy6S2H0RzedA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bwxM5KIrYBxPEJpScenkz5tSUvr+Ee9yqnjqXXZNOQ=;
 b=QKvWPCrSaPkvYWQHap8OdtdfJs8F3ApTAlzJHM/JVugQqLVtOI4nkTD6XQ+SnzVwLxEXRb8pnzb3YFFV6H7ycmSxqUiUESy5Dmr1lCPJKKH+k6gpkkOA4XsrS1AwPhG+I0e34oI7qoViX7ZkY8z1Xl0JmxtzOjjstEL/C2mDfhA=
Received: from BL1PR13CA0011.namprd13.prod.outlook.com (2603:10b6:208:256::16)
 by SA1PR12MB7412.namprd12.prod.outlook.com (2603:10b6:806:2b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 05:01:15 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::78) by BL1PR13CA0011.outlook.office365.com
 (2603:10b6:208:256::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.19 via Frontend Transport; Thu,
 8 May 2025 05:01:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 05:01:15 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 00:01:14 -0500
Received: from xhdipdslab61.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 8 May 2025 00:01:10 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Andrew Boyer <andrew.boyer@amd.com>
Subject: [PATCH v2 09/14] RDMA/ionic: Create device queues to support admin operations
Date: Thu, 8 May 2025 10:29:52 +0530
Message-ID: <20250508045957.2823318-10-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250508045957.2823318-1-abhijit.gangurde@amd.com>
References: <20250508045957.2823318-1-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|SA1PR12MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cbfbd55-d45f-4122-01df-08dd8ded5c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a0l3Q+HA719NGWHgucaR6c7jSuT2BuvqaVyZhAGIXFGvl25LgPPLYiGtKaM1?=
 =?us-ascii?Q?HUJ/RmwdERt0LUjrGOJ6I/MYvOINi8ZzbZ65KXB5k6C/TkPU/1MASZLkK8xl?=
 =?us-ascii?Q?4xiwglwkEWukFKd2J9NSG4hdnUDukUxiykbft7HMv6axJ+z4T+xegg5J4Mif?=
 =?us-ascii?Q?ZJFQa8ncSALM8EKMJ7nOjmpgL0GtsedvNkWhSo4SNzMcwnaZmZ0iNUPnqEUp?=
 =?us-ascii?Q?+yK4sL1k0IB22KFNCareFqUtEEBeIOrvl74ARIapYATety6Fm+pFa+d6sDd/?=
 =?us-ascii?Q?3onTyt40IybS5A810PTyjBZEmFUym5KlctHhEprPXfn2rFzevEJvZM61RfIe?=
 =?us-ascii?Q?LPvCVROa81ODytEbgKN/z2W4t0HY5ajR1D5TGfU5dd9+TWGN9ksFlZvxj3uI?=
 =?us-ascii?Q?d7P0Ywwp+ouqu2s9oYwQM+K0C2b01nr1TFNX143wETtpWZa+yWheUb2cEKkG?=
 =?us-ascii?Q?eBzY4uoFCSTM0/Zn5Q/sMQOpFXObx8o/aopclIZCHcfAu8PxhIbepTbDy8wO?=
 =?us-ascii?Q?tIOoj2HcXW440fqY8N7qdNII8UEnzYa6iNnAw9u5qkVdHiMwulTbkNVM/sm/?=
 =?us-ascii?Q?s6QY3YM/gzjiHoxtAiRNdOR0fRAjt2S0H5qcNyvNWRS1DLEMO9W05i+lcUPd?=
 =?us-ascii?Q?I22tbOOJG+reYtuEPG7DmlaN8QLwDFL9UnDpZdPIMsTvzakbo5w/PecEOKk3?=
 =?us-ascii?Q?BPjWQ449rHmE6HXBMkB6OV2HnP2iRN/psSiO2n/KaBlEcLFOrnfDAPInQwh6?=
 =?us-ascii?Q?kHWhNtAuQlvSQRD64klHmTwS5agfIzTLndXhkX5SHrzsZd+24ScrSdA/JBun?=
 =?us-ascii?Q?sQde46TqQ/W2ZKBY/RQzzZjmBcaCGGztWygiEnAWQPYBRBhptg6SRafiWgIT?=
 =?us-ascii?Q?RT5MS3wuZ8P/jRRCMHE5JDMudGNO+Ch/sZjU13E+V7FRIH2zEXxtU+ePzarv?=
 =?us-ascii?Q?qBsHSm6U1RWvT7NAbGKWPCUyrBJnBgkzIM4SgJo2BqE7m6W9rCdKghq3Hyeg?=
 =?us-ascii?Q?cUlpTSWP7nrEQ7w3C0U7nLjClxVlNOkEI/ILJRc9YgEL6SPQo+iOC60TY7Es?=
 =?us-ascii?Q?TsTBK9J1chQsVF1KxBMr9ldIMddZwB8bBZWl/hqoLqjwZlCWtA5iRHO0M+fE?=
 =?us-ascii?Q?klNyX35kYYvHLhDFGIAb0dSgHUPZDex+FGqtfYe9s4TejSW/TeWVRvYBoDvl?=
 =?us-ascii?Q?JC1bM/pxQPNIGr+I90HGrnJb2Mp9jeo4MqnpHXzSUaCKxt5BZyqHpuxe6DLV?=
 =?us-ascii?Q?iw1J69uaSa3eR/RiEEqeMdpPCTHXFuAfo7Slpb8Eq9WQD0B3UFM/0u8ZEpmw?=
 =?us-ascii?Q?FNw+EAKq8NaIFzvtboq2pXRaFoOagj7QvNXm5YuunstEFwr9+m2trn+omDQ5?=
 =?us-ascii?Q?Kjg5k2ql/s5g1frJ5XuNKhAlXnVvvgMjHwV7jcVa7zWLqkFeSL5jFxSuf1Qk?=
 =?us-ascii?Q?swsUbGnDnnyINWVgdGcERM3PAEkMI5JZtfWH4wdrQFsm3i7cnTtfAdae4H+n?=
 =?us-ascii?Q?PdGwZYIQClbcVKu5K2UPz2jHH9/p9RMC59PMZRTNZPPI3Y7PHacC/m5ZgQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 05:01:15.3410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbfbd55-d45f-4122-01df-08dd8ded5c6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7412

Setup RDMA admin queues using device command exposed over
auxiliary device and manage these queues using bit-map
tracking structures.

Co-developed-by: Andrew Boyer <andrew.boyer@amd.com>
Signed-off-by: Andrew Boyer <andrew.boyer@amd.com>
Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 drivers/infiniband/hw/ionic/ionic_admin.c     | 1160 +++++++++++++++++
 .../infiniband/hw/ionic/ionic_controlpath.c   |  191 +++
 drivers/infiniband/hw/ionic/ionic_fw.h        |  164 +++
 drivers/infiniband/hw/ionic/ionic_ibdev.c     |  118 ++
 drivers/infiniband/hw/ionic/ionic_ibdev.h     |  245 ++++
 drivers/infiniband/hw/ionic/ionic_pgtbl.c     |  113 ++
 drivers/infiniband/hw/ionic/ionic_queue.c     |   52 +
 drivers/infiniband/hw/ionic/ionic_queue.h     |  234 ++++
 drivers/infiniband/hw/ionic/ionic_res.c       |   42 +
 drivers/infiniband/hw/ionic/ionic_res.h       |  182 +++
 10 files changed, 2501 insertions(+)
 create mode 100644 drivers/infiniband/hw/ionic/ionic_admin.c
 create mode 100644 drivers/infiniband/hw/ionic/ionic_controlpath.c
 create mode 100644 drivers/infiniband/hw/ionic/ionic_fw.h
 create mode 100644 drivers/infiniband/hw/ionic/ionic_pgtbl.c
 create mode 100644 drivers/infiniband/hw/ionic/ionic_queue.c
 create mode 100644 drivers/infiniband/hw/ionic/ionic_queue.h
 create mode 100644 drivers/infiniband/hw/ionic/ionic_res.c
 create mode 100644 drivers/infiniband/hw/ionic/ionic_res.h

diff --git a/drivers/infiniband/hw/ionic/ionic_admin.c b/drivers/infiniband/hw/ionic/ionic_admin.c
new file mode 100644
index 000000000000..5a414c0600a1
--- /dev/null
+++ b/drivers/infiniband/hw/ionic/ionic_admin.c
@@ -0,0 +1,1160 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
+
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+
+#include "ionic_fw.h"
+#include "ionic_ibdev.h"
+
+#define IONIC_EQ_COUNT_MIN	4
+#define IONIC_AQ_COUNT_MIN	1
+
+/* not a valid queue position or negative error status */
+#define IONIC_ADMIN_POSTED	0x10000
+
+/* cpu can be held with irq disabled for COUNT * MS  (for create/destroy_ah) */
+#define IONIC_ADMIN_BUSY_RETRY_COUNT	2000
+#define IONIC_ADMIN_BUSY_RETRY_MS	1
+
+/* admin queue will be considered failed if a command takes longer */
+#define IONIC_ADMIN_TIMEOUT	(HZ * 2)
+#define IONIC_ADMIN_WARN	(HZ / 8)
+
+/* will poll for admin cq to tolerate and report from missed event */
+#define IONIC_ADMIN_DELAY	(HZ / 8)
+
+/* work queue for polling the event queue and admin cq */
+struct workqueue_struct *ionic_evt_workq;
+
+static void ionic_admin_timedout(struct ionic_aq *aq)
+{
+	struct ionic_cq *cq = &aq->vcq->cq[0];
+	struct ionic_ibdev *dev = aq->dev;
+	unsigned long irqflags;
+	u16 pos;
+
+	spin_lock_irqsave(&aq->lock, irqflags);
+	if (ionic_queue_empty(&aq->q))
+		goto out;
+
+	/* Reset ALL adminq if any one times out */
+	queue_work(ionic_evt_workq, &dev->reset_work);
+
+	ibdev_err(&dev->ibdev, "admin command timed out, aq %d\n", aq->aqid);
+
+	ibdev_warn(&dev->ibdev, "admin timeout was set for %ums\n",
+		   (u32)jiffies_to_msecs(IONIC_ADMIN_TIMEOUT));
+	ibdev_warn(&dev->ibdev, "admin inactivity for %ums\n",
+		   (u32)jiffies_to_msecs(jiffies - aq->stamp));
+
+	ibdev_warn(&dev->ibdev, "admin commands outstanding %u\n",
+		   ionic_queue_length(&aq->q));
+	ibdev_warn(&dev->ibdev, "%s more commands pending\n",
+		   list_empty(&aq->wr_post) ? "no" : "some");
+
+	pos = cq->q.prod;
+
+	ibdev_warn(&dev->ibdev, "admin cq pos %u (next to complete)\n", pos);
+	print_hex_dump(KERN_WARNING, "cqe ", DUMP_PREFIX_OFFSET, 16, 1,
+		       ionic_queue_at(&cq->q, pos),
+		       BIT(cq->q.stride_log2), true);
+
+	pos = (pos - 1) & cq->q.mask;
+
+	ibdev_warn(&dev->ibdev, "admin cq pos %u (last completed)\n", pos);
+	print_hex_dump(KERN_WARNING, "cqe ", DUMP_PREFIX_OFFSET, 16, 1,
+		       ionic_queue_at(&cq->q, pos),
+		       BIT(cq->q.stride_log2), true);
+
+	pos = aq->q.cons;
+
+	ibdev_warn(&dev->ibdev, "admin pos %u (next to complete)\n", pos);
+	print_hex_dump(KERN_WARNING, "cmd ", DUMP_PREFIX_OFFSET, 16, 1,
+		       ionic_queue_at(&aq->q, pos),
+		       BIT(aq->q.stride_log2), true);
+
+	pos = (aq->q.prod - 1) & aq->q.mask;
+	if (pos == aq->q.cons)
+		goto out;
+
+	ibdev_warn(&dev->ibdev, "admin pos %u (last posted)\n", pos);
+	print_hex_dump(KERN_WARNING, "cmd ", DUMP_PREFIX_OFFSET, 16, 1,
+		       ionic_queue_at(&aq->q, pos),
+		       BIT(aq->q.stride_log2), true);
+
+out:
+	spin_unlock_irqrestore(&aq->lock, irqflags);
+}
+
+static void ionic_admin_reset_dwork(struct ionic_ibdev *dev)
+{
+	if (dev->admin_state < IONIC_ADMIN_KILLED)
+		queue_delayed_work(ionic_evt_workq, &dev->admin_dwork,
+				   IONIC_ADMIN_DELAY);
+}
+
+static void ionic_admin_reset_wdog(struct ionic_aq *aq)
+{
+	aq->stamp = jiffies;
+	ionic_admin_reset_dwork(aq->dev);
+}
+
+static bool ionic_admin_next_cqe(struct ionic_ibdev *dev, struct ionic_cq *cq,
+				 struct ionic_v1_cqe **cqe)
+{
+	struct ionic_v1_cqe *qcqe = ionic_queue_at_prod(&cq->q);
+
+	if (unlikely(cq->color != ionic_v1_cqe_color(qcqe)))
+		return false;
+
+	/* Prevent out-of-order reads of the CQE */
+	rmb();
+
+	ibdev_dbg(&dev->ibdev, "poll admin cq %u prod %u\n",
+		  cq->cqid, cq->q.prod);
+	print_hex_dump_debug("cqe ", DUMP_PREFIX_OFFSET, 16, 1,
+			     qcqe, BIT(cq->q.stride_log2), true);
+	*cqe = qcqe;
+
+	return true;
+}
+
+static void ionic_admin_poll_locked(struct ionic_aq *aq)
+{
+	struct ionic_cq *cq = &aq->vcq->cq[0];
+	struct ionic_admin_wr *wr, *wr_next;
+	struct ionic_ibdev *dev = aq->dev;
+	u32 wr_strides, avlbl_strides;
+	struct ionic_v1_cqe *cqe;
+	u32 qtf, qid;
+	u16 old_prod;
+	u8 type;
+
+	if (dev->admin_state >= IONIC_ADMIN_KILLED) {
+		list_for_each_entry_safe(wr, wr_next, &aq->wr_prod, aq_ent) {
+			INIT_LIST_HEAD(&wr->aq_ent);
+			aq->q_wr[wr->status].wr = NULL;
+			wr->status = dev->admin_state;
+			complete_all(&wr->work);
+		}
+		INIT_LIST_HEAD(&aq->wr_prod);
+
+		list_for_each_entry_safe(wr, wr_next, &aq->wr_post, aq_ent) {
+			INIT_LIST_HEAD(&wr->aq_ent);
+			wr->status = dev->admin_state;
+			complete_all(&wr->work);
+		}
+		INIT_LIST_HEAD(&aq->wr_post);
+
+		return;
+	}
+
+	old_prod = cq->q.prod;
+
+	while (ionic_admin_next_cqe(dev, cq, &cqe)) {
+		qtf = ionic_v1_cqe_qtf(cqe);
+		qid = ionic_v1_cqe_qtf_qid(qtf);
+		type = ionic_v1_cqe_qtf_type(qtf);
+
+		if (unlikely(type != IONIC_V1_CQE_TYPE_ADMIN)) {
+			ibdev_warn_ratelimited(&dev->ibdev,
+					       "bad cqe type %u\n", type);
+			goto cq_next;
+		}
+
+		if (unlikely(qid != aq->aqid)) {
+			ibdev_warn_ratelimited(&dev->ibdev,
+					       "bad cqe qid %u\n", qid);
+			goto cq_next;
+		}
+
+		if (unlikely(be16_to_cpu(cqe->admin.cmd_idx) != aq->q.cons)) {
+			ibdev_warn_ratelimited(&dev->ibdev,
+					       "bad idx %u cons %u qid %u\n",
+					       be16_to_cpu(cqe->admin.cmd_idx),
+					       aq->q.cons, qid);
+			goto cq_next;
+		}
+
+		if (unlikely(ionic_queue_empty(&aq->q))) {
+			ibdev_warn_ratelimited(&dev->ibdev,
+					       "bad cqe for empty adminq\n");
+			goto cq_next;
+		}
+
+		wr = aq->q_wr[aq->q.cons].wr;
+		if (wr) {
+			aq->q_wr[aq->q.cons].wr = NULL;
+			list_del_init(&wr->aq_ent);
+
+			wr->cqe = *cqe;
+			wr->status = dev->admin_state;
+			complete_all(&wr->work);
+		}
+
+		ionic_queue_consume_entries(&aq->q,
+					    aq->q_wr[aq->q.cons].wqe_strides);
+
+cq_next:
+		ionic_queue_produce(&cq->q);
+		cq->color = ionic_color_wrap(cq->q.prod, cq->color);
+	}
+
+	if (old_prod != cq->q.prod) {
+		ionic_admin_reset_wdog(aq);
+		cq->q.cons = cq->q.prod;
+		ionic_dbell_ring(dev->lif_cfg.dbpage, dev->lif_cfg.cq_qtype,
+				 ionic_queue_dbell_val(&cq->q));
+		queue_work(ionic_evt_workq, &aq->work);
+	} else if (!aq->armed) {
+		aq->armed = true;
+		cq->arm_any_prod = ionic_queue_next(&cq->q, cq->arm_any_prod);
+		ionic_dbell_ring(dev->lif_cfg.dbpage, dev->lif_cfg.cq_qtype,
+				 cq->q.dbell | IONIC_CQ_RING_ARM |
+				 cq->arm_any_prod);
+		queue_work(ionic_evt_workq, &aq->work);
+	}
+
+	if (dev->admin_state != IONIC_ADMIN_ACTIVE)
+		return;
+
+	old_prod = aq->q.prod;
+
+	if (ionic_queue_empty(&aq->q) && !list_empty(&aq->wr_post))
+		ionic_admin_reset_wdog(aq);
+
+	if (list_empty(&aq->wr_post))
+		return;
+
+	do {
+		u8 *src;
+		int i, src_len;
+		size_t stride_len;
+
+		wr = list_first_entry(&aq->wr_post, struct ionic_admin_wr,
+				      aq_ent);
+		wr_strides = (wr->wqe.len + ADMIN_WQE_HDR_LEN +
+			     (ADMIN_WQE_STRIDE - 1)) >> aq->q.stride_log2;
+		avlbl_strides = ionic_queue_length_remaining(&aq->q);
+
+		if (wr_strides > avlbl_strides)
+			break;
+
+		list_move(&wr->aq_ent, &aq->wr_prod);
+		wr->status = aq->q.prod;
+		aq->q_wr[aq->q.prod].wr = wr;
+		aq->q_wr[aq->q.prod].wqe_strides = wr_strides;
+
+		src_len = wr->wqe.len;
+		src = (uint8_t *)&wr->wqe.cmd;
+
+		/* First stride */
+		memcpy(ionic_queue_at_prod(&aq->q), &wr->wqe,
+		       ADMIN_WQE_HDR_LEN);
+		stride_len = ADMIN_WQE_STRIDE - ADMIN_WQE_HDR_LEN;
+		if (stride_len > src_len)
+			stride_len = src_len;
+		memcpy(ionic_queue_at_prod(&aq->q) + ADMIN_WQE_HDR_LEN,
+		       src, stride_len);
+		ibdev_dbg(&dev->ibdev, "post admin prod %u (%u strides)\n",
+			  aq->q.prod, wr_strides);
+		print_hex_dump_debug("wqe ", DUMP_PREFIX_OFFSET, 16, 1,
+				     ionic_queue_at_prod(&aq->q),
+				     BIT(aq->q.stride_log2), true);
+		ionic_queue_produce(&aq->q);
+
+		/* Remaining strides */
+		for (i = stride_len; i < src_len; i += stride_len) {
+			stride_len = ADMIN_WQE_STRIDE;
+
+			if (i + stride_len > src_len)
+				stride_len = src_len - i;
+
+			memcpy(ionic_queue_at_prod(&aq->q), src + i,
+			       stride_len);
+			print_hex_dump_debug("wqe ", DUMP_PREFIX_OFFSET, 16, 1,
+					     ionic_queue_at_prod(&aq->q),
+					     BIT(aq->q.stride_log2), true);
+			ionic_queue_produce(&aq->q);
+		}
+	} while (!list_empty(&aq->wr_post));
+
+	if (old_prod != aq->q.prod)
+		ionic_dbell_ring(dev->lif_cfg.dbpage, dev->lif_cfg.aq_qtype,
+				 ionic_queue_dbell_val(&aq->q));
+}
+
+static void ionic_admin_dwork(struct work_struct *ws)
+{
+	struct ionic_ibdev *dev =
+		container_of(ws, struct ionic_ibdev, admin_dwork.work);
+	struct ionic_aq *aq, *bad_aq = NULL;
+	bool do_reschedule = false;
+	unsigned long irqflags;
+	bool do_reset = false;
+	u16 pos;
+	int i;
+
+	for (i = 0; i < dev->lif_cfg.aq_count; i++) {
+		aq = dev->aq_vec[i];
+
+		spin_lock_irqsave(&aq->lock, irqflags);
+
+		if (ionic_queue_empty(&aq->q))
+			goto next_aq;
+
+		/* Reschedule if any queue has outstanding work */
+		do_reschedule = true;
+
+		if (time_is_after_eq_jiffies(aq->stamp + IONIC_ADMIN_WARN))
+			/* Warning threshold not met, nothing to do */
+			goto next_aq;
+
+		/* See if polling now makes some progress */
+		pos = aq->q.cons;
+		ionic_admin_poll_locked(aq);
+		if (pos != aq->q.cons) {
+			ibdev_dbg(&dev->ibdev,
+				  "missed event for acq %d\n", aq->cqid);
+			goto next_aq;
+		}
+
+		if (time_is_after_eq_jiffies(aq->stamp +
+					     IONIC_ADMIN_TIMEOUT)) {
+			/* Timeout threshold not met */
+			ibdev_dbg(&dev->ibdev, "no progress after %ums\n",
+				  (u32)jiffies_to_msecs(jiffies - aq->stamp));
+			goto next_aq;
+		}
+
+		/* Queue timed out */
+		bad_aq = aq;
+		do_reset = true;
+next_aq:
+		spin_unlock_irqrestore(&aq->lock, irqflags);
+	}
+
+	if (do_reset)
+		/* Reset device on a timeout */
+		ionic_admin_timedout(bad_aq);
+	else if (do_reschedule)
+		/* Try to poll again later */
+		ionic_admin_reset_dwork(dev);
+}
+
+static void ionic_admin_work(struct work_struct *ws)
+{
+	struct ionic_aq *aq = container_of(ws, struct ionic_aq, work);
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&aq->lock, irqflags);
+	ionic_admin_poll_locked(aq);
+	spin_unlock_irqrestore(&aq->lock, irqflags);
+}
+
+static void ionic_admin_post_aq(struct ionic_aq *aq, struct ionic_admin_wr *wr)
+{
+	unsigned long irqflags;
+	bool poll;
+
+	wr->status = IONIC_ADMIN_POSTED;
+	wr->aq = aq;
+
+	spin_lock_irqsave(&aq->lock, irqflags);
+	poll = list_empty(&aq->wr_post);
+	list_add(&wr->aq_ent, &aq->wr_post);
+	if (poll)
+		ionic_admin_poll_locked(aq);
+	spin_unlock_irqrestore(&aq->lock, irqflags);
+}
+
+void ionic_admin_post(struct ionic_ibdev *dev, struct ionic_admin_wr *wr)
+{
+	int aq_idx;
+
+	aq_idx = raw_smp_processor_id() % dev->lif_cfg.aq_count;
+	ionic_admin_post_aq(dev->aq_vec[aq_idx], wr);
+}
+
+static void ionic_admin_cancel(struct ionic_admin_wr *wr)
+{
+	struct ionic_aq *aq = wr->aq;
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&aq->lock, irqflags);
+
+	if (!list_empty(&wr->aq_ent)) {
+		list_del(&wr->aq_ent);
+		if (wr->status != IONIC_ADMIN_POSTED)
+			aq->q_wr[wr->status].wr = NULL;
+	}
+
+	spin_unlock_irqrestore(&aq->lock, irqflags);
+}
+
+static int ionic_admin_busy_wait(struct ionic_admin_wr *wr)
+{
+	struct ionic_aq *aq = wr->aq;
+	unsigned long irqflags;
+	int try_i;
+
+	for (try_i = 0; try_i < IONIC_ADMIN_BUSY_RETRY_COUNT; ++try_i) {
+		if (completion_done(&wr->work))
+			return 0;
+
+		mdelay(IONIC_ADMIN_BUSY_RETRY_MS);
+
+		spin_lock_irqsave(&aq->lock, irqflags);
+		ionic_admin_poll_locked(aq);
+		spin_unlock_irqrestore(&aq->lock, irqflags);
+	}
+
+	/*
+	 * we timed out. Initiate RDMA LIF reset and indicate
+	 * error to caller.
+	 */
+	ionic_admin_timedout(aq);
+	return -ETIMEDOUT;
+}
+
+int ionic_admin_wait(struct ionic_ibdev *dev, struct ionic_admin_wr *wr,
+		     enum ionic_admin_flags flags)
+{
+	int rc, timo;
+
+	if (flags & IONIC_ADMIN_F_BUSYWAIT) {
+		/* Spin */
+		rc = ionic_admin_busy_wait(wr);
+	} else if (flags & IONIC_ADMIN_F_INTERRUPT) {
+		/*
+		 * Interruptible sleep, 1s timeout
+		 * This is used for commands which are safe for the caller
+		 * to clean up without killing and resetting the adminq.
+		 */
+		timo = wait_for_completion_interruptible_timeout(&wr->work,
+								 HZ);
+		if (timo > 0)
+			rc = 0;
+		else if (timo == 0)
+			rc = -ETIMEDOUT;
+		else
+			rc = timo;
+	} else {
+		/*
+		 * Uninterruptible sleep
+		 * This is used for commands which are NOT safe for the
+		 * caller to clean up. Cleanup must be handled by the
+		 * adminq kill and reset process so that host memory is
+		 * not corrupted by the device.
+		 */
+		wait_for_completion(&wr->work);
+		rc = 0;
+	}
+
+	if (rc) {
+		ibdev_warn(&dev->ibdev, "wait status %d\n", rc);
+		ionic_admin_cancel(wr);
+	} else if (wr->status == IONIC_ADMIN_KILLED) {
+		ibdev_dbg(&dev->ibdev, "admin killed\n");
+
+		/* No error if admin already killed during teardown */
+		rc = (flags & IONIC_ADMIN_F_TEARDOWN) ? 0 : -ENODEV;
+	} else if (ionic_v1_cqe_error(&wr->cqe)) {
+		ibdev_warn(&dev->ibdev, "opcode %u error %u\n",
+			   wr->wqe.op,
+			   be32_to_cpu(wr->cqe.status_length));
+		rc = -EINVAL;
+	}
+	return rc;
+}
+
+static int ionic_rdma_devcmd(struct ionic_ibdev *dev,
+			     struct ionic_admin_ctx *admin)
+{
+	int rc;
+
+	rc = ionic_adminq_post_wait(dev->lif_cfg.lif, admin);
+	if (rc)
+		return rc;
+
+	return ionic_error_to_errno(admin->comp.comp.status);
+}
+
+int ionic_rdma_reset_devcmd(struct ionic_ibdev *dev)
+{
+	struct ionic_admin_ctx admin = {
+		.work = COMPLETION_INITIALIZER_ONSTACK(admin.work),
+		.cmd.rdma_reset = {
+			.opcode = IONIC_CMD_RDMA_RESET_LIF,
+			.lif_index = cpu_to_le16(dev->lif_cfg.lif_index),
+		},
+	};
+
+	return ionic_rdma_devcmd(dev, &admin);
+}
+
+static int ionic_rdma_queue_devcmd(struct ionic_ibdev *dev,
+				   struct ionic_queue *q,
+				   u32 qid, u32 cid, u16 opcode)
+{
+	struct ionic_admin_ctx admin = {
+		.work = COMPLETION_INITIALIZER_ONSTACK(admin.work),
+		.cmd.rdma_queue = {
+			.opcode = opcode,
+			.lif_index = cpu_to_le16(dev->lif_cfg.lif_index),
+			.qid_ver = cpu_to_le32(qid),
+			.cid = cpu_to_le32(cid),
+			.dbid = cpu_to_le16(dev->lif_cfg.dbid),
+			.depth_log2 = q->depth_log2,
+			.stride_log2 = q->stride_log2,
+			.dma_addr = cpu_to_le64(q->dma),
+		},
+	};
+
+	return ionic_rdma_devcmd(dev, &admin);
+}
+
+static void ionic_rdma_admincq_comp(struct ib_cq *ibcq, void *cq_context)
+{
+	struct ionic_aq *aq = cq_context;
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&aq->lock, irqflags);
+	aq->armed = false;
+	if (aq->dev->admin_state < IONIC_ADMIN_KILLED)
+		queue_work(ionic_evt_workq, &aq->work);
+	spin_unlock_irqrestore(&aq->lock, irqflags);
+}
+
+static void ionic_rdma_admincq_event(struct ib_event *event, void *cq_context)
+{
+	struct ionic_aq *aq = cq_context;
+
+	ibdev_err(&aq->dev->ibdev, "admincq event %d\n", event->event);
+}
+
+static struct ionic_vcq *ionic_create_rdma_admincq(struct ionic_ibdev *dev,
+						   int comp_vector)
+{
+	struct ib_cq_init_attr attr = {
+		.cqe = IONIC_AQ_DEPTH,
+		.comp_vector = comp_vector,
+	};
+	struct ionic_tbl_buf buf = {};
+	struct ionic_vcq *vcq;
+	struct ionic_cq *cq;
+	int rc;
+
+	vcq = kzalloc(sizeof(*vcq), GFP_KERNEL);
+	if (!vcq) {
+		rc = -ENOMEM;
+		goto err_alloc;
+	}
+
+	vcq->ibcq.device = &dev->ibdev;
+	vcq->ibcq.uobject = NULL;
+	vcq->ibcq.comp_handler = ionic_rdma_admincq_comp;
+	vcq->ibcq.event_handler = ionic_rdma_admincq_event;
+	vcq->ibcq.cq_context = NULL;
+	atomic_set(&vcq->ibcq.usecnt, 0);
+
+	vcq->udma_mask = 1;
+	cq = &vcq->cq[0];
+
+	rc = ionic_create_cq_common(vcq, &buf, &attr, NULL, NULL,
+				    NULL, NULL, 0);
+	if (rc)
+		goto err_init;
+
+	rc = ionic_rdma_queue_devcmd(dev, &cq->q, cq->cqid, cq->eqid,
+				     IONIC_CMD_RDMA_CREATE_CQ);
+	if (rc)
+		goto err_cmd;
+
+	return vcq;
+
+err_cmd:
+	ionic_destroy_cq_common(dev, cq);
+err_init:
+	kfree(vcq);
+err_alloc:
+	return ERR_PTR(rc);
+}
+
+static struct ionic_aq *__ionic_create_rdma_adminq(struct ionic_ibdev *dev,
+						   u32 aqid, u32 cqid)
+{
+	struct ionic_aq *aq;
+	int rc;
+
+	aq = kmalloc(sizeof(*aq), GFP_KERNEL);
+	if (!aq) {
+		rc = -ENOMEM;
+		goto err_aq;
+	}
+
+	aq->dev = dev;
+	aq->aqid = aqid;
+	aq->cqid = cqid;
+	spin_lock_init(&aq->lock);
+
+	rc = ionic_queue_init(&aq->q, dev->lif_cfg.hwdev, IONIC_EQ_DEPTH,
+			      ADMIN_WQE_STRIDE);
+	if (rc)
+		goto err_q;
+
+	ionic_queue_dbell_init(&aq->q, aq->aqid);
+
+	aq->q_wr = kcalloc((u32)aq->q.mask + 1, sizeof(*aq->q_wr), GFP_KERNEL);
+	if (!aq->q_wr) {
+		rc = -ENOMEM;
+		goto err_wr;
+	}
+
+	INIT_LIST_HEAD(&aq->wr_prod);
+	INIT_LIST_HEAD(&aq->wr_post);
+
+	INIT_WORK(&aq->work, ionic_admin_work);
+	aq->armed = false;
+
+	return aq;
+
+err_wr:
+	ionic_queue_destroy(&aq->q, dev->lif_cfg.hwdev);
+err_q:
+	kfree(aq);
+err_aq:
+	return ERR_PTR(rc);
+}
+
+static void __ionic_destroy_rdma_adminq(struct ionic_ibdev *dev,
+					struct ionic_aq *aq)
+{
+	ionic_queue_destroy(&aq->q, dev->lif_cfg.hwdev);
+	kfree(aq);
+}
+
+static struct ionic_aq *ionic_create_rdma_adminq(struct ionic_ibdev *dev,
+						 u32 aqid, u32 cqid)
+{
+	struct ionic_aq *aq;
+	int rc;
+
+	aq = __ionic_create_rdma_adminq(dev, aqid, cqid);
+	if (IS_ERR(aq)) {
+		rc = PTR_ERR(aq);
+		goto err_aq;
+	}
+
+	rc = ionic_rdma_queue_devcmd(dev, &aq->q, aq->aqid, aq->cqid,
+				     IONIC_CMD_RDMA_CREATE_ADMINQ);
+	if (rc)
+		goto err_cmd;
+
+	return aq;
+
+err_cmd:
+	__ionic_destroy_rdma_adminq(dev, aq);
+err_aq:
+	return ERR_PTR(rc);
+}
+
+static void ionic_kill_ibdev(struct ionic_ibdev *dev, bool fatal_path)
+{
+	unsigned long irqflags;
+	bool do_flush = false;
+	int i;
+
+	local_irq_save(irqflags);
+
+	/* Mark the admin queue, flushing at most once */
+	for (i = 0; i < dev->lif_cfg.aq_count; i++)
+		spin_lock(&dev->aq_vec[i]->lock);
+
+	if (dev->admin_state != IONIC_ADMIN_KILLED) {
+		dev->admin_state = IONIC_ADMIN_KILLED;
+		do_flush = true;
+	}
+
+	for (i = dev->lif_cfg.aq_count - 1; i >= 0; i--) {
+		/* Flush incomplete admin commands */
+		if (do_flush)
+			ionic_admin_poll_locked(dev->aq_vec[i]);
+		spin_unlock(&dev->aq_vec[i]->lock);
+	}
+
+	local_irq_restore(irqflags);
+
+	/* Post a fatal event if requested */
+	if (fatal_path)
+		ionic_port_event(dev, IB_EVENT_DEVICE_FATAL);
+}
+
+void ionic_kill_rdma_admin(struct ionic_ibdev *dev, bool fatal_path)
+{
+	unsigned long irqflags = 0;
+	bool do_reset = false;
+	int i, rc;
+
+	if (!dev->aq_vec)
+		return;
+
+	local_irq_save(irqflags);
+	for (i = 0; i < dev->lif_cfg.aq_count; i++)
+		spin_lock(&dev->aq_vec[i]->lock);
+
+	/* pause rdma admin queues to reset device */
+	if (dev->admin_state == IONIC_ADMIN_ACTIVE) {
+		dev->admin_state = IONIC_ADMIN_PAUSED;
+		do_reset = true;
+	}
+
+	while (i-- > 0)
+		spin_unlock(&dev->aq_vec[i]->lock);
+	local_irq_restore(irqflags);
+
+	if (!do_reset)
+		return;
+
+	/* After resetting the device, it will be safe to resume the rdma admin
+	 * queues in the killed state.	Commands will not be issued to the
+	 * device, but will complete locally with status IONIC_ADMIN_KILLED.
+	 * Handling completion will ensure that creating or modifying resources
+	 * fails, but destroying resources succeeds.
+	 *
+	 * If there was a failure resetting the device using this strategy,
+	 * then the state of the device is unknown.  The rdma admin queue is
+	 * left here in the paused state.  No new commands are issued to the
+	 * device, nor are any completed locally.  The eth driver will use a
+	 * different strategy to reset the device.  A callback from the eth
+	 * driver will indicate that the reset is done and it is safe to
+	 * continue.  Then, the rdma admin queue will be transitioned to the
+	 * killed state and new and outstanding commands will complete locally.
+	 */
+
+	rc = ionic_rdma_reset_devcmd(dev);
+	if (unlikely(rc)) {
+		ibdev_err(&dev->ibdev, "failed to reset rdma %d\n", rc);
+		ionic_request_rdma_reset(dev->lif_cfg.lif);
+	}
+
+	ionic_kill_ibdev(dev, fatal_path);
+}
+
+static void ionic_reset_work(struct work_struct *ws)
+{
+	struct ionic_ibdev *dev =
+		container_of(ws, struct ionic_ibdev, reset_work);
+
+	ionic_kill_rdma_admin(dev, true);
+}
+
+static bool ionic_next_eqe(struct ionic_eq *eq, struct ionic_v1_eqe *eqe)
+{
+	struct ionic_v1_eqe *qeqe;
+	bool color;
+
+	qeqe = ionic_queue_at_prod(&eq->q);
+	color = ionic_v1_eqe_color(qeqe);
+
+	/* cons is color for eq */
+	if (eq->q.cons != color)
+		return false;
+
+	/* Prevent out-of-order reads of the EQE */
+	rmb();
+
+	ibdev_dbg(&eq->dev->ibdev, "poll eq prod %u\n", eq->q.prod);
+	print_hex_dump_debug("eqe ", DUMP_PREFIX_OFFSET, 16, 1,
+			     qeqe, BIT(eq->q.stride_log2), true);
+	*eqe = *qeqe;
+
+	return true;
+}
+
+static void ionic_cq_event(struct ionic_ibdev *dev, u32 cqid, u8 code)
+{
+	unsigned long irqflags;
+	struct ib_event ibev;
+	struct ionic_cq *cq;
+
+	read_lock_irqsave(&dev->cq_tbl_rw, irqflags);
+	cq = xa_load(&dev->cq_tbl, cqid);
+	if (cq)
+		kref_get(&cq->cq_kref);
+	read_unlock_irqrestore(&dev->cq_tbl_rw, irqflags);
+
+	if (!cq) {
+		ibdev_dbg(&dev->ibdev,
+			  "missing cqid %#x code %u\n", cqid, code);
+		return;
+	}
+
+	switch (code) {
+	case IONIC_V1_EQE_CQ_NOTIFY:
+		if (cq->vcq->ibcq.comp_handler)
+			cq->vcq->ibcq.comp_handler(&cq->vcq->ibcq,
+						   cq->vcq->ibcq.cq_context);
+		break;
+
+	case IONIC_V1_EQE_CQ_ERR:
+		if (cq->vcq->ibcq.event_handler) {
+			ibev.event = IB_EVENT_CQ_ERR;
+			ibev.device = &dev->ibdev;
+			ibev.element.cq = &cq->vcq->ibcq;
+
+			cq->vcq->ibcq.event_handler(&ibev,
+						    cq->vcq->ibcq.cq_context);
+		}
+		break;
+
+	default:
+		ibdev_dbg(&dev->ibdev,
+			  "unrecognized cqid %#x code %u\n", cqid, code);
+		break;
+	}
+
+	kref_put(&cq->cq_kref, ionic_cq_complete);
+}
+
+static u16 ionic_poll_eq(struct ionic_eq *eq, u16 budget)
+{
+	struct ionic_ibdev *dev = eq->dev;
+	struct ionic_v1_eqe eqe;
+	u16 npolled = 0;
+	u8 type, code;
+	u32 evt, qid;
+
+	while (npolled < budget) {
+		if (!ionic_next_eqe(eq, &eqe))
+			break;
+
+		ionic_queue_produce(&eq->q);
+
+		/* cons is color for eq */
+		eq->q.cons = ionic_color_wrap(eq->q.prod, eq->q.cons);
+
+		++npolled;
+
+		evt = ionic_v1_eqe_evt(&eqe);
+		type = ionic_v1_eqe_evt_type(evt);
+		code = ionic_v1_eqe_evt_code(evt);
+		qid = ionic_v1_eqe_evt_qid(evt);
+
+		switch (type) {
+		case IONIC_V1_EQE_TYPE_CQ:
+			ionic_cq_event(dev, qid, code);
+			break;
+
+		default:
+			ibdev_dbg(&dev->ibdev,
+				  "unknown event %#x type %u\n", evt, type);
+		}
+	}
+
+	return npolled;
+}
+
+static void ionic_poll_eq_work(struct work_struct *work)
+{
+	struct ionic_eq *eq = container_of(work, struct ionic_eq, work);
+	u32 npolled;
+
+	if (unlikely(!eq->enable) || WARN_ON(eq->armed))
+		return;
+
+	npolled = ionic_poll_eq(eq, IONIC_EQ_WORK_BUDGET);
+	eq->poll_wq += npolled;
+	if (npolled == 1)
+		eq->poll_wq_single++;
+
+	if (npolled == IONIC_EQ_WORK_BUDGET) {
+		eq->poll_wq_full++;
+		ionic_intr_credits(eq->dev->lif_cfg.intr_ctrl, eq->intr,
+				   npolled, 0);
+		queue_work(ionic_evt_workq, &eq->work);
+	} else {
+		xchg(&eq->armed, true);
+		ionic_intr_credits(eq->dev->lif_cfg.intr_ctrl, eq->intr,
+				   0, IONIC_INTR_CRED_UNMASK);
+	}
+}
+
+static irqreturn_t ionic_poll_eq_isr(int irq, void *eqptr)
+{
+	struct ionic_eq *eq = eqptr;
+	bool was_armed;
+	u32 npolled;
+
+	was_armed = xchg(&eq->armed, false);
+
+	if (unlikely(!eq->enable) || !was_armed)
+		return IRQ_HANDLED;
+
+	npolled = ionic_poll_eq(eq, IONIC_EQ_ISR_BUDGET);
+	eq->poll_isr += npolled;
+	if (npolled == 1)
+		eq->poll_isr_single++;
+
+	if (npolled == IONIC_EQ_ISR_BUDGET) {
+		eq->poll_isr_full++;
+		ionic_intr_credits(eq->dev->lif_cfg.intr_ctrl, eq->intr,
+				   npolled, 0);
+		queue_work(ionic_evt_workq, &eq->work);
+	} else {
+		xchg(&eq->armed, true);
+		ionic_intr_credits(eq->dev->lif_cfg.intr_ctrl, eq->intr,
+				   0, IONIC_INTR_CRED_UNMASK);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static struct ionic_eq *ionic_create_eq(struct ionic_ibdev *dev, int eqid)
+{
+	struct ionic_intr_info intr_obj = { };
+	struct ionic_eq *eq;
+	int rc;
+
+	eq = kzalloc(sizeof(*eq), GFP_KERNEL);
+	if (!eq) {
+		rc = -ENOMEM;
+		goto err_eq;
+	}
+
+	eq->dev = dev;
+
+	rc = ionic_queue_init(&eq->q, dev->lif_cfg.hwdev, IONIC_EQ_DEPTH,
+			      sizeof(struct ionic_v1_eqe));
+	if (rc)
+		goto err_q;
+
+	eq->eqid = eqid;
+
+	eq->armed = true;
+	eq->enable = false;
+	INIT_WORK(&eq->work, ionic_poll_eq_work);
+
+	rc = ionic_intr_alloc(dev->lif_cfg.lif, &intr_obj);
+	if (rc < 0)
+		goto err_intr;
+
+	eq->irq = intr_obj.vector;
+	eq->intr = intr_obj.index;
+
+	ionic_queue_dbell_init(&eq->q, eq->eqid);
+
+	/* cons is color for eq */
+	eq->q.cons = true;
+
+	snprintf(eq->name, sizeof(eq->name), "%s-%d-%d-eq",
+		 DRIVER_SHORTNAME, dev->lif_cfg.lif_index, eq->eqid);
+
+	ionic_intr_mask(dev->lif_cfg.intr_ctrl, eq->intr, IONIC_INTR_MASK_SET);
+	ionic_intr_mask_assert(dev->lif_cfg.intr_ctrl, eq->intr, IONIC_INTR_MASK_SET);
+	ionic_intr_coal_init(dev->lif_cfg.intr_ctrl, eq->intr, 0);
+	ionic_intr_clean(dev->lif_cfg.intr_ctrl, eq->intr);
+
+	eq->enable = true;
+
+	rc = request_irq(eq->irq, ionic_poll_eq_isr, 0, eq->name, eq);
+	if (rc)
+		goto err_irq;
+
+	rc = ionic_rdma_queue_devcmd(dev, &eq->q, eq->eqid, eq->intr,
+				     IONIC_CMD_RDMA_CREATE_EQ);
+	if (rc)
+		goto err_cmd;
+
+	ionic_intr_mask(dev->lif_cfg.intr_ctrl, eq->intr, IONIC_INTR_MASK_CLEAR);
+
+	return eq;
+
+err_cmd:
+	eq->enable = false;
+	flush_work(&eq->work);
+	free_irq(eq->irq, eq);
+err_irq:
+	ionic_intr_free(dev->lif_cfg.lif, eq->intr);
+err_intr:
+	ionic_queue_destroy(&eq->q, dev->lif_cfg.hwdev);
+err_q:
+	kfree(eq);
+err_eq:
+	return ERR_PTR(rc);
+}
+
+static void ionic_destroy_eq(struct ionic_eq *eq)
+{
+	struct ionic_ibdev *dev = eq->dev;
+
+	eq->enable = false;
+	flush_work(&eq->work);
+	free_irq(eq->irq, eq);
+
+	ionic_intr_free(dev->lif_cfg.lif, eq->intr);
+	ionic_queue_destroy(&eq->q, dev->lif_cfg.hwdev);
+	kfree(eq);
+}
+
+int ionic_create_rdma_admin(struct ionic_ibdev *dev)
+{
+	int eq_i = 0, aq_i = 0, rc = 0;
+	struct ionic_vcq *vcq;
+	struct ionic_aq *aq;
+	struct ionic_eq *eq;
+
+	dev->eq_vec = NULL;
+	dev->aq_vec = NULL;
+
+	INIT_WORK(&dev->reset_work, ionic_reset_work);
+	INIT_DELAYED_WORK(&dev->admin_dwork, ionic_admin_dwork);
+	dev->admin_state = IONIC_ADMIN_KILLED;
+
+	if (dev->lif_cfg.aq_count > IONIC_AQ_COUNT) {
+		ibdev_dbg(&dev->ibdev, "limiting adminq count to %d\n",
+			  IONIC_AQ_COUNT);
+		dev->lif_cfg.aq_count = IONIC_AQ_COUNT;
+	}
+
+	if (dev->lif_cfg.eq_count > IONIC_EQ_COUNT) {
+		dev_dbg(&dev->ibdev.dev, "limiting eventq count to %d\n",
+			IONIC_EQ_COUNT);
+		dev->lif_cfg.eq_count = IONIC_EQ_COUNT;
+	}
+
+	/* need at least two eq and one aq */
+	if (dev->lif_cfg.eq_count < IONIC_EQ_COUNT_MIN ||
+	    dev->lif_cfg.aq_count < IONIC_AQ_COUNT_MIN) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	dev->eq_vec = kmalloc_array(dev->lif_cfg.eq_count, sizeof(*dev->eq_vec),
+				    GFP_KERNEL);
+	if (!dev->eq_vec) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	for (eq_i = 0; eq_i < dev->lif_cfg.eq_count; ++eq_i) {
+		eq = ionic_create_eq(dev, eq_i + dev->lif_cfg.eq_base);
+		if (IS_ERR(eq)) {
+			rc = PTR_ERR(eq);
+
+			if (eq_i < IONIC_EQ_COUNT_MIN) {
+				ibdev_err(&dev->ibdev,
+					  "fail create eq %d\n", rc);
+				goto out;
+			}
+
+			/* ok, just fewer eq than device supports */
+			ibdev_dbg(&dev->ibdev, "eq count %d want %d rc %d\n",
+				  eq_i, dev->lif_cfg.eq_count, rc);
+
+			rc = 0;
+			break;
+		}
+
+		dev->eq_vec[eq_i] = eq;
+	}
+
+	dev->lif_cfg.eq_count = eq_i;
+
+	dev->aq_vec = kmalloc_array(dev->lif_cfg.aq_count, sizeof(*dev->aq_vec),
+				    GFP_KERNEL);
+	if (!dev->aq_vec) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	/* Create one CQ per AQ */
+	for (aq_i = 0; aq_i < dev->lif_cfg.aq_count; ++aq_i) {
+		vcq = ionic_create_rdma_admincq(dev, aq_i % eq_i);
+		if (IS_ERR(vcq)) {
+			rc = PTR_ERR(vcq);
+
+			if (!aq_i) {
+				ibdev_err(&dev->ibdev,
+					  "failed to create acq %d\n", rc);
+				goto out;
+			}
+
+			/* ok, just fewer adminq than device supports */
+			ibdev_dbg(&dev->ibdev, "acq count %d want %d rc %d\n",
+				  aq_i, dev->lif_cfg.aq_count, rc);
+			break;
+		}
+
+		aq = ionic_create_rdma_adminq(dev, aq_i + dev->lif_cfg.aq_base,
+					      vcq->cq[0].cqid);
+		if (IS_ERR(aq)) {
+			/* Clean up the dangling CQ */
+			ionic_destroy_cq_common(dev, &vcq->cq[0]);
+			kfree(vcq);
+
+			rc = PTR_ERR(aq);
+
+			if (!aq_i) {
+				ibdev_err(&dev->ibdev,
+					  "failed to create aq %d\n", rc);
+				goto out;
+			}
+
+			/* ok, just fewer adminq than device supports */
+			ibdev_dbg(&dev->ibdev, "aq count %d want %d rc %d\n",
+				  aq_i, dev->lif_cfg.aq_count, rc);
+			break;
+		}
+
+		vcq->ibcq.cq_context = aq;
+		aq->vcq = vcq;
+
+		dev->aq_vec[aq_i] = aq;
+	}
+
+	dev->admin_state = IONIC_ADMIN_ACTIVE;
+out:
+	dev->lif_cfg.eq_count = eq_i;
+	dev->lif_cfg.aq_count = aq_i;
+
+	return rc;
+}
+
+void ionic_destroy_rdma_admin(struct ionic_ibdev *dev)
+{
+	struct ionic_vcq *vcq;
+	struct ionic_aq *aq;
+	struct ionic_eq *eq;
+
+	cancel_delayed_work_sync(&dev->admin_dwork);
+	cancel_work_sync(&dev->reset_work);
+
+	if (dev->aq_vec) {
+		while (dev->lif_cfg.aq_count > 0) {
+			aq = dev->aq_vec[--dev->lif_cfg.aq_count];
+			vcq = aq->vcq;
+
+			cancel_work_sync(&aq->work);
+
+			__ionic_destroy_rdma_adminq(dev, aq);
+			if (vcq) {
+				ionic_destroy_cq_common(dev, &vcq->cq[0]);
+				kfree(vcq);
+			}
+		}
+
+		kfree(dev->aq_vec);
+	}
+
+	if (dev->eq_vec) {
+		while (dev->lif_cfg.eq_count > 0) {
+			eq = dev->eq_vec[--dev->lif_cfg.eq_count];
+			ionic_destroy_eq(eq);
+		}
+
+		kfree(dev->eq_vec);
+	}
+}
diff --git a/drivers/infiniband/hw/ionic/ionic_controlpath.c b/drivers/infiniband/hw/ionic/ionic_controlpath.c
new file mode 100644
index 000000000000..1004659c7554
--- /dev/null
+++ b/drivers/infiniband/hw/ionic/ionic_controlpath.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
+
+#include "ionic_ibdev.h"
+
+static int ionic_validate_qdesc(struct ionic_qdesc *q)
+{
+	if (!q->addr || !q->size || !q->mask ||
+	    !q->depth_log2 || !q->stride_log2)
+		return -EINVAL;
+
+	if (q->addr & (PAGE_SIZE - 1))
+		return -EINVAL;
+
+	if (q->mask != BIT(q->depth_log2) - 1)
+		return -EINVAL;
+
+	if (q->size < BIT_ULL(q->depth_log2 + q->stride_log2))
+		return -EINVAL;
+
+	return 0;
+}
+
+static u32 ionic_get_eqid(struct ionic_ibdev *dev, u32 comp_vector, u8 udma_idx)
+{
+	/* EQ per vector per udma, and the first eqs reserved for async events.
+	 * The rest of the vectors can be requested for completions.
+	 */
+	u32 comp_vec_count = dev->lif_cfg.eq_count / dev->lif_cfg.udma_count - 1;
+
+	return (comp_vector % comp_vec_count + 1) * dev->lif_cfg.udma_count + udma_idx;
+}
+
+static int ionic_get_cqid(struct ionic_ibdev *dev, u32 *cqid, u8 udma_idx)
+{
+	int rc, size, base, bound, next;
+
+	size = dev->lif_cfg.cq_count / dev->lif_cfg.udma_count;
+	base = size * udma_idx;
+	bound = base + size;
+
+	mutex_lock(&dev->inuse_lock);
+	next = dev->next_cqid[udma_idx];
+	rc = ionic_resid_get_shared(&dev->inuse_cqid, base, next, bound);
+	if (rc >= 0)
+		dev->next_cqid[udma_idx] = rc + 1;
+	mutex_unlock(&dev->inuse_lock);
+
+	if (rc >= 0) {
+		/* cq_base is zero or a multiple of two queue groups */
+		*cqid = dev->lif_cfg.cq_base +
+			ionic_bitid_to_qid(rc, dev->lif_cfg.udma_qgrp_shift,
+					   dev->half_cqid_udma_shift);
+
+		rc = 0;
+	}
+
+	return rc;
+}
+
+static void ionic_put_cqid(struct ionic_ibdev *dev, u32 cqid)
+{
+	u32 bitid = ionic_qid_to_bitid(cqid - dev->lif_cfg.cq_base,
+				       dev->lif_cfg.udma_qgrp_shift,
+				       dev->half_cqid_udma_shift);
+
+	ionic_resid_put(&dev->inuse_cqid, bitid);
+}
+
+int ionic_create_cq_common(struct ionic_vcq *vcq,
+			   struct ionic_tbl_buf *buf,
+			   const struct ib_cq_init_attr *attr,
+			   struct ionic_ctx *ctx,
+			   struct ib_udata *udata,
+			   struct ionic_qdesc *req_cq,
+			   __u32 *resp_cqid,
+			   int udma_idx)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(vcq->ibcq.device);
+	struct ionic_cq *cq = &vcq->cq[udma_idx];
+	unsigned long irqflags;
+	int rc;
+
+	cq->vcq = vcq;
+
+	if (attr->cqe < 1 || attr->cqe + IONIC_CQ_GRACE > 0xffff) {
+		rc = -EINVAL;
+		goto err_args;
+	}
+
+	rc = ionic_get_cqid(dev, &cq->cqid, udma_idx);
+	if (rc)
+		goto err_cqid;
+
+	cq->eqid = ionic_get_eqid(dev, attr->comp_vector, udma_idx);
+
+	spin_lock_init(&cq->lock);
+	INIT_LIST_HEAD(&cq->poll_sq);
+	INIT_LIST_HEAD(&cq->flush_sq);
+	INIT_LIST_HEAD(&cq->flush_rq);
+
+	if (udata) {
+		rc = ionic_validate_qdesc(req_cq);
+		if (rc)
+			goto err_qdesc;
+
+		cq->umem = ib_umem_get(&dev->ibdev, req_cq->addr, req_cq->size,
+				       IB_ACCESS_LOCAL_WRITE);
+		if (IS_ERR(cq->umem)) {
+			rc = PTR_ERR(cq->umem);
+			goto err_umem;
+		}
+
+		cq->q.ptr = NULL;
+		cq->q.size = req_cq->size;
+		cq->q.mask = req_cq->mask;
+		cq->q.depth_log2 = req_cq->depth_log2;
+		cq->q.stride_log2 = req_cq->stride_log2;
+
+		*resp_cqid = cq->cqid;
+	} else {
+		rc = ionic_queue_init(&cq->q, dev->lif_cfg.hwdev,
+				      attr->cqe + IONIC_CQ_GRACE,
+				      sizeof(struct ionic_v1_cqe));
+		if (rc)
+			goto err_q_init;
+
+		ionic_queue_dbell_init(&cq->q, cq->cqid);
+		cq->color = true;
+		cq->reserve = cq->q.mask;
+	}
+
+	rc = ionic_pgtbl_init(dev, buf, cq->umem, cq->q.dma, 1, PAGE_SIZE);
+	if (rc) {
+		ibdev_dbg(&dev->ibdev,
+			  "create cq %u pgtbl_init error %d\n", cq->cqid, rc);
+		goto err_pgtbl_init;
+	}
+
+	init_completion(&cq->cq_rel_comp);
+	kref_init(&cq->cq_kref);
+
+	write_lock_irqsave(&dev->cq_tbl_rw, irqflags);
+	rc = xa_err(xa_store(&dev->cq_tbl, cq->cqid, cq, GFP_KERNEL));
+	write_unlock_irqrestore(&dev->cq_tbl_rw, irqflags);
+	if (rc)
+		goto err_xa;
+
+	return 0;
+
+err_xa:
+	ionic_pgtbl_unbuf(dev, buf);
+err_pgtbl_init:
+	if (!udata)
+		ionic_queue_destroy(&cq->q, dev->lif_cfg.hwdev);
+err_q_init:
+	if (cq->umem)
+		ib_umem_release(cq->umem);
+err_umem:
+err_qdesc:
+	ionic_put_cqid(dev, cq->cqid);
+err_cqid:
+err_args:
+	cq->vcq = NULL;
+
+	return rc;
+}
+
+void ionic_destroy_cq_common(struct ionic_ibdev *dev, struct ionic_cq *cq)
+{
+	unsigned long irqflags;
+
+	if (!cq->vcq)
+		return;
+
+	write_lock_irqsave(&dev->cq_tbl_rw, irqflags);
+	xa_erase(&dev->cq_tbl, cq->cqid);
+	write_unlock_irqrestore(&dev->cq_tbl_rw, irqflags);
+
+	kref_put(&cq->cq_kref, ionic_cq_complete);
+	wait_for_completion(&cq->cq_rel_comp);
+
+	if (cq->umem)
+		ib_umem_release(cq->umem);
+	else
+		ionic_queue_destroy(&cq->q, dev->lif_cfg.hwdev);
+
+	ionic_put_cqid(dev, cq->cqid);
+
+	cq->vcq = NULL;
+}
diff --git a/drivers/infiniband/hw/ionic/ionic_fw.h b/drivers/infiniband/hw/ionic/ionic_fw.h
new file mode 100644
index 000000000000..b4f029dde3a9
--- /dev/null
+++ b/drivers/infiniband/hw/ionic/ionic_fw.h
@@ -0,0 +1,164 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
+
+#ifndef _IONIC_FW_H_
+#define _IONIC_FW_H_
+
+#include <linux/kernel.h>
+
+/* completion queue v1 cqe */
+struct ionic_v1_cqe {
+	union {
+		struct {
+			__be16		cmd_idx;
+			__u8		cmd_op;
+			__u8		rsvd[17];
+			__le16		old_sq_cindex;
+			__le16		old_rq_cq_cindex;
+		} admin;
+		struct {
+			__u64		wqe_id;
+			__be32		src_qpn_op;
+			__u8		src_mac[6];
+			__be16		vlan_tag;
+			__be32		imm_data_rkey;
+		} recv;
+		struct {
+			__u8		rsvd[4];
+			__be32		msg_msn;
+			__u8		rsvd2[8];
+			__u64		npg_wqe_id;
+		} send;
+	};
+	__be32				status_length;
+	__be32				qid_type_flags;
+};
+
+/* bits for cqe qid_type_flags */
+enum ionic_v1_cqe_qtf_bits {
+	IONIC_V1_CQE_COLOR		= BIT(0),
+	IONIC_V1_CQE_ERROR		= BIT(1),
+	IONIC_V1_CQE_TYPE_SHIFT		= 5,
+	IONIC_V1_CQE_TYPE_MASK		= 0x7,
+	IONIC_V1_CQE_QID_SHIFT		= 8,
+
+	IONIC_V1_CQE_TYPE_ADMIN		= 0,
+	IONIC_V1_CQE_TYPE_RECV		= 1,
+	IONIC_V1_CQE_TYPE_SEND_MSN	= 2,
+	IONIC_V1_CQE_TYPE_SEND_NPG	= 3,
+};
+
+static inline bool ionic_v1_cqe_color(struct ionic_v1_cqe *cqe)
+{
+	return !!(cqe->qid_type_flags & cpu_to_be32(IONIC_V1_CQE_COLOR));
+}
+
+static inline bool ionic_v1_cqe_error(struct ionic_v1_cqe *cqe)
+{
+	return !!(cqe->qid_type_flags & cpu_to_be32(IONIC_V1_CQE_ERROR));
+}
+
+static inline void ionic_v1_cqe_clean(struct ionic_v1_cqe *cqe)
+{
+	cqe->qid_type_flags |= cpu_to_be32(~0u << IONIC_V1_CQE_QID_SHIFT);
+}
+
+static inline u32 ionic_v1_cqe_qtf(struct ionic_v1_cqe *cqe)
+{
+	return be32_to_cpu(cqe->qid_type_flags);
+}
+
+static inline u8 ionic_v1_cqe_qtf_type(u32 qtf)
+{
+	return (qtf >> IONIC_V1_CQE_TYPE_SHIFT) & IONIC_V1_CQE_TYPE_MASK;
+}
+
+static inline u32 ionic_v1_cqe_qtf_qid(u32 qtf)
+{
+	return qtf >> IONIC_V1_CQE_QID_SHIFT;
+}
+
+#define ADMIN_WQE_STRIDE	64
+#define ADMIN_WQE_HDR_LEN	4
+
+/* admin queue v1 wqe */
+struct ionic_v1_admin_wqe {
+	__u8				op;
+	__u8				rsvd;
+	__le16				len;
+
+	union {
+	} cmd;
+};
+
+/* admin queue v1 cqe status */
+enum ionic_v1_admin_status {
+	IONIC_V1_ASTS_OK,
+	IONIC_V1_ASTS_BAD_CMD,
+	IONIC_V1_ASTS_BAD_INDEX,
+	IONIC_V1_ASTS_BAD_STATE,
+	IONIC_V1_ASTS_BAD_TYPE,
+	IONIC_V1_ASTS_BAD_ATTR,
+	IONIC_V1_ASTS_MSG_TOO_BIG,
+};
+
+/* event queue v1 eqe */
+struct ionic_v1_eqe {
+	__be32				evt;
+};
+
+/* bits for cqe queue_type_flags */
+enum ionic_v1_eqe_evt_bits {
+	IONIC_V1_EQE_COLOR		= BIT(0),
+	IONIC_V1_EQE_TYPE_SHIFT		= 1,
+	IONIC_V1_EQE_TYPE_MASK		= 0x7,
+	IONIC_V1_EQE_CODE_SHIFT		= 4,
+	IONIC_V1_EQE_CODE_MASK		= 0xf,
+	IONIC_V1_EQE_QID_SHIFT		= 8,
+
+	/* cq events */
+	IONIC_V1_EQE_TYPE_CQ		= 0,
+	/* cq normal events */
+	IONIC_V1_EQE_CQ_NOTIFY		= 0,
+	/* cq error events */
+	IONIC_V1_EQE_CQ_ERR		= 8,
+
+	/* qp and srq events */
+	IONIC_V1_EQE_TYPE_QP		= 1,
+	/* qp normal events */
+	IONIC_V1_EQE_SRQ_LEVEL		= 0,
+	IONIC_V1_EQE_SQ_DRAIN		= 1,
+	IONIC_V1_EQE_QP_COMM_EST	= 2,
+	IONIC_V1_EQE_QP_LAST_WQE	= 3,
+	/* qp error events */
+	IONIC_V1_EQE_QP_ERR		= 8,
+	IONIC_V1_EQE_QP_ERR_REQUEST	= 9,
+	IONIC_V1_EQE_QP_ERR_ACCESS	= 10,
+};
+
+static inline bool ionic_v1_eqe_color(struct ionic_v1_eqe *eqe)
+{
+	return !!(eqe->evt & cpu_to_be32(IONIC_V1_EQE_COLOR));
+}
+
+static inline u32 ionic_v1_eqe_evt(struct ionic_v1_eqe *eqe)
+{
+	return be32_to_cpu(eqe->evt);
+}
+
+static inline u8 ionic_v1_eqe_evt_type(u32 evt)
+{
+	return (evt >> IONIC_V1_EQE_TYPE_SHIFT) & IONIC_V1_EQE_TYPE_MASK;
+}
+
+static inline u8 ionic_v1_eqe_evt_code(u32 evt)
+{
+	return (evt >> IONIC_V1_EQE_CODE_SHIFT) & IONIC_V1_EQE_CODE_MASK;
+}
+
+static inline u32 ionic_v1_eqe_evt_qid(u32 evt)
+{
+	return evt >> IONIC_V1_EQE_QID_SHIFT;
+}
+
+#endif /* _IONIC_FW_H_ */
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.c b/drivers/infiniband/hw/ionic/ionic_ibdev.c
index ca047a789378..21d2820f36ce 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.c
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.c
@@ -22,9 +22,99 @@ static const struct auxiliary_device_id ionic_aux_id_table[] = {
 
 MODULE_DEVICE_TABLE(auxiliary, ionic_aux_id_table);
 
+void ionic_port_event(struct ionic_ibdev *dev, enum ib_event_type event)
+{
+	struct ib_event ev;
+
+	ev.device = &dev->ibdev;
+	ev.element.port_num = 1;
+	ev.event = event;
+
+	ib_dispatch_event(&ev);
+}
+
+static int ionic_init_resids(struct ionic_ibdev *dev)
+{
+	int rc;
+
+	rc = ionic_resid_init(&dev->inuse_cqid, dev->lif_cfg.cq_count);
+	if (rc)
+		return rc;
+
+	dev->next_cqid[0] = 0;
+	dev->next_cqid[1] = dev->lif_cfg.cq_count / dev->lif_cfg.udma_count;
+	dev->half_cqid_udma_shift =
+		order_base_2(dev->lif_cfg.cq_count / dev->lif_cfg.udma_count);
+
+	rc = ionic_resid_init(&dev->inuse_pdid, IONIC_MAX_PD);
+	if (rc)
+		goto err_pdid;
+
+	rc = ionic_resid_init(&dev->inuse_ahid, dev->lif_cfg.nahs_per_lif);
+	if (rc)
+		goto err_ahid;
+
+	rc = ionic_resid_init(&dev->inuse_mrid, dev->lif_cfg.nmrs_per_lif);
+	if (rc)
+		goto err_mrid;
+
+	/* skip reserved lkey */
+	dev->inuse_mrid.next_id = 1;
+	dev->next_mrkey = 1;
+
+	rc = ionic_resid_init(&dev->inuse_qpid, dev->lif_cfg.qp_count);
+	if (rc)
+		goto err_qpid;
+
+	/* skip reserved SMI and GSI qpids */
+	dev->next_qpid[0] = 2;
+	dev->next_qpid[1] = dev->lif_cfg.qp_count / dev->lif_cfg.udma_count;
+	dev->half_qpid_udma_shift =
+		order_base_2(dev->lif_cfg.qp_count / dev->lif_cfg.udma_count);
+
+	rc = ionic_resid_init(&dev->inuse_dbid, dev->lif_cfg.dbid_count);
+	if (rc)
+		goto err_dbid;
+
+	/* Reserve dbid zero for kernel pid */
+	dev->inuse_dbid.next_id = 1;
+
+	mutex_init(&dev->inuse_lock);
+	spin_lock_init(&dev->inuse_splock);
+
+	return 0;
+
+err_dbid:
+	ionic_resid_destroy(&dev->inuse_qpid);
+err_qpid:
+	ionic_resid_destroy(&dev->inuse_mrid);
+err_mrid:
+	ionic_resid_destroy(&dev->inuse_ahid);
+err_ahid:
+	ionic_resid_destroy(&dev->inuse_pdid);
+err_pdid:
+	ionic_resid_destroy(&dev->inuse_cqid);
+
+	return rc;
+}
+
+static void ionic_destroy_resids(struct ionic_ibdev *dev)
+{
+	ionic_resid_destroy(&dev->inuse_cqid);
+	ionic_resid_destroy(&dev->inuse_pdid);
+	ionic_resid_destroy(&dev->inuse_ahid);
+	ionic_resid_destroy(&dev->inuse_mrid);
+	ionic_resid_destroy(&dev->inuse_qpid);
+	ionic_resid_destroy(&dev->inuse_dbid);
+}
+
 static void ionic_destroy_ibdev(struct ionic_ibdev *dev)
 {
+	ionic_kill_rdma_admin(dev, false);
 	ib_unregister_device(&dev->ibdev);
+	ionic_destroy_rdma_admin(dev);
+	ionic_destroy_resids(dev);
+	xa_destroy(&dev->cq_tbl);
 	ib_dealloc_device(&dev->ibdev);
 }
 
@@ -46,6 +136,21 @@ static struct ionic_ibdev *ionic_create_ibdev(struct ionic_aux_dev *ionic_adev)
 
 	ionic_fill_lif_cfg(ionic_adev->lif, &dev->lif_cfg);
 
+	xa_init_flags(&dev->cq_tbl, GFP_ATOMIC);
+	rwlock_init(&dev->cq_tbl_rw);
+
+	rc = ionic_init_resids(dev);
+	if (rc)
+		goto err_resids;
+
+	rc = ionic_rdma_reset_devcmd(dev);
+	if (rc)
+		goto err_reset;
+
+	rc = ionic_create_rdma_admin(dev);
+	if (rc)
+		goto err_admin;
+
 	ibdev = &dev->ibdev;
 	ibdev->dev.parent = dev->lif_cfg.hwdev;
 
@@ -73,6 +178,12 @@ static struct ionic_ibdev *ionic_create_ibdev(struct ionic_aux_dev *ionic_adev)
 
 err_register:
 err_admin:
+	ionic_kill_rdma_admin(dev, false);
+	ionic_destroy_rdma_admin(dev);
+err_reset:
+	ionic_destroy_resids(dev);
+err_resids:
+	xa_destroy(&dev->cq_tbl);
 	ib_dealloc_device(&dev->ibdev);
 err_dev:
 	return ERR_PTR(rc);
@@ -116,6 +227,10 @@ static int __init ionic_mod_init(void)
 {
 	int rc;
 
+	ionic_evt_workq = create_workqueue(DRIVER_NAME "-evt");
+	if (!ionic_evt_workq)
+		return -ENOMEM;
+
 	rc = auxiliary_driver_register(&ionic_aux_r_driver);
 	if (rc)
 		goto err_aux;
@@ -123,12 +238,15 @@ static int __init ionic_mod_init(void)
 	return 0;
 
 err_aux:
+	destroy_workqueue(ionic_evt_workq);
+
 	return rc;
 }
 
 static void __exit ionic_mod_exit(void)
 {
 	auxiliary_driver_unregister(&ionic_aux_r_driver);
+	destroy_workqueue(ionic_evt_workq);
 }
 
 module_init(ionic_mod_init);
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.h b/drivers/infiniband/hw/ionic/ionic_ibdev.h
index e13adff390d7..bd10bae2cf72 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.h
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.h
@@ -4,18 +4,263 @@
 #ifndef _IONIC_IBDEV_H_
 #define _IONIC_IBDEV_H_
 
+#include <rdma/ib_umem.h>
 #include <rdma/ib_verbs.h>
+
 #include <ionic_api.h>
+#include <ionic_regs.h>
+
+#include "ionic_fw.h"
+#include "ionic_queue.h"
+#include "ionic_res.h"
 
 #include "ionic_lif_cfg.h"
 
+#define DRIVER_NAME		"ionic_rdma"
+#define DRIVER_SHORTNAME	"ionr"
+
 #define IONIC_MIN_RDMA_VERSION	0
 #define IONIC_MAX_RDMA_VERSION	2
 
+/* Config knobs */
+#define IONIC_EQ_DEPTH 511
+#define IONIC_EQ_COUNT 32
+#define IONIC_AQ_DEPTH 63
+#define IONIC_AQ_COUNT 4
+#define IONIC_EQ_ISR_BUDGET 10
+#define IONIC_EQ_WORK_BUDGET 1000
+#define IONIC_MAX_PD 1024
+
+#define IONIC_CQ_GRACE 100
+
+struct ionic_aq;
+struct ionic_cq;
+struct ionic_eq;
+struct ionic_vcq;
+
+enum ionic_admin_state {
+	IONIC_ADMIN_ACTIVE, /* submitting admin commands to queue */
+	IONIC_ADMIN_PAUSED, /* not submitting, but may complete normally */
+	IONIC_ADMIN_KILLED, /* not submitting, locally completed */
+};
+
+enum ionic_admin_flags {
+	IONIC_ADMIN_F_BUSYWAIT  = BIT(0),	/* Don't sleep */
+	IONIC_ADMIN_F_TEARDOWN  = BIT(1),	/* In destroy path */
+	IONIC_ADMIN_F_INTERRUPT = BIT(2),	/* Interruptible w/timeout */
+};
+
+struct ionic_qdesc {
+	__aligned_u64 addr;
+	__u32 size;
+	__u16 mask;
+	__u8 depth_log2;
+	__u8 stride_log2;
+};
+
+struct ionic_mmap_info {
+	struct list_head ctx_ent;
+	unsigned long offset;
+	unsigned long size;
+	unsigned long pfn;
+	bool writecombine;
+};
+
 struct ionic_ibdev {
 	struct ib_device	ibdev;
 
 	struct ionic_lif_cfg	lif_cfg;
+
+	/* These tables are used in the fast path.
+	 * They are protected by rw locks.
+	 */
+	struct xarray		qp_tbl;
+	struct xarray		cq_tbl;
+	rwlock_t		qp_tbl_rw;
+	rwlock_t		cq_tbl_rw;
+	struct mutex		inuse_lock; /* for id reservation */
+	spinlock_t		inuse_splock; /* for ahid reservation */
+
+	struct ionic_resid_bits	inuse_dbid;
+	struct ionic_resid_bits	inuse_pdid;
+	struct ionic_resid_bits	inuse_ahid;
+	struct ionic_resid_bits	inuse_mrid;
+	struct ionic_resid_bits	inuse_qpid;
+	struct ionic_resid_bits	inuse_cqid;
+
+	int			next_cqid[2];
+	int			next_qpid[2];
+	u8			half_cqid_udma_shift;
+	u8			half_qpid_udma_shift;
+	u8			next_qpid_udma_idx;
+	u8			next_mrkey;
+
+	struct work_struct	reset_work;
+	bool			reset_posted;
+	u32			reset_cnt;
+
+	struct delayed_work	admin_dwork;
+	struct ionic_aq		**aq_vec;
+	enum ionic_admin_state	admin_state;
+
+	struct ionic_eq		**eq_vec;
 };
 
+struct ionic_eq {
+	struct ionic_ibdev	*dev;
+
+	u32			eqid;
+	u32			intr;
+
+	struct ionic_queue	q;
+
+	int			armed;
+	bool			enable;
+
+	struct work_struct	work;
+
+	int			irq;
+	char			name[32];
+
+	u64			poll_isr;
+	u64			poll_isr_single;
+	u64			poll_isr_full;
+	u64			poll_wq;
+	u64			poll_wq_single;
+	u64			poll_wq_full;
+};
+
+struct ionic_admin_wr {
+	struct completion		work;
+	struct list_head		aq_ent;
+	struct ionic_v1_admin_wqe	wqe;
+	struct ionic_v1_cqe		cqe;
+	struct ionic_aq			*aq;
+	int				status;
+};
+
+struct ionic_admin_wr_q {
+	struct ionic_admin_wr	*wr;
+	int			wqe_strides;
+};
+
+struct ionic_aq {
+	struct ionic_ibdev	*dev;
+	struct ionic_vcq	*vcq;
+
+	struct work_struct	work;
+
+	unsigned long		stamp;
+	bool			armed;
+
+	u32			aqid;
+	u32			cqid;
+
+	spinlock_t		lock; /* for posting */
+	struct ionic_queue	q;
+	struct ionic_admin_wr_q	*q_wr;
+	struct list_head	wr_prod;
+	struct list_head	wr_post;
+};
+
+struct ionic_ctx {
+	struct ib_ucontext	ibctx;
+
+	u32			dbid;
+
+	struct mutex		mmap_mut; /* for mmap_list */
+	unsigned long long	mmap_off;
+	struct list_head	mmap_list;
+	struct ionic_mmap_info	mmap_dbell;
+};
+
+struct ionic_tbl_buf {
+	u32		tbl_limit;
+	u32		tbl_pages;
+	size_t		tbl_size;
+	__le64		*tbl_buf;
+	dma_addr_t	tbl_dma;
+	u8		page_size_log2;
+};
+
+struct ionic_cq {
+	struct ionic_vcq	*vcq;
+
+	u32			cqid;
+	u32			eqid;
+
+	spinlock_t		lock; /* for polling */
+	struct list_head	poll_sq;
+	bool			flush;
+	struct list_head	flush_sq;
+	struct list_head	flush_rq;
+	struct list_head	cq_list_ent;
+
+	struct ionic_queue	q;
+	bool			color;
+	int			reserve;
+	u16			arm_any_prod;
+	u16			arm_sol_prod;
+
+	struct kref		cq_kref;
+	struct completion	cq_rel_comp;
+
+	/* infrequently accessed, keep at end */
+	struct ib_umem		*umem;
+};
+
+struct ionic_vcq {
+	struct ib_cq		ibcq;
+	struct ionic_cq		cq[2];
+	u8			udma_mask;
+	u8			poll_idx;
+};
+
+static inline struct ionic_ibdev *to_ionic_ibdev(struct ib_device *ibdev)
+{
+	return container_of(ibdev, struct ionic_ibdev, ibdev);
+}
+
+static inline void ionic_cq_complete(struct kref *kref)
+{
+	struct ionic_cq *cq = container_of(kref, struct ionic_cq, cq_kref);
+
+	complete(&cq->cq_rel_comp);
+}
+
+/* ionic_admin.c */
+extern struct workqueue_struct *ionic_evt_workq;
+void ionic_admin_post(struct ionic_ibdev *dev, struct ionic_admin_wr *wr);
+int ionic_admin_wait(struct ionic_ibdev *dev, struct ionic_admin_wr *wr,
+		     enum ionic_admin_flags);
+
+int ionic_rdma_reset_devcmd(struct ionic_ibdev *dev);
+
+int ionic_create_rdma_admin(struct ionic_ibdev *dev);
+void ionic_destroy_rdma_admin(struct ionic_ibdev *dev);
+void ionic_kill_rdma_admin(struct ionic_ibdev *dev, bool fatal_path);
+
+/* ionic_controlpath.c */
+int ionic_create_cq_common(struct ionic_vcq *vcq,
+			   struct ionic_tbl_buf *buf,
+			   const struct ib_cq_init_attr *attr,
+			   struct ionic_ctx *ctx,
+			   struct ib_udata *udata,
+			   struct ionic_qdesc *req_cq,
+			   __u32 *resp_cqid,
+			   int udma_idx);
+void ionic_destroy_cq_common(struct ionic_ibdev *dev, struct ionic_cq *cq);
+
+/* ionic_pgtbl.c */
+int ionic_pgtbl_page(struct ionic_tbl_buf *buf, u64 dma);
+int ionic_pgtbl_init(struct ionic_ibdev *dev,
+		     struct ionic_tbl_buf *buf,
+		     struct ib_umem *umem,
+		     dma_addr_t dma,
+		     int limit,
+		     u64 page_size);
+void ionic_pgtbl_unbuf(struct ionic_ibdev *dev, struct ionic_tbl_buf *buf);
+
+/* ionic_ibdev.c */
+void ionic_port_event(struct ionic_ibdev *dev, enum ib_event_type event);
 #endif /* _IONIC_IBDEV_H_ */
diff --git a/drivers/infiniband/hw/ionic/ionic_pgtbl.c b/drivers/infiniband/hw/ionic/ionic_pgtbl.c
new file mode 100644
index 000000000000..11461f7642bc
--- /dev/null
+++ b/drivers/infiniband/hw/ionic/ionic_pgtbl.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
+
+#include <linux/mman.h>
+#include <linux/dma-mapping.h>
+
+#include "ionic_fw.h"
+#include "ionic_ibdev.h"
+
+int ionic_pgtbl_page(struct ionic_tbl_buf *buf, u64 dma)
+{
+	if (unlikely(buf->tbl_pages == buf->tbl_limit))
+		return -ENOMEM;
+
+	if (buf->tbl_buf)
+		buf->tbl_buf[buf->tbl_pages] = cpu_to_le64(dma);
+	else
+		buf->tbl_dma = dma;
+
+	++buf->tbl_pages;
+
+	return 0;
+}
+
+static int ionic_tbl_buf_alloc(struct ionic_ibdev *dev,
+			       struct ionic_tbl_buf *buf)
+{
+	int rc;
+
+	buf->tbl_size = buf->tbl_limit * sizeof(*buf->tbl_buf);
+	buf->tbl_buf = kmalloc(buf->tbl_size, GFP_KERNEL);
+	if (!buf->tbl_buf)
+		return -ENOMEM;
+
+	buf->tbl_dma = dma_map_single(dev->lif_cfg.hwdev, buf->tbl_buf,
+				      buf->tbl_size, DMA_TO_DEVICE);
+	rc = dma_mapping_error(dev->lif_cfg.hwdev, buf->tbl_dma);
+	if (rc) {
+		kfree(buf->tbl_buf);
+		return rc;
+	}
+
+	return 0;
+}
+
+static int ionic_pgtbl_umem(struct ionic_tbl_buf *buf, struct ib_umem *umem)
+{
+	struct ib_block_iter biter;
+	u64 page_dma;
+	int rc;
+
+	rdma_umem_for_each_dma_block(umem, &biter, BIT_ULL(buf->page_size_log2)) {
+		page_dma = rdma_block_iter_dma_address(&biter);
+		rc = ionic_pgtbl_page(buf, page_dma);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+void ionic_pgtbl_unbuf(struct ionic_ibdev *dev, struct ionic_tbl_buf *buf)
+{
+	if (buf->tbl_buf)
+		dma_unmap_single(dev->lif_cfg.hwdev, buf->tbl_dma,
+				 buf->tbl_size, DMA_TO_DEVICE);
+
+	kfree(buf->tbl_buf);
+	memset(buf, 0, sizeof(*buf));
+}
+
+int ionic_pgtbl_init(struct ionic_ibdev *dev,
+		     struct ionic_tbl_buf *buf,
+		     struct ib_umem *umem,
+		     dma_addr_t dma,
+		     int limit,
+		     u64 page_size)
+{
+	int rc;
+
+	memset(buf, 0, sizeof(*buf));
+
+	if (umem) {
+		limit = ib_umem_num_dma_blocks(umem, page_size);
+		buf->page_size_log2 = order_base_2(page_size);
+	}
+
+	if (limit < 1)
+		return -EINVAL;
+
+	buf->tbl_limit = limit;
+
+	/* skip pgtbl if contiguous / direct translation */
+	if (limit > 1) {
+		rc = ionic_tbl_buf_alloc(dev, buf);
+		if (rc)
+			return rc;
+	}
+
+	if (umem)
+		rc = ionic_pgtbl_umem(buf, umem);
+	else
+		rc = ionic_pgtbl_page(buf, dma);
+
+	if (rc)
+		goto err_unbuf;
+
+	return 0;
+
+err_unbuf:
+	ionic_pgtbl_unbuf(dev, buf);
+	return rc;
+}
diff --git a/drivers/infiniband/hw/ionic/ionic_queue.c b/drivers/infiniband/hw/ionic/ionic_queue.c
new file mode 100644
index 000000000000..aa897ed2a412
--- /dev/null
+++ b/drivers/infiniband/hw/ionic/ionic_queue.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
+
+#include <linux/dma-mapping.h>
+
+#include "ionic_queue.h"
+
+int ionic_queue_init(struct ionic_queue *q, struct device *dma_dev,
+		     int depth, size_t stride)
+{
+	if (depth < 0 || depth > 0xffff)
+		return -EINVAL;
+
+	if (stride == 0 || stride > 0x10000)
+		return -EINVAL;
+
+	if (depth == 0)
+		depth = 1;
+
+	q->depth_log2 = order_base_2(depth + 1);
+	q->stride_log2 = order_base_2(stride);
+
+	if (q->depth_log2 + q->stride_log2 < PAGE_SHIFT)
+		q->depth_log2 = PAGE_SHIFT - q->stride_log2;
+
+	if (q->depth_log2 > 16 || q->stride_log2 > 16)
+		return -EINVAL;
+
+	q->size = BIT_ULL(q->depth_log2 + q->stride_log2);
+	q->mask = BIT(q->depth_log2) - 1;
+
+	q->ptr = dma_alloc_coherent(dma_dev, q->size, &q->dma, GFP_KERNEL);
+	if (!q->ptr)
+		return -ENOMEM;
+
+	/* it will always be page aligned, but just to be sure... */
+	if (!PAGE_ALIGNED(q->ptr)) {
+		dma_free_coherent(dma_dev, q->size, q->ptr, q->dma);
+		return -ENOMEM;
+	}
+
+	q->prod = 0;
+	q->cons = 0;
+	q->dbell = 0;
+
+	return 0;
+}
+
+void ionic_queue_destroy(struct ionic_queue *q, struct device *dma_dev)
+{
+	dma_free_coherent(dma_dev, q->size, q->ptr, q->dma);
+}
diff --git a/drivers/infiniband/hw/ionic/ionic_queue.h b/drivers/infiniband/hw/ionic/ionic_queue.h
new file mode 100644
index 000000000000..d18020d4cad5
--- /dev/null
+++ b/drivers/infiniband/hw/ionic/ionic_queue.h
@@ -0,0 +1,234 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
+
+#ifndef _IONIC_QUEUE_H_
+#define _IONIC_QUEUE_H_
+
+#include <linux/io.h>
+#include <ionic_regs.h>
+
+#define IONIC_MAX_DEPTH		0xffff
+#define IONIC_MAX_CQ_DEPTH	0xffff
+#define IONIC_CQ_RING_ARM	IONIC_DBELL_RING_1
+#define IONIC_CQ_RING_SOL	IONIC_DBELL_RING_2
+
+/**
+ * struct ionic_queue - Ring buffer used between device and driver
+ * @size:	Size of the buffer, in bytes
+ * @dma:	Dma address of the buffer
+ * @ptr:	Buffer virtual address
+ * @prod:	Driver position in the queue
+ * @cons:	Device position in the queue
+ * @mask:	Capacity of the queue, subtracting the hole
+ *		This value is equal to ((1 << depth_log2) - 1)
+ * @depth_log2: Log base two size depth of the queue
+ * @stride_log2: Log base two size of an element in the queue
+ * @dbell:	Doorbell identifying bits
+ */
+struct ionic_queue {
+	size_t size;
+	dma_addr_t dma;
+	void *ptr;
+	u16 prod;
+	u16 cons;
+	u16 mask;
+	u8 depth_log2;
+	u8 stride_log2;
+	u64 dbell;
+};
+
+/**
+ * ionic_queue_init() - Initialize user space queue
+ * @q:		Uninitialized queue structure
+ * @dma_dev:	DMA device for mapping
+ * @depth:	Depth of the queue
+ * @stride:	Size of each element of the queue
+ *
+ * Return: status code
+ */
+int ionic_queue_init(struct ionic_queue *q, struct device *dma_dev,
+		     int depth, size_t stride);
+
+/**
+ * ionic_queue_destroy() - Destroy user space queue
+ * @q:		Queue structure
+ * @dma_dev:	DMA device for mapping
+ *
+ * Return: status code
+ */
+void ionic_queue_destroy(struct ionic_queue *q, struct device *dma_dev);
+
+/**
+ * ionic_queue_empty() - Test if queue is empty
+ * @q:		Queue structure
+ *
+ * This is only valid for to-device queues.
+ *
+ * Return: is empty
+ */
+static inline bool ionic_queue_empty(struct ionic_queue *q)
+{
+	return q->prod == q->cons;
+}
+
+/**
+ * ionic_queue_length() - Get the current length of the queue
+ * @q:		Queue structure
+ *
+ * This is only valid for to-device queues.
+ *
+ * Return: length
+ */
+static inline u16 ionic_queue_length(struct ionic_queue *q)
+{
+	return (q->prod - q->cons) & q->mask;
+}
+
+/**
+ * ionic_queue_length_remaining() - Get the remaining length of the queue
+ * @q:		Queue structure
+ *
+ * This is only valid for to-device queues.
+ *
+ * Return: length remaining
+ */
+static inline u16 ionic_queue_length_remaining(struct ionic_queue *q)
+{
+	return q->mask - ionic_queue_length(q);
+}
+
+/**
+ * ionic_queue_full() - Test if queue is full
+ * @q:		Queue structure
+ *
+ * This is only valid for to-device queues.
+ *
+ * Return: is full
+ */
+static inline bool ionic_queue_full(struct ionic_queue *q)
+{
+	return q->mask == ionic_queue_length(q);
+}
+
+/**
+ * ionic_color_wrap() - Flip the color if prod is wrapped
+ * @prod:	Queue index just after advancing
+ * @color:	Queue color just prior to advancing the index
+ *
+ * Return: color after advancing the index
+ */
+static inline bool ionic_color_wrap(u16 prod, bool color)
+{
+	/* logical xor color with (prod == 0) */
+	return color != (prod == 0);
+}
+
+/**
+ * ionic_queue_at() - Get the element at the given index
+ * @q:		Queue structure
+ * @idx:	Index in the queue
+ *
+ * The index must be within the bounds of the queue.  It is not checked here.
+ *
+ * Return: pointer to element at index
+ */
+static inline void *ionic_queue_at(struct ionic_queue *q, u16 idx)
+{
+	return q->ptr + ((unsigned long)idx << q->stride_log2);
+}
+
+/**
+ * ionic_queue_at_prod() - Get the element at the producer index
+ * @q:		Queue structure
+ *
+ * Return: pointer to element at producer index
+ */
+static inline void *ionic_queue_at_prod(struct ionic_queue *q)
+{
+	return ionic_queue_at(q, q->prod);
+}
+
+/**
+ * ionic_queue_at_cons() - Get the element at the consumer index
+ * @q:		Queue structure
+ *
+ * Return: pointer to element at consumer index
+ */
+static inline void *ionic_queue_at_cons(struct ionic_queue *q)
+{
+	return ionic_queue_at(q, q->cons);
+}
+
+/**
+ * ionic_queue_next() - Compute the next index
+ * @q:		Queue structure
+ * @idx:	Index
+ *
+ * Return: next index after idx
+ */
+static inline u16 ionic_queue_next(struct ionic_queue *q, u16 idx)
+{
+	return (idx + 1) & q->mask;
+}
+
+/**
+ * ionic_queue_produce() - Increase the producer index
+ * @q:		Queue structure
+ *
+ * Caller must ensure that the queue is not full.  It is not checked here.
+ */
+static inline void ionic_queue_produce(struct ionic_queue *q)
+{
+	q->prod = ionic_queue_next(q, q->prod);
+}
+
+/**
+ * ionic_queue_consume() - Increase the consumer index
+ * @q:		Queue structure
+ *
+ * Caller must ensure that the queue is not empty.  It is not checked here.
+ *
+ * This is only valid for to-device queues.
+ */
+static inline void ionic_queue_consume(struct ionic_queue *q)
+{
+	q->cons = ionic_queue_next(q, q->cons);
+}
+
+/**
+ * ionic_queue_consume_entries() - Increase the consumer index by entries
+ * @q:				Queue structure
+ * @entries:		Number of entries to increment
+ *
+ * Caller must ensure that the queue is not empty.  It is not checked here.
+ *
+ * This is only valid for to-device queues.
+ */
+static inline void ionic_queue_consume_entries(struct ionic_queue *q,
+					       u16 entries)
+{
+	q->cons = (q->cons + entries) & q->mask;
+}
+
+/**
+ * ionic_queue_dbell_init() - Initialize doorbell bits for queue id
+ * @q:		Queue structure
+ * @qid:	Queue identifying number
+ */
+static inline void ionic_queue_dbell_init(struct ionic_queue *q, u32 qid)
+{
+	q->dbell = IONIC_DBELL_QID(qid);
+}
+
+/**
+ * ionic_queue_dbell_val() - Get current doorbell update value
+ * @q:		Queue structure
+ *
+ * Return: current doorbell update value
+ */
+static inline u64 ionic_queue_dbell_val(struct ionic_queue *q)
+{
+	return q->dbell | q->prod;
+}
+
+#endif /* _IONIC_QUEUE_H_ */
diff --git a/drivers/infiniband/hw/ionic/ionic_res.c b/drivers/infiniband/hw/ionic/ionic_res.c
new file mode 100644
index 000000000000..a3b4f10aa4c8
--- /dev/null
+++ b/drivers/infiniband/hw/ionic/ionic_res.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
+
+#include <linux/bitmap.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+
+#include "ionic_res.h"
+
+int ionic_resid_init(struct ionic_resid_bits *resid, int size)
+{
+	int size_bytes = sizeof(long) * BITS_TO_LONGS(size);
+
+	resid->next_id = 0;
+	resid->inuse_size = size;
+
+	resid->inuse = kzalloc(size_bytes, GFP_KERNEL);
+	if (!resid->inuse)
+		return -ENOMEM;
+
+	return 0;
+}
+
+int ionic_resid_get_shared(struct ionic_resid_bits *resid, int wrap_id,
+			   int next_id, int size)
+{
+	int id;
+
+	id = find_next_zero_bit(resid->inuse, size, next_id);
+	if (id != size) {
+		set_bit(id, resid->inuse);
+		return id;
+	}
+
+	id = find_next_zero_bit(resid->inuse, next_id, wrap_id);
+	if (id != next_id) {
+		set_bit(id, resid->inuse);
+		return id;
+	}
+
+	return -ENOMEM;
+}
diff --git a/drivers/infiniband/hw/ionic/ionic_res.h b/drivers/infiniband/hw/ionic/ionic_res.h
new file mode 100644
index 000000000000..e833ced1466e
--- /dev/null
+++ b/drivers/infiniband/hw/ionic/ionic_res.h
@@ -0,0 +1,182 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
+
+#ifndef _IONIC_RES_H_
+#define _IONIC_RES_H_
+
+/**
+ * struct ionic_resid_bits - Number allocator based on find_first_zero_bit
+ *
+ * @next_id:    The bitnumber to start searching at
+ * @inuse_size: The bitmap size in bits
+ * @inuse:      The address to base the search on
+ *
+ * The allocator find_first_zero_bit suffers O(N^2) search time complexity,
+ * for N allocations.  This is because it starts from the beginning of the
+ * bitmap each time.  To find a free bit in the bitmap, the search time
+ * increases for each allocation as the beginning of the bitmap is filled.  On
+ * the other hand, it is desirable for O(1) memory size complexity, assuming
+ * the capacity is constant.
+ *
+ * This allocator is intended to keep the desired memory size complexity, but
+ * improve the search time complexity for typical workloads.  The search time
+ * complexity is expected to be closer to O(N), for N allocations, although it
+ * remains bounded by O(N^2) in the worst case.
+ */
+struct ionic_resid_bits {
+	int next_id;
+	int inuse_size;
+	unsigned long *inuse;
+};
+
+/**
+ * ionic_resid_init() - Initialize a resid allocator
+ * @resid:  Uninitialized resid allocator
+ * @size:   Capacity of the allocator
+ *
+ * Return: Zero on success, or negative error number
+ */
+int ionic_resid_init(struct ionic_resid_bits *resid, int size);
+
+/**
+ * ionic_resid_destroy() - Destroy a resid allocator
+ * @resid:  Resid allocator
+ */
+static inline void ionic_resid_destroy(struct ionic_resid_bits *resid)
+{
+	kfree(resid->inuse);
+}
+
+/**
+ * ionic_resid_get_shared() - Allocate an available shared resource id
+ * @resid:   Resid allocator
+ * @wrap_id: Smallest valid resource id
+ * @next_id: Start the search at resource id
+ * @size:    One after largest valid resource id
+ *
+ * This does not update the next_id.  Caller should update the next_id for
+ * the resource that shares the id space, and/or the shared resid->next_id as
+ * appropriate.
+ *
+ * Return: Resource id, or negative error number
+ */
+int ionic_resid_get_shared(struct ionic_resid_bits *resid, int wrap_id,
+			   int next_id, int size);
+
+/**
+ * ionic_resid_get_wrap() - Allocate an available resource id, wrap to nonzero
+ * @resid:   Resid allocator
+ * @wrap_id: Smallest valid resource id
+ *
+ * Return: Resource id, or negative error number
+ */
+static inline int ionic_resid_get_wrap(struct ionic_resid_bits *resid,
+				       int wrap_id)
+{
+	int rc;
+
+	rc = ionic_resid_get_shared(resid, wrap_id,
+				    resid->next_id,
+				    resid->inuse_size);
+	if (rc >= 0)
+		resid->next_id = rc + 1;
+
+	return rc;
+}
+
+/**
+ * ionic_resid_get() - Allocate an available resource id
+ * @resid: Resid allocator
+ *
+ * Return: Resource id, or negative error number
+ */
+static inline int ionic_resid_get(struct ionic_resid_bits *resid)
+{
+	return ionic_resid_get_wrap(resid, 0);
+}
+
+/**
+ * ionic_resid_put() - Free a resource id
+ * @resid:  Resid allocator
+ * @id:     Resource id
+ */
+static inline void ionic_resid_put(struct ionic_resid_bits *resid, int id)
+{
+	clear_bit(id, resid->inuse);
+}
+
+/**
+ * ionic_bitid_to_qid() - Transform a resource bit index into a queue id
+ * @bitid:           Bit index
+ * @qgrp_shift:      Log2 number of queues per queue group
+ * @half_qid_shift:  Log2 of half the total number of queues
+ *
+ * Return: Queue id
+ *
+ * Udma-constrained queues (QPs and CQs) are associated with their udma by
+ * queue group. Even queue groups are associated with udma0, and odd queue
+ * groups with udma1.
+ *
+ * For allocating queue ids, we want to arrange the bits into two halves,
+ * with the even queue groups of udma0 in the lower half of the bitset,
+ * and the odd queue groups of udma1 in the upper half of the bitset.
+ * Then, one or two calls of find_next_zero_bit can examine all the bits
+ * for queues of an entire udma.
+ *
+ * For example, assuming eight queue groups with qgrp qids per group:
+ *
+ * bitid 0*qgrp..1*qgrp-1 : qid 0*qgrp..1*qgrp-1
+ * bitid 1*qgrp..2*qgrp-1 : qid 2*qgrp..3*qgrp-1
+ * bitid 2*qgrp..3*qgrp-1 : qid 4*qgrp..5*qgrp-1
+ * bitid 3*qgrp..4*qgrp-1 : qid 6*qgrp..7*qgrp-1
+ * bitid 4*qgrp..5*qgrp-1 : qid 1*qgrp..2*qgrp-1
+ * bitid 5*qgrp..6*qgrp-1 : qid 3*qgrp..4*qgrp-1
+ * bitid 6*qgrp..7*qgrp-1 : qid 5*qgrp..6*qgrp-1
+ * bitid 7*qgrp..8*qgrp-1 : qid 7*qgrp..8*qgrp-1
+ *
+ * There are three important ranges of bits in the qid.  There is the udma
+ * bit "U" at qgrp_shift, which is the least significant bit of the group
+ * index, and determines which udma a queue is associated with.
+ * The bits of lesser significance we can call the idx bits "I", which are
+ * the index of the queue within the group.  The bits of greater significance
+ * we can call the grp bits "G", which are other bits of the group index that
+ * do not determine the udma.  Those bits are just rearranged in the bit index
+ * in the bitset.  A bitid has the udma bit in the most significant place,
+ * then the grp bits, then the idx bits.
+ *
+ * bitid: 00000000000000 U GGG IIIIII
+ * qid:   00000000000000 GGG U IIIIII
+ *
+ * Transforming from bit index to qid, or from qid to bit index, can be
+ * accomplished by rearranging the bits by masking and shifting.
+ */
+static inline u32 ionic_bitid_to_qid(u32 bitid, u8 qgrp_shift,
+				     u8 half_qid_shift)
+{
+	u32 udma_bit =
+		(bitid & BIT(half_qid_shift)) >> (half_qid_shift - qgrp_shift);
+	u32 grp_bits = (bitid & GENMASK(half_qid_shift - 1, qgrp_shift)) << 1;
+	u32 idx_bits = bitid & (BIT(qgrp_shift) - 1);
+
+	return grp_bits | udma_bit | idx_bits;
+}
+
+/**
+ * ionic_qid_to_bitid() - Transform a queue id into a resource bit index
+ * @qid:            queue index
+ * @qgrp_shift:     Log2 number of queues per queue group
+ * @half_qid_shift: Log2 of half the total number of queues
+ *
+ * Return: Resource bit index
+ *
+ * This is the inverse of ionic_bitid_to_qid().
+ */
+static inline u32 ionic_qid_to_bitid(u32 qid, u8 qgrp_shift, u8 half_qid_shift)
+{
+	u32 udma_bit = (qid & BIT(qgrp_shift)) << (half_qid_shift - qgrp_shift);
+	u32 grp_bits = (qid & GENMASK(half_qid_shift, qgrp_shift + 1)) >> 1;
+	u32 idx_bits = qid & (BIT(qgrp_shift) - 1);
+
+	return udma_bit | grp_bits | idx_bits;
+}
+#endif /* _IONIC_RES_H_ */
-- 
2.34.1


