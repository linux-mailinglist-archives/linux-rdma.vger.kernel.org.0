Return-Path: <linux-rdma+bounces-9719-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1146DA98763
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 12:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37C75A1B82
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 10:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F2526FA55;
	Wed, 23 Apr 2025 10:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fRvOErI6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90AD26F475;
	Wed, 23 Apr 2025 10:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745404254; cv=fail; b=boPmiF2SiaKtoiqwkMAEfm/Fc3Btuh33VyqKM1+e2S4sNq2ftOghkf4dBeZZgLTYSyuv04hdLdHi7E94S1db7surFUFdghVikh1Vg6JWX7yyhxdMEEBfk/6MmnUS3EVwhHxkG7fZrfiaLUtlU/FFTLy4Z0QkeJ5OdIyTON5OfYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745404254; c=relaxed/simple;
	bh=o4Xg37l/nPZ1xhp6szsgcGdAgDohZvzAJXHpeQvqD98=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s+kcFP1fe5q2Mx1C/I0bPX6kIHrjcwq+PeuU9UjFc7F3EXI0ItfFS2t3+KbuYnR/iampLUE8Kj/5RyQEaxn8H1rG81i5bDqe73EGKDfX0S9R32jobFm2P13yMltBat//5ZlJ5dyYvAw8u2Cci14rtW5B86sfqClhfNDsNqGevgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fRvOErI6; arc=fail smtp.client-ip=40.107.95.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+IvyCpV4NSi8UgL2sw6qkMpKBNUknCQqrr6Oog7nDo15Vdybx4TCw53AOyeIpPN8LA9X6kaBPSTQSPYmLf4EzP3kWnWRjNtZylLOXpE/YBHTTAT+2IYvquT4a273c+pNmjc44+R76Lksz1OH4Pm6Su/pBxdvu+cSRcbsRStAvw4CnmfwyzIn9IlDDOiyMilFflUP4h+xdrFB/uHzMNZMzapo30OQiCmteXEmyURUZRJkylXIYkVTsh5vsfPMBYeDCZhngQA0XfMwjseD/Ex1u8BqJnxBA4qckrFGXOmB4qp1P0XKdseudB7oVci+G3vNKidarpMZ3RYdYzmSkj12A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G834EeojtraYa5yTwVKjBO/F1hoIGIvKwZpTSPhQbE4=;
 b=aQqIhOmDw/s5Q7j8tw0NjE7GNiFCsoYAoTfZSe7XLnznfp/EVYA0dQDIu+3qQy5dGPQvFVXAahH4/Y/r/thPu9tW6rAGojj8RF5+DdBgRh4rUdjmpkfwNoykIpulmKikFPXMNsnJqcfESpuC9O1f79Twvjei4R4R6in++9DjwJ7vuHTXRPBrROz/J6+LXtnM9muEIADqiDaU5R+XqatocSGkfB4x4BgaJxE1SH/nH9Uw1j/8yBvYcMNe2aoDJIbX/jYpiqzGdclQBlBDaPPK5L+6STizTZ4b62k/yIofeyUsZZ10VC75JorYVGjqY1D4QNpyi8Z+dGrKXjUs6UYhIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G834EeojtraYa5yTwVKjBO/F1hoIGIvKwZpTSPhQbE4=;
 b=fRvOErI6zUEVBBFhI1/U2DuWM8bOBZrxIQgzt99TbVYagA1at8/yVmV9yfnEnc4wPJGP3mKHTXMXUtBsS6s+mK5bJHuwxTTseqBbb6cOlTJ9bcdzorqnhGiJhusnhfN9SdWQDfco1u7QFxqoDlBo4bYeNFYZRT/vOSRc5HP/CwQ=
