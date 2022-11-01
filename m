Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F66614508
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Nov 2022 08:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiKAH2D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Nov 2022 03:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKAH2C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Nov 2022 03:28:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030DD17437;
        Tue,  1 Nov 2022 00:28:00 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1671xi022039;
        Tue, 1 Nov 2022 07:27:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=qy0ufu4MNozywPSm72pviM8oNNpt5w2srDY6wzyqHdU=;
 b=R3/pOJxvUalrDJiJns5LrZcWuEWCqzB0pK5xV4yBAfPLnOL2ms6Rc2JPFKC828uqcTW7
 pxMzVOu92/bK2pKiyEZcdNhQqhM4/tDQqKSCj4lSCgTeA26BE/rN1V8svIYUEa0KPMgI
 I2v9Vvfof2/V5M4enwZEKEJ37etFF9xWd/Pv89tmgAtGUQaGnzrkXDKFwuMKHGQoV8u6
 k3AZZucP/JdxLBtQod3913wOowtxgxZH/xq2ISL0aDVyesxjhzktBq4Qd3aLMhrAz8o/
 4ZPtNJ6qPgvLf5pyh0yDZRVnSB4YlHlbU/t7bHAc7EpOf35cqR+E00d5BG1jx7IxfDtG JA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgts15vds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 07:27:51 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A16H16R025913;
        Tue, 1 Nov 2022 07:27:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtmachfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 07:27:50 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A17MwLP009985;
        Tue, 1 Nov 2022 07:27:49 GMT
