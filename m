Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197BF60C808
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Oct 2022 11:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiJYJ1s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Oct 2022 05:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbiJYJ11 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Oct 2022 05:27:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A315188;
        Tue, 25 Oct 2022 02:22:56 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29P7EBIx010290;
        Tue, 25 Oct 2022 09:22:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=ZlxjLVbOxO5jlKNKzUmudBGOWBzc+8LWVI+TIkVxcUg=;
 b=pXgg4ynHQsNMuUHZ70L7eexPKBHmut6oIImaeEXMR3PHVofLQW00mtYiOZW9MVmD7wP3
 DUz8AG7OgmZW1itT3Y10+npKOMoxmDDYpheOjw2KTXqvdQWAEdiT8ZEQOTm6Y+KgZLWE
 iC+QMFhMPbIXgsAHRKYx4kVJ8RC7ni0j45L6DMGVrffiWDXWEy1v0H6F/l8Og55HEJLw
 jZMzdZA7FDxHf9paPuPuySfVR9S67Q3Zej13n0ugm9Gyc8HJ+fMOjaO7NyNQSxHAb/oL
 /TZOcmCLTdHCEY+wUyc96rCFiDQXt53Jo9uae227rkeiNScdYbcRDQp+Dh7Jrkqt2S28 oA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc7a327cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 09:22:52 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29P9FopY017239;
        Tue, 25 Oct 2022 09:22:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y4pvr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 09:22:51 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29P9Mp5D031381;
        Tue, 25 Oct 2022 09:22:51 GMT
Received: from akolappa-linux.us.oracle.com (dhcp-10-132-95-101.usdhcp.oraclecorp.com [10.132.95.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3kc6y4pvqr-1;
        Tue, 25 Oct 2022 09:22:51 +0000
From:   Arumugam Kolappan <aru.kolappan@oracle.com>
To:     leon@kernel.org, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     manjunath.b.patil@oracle.com, rama.nichanamatlu@oracle.com,
        aru.kolappan@oracle.com
Subject: [PATCH  1/1] net/mlx5: update debug log level for remote access error syndromes
Date:   Tue, 25 Oct 2022 02:22:01 -0700
Message-Id: <1666689721-30424-1-git-send-email-aru.kolappan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_03,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210250054
X-Proofpoint-GUID: ZKUGhHGYAyOIuylVUftqXrHBOUgyZaN-
X-Proofpoint-ORIG-GUID: ZKUGhHGYAyOIuylVUftqXrHBOUgyZaN-
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
---
 drivers/infiniband/hw/mlx5/cq.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index be189e0..d665129 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -267,10 +267,25 @@ static void handle_responder(struct ib_wc *wc, struct mlx5_cqe64 *cqe,
 	wc->wc_flags |= IB_WC_WITH_NETWORK_HDR_TYPE;
 }
 
-static void dump_cqe(struct mlx5_ib_dev *dev, struct mlx5_err_cqe *cqe)
+static void dump_cqe(struct mlx5_ib_dev *dev, struct mlx5_err_cqe *cqe,
+		     struct ib_wc *wc, int dump)
 {
-	mlx5_ib_warn(dev, "dump error cqe\n");
-	mlx5_dump_err_cqe(dev->mdev, cqe);
+	const char *level;
+
+	if (!dump)
+		return;
+
+	mlx5_ib_warn(dev, "WC error: %d, Message: %s\n", wc->status,
+		     ib_wc_status_msg(wc->status));
+
+	if (dump == 1)
+		level = KERN_WARNING;
+
+	if (dump == 2)
+		level = KERN_DEBUG;
+
+	print_hex_dump(level, "cqe_dump: ", DUMP_PREFIX_OFFSET, 16, 1,
+		       cqe, sizeof(*cqe), false);
 }
 
 static void mlx5_handle_error_cqe(struct mlx5_ib_dev *dev,
@@ -287,6 +302,7 @@ static void mlx5_handle_error_cqe(struct mlx5_ib_dev *dev,
 		wc->status = IB_WC_LOC_QP_OP_ERR;
 		break;
 	case MLX5_CQE_SYNDROME_LOCAL_PROT_ERR:
+		dump = 2;
 		wc->status = IB_WC_LOC_PROT_ERR;
 		break;
 	case MLX5_CQE_SYNDROME_WR_FLUSH_ERR:
@@ -306,9 +322,11 @@ static void mlx5_handle_error_cqe(struct mlx5_ib_dev *dev,
 		wc->status = IB_WC_REM_INV_REQ_ERR;
 		break;
 	case MLX5_CQE_SYNDROME_REMOTE_ACCESS_ERR:
+		dump = 2;
 		wc->status = IB_WC_REM_ACCESS_ERR;
 		break;
 	case MLX5_CQE_SYNDROME_REMOTE_OP_ERR:
+		dump = 2;
 		wc->status = IB_WC_REM_OP_ERR;
 		break;
 	case MLX5_CQE_SYNDROME_TRANSPORT_RETRY_EXC_ERR:
@@ -328,11 +346,7 @@ static void mlx5_handle_error_cqe(struct mlx5_ib_dev *dev,
 	}
 
 	wc->vendor_err = cqe->vendor_err_synd;
-	if (dump) {
-		mlx5_ib_warn(dev, "WC error: %d, Message: %s\n", wc->status,
-			     ib_wc_status_msg(wc->status));
-		dump_cqe(dev, cqe);
-	}
+	dump_cqe(dev, cqe, wc, dump);
 }
 
 static void handle_atomics(struct mlx5_ib_qp *qp, struct mlx5_cqe64 *cqe64,
-- 
1.8.3.1