Received: from BYAPR11CA0050.namprd11.prod.outlook.com (2603:10b6:a03:80::27)
 by DM4PR12MB7670.namprd12.prod.outlook.com (2603:10b6:8:105::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 10:30:49 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:80:cafe::db) by BYAPR11CA0050.outlook.office365.com
 (2603:10b6:a03:80::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Wed,
 23 Apr 2025 10:30:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 10:30:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 05:30:46 -0500
Received: from xhdipdslab48.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 23 Apr 2025 05:30:40 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH 04/14] net: ionic: Export the APIs from net driver to support device commands
Date: Wed, 23 Apr 2025 15:59:03 +0530
Message-ID: <20250423102913.438027-5-abhijit.gangurde@amd.com>
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
Received-SPF: None (SATLEXMB04.amd.com: abhijit.gangurde@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|DM4PR12MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: f26b94f2-ef14-4b7d-3803-08dd8251ea75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8lqHdTvZUsyr1TB+IUmxNObHrI7f5O0xHyh+AQkysU0Gqm9H3HFOZm504k0l?=
 =?us-ascii?Q?oID100dq/UUYImLxWgwLy5Puww7lKtYsTB1jjPyWcpJDItqv5hfAIIV7ATbN?=
 =?us-ascii?Q?BaBWpycj6chby+o9N+gHW+klsqKkSF+Uy5M1luFc/IYYZMhNDAwt+SDepHgJ?=
 =?us-ascii?Q?qkEr0iDYCq9xYIWbJiRH6E+NhLcECDoZvKm2DqwUDG9lwgD62XNHHTkbkDMW?=
 =?us-ascii?Q?iN5rmjTJ4HjLpHkPK8yCmqFCOmQra/YOoa+AZSJh6w0qWL84QyHhNIN3NVc6?=
 =?us-ascii?Q?ZzFzKaudBHB+EQoSkWNqy0VGXat5YrpAaGP9rvTm1AvH4OWho0gcBc5BEGWx?=
 =?us-ascii?Q?aL7hkR7dUjDS6N4Rz1dUabk3N+UfQJe8eg0pqNcD8a8ogd07aux1s4ZanjaQ?=
 =?us-ascii?Q?R+NhuNLyTAa2qQ6Tnlyao9wiOV9wc1Z8PRLZV+tHhvcvn2sdPMX1E1rCjSeS?=
 =?us-ascii?Q?qTwYQFKjQHVGXggnkewIlMMtaM0QTEq/BSEnqG4WZJD+dn9FRaT+C9ycyCj9?=
 =?us-ascii?Q?G10JYHk8H4S7Rl8F/1vzD3EFoNkGUUoOpxxP0keLbazZjCRDOyCL6DqZZMvQ?=
 =?us-ascii?Q?bpAODVvaniu3T2nO8BMDkZFHf5KNDfGT0o5X82ChPBQyEJf5e9YS7V2OGje2?=
 =?us-ascii?Q?3PJJSnnDTh/eXjUA7IFpq3BT+TsPLIFwTZe02+aIm2xtjSnQgaTgVtqKZ2zz?=
 =?us-ascii?Q?UNzN8q6aH/wsZyCGq8wVV4DNzPHlBb4QEfon6/ax/QNaekytSx0VlRZWVsND?=
 =?us-ascii?Q?7mb5I9laFaijn5EcNZeVNHUiFf7ElveK4+/1zFon3cUpR55Tu6t3cEmy5zcP?=
 =?us-ascii?Q?2tmN5NGlnn9Ez4OujvGreUDRimflb3La8fDQklDUnQ/mj0DLILKCWghdIVN0?=
 =?us-ascii?Q?i2yCq7hg662R5ig+4tzVJ/3NLzLPTSpY2WhXdpyYByCx+Z6RLzJcCLt0tjar?=
 =?us-ascii?Q?Qa/XpuBqJvmcgnUfgX+sAiZoL3V2MqvyFzCI+nL4qKPnm9HMWQvKBo27TKkl?=
 =?us-ascii?Q?Brf09fZ/30lhDsHh/kuhfwk2gtcyScbiE4fVefFbETW4n9kre45imCFXlypP?=
 =?us-ascii?Q?DlxocHnNb7m3Q8ih02/9FqIkXCdmxYUxEgKuxigBewBsQHjMP4S3OiBXFKfE?=
 =?us-ascii?Q?zDngH4/m9JYc37wMyTIqWKdY/RcsLGXQtYUwtx8oY+ruqiIZ9kA7U5Rdr/wW?=
 =?us-ascii?Q?NRxHhcUfil9ve00LFlUsa5vA1PwU3xvhAhqHix2EAVcg30BDnEAk4HuVw9Cp?=
 =?us-ascii?Q?zjn+aJ430Sk9xuJhRxOwm8D/lwzTi0fMEQwLumSx3Yh+A8nOKb4vkr99YShF?=
 =?us-ascii?Q?QhE75cCwIKQ2i+Wzby55uBp6dnKyVbxDaJExsGtCuPgaeWBYEGLIDiUocWCh?=
 =?us-ascii?Q?KaYXSdu29wCzclD5jZN8kz2AIvpIn7HhnFxtCc0QWn2qxxp4v5+/Gr92dHVq?=
 =?us-ascii?Q?8d/ulX7k84RZZTwdvU5bydMoOSRq7/HOTYedTQ0yO7kjX0GMMQ8kFQ7P3rL7?=
 =?us-ascii?Q?Ue7zB9X4YCoa5ChPJQvgVhlWfKiJgPVuxx488Dj3xG2hWTr5eQorfUCeNA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 10:30:49.2740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f26b94f2-ef14-4b7d-3803-08dd8251ea75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7670

RDMA driver needs to establish admin queues to support admin operations.
Export the APIs to send device commands, allocate interrupts for
event queues and get doorbell page information.

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic.h   |  8 +-
 .../net/ethernet/pensando/ionic/ionic_api.c   | 93 ++++++++++++++++++
 .../net/ethernet/pensando/ionic/ionic_api.h   | 94 +++++++++++++++++++
 .../net/ethernet/pensando/ionic/ionic_bus.h   |  1 +
 .../ethernet/pensando/ionic/ionic_bus_pci.c   |  6 ++
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 41 ++++++--
 .../net/ethernet/pensando/ionic/ionic_lif.h   |  5 +
 .../net/ethernet/pensando/ionic/ionic_main.c  |  2 +-
 8 files changed, 237 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic.h b/drivers/net/ethernet/pensando/ionic/ionic.h
index 013e1ce72d0d..5abdaf2fa3a6 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic.h
@@ -65,12 +65,6 @@ struct ionic {
 	int watchdog_period;
 };
 
-struct ionic_admin_ctx {
-	struct completion work;
-	union ionic_adminq_cmd cmd;
-	union ionic_adminq_comp comp;
-};
-
 int ionic_adminq_post(struct ionic_lif *lif, struct ionic_admin_ctx *ctx);
 int ionic_adminq_wait(struct ionic_lif *lif, struct ionic_admin_ctx *ctx,
 		      const int err, const bool do_msg);
@@ -97,4 +91,6 @@ int ionic_port_reset(struct ionic *ionic);
 
 bool ionic_doorbell_wa(struct ionic *ionic);
 
+int ionic_error_to_errno(enum ionic_status_code code);
+
 #endif /* _IONIC_H_ */
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_api.c b/drivers/net/ethernet/pensando/ionic/ionic_api.c
index 8c39e6183ad4..201053cf4ea8 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_api.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_api.c
@@ -4,6 +4,7 @@
 #include <linux/kernel.h>
 
 #include "ionic.h"
+#include "ionic_bus.h"
 #include "ionic_lif.h"
 
 struct net_device *ionic_api_get_netdev_from_handle(void *handle)
@@ -31,6 +32,31 @@ const union ionic_lif_identity *ionic_api_get_identity(void *handle,
 }
 EXPORT_SYMBOL_NS(ionic_api_get_identity, "NET_IONIC");
 
+void ionic_api_request_reset(void *handle)
+{
+	struct ionic_lif *lif = handle;
+	struct ionic *ionic;
+	int err;
+
+	union ionic_dev_cmd cmd = {
+		.cmd.opcode = IONIC_CMD_RDMA_RESET_LIF,
+		.cmd.lif_index = cpu_to_le16(lif->index),
+	};
+
+	ionic = lif->ionic;
+
+	mutex_lock(&ionic->dev_cmd_lock);
+
+	ionic_dev_cmd_go(&ionic->idev, &cmd);
+	err = ionic_dev_cmd_wait(ionic, DEVCMD_TIMEOUT);
+
+	mutex_unlock(&ionic->dev_cmd_lock);
+
+	if (err)
+		netdev_warn(lif->netdev, "request_reset: error %d\n", err);
+}
+EXPORT_SYMBOL_NS(ionic_api_request_reset, "NET_IONIC");
+
 const struct ionic_devinfo *ionic_api_get_devinfo(void *handle)
 {
 	struct ionic_lif *lif = handle;
@@ -38,3 +64,70 @@ const struct ionic_devinfo *ionic_api_get_devinfo(void *handle)
 	return &lif->ionic->idev.dev_info;
 }
 EXPORT_SYMBOL_NS(ionic_api_get_devinfo, "NET_IONIC");
+
+int ionic_api_get_intr(void *handle, int *irq)
+{
+	struct ionic_intr_info intr_obj;
+	struct ionic_lif *lif = handle;
+	int err;
+
+	if (!lif->nrdma_eqs_avail)
+		return -ENOSPC;
+
+	err = ionic_intr_alloc(lif->ionic, &intr_obj);
+	if (err)
+		return err;
+
+	err = ionic_bus_get_irq(lif->ionic, intr_obj.index);
+	if (err < 0) {
+		ionic_intr_free(lif->ionic, intr_obj.index);
+		return err;
+	}
+
+	lif->nrdma_eqs_avail--;
+
+	*irq = err;
+	return intr_obj.index;
+}
+EXPORT_SYMBOL_NS(ionic_api_get_intr, "NET_IONIC");
+
+void ionic_api_put_intr(void *handle, int intr_index)
+{
+	struct ionic_lif *lif = handle;
+
+	ionic_intr_free(lif->ionic, intr_index);
+
+	lif->nrdma_eqs_avail++;
+}
+EXPORT_SYMBOL_NS(ionic_api_put_intr, "NET_IONIC");
+
+void ionic_api_kernel_dbpage(void *handle,
+			     struct ionic_intr __iomem **intr_ctrl,
+			     u32 *dbid, u64 __iomem **dbpage)
+{
+	struct ionic_lif *lif = handle;
+
+	*intr_ctrl = lif->ionic->idev.intr_ctrl;
+
+	*dbid = lif->kern_pid;
+	*dbpage = lif->kern_dbpage;
+}
+EXPORT_SYMBOL_NS(ionic_api_kernel_dbpage, "NET_IONIC");
+
+int ionic_api_adminq_post(void *handle, struct ionic_admin_ctx *ctx)
+{
+	return ionic_adminq_post(handle, ctx);
+}
+EXPORT_SYMBOL_NS(ionic_api_adminq_post, "NET_IONIC");
+
+int ionic_api_adminq_post_wait(void *handle, struct ionic_admin_ctx *ctx)
+{
+	return ionic_adminq_post_wait(handle, ctx);
+}
+EXPORT_SYMBOL_NS(ionic_api_adminq_post_wait, "NET_IONIC");
+
+int ionic_api_error_to_errno(enum ionic_status_code code)
+{
+	return ionic_error_to_errno(code);
+}
+EXPORT_SYMBOL_NS(ionic_api_error_to_errno, "NET_IONIC");
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_api.h b/drivers/net/ethernet/pensando/ionic/ionic_api.h
index f59391102c62..80606a37ae45 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_api.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_api.h
@@ -65,4 +65,98 @@ struct net_device *ionic_api_get_netdev_from_handle(void *handle);
  */
 const struct ionic_devinfo *ionic_api_get_devinfo(void *handle);
 
+/**
+ * ionic_api_request_reset - request reset or disable the device or lif
+ * @handle:     Handle to lif
+ *
+ * The reset is triggered asynchronously. It will wait until reset request
+ * completes or times out.
+ */
+void ionic_api_request_reset(void *handle);
+
+/**
+ * ionic_api_get_intr - Reserve a device interrupt index
+ * @handle:     Handle to lif
+ * @irq:        OS interrupt number returned
+ *
+ * Reserve an interrupt index, and indicate the irq number for that index.
+ *
+ * Return: interrupt index or negative error status
+ */
+int ionic_api_get_intr(void *handle, int *irq);
+
+/**
+ * ionic_api_put_intr - Release a device interrupt index
+ * @handle:     Handle to lif
+ * @intr:       Interrupt index
+ *
+ * Mark the interrupt index unused so that it can be reserved again.
+ */
+void ionic_api_put_intr(void *handle, int intr);
+
+/**
+ * ionic_api_kernel_dbpage - Get mapped doorbell page for use in kernel space
+ * @handle:     Handle to lif
+ * @intr_ctrl:  Interrupt control registers
+ * @dbid:       Doorbell id for use in kernel space
+ * @dbpage:     One ioremapped doorbell page for use in kernel space
+ *
+ * This also provides mapped interrupt control registers.
+ *
+ * The id and page returned here refer to the doorbell page reserved for use in
+ * kernel space for this lif.  For user space, use ionic_api_get_dbid to
+ * allocate a doorbell id for exclusive use by a process.
+ */
+void ionic_api_kernel_dbpage(void *handle,
+			     struct ionic_intr __iomem **intr_ctrl,
+			     u32 *dbid, u64 __iomem **dbpage);
+
+/**
+ * struct ionic_admin_ctx - Admin command context
+ * @work:       Work completion wait queue element
+ * @cmd:        Admin command (64B) to be copied to the queue
+ * @comp:       Admin completion (16B) copied from the queue
+ */
+struct ionic_admin_ctx {
+	struct completion work;
+	union ionic_adminq_cmd cmd;
+	union ionic_adminq_comp comp;
+};
+
+/**
+ * ionic_api_adminq_post - Post an admin command
+ * @handle:     Handle to lif
+ * @ctx:        API admin command context
+ *
+ * Post the command to an admin queue in the ethernet driver.  If this command
+ * succeeds, then the command has been posted, but that does not indicate a
+ * completion.  If this command returns success, then the completion callback
+ * will eventually be called.
+ *
+ * Return: zero or negative error status
+ */
+int ionic_api_adminq_post(void *handle, struct ionic_admin_ctx *ctx);
+
+/**
+ * ionic_api_adminq_post_wait - Post an admin command and wait for response
+ * @handle:     Handle to lif
+ * @ctx:        API admin command context
+ *
+ * Post the command to an admin queue in the ethernet driver.  If this command
+ * succeeds, then the command has been posted, but that does not indicate a
+ * completion.  If this command returns success, then the completion callback
+ * will eventually be called.
+ *
+ * Return: zero or negative error status
+ */
+int ionic_api_adminq_post_wait(void *handle, struct ionic_admin_ctx *ctx);
+
+/**
+ * ionic_api_error_to_errno - Transform ionic_if errors to os errno
+ * @code:       Ionic error number
+ *
+ * Return:      Negative OS error number or zero
+ */
+int ionic_api_error_to_errno(enum ionic_status_code code);
+
 #endif /* _IONIC_API_H_ */
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus.h b/drivers/net/ethernet/pensando/ionic/ionic_bus.h
index 2f4d08c64910..0963b6aabd42 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus.h
@@ -12,5 +12,6 @@ int ionic_bus_register_driver(void);
 void ionic_bus_unregister_driver(void);
 void __iomem *ionic_bus_map_dbpage(struct ionic *ionic, int page_num);
 void ionic_bus_unmap_dbpage(struct ionic *ionic, void __iomem *page);
+phys_addr_t ionic_bus_phys_dbpage(struct ionic *ionic, int page_num);
 
 #endif /* _IONIC_BUS_H_ */
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index bb75044dfb82..5fa8840b063f 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -109,6 +109,12 @@ void ionic_bus_unmap_dbpage(struct ionic *ionic, void __iomem *page)
 	iounmap(page);
 }
 
