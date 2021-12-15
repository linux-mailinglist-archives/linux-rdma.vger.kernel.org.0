Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF81475A13
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Dec 2021 14:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243056AbhLON5k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Dec 2021 08:57:40 -0500
Received: from mail-bn7nam10on2073.outbound.protection.outlook.com ([40.107.92.73]:50144
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243062AbhLON5i (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Dec 2021 08:57:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Stues/QsmSwEUg/SNRLYlKoYeAGLP66K8hXiwJY+OqENGVR1Ms91RELCrkLJGtBqnmLNxIMLf3mWgTaHdurY5erMVVOUO7Igp+wII40B57MIwg76WWQ/zY+TPErZNnrBiOl4DPU64wjK8ONBusFnDMDAgAZJ1+04a8TK73D0HOKc6tG12fBu1aBe5+/R3ki7IDx+YEg0rS48afOnb8qxgRheMO0SA3sLhTXqgXk2dVko1KD5knMuJkwwdNCM3sEvInW5PFkCyvqxmFGq2enhAqlsyVg2b/z1pi3iPa9++NlU+BpFhsIfjJUs9pquKSgget5ESSJhkLk5yYNJS5AjGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpY/3nzVWH5fxoqIrED6t83jkTHR6xvV2Bdj8X/Kr04=;
 b=UGdfhwIDrn0HcA2q1LSK+lElL6BoHceRznoLE1h1YwsXMUPrJYxNUzxuyZGXQAxZ93J7Y1E8rqMWktmn8RW2XexyLHkGo2wrysuj+G0McfWuq4inNoCW6BtlH7wiSsuz2OHytGSSovbgbsQJYggfTv8QssHecDkLxLKU60ZPGJUM44TtDDZDTNL+dv/y/wbQ9Zqu5kiH3NNsJ3dpQKGmeaJ3HuohqtbH6F3TNd4RY2LRI+yd1YLpyNpcwvD0wY6tpFoMdbV0Q6R4b1iilC1ybH6QpjR0KbwmyRLDjrdZf2Dw/+sooAzLh4v3otFIcLYqN6fUGLTQw3x7iJvpT9VxMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.12) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpY/3nzVWH5fxoqIrED6t83jkTHR6xvV2Bdj8X/Kr04=;
 b=rK2o3Up1zoSWLoGnC86I5HuvwEKsYxGVd1ZZ2eCaKHVVtJNilHzXAGJxF/X2PFKTvKpeTrKVXniukTwSJJLG42Sj5FaK1SR9nE7IaWn/UywNoGpAY6hoMKTyWN11wdudYUw/5eKmj69ceWj8yJWMpEfqTMB5dBi8LeA7JyBNlibYIE/DNhEX/sPT3WGWx+YjFEMHi8jmur3soVLpgx0Gry7dXazc8nrB5hg5reORW89KissCN/GlBfB/vlQS0xtrkkEu6CkppDjbOdoU2x2eqfzuht4ZnjsHFtdFp5xQnJdoyYhEELuixcnFJ9sD3eV6DyGCFicSA5N8dv1BEkSqfg==
Received: from CO2PR04CA0003.namprd04.prod.outlook.com (2603:10b6:102:1::13)
 by MWHPR12MB1646.namprd12.prod.outlook.com (2603:10b6:301:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Wed, 15 Dec
 2021 13:57:36 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:1:cafe::52) by CO2PR04CA0003.outlook.office365.com
 (2603:10b6:102:1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16 via Frontend
 Transport; Wed, 15 Dec 2021 13:57:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.12)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.12; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.12) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4778.13 via Frontend Transport; Wed, 15 Dec 2021 13:57:35 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 15 Dec
 2021 13:57:30 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 15 Dec
 2021 13:57:28 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 15 Dec 2021 13:57:26 +0000
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <sagi@grimberg.me>, <jgg@nvidia.com>
CC:     <oren@nvidia.com>, <israelr@nvidia.com>, <sergeygo@nvidia.com>,
        "Max Gurtovoy" <mgurtovoy@nvidia.com>
