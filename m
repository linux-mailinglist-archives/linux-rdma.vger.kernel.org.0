Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA714D1B12
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Mar 2022 15:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344598AbiCHO5H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Mar 2022 09:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241296AbiCHO5G (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Mar 2022 09:57:06 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2071.outbound.protection.outlook.com [40.107.96.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E426C4D60E
        for <linux-rdma@vger.kernel.org>; Tue,  8 Mar 2022 06:56:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ut7H8esnVjgGTsd+/Hipe/xsP8b2km4frqqRZYX3Sb6XHpllGqvfIIKUXq9lDEXuTiMArBkdryLmZ8PwZHybbErswASw2LZntoVc0VYKW9TQod0XHEyoKKAl4cGK4VAQvYK5bHynPkqnLlBXfS1bpx2bojwH6yp+VFn5Due3N/ZKLxSqJXzikghzpBWcoVG7nBAW+iQqzx342BBU+kMmZIYuaYVgvAUGGy4EmabKxDsM8ctKaw9/fGYG4Zw0dxEl7ISa5N0PWXuMc7d3eYPqzaGxGYqpVOFaZKsxVVcNkFlMK0bcMT26LpL+TEFAjejZgwISy1n3gr5yLk+lm2DoPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMU3qmAWh7a9HvJjpTkkVXHZFS/fb0Br4GNtEml0VKo=;
 b=OEirgbf7sLZ8wvgC+B+F0bmvSGNNI1I0NNozQbjm6Sxa9iTR9JSZtNychN1GszyJZcjxUlqhXEp/FR1GRkgU/d9whPZMvS6lsKU8Byamab8eUuZN0r03SSAyJT6Cu904KhoHOr071KIGwF2NjzzkaAoUGo0kfiZx2Tb+oeCjvpWavE2o7/d3cMxHhOvfGveKXr1tFHkY4WcN4dI6HW+a5uyhqBrLaya9iWZinqS1q9qhzxP3/nsDm/Br3F+sjCB2VOzizy2/Wuee4rkJkAvkHjM4MznCGItGHI+OuMHmafgUbo1nvenEzE7K6Xkpm3ZDikr0q0Fe3QoRP7ytoZX9Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMU3qmAWh7a9HvJjpTkkVXHZFS/fb0Br4GNtEml0VKo=;
 b=tvuOfVDXfVgBKwmCsjy6FA6R/W5UFXGtFYUx9BBdm9M8kKaZezCODmCLbglTgbg0ZZV1PnZ5i637RNGIsEE90hYVPAAHVNxsfFZO6QtWbVL/UPsepiPkXNiIfCIkyypefAVqIrXmZyYyvUMT/HJzz+7Y+ny3NQVDJ23JNpQpwBZqSHHgJUIbKdZaBpGFQ+6b125yQOyLeZuHfLwx+GPzeBwoF2pAWx9ZoDv7y8NMMuKe7bc4J0Kn4igcVK3qyMn28QGDkgO/yeZtctlpig7w4PDC2sS/4kdod2n/4bQLyXG150bcrD+S1oJ2donY6TIPBCbAVi9C2aUPJanT+2nt+w==
Received: from MWHPR18CA0039.namprd18.prod.outlook.com (2603:10b6:320:31::25)
 by MN2PR12MB3518.namprd12.prod.outlook.com (2603:10b6:208:101::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Tue, 8 Mar
 2022 14:56:03 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:31:cafe::ab) by MWHPR18CA0039.outlook.office365.com
 (2603:10b6:320:31::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 8 Mar 2022 14:56:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 14:56:03 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 8 Mar
 2022 14:56:01 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 8 Mar 2022
 06:56:00 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 8 Mar 2022 06:55:58 -0800
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>, <sagi@grimberg.me>
CC:     <oren@nvidia.com>, <sergeygo@nvidia.com>, <israelr@nvidia.com>,
        <leonro@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v2 4/4] IB/iser: fix error flow in case of registration failure
Date:   Tue, 8 Mar 2022 16:55:46 +0200
Message-ID: <20220308145546.8372-5-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20220308145546.8372-1-mgurtovoy@nvidia.com>
References: <20220308145546.8372-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f7aa203-44e2-4d7c-75d3-08da0113c433
X-MS-TrafficTypeDiagnostic: MN2PR12MB3518:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3518B6A3CD7610ED151DC936DE099@MN2PR12MB3518.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2pV69vjVZV5vDUM/5WsBaxbP9Btrm7YxnNszFUIZuUdzFcCwNT1N+yDVkRV/iv8fh45bYTDmM6APnllLlMD7MHZMpNNzquieyfZ9IAwIBIVrmufjIlJPabyd+LJx17l7uz9Gll4NV2Dqg0yBFVqBON2al8KmNlZM6s2gml5yXfPEe6UlhCYwvNqapG1P39B3J+IcNCH7HwLFlq0osTUdQSXtzZdAFhLgVlzwDRZZ3On6T5BJXL/pjUOQNZcxaDMCidw9VnlpWD4aemjc/E+JMRXdlAWiaX+yrXwLyYN6rGA8fyehLIbEmgXbUL4CN/qXkutqzJXQceVUU3WfoW8muNqG+Y/5wPaOHZk2kFHS/959XIub9FP7boMAPHP/y2zuKtKIuSUYSrOz5BKbs4z6daMRxMlZ7WGeNB+VwIVy8cpwb+TYyue8v4+J5Yt7utPHF7Tz5USq/HOEXEpKC8tbEPEj3TC34Hs2WJmkdTmkaNboGjHMC2x7+txLR3e7Wc3JfC0nJt3IeLBPwwJoqxO6fCgTzpM75FXtHZc0nwEwB/Z2dF/AleIJNAZObVZZoYYFzAPiNuygrZQ2+8qIpYFdWYq4dpYFM1JSZse5EFDHU8mBKbrFLxfmc6VGHW/QSfeuh31Lco4MOp9gQY6p3Qpd9YqjwWNqGUcmmr+h7hmfUeb6xWXf0qeAVeDZ1ocpXHaIO+pauHqGcnkJ0rWCP/5cSQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(4326008)(81166007)(8676002)(70206006)(70586007)(5660300002)(2906002)(356005)(36756003)(8936002)(82310400004)(54906003)(36860700001)(110136005)(316002)(186003)(40460700003)(508600001)(86362001)(107886003)(47076005)(6666004)(2616005)(426003)(1076003)(26005)(83380400001)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 14:56:03.2809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7aa203-44e2-4d7c-75d3-08da0113c433
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3518
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

During READ/WRITE preparation, in case of failure in memory registration
using iser_reg_mem_fastreg we must unmap previously mapped iser task.

Reviewed-by: Sergey Gorenko <sergeygo@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/infiniband/ulp/iser/iser_initiator.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iser_initiator.c b/drivers/infiniband/ulp/iser/iser_initiator.c
index dbc2c268bc0e..bd5f3b5e1727 100644
--- a/drivers/infiniband/ulp/iser/iser_initiator.c
+++ b/drivers/infiniband/ulp/iser/iser_initiator.c
@@ -62,7 +62,7 @@ static int iser_prepare_read_cmd(struct iscsi_task *task)
 	err = iser_reg_mem_fastreg(iser_task, ISER_DIR_IN, false);
 	if (err) {
 		iser_err("Failed to set up Data-IN RDMA\n");
-		return err;
+		goto out_err;
 	}
 	mem_reg = &iser_task->rdma_reg[ISER_DIR_IN];
 
@@ -75,6 +75,10 @@ static int iser_prepare_read_cmd(struct iscsi_task *task)
 		 (unsigned long long)mem_reg->sge.addr);
 
 	return 0;
+
+out_err:
+	iser_dma_unmap_task_data(iser_task, ISER_DIR_IN, DMA_FROM_DEVICE);
+	return err;
 }
 
 /* Register user buffer memory and initialize passive rdma
@@ -100,9 +104,9 @@ static int iser_prepare_write_cmd(struct iscsi_task *task, unsigned int imm_sz,
 
 	err = iser_reg_mem_fastreg(iser_task, ISER_DIR_OUT,
 				   buf_out->data_len == imm_sz);
-	if (err != 0) {
+	if (err) {
 		iser_err("Failed to register write cmd RDMA mem\n");
-		return err;
+		goto out_err;
 	}
 
 	mem_reg = &iser_task->rdma_reg[ISER_DIR_OUT];
@@ -129,6 +133,10 @@ static int iser_prepare_write_cmd(struct iscsi_task *task, unsigned int imm_sz,
 	}
 
 	return 0;
+
+out_err:
+	iser_dma_unmap_task_data(iser_task, ISER_DIR_OUT, DMA_TO_DEVICE);
+	return err;
 }
 
 /* creates a new tx descriptor and adds header regd buffer */
-- 
2.18.1

