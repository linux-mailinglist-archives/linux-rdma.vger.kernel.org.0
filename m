Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836D84B6A39
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 12:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbiBOLGw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 06:06:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiBOLGv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 06:06:51 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C89E101F27
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 03:06:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/BAVzJyTAcQsKFLS4j/oB1LOnbnmUIxRtMGqoBGsKX4qgn0dRs/WZdPCyzG43MF1qJs3qOF/1KM7b325ywPTr5FjzSuyGKeflewIjRhABcG/unl+/Puuc8m17qcU/fvbZBoKsAhch5JzaCN1OODi4kdtvi9dGlI3uM8+YAeQd71TEdVF9YgAVjPAUKZOicjFV4AO5hoySfufntL4AlOYi6BCIivshimSW3hrM49ipkl3tpQkZHrTAY1LYU7Pa2lzJqmKiMfwjiOKx+2alKEj39aWBFVK19ATYuWjXqulXCioUi1cmOAlVhC2VInAU/V29rqqEfvGBO45o2TmI7M8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhBqcEGOZBXT6lrrxzYgdWLnupdaGQ6HL5u5lFfDP0U=;
 b=V3ekkTfnzNlhQacSGxSTRmtPL+SB8XARtLYWBbvXB4wsP8Zd0pO6BeXHEMrHNWpH8wYb03K4Ba3k537uaSR0JQol1iNfuScIc3bd9u0FJLH7iM/QGcw7gS153oGprQFzZTQWTuUkyGidCIjRZ6Haqv1dGfpjCzJS7LK0NxmiKYPwATSqbAQRd2hDotm1uWh4vZEYYMQiTAcKtvTIWaYsGyexbxraSLuQl1RNoP0Nr0tLK9woak6iRKIXkaY1Jm6nLt+fIW72bSDxzLSTAQtWG0dn7udRub3OfDVkdI8p1AEDEyWDKpSItCyB73UYqf7wDTd5rmRf6VqrpKIL/f2fZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhBqcEGOZBXT6lrrxzYgdWLnupdaGQ6HL5u5lFfDP0U=;
 b=BdkDbw8ET3TbxNhqG5EW30KgPysZi4K26lU3SiwpeIM94M80fVPZJ+gczvTb2jWjQ1Nc1y3iPJaSKfJeHmt4fLG5/hL2QDv8OABQyPYC379UG2OtmwhApUIsXDZngMGmCbQgj77H2csP+1Hpr8I94eYNx+BYCQY6uRUgr0GbGxOdBp8aLZQoFRXEnFMXvaR1xET7CMDq+ty1CmBNCLr2ATJNH38unxM+P1ugMRMvdqxbAwbsK48Ibr0bGdXreDK9g5orsCCBN7/Km85JD14MZzn99ULsKxuLEczT48UnStb2WhQJvRLvchMN1Lj53uowBvu269445oqO4bjaOAEKug==
Received: from MW4PR03CA0025.namprd03.prod.outlook.com (2603:10b6:303:8f::30)
 by MN2PR12MB4830.namprd12.prod.outlook.com (2603:10b6:208:1bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Tue, 15 Feb
 2022 11:06:40 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::3e) by MW4PR03CA0025.outlook.office365.com
 (2603:10b6:303:8f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17 via Frontend
 Transport; Tue, 15 Feb 2022 11:06:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 11:06:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 15 Feb
 2022 11:06:39 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 15 Feb 2022
 03:06:38 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 15 Feb 2022 03:06:37 -0800
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>, <sagi@grimberg.me>
CC:     <oren@nvidia.com>, <sergeygo@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 2/4] IB/iser: use iser_fr_desc as registration context
Date:   Tue, 15 Feb 2022 13:06:30 +0200
Message-ID: <20220215110632.10697-3-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20220215110632.10697-1-mgurtovoy@nvidia.com>
References: <20220215110632.10697-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c27b2320-fa65-42a5-895b-08d9f0733dff
X-MS-TrafficTypeDiagnostic: MN2PR12MB4830:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4830D39B1BE855947C9915DBDE349@MN2PR12MB4830.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X63s5o7OoVRE+TzJUuwoMaWIm0nsZfH7xoyU271kOONl4zZb2cjDRjVlDZrZQUpE9uhQzBqC9aiPU6Ggj0cUBqS+sQ9v1daQAXXQ25CnDHV4EC3vChmxl6kTeoDqnmNKuIeeCfA7gv66qOvb22lb3K96YKrrB+5KGOlXRQxMYVUm570d3yDyM6fbj1o+shKjLtrYVAaxyNcpHHpq0cS2UrjzSu4MgmA5+ztjRcgKeo6EIIThwnmEHXBtc24Gqepglj0K5bbgzASmjGBekpdiSDjQaZE1Gwq+2JJO2R0xTQtXEx/MptIQBwV6hU8Tr0cwVs5ETXG1lkiJEKVrPl1knCNUcoyCAB775xw5Qwd4BXRbHXxKhBBq/n/6/fDJJjXjipiRmgkHzEpBSZgM/ZVP/pKR1hP52Bx8oeg78+71FNUrRpg1PWV2dkrlbbVwHyu52/6m1sxkfnFqACc5CpmDgDtisFDQlecV1kFTvAU0FUmr7jUsyjjjUubnhgiqANur3gyuTY0K11GQmZ97NKf1wdZfjAI1vgLIlw4VhV0s699C6gXXjWjr3Ds6hJ34njZmOfYPzp5996nDd1NEkI9PngljFHBeLZZ+xPT0i/mDDB4SrxLRTGzjqK0kf09rU04nvLydpOV9fX69cSFmt9ThScrZQUqnAPNLvatgZYT7+ZFW4UFgz9meraDH/Fos6ReZahouHBAWJEkOUmIiXfaQDA==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36860700001)(2906002)(107886003)(83380400001)(2616005)(186003)(26005)(426003)(1076003)(336012)(47076005)(82310400004)(508600001)(70586007)(8676002)(316002)(36756003)(40460700003)(86362001)(8936002)(4326008)(70206006)(110136005)(6666004)(356005)(5660300002)(81166007)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 11:06:39.9979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c27b2320-fa65-42a5-895b-08d9f0733dff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4830
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

