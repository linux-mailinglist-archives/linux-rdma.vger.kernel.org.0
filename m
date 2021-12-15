Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD87475A1B
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Dec 2021 14:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243082AbhLON5s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Dec 2021 08:57:48 -0500
Received: from mail-mw2nam08on2087.outbound.protection.outlook.com ([40.107.101.87]:52448
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243073AbhLON5q (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Dec 2021 08:57:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaCtR7EQ7JjgEsXW8SqMIw+yUgnb4d4FUbh5S1kptb+DV/N8I1c/rlX+NUchlas1jNyZAcdIFv0brNYUCiJYz893mlq4dBZZw2MkTC6axPk4QnKqLwmXCJud7e5UXNV9T4rHVExcaIc5uGjiwRLrswVq1QC2f3Pga4MfauNcbDXIId8MgmPwqfET6Kl6JhZczrEFMINtU2oxooTkfjy1YWGg7ZamcltzjVMkHFokzJ443UEha/JdbnOfTyHsTbovHHojc3j7yyPdLa1P/a0+ba1xbLuI16EwPT9GriL84U68mgUB3cstU93FilDv3EvOkTwryAc/1/3cQg+/v52mMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBwzfcac5E75E1TOD6go4/xRdkyDR0+jqJ8ueYzNbrw=;
 b=aUh+55CIpkhLEP7d77VCPtcWFT2O0lT477TCy2FusJbDuKEo+ySsk8r1/KyURoD54Sku1KQ4QlHdY/hkXpZjy+o6OJjBha7d/aV2cXGHUjOsT4Fe4yi5ulqgHdiw0cnJRtzSj20FaW6LqS/PBrh5Z+jDTJdTH9jUKiK6sdiY3M5Co4ZG5dHyByzWD9p4vmmn4BrdCN4+jfrg4hDNPAyyoVYVxpjvkBU3sAa7AGKjhvniUwz+u1YK/slSlReaGMQGrlg5P7wXcFKTRWpBPEnQcCsahmZ7swm6pRaJbqJDqjsdDls2V4jgqiZkXd9tkwl1PnYNdMhEDIbI3o1Xyo0uvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.13) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBwzfcac5E75E1TOD6go4/xRdkyDR0+jqJ8ueYzNbrw=;
 b=e2EfsnrCT6UJN/fUS6BxI1wFkbpoc9GWL2WvTf66lj3vcoBx8XqPRcNCn0yVOUTqymvjneGRdQ5Us1rtNEg+JgFjf7Q3SCVJecKUUwwUghNbv0hoBe6u7nuvE6DOjWtE+cKxSBjWh/+cNIWta/DesMmnn7w4sT9SDgyMTYvPvHojU5CSx+wGe8EKhHAKoolXM0+xBT1fpVCvGnzI82K44u8jyK8q11jNkHA/CuXRSjH3eE0ANKrv+qlPtFE8OhGfh7S49HFvmkHwLRa7eaBvKzz3NQxeNXuZixZcYsFr35boUXkJE7ogyRRyK5YGgBZEL+m8s8k5neKAAWnkP3AGZQ==
Received: from BN6PR11CA0011.namprd11.prod.outlook.com (2603:10b6:405:2::21)
 by CH2PR12MB5564.namprd12.prod.outlook.com (2603:10b6:610:65::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Wed, 15 Dec
 2021 13:57:44 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::ca) by BN6PR11CA0011.outlook.office365.com
 (2603:10b6:405:2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13 via Frontend
 Transport; Wed, 15 Dec 2021 13:57:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.13)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.13 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.13; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.13) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4778.13 via Frontend Transport; Wed, 15 Dec 2021 13:57:44 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 15 Dec
 2021 13:57:34 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 15 Dec
 2021 13:57:32 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 15 Dec 2021 13:57:31 +0000
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <sagi@grimberg.me>, <jgg@nvidia.com>
CC:     <oren@nvidia.com>, <israelr@nvidia.com>, <sergeygo@nvidia.com>,
        "Max Gurtovoy" <mgurtovoy@nvidia.com>