Subject: [PATCH 2/6] IB/iser: fix RNR errors
Date:   Wed, 15 Dec 2021 15:57:17 +0200
Message-ID: <20211215135721.3662-3-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20211215135721.3662-1-mgurtovoy@nvidia.com>
References: <20211215135721.3662-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8112a4b1-7fca-42c2-6598-08d9bfd2d942
X-MS-TrafficTypeDiagnostic: MWHPR12MB1646:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB16463129F064168FE7875888DE769@MWHPR12MB1646.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cNrYXkySRC04RGB3UrrOFPs79a8M+K+AycHdQ8hOxzJ1MdaAFoEL9QA4RD1eGy0/gQwjXqGS+9qyDSUEpjgZO1Th3DEl+61HpEA016vxwZ7v6olgIsSFmMrRg7w2cGuD3ud3GvNzBXObgfiyxOMD6vEVsoW4XbJl0mkyY2dYoHcUn2m5/C1p64vhhvlTAeOGUkdSTAeC3tYo7kvNKxy+PHdUmtIBQjEcrS+wudlmTKcUXbgS+1fbk4d3Bvn34/0eQUjWrQNrPlJTTj6CZQZvcAygmwhauFf6Z2WQJuiUrJ1MNZ+DC9+UMvEzpEIXHv07d++K0SUj6WKwN6x8n2iuvEKFGXfzYSCviNIhuU+PByl3FMrfWd/Z4Pq64By0bmHrJyjzFTt4VhhFRWYILjH7QCF+gpq+7YqbRECEXnPJ26MjymnbIcACjt7/dzDMB/MpcriNyydwOpJ0pHzVRcij+SfLKJhqW/VXkCEupcGZsPH/CxMDv49vfqMKqeB8Auz4OvNzjh7Z/73k21GUaNuKc+LvPJSQ8jvqENkndcW/FmVUBZBPiCxCbjqYCzxqOECIRt/PfHV7Hwc3EQNKkpnVTNXAMBpDDrfkgAH81ImC1XvYtiC2LvpNNlKq7svVU2pdFpZvcaOWP+lWXfgHo7FhS1tKZKnsP7AXVvZGBbpoNmowYUJ+xawLHuzXIiV97lQydoMBtsDjuxI6SfgBCPnqtKpnvbsoIjhbjKBxd/mdEM1Tla7tdT+gyPCx9XeI2ubog8vwIvBbbLBpDRLGo2Fjkt4spQ3JAdgkMeMRLfrAkh4=
X-Forefront-Antispam-Report: CIP:203.18.50.12;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(6666004)(336012)(508600001)(2616005)(6636002)(426003)(4326008)(83380400001)(186003)(26005)(1076003)(40460700001)(107886003)(30864003)(36756003)(316002)(34020700004)(7636003)(86362001)(70586007)(82310400004)(5660300002)(8676002)(36860700001)(70206006)(54906003)(2906002)(110136005)(356005)(47076005)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 13:57:35.5086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8112a4b1-7fca-42c2-6598-08d9bfd2d942
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.12];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1646
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Sergey Gorenko <sergeygo@nvidia.com>

Some users complain about RNR errors on the target, when heavy
high-priority tasks run on the initiator. After the investigation, we
found out that the receive WRs were exhausted, because the initiator
could not post them on time.

Receive work reqeusts are posted in chunks to reduce the number of hits
to the HCA. The WRs are posted in the receive completion handler when
the number of free receive buffers reaches the threshold. But on a
high-loaded host, receive CQEs processing can be delayed and all receive
WRs will be exhausted. In this case, the target will get an RNR error.

To avoid this, we post receive WR, as soon as possible and not in a
batch. This increases the number of hits to the HCA, but also the common
implementation in most of Linux ULPs (e.g. NVMe-oF/RDMA). As a rule of
thumb, performance improvements and heuristics are being added to the
RDMA core layer or vendors low level drivers and it's about time to
align iSER as well.

Signed-off-by: Sergey Gorenko <sergeygo@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Israel Rukshin <israelr@nvidia.com>
---
 drivers/infiniband/ulp/iser/iscsi_iser.h     | 15 +----
 drivers/infiniband/ulp/iser/iser_initiator.c | 64 +++++++++-----------
 drivers/infiniband/ulp/iser/iser_verbs.c     | 41 ++++---------
 3 files changed, 42 insertions(+), 78 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.h b/drivers/infiniband/ulp/iser/iscsi_iser.h
