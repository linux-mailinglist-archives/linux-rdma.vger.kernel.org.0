Return-Path: <linux-rdma+bounces-12736-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFD0B25AE9
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 07:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 150747ABC33
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 05:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17722356C0;
	Thu, 14 Aug 2025 05:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zj7+gQXe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0534023183C;
	Thu, 14 Aug 2025 05:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755149980; cv=fail; b=DCtdx+ZVEzrGgBjZ6jAZL77WHnVJZSOhI+lQNp6PgeWVECyga7QvVnTdhw4jnBhN75lDUTb07/iaoCIoqfMoBzhC1n+YXJ4NW1R3vAVwbkcHG04SEWdMqNryF6RwiT45a7DWQF1IMNHQgWfDG70I2c4VcEirrvMp/QJ64/AFrwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755149980; c=relaxed/simple;
	bh=+VzOr43iTWgDtxaSZ3J6fp7o8fJIVlHBtyaiHDdKPAM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MqEhpD96VUAbWBRdiY/dZLed2n/zoS6C4WnOFlFstUbjlElDhW8sPHpZHy1F0+6W8x5f2zOmw1Rs6XoVmcFN/K4zItJgWEXlcNdGvYuJElTh131NHxG45Dlpapa9MFCSlAwhgj7m74Z/91kJxPMacbJfo8foM+iWhwWhMFm4YfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zj7+gQXe; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q17zKDAwsKjkk8U7Z7OspsUZo+y8pmhiffQDfEJa8SCMIYtGy339H8G9q6rcqVebWAe0E1MHs3MpD96FmHEAOOAcUSmXRriuzWespkD1MUnFCUUjZ59wZgU856JCERseb5nu07fx71y1DJhlqxXhAeFqFZOYbGIQ5Vp+X2a8/lyTRK88BRPI/MknQDxVnvvZ3A07TG2MjyQISUH+rCd8klzykbNQP3vJJWEViztLOQgLDF4499Ds4wYKyLzHW5uzcRI/ASN3aS8L9gPZs+XkmiFVEeyGhzhZ4MI889QTrqgRYMygMSlSYPUe2iHOusJ0cgvt07ps5aFIlJGSoo/Bxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFLk0eoNiAIeG45aUblgkvyIUpJd3GlBO06frfi2H4w=;
 b=w8dHVRIYDr4LBZofymA0nZU95q5q217mcLP549u9RgA4pnzxnRM3ErF1ngAXFj9YfJFGvd9SohE34eg+QJVZcFA/JMFKnO+cVIVl9Tni2gdchHT65go/8cvtnhQxzxZ1gHZeL9H6eDZUaDwTfnFm2C4AM4A3slEw9q6l8L7S9XJXtkTZnn8s3QuhHhfi+aOPvP684oARrhNnmNHGsaZuIW1ytJyBPsjqSbn2jskea0DbyZTm2I/aygbNhAo0BT3TUlthAvLEsD719kj5+zQCD6zjNBEWdEOkPTw4f20pLlMKmTYvl3RO2xNoPzPTcAKyNW4d2h+GdfTXB0MI1hci+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFLk0eoNiAIeG45aUblgkvyIUpJd3GlBO06frfi2H4w=;
 b=Zj7+gQXe8APV0OeoQeeIQHs6DwuQ1usFFS+EF5OJpHjdS/MmbcswFJVxBng/u8puRa+o71EgpnW1+uxklOmlyYXDrxtZKWOSMDPrDheVp2oxUooWo4aQufHsn2uN/FV2N+tOSsi1GlTRCEAmNpYFPUXGf64kL7sXGffEES3mAB8=
