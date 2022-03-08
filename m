Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2594E4D1B14
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Mar 2022 15:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245628AbiCHO51 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Mar 2022 09:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239658AbiCHO50 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Mar 2022 09:57:26 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4344D60E
        for <linux-rdma@vger.kernel.org>; Tue,  8 Mar 2022 06:56:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWHp+5ST62E8SZoXjDDKsbClQCx2t29KAKm/g6AFWJiab23+AbaXLVbdThy6qSb/+JRecZuQhFaCyMkBvNaytPaGa0kq+cS9/M9mHZSU5DAmnFUo30GxQ9ERO3fzAlFt98nPD1NsLJaYvLYBYvC1N8TYpi94N/gZbw9ZzlI7g8yWDRYbAm/1xgeYVSO0bYywePSVzW+YOhv3hkx8yA3csFXJfaY/utZXyi6MUXjzNYUv40esccgTiFZaJMhhRXAgIwElL+rmey6VcQdKMC+ctIvswQIPxDvgfinoFUAYdLnaaTVV4Pd1WDUautXPBb4mrJ60bZoi5RwweniIdiMcYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxKKAwrWnc7Vj2P/A0lTW0F0ko1hK+iijC+UYJyEv+w=;
 b=Xtt6Ua2DjcnrYFYBPYQMD19XCiwssy2o21gLr3NhqHvIF5GCQHBQVU1WddpcOAefKStf5a0600CXrp2LF2Za5z9bqVh0PAhAhy5KoCYHL2vnZJ+yrRW10Pji//7eXISXmLJq67P26vYxaeQJcUd/+mZGL8aRbx4D4v8wxX5vY0hT/X7zFq3E7/xbDhQBGDd2ULzfmScr429iKDyZ2BlwdPtfUKFEkV1bSzQJoyhTaDP1n5o4oAQBx82+suwJIlWuF8Unq6zmXxcte/qvnlj/alL7kQ/Cq8GrDhqbtdLMQZ/hrGCiZ2dzSPjciEfIHONFedLavwXoiWdu6yGYCK0QTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxKKAwrWnc7Vj2P/A0lTW0F0ko1hK+iijC+UYJyEv+w=;
 b=N/zWGRSC/cVLycZOTxZ4FsDOQ2N9LCObKk0daJ9Vc7cgOnNbKrdIRk4qJQVxt0OnULBe+TfNP621GhxvrELrxsVO70qg9ksmHFPj+J+sZ6fd+lIxKQai9Jj9pA63ypj2UP+UHUvWFEHYPZK3Q9VhRABt6BLTA3ly/dpiQbDKxd1+y/WKbPRSC78kHbsLm1UiUkKLVz0OH9Nc6RE8dF8X7RNCXaIGfO3CJtFmHttjjouMql67KdFwV/8ARKeE6LUv2BSga6sIy3RzN0FMpV4jBTeD7tznl0met2AtA3FKjH6h/vohfdtA5sCDIZWUW62Sm6CU0PbHLZOJ1OLUzDlW1g==
Received: from MW4PR04CA0122.namprd04.prod.outlook.com (2603:10b6:303:84::7)
 by MN2PR12MB2877.namprd12.prod.outlook.com (2603:10b6:208:ae::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Tue, 8 Mar
 2022 14:56:22 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::46) by MW4PR04CA0122.outlook.office365.com
 (2603:10b6:303:84::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 8 Mar 2022 14:56:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 14:56:21 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 8 Mar
 2022 14:55:53 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 8 Mar 2022
 06:55:52 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 8 Mar 2022 06:55:50 -0800
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>, <sagi@grimberg.me>
CC:     <oren@nvidia.com>, <sergeygo@nvidia.com>, <israelr@nvidia.com>,
        <leonro@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v2 1/4] IB/iser: remove iser_reg_data_sg helper function