index 22d2586b08cd..05a95d5b25f0 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.h
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.h
@@ -119,8 +119,6 @@
 
 #define ISER_QP_MAX_RECV_DTOS		(ISER_DEF_XMIT_CMDS_MAX)
 
-#define ISER_MIN_POSTED_RX		(ISER_DEF_XMIT_CMDS_MAX >> 2)
-
 /* the max TX (send) WR supported by the iSER QP is defined by                 *
  * max_send_wr = T * (1 + D) + C ; D is how many inflight dataouts we expect   *
  * to have at max for SCSI command. The tx posting & completion handling code  *
@@ -366,9 +364,7 @@ struct iser_fr_pool {
  * @qp:                  Connection Queue-pair
  * @cq:                  Connection completion queue
  * @cq_size:             The number of max outstanding completions
- * @post_recv_buf_count: post receive counter
  * @sig_count:           send work request signal count
- * @rx_wr:               receive work request for batch posts
  * @device:              reference to iser device
  * @fr_pool:             connection fast registration poool
  * @pi_support:          Indicate device T10-PI support
@@ -379,9 +375,7 @@ struct ib_conn {
 	struct ib_qp	            *qp;
 	struct ib_cq		    *cq;
 	u32			    cq_size;
-	int                          post_recv_buf_count;
 	u8                           sig_count;
-	struct ib_recv_wr	     rx_wr[ISER_MIN_POSTED_RX];
 	struct iser_device          *device;
 	struct iser_fr_pool          fr_pool;
 	bool			     pi_support;
@@ -397,8 +391,6 @@ struct ib_conn {
  * @state:            connection logical state
  * @qp_max_recv_dtos: maximum number of data outs, corresponds
  *                    to max number of post recvs
- * @qp_max_recv_dtos_mask: (qp_max_recv_dtos - 1)
- * @min_posted_rx:    (qp_max_recv_dtos >> 2)
  * @max_cmds:         maximum cmds allowed for this connection
  * @name:             connection peer portal
  * @release_work:     deffered work for release job
@@ -409,7 +401,6 @@ struct ib_conn {
  *                    (state is ISER_CONN_UP)
  * @conn_list:        entry in ig conn list
  * @login_desc:       login descriptor
- * @rx_desc_head:     head of rx_descs cyclic buffer
  * @rx_descs:         rx buffers array (cyclic buffer)
  * @num_rx_descs:     number of rx descriptors
  * @scsi_sg_tablesize: scsi host sg_tablesize
@@ -422,8 +413,6 @@ struct iser_conn {
 	struct iscsi_endpoint	     *ep;
 	enum iser_conn_state	     state;
 	unsigned		     qp_max_recv_dtos;
-	unsigned		     qp_max_recv_dtos_mask;
-	unsigned		     min_posted_rx;
 	u16                          max_cmds;
 	char 			     name[ISER_OBJECT_NAME_SIZE];
 	struct work_struct	     release_work;
@@ -433,7 +422,6 @@ struct iser_conn {
 	struct completion	     up_completion;
 	struct list_head	     conn_list;
 	struct iser_login_desc       login_desc;
-	unsigned int 		     rx_desc_head;
 	struct iser_rx_desc	     *rx_descs;
 	u32                          num_rx_descs;
 	unsigned short               scsi_sg_tablesize;
@@ -542,7 +530,8 @@ int  iser_connect(struct iser_conn *iser_conn,
 		  int non_blocking);
 
 int  iser_post_recvl(struct iser_conn *iser_conn);
-int  iser_post_recvm(struct iser_conn *iser_conn, int count);
+int  iser_post_recvm(struct iser_conn *iser_conn,
+		     struct iser_rx_desc *rx_desc);
 int  iser_post_send(struct ib_conn *ib_conn, struct iser_tx_desc *tx_desc,
 		    bool signal);
 
diff --git a/drivers/infiniband/ulp/iser/iser_initiator.c b/drivers/infiniband/ulp/iser/iser_initiator.c
index 27a6f75a9912..ca22b6d1f5e3 100644
--- a/drivers/infiniband/ulp/iser/iser_initiator.c
+++ b/drivers/infiniband/ulp/iser/iser_initiator.c
@@ -247,8 +247,6 @@ int iser_alloc_rx_descriptors(struct iser_conn *iser_conn,
 	struct iser_device *device = ib_conn->device;
 
 	iser_conn->qp_max_recv_dtos = session->cmds_max;
-	iser_conn->qp_max_recv_dtos_mask = session->cmds_max - 1; /* cmds_max is 2^N */
-	iser_conn->min_posted_rx = iser_conn->qp_max_recv_dtos >> 2;
 
 	if (iser_alloc_fastreg_pool(ib_conn, session->scsi_cmds_max,
 				    iser_conn->pages_per_mr))
