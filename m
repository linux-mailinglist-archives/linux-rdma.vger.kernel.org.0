Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7404D1B13
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Mar 2022 15:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241296AbiCHO5Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Mar 2022 09:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239658AbiCHO5X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Mar 2022 09:57:23 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A3D4D614
        for <linux-rdma@vger.kernel.org>; Tue,  8 Mar 2022 06:56:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvkZMQlw1++PCVkT42tBZ2l6eATdshvbKqQbneqLpq4gM8bjdzGsnPd9q8z7t8fGpU5mFgNttWFH9cKAeMwYtSAm0dAs4h6+nh3kgO2thvUFQSd+B27C9J+mVp/fwSR+yhJusxalKI32XWHnh0cKfWFTRoZfsO6OTRb5cA7jsr9os+XUBrBEaV5ddwOlJqjcCYOCicGo9X4fVLQ+9ZcgntpzRcwRWMr87VYMoJp3PZVSD9BRjGdb4DkivWEu2E2AWyfLTjcEgrCJ2gpq9SMeydpava412tiePX3UZSpafbYIjDHil7doIDI4EqlR6tF/Yj5kJAswR/oIkNdslQvAXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nn284xp7m9ce6QCG7ZMdmiNzU3gGzRZAPLxecvLADyk=;
 b=Ohq1hr6M8XBLGHlRuRO4pRacAECzI+09Xp6bkDGQXaYEEbwM7/3SBDLYGAawILkbRSH3iF6dtGEbokuUQ/5bkBqyugEBJSIbZUDv1rwHLhVCgOGah/clF9ioLyo4XI7P5RVbXXC70o9vPohEqFiJtV/o4nduGAzsL63ROJ29X1MqDJrciMpuMh1D7lPQu+zWfcEdPT+dnGRO2LxNEEMc6iEZJCzYR60l6z56Vy7CfgAStxIDsPialetnEw0xXR9EjYkGrWqFHgWko4LN56cde13dRj/n83syCiTIXZ07dLW26QsGQJ76PYHIuv8JvODaj79xnZDY6KT8FZS81fhbWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nn284xp7m9ce6QCG7ZMdmiNzU3gGzRZAPLxecvLADyk=;
 b=OWXF7DbAYuO2AuRD5zVWRwOMBTk5iIdrKDeOMiSYsbc3dA1apKYcQz6wKwz0Vuzcm3DGOvE8cCa7Bi0r83RTrgrMOKsylLjXLahYkA98q4HBq2+Oc7hoApwxq7eybIXOjBH+er3eObJPlKYiEp3aAtyWW1/gIrHCTgyn6IbvaDt94NQkd0VudDFBPUXX9FOFsn90l2gqvR++1T05tBLjDGxcskC6O7eRBGflfCmSHSzB74sIgC2cvyw3gfmO9oyE9ivNvgBXS6Gg0mb+gy6TjDtoFBJhSzgVB+TRS2iT9qNMU1hM+FSFGAI+5kfsyd3M0Q8cPU4CJNN7xvKYwhJvkw==
Received: from MW4PR04CA0123.namprd04.prod.outlook.com (2603:10b6:303:84::8)
 by BYAPR12MB3208.namprd12.prod.outlook.com (2603:10b6:a03:13b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Tue, 8 Mar
 2022 14:56:24 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::e6) by MW4PR04CA0123.outlook.office365.com
 (2603:10b6:303:84::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 8 Mar 2022 14:56:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 14:56:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 8 Mar
 2022 14:55:59 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 8 Mar 2022
 06:55:58 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 8 Mar 2022 06:55:55 -0800
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>, <sagi@grimberg.me>
CC:     <oren@nvidia.com>, <sergeygo@nvidia.com>, <israelr@nvidia.com>,
        <leonro@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v2 3/4] IB/iser: generalize map/unmap dma tasks
Date:   Tue, 8 Mar 2022 16:55:45 +0200
Message-ID: <20220308145546.8372-4-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20220308145546.8372-1-mgurtovoy@nvidia.com>
References: <20220308145546.8372-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07465071-ebc4-4b4e-44d9-08da0113d099
X-MS-TrafficTypeDiagnostic: BYAPR12MB3208:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB32087D8679507EE8F4676127DE099@BYAPR12MB3208.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W1PKbIcqlL5UeD53L08Cu3/C3UftkLxx5mYjJBiUOCr6ZoHhRh3146fpo/I83A98Wnbh1ouaP3lkl/kAQ+QB979BZBVJCFYUSyiIyovBj5K0AMfJbl4KZTUOjr6WpMdQkC4QF1noD+TrMXZ8tYjnr//XOU3Ly0WX5jp3CTAwP/voiXvWjN3FF/BVgoVCsT7OBWGdLuepYOAeVt0jPuuxsYeDm4w8m8h5fDgBdswEgivFgQ4zHh+NzgDN/EQJa8KqtLL3GkY9dQFsFQO62+l5dKDYCjLVIorZg0vf5d/Pfb2W8gAktt9DDfn0GBwRgJH673s78oPtReAQL7Z+RJpV60Dryo85k9wlhJ6bACRiKwvwcxlZBorEEe9mGhfXrBcYnufwa16U0Jp2mMnh3NzWIwRSyqpjHmoViQtJq6IY5vclycH/SRcaNF2ll5llnDaj6ArAI9tAvYztvi9sXL7mW/sDyNaNXKXKdcYwRIjZMdLfeeX5s1R51WIGAjxv3qfVUSvt3Xl8wpsGjJM6OcnJ1h0nMPt88pu1oZU1W4iao/NkRcaFIenKImfZ02nLxu13hS3QcjzrJc0yuQcVqaT47D1xYU8BzMLndJyLiP9QZTyJtwBnppVfS89xurf7OFbjloPpsp/4WhaG2SD0uykglUttBO5TAO2YZ+u737itSOkLncbLVgp+kon8hA/WZQsanIyRvQ9eA49CnEANcSZiZQ==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36860700001)(54906003)(26005)(47076005)(2906002)(4326008)(86362001)(36756003)(6666004)(110136005)(316002)(508600001)(356005)(2616005)(107886003)(426003)(81166007)(336012)(1076003)(186003)(82310400004)(8676002)(70206006)(70586007)(8936002)(83380400001)(40460700003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 14:56:24.0964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07465071-ebc4-4b4e-44d9-08da0113d099
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3208
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 01708df8cb0c..7046e7ca9523 100644
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

