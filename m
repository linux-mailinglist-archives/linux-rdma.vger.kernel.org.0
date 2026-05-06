Return-Path: <linux-rdma+bounces-20048-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEGEDILB+mnRSQMAu9opvQ
	(envelope-from <linux-rdma+bounces-20048-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 06:20:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5FC4D615A
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 06:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3722F301D339
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 04:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF81E2F1FD7;
	Wed,  6 May 2026 04:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xaQrzCvm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011027.outbound.protection.outlook.com [40.107.208.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AF12F745D;
	Wed,  6 May 2026 04:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778041208; cv=fail; b=m/FCuPRw/eble/mLCAeRG1+fAxJ5JJ7kT8bp5vQkU6hC/FHNrqmmmsBJaQOrKu8zhUybQWT5WbX7FHE4Dd8QaQR+EZpkAnbNdX5A6kIIVyaksB+22OHHuKKYs7R5ZhDX1/ALtR8awsFgh4BuRyy0++2bnXhy0BikhJComUUSVfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778041208; c=relaxed/simple;
	bh=Uj7wU40Ao5OeuIRO/W73MEiWUBmr8Olsdk8u7Bh7K9o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kEjcCMP0XaIYkffHZ0O6sErR0ERLLzJKCqKj4zBvd+JvtmaPmDrGdpawPRp6lC1pD+hVfuoECEWabPu3JneOGABf9GQXiE2/ssh8er+epp2/OcJyCSZsw3g/CCsCuu7I9kHYtSZA0I93M7bXZQFrxpelooo2CSwU1sd2uz/cXa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xaQrzCvm; arc=fail smtp.client-ip=40.107.208.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRYLHoG/F1EPiwqE4d0Co5uiQgQCJecdEPfyU7hYkNwQD7TR92L16Xi4nRK9/wMkR0tSbALOOd+OT4eGVAIQLKeJms6ZQ14610iWtUwqvGHHDETsWD49V7KxrgpBVTsMiNtZyY45zx1NB0RPkEQOJbzahy/XkY8p6+8L9zhJJ9Yi/82/GGz+QrqBDAbQIh+SAM/qbT7BOBqDR/s3dLuXeCAPp+k+0nmxdFWGVUDlSxOdh6lKdKW8e3G0aVLbiJfnp0G1jL/j1aIc37UhFxmrGFnyscvBerSWwfiuQKmeXEWMHGWa/Dikx8xbS3sEJj9+YeaubsnCH3qjDxHB0Ib6Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSA1Y65yRuMyFSWNObo69kiE+1Nh3GepAIbgVnSS3Bw=;
 b=qQj6BLSGaN7L8rG30y/Rm5nny3GYr1lrJO5BQQb85ci5RS2iPOLsPKN0LnvenpSlutkFDOvddLhpeb19VqL2BKktoVAmt7YlEQpkPi26h9/cKCEe6PMDGMsP0A2vjSm09JP5Xi9QCePjBIfuZ2Zg5Z24O6Tltm/Za2nXP9mSjU3sgfUuPtIw9F41jqizLFcj9Sh6C5godsGqV0KTWsVuMROpv/luxDNSR5TxCC2v++lKJ43mOYjLAIsx8tYbBcJtjw0GEF1eetrNtr8IJKGRxfPoXfjT6YXQuA5GShQnj8SRk0NhH10HKZiRIpTo/o25VzFCFiBUz3RFc8isxAQaUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSA1Y65yRuMyFSWNObo69kiE+1Nh3GepAIbgVnSS3Bw=;
 b=xaQrzCvm6zmzSstlGnRy8iOjQYl5fVuPUUiVGurGuJauCVz0cRCVSykN+4LSpXQ74pMJdX1gKbVGeBaR6jAP+SGJF88l1eV8fR/gKwAUofqdrCpBo3z9p2cMdtBHlZqXlGiJxGRgFMR+YsM6EPJF8hTiWbd2l8+Snt6eZ+A1r6w=
Received: from PH7PR17CA0054.namprd17.prod.outlook.com (2603:10b6:510:325::18)
 by DM4PR12MB6256.namprd12.prod.outlook.com (2603:10b6:8:a3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.15; Wed, 6 May 2026 04:19:59 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::6f) by PH7PR17CA0054.outlook.office365.com
 (2603:10b6:510:325::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 04:19:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 04:19:59 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 23:19:57 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Abhijit Gangurde <abhijit.gangurde@amd.com>, Allen Hubbe
	<allen.hubbe@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net-next 4/4] RDMA/ionic: Add DCQCN parameter configuration via debugfs
Date: Tue, 5 May 2026 21:19:35 -0700
Message-ID: <20260506041935.1061-5-eric.joyner@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|DM4PR12MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c5840a6-5280-468c-d266-08deab26bcb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aqC6IggLf04ut59otk7oTG+ilKZEJFpB0YOFa3f59G6XwgaR+nh7UtgvgwyQPawuqL4F6b1IYq7gnGDofZ3fLqrCQ0lXskksk3I7RnvmvXaIFwcU+duB3PrnIuPxXGQLW8xHRrDoK84d6NGGWiNxXIHhx/fZIHYGqtYM7iwPhAsIG30FwehqSgItBt2EHNpjOZ85tfwWcKggronZvMNiPAwYfz3pyk+RkjQ12JiK+Bqj7JQtv7nEmjbjHfpaCCVuTFM6jaOx+d9xdvZVYubKH+KCfcFz64F43lsvsxHmBnD+wirwNyi5byWTE+4jRuWr3GqUYNmG0JAnc3IzQuK8sTklWXFzUMyNZsWzol0/eQH0p0wrFmgr0PMJVQTUSFw8H62GPU/Gjralfx9NVc/wa534Uz+Y+lgevQHgjBaikVzNo8NxnRhZJbgVMQlbfhpkcdkYdskXVVKeGl8rxxhkxccbd3Yo5gTGePIvEdAHPxlcxGpFIoezBHO2VbKgTWwW3NSPETxEBuNSQ9YhbpswS3oAEid5ZVjkOud0ATfozMZqkOZdgagl0HctWMWPUDLxPuxouFJy0EPpicWf3oAuXOBOsExp5GyI/SnhMXayYSKIsPjImGSImywGTG7MAZtqDqSMaijDf4xBBRBCBykMLXRsdPc6h68Spk5UzNDEubDLnt9BaX2aSGig841kRAyMzioRZVs+p6BQ1fiX0cBJHeQekwF/iczuu8SwgPkSHbA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JZKR/9pEhAy5+qje8GXphrAdk6+zE13lQ40LcSQU5SDzbfIrwjOvmDgm5hHjQbISJZQMj67OsWyhdpEIb/QCEsJ9neKMKu7BQXy5XUeJDMggIj73eCfVefhCcRqlT4kDWyxjwe5ufU9xOIvj7F35yyboZdZtRoj/NTfoJdZkY3LCi/bndiUYYmkgu1bR5g0tm1ESOFRF5kFkTCZepHjwS6RH3GC6jvQe6o6Y9vrZqL6tm/PXt6K++sfIS4Hl2FWoO0CLCtzVUIjBriNnXs84bkaab4+C42SPF4dcEh8DFcbBjakmCNu8nL3e9Cl4zZgHyF3EFu3bfvePuH03T0UpJX3vY2+VEnvdmLrjW78Zvqs9iBkKi+JeuIgeSjyYjbYpWk5STi+WOmVp9NfhMkkpsqQJZB3UQtSnN8exqFrJcawxEsl5pFTfvZAMeIMpEvN2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 04:19:59.4993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5840a6-5280-468c-d266-08deab26bcb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6256
X-Rspamd-Queue-Id: 2C5FC4D615A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20048-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Allen Hubbe <allen.hubbe@amd.com>

The HCA supports DCQCN with multiple profiles; these are normally
configured through a userspace utility, but expose these profiles and
their parameters for debug purposes via debugfs.

To use these, the firmware must be configured in the mode that expects
DCQCN settings to be programmed by the driver, otherwise the firmware
will silently fail and indicate success without any changes actually
occurring.

Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Co-developed-by: Eric Joyner <eric.joyner@amd.com>
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 drivers/infiniband/hw/ionic/Makefile          |   3 +-
 .../infiniband/hw/ionic/ionic_controlpath.c   |   5 +
 drivers/infiniband/hw/ionic/ionic_dcqcn.c     | 629 ++++++++++++++++++
 drivers/infiniband/hw/ionic/ionic_fw.h        |  31 +
 drivers/infiniband/hw/ionic/ionic_ibdev.c     |   4 +
 drivers/infiniband/hw/ionic/ionic_ibdev.h     |  12 +
 drivers/infiniband/hw/ionic/ionic_lif_cfg.c   |   1 +
 drivers/infiniband/hw/ionic/ionic_lif_cfg.h   |   2 +
 drivers/infiniband/hw/ionic/ionic_profiles.h  |  86 +++
 9 files changed, 772 insertions(+), 1 deletion(-)
 create mode 100644 drivers/infiniband/hw/ionic/ionic_dcqcn.c
 create mode 100644 drivers/infiniband/hw/ionic/ionic_profiles.h

diff --git a/drivers/infiniband/hw/ionic/Makefile b/drivers/infiniband/hw/ionic/Makefile
index 65bb4eaf0c13..1ad2c3d12b36 100644
--- a/drivers/infiniband/hw/ionic/Makefile
+++ b/drivers/infiniband/hw/ionic/Makefile
@@ -6,4 +6,5 @@ obj-$(CONFIG_INFINIBAND_IONIC)	+= ionic_rdma.o
 
 ionic_rdma-y :=	\
 	ionic_ibdev.o ionic_lif_cfg.o ionic_queue.o ionic_pgtbl.o ionic_admin.o \
-	ionic_controlpath.o ionic_datapath.o ionic_hw_stats.o ionic_debugfs.o
+	ionic_controlpath.o ionic_datapath.o ionic_hw_stats.o ionic_debugfs.o \
+	ionic_dcqcn.o
diff --git a/drivers/infiniband/hw/ionic/ionic_controlpath.c b/drivers/infiniband/hw/ionic/ionic_controlpath.c
index 0ea053369cba..4daca85c4fb3 100644
--- a/drivers/infiniband/hw/ionic/ionic_controlpath.c
+++ b/drivers/infiniband/hw/ionic/ionic_controlpath.c
@@ -1512,6 +1512,7 @@ static int ionic_modify_qp_cmd(struct ionic_ibdev *dev,
 			cpu_to_le32(qp->ahid | (hdr_len << 24));
 		wr.wqe.cmd.mod_qp.dma_addr = cpu_to_le64(hdr_dma);
 
+		wr.wqe.cmd.mod_qp.dcqcn_profile = qp->dcqcn_profile;
 		wr.wqe.cmd.mod_qp.en_pcp = attr->ah_attr.sl;
 		wr.wqe.cmd.mod_qp.ip_dscp = grh->traffic_class >> 2;
 	}
@@ -2586,6 +2587,10 @@ int ionic_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int mask,
 	if (mask & IB_QP_CAP)
 		return -EINVAL;
 
+	if (mask & IB_QP_AV)
+		qp->dcqcn_profile =
+		    ionic_dcqcn_select_profile(dev, &attr->ah_attr);
+
 	rc = ionic_modify_qp_cmd(dev, pd, qp, attr, mask);
 	if (rc)
 		return rc;
diff --git a/drivers/infiniband/hw/ionic/ionic_dcqcn.c b/drivers/infiniband/hw/ionic/ionic_dcqcn.c
new file mode 100644
index 000000000000..80fa79cfd951
--- /dev/null
+++ b/drivers/infiniband/hw/ionic/ionic_dcqcn.c
@@ -0,0 +1,629 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2018-2026, Advanced Micro Devices, Inc. */
+
+#include <linux/debugfs.h>
+
+#include "ionic_ibdev.h"
+#include "ionic_profiles.h"
+
+static const struct ionic_profile_vals dcqcn_defaults[] = {
+	{
+		.v[NP_ICNP_802P_PRIO]			= 6,
+		.v[NP_CNP_DSCP]				= 46,
+		.v[RP_TOKEN_BUCKET_SIZE]		= 800000,
+		.v[RP_INITIAL_ALPHA_VALUE]		= 64,
+		.v[RP_DCE_TCP_G]			= 512,
+		.v[RP_DCE_TCP_RTT]			= 1,
+		.v[RP_RATE_REDUCE_MONITOR_PERIOD]	= 1,
+		.v[RP_MIN_RATE]				= 1,
+		.v[RP_GD]				= 11,
+		.v[RP_MIN_DEC_FAC]			= 50,
+		.v[RP_CLAMP_TGT_RATE_ATI]		= 1,
+		.v[RP_THRESHOLD]			= 1,
+		.v[RP_TIME_RESET]			= 1,
+		.v[RP_QP_RATE]				= 100000,
+		.v[RP_BYTE_RESET]			= 431068,
+		.v[RP_AI_RATE]				= 160,
+		.v[RP_HAI_RATE]				= 300,
+	},
+};
+
+#define DCQCN_INT_ATTR(_min, _max, _name) \
+	{ .min = (_min), .max = (_max), .name = (_name) }
+
+#define DCQCN_BOOL_ATTR(_name) \
+	DCQCN_INT_ATTR(0, 1, _name)
+
+static const struct ionic_dcqcn_param_attr dcqcn_attrs[] = {
+	/* under "roce_np" */
+	DCQCN_INT_ATTR(0, 7, "icnp_802p_prio"),
+	DCQCN_INT_ATTR(0, 63, "cnp_dscp"),
+	/* under "roce_rp" */
+	DCQCN_INT_ATTR(100, 200000000, "token_bucket_size"),
+	DCQCN_INT_ATTR(0, 1023, "initial_alpha_value"),
+	DCQCN_INT_ATTR(0, 1023, "dce_tcp_g"),
+	DCQCN_INT_ATTR(1, 131071, "dce_tcp_rtt"),
+	DCQCN_INT_ATTR(1, INT_MAX, "rate_reduce_monitor_period"),
+	DCQCN_INT_ATTR(1, INT_MAX, "rate_to_set_on_first_cnp"),
+	DCQCN_INT_ATTR(1, INT_MAX, "min_rate"),
+	DCQCN_INT_ATTR(1, 11, "gd"),
+	DCQCN_INT_ATTR(0, 100, "min_dec_fac"),
+	DCQCN_BOOL_ATTR("clamp_tgt_rate"),
+	DCQCN_BOOL_ATTR("clamp_tgt_rate_ati"),
+	DCQCN_INT_ATTR(1, 31, "threshold"),
+	DCQCN_INT_ATTR(1, 32767, "time_reset"),
+	DCQCN_INT_ATTR(1, INT_MAX, "qp_rate"),
+	DCQCN_INT_ATTR(1, INT_MAX, "byte_reset"),
+	DCQCN_INT_ATTR(1, INT_MAX, "ai_rate"),
+	DCQCN_INT_ATTR(1, INT_MAX, "hai_rate"),
+};
+
+static void dcqcn_set_profile(struct ionic_profile *profile)
+{
+	struct ionic_ibdev *dev = profile->dev;
+	struct ionic_admin_wr wr = {
+		.work = COMPLETION_INITIALIZER_ONSTACK(wr.work),
+		.wqe = {
+			.op = IONIC_V1_ADMIN_MODIFY_DCQCN,
+			.len = cpu_to_le16(IONIC_ADMIN_MODIFY_DCQCN_IN_V1_LEN),
+			.cmd.mod_dcqcn = {
+				.id_ver = cpu_to_le32(profile->idx + 1),
+			}
+		}
+	};
+	int rc;
+
+	wr.wqe.cmd.mod_dcqcn.np_incp_802p_prio =
+		profile->vals.v[NP_ICNP_802P_PRIO];
+
+	wr.wqe.cmd.mod_dcqcn.np_cnp_dscp =
+		profile->vals.v[NP_CNP_DSCP];
+
+	wr.wqe.cmd.mod_dcqcn.rp_token_bucket_size =
+		cpu_to_be64(profile->vals.v[RP_TOKEN_BUCKET_SIZE]);
+
+	wr.wqe.cmd.mod_dcqcn.rp_initial_alpha_value =
+		cpu_to_be16(profile->vals.v[RP_INITIAL_ALPHA_VALUE]);
+
+	wr.wqe.cmd.mod_dcqcn.rp_dce_tcp_g =
+		cpu_to_be16(profile->vals.v[RP_DCE_TCP_G]);
+
+	wr.wqe.cmd.mod_dcqcn.rp_dce_tcp_rtt =
+		cpu_to_be32(profile->vals.v[RP_DCE_TCP_RTT]);
+
+	wr.wqe.cmd.mod_dcqcn.rp_rate_reduce_monitor_period =
+		cpu_to_be32(profile->vals.v[RP_RATE_REDUCE_MONITOR_PERIOD]);
+
+	wr.wqe.cmd.mod_dcqcn.rp_rate_to_set_on_first_cnp =
+		cpu_to_be32(profile->vals.v[RP_RATE_TO_SET_ON_FIRST_CNP]);
+
+	wr.wqe.cmd.mod_dcqcn.rp_min_rate =
+		cpu_to_be32(profile->vals.v[RP_MIN_RATE]);
+
+	wr.wqe.cmd.mod_dcqcn.rp_gd =
+		profile->vals.v[RP_GD];
+
+	wr.wqe.cmd.mod_dcqcn.rp_min_dec_fac =
+		profile->vals.v[RP_MIN_DEC_FAC];
+
+	if (profile->vals.v[RP_CLAMP_TGT_RATE])
+		wr.wqe.cmd.mod_dcqcn.rp_clamp_flags |= IONIC_RPF_CLAMP_TGT_RATE;
+
+	if (profile->vals.v[RP_CLAMP_TGT_RATE_ATI])
+		wr.wqe.cmd.mod_dcqcn.rp_clamp_flags |=
+			IONIC_RPF_CLAMP_TGT_RATE_ATI;
+
+	wr.wqe.cmd.mod_dcqcn.rp_threshold =
+		profile->vals.v[RP_THRESHOLD];
+
+	wr.wqe.cmd.mod_dcqcn.rp_time_reset =
+		cpu_to_be32(profile->vals.v[RP_TIME_RESET]);
+
+	wr.wqe.cmd.mod_dcqcn.rp_qp_rate =
+		cpu_to_be32(profile->vals.v[RP_QP_RATE]);
+
+	wr.wqe.cmd.mod_dcqcn.rp_byte_reset =
+		cpu_to_be32(profile->vals.v[RP_BYTE_RESET]);
+
+	wr.wqe.cmd.mod_dcqcn.rp_ai_rate =
+		cpu_to_be32(profile->vals.v[RP_AI_RATE]);
+
+	wr.wqe.cmd.mod_dcqcn.rp_hai_rate =
+		cpu_to_be32(profile->vals.v[RP_HAI_RATE]);
+
+	ionic_admin_post(dev, &wr);
+	rc = ionic_admin_wait(dev, &wr, IONIC_ADMIN_F_INTERRUPT);
+	if (rc)
+		ibdev_warn(&dev->ibdev, "dcqcn profile %d not set, error %d\n",
+			   profile->idx + 1, rc);
+}
+
+static int dcqcn_param_show(struct seq_file *s, void *v)
+{
+	struct ionic_dcqcn_param_entry *entry = s->private;
+	struct ionic_profile *profile = entry->profile;
+	int val = profile->vals.v[entry->var];
+
+	seq_printf(s, "%d\n", val);
+	return 0;
+}
+
+static ssize_t dcqcn_param_write(struct file *fp, const char __user *ubuf,
+				 size_t count, loff_t *ppos)
+{
+	struct seq_file *s = fp->private_data;
+	struct ionic_dcqcn_param_entry *entry;
+	struct ionic_profile *profile;
+	int rc, val;
+	char *buf;
+
+	entry = s->private;
+	profile = entry->profile;
+
+	buf = memdup_user_nul(ubuf, count);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	rc = kstrtoint(buf, 0, &val);
+	if (rc < 0)
+		goto out;
+
+	if (val < dcqcn_attrs[entry->var].min ||
+	    val > dcqcn_attrs[entry->var].max) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	profile->vals.v[entry->var] = val;
+
+	dcqcn_set_profile(profile);
+out:
+	kfree(buf);
+	return rc ?: count;
+}
+DEFINE_SHOW_STORE_ATTRIBUTE(dcqcn_param);
+
+static const struct ionic_profile_vals *dcqcn_get_defaults(int prof_i)
+{
+	if (prof_i < 0 || prof_i >= ARRAY_SIZE(dcqcn_defaults))
+		return &dcqcn_defaults[0];
+
+	return &dcqcn_defaults[prof_i];
+}
+
+static int dcqcn_match_default_show(struct seq_file *s, void *v)
+{
+	struct ionic_profile_root *profile_root = s->private;
+	int val = profile_root->profiles_default;
+
+	seq_printf(s, "%d\n", val);
+	return 0;
+}
+
+static ssize_t dcqcn_match_default_write(struct file *fp, const char __user *ubuf,
+					 size_t count, loff_t *ppos)
+{
+	struct ionic_profile_root *profile_root;
+	struct seq_file *s = fp->private_data;
+	int rc, val;
+	char *buf;
+
+	profile_root = s->private;
+
+	buf = memdup_user_nul(ubuf, count);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	rc = kstrtoint(buf, 0, &val);
+	if (rc < 0)
+		goto out;
+
+	if (val < 0 || val > profile_root->profiles_count) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	profile_root->profiles_default = val;
+
+out:
+	kfree(buf);
+	return rc ?: count;
+}
+DEFINE_SHOW_STORE_ATTRIBUTE(dcqcn_match_default);
+
+static int dcqcn_match_rules_show(struct seq_file *s, void *v)
+{
+	struct ionic_profile_root *profile_root = s->private;
+	struct ionic_match_rule *rule, *rules;
+	unsigned long irqflags;
+	int i, rules_count;
+
+	spin_lock_irqsave(&profile_root->rules_lock, irqflags);
+
+	rules = profile_root->rules;
+	rules_count = profile_root->rules_count;
+	for (i = 0; i < rules_count; ++i) {
+		rule = &rules[i];
+		seq_printf(s, "%s %d %d\n", rule->name, rule->cond, rule->prof);
+	}
+
+	spin_unlock_irqrestore(&profile_root->rules_lock, irqflags);
+
+	return 0;
+}
+
+static bool ionic_match_prio(struct rdma_ah_attr *attr, int cond)
+{
+	int prio = attr->sl;
+
+	return prio >= 0 && prio < 8 && (cond & BIT(prio));
+}
+
+static bool ionic_match_gid(struct rdma_ah_attr *attr, int cond)
+{
+	int gid = rdma_ah_read_grh(attr)->sgid_index;
+
+	return gid == cond;
+}
+
+static bool ionic_parse_rule_name(const char *name, const char *buf, int count)
+{
+	return !strncmp(name, buf, count) && !name[count];
+}
+
+static int ionic_parse_match_rules(const char *buf, size_t count,
+				   int prof_count, int rules_count,
+				   struct ionic_match_rule *rules)
+{
+	bool (*match)(struct rdma_ah_attr *attr, int cond);
+	struct ionic_match_rule *rule;
+	int cmd, cond, prof, end;
+	int rc, rule_i = 0;
+	const char *name;
+
+	for (;; ++rule_i) {
+		/* skip leading whitespace */
+
+		rc = sscanf(buf, " %n", &end);
+		if (rc != 0)
+			return -EINVAL;
+
+		buf += end;
+		count -= end;
+
+		/* break at end of buffer */
+
+		if (!count)
+			break;
+
+		/* Parse one rule, as:
+		 * <name> <condition> <profile>
+		 *
+		 * Name and condition determine when a rule will be a match.
+		 * If a rule is a match, then use the inidcated DCQCN profile.
+		 *
+		 * If name eq "gid":
+		 * then condition is a gid index.
+		 *
+		 * eg: gid 5 3 -> for gid index 5, use profile 3.
+		 *
+		 * If name eq "prio":
+		 * then condition is a bitmask of 802.1p priorities.
+		 *
+		 * eg: prio 0xc 1 -> for 802.1p priority 2 or 3, use profile 1.
+		 */
+
+		rc = sscanf(buf, "%*s%n%i%i%n", &cmd, &cond, &prof, &end);
+		if (rc != 2)
+			return -EINVAL;
+
+		/* rule name in first `cmd` chars of `buf` */
+
+		if (ionic_parse_rule_name("gid", buf, cmd)) {
+			match = ionic_match_gid;
+			name = "gid";
+		} else if (ionic_parse_rule_name("prio", buf, cmd)) {
+			match = ionic_match_prio;
+			name = "prio";
+		} else {
+			return -EINVAL;
+		}
+
+		if (prof < 0 || prof > prof_count)
+			return -EINVAL;
+
+		if (rule_i < rules_count) {
+			rule = &rules[rule_i];
+			rule->match = match;
+			rule->name = name;
+			rule->cond = cond;
+			rule->prof = prof;
+		}
+
+		buf += end;
+		count -= end;
+	}
+
+	return rule_i;
+}
+
+static ssize_t dcqcn_match_rules_write(struct file *fp,
+				       const char __user *ubuf,
+				       size_t count, loff_t *ppos)
+{
+	struct ionic_profile_root *profile_root;
+	struct seq_file *s = fp->private_data;
+	unsigned long irqflags;
+	int rc, rules_count;
+	char *buf;
+
+	profile_root = s->private;
+
+	buf = memdup_user_nul(ubuf, count);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	/* validate and count rules */
+	rc = ionic_parse_match_rules(buf, count, profile_root->profiles_count,
+				     0, NULL);
+	if (rc < 0)
+		goto out;
+
+	rules_count = rc;
+	rc = 0;
+
+	/* clear previous rules */
+	spin_lock_irqsave(&profile_root->rules_lock, irqflags);
+	profile_root->rules_count = 0;
+	spin_unlock_irqrestore(&profile_root->rules_lock, irqflags);
+
+	kfree(profile_root->rules);
+	profile_root->rules = NULL;
+
+	/* assign new rules */
+	if (rules_count) {
+		profile_root->rules = kzalloc_objs(*profile_root->rules,
+						   rules_count);
+		if (!profile_root->rules) {
+			rc = -ENOMEM;
+			goto out;
+		}
+
+		ionic_parse_match_rules(buf, count, profile_root->profiles_count,
+					rules_count, profile_root->rules);
+
+		spin_lock_irqsave(&profile_root->rules_lock, irqflags);
+		profile_root->rules_count = rules_count;
+		spin_unlock_irqrestore(&profile_root->rules_lock, irqflags);
+	}
+out:
+	kfree(buf);
+	return rc ?: count;
+}
+DEFINE_SHOW_STORE_ATTRIBUTE(dcqcn_match_rules);
+
+static ssize_t dcqcn_profile_reset(struct file *fp, const char __user *ubuf,
+				   size_t count, loff_t *ppos)
+{
+	struct ionic_profile *profile = fp->private_data;
+	int rc = 0;
+	char *buf;
+
+	buf = memdup_user_nul(ubuf, 2);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	if (strcmp(buf, "1") && strcmp(buf, "1\n")) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	profile->vals = *dcqcn_get_defaults(profile->idx);
+	dcqcn_set_profile(profile);
+
+out:
+	kfree(buf);
+	return rc ?: count;
+}
+
+static const struct file_operations dcqcn_profile_reset_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.write = dcqcn_profile_reset,
+};
+
+static void ionic_dcqcn_add_profile_params(struct ionic_profile *profile)
+{
+	struct ionic_dcqcn_param_entry *entry;
+	struct dentry *dentry;
+	int i;
+
+	for (i = 0; i < DCQCN_VAR_COUNT; i++) {
+		entry = &profile->entries[i];
+
+		entry->profile = profile;
+		entry->var = i;
+
+		if (i <= NP_CNP_DSCP)
+			dentry = profile->roce_np_debug;
+		else
+			dentry = profile->roce_rp_debug;
+
+		debugfs_create_file(dcqcn_attrs[i].name, 0640, dentry, entry,
+				    &dcqcn_param_fops);
+	}
+}
+
+int ionic_dcqcn_init(struct ionic_ibdev *dev, int prof_count)
+{
+	const enum ionic_profile_type type = IONIC_PROFILE_TYPE_DCQCN;
+	struct ionic_profile_root *profile_root;
+	int rc, i;
+
+	if (!prof_count)
+		return 0;
+
+	dev->profile[type] = kzalloc_obj(*dev->profile[type]);
+	if (!dev->profile[type]) {
+		rc = -ENOMEM;
+		goto err_cb_alloc;
+	}
+
+	profile_root = dev->profile[type];
+	profile_root->dev = dev;
+
+	spin_lock_init(&profile_root->rules_lock);
+
+	profile_root->debug = debugfs_create_dir("dcqcn", dev->debug);
+	if (IS_ERR(profile_root->debug)) {
+		profile_root->debug = NULL;
+		goto err_cb_dentry;
+	}
+
+	debugfs_create_file("match_default", 0640, profile_root->debug,
+			    profile_root, &dcqcn_match_default_fops);
+	debugfs_create_file("match_rules", 0640, profile_root->debug,
+			    profile_root, &dcqcn_match_rules_fops);
+
+	profile_root->profiles_debug = debugfs_create_dir("profiles",
+							  profile_root->debug);
+	if (IS_ERR(profile_root->profiles_debug)) {
+		profile_root->profiles_debug = NULL;
+		goto err_prof_dentry;
+	}
+
+	profile_root->profiles = kzalloc_objs(*profile_root->profiles,
+					      prof_count);
+	if (!profile_root->profiles) {
+		rc = -ENOMEM;
+		goto err_prof_alloc;
+	}
+
+	profile_root->profiles_default = 0;
+
+	for (i = 0; i < prof_count; ++i) {
+		struct ionic_profile *profile = &profile_root->profiles[i];
+		char name[8];
+
+		profile->dev = dev;
+		profile->vals = *dcqcn_get_defaults(i);
+		profile->idx = i;
+
+		dcqcn_set_profile(profile);
+
+		snprintf(name, sizeof(name), "%d", i + 1);
+		profile->debug = debugfs_create_dir(name,
+						 profile_root->profiles_debug);
+		if (IS_ERR(profile->debug)) {
+			profile->debug = NULL;
+			break;
+		}
+
+		debugfs_create_file("reset", 0640, profile->debug, profile,
+				    &dcqcn_profile_reset_fops);
+
+		profile->entries = kzalloc_objs(*profile->entries,
+						DCQCN_VAR_COUNT);
+
+		profile->roce_np_debug = debugfs_create_dir("roce_np",
+							    profile->debug);
+		if (IS_ERR(profile->roce_np_debug)) {
+			profile->roce_np_debug = NULL;
+			break;
+		}
+
+		profile->roce_rp_debug = debugfs_create_dir("roce_rp",
+							    profile->debug);
+		if (IS_ERR(profile->roce_rp_debug)) {
+			profile->roce_rp_debug = NULL;
+			break;
+		}
+
+		ionic_dcqcn_add_profile_params(profile);
+	}
+
+	if (!i)
+		goto err_prof_init;
+
+	profile_root->profiles_count = i;
+	if (i != prof_count) {
+		ibdev_warn(&dev->ibdev,
+			   "dcqcn initialized %d out of %d profiles\n",
+			   i, prof_count);
+	}
+	return 0;
+
+err_prof_init:
+	kfree(profile_root->profiles);
+err_prof_alloc:
+	debugfs_remove_recursive(profile_root->profiles_debug);
+err_prof_dentry:
+	debugfs_remove_recursive(profile_root->debug);
+err_cb_dentry:
+	kfree(dev->profile[type]);
+	dev->profile[type] = NULL;
+err_cb_alloc:
+	ibdev_warn(&dev->ibdev, "dcqcn failed init, error %d\n", rc);
+	return rc;
+}
+
+void ionic_dcqcn_destroy(struct ionic_ibdev *dev)
+{
+	struct ionic_profile_root *profile_root;
+	int i, prof_count;
+
+	profile_root = dev->profile[IONIC_PROFILE_TYPE_DCQCN];
+
+	if (!profile_root)
+		return;
+	prof_count = profile_root->profiles_count;
+	for (i = 0; i < prof_count; ++i) {
+		struct ionic_profile *profile;
+
+		profile = &profile_root->profiles[i];
+
+		kfree(profile->entries);
+		debugfs_remove_recursive(profile->debug);
+	}
+
+	debugfs_remove_recursive(profile_root->profiles_debug);
+	kfree(profile_root->rules);
+	kfree(profile_root->profiles);
+
+	debugfs_remove_recursive(profile_root->debug);
+
+	kfree(profile_root);
+	dev->profile[IONIC_PROFILE_TYPE_DCQCN] = NULL;
+}
+
+int ionic_dcqcn_select_profile(struct ionic_ibdev *dev,
+			       struct rdma_ah_attr *attr)
+{
+	struct ionic_profile_root *profile_root;
+	struct ionic_match_rule *rule, *rules;
+	int i, rules_count, prof;
+	unsigned long irqflags;
+
+	if (!dev->profile[IONIC_PROFILE_TYPE_DCQCN])
+		return 0;
+
+	profile_root = dev->profile[IONIC_PROFILE_TYPE_DCQCN];
+
+	spin_lock_irqsave(&profile_root->rules_lock, irqflags);
+
+	prof = profile_root->profiles_default;
+	rules = profile_root->rules;
+	rules_count = profile_root->rules_count;
+
+	for (i = 0; i < rules_count; ++i) {
+		rule = &rules[i];
+		if (rule->match(attr, rule->cond)) {
+			prof = rule->prof;
+			break;
+		}
+	}
+
+	spin_unlock_irqrestore(&profile_root->rules_lock, irqflags);
+
+	return prof;
+}
diff --git a/drivers/infiniband/hw/ionic/ionic_fw.h b/drivers/infiniband/hw/ionic/ionic_fw.h
index 0806c148faf2..eb463afe2305 100644
--- a/drivers/infiniband/hw/ionic/ionic_fw.h
+++ b/drivers/infiniband/hw/ionic/ionic_fw.h
@@ -838,6 +838,36 @@ struct ionic_admin_query_qp {
 static_assert(sizeof(struct ionic_admin_query_qp) ==
 	       IONIC_ADMIN_QUERY_QP_IN_V1_LEN);
 
+enum ionic_v1_dcqcn_flags {
+	IONIC_RPF_CLAMP_TGT_RATE	= BIT(0),
+	IONIC_RPF_CLAMP_TGT_RATE_ATI	= BIT(1),
+};
+
+struct ionic_admin_mod_dcqcn {
+	__u8		np_incp_802p_prio;
+	__u8		np_cnp_dscp;
+	__be16		rp_dce_tcp_g;
+	__be32		rp_dce_tcp_rtt;
+	__be32		rp_rate_reduce_monitor_period;
+	__be32		rp_rate_to_set_on_first_cnp;
+	__be32		rp_min_rate;
+	__be16		rp_initial_alpha_value;
+	__u8		rp_gd;
+	__u8		rp_min_dec_fac;
+	__u8		rp_clamp_flags;
+	__u8		rp_threshold;
+	__be16		rp_time_reset;
+	__be32		rp_qp_rate;
+	__be32		rp_byte_reset;
+	__be32		rp_ai_rate;
+	__be32		rp_hai_rate;
+	__le32		id_ver;
+	__be64		rp_token_bucket_size;
+} __packed;
+
+#define IONIC_ADMIN_MODIFY_DCQCN_IN_V1_LEN 56
+static_assert(sizeof(struct ionic_admin_mod_dcqcn) == IONIC_ADMIN_MODIFY_DCQCN_IN_V1_LEN);
+
 #define ADMIN_WQE_STRIDE	64
 #define ADMIN_WQE_HDR_LEN	4
 
@@ -860,6 +890,7 @@ struct ionic_v1_admin_wqe {
 		struct ionic_admin_destroy_qp destroy_qp;
 		struct ionic_admin_mod_qp mod_qp;
 		struct ionic_admin_query_qp query_qp;
+		struct ionic_admin_mod_dcqcn mod_dcqcn;
 	} cmd;
 };
 
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.c b/drivers/infiniband/hw/ionic/ionic_ibdev.c
index 69e6164e0f1e..2d89a4139d5a 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.c
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.c
@@ -290,6 +290,8 @@ static void ionic_destroy_resids(struct ionic_ibdev *dev)
 static void ionic_destroy_ibdev(struct ionic_ibdev *dev)
 {
 	ionic_kill_rdma_admin(dev, false);
+
+	ionic_dcqcn_destroy(dev);
 	ib_unregister_device(&dev->ibdev);
 	ionic_stats_cleanup(dev);
 	ionic_destroy_rdma_admin(dev);
@@ -357,6 +359,8 @@ static struct ionic_ibdev *ionic_create_ibdev(struct ionic_aux_dev *ionic_adev)
 	if (rc)
 		goto err_register;
 
+	ionic_dcqcn_init(dev, dev->lif_cfg.dcqcn_profiles);
+
 	return dev;
 
 err_register:
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.h b/drivers/infiniband/hw/ionic/ionic_ibdev.h
index 300d17882db5..cf909b14395a 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.h
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.h
@@ -74,6 +74,11 @@ enum ionic_mmap_flag {
 	IONIC_MMAP_WC = BIT(0),
 };
 
+enum ionic_profile_type {
+	IONIC_PROFILE_TYPE_DCQCN,
+	IONIC_PROFILE_TYPE_MAX,
+};
+
 struct ionic_mmap_entry {
 	struct rdma_user_mmap_entry rdma_entry;
 	unsigned long size;
@@ -123,6 +128,7 @@ struct ionic_ibdev {
 	struct dentry		*debug_qp;
 
 	int			hw_stats_count;
+	struct ionic_profile_root	*profile[IONIC_PROFILE_TYPE_MAX];
 };
 
 struct ionic_eq {
@@ -543,4 +549,10 @@ void ionic_dbg_rm_mr(struct ionic_mr *mr);
 void ionic_dbg_add_qp(struct ionic_ibdev *dev, struct ionic_qp *qp);
 void ionic_dbg_rm_qp(struct ionic_qp *qp);
 
+/* ionic_dcqcn.c */
+int ionic_dcqcn_init(struct ionic_ibdev *dev, int prof_count);
+void ionic_dcqcn_destroy(struct ionic_ibdev *dev);
+int ionic_dcqcn_select_profile(struct ionic_ibdev *dev,
+			       struct rdma_ah_attr *attr);
+
 #endif /* _IONIC_IBDEV_H_ */
diff --git a/drivers/infiniband/hw/ionic/ionic_lif_cfg.c b/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
index 53e41b1b3e8d..71aaf8d83f9c 100644
--- a/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
+++ b/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
@@ -93,6 +93,7 @@ void ionic_fill_lif_cfg(struct ionic_lif *lif, struct ionic_lif_cfg *cfg)
 	    !!(lif->qtype_info[IONIC_QTYPE_RXQ].features & IONIC_QIDENT_F_EXPDB);
 
 	cfg->dbg_ctx = lif->dentry;
+	cfg->dcqcn_profiles = ident->rdma.dcqcn_profiles;
 }
 
 struct net_device *ionic_lif_netdev(struct ionic_lif *lif)
diff --git a/drivers/infiniband/hw/ionic/ionic_lif_cfg.h b/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
index 500925c429f6..1e005400a0fa 100644
--- a/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
+++ b/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
@@ -58,6 +58,8 @@ struct ionic_lif_cfg {
 	bool sq_expdb;
 	bool rq_expdb;
 	u8 expdb_mask;
+
+	u8 dcqcn_profiles;
 };
 
 void ionic_fill_lif_cfg(struct ionic_lif *lif, struct ionic_lif_cfg *cfg);
diff --git a/drivers/infiniband/hw/ionic/ionic_profiles.h b/drivers/infiniband/hw/ionic/ionic_profiles.h
new file mode 100644
index 000000000000..a6cdd5992460
--- /dev/null
+++ b/drivers/infiniband/hw/ionic/ionic_profiles.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2018-2026, Advanced Micro Devices, Inc. */
+
+#ifndef _IONIC_PROFILES_H_
+#define _IONIC_PROFILES_H_
+
+#include "ionic_ibdev.h"
+
+enum ionic_dcqcn_var {
+	/* notification point */
+	NP_ICNP_802P_PRIO,		/* 0..7 (prio) */
+	NP_CNP_DSCP,			/* 0..63 (dscp) */
+
+	RP_TOKEN_BUCKET_SIZE,		/* 100..200000000 (100kb - 200gb) */
+	/* reaction point alpha update */
+	RP_INITIAL_ALPHA_VALUE,		/* 0..1023 */
+	RP_DCE_TCP_G,			/* 0..1023 */
+	RP_DCE_TCP_RTT,			/* 1..131071 (us) */
+
+	/* reaction point rate decrease */
+	RP_RATE_REDUCE_MONITOR_PERIOD,	/* 1.. (us) */
+	RP_RATE_TO_SET_ON_FIRST_CNP,	/* 0 disable, 1.. (Mbps) */
+	RP_MIN_RATE,			/* 1.. (Mbps) */
+	RP_GD,				/* 1..11 */
+	RP_MIN_DEC_FAC,			/* 0..100 (%) */
+
+	/* reaction point rate increase */
+	RP_CLAMP_TGT_RATE,		/* 0..1 (bool) */
+	RP_CLAMP_TGT_RATE_ATI,		/* 0..1 (bool) */
+	RP_THRESHOLD,			/* 1..31 */
+	RP_TIME_RESET,			/* 1..32767 (x RP_DCE_TCP_RTT) */
+	RP_QP_RATE,			/* 1.. (Mbps) */
+	RP_BYTE_RESET,			/* 1..4294967296 (B) */
+	RP_AI_RATE,			/* 1.. (Mbps) */
+	RP_HAI_RATE,			/* 1.. (Mbps) */
+
+	DCQCN_VAR_COUNT
+};
+
+struct ionic_match_rule {
+	bool			(*match)(struct rdma_ah_attr *attr, int cond);
+	const char		*name;
+	int			cond;
+	int			prof;
+};
+
+struct ionic_profile_vals {
+	int			v[DCQCN_VAR_COUNT];
+};
+
+struct ionic_dcqcn_param_attr {
+	char			*name;
+	int			min;
+	int			max;
+};
+
+struct ionic_dcqcn_param_entry {
+	struct ionic_profile	*profile;
+	enum ionic_dcqcn_var	var;
+};
+
+struct ionic_profile {
+	struct ionic_ibdev		*dev;
+	struct ionic_profile_vals	vals;
+	struct ionic_dcqcn_param_entry	*entries;
+	int idx;
+
+	struct dentry			*debug;
+	struct dentry			*roce_np_debug;
+	struct dentry			*roce_rp_debug;
+};
+
+struct ionic_profile_root {
+	struct ionic_ibdev	*dev;
+	int			profiles_default;
+	int			profiles_count;
+	struct ionic_profile	*profiles;
+	spinlock_t		rules_lock;	/* lock to atomic update the rules */
+	int			rules_count;
+	struct ionic_match_rule	*rules;
+
+	struct dentry		*debug;
+	struct dentry		*profiles_debug;
+};
+
+#endif /* _IONIC_PROFILES_H_ */
-- 
2.17.1