@@ -280,7 +278,6 @@ int iser_alloc_rx_descriptors(struct iser_conn *iser_conn,
 		rx_sg->lkey = device->pd->local_dma_lkey;
 	}
 
-	iser_conn->rx_desc_head = 0;
 	return 0;
 
 rx_desc_dma_map_failed:
@@ -322,32 +319,35 @@ void iser_free_rx_descriptors(struct iser_conn *iser_conn)
 static int iser_post_rx_bufs(struct iscsi_conn *conn, struct iscsi_hdr *req)
 {
 	struct iser_conn *iser_conn = conn->dd_data;
-	struct ib_conn *ib_conn = &iser_conn->ib_conn;
 	struct iscsi_session *session = conn->session;
+	int err = 0;
+	int i;
 
 	iser_dbg("req op %x flags %x\n", req->opcode, req->flags);
 	/* check if this is the last login - going to full feature phase */
 	if ((req->flags & ISCSI_FULL_FEATURE_PHASE) != ISCSI_FULL_FEATURE_PHASE)
-		return 0;
-
-	/*
-	 * Check that there is one posted recv buffer
-	 * (for the last login response).
-	 */
-	WARN_ON(ib_conn->post_recv_buf_count != 1);
+		goto out;
 
 	if (session->discovery_sess) {
 		iser_info("Discovery session, re-using login RX buffer\n");
-		return 0;
-	} else
-		iser_info("Normal session, posting batch of RX %d buffers\n",
-			  iser_conn->min_posted_rx);
+		goto out;
+	}
 
-	/* Initial post receive buffers */
-	if (iser_post_recvm(iser_conn, iser_conn->min_posted_rx))
-		return -ENOMEM;
+	iser_info("Normal session, posting batch of RX %d buffers\n",
+		  iser_conn->qp_max_recv_dtos - 1);
 
-	return 0;
+	/*
+	 * Initial post receive buffers.
+	 * There is one already posted recv buffer (for the last login
+	 * response). Therefore, the first recv buffer is skipped here.
+	 */
+	for (i = 1; i < iser_conn->qp_max_recv_dtos; i++) {
+		err = iser_post_recvm(iser_conn, &iser_conn->rx_descs[i]);
+		if (err)
+			goto out;
+	}
+out:
+	return err;
 }
 
 static inline bool iser_signal_comp(u8 sig_count)
@@ -590,7 +590,11 @@ void iser_login_rsp(struct ib_cq *cq, struct ib_wc *wc)
 				      desc->rsp_dma, ISER_RX_LOGIN_SIZE,
 				      DMA_FROM_DEVICE);
 
-	ib_conn->post_recv_buf_count--;
+	if (iser_conn->iscsi_conn->session->discovery_sess)
+		return;
+
+	/* Post the first RX buffer that is skipped in iser_post_rx_bufs() */
+	iser_post_recvm(iser_conn, iser_conn->rx_descs);
 }
 
 static inline int
@@ -657,8 +661,7 @@ void iser_task_rsp(struct ib_cq *cq, struct ib_wc *wc)
 	struct iser_conn *iser_conn = to_iser_conn(ib_conn);
 	struct iser_rx_desc *desc = iser_rx(wc->wr_cqe);
 	struct iscsi_hdr *hdr;
-	int length;
-	int outstanding, count, err;
+	int length, err;
 
 	if (unlikely(wc->status != IB_WC_SUCCESS)) {
 		iser_err_comp(wc, "task_rsp");
@@ -687,20 +690,9 @@ void iser_task_rsp(struct ib_cq *cq, struct ib_wc *wc)
 				      desc->dma_addr, ISER_RX_PAYLOAD_SIZE,
 				      DMA_FROM_DEVICE);
 