Date:   Tue, 8 Mar 2022 16:55:43 +0200
Message-ID: <20220308145546.8372-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20220308145546.8372-1-mgurtovoy@nvidia.com>
References: <20220308145546.8372-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92a08140-571d-438e-8091-08da0113cf4b
X-MS-TrafficTypeDiagnostic: MN2PR12MB2877:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB2877B0DEA7842A5299F71F07DE099@MN2PR12MB2877.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VhweoNT2BqrOSsHxOr7qYfHal9fBRiI2SvmlDxdx0B4rR+QTMdweO7rPe7rOoivaJUJsr4iPG8jUXwnmZgRusk6ZpBp44ApfwGErtD1TPnB09f4vU4V2/BOQ+QfK59EHKjS/yF5bm4TQi2fEgCuciufXSu6R6ntT8xJmCXUOWPPM2kewfncRjrmALqf9tAuAYUe370t7/8dl686dfJ9w7uC/Qq9JXDjKbS7ZTJRLzXBrfnMowQorE7cwSzDuJ6oxNCnVYlR/r0KcU8GQUI0jLfNC3Og2UD/4Ew2U/88P77QeS1igEx/Utms2yc15j+qyeOw4sDn/0hhHXf9i+9fQZNx5xPF4BDgT3MuE3MwYXE1OytRECcIt9r+57Z0iqaanQ5LvuLWUOxZ6mBimP4A6iLSWnsDV2rBC1WaMlF9DfSghiToNA5Qr8Cn1e3oJHyIPo8wwtCwVMpuSviohSpso3uHyfyIwzC1zsBVnbwF9gP71NGjxDE9TdMK+cdOI6VOL4FzU6mAVXXVayivfdPAONe9/eOneiA3/wa0FN0dIoKBKkrX4vvMLi94wo8oiUyQ5EXebfu5bQvv3o/mBgG5P+JyPrF165GxLDGSPACmFotORJhfSqtAmUfRQhqcXXiXfx4DwzfoGSq4El395EmMN52VqMK938zcCvAujQY2FspHmP/tlLb5GaZOl/sCMMrrA9cdwX9n9qbjQYESl2x3oIA==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(4326008)(81166007)(8676002)(70206006)(70586007)(5660300002)(2906002)(356005)(36756003)(8936002)(82310400004)(54906003)(36860700001)(110136005)(316002)(186003)(40460700003)(508600001)(86362001)(107886003)(47076005)(6666004)(2616005)(426003)(1076003)(26005)(83380400001)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 14:56:21.8934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a08140-571d-438e-8091-08da0113cf4b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2877
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Open coding it makes the code more readable and simple.

Reviewed-by: Sergey Gorenko <sergeygo@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/infiniband/ulp/iser/iser_memory.c | 31 +++++++----------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iser_memory.c b/drivers/infiniband/ulp/iser/iser_memory.c
index 660982625488..4292c57856dd 100644
--- a/drivers/infiniband/ulp/iser/iser_memory.c
+++ b/drivers/infiniband/ulp/iser/iser_memory.c
@@ -327,40 +327,26 @@ static int iser_fast_reg_mr(struct iscsi_iser_task *iser_task,
 	return 0;
 }
 
-static int iser_reg_data_sg(struct iscsi_iser_task *task,
-			    struct iser_data_buf *mem,
-			    struct iser_fr_desc *desc, bool use_dma_key,
-			    struct iser_mem_reg *reg)
-{
-	struct iser_device *device = task->iser_conn->ib_conn.device;
-
-	if (use_dma_key)
-		return iser_reg_dma(device, mem, reg);
-
-	return iser_fast_reg_mr(task, mem, &desc->rsc, reg);
-}
-
 int iser_reg_mem_fastreg(struct iscsi_iser_task *task,
 			 enum iser_data_dir dir,
 			 bool all_imm)
 {
 	struct ib_conn *ib_conn = &task->iser_conn->ib_conn;
+	struct iser_device *device = ib_conn->device;
 	struct iser_data_buf *mem = &task->data[dir];
 	struct iser_mem_reg *reg = &task->rdma_reg[dir];
-	struct iser_fr_desc *desc = NULL;
+	struct iser_fr_desc *desc;
 	bool use_dma_key;
 	int err;
 
 	use_dma_key = mem->dma_nents == 1 && (all_imm || !iser_always_reg) &&
 		      scsi_get_prot_op(task->sc) == SCSI_PROT_NORMAL;
+	if (use_dma_key)
+		return iser_reg_dma(device, mem, reg);
 
-	if (!use_dma_key) {
-		desc = iser_reg_desc_get_fr(ib_conn);
-		reg->mem_h = desc;
-	}
-
+	desc = iser_reg_desc_get_fr(ib_conn);
 	if (scsi_get_prot_op(task->sc) == SCSI_PROT_NORMAL) {
-		err = iser_reg_data_sg(task, mem, desc, use_dma_key, reg);
+		err = iser_fast_reg_mr(task, mem, &desc->rsc, reg);
 		if (unlikely(err))
 			goto err_reg;
 	} else {
@@ -372,11 +358,12 @@ int iser_reg_mem_fastreg(struct iscsi_iser_task *task,
 		desc->sig_protected = true;
 	}
 
+	reg->mem_h = desc;
+
 	return 0;
 
 err_reg:
-	if (desc)
-		iser_reg_desc_put_fr(ib_conn, desc);
+	iser_reg_desc_put_fr(ib_conn, desc);
 
 	return err;
 }
-- 
2.18.1

