Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D51E4B6A3E
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 12:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbiBOLHL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 06:07:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236902AbiBOLHL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 06:07:11 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2041.outbound.protection.outlook.com [40.107.212.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05624107D07
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 03:07:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gExo+/Flu41jjytnBMZXRDooTHhVCAvnZ8HHVWzWIU+pV06X7XUtWaOdBJ0NQea67NJv8HIFaN1R/ajv7kr+uY/FS6UAFJy63ZObZYmUSPFGABjjPK5oex1oJfoZC4s6pFZg9FLG0BrkkMlZtYxEYIzPXtob1SCjNP7Kxe0kA4Lis2zFwMPPnKV7aEfdNsolvoiRRwf91u9CnhhDzQ04gHkmA6S4Unq4ullgUsPlTN6QuPboaGJ5nGUrc6nMyF07fepvL8dujxNnTk6A+nrNuL3XQ9FO6V+G00PpDudYB1PdgfeXq99N/C04p+Cjtw5U3WN8hC1w4gsiD3p+H6t+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6MXGAkqK5Lu9ogoxw+dMSzAxKAJZZ/y1P/WR5epKnI=;
 b=ahnj2iZ31UySGe1GlBGorw6S2N71shYDiza5qipCDDJNPRkYDCpzJYZS+ztGgec4+EjJ7he5cJgsXuFZUDVEEDP49HgBoRJpGLBW/Lr2s4p627RcnglVRJEBPfY7GGapH/J1DFQa2RhHA4mZfTr2E5KfPuuygOfbLpczcmvg21vAOUHXOHIvgkA+hz+HFFHu/bG96xJFDYTVqdfEltq7H2i721hMrJQokAoM9jSny+2WpALkDnRGxrLBQc5ARjUDtKF8yLngvd7RlVBBbRZO++z7uvQetz1pDkOOJVT2Q2CM01ff+nNj0YPYaz+yppdbEPggQsCq0+AEp0kaxsY0jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6MXGAkqK5Lu9ogoxw+dMSzAxKAJZZ/y1P/WR5epKnI=;
 b=ZcgJ1I3TwnQGhZTfK06OVRR6dSmApiKWSVXhUPUSiCCX8SQkn1hFqzjPzwEDida4SRt6FYxflzSBcVgEg1Qdw1Ktk7GWw/MI02Y7cIlyW5CHDA/FDQ8TBtHZVjaKEQMhbnPULNEM18fR+ojZv0hOvKBsAyZcGaMk0N+3ghoDFssz5DeqMyD7jyaG/vqPgboq9coAsxi8gCkaswfrLI4J5pkYNcLX6ellykm4TNa+qJtn+Am2/OmgSDizH/h2PgyXQzdgupEQN+UqBi3L63sKreOzsdBbnUNZIizrGQUDhRfOdr0O+ZRHtXSi2IcrZf9zFmNqlxzMR5eV3xvmueBAAg==
Received: from BN9PR03CA0894.namprd03.prod.outlook.com (2603:10b6:408:13c::29)
 by BYAPR12MB3349.namprd12.prod.outlook.com (2603:10b6:a03:ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 11:06:57 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::3c) by BN9PR03CA0894.outlook.office365.com
 (2603:10b6:408:13c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18 via Frontend
 Transport; Tue, 15 Feb 2022 11:06:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 11:06:56 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 15 Feb
 2022 11:06:41 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 15 Feb 2022
 03:06:40 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 15 Feb 2022 03:06:39 -0800
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>, <sagi@grimberg.me>
CC:     <oren@nvidia.com>, <sergeygo@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 3/4] IB/iser: generalize map/unmap dma tasks
Date:   Tue, 15 Feb 2022 13:06:31 +0200
Message-ID: <20220215110632.10697-4-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20220215110632.10697-1-mgurtovoy@nvidia.com>
References: <20220215110632.10697-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08e6b944-35eb-4659-7be8-08d9f073480b
X-MS-TrafficTypeDiagnostic: BYAPR12MB3349:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB334920E86750135C1D940EF3DE349@BYAPR12MB3349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v7pabkQahIgnO5JCMWXi0xjEFVyw1oayDG0u6Gw+mKnmmaQWdnarF2g2l0Lv2Npscwk+eydboh8LnPWbkJKsLmyEg/Sp1X3TdjnUoKn6TqacQKw6S4uhEBrXPZAOfXxqwlF5ueq8CQTb9BdYQviyhGKG6mqaKSrRlQ9F1uR1zm2lxszCg+iOhFVQl6zgjYaSAYmTwecYJCZ1Sb7OyL5TJU9WrK5wAl1n0Spa3rtk/G/AJjSN1WDrjI17f4kebtHE5WH5IkPuSQikVld8sGwlRoCSWJa2Uh1HSPNaMqOuCJ7mNO1sNev4PGiPVFduZqoPMiSmTC3AwBR44ISD6UElCQX89+Kbyj7EknApuAEwnMZ88weVGbYsUV4l0gco/gCvOwYsHUAf0vgifaRKr3q3tFby21sUxsxe1dlEu0djEear2s8O5IRLUeRJt0+HbUXc82LObHDtti7+Qa3KwTU9tywidDAwZliHT+UNH+xUL4XJnsP7CSRHzg7HfepZTCf2YMClrfFAXgTlm8lNRLKtOMqJUsskhKNJytl1wbe111L6sxR8jxTVHPqJ1Xtk00xxSnx/L5dUjbDczEVIWJPnubjl/RSZ6Xd4/IM+cHzs+FkEJjhcvpzV4b1dQf338HCs4EqcOX9ARZR2ScJTTz4jCDmz6q9ESuvqeUvLsSBQuoy3FGQw4x0bX7dfDgPZWTITCSgAUrV8oLszJloFiBBEIg==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(316002)(54906003)(70586007)(4326008)(186003)(508600001)(426003)(110136005)(336012)(36756003)(8676002)(70206006)(107886003)(1076003)(5660300002)(2906002)(86362001)(2616005)(83380400001)(40460700003)(26005)(47076005)(356005)(36860700001)(81166007)(6666004)(8936002)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 11:06:56.8534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e6b944-35eb-4659-7be8-08d9f073480b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3349
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Avoid code duplication and add the mapping/unmapping of the protection
buffers to the iser_dma_map_task_data/iser_dma_unmap_task_data
functions.

Reviewed-by: Sergey Gorenko <sergeygo@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/infiniband/ulp/iser/iscsi_iser.h     |  5 +--
 drivers/infiniband/ulp/iser/iser_initiator.c | 40 +-------------------
 drivers/infiniband/ulp/iser/iser_memory.c    | 31 +++++++++++++--
 3 files changed, 31 insertions(+), 45 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.h b/drivers/infiniband/ulp/iser/iscsi_iser.h
index 23b922233006..7e4faf9c5e9e 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.h
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.h
@@ -531,13 +531,12 @@ int  iser_post_recvm(struct iser_conn *iser_conn,
 int  iser_post_send(struct ib_conn *ib_conn, struct iser_tx_desc *tx_desc);
 
 int iser_dma_map_task_data(struct iscsi_iser_task *iser_task,
-			   struct iser_data_buf *data,
 			   enum iser_data_dir iser_dir,
 			   enum dma_data_direction dma_dir);
 
 void iser_dma_unmap_task_data(struct iscsi_iser_task *iser_task,
-			      struct iser_data_buf *data,
-			      enum dma_data_direction dir);
+			      enum iser_data_dir iser_dir,
+			      enum dma_data_direction dma_dir);
 
 int  iser_initialize_task_headers(struct iscsi_task *task,
 			struct iser_tx_desc *tx_desc);
diff --git a/drivers/infiniband/ulp/iser/iser_initiator.c b/drivers/infiniband/ulp/iser/iser_initiator.c
index 012decf6905a..dbc2c268bc0e 100644
--- a/drivers/infiniband/ulp/iser/iser_initiator.c
+++ b/drivers/infiniband/ulp/iser/iser_initiator.c
@@ -52,26 +52,13 @@ static int iser_prepare_read_cmd(struct iscsi_task *task)
 	struct iser_mem_reg *mem_reg;
 	int err;
 	struct iser_ctrl *hdr = &iser_task->desc.iser_header;
-	struct iser_data_buf *buf_in = &iser_task->data[ISER_DIR_IN];
 
 	err = iser_dma_map_task_data(iser_task,
-				     buf_in,
 				     ISER_DIR_IN,
 				     DMA_FROM_DEVICE);
 	if (err)
 		return err;
 
-	if (scsi_prot_sg_count(iser_task->sc)) {
-		struct iser_data_buf *pbuf_in = &iser_task->prot[ISER_DIR_IN];
-
-		err = iser_dma_map_task_data(iser_task,
-					     pbuf_in,
-					     ISER_DIR_IN,
-					     DMA_FROM_DEVICE);
-		if (err)
-			return err;
-	}
-
 	err = iser_reg_mem_fastreg(iser_task, ISER_DIR_IN, false);
 	if (err) {
 		iser_err("Failed to set up Data-IN RDMA\n");
@@ -106,23 +93,11 @@ static int iser_prepare_write_cmd(struct iscsi_task *task, unsigned int imm_sz,
 	struct ib_sge *tx_dsg = &iser_task->desc.tx_sg[1];
 
 	err = iser_dma_map_task_data(iser_task,
-				     buf_out,
 				     ISER_DIR_OUT,
 				     DMA_TO_DEVICE);
 	if (err)
 		return err;
 
-	if (scsi_prot_sg_count(iser_task->sc)) {
-		struct iser_data_buf *pbuf_out = &iser_task->prot[ISER_DIR_OUT];
-
-		err = iser_dma_map_task_data(iser_task,
-					     pbuf_out,
-					     ISER_DIR_OUT,
-					     DMA_TO_DEVICE);
-		if (err)
-			return err;
-	}
-
 	err = iser_reg_mem_fastreg(iser_task, ISER_DIR_OUT,
 				   buf_out->data_len == imm_sz);
 	if (err != 0) {
@@ -740,27 +715,16 @@ void iser_task_rdma_init(struct iscsi_iser_task *iser_task)
 
 void iser_task_rdma_finalize(struct iscsi_iser_task *iser_task)
 {
-	int prot_count = scsi_prot_sg_count(iser_task->sc);
 
 	if (iser_task->dir[ISER_DIR_IN]) {
 		iser_unreg_mem_fastreg(iser_task, ISER_DIR_IN);
-		iser_dma_unmap_task_data(iser_task,
-					 &iser_task->data[ISER_DIR_IN],
+		iser_dma_unmap_task_data(iser_task, ISER_DIR_IN,
 					 DMA_FROM_DEVICE);
-		if (prot_count)
-			iser_dma_unmap_task_data(iser_task,
-						 &iser_task->prot[ISER_DIR_IN],
-						 DMA_FROM_DEVICE);
 	}
 
 	if (iser_task->dir[ISER_DIR_OUT]) {
 		iser_unreg_mem_fastreg(iser_task, ISER_DIR_OUT);
-		iser_dma_unmap_task_data(iser_task,
-					 &iser_task->data[ISER_DIR_OUT],
+		iser_dma_unmap_task_data(iser_task, ISER_DIR_OUT,
 					 DMA_TO_DEVICE);
-		if (prot_count)
-			iser_dma_unmap_task_data(iser_task,
-						 &iser_task->prot[ISER_DIR_OUT],
-						 DMA_TO_DEVICE);
 	}
 }
diff --git a/drivers/infiniband/ulp/iser/iser_memory.c b/drivers/infiniband/ulp/iser/iser_memory.c
index 72a117cd6fd7..d72384e029a0 100644
--- a/drivers/infiniband/ulp/iser/iser_memory.c
+++ b/drivers/infiniband/ulp/iser/iser_memory.c
@@ -71,10 +71,10 @@ static void iser_reg_desc_put_fr(struct ib_conn *ib_conn,
 }
 
 int iser_dma_map_task_data(struct iscsi_iser_task *iser_task,
-			   struct iser_data_buf *data,
 			   enum iser_data_dir iser_dir,
 			   enum dma_data_direction dma_dir)
 {
+	struct iser_data_buf *data = &iser_task->data[iser_dir];
 	struct ib_device *dev;
 
 	iser_task->dir[iser_dir] = 1;
@@ -85,17 +85,40 @@ int iser_dma_map_task_data(struct iscsi_iser_task *iser_task,
 		iser_err("dma_map_sg failed!!!\n");
 		return -EINVAL;
 	}
+
+	if (scsi_prot_sg_count(iser_task->sc)) {
+		struct iser_data_buf *pdata = &iser_task->prot[iser_dir];
+
+		pdata->dma_nents = ib_dma_map_sg(dev, pdata->sg, pdata->size, dma_dir);
+		if (unlikely(pdata->dma_nents == 0)) {
+			iser_err("protection dma_map_sg failed!!!\n");
+			goto out_unmap;
+		}
+	}
+
 	return 0;
+
+out_unmap:
+	ib_dma_unmap_sg(dev, data->sg, data->size, dma_dir);
+	return -EINVAL;
 }
 
+
 void iser_dma_unmap_task_data(struct iscsi_iser_task *iser_task,
-			      struct iser_data_buf *data,
-			      enum dma_data_direction dir)
+			      enum iser_data_dir iser_dir,
+			      enum dma_data_direction dma_dir)
 {
+	struct iser_data_buf *data = &iser_task->data[iser_dir];
 	struct ib_device *dev;
 
 	dev = iser_task->iser_conn->ib_conn.device->ib_device;
-	ib_dma_unmap_sg(dev, data->sg, data->size, dir);
+	ib_dma_unmap_sg(dev, data->sg, data->size, dma_dir);
+
+	if (scsi_prot_sg_count(iser_task->sc)) {
+		struct iser_data_buf *pdata = &iser_task->prot[iser_dir];
+
+		ib_dma_unmap_sg(dev, pdata->sg, pdata->size, dma_dir);
+	}
 }
 
 static int iser_reg_dma(struct iser_device *device, struct iser_data_buf *mem,
-- 
2.18.1

