Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BAF6D062D
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Mar 2023 15:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjC3NNu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Mar 2023 09:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjC3NNr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Mar 2023 09:13:47 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E799020
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 06:13:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6Q9Mkygc5h9NcYMHQ/TBW55BRrnCIz2/vT6wWln71VZw77JYyAORICvIbE7ivYa5Q+uhf+gmSzuUldRupzZm7BVW2Re4cy1o2UMOlAgxNqOAJ72BL+5EdSmoiWVWIoQLV+6TRzfTzC8ZQS0XpXjnmVEIHVtiKqydORvfZ4Zx0k7lyj7CzFynkSf15aFx5/6+Y+exWGmHEjFVyWeQj8iLUXyL2GCyULy3EgRd3h8c1QkFHtVsr5TpWZpfapzJKiPHHG3rMt7Jt43y7GxWhHJM1aKmj8TDxaDtWRXj9wT2XGnedNNN0bFNcDwsS4UUWk3nKsZcPoB/aQ3+k/TBOBDRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SlHHg6CsupYgaHzzZhn3afJOGyFzmrjg+dG/gh9aoE=;
 b=O7TBHIeaLxplTHnL6ke4FxTHPWndlfFsh2G237h25tvKTzCdQKKnwBeDapLVEKz5q4Vl2WO0wKsuIMkJe25LcIuwwwjqVBXrwPG41QqooGMZjWtR5AB0ho9XChNSjRN/VAzIO+f8gqp6kdpwpXraHvqJlwH0tgTXyxFvI9rP6vpb2dZ7nJVP42eqOXrfZUKaE6gLQAQWIOlk0dN9QZ5Z6q/EWLytn5g83H6lwiTGRrwwPs6UBLL9GH003BWNxQJSNzA3IvwjSXhZ7X5CgBUm1rdYSXqkCqxRLQDrRQ+2eKK25brVNxdRXMdxjg4Qb5UWefI1Z3iM+oliMlrqNWwAUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SlHHg6CsupYgaHzzZhn3afJOGyFzmrjg+dG/gh9aoE=;
 b=djNxEErwlmVkdjVerTEnNgQs4zA8PSmj5jI0D59MKh35+6ErbZlVjK48j7g4AurCc5fM8eImrtYrAvTBh0Fw/5uV9++JE+53S2o7KNNkF8DGA4DICwgwf5buNIJ3jttrZ5T/I4S0qc2aRBbiEIcqfCSLo1M4ZfPM2S8wMHWNx/RxQ+hxNlWWn4EAU6NIsJ25MsZvUI1g+8XxCdKC3dBE5zj04BZIEA6jWwuyJmwmRTxkbI0zP/iZCK97m/w1HvEkfm2KbJll/SXxoZm0O18uMt2ti7/LlGNV1ueF9V4CZ3vPqyMXy52aAxNzUvvUM3Ql5JM54OKe2IysVpvthgnX7Q==