-	/* decrementing conn->post_recv_buf_count only --after-- freeing the   *
-	 * task eliminates the need to worry on tasks which are completed in   *
-	 * parallel to the execution of iser_conn_term. So the code that waits *
-	 * for the posted rx bufs refcount to become zero handles everything   */
-	ib_conn->post_recv_buf_count--;
-
-	outstanding = ib_conn->post_recv_buf_count;
-	if (outstanding + iser_conn->min_posted_rx <= iser_conn->qp_max_recv_dtos) {
-		count = min(iser_conn->qp_max_recv_dtos - outstanding,
-			    iser_conn->min_posted_rx);
-		err = iser_post_recvm(iser_conn, count);
-		if (err)
-			iser_err("posting %d rx bufs err %d\n", count, err);
-	}
+	err = iser_post_recvm(iser_conn, desc);
+	if (err)
+		iser_err("posting rx buffer err %d\n", err);
 }
 
 void iser_cmd_comp(struct ib_cq *cq, struct ib_wc *wc)
diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index b566f7cb7797..e272390bc492 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -757,7 +757,6 @@ void iser_conn_init(struct iser_conn *iser_conn)
 	INIT_LIST_HEAD(&iser_conn->conn_list);
 	mutex_init(&iser_conn->state_mutex);
 
-	ib_conn->post_recv_buf_count = 0;
 	ib_conn->reg_cqe.done = iser_reg_comp;
 }
 
@@ -841,44 +840,28 @@ int iser_post_recvl(struct iser_conn *iser_conn)
 	wr.num_sge = 1;
 	wr.next = NULL;
 
-	ib_conn->post_recv_buf_count++;
 	ib_ret = ib_post_recv(ib_conn->qp, &wr, NULL);
-	if (ib_ret) {
-		iser_err("ib_post_recv failed ret=%d\n", ib_ret);
-		ib_conn->post_recv_buf_count--;
-	}
+	if (unlikely(ib_ret))
+		iser_err("ib_post_recv login failed ret=%d\n", ib_ret);
 
 	return ib_ret;
 }
 
-int iser_post_recvm(struct iser_conn *iser_conn, int count)
+int iser_post_recvm(struct iser_conn *iser_conn, struct iser_rx_desc *rx_desc)
 {
 	struct ib_conn *ib_conn = &iser_conn->ib_conn;
-	unsigned int my_rx_head = iser_conn->rx_desc_head;
-	struct iser_rx_desc *rx_desc;
-	struct ib_recv_wr *wr;
-	int i, ib_ret;
-
-	for (wr = ib_conn->rx_wr, i = 0; i < count; i++, wr++) {
-		rx_desc = &iser_conn->rx_descs[my_rx_head];
-		rx_desc->cqe.done = iser_task_rsp;
-		wr->wr_cqe = &rx_desc->cqe;
-		wr->sg_list = &rx_desc->rx_sg;
-		wr->num_sge = 1;
-		wr->next = wr + 1;
-		my_rx_head = (my_rx_head + 1) & iser_conn->qp_max_recv_dtos_mask;
-	}
+	struct ib_recv_wr wr;
+	int ib_ret;
 
-	wr--;
-	wr->next = NULL; /* mark end of work requests list */
+	rx_desc->cqe.done = iser_task_rsp;
+	wr.wr_cqe = &rx_desc->cqe;
+	wr.sg_list = &rx_desc->rx_sg;
+	wr.num_sge = 1;
+	wr.next = NULL;
 
-	ib_conn->post_recv_buf_count += count;
-	ib_ret = ib_post_recv(ib_conn->qp, ib_conn->rx_wr, NULL);
-	if (unlikely(ib_ret)) {
+	ib_ret = ib_post_recv(ib_conn->qp, &wr, NULL);
+	if (unlikely(ib_ret))
 		iser_err("ib_post_recv failed ret=%d\n", ib_ret);
-		ib_conn->post_recv_buf_count -= count;
-	} else
-		iser_conn->rx_desc_head = my_rx_head;
 
 	return ib_ret;
 }
-- 
2.18.1

