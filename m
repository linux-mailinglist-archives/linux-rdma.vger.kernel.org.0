Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D35A4B6A38
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 12:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbiBOLGu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 06:06:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiBOLGt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 06:06:49 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D2F101F27
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 03:06:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ND8nSH80uP1ejL8K43pcDKN7AaOL9FXdPu7G0j9BGQ9vd8OXBV98jhbejA/5AXexKiFr1g56ZPPYTZkG5xCB146gcBIA4HTPyqklZ9WWm7Rf9OuNd2XQChjSTT6GsEvius8b+E5u3vgXmdF15Plx0nrEIDo9N1vHOpB/o5bX9YLieS3Lj+x495M+83XplSyJ7SHIKLBxaXXc2+1WIK4QM0gSfWE5M+qubFG1oNy2TYvfNDAeyMwKqktcz2OaRj7F/4kIgtbVnpZEdUaAfESGRLYRO9WmplCNFUpfnX6t76qRjmjv4YwogKDFET/ofq5AgkEWt/ILLidlD128xhZcFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RvA8KiVXWVQ4Z0oBGxre9hU+HzNDa0aBFkRA7lmr9o=;
 b=IQPk3+cJtYgQ68eUGo6ZxywBZh8unntwJnniCLuHoOhnhN6diBvlTmo4OG4YCthiAiXumZplYcwFJUXeLsOWCYkWquM3uhoh4HbUuhvjF7+3+DXAejsA+ZFYKGssq2wiFwzkk/txjXes+FpWRtBYCD86o6dNyGHB14aPRQh9JhYqgOAy27pqPxgVA1Jf/FRjFUrGx7KcoDXuySaKYyzaiBJYYsq8ZG2Mlx+tW4H4SBv2r81q3or7oP21dTQ68Ie4mS1dqEKKd9DVBprjdvqLzbH5Q8ZZQex2AoTpy1pDqZbHzjCxhZ6FX5ZSUPrqW5YCwwh9Hi4o99kkrT6MhX7RzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RvA8KiVXWVQ4Z0oBGxre9hU+HzNDa0aBFkRA7lmr9o=;
 b=iRsyqFH6+Rd1J3ehw131VEa6a+38Gdiaz2djsUVf4glSS0u3ck0fe1Xnec/VeobuDVRrAZ/gYBSs2JOqWgKkSr9UsKZjQz3a2OgMOBgsa4TSRzq2otnrsmu1BF1yt9dhc5VltJv+z5FSbyi/QsWL459TBjK5P/JT9+MWqkwLg0ZY33eS2r0+BA0e0JARBJHi8ZQCqgbDHyBbM2R/Laijl69rWju3HCpDA/wZMP2d1EJrCjBEXcG0lkLEaPJ65EKZtWy457h+WnUoSirXibSwrmXtqTVZ0+Y77A8mLDxEcJBrHl7C0/WhDDBTdXtYZX7vrCtWUD/dXi5SXWYpKio9Yg==
Received: from BN6PR21CA0004.namprd21.prod.outlook.com (2603:10b6:404:8e::14)
 by PH7PR12MB5904.namprd12.prod.outlook.com (2603:10b6:510:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Tue, 15 Feb
 2022 11:06:38 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:8e:cafe::83) by BN6PR21CA0004.outlook.office365.com
 (2603:10b6:404:8e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.5 via Frontend
 Transport; Tue, 15 Feb 2022 11:06:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 11:06:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 15 Feb
 2022 11:06:37 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 15 Feb 2022
 03:06:36 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 15 Feb 2022 03:06:34 -0800
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>, <sagi@grimberg.me>
CC:     <oren@nvidia.com>, <sergeygo@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/4] IB/iser: remove iser_reg_data_sg helper function
Date:   Tue, 15 Feb 2022 13:06:29 +0200
Message-ID: <20220215110632.10697-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20220215110632.10697-1-mgurtovoy@nvidia.com>
References: <20220215110632.10697-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fb32738-05c7-4567-e722-08d9f0733cdc
X-MS-TrafficTypeDiagnostic: PH7PR12MB5904:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5904ECC4D4EC45530626C860DE349@PH7PR12MB5904.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: veutgG8RLGqKkiq6rmbUfYYj2APYeoSvORTlLxAZvOseHKuC0sFtI4IFpKSHIOyxt4CKixvyon0FAIjQfmwAcHUZcaIufTajf1KobuErzf6S9hIqlKCTE7mr1YkXNwDVBGXab2mwxlSeJKsHRUabwdylMKwEB8p0PSNcdn27mDjd3vubOpxDFpknid9MVu/g84bljG+uBEvLBCSzISi5acakk9FWxIzjLPON/vsUzJzk1CakAcoDN6mMLD2QMfK41gsSe5yJKPJI+R9tsbrzhV1tPI5T1o8GUpblS1e1atA/WSTNcLqXk6CaRQtLQlH/geLxzYWbpDkssHk14Nr1gsySaDIV35dRo5q9HuVIRi918yd9iFKhZjhv8QmlL4aaDPIWYNj8bWZJ5GyipZwpjM4xzgLgwcQhksobW/qsgNPlNgGvgS1Mflx3mGIW4atWOpTOhP5oydGHnm22gXRL+BzrC2Af7OIx0vVERSk8COjmy6EwoTj874wQeaDOj9dCX5iLCbl75lEW2M46UzDL8aSUi6Xz8XzIfp7dterLFZsam6p7sLhnALtfV0Vra72HWfAC5no/2erL4ZD/34zfLBVM1ANawoXE0EtbTAKKLP1d2jP73dNjZrPuaO6mlt9w/7J5p3dFzzhwPdfCLNiAoNThhvmzi9ryNrDcyMvTe1geMEwtzEvJbN+2FzGFKJIfjxZ/jr+wo82H5yFdERVwdg==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2906002)(40460700003)(107886003)(83380400001)(5660300002)(426003)(356005)(82310400004)(81166007)(70586007)(70206006)(1076003)(186003)(508600001)(4326008)(336012)(8676002)(26005)(316002)(47076005)(36860700001)(2616005)(36756003)(8936002)(86362001)(110136005)(6666004)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 11:06:38.1088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb32738-05c7-4567-e722-08d9f0733cdc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5904
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/infiniband/ulp/iser/iser_memory.c | 32 ++++++++---------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iser_memory.c b/drivers/infiniband/ulp/iser/iser_memory.c
index 660982625488..2738ec56c918 100644
--- a/drivers/infiniband/ulp/iser/iser_memory.c
+++ b/drivers/infiniband/ulp/iser/iser_memory.c
@@ -327,40 +327,29 @@ static int iser_fast_reg_mr(struct iscsi_iser_task *iser_task,
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
+	desc = iser_reg_desc_get_fr(ib_conn);
+	if (unlikely(!desc))
+		return -ENOMEM;
 
 	if (scsi_get_prot_op(task->sc) == SCSI_PROT_NORMAL) {
-		err = iser_reg_data_sg(task, mem, desc, use_dma_key, reg);
+		err = iser_fast_reg_mr(task, mem, &desc->rsc, reg);
 		if (unlikely(err))
 			goto err_reg;
 	} else {
@@ -372,11 +361,12 @@ int iser_reg_mem_fastreg(struct iscsi_iser_task *task,
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

