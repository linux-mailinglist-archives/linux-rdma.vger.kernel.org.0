Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66CB797CE6
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 16:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbfHUO1s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 10:27:48 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52516 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbfHUO1s (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Aug 2019 10:27:48 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LENXvg096446;
        Wed, 21 Aug 2019 14:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=wF8k2yGaEghPM0mvQrc2oh+WBNbXs7EXelHLeROlRAM=;
 b=GauoHJz1P/4MxaOnTGq1pGWuKYZxKKcZHXnabz0LatdV34BQIKUuLrtikwHlvGhCHOx0
 88x2Fri8wSj/rK5Fxoec+2Ut8+lkm2cPmYB8cXgAuMsEMccw7lmICksMzzmxVpKE0M+p
 nKDATdHtW699BieLeWsiJu6C0E0YSOWeWJrDEs/1AdbndAjK8aGZJXCSbyCMsOv+Np/4
 Qlw0vNyIj0CsCpxcSFGapRuqnI60CFckfd8GaMsl74doiVf5kon4igu9QOlqECdy1t6x
 CWgn7mXke9riT9TrhP05werA4aqjwtYGC8+b3rdmJp3YsRfKKY56zkinLX44ohM2RnTz +w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2ue9hpnw25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:27:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LEMquZ017117;
        Wed, 21 Aug 2019 14:27:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2uh2q4k2v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:27:29 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7LERRjD003382;
        Wed, 21 Aug 2019 14:27:27 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Aug 2019 07:27:27 -0700
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        monis@mellanox.com, parav@mellanox.com, danielj@mellanox.com,
        kamalheib1@gmail.com, markz@mellanox.com,
        swise@opengridcomputing.com, shamir.rabinovitch@oracle.com,
        johannes.berg@intel.com, willy@infradead.org,
        michaelgur@mellanox.com, markb@mellanox.com,
        yuval.shaia@oracle.com, dan.carpenter@oracle.com,
        bvanassche@acm.org, maxg@mellanox.com, israelr@mellanox.com,
        galpress@amazon.com, denisd@mellanox.com, yuvalav@mellanox.com,
        dennis.dalessandro@intel.com, will@kernel.org, ereza@mellanox.com,
        jgg@mellanox.com, linux-rdma@vger.kernel.org
Cc:     Shamir Rabinovitch <srabinov7@gmail.com>
Subject: [PATCH v1 rdma-core 05/12] mlx5: Implementation of import PD callback
Date:   Wed, 21 Aug 2019 17:26:32 +0300
Message-Id: <20190821142639.5807-6-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821142639.5807-1-yuval.shaia@oracle.com>
References: <20190821142639.5807-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908210158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908210158
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The import PD verb take care of importing the generic part of the PD
object and then triggers provider's specific callback to take care of
provider's specific attributes.
Add implementation of mlx5 related PD attributes.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
---
 providers/mlx5/mlx5-abi.h |  2 ++
 providers/mlx5/mlx5.c     |  1 +
 providers/mlx5/mlx5.h     |  2 ++
 providers/mlx5/verbs.c    | 28 ++++++++++++++++++++++++++++
 4 files changed, 33 insertions(+)

diff --git a/providers/mlx5/mlx5-abi.h b/providers/mlx5/mlx5-abi.h
index 2b66e820..1faeb4ba 100644
--- a/providers/mlx5/mlx5-abi.h
+++ b/providers/mlx5/mlx5-abi.h
@@ -85,6 +85,8 @@ DECLARE_DRV_CMD(mlx5_query_device_ex, IB_USER_VERBS_EX_CMD_QUERY_DEVICE,
 		empty, mlx5_ib_query_device_resp);
 DECLARE_DRV_CMD(mlx5_modify_qp_ex, IB_USER_VERBS_EX_CMD_MODIFY_QP,
 		empty, mlx5_ib_modify_qp_resp);
+DECLARE_DRV_CMD(mlx5_import_pd, IB_USER_VERBS_CMD_IMPORT_PD,
+		empty, mlx5_ib_alloc_pd_resp);
 
 struct mlx5_modify_qp {
 	struct ibv_modify_qp_ex		ibv_cmd;
diff --git a/providers/mlx5/mlx5.c b/providers/mlx5/mlx5.c
index 291e7ee0..c16b30b3 100644
--- a/providers/mlx5/mlx5.c
+++ b/providers/mlx5/mlx5.c
@@ -91,6 +91,7 @@ static const struct verbs_context_ops mlx5_ctx_common_ops = {
 	.alloc_pd      = mlx5_alloc_pd,
 	.async_event   = mlx5_async_event,
 	.dealloc_pd    = mlx5_free_pd,
+	.import_pd     = mlx5_import_pd,
 	.reg_mr	       = mlx5_reg_mr,
 	.rereg_mr      = mlx5_rereg_mr,
 	.dereg_mr      = mlx5_dereg_mr,
diff --git a/providers/mlx5/mlx5.h b/providers/mlx5/mlx5.h
index ab3c2c1a..06e2b471 100644
--- a/providers/mlx5/mlx5.h
+++ b/providers/mlx5/mlx5.h
@@ -816,6 +816,8 @@ int mlx5_query_port(struct ibv_context *context, uint8_t port,
 
 struct ibv_pd *mlx5_alloc_pd(struct ibv_context *context);
 int mlx5_free_pd(struct ibv_pd *pd);
+struct ibv_pd *mlx5_import_pd(struct ibv_context *context, uint32_t fd,
+			      uint32_t handle);
 
 void mlx5_async_event(struct ibv_context *context,
 		      struct ibv_async_event *event);
diff --git a/providers/mlx5/verbs.c b/providers/mlx5/verbs.c
index 714c5f7e..3d2510c3 100644
--- a/providers/mlx5/verbs.c
+++ b/providers/mlx5/verbs.c
@@ -178,6 +178,34 @@ struct ibv_pd *mlx5_alloc_pd(struct ibv_context *context)
 	return &pd->ibv_pd;
 }
 
+struct ibv_pd *mlx5_import_pd(struct ibv_context *context, uint32_t fd,
+			      uint32_t handle)
+{
+	struct ibv_import_pd cmd = {
+		.handle = handle,
+		.type = UVERBS_OBJECT_PD,
+		.fd = fd,
+	};
+	struct mlx5_import_pd_resp resp;
+	struct mlx5_pd *pd;
+	int ret;
+
+	pd = calloc(1, sizeof(*pd));
+	if (!pd)
+		return NULL;
+
+	ret = ibv_cmd_import_pd(context, &pd->ibv_pd, &cmd, sizeof(cmd),
+				&resp.ibv_resp, sizeof(resp));
+	if (ret) {
+		free(pd);
+		return NULL;
+	}
+
+	pd->pdn = resp.pdn;
+
+	return &pd->ibv_pd;
+}
+
 static void mlx5_put_bfreg_index(struct mlx5_context *ctx, uint32_t bfreg_dyn_index)
 {
 	pthread_mutex_lock(&ctx->dyn_bfregs_mutex);
-- 
2.20.1