Received: from akolappa-linux.us.oracle.com (dhcp-10-132-95-101.usdhcp.oraclecorp.com [10.132.95.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3kgtmachf1-1;
        Tue, 01 Nov 2022 07:27:49 +0000
From:   Arumugam Kolappan <aru.kolappan@oracle.com>
To:     leon@kernel.org, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     manjunath.b.patil@oracle.com, rama.nichanamatlu@oracle.com,
        aru.kolappan@oracle.com
Subject: [PATCH rdma-next v2] RDMA/mlx5: update debug log level for remote access error syndromes
Date:   Tue,  1 Nov 2022 00:27:44 -0700
Message-Id: <1667287664-19377-1-git-send-email-aru.kolappan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_03,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211010056
X-Proofpoint-GUID: mHbayBG8IqA8Aa66gx-zMuraDSW8Ikl1
X-Proofpoint-ORIG-GUID: mHbayBG8IqA8Aa66gx-zMuraDSW8Ikl1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The mlx5 driver dumps the entire CQE buffer by default for few syndromes.
Some syndromes are expected due to the application behavior [ex:
MLX5_CQE_SYNDROME_REMOTE_ACCESS_ERR, MLX5_CQE_SYNDROME_REMOTE_OP_ERR and
MLX5_CQE_SYNDROME_LOCAL_PROT_ERR]. Hence, for these syndromes, the patch
converts the log level from KERN_WARNING to KERN_DEBUG. This enables the
application to get the CQE buffer dump by changing to KERN_DEBUG level
as and when needed.

Suggested-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Arumugam Kolappan <aru.kolappan@oracle.com>
----
v1 -> v2:
      Added mlx5_ib_log() - print based on log_level
      dump_cqe() takes log_level as argument
---
 drivers/infiniband/hw/mlx5/cq.c      | 27 +++++++++++++++------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  4 ++++
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index be189e0..1611b49 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -267,17 +267,20 @@ static void handle_responder(struct ib_wc *wc, struct mlx5_cqe64 *cqe,
 	wc->wc_flags |= IB_WC_WITH_NETWORK_HDR_TYPE;
 }
 
-static void dump_cqe(struct mlx5_ib_dev *dev, struct mlx5_err_cqe *cqe)
+static void dump_cqe(struct mlx5_ib_dev *dev, struct mlx5_err_cqe *cqe,
+		     struct ib_wc *wc, const char *level)
 {
-	mlx5_ib_warn(dev, "dump error cqe\n");
-	mlx5_dump_err_cqe(dev->mdev, cqe);
+	mlx5_ib_log(level, dev, "WC error: %d, Message: %s\n", wc->status,
+		    ib_wc_status_msg(wc->status));
+	print_hex_dump(level, "cqe_dump: ", DUMP_PREFIX_OFFSET, 16, 1,
+		       cqe, sizeof(*cqe), false);
 }
 
 static void mlx5_handle_error_cqe(struct mlx5_ib_dev *dev,
 				  struct mlx5_err_cqe *cqe,
 				  struct ib_wc *wc)
 {
-	int dump = 1;
+	const char *dump = KERN_WARNING;
 
 	switch (cqe->syndrome) {
 	case MLX5_CQE_SYNDROME_LOCAL_LENGTH_ERR:
@@ -287,10 +290,11 @@ static void mlx5_handle_error_cqe(struct mlx5_ib_dev *dev,
 		wc->status = IB_WC_LOC_QP_OP_ERR;
 		break;
 	case MLX5_CQE_SYNDROME_LOCAL_PROT_ERR:
+		dump = KERN_DEBUG;
 		wc->status = IB_WC_LOC_PROT_ERR;
 		break;
 	case MLX5_CQE_SYNDROME_WR_FLUSH_ERR:
-		dump = 0;
+		dump = NULL;
 		wc->status = IB_WC_WR_FLUSH_ERR;
 		break;
 	case MLX5_CQE_SYNDROME_MW_BIND_ERR:
@@ -306,18 +310,20 @@ static void mlx5_handle_error_cqe(struct mlx5_ib_dev *dev,
 		wc->status = IB_WC_REM_INV_REQ_ERR;
 		break;
 	case MLX5_CQE_SYNDROME_REMOTE_ACCESS_ERR:
+		dump = KERN_DEBUG;
 		wc->status = IB_WC_REM_ACCESS_ERR;
 		break;
 	case MLX5_CQE_SYNDROME_REMOTE_OP_ERR:
+		dump = KERN_DEBUG;
 		wc->status = IB_WC_REM_OP_ERR;
 		break;
 	case MLX5_CQE_SYNDROME_TRANSPORT_RETRY_EXC_ERR:
 		wc->status = IB_WC_RETRY_EXC_ERR;
-		dump = 0;
+		dump = NULL;
 		break;
 	case MLX5_CQE_SYNDROME_RNR_RETRY_EXC_ERR:
 		wc->status = IB_WC_RNR_RETRY_EXC_ERR;
-		dump = 0;
+		dump = NULL;
 		break;
 	case MLX5_CQE_SYNDROME_REMOTE_ABORTED_ERR:
 		wc->status = IB_WC_REM_ABORT_ERR;
@@ -328,11 +334,8 @@ static void mlx5_handle_error_cqe(struct mlx5_ib_dev *dev,
 	}
 
 	wc->vendor_err = cqe->vendor_err_synd;
-	if (dump) {
-		mlx5_ib_warn(dev, "WC error: %d, Message: %s\n", wc->status,
-			     ib_wc_status_msg(wc->status));
-		dump_cqe(dev, cqe);
-	}
+	if (dump)
+		dump_cqe(dev, cqe, wc, dump);
 }
 
 static void handle_atomics(struct mlx5_ib_qp *qp, struct mlx5_cqe64 *cqe64,
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index e66bf72..0fb8e2a 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -38,6 +38,10 @@
 	dev_warn(&(_dev)->ib_dev.dev, "%s:%d:(pid %d): " format, __func__,     \
 		 __LINE__, current->pid, ##arg)
 
+#define mlx5_ib_log(lvl, _dev, format, arg...)                                 \
+	dev_printk(lvl, &(_dev)->ib_dev.dev,  "%s:%d:(pid %d): " format,       \
+		   __func__, __LINE__, current->pid, ##arg)
+
 #define MLX5_IB_DEFAULT_UIDX 0xffffff
 #define MLX5_USER_ASSIGNED_UIDX_MASK __mlx5_mask(qpc, user_index)
 
-- 
1.8.3.1