Received: from SN1PR12CA0078.namprd12.prod.outlook.com (2603:10b6:802:20::49)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Thu, 14 Aug
 2025 05:39:35 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:802:20:cafe::82) by SN1PR12CA0078.outlook.office365.com
 (2603:10b6:802:20::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Thu,
 14 Aug 2025 05:39:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 05:39:34 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 00:39:34 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 13 Aug
 2025 22:39:33 -0700
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 14 Aug 2025 00:39:29 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <brett.creeley@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <sln@onemain.com>, <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v5 04/14] net: ionic: Provide RDMA reset support for the RDMA driver
Date: Thu, 14 Aug 2025 11:08:50 +0530
Message-ID: <20250814053900.1452408-5-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250814053900.1452408-1-abhijit.gangurde@amd.com>
References: <20250814053900.1452408-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ae1b32-964d-4c99-950e-08dddaf4f38f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pGqB3tfpqxV0LHobCjBTj3pvF8NwpNkosiAJRNC+QyD4lOTScXXPiNe2uKGA?=
 =?us-ascii?Q?erln1cOEvJ6dTn9zSxK5HnaT/BmEh7XvJUnYxHOpYcgLkU1WC8gj//4nao2N?=
 =?us-ascii?Q?xXoIUAP/IBkFQLJ+YXOhQyJcXLw1ZcNEioADLOw3/n+txEHAkSq9QFO29JY4?=
 =?us-ascii?Q?9q3IbbKsliXWK41cvW3iItMTVocIjsqFXg8c5xxttai+3LN2GJE9oFYvr8IT?=
 =?us-ascii?Q?AkdO9UUGMnfwJs0nw5b85EyMCTNPblrropQmkrCzSQOPqv8MqA7fU4AJA0bl?=
 =?us-ascii?Q?VLhgu45tSqT/2pynI9biZI5IpXjZ57Yd8nHYCpu5JhoM+/jV2lOqsLUS4yiP?=
 =?us-ascii?Q?9n1aoYdnzjobuWBwF+Sl7Y2lMmqYfnC5p7iUHxmQXBzIdO3pLvvIIt7QVCx8?=
 =?us-ascii?Q?QXPw5ldhKo+RfTYn+tp3042pLJR7RWPyFctcNBZtd/5AJJs85Hu+tVgpztRr?=
 =?us-ascii?Q?yZ25BaYvfZVrvsgm9SGV/eM2mtUFFRQHKfEvSDNJTPwxT6hfsIFzv8ZBvVks?=
 =?us-ascii?Q?f8eytenbjOlgoEqzxUj9LJxiIkmLTnG83ZZg81NBrplfUwqvzNKMuHXAxNwE?=
 =?us-ascii?Q?vBwkjxzgteXTG8+XGE3NNkZsRZ+CIgTYgUA4dCigJE+ByQPvL2mj+GlfMesc?=
 =?us-ascii?Q?5FbGphAzDHdyOcEGDV1JeRFSZ3t+N+8JIbAJpKKsbw5X8VgoOf/GapSbK6G1?=
 =?us-ascii?Q?/OQXrFEKkMk+h2xdB7g0I0LFrgVrWQabfT3/DErUw/cbcvJyKB1P5fAHEeAe?=
 =?us-ascii?Q?sJ4A6XPZiZlj11LqZ7zUKUcGVQ24KLWRvdJP8UP3vRRMmHNC/oqfpjSOn6/H?=
 =?us-ascii?Q?m5V979SoVkXwQZKWUJMrF4OJ9Y1cCtM05eTgKvgNMR39/kZ7jgyNgc4FHE8H?=
 =?us-ascii?Q?Q6w4oSSjEK5oT9hY9srd1IPdPCg33cyAsWmH1tPQsVsDv0pSBeCFXjUTe44c?=
 =?us-ascii?Q?Zrbi+czYeJMzz8LdmDfyZ+M3fgUkylaiw+9/cfRbq7SiYtX7YlB6XflN2Pwo?=
 =?us-ascii?Q?epil5KDWa/JNORzAM+1/f5fh5mro/Y7m5zOtq7Ndrb/nR6a+M5MaB3EcZUBB?=
 =?us-ascii?Q?vkPmOuwS+K9/XY4H4DPawUuDckOBYbW5nhu21HmN6J5zIipmS+CzSSzScNrq?=
 =?us-ascii?Q?Ia4tQJVjA7NaselpAyWF2FJQXZXCRNZhhzYtKwEzwQh6U6tuB6UgAFU14oRI?=
 =?us-ascii?Q?yBiHJO4HSK2iD4fU8Utptghe8pJpfXOccY4LXeKFaxksfBjgQcwuFsAk43TC?=
 =?us-ascii?Q?zndg8pJWIomJlDrpR48uopxY5Ad7t8z5eNjSE72FvFB8pxFcPxJs/hI9uSPq?=
 =?us-ascii?Q?taQPMRrLk4Bpk1vYHEsjZ+mBLS+jIWNFeEjLeMoFodHj8/MVGgfmIo7CJfZu?=
 =?us-ascii?Q?fa8OumKio06R7Bs64DNkB1Yajbwj6szqixvIP4/ia8M4fDXbzVSs+bUCnuH9?=
 =?us-ascii?Q?2nDv7vFvAFDAj8QRAzPw0f2MyPfCQkXgfvTCAW7pZyMLBS87gwHtDf+CbYtD?=
 =?us-ascii?Q?syvg+Lrsq4iwjZ8cwsMtnKzZWHMQyz+PdskB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 05:39:34.8929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ae1b32-964d-4c99-950e-08dddaf4f38f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702

The Ethernet driver holds the privilege to execute the device commands.
Export the function to execute RDMA reset command for use by RDMA driver.

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_api.h   |  9 ++++++++
 .../net/ethernet/pensando/ionic/ionic_aux.c   | 22 +++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_api.h b/drivers/net/ethernet/pensando/ionic/ionic_api.h
index d75902ca34af..e0b766d1769f 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_api.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_api.h
@@ -54,4 +54,13 @@ int ionic_adminq_post_wait(struct ionic_lif *lif, struct ionic_admin_ctx *ctx);
  */
 int ionic_error_to_errno(enum ionic_status_code code);
 
+/**
+ * ionic_request_rdma_reset - request reset or disable the device or lif
+ * @lif:        Logical interface
+ *
+ * The reset is triggered asynchronously. It will wait until reset request
+ * completes or times out.
+ */
+void ionic_request_rdma_reset(struct ionic_lif *lif);
+
 #endif /* _IONIC_API_H_ */
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_aux.c b/drivers/net/ethernet/pensando/ionic/ionic_aux.c
index f3c2a5227b36..a2be338eb3e5 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_aux.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_aux.c
@@ -78,3 +78,25 @@ void ionic_auxbus_unregister(struct ionic_lif *lif)
 out:
 	mutex_unlock(&lif->adev_lock);
 }
+
+void ionic_request_rdma_reset(struct ionic_lif *lif)
+{
+	struct ionic *ionic = lif->ionic;
+	int err;
+
+	union ionic_dev_cmd cmd = {
+		.cmd.opcode = IONIC_CMD_RDMA_RESET_LIF,
+		.cmd.lif_index = cpu_to_le16(lif->index),
+	};
+
+	mutex_lock(&ionic->dev_cmd_lock);
+
+	ionic_dev_cmd_go(&ionic->idev, &cmd);
+	err = ionic_dev_cmd_wait(ionic, DEVCMD_TIMEOUT);
+
+	mutex_unlock(&ionic->dev_cmd_lock);
+
+	if (err)
+		pr_warn("%s request_reset: error %d\n", __func__, err);
+}
+EXPORT_SYMBOL_NS(ionic_request_rdma_reset, "NET_IONIC");
-- 
2.43.0