Subject: [PATCH 4/6] IB/iser: don't suppress send completions
Date:   Wed, 15 Dec 2021 15:57:19 +0200
Message-ID: <20211215135721.3662-5-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20211215135721.3662-1-mgurtovoy@nvidia.com>
References: <20211215135721.3662-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18d358f4-48fc-4d59-07d8-08d9bfd2dea6
X-MS-TrafficTypeDiagnostic: CH2PR12MB5564:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB5564CBE22B8C4E86A04FA8D1DE769@CH2PR12MB5564.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BGhwiL6H3lkWZay4/0xSPDvM2mncGBmlrMhIvV0R2k+Mpxi9uH0PyowAGe3RyJs8o5kS8ZkToQgg3zseKxXyoJkgBf6CHbvfwm5oRHIe6tD5YhtrbI70I07YzWfySCdSM7gjjPrFIqOZkbVqvwN8TYdJYihWwS4dmKU2tOdrtC7gxj18mhSufyEjbRxQbJqYLSZ9pzyhIwtdX/QyWm0bQceQnt85OqpZ2Z87JdjCRaJ7PoTryRaIBYRi7mZv/7GmEZoikAquxutSFPGYUyKKsFgU5GPtdsh1IT6IpHX/llDCSu7BlPB13+Is+10S3jN0IMCHTyujO7AA5+NcV0dZIc5zTAOQ5dvPNQDx6QZ9A+NZD/SvW//MjlFec+6+MXGuzQ224NbGQ1clYk7jV/XnGNQQE6cpfnkiJuZRz9BHCG9ivOWLp6pUHDrlnGjTS17KfVK2HvU9nDZh2MCQL6IIf8lOYsjmDUzIYhUa6HQGGRDwiuAi658xmVZma3+hOySwLompqqaFXaz9mG7pt+HFu9Oi4/cV82AGjAw7fMbMwyi9LVZ6b6BlyyfN8Un6IhXnC3cvqi1/HwdWl0nw+Nn4kT1SRenSQi2Bj9/745Vo5gNq4+/p6NHpq1rTfnXEiXU3gYCVF2J2uHJryJ22q2mERNg1QGSzIKPPLVnAKBl+sLAiagammhFMHWENLN2G74KXWXo+YHHOKvI4z20z1beZL1DvV834qkGZxr8d5DF0VjWQSC0LUu4FuTA0MkNS/w24q4TTXLPP4soqYei4hppZuVcT8AeQnrMKvvXS6HLN0Mc=
X-Forefront-Antispam-Report: CIP:203.18.50.13;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(70586007)(26005)(186003)(336012)(508600001)(36756003)(426003)(2616005)(6636002)(6666004)(1076003)(2906002)(316002)(54906003)(86362001)(34020700004)(8676002)(47076005)(82310400004)(5660300002)(4326008)(110136005)(70206006)(36860700001)(7636003)(356005)(40460700001)(83380400001)(8936002)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 13:57:44.4096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d358f4-48fc-4d59-07d8-08d9bfd2dea6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.13];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5564
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In order to complete a scsi command and guarantee that the HCA will
never perform an access violation when retrying a send operation we must
complete a scsi request only when both send and receive completions
has arrived. This is a preparation commit that remove the send
completions suppression. Next step will be taking care of the local
invalidation mechanism and adding a reference counter for commands.
Currently, we don't do anything upon getting the send completion and
just "consume" it.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Israel Rukshin <israelr@nvidia.com>
---
 drivers/infiniband/ulp/iser/iscsi_iser.h     |  7 +------
 drivers/infiniband/ulp/iser/iser_initiator.c | 13 +++----------
 drivers/infiniband/ulp/iser/iser_verbs.c     |  6 ++----
 3 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.h b/drivers/infiniband/ulp/iser/iscsi_iser.h
index 05a95d5b25f0..20af46c4e954 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.h
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.h
@@ -146,8 +146,6 @@
 					 - ISER_MAX_RX_MISC_PDUS) /	\
 					 (1 + ISER_INFLIGHT_DATAOUTS))
 
-#define ISER_SIGNAL_CMD_COUNT 32
-
 /* Constant PDU lengths calculations */
 #define ISER_HEADERS_LEN	(sizeof(struct iser_ctrl) + sizeof(struct iscsi_hdr))
 