+phys_addr_t ionic_bus_phys_dbpage(struct ionic *ionic, int page_num)
+{
+	return ionic->bars[IONIC_PCI_BAR_DBELL].bus_addr +
+		((phys_addr_t)page_num << PAGE_SHIFT);
+}
+
 static void ionic_vf_dealloc_locked(struct ionic *ionic)
 {
 	struct ionic_vf_setattr_cmd vfc = { .attr = IONIC_VF_ATTR_STATSADDR };
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index e63ed91879a1..c1ad2b95d2b9 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -244,14 +244,13 @@ static int ionic_request_irq(struct ionic_lif *lif, struct ionic_qcq *qcq)
 				0, intr->name, &qcq->napi);
 }
 
-static int ionic_intr_alloc(struct ionic_lif *lif, struct ionic_intr_info *intr)
+int ionic_intr_alloc(struct ionic *ionic, struct ionic_intr_info *intr)
 {
-	struct ionic *ionic = lif->ionic;
 	int index;
 
 	index = find_first_zero_bit(ionic->intrs, ionic->nintrs);
 	if (index == ionic->nintrs) {
-		netdev_warn(lif->netdev, "%s: no intr, index=%d nintrs=%d\n",
+		netdev_warn(ionic->lif->netdev, "%s: no intr, index=%d nintrs=%d\n",
 			    __func__, index, ionic->nintrs);
 		return -ENOSPC;
 	}
@@ -262,7 +261,7 @@ static int ionic_intr_alloc(struct ionic_lif *lif, struct ionic_intr_info *intr)
 	return 0;
 }
 
-static void ionic_intr_free(struct ionic *ionic, int index)
+void ionic_intr_free(struct ionic *ionic, int index)
 {
 	if (index != IONIC_INTR_INDEX_NOT_ASSIGNED && index < ionic->nintrs)
 		clear_bit(index, ionic->intrs);
@@ -504,7 +503,7 @@ static int ionic_alloc_qcq_interrupt(struct ionic_lif *lif, struct ionic_qcq *qc
 		return 0;
 	}
 
-	err = ionic_intr_alloc(lif, &qcq->intr);
+	err = ionic_intr_alloc(lif->ionic, &qcq->intr);
 	if (err) {
 		netdev_warn(lif->netdev, "no intr for %s: %d\n",
 			    qcq->q.name, err);
@@ -3268,6 +3267,7 @@ int ionic_lif_alloc(struct ionic *ionic)
 	lif->netdev->max_mtu =
 		le32_to_cpu(lif->identity->eth.max_frame_size) - VLAN_ETH_HLEN;
 
+	lif->nrdma_eqs_avail = ionic->nrdma_eqs_per_lif;
 	lif->nrdma_eqs = ionic->nrdma_eqs_per_lif;
 	lif->nxqs = ionic->ntxqs_per_lif;
 
@@ -3295,6 +3295,7 @@ int ionic_lif_alloc(struct ionic *ionic)
 	mutex_init(&lif->queue_lock);
 	mutex_init(&lif->config_lock);
 	mutex_init(&lif->adev_lock);
+	mutex_init(&lif->dbid_inuse_lock);
 
 	spin_lock_init(&lif->adminq_lock);
 
@@ -3351,6 +3352,7 @@ int ionic_lif_alloc(struct ionic *ionic)
 	lif->info = NULL;
 	lif->info_pa = 0;
 err_out_free_mutex:
+	mutex_destroy(&lif->dbid_inuse_lock);
 	mutex_destroy(&lif->adev_lock);
 	mutex_destroy(&lif->config_lock);
 	mutex_destroy(&lif->queue_lock);
@@ -3507,6 +3509,14 @@ static void ionic_lif_handle_fw_up(struct ionic_lif *lif)
 	dev_err(ionic->dev, "FW Up: LIFs restart failed - err %d\n", err);
 }
 
+static void ionic_lif_dbid_inuse_free(struct ionic_lif *lif)
+{
+	mutex_lock(&lif->dbid_inuse_lock);
+	bitmap_free(lif->dbid_inuse);
+	lif->dbid_inuse = NULL;
+	mutex_unlock(&lif->dbid_inuse_lock);
+}
+
 void ionic_lif_free(struct ionic_lif *lif)
 {
 	struct device *dev = lif->ionic->dev;
@@ -3535,10 +3545,12 @@ void ionic_lif_free(struct ionic_lif *lif)
 	/* unmap doorbell page */
 	ionic_bus_unmap_dbpage(lif->ionic, lif->kern_dbpage);
 	lif->kern_dbpage = NULL;
+	ionic_lif_dbid_inuse_free(lif);
 
 	mutex_destroy(&lif->config_lock);
 	mutex_destroy(&lif->queue_lock);
 	mutex_destroy(&lif->adev_lock);
+	mutex_destroy(&lif->dbid_inuse_lock);
 
 	/* free netdev & lif */
 	ionic_debugfs_del_lif(lif);
@@ -3562,6 +3574,8 @@ void ionic_lif_deinit(struct ionic_lif *lif)
 	ionic_lif_qcq_deinit(lif, lif->notifyqcq);
 	ionic_lif_qcq_deinit(lif, lif->adminqcq);
 
+	ionic_lif_dbid_inuse_free(lif);
+
 	ionic_lif_reset(lif);
 }
 
@@ -3755,12 +3769,25 @@ int ionic_lif_init(struct ionic_lif *lif)
 		return -EINVAL;
 	}
 
+	mutex_lock(&lif->dbid_inuse_lock);
+	lif->dbid_inuse = bitmap_zalloc(lif->dbid_count, GFP_KERNEL);
+	if (!lif->dbid_inuse) {
+		dev_err(dev, "Failed alloc doorbell id bitmap, aborting\n");
+		mutex_unlock(&lif->dbid_inuse_lock);
+		return -ENOMEM;
+	}
+
+	/* first doorbell id reserved for kernel (dbid aka pid == zero) */
+	set_bit(0, lif->dbid_inuse);
+	mutex_unlock(&lif->dbid_inuse_lock);
 	lif->kern_pid = 0;
+
 	dbpage_num = ionic_db_page_num(lif, lif->kern_pid);
 	lif->kern_dbpage = ionic_bus_map_dbpage(lif->ionic, dbpage_num);
 	if (!lif->kern_dbpage) {
 		dev_err(dev, "Cannot map dbpage, aborting\n");
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err_out_free_dbid;
 	}
 
 	err = ionic_lif_adminq_init(lif);
@@ -3807,6 +3834,8 @@ int ionic_lif_init(struct ionic_lif *lif)
 	ionic_lif_reset(lif);
 	ionic_bus_unmap_dbpage(lif->ionic, lif->kern_dbpage);
 	lif->kern_dbpage = NULL;
+err_out_free_dbid:
+	ionic_lif_dbid_inuse_free(lif);
 
 	return err;
 }
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
index 333394e477e0..54c8bbe8960a 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
@@ -204,6 +204,7 @@ struct ionic_lif {
 	unsigned int kern_pid;
 	u64 __iomem *kern_dbpage;
 	unsigned int nrdma_eqs;
+	unsigned int nrdma_eqs_avail;
 	unsigned int nxqs;
 	unsigned int ntxq_descs;
 	unsigned int nrxq_descs;
@@ -241,6 +242,8 @@ struct ionic_lif {
 	u32 tx_coalesce_usecs;		/* what the user asked for */
 	u32 tx_coalesce_hw;		/* what the hw is using */
 	unsigned int dbid_count;
+	struct mutex dbid_inuse_lock;   /* lock the dbid bit list */
+	unsigned long *dbid_inuse;
 
 	struct ionic_phc *phc;
 
@@ -402,6 +405,8 @@ int ionic_lif_set_hwstamp_rxfilt(struct ionic_lif *lif, u64 pkt_class);
 
 int ionic_lif_rss_config(struct ionic_lif *lif, u16 types,
 			 const u8 *key, const u32 *indir);
+int ionic_intr_alloc(struct ionic *ionic, struct ionic_intr_info *intr);
+void ionic_intr_free(struct ionic *ionic, int index);
 void ionic_lif_rx_mode(struct ionic_lif *lif);
 int ionic_reconfigure_queues(struct ionic_lif *lif,
 			     struct ionic_queue_params *qparam);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index daf1e82cb76b..83e3117a199f 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -72,7 +72,7 @@ static const char *ionic_error_to_str(enum ionic_status_code code)
 	}
 }
 
-static int ionic_error_to_errno(enum ionic_status_code code)
+int ionic_error_to_errno(enum ionic_status_code code)
 {
 	switch (code) {
 	case IONIC_RC_SUCCESS:
-- 
2.34.1


