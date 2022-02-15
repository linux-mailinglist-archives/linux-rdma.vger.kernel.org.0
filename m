Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F184D4B6A3F
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 12:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbiBOLHM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 06:07:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236905AbiBOLHL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 06:07:11 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD8B107D0B
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 03:07:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrUc+ImXqcRhQc4eI3pPpXgSiLBRhrECac4XSUSwCCF00TZSMFFxWdG9WTx6NDB4txXqF53Sc2Zdwa3ks75LVtwNkOfrIBafCr0XwXEU3FIQ5jMWfPECE8vxpGhiO4oGtElP5ZgPC3jW3tsOTJMfk72/g5gqhm8VyH9+iZ3ExErNirkgpALIA3K16jobynA96ZiK4bXLB4Kq4nJHBZQHzi3yQQZI5V06xHZnUCQL3jtfwHXMUxxQUTIHhFTW2+usbWWeAuRlxOtSU7NRX6lgh62THj51zhrYZINlEs8/NQe7lcIfQZVUCKv0QCI32cl5pe+x8t2kyCHMwjY4aBdYPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMU3qmAWh7a9HvJjpTkkVXHZFS/fb0Br4GNtEml0VKo=;
 b=Z7jwXxYjNyOCv7Vx+THXyaJGCK7q7nwmy8WONaa2WQPqFhXn3jUBF3ebjAWoYWl82FlaRL8PZ4Fq4rOJL89h9yDokhKcGAZK0GWm29IM4KjjBzdsaroNdKPr1KK45QJs0XmVT10NkkDe0wk+RjyOMcl18+c4w4JSroS8lJBT7hXutVWZjaOHOQ1REw/djhIDFFObNYjj9qrTo9JDPTCgCqxQkP4r3ramI4VbA/WgQBQMw3IFdudfmDd9rgu9ZJacpa7VgVr3Vnijl7JsahKv8DSRtSxIyr7lXct93OJDReKNai9m2X2WeFwuaWAfKzBsa2knNpKwWEFZb0U7g1jTKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMU3qmAWh7a9HvJjpTkkVXHZFS/fb0Br4GNtEml0VKo=;
 b=lvN/4ThizmCP2AB5Nea3uG1EuMB+oE8aKc/3RNl7szL1n8T9N+BSquUvKpUsdNxbJy4fVNgRnuItYN6lE5hf1xA46EIyTPjV6pqSTrQBrmiRsGClTHpidDJ9hjszRTPkslWAQqqF8V1l1TLJ45S42iw1QzaF2Hh1Q1OmOlzw31klowTd69wJCNUtHKjUuhVByGADfZkZiGuCtlyBfobNW+RlhJenpzsYetYyccy1LngjXqFdfNijKxU2heBlcJeYZarJi+OKWP3oVfQFyy56NW+McPr8meHhZKxQbRtETX5wPdozdHrv4UoTBm9/xXUFg67kZI/gCIr3S+E6QlDSpA==
Received: from BN9PR03CA0889.namprd03.prod.outlook.com (2603:10b6:408:13c::24)
 by PH0PR12MB5647.namprd12.prod.outlook.com (2603:10b6:510:144::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Tue, 15 Feb
 2022 11:06:59 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::45) by BN9PR03CA0889.outlook.office365.com
 (2603:10b6:408:13c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18 via Frontend
 Transport; Tue, 15 Feb 2022 11:06:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 11:06:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 15 Feb
 2022 11:06:43 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 15 Feb 2022
 03:06:42 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 15 Feb 2022 03:06:41 -0800
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>, <sagi@grimberg.me>
CC:     <oren@nvidia.com>, <sergeygo@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 4/4] IB/iser: fix error flow in case of registration failure
Date:   Tue, 15 Feb 2022 13:06:32 +0200
Message-ID: <20220215110632.10697-5-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20220215110632.10697-1-mgurtovoy@nvidia.com>
References: <20220215110632.10697-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed52122d-d78d-4b01-4dc0-08d9f073496c
X-MS-TrafficTypeDiagnostic: PH0PR12MB5647:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB56477914D5585361A686570ADE349@PH0PR12MB5647.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SEzHryDom4aRBLraGpQjrj59si2mTnx3ZgvVGmlgw+znncEup1QY+TaVNA80gTTnh/wgKZ1SuCIpDwVZu7r3Q/69YPn15m4P2fA2IoehymoejFM0xPW15x5bp5I61KeXbtdxKTD3+t+1BnDM6DEL7rQ7HejHznKK2vvO0ECL9NVFLpTBqOUHcY3GHFhgBwz9KaT3mKWoD/HxYOuhpkReXsWqkiJCVR0EMEhaDGReTcZZJX6GV+fqj0B0tGrH/wyK82ZoIAAZzQtI/vqYOqQz2HzwLD9aDJ78qaFWt8Z0wviasZXNVVDioQC+eb/FRjezx5WcYd2b21FbuoRsjoTkqCgduG+7UayTyrZbqQ2+VGR1SCu/kCD+ikh19qNHGQ0jY3Ywui+ulwp36apVukrNUxt10ND8fN4icka6lwLpxcL377uToYjhhu391MSpG+utGsbhpcZ8n3ys+DbyzGJercx5stpMGhRtjmNGMp+cbciw5gQNldMB5cS+61AJkNXJbKDgjlqjxfUtFc4NhXM3e1W8S6vBbuOQclAy22A9SELVU2HbUBFShiufp5UszY59cMGT708RiKmJ6JNF7WZ4NCrb7PKfKQhsZZPgY+6dPYMVkTs+0VU3jfFmB8tMA72sUtwE01Y8c/G1pEgRoXl083vjHxKcxAsS12ZIb+3EIXqxNUkti5UbUStKHTbv0UJJZs32GUzdD0xDtxOrW7JVvQ==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2906002)(36860700001)(5660300002)(82310400004)(83380400001)(6666004)(107886003)(47076005)(70586007)(508600001)(356005)(86362001)(54906003)(4326008)(2616005)(316002)(26005)(81166007)(426003)(70206006)(186003)(336012)(110136005)(40460700003)(36756003)(1076003)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 11:06:59.1657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed52122d-d78d-4b01-4dc0-08d9f073496c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5647
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