@@ -364,7 +362,6 @@ struct iser_fr_pool {
  * @qp:                  Connection Queue-pair
  * @cq:                  Connection completion queue
  * @cq_size:             The number of max outstanding completions
- * @sig_count:           send work request signal count
  * @device:              reference to iser device
  * @fr_pool:             connection fast registration poool
  * @pi_support:          Indicate device T10-PI support
@@ -375,7 +372,6 @@ struct ib_conn {
 	struct ib_qp	            *qp;
 	struct ib_cq		    *cq;
 	u32			    cq_size;
-	u8                           sig_count;
 	struct iser_device          *device;
 	struct iser_fr_pool          fr_pool;
 	bool			     pi_support;
@@ -532,8 +528,7 @@ int  iser_connect(struct iser_conn *iser_conn,
 int  iser_post_recvl(struct iser_conn *iser_conn);
 int  iser_post_recvm(struct iser_conn *iser_conn,
 		     struct iser_rx_desc *rx_desc);
-int  iser_post_send(struct ib_conn *ib_conn, struct iser_tx_desc *tx_desc,
-		    bool signal);
+int  iser_post_send(struct ib_conn *ib_conn, struct iser_tx_desc *tx_desc);
 
 int iser_dma_map_task_data(struct iscsi_iser_task *iser_task,
 			   struct iser_data_buf *data,
diff --git a/drivers/infiniband/ulp/iser/iser_initiator.c b/drivers/infiniband/ulp/iser/iser_initiator.c
index ca22b6d1f5e3..778835003d39 100644
--- a/drivers/infiniband/ulp/iser/iser_initiator.c
+++ b/drivers/infiniband/ulp/iser/iser_initiator.c
@@ -350,11 +350,6 @@ static int iser_post_rx_bufs(struct iscsi_conn *conn, struct iscsi_hdr *req)
 	return err;
 }
 
-static inline bool iser_signal_comp(u8 sig_count)
-{
-	return ((sig_count % ISER_SIGNAL_CMD_COUNT) == 0);
-}
-
 /**
  * iser_send_command - send command PDU
  * @conn: link to matching iscsi connection
@@ -371,7 +366,6 @@ int iser_send_command(struct iscsi_conn *conn,
 	struct iscsi_scsi_req *hdr = (struct iscsi_scsi_req *)task->hdr;
 	struct scsi_cmnd *sc  =  task->sc;
 	struct iser_tx_desc *tx_desc = &iser_task->desc;
-	u8 sig_count = ++iser_conn->ib_conn.sig_count;
 
 	edtl = ntohl(hdr->data_length);
 
@@ -418,8 +412,7 @@ int iser_send_command(struct iscsi_conn *conn,
 
 	iser_task->status = ISER_TASK_STATUS_STARTED;
 
-	err = iser_post_send(&iser_conn->ib_conn, tx_desc,
-			     iser_signal_comp(sig_count));
+	err = iser_post_send(&iser_conn->ib_conn, tx_desc);
 	if (!err)
 		return 0;
 
@@ -487,7 +480,7 @@ int iser_send_data_out(struct iscsi_conn *conn,
 		 itt, buf_offset, data_seg_len);
 
 
-	err = iser_post_send(&iser_conn->ib_conn, tx_desc, true);
+	err = iser_post_send(&iser_conn->ib_conn, tx_desc);
 	if (!err)
 		return 0;
 
@@ -550,7 +543,7 @@ int iser_send_control(struct iscsi_conn *conn,
 			goto send_control_error;
 	}
 
-	err = iser_post_send(&iser_conn->ib_conn, mdesc, true);
+	err = iser_post_send(&iser_conn->ib_conn, mdesc);
 	if (!err)
 		return 0;
 
diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index e0d7119a2c40..53af7f4052ec 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -871,12 +871,10 @@ int iser_post_recvm(struct iser_conn *iser_conn, struct iser_rx_desc *rx_desc)
  * iser_post_send - Initiate a Send DTO operation
  * @ib_conn: connection RDMA resources
  * @tx_desc: iSER TX descriptor
- * @signal: true to send work request as SIGNALED
  *
  * Return: 0 on success, -1 on failure
  */
-int iser_post_send(struct ib_conn *ib_conn, struct iser_tx_desc *tx_desc,
-		   bool signal)
+int iser_post_send(struct ib_conn *ib_conn, struct iser_tx_desc *tx_desc)
 {
 	struct ib_send_wr *wr = &tx_desc->send_wr;
 	struct ib_send_wr *first_wr;
@@ -891,7 +889,7 @@ int iser_post_send(struct ib_conn *ib_conn, struct iser_tx_desc *tx_desc,
 	wr->sg_list = tx_desc->tx_sg;
 	wr->num_sge = tx_desc->num_sge;
 	wr->opcode = IB_WR_SEND;
-	wr->send_flags = signal ? IB_SEND_SIGNALED : 0;
+	wr->send_flags = IB_SEND_SIGNALED;
 
 	if (tx_desc->inv_wr.next)
 		first_wr = &tx_desc->inv_wr;
-- 
2.18.1

