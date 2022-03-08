Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EBC4D1B11
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Mar 2022 15:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347669AbiCHO47 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Mar 2022 09:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344598AbiCHO46 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Mar 2022 09:56:58 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2084.outbound.protection.outlook.com [40.107.100.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305A54D60E
        for <linux-rdma@vger.kernel.org>; Tue,  8 Mar 2022 06:56:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKkOp7tNygLMS3mGqYx+wSYrrXLTwrfQpH935v2n3eotY7JdvS6fPNNPZ1DIMeaWHOMg2nSz5xnvbeaflhtTeVTSwFkgkc1icNnfjYCAtNaVezCsYTsJbsxBZA+fAmSI4FWLZ9OEiNwzroeCbCN0aDbLu7E4NlyLcpujtiZ4lhldSjJiiyYGFj8/33VoJUkx7buTCw+u5qNN3qkdS9ANMAWbXUEEFtbZRMpSWU9RROguODcmRXq75jVOwHDl+MbKihlT05eWBRTksg0FgiTYRMXW7mbwb98nakVQ0pXqgoW746Jk2fOlMe1QUoIeBTIAro46fv07875TDRRbBQfhww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rApqUlKOg13zbVn2MgrB0kco0FMtL211RsuqRof1G4=;
 b=E2fZHKzWdp/kC4tK6GEsk0XVTXWS/ELN0Iernr3BHumOWBHpqP1RFo7QWgLhc2zXqJUz9D+WZuLPo/6jNg9z2VEb7kj9oJLeNDbo+/N4YM1SMyPLirKNIeRSzlchjqs8w4cXIk3Rnz8rYx4/qrQ0njf1DKNMfa66l8fHiv4+c2EG8LcgTj56l7Pt8cqJcJPhiVeVmGgvwkJ1Hd03gcy4yIAuZCUSk/svpPNIoSeZ1Z8T+tZUCGWVMIWFuB8qKSkMWxcxzKqS9eS7DqBK8QxJhJWarXTxckK0cm7bQqUwRneeGY+ikmbbOh4hXpIqpzWt3gSszSLeYhf3XT2GB1JAmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rApqUlKOg13zbVn2MgrB0kco0FMtL211RsuqRof1G4=;
 b=NsUyqLB5SU0weklxcIAVIwK7fUwV1apAmDLzLNTNI2NNqd5JEpehVOeknzFE8khxsyfc7siraAyxfyGp3KZ9cpMSRPYUXfiVxABbM4H7TbqXNuz0hSDFWlmDxe3ZFL6zyTyMXAV/TxkHIuenphmiq30E+TSxHVARvO5MOzcZDTfGUPlFnKWDFWNo4tPs/ps7Jabmx98LG9qnrAN3VtcD7HmZ7Xbvp1MgaUJ34KwtwgKN/AN165i4BoQsvO0fVbuacI1OxpEkfeK27pDrdkXJRhEIf7KD84mIPSE6iM7fQLlTG4ZQab0FNv0VDNc0gzLwhkeKX2SET+vn62nEnCXjQQ==
Received: from BN9PR03CA0767.namprd03.prod.outlook.com (2603:10b6:408:13a::22)
 by CH0PR12MB5089.namprd12.prod.outlook.com (2603:10b6:610:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 14:55:59 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::b1) by BN9PR03CA0767.outlook.office365.com
 (2603:10b6:408:13a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 8 Mar 2022 14:55:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 14:55:58 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 8 Mar
 2022 14:55:56 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 8 Mar 2022
 06:55:55 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 8 Mar 2022 06:55:53 -0800
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>, <sagi@grimberg.me>
CC:     <oren@nvidia.com>, <sergeygo@nvidia.com>, <israelr@nvidia.com>,
        <leonro@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v2 2/4] IB/iser: use iser_fr_desc as registration context
Date:   Tue, 8 Mar 2022 16:55:44 +0200
Message-ID: <20220308145546.8372-3-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20220308145546.8372-1-mgurtovoy@nvidia.com>
References: <20220308145546.8372-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f0c241a-352a-4ec9-e253-08da0113c162
X-MS-TrafficTypeDiagnostic: CH0PR12MB5089:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5089CD82A9AD5BCE5E957D1ADE099@CH0PR12MB5089.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AeTE26efD54A1tgIRFuQqkKofgJ1rCpD+Yn7tp8lEbtH4pPreFgBwL+zzftJJfvATJ8/VtvhcjU9OGvgndBbNT1+z9q0XpdChr4QlBs7tWtCIso/3h3tStmnjKPEgquqpe+y+9dUcuTG//0k/mNbO/c+Wee/shoRP/xyglKIQw9HZlaMe/TBTDxFSZwpimfeGiAulpHN3opJkUaZat/50zJBbkkQn1SvyIgaKSFsRDrCrkvAdLK/vCNch8uzin9RXYMl6+y542pZlSalbeMlec5dc7feOELwpoGHvEsLWqwT2yDZgtgMmhL2X01HkR8XY5Qsl86m0Lmpdc+zpvdqlK5PdhfSNme8E2UNfqHaaTyEa+PkqUnF4VlZ2CVnlo2D7kIMhc4o30+Y1bgtJ/uVopuN5+4s5W5rqcrZq8zXxnI4MRIH032HHH2H5uL51FhOgcRKBl0FmvCDuCEO81Nw0JrQ9A/1K0dvrhGmG2xbI8hgwuQAc8qhkwdsWT3zYAzd7SSMBU4YFurcKtM9TJPcQ37HOtc3j23TTblGqhD3cxA4iLKCvFgaCG/RZc4sS6rv7mypngelIcSXgI80G8kb12vRafSUjF1wtXiZdLgPTG6cAUJ3ZEP7sKFM3UMjfUM/wOtgBBGlwe2xsgS6Xkn9F86Z6QKs1UYaIVush8mhoGIHVoR9XqkP/m2fVkeWAwyQ57kReM0yz46LXCXJYVOdpw==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(86362001)(5660300002)(8936002)(508600001)(6666004)(2906002)(1076003)(107886003)(186003)(26005)(40460700003)(4326008)(8676002)(82310400004)(70586007)(47076005)(2616005)(110136005)(356005)(36860700001)(81166007)(316002)(54906003)(426003)(336012)(36756003)(83380400001)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 14:55:58.0430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0c241a-352a-4ec9-e253-08da0113c162
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5089
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 4292c57856dd..01708df8cb0c 100644
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
@@ -358,7 +358,7 @@ int iser_reg_mem_fastreg(struct iscsi_iser_task *task,
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