Received: from DM6PR13CA0041.namprd13.prod.outlook.com (2603:10b6:5:134::18)
 by SJ2PR12MB8183.namprd12.prod.outlook.com (2603:10b6:a03:4f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 13:13:41 +0000
Received: from DS1PEPF0000B076.namprd05.prod.outlook.com
 (2603:10b6:5:134:cafe::d) by DM6PR13CA0041.outlook.office365.com
 (2603:10b6:5:134::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 13:13:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0000B076.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 13:13:41 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 30 Mar 2023
 06:13:39 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 30 Mar 2023 06:13:39 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 30 Mar 2023 06:13:36 -0700
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <sagi@grimberg.me>, <leonro@nvidia.com>,
        <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>
CC:     <israelr@nvidia.com>, <oren@nvidia.com>, <sergeygo@nvidia.com>,
        "Max Gurtovoy" <mgurtovoy@nvidia.com>
Subject: [PATCH 2/3] IB/iser: centralize setting desc type and done callback
Date:   Thu, 30 Mar 2023 16:13:32 +0300
Message-ID: <20230330131333.37900-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20230330131333.37900-1-mgurtovoy@nvidia.com>
References: <20230330131333.37900-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B076:EE_|SJ2PR12MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: dd56a876-5036-43e5-8484-08db31209547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8T0Xa12qcYKCtdUfv8+gRgL9OUmjfcmiCJL0zNDGZrZKjTyY1L0UC/IoMbovOgtLzpeVPzVEhRZxqxN7G1ZCi4+7NSF4c6IsLUMCYCE/BBExSgDfM7jFnefG/FnSSsNkjg7wnuRsELEG458m2P0Cr2CzE/oWjsAaVBfm3Nl6mEJ0lWF92plkY2r519k/iIjtiA57Lm8uA/7tXl1qR2zk/0NTc87QhQB/mM+0UK2bHgMyvXi3x6LVBw0kT69QOf1nWepp+xkVuDcu3W69ZOIz/jQJyyAI4VYxEnVY3wBDppTDbZjyHQ6smM8AF4zHShvMGAX8Q9hmmo0lPmh40sY2ahXl9sL8hs+TVU3ptapmMmjMvjapxTf4OystyBus5C6zwTI3Sq3fz3ZlspwiP7+XDh6cB27bArkGZZx1J4f0AmBUOD7lQEtPZKy1v2eWoGGqB0r1cqSOGEw4Pnfwm2Q5IWJ1MuPIDYx3xI+qaoBOqL0/q8cwhAkube0gAj42vsk358tC7kttJUmhccVKoS/u4CGaDKpYCH+/5hoJvmMp3uGVgb2k/tWEqyYlQvkTWWhBQAiRya1unuQ4ZvjlitWSzACLYbgfGDp69iexACHcd4MOEkMXr39Sb+2CrKtWVqJ+F8q8kQgxKeeSwb6HsaMfr2TI8Gq+wBzuxb7oB3H0g4u50v1DwZ6MSScd3h7d53rN4zVNaEk0I8fTpyHj5gB0exDwAJNBpT6PRtKPOYA6Tu3/LmtjLtlVZCU2ar5eWOmtus2XhRzJLX4LQZ6Wr0nThQ==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(336012)(83380400001)(47076005)(36756003)(426003)(2616005)(186003)(107886003)(1076003)(6666004)(82310400005)(478600001)(86362001)(110136005)(54906003)(316002)(36860700001)(26005)(41300700001)(4326008)(40480700001)(6636002)(40460700003)(82740400003)(7636003)(356005)(8676002)(70586007)(70206006)(8936002)(2906002)(5660300002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 13:13:41.4857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd56a876-5036-43e5-8484-08db31209547
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B076.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8183
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Move this common logic into iser_create_send_desc instead of duplicating
the code.

Reviewed-by: Sergey Gorenko <sergeygo@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/infiniband/ulp/iser/iser_initiator.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iser_initiator.c b/drivers/infiniband/ulp/iser/iser_initiator.c
index 7b83f48f60c5..354928408399 100644
--- a/drivers/infiniband/ulp/iser/iser_initiator.c
+++ b/drivers/infiniband/ulp/iser/iser_initiator.c
@@ -141,10 +141,14 @@ static int iser_prepare_write_cmd(struct iscsi_task *task, unsigned int imm_sz,
 
 /* creates a new tx descriptor and adds header regd buffer */
 static void iser_create_send_desc(struct iser_conn *iser_conn,
-				  struct iser_tx_desc *tx_desc)
+		struct iser_tx_desc *tx_desc, enum iser_desc_type type,
+		void (*done)(struct ib_cq *cq, struct ib_wc *wc))
 {
 	struct iser_device *device = iser_conn->ib_conn.device;
 
+	tx_desc->type = type;
+	tx_desc->cqe.done = done;
+
 	ib_dma_sync_single_for_cpu(device->ib_device,
 		tx_desc->dma_addr, ISER_HEADERS_LEN, DMA_TO_DEVICE);
 
@@ -349,9 +353,8 @@ int iser_send_command(struct iscsi_conn *conn, struct iscsi_task *task)
 	edtl = ntohl(hdr->data_length);
 
 	/* build the tx desc regd header and add it to the tx desc dto */
-	tx_desc->type = ISCSI_TX_SCSI_COMMAND;
-	tx_desc->cqe.done = iser_cmd_comp;
-	iser_create_send_desc(iser_conn, tx_desc);
+	iser_create_send_desc(iser_conn, tx_desc, ISCSI_TX_SCSI_COMMAND,
+			      iser_cmd_comp);
 
 	if (hdr->flags & ISCSI_FLAG_CMD_READ) {
 		data_buf = &iser_task->data[ISER_DIR_IN];
@@ -478,9 +481,8 @@ int iser_send_control(struct iscsi_conn *conn, struct iscsi_task *task)
 	struct iser_device *device;
 
 	/* build the tx desc regd header and add it to the tx desc dto */
-	mdesc->type = ISCSI_TX_CONTROL;
-	mdesc->cqe.done = iser_ctrl_comp;
-	iser_create_send_desc(iser_conn, mdesc);
+	iser_create_send_desc(iser_conn, mdesc, ISCSI_TX_CONTROL,
+			      iser_ctrl_comp);
 
 	device = iser_conn->ib_conn.device;
 
-- 
2.18.1