After removing the FMR support in iSER, there is only one type of
registration context. Replace the void pointer with the explicit
structure for registration (struct iser_fr_desc).

Reviewed-by: Sergey Gorenko <sergeygo@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/infiniband/ulp/iser/iscsi_iser.h     | 8 ++++----
 drivers/infiniband/ulp/iser/iser_initiator.c | 4 ++--
 drivers/infiniband/ulp/iser/iser_memory.c    | 8 ++++----
 drivers/infiniband/ulp/iser/iser_verbs.c     | 2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.h b/drivers/infiniband/ulp/iser/iscsi_iser.h
index 20af46c4e954..23b922233006 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.h
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.h
@@ -203,12 +203,12 @@ struct iser_reg_resources;
  *
  * @sge:          memory region sg element
  * @rkey:         memory region remote key
- * @mem_h:        pointer to registration context (FMR/Fastreg)
+ * @desc:         pointer to fast registration context
  */
 struct iser_mem_reg {
-	struct ib_sge	 sge;
-	u32		 rkey;
-	void		*mem_h;
+	struct ib_sge sge;
+	u32 rkey;
+	struct iser_fr_desc *desc;
 };
 
 enum iser_desc_type {
diff --git a/drivers/infiniband/ulp/iser/iser_initiator.c b/drivers/infiniband/ulp/iser/iser_initiator.c
index 2490150d3085..012decf6905a 100644
--- a/drivers/infiniband/ulp/iser/iser_initiator.c
+++ b/drivers/infiniband/ulp/iser/iser_initiator.c
@@ -619,13 +619,13 @@ static int iser_check_remote_inv(struct iser_conn *iser_conn, struct ib_wc *wc,
 			struct iser_fr_desc *desc;
 
 			if (iser_task->dir[ISER_DIR_IN]) {
-				desc = iser_task->rdma_reg[ISER_DIR_IN].mem_h;
+				desc = iser_task->rdma_reg[ISER_DIR_IN].desc;
 				if (unlikely(iser_inv_desc(desc, rkey)))
 					return -EINVAL;
 			}
 
 			if (iser_task->dir[ISER_DIR_OUT]) {
-				desc = iser_task->rdma_reg[ISER_DIR_OUT].mem_h;
+				desc = iser_task->rdma_reg[ISER_DIR_OUT].desc;
 				if (unlikely(iser_inv_desc(desc, rkey)))
 					return -EINVAL;
 			}
diff --git a/drivers/infiniband/ulp/iser/iser_memory.c b/drivers/infiniband/ulp/iser/iser_memory.c
index 2738ec56c918..72a117cd6fd7 100644
--- a/drivers/infiniband/ulp/iser/iser_memory.c
+++ b/drivers/infiniband/ulp/iser/iser_memory.c
@@ -130,7 +130,7 @@ void iser_unreg_mem_fastreg(struct iscsi_iser_task *iser_task,
 	struct iser_fr_desc *desc;
 	struct ib_mr_status mr_status;
 
-	desc = reg->mem_h;
+	desc = reg->desc;
 	if (!desc)
 		return;
 
@@ -147,8 +147,8 @@ void iser_unreg_mem_fastreg(struct iscsi_iser_task *iser_task,
 		ib_check_mr_status(desc->rsc.sig_mr, IB_MR_CHECK_SIG_STATUS,
 				   &mr_status);
 	}
-	iser_reg_desc_put_fr(&iser_task->iser_conn->ib_conn, reg->mem_h);
-	reg->mem_h = NULL;
+	iser_reg_desc_put_fr(&iser_task->iser_conn->ib_conn, reg->desc);
+	reg->desc = NULL;
 }
 
 static void iser_set_dif_domain(struct scsi_cmnd *sc,
@@ -361,7 +361,7 @@ int iser_reg_mem_fastreg(struct iscsi_iser_task *task,
 		desc->sig_protected = true;
 	}
 
-	reg->mem_h = desc;
+	reg->desc = desc;
 
 	return 0;
 
diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index 8bf87b073d9b..c7607b22a396 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -905,7 +905,7 @@ u8 iser_check_task_pi_status(struct iscsi_iser_task *iser_task,
 			     enum iser_data_dir cmd_dir, sector_t *sector)
 {
 	struct iser_mem_reg *reg = &iser_task->rdma_reg[cmd_dir];
-	struct iser_fr_desc *desc = reg->mem_h;
+	struct iser_fr_desc *desc = reg->desc;
 	unsigned long sector_size = iser_task->sc->device->sector_size;
 	struct ib_mr_status mr_status;
 	int ret;
-- 
2.18.1

