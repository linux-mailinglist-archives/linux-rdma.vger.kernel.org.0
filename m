Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6378A6AE6A
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2019 20:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387949AbfGPSTu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jul 2019 14:19:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42548 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbfGPSTu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Jul 2019 14:19:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GIIsi9124183;
        Tue, 16 Jul 2019 18:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=kU2pm9mQWxzGSy/A6+2CPJWfcnuq8CNz00LjdFzUeIg=;
 b=E1/cIdR9uxSprwa2pKHFvvhVQR2pF+xut/fzv+XJH/7GIqWHMwC6rezI2ljJFbrnfA/3
 hmFaLFLs+H9coqSeANJoF7LQV6np8lWhNDzX48e3rt1wsQzmiGK19bCtlbKyh0vXUM/C
 J9N3v6kEN+AZ+5DIRLCGCMQ5are4nrJfXzSxQrg43quANejJ6D9LD97NY+SjG9idUinx
 BaqI6NFibN8bBebR9D04R2OpNJho6sdRtJ+F0lqnZ6827Z9sMfyR5t87HG9F4kJrAbxI
 VcEeiDqTQZs5H/O/wH5TSrou7AeKoelGeJRok35fnnYPrCtIY/NF/0ksRE1yhYL8LrzS Ww== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2tq7xqx5au-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:19:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GIHqpu038367;
        Tue, 16 Jul 2019 18:19:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2tq4du2wp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:19:24 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6GIJL8b001271;
        Tue, 16 Jul 2019 18:19:21 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 18:19:21 +0000
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
Subject: [PATCH rdma-core 04/12] mlx4: Implementation of import PD callback
Date:   Tue, 16 Jul 2019 21:18:32 +0300
Message-Id: <20190716181840.4579-5-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190716181840.4579-1-yuval.shaia@oracle.com>
References: <20190716181840.4579-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907160224
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907160224
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The import PD verb take care of importing the generic part of the PD
object and then triggers provider's specific callback to take care of
provider's specific attributes.
Add implementation of mlx4 related PD attributes.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
---
 providers/mlx4/mlx4-abi.h |  2 ++
 providers/mlx4/mlx4.c     |  1 +
 providers/mlx4/mlx4.h     |  2 ++
 providers/mlx4/verbs.c    | 30 ++++++++++++++++++++++++++++++
 4 files changed, 35 insertions(+)

diff --git a/providers/mlx4/mlx4-abi.h b/providers/mlx4/mlx4-abi.h
index e1d8327e..f43c512d 100644
--- a/providers/mlx4/mlx4-abi.h
+++ b/providers/mlx4/mlx4-abi.h
@@ -70,5 +70,7 @@ DECLARE_DRV_CMD(mlx4_query_device_ex, IB_USER_VERBS_EX_CMD_QUERY_DEVICE,
 		empty, mlx4_uverbs_ex_query_device_resp);
 DECLARE_DRV_CMD(mlx4_resize_cq, IB_USER_VERBS_CMD_RESIZE_CQ,
 		mlx4_ib_resize_cq, empty);
+DECLARE_DRV_CMD(mlx4_import_pd, IB_USER_VERBS_CMD_IMPORT_PD,
+		empty, mlx4_ib_alloc_pd_resp);
 
 #endif /* MLX4_ABI_H */
diff --git a/providers/mlx4/mlx4.c b/providers/mlx4/mlx4.c
index 0afe59ca..62ea5539 100644
--- a/providers/mlx4/mlx4.c
+++ b/providers/mlx4/mlx4.c
@@ -86,6 +86,7 @@ static const struct verbs_context_ops mlx4_ctx_ops = {
 	.query_port    = mlx4_query_port,
 	.alloc_pd      = mlx4_alloc_pd,
 	.dealloc_pd    = mlx4_free_pd,
+	.import_pd     = mlx4_import_pd,
 	.reg_mr	       = mlx4_reg_mr,
 	.rereg_mr      = mlx4_rereg_mr,
 	.dereg_mr      = mlx4_dereg_mr,
diff --git a/providers/mlx4/mlx4.h b/providers/mlx4/mlx4.h
index 9c21d775..0f6e6ecf 100644
--- a/providers/mlx4/mlx4.h
+++ b/providers/mlx4/mlx4.h
@@ -316,6 +316,8 @@ int mlx4_query_rt_values(struct ibv_context *context,
 			 struct ibv_values_ex *values);
 struct ibv_pd *mlx4_alloc_pd(struct ibv_context *context);
 int mlx4_free_pd(struct ibv_pd *pd);
+struct ibv_pd *mlx4_import_pd(struct ibv_context *context, uint32_t fd,
+			      uint32_t handle);
 struct ibv_xrcd *mlx4_open_xrcd(struct ibv_context *context,
 				struct ibv_xrcd_init_attr *attr);
 int mlx4_close_xrcd(struct ibv_xrcd *xrcd);
diff --git a/providers/mlx4/verbs.c b/providers/mlx4/verbs.c
index 9a5affe7..fd8d396f 100644
--- a/providers/mlx4/verbs.c
+++ b/providers/mlx4/verbs.c
@@ -41,6 +41,8 @@
 
 #include <util/mmio.h>
 
+#include <rdma/ib_user_ioctl_cmds.h>
+
 #include "mlx4.h"
 #include "mlx4-abi.h"
 
@@ -237,6 +239,34 @@ int mlx4_free_pd(struct ibv_pd *pd)
 	return 0;
 }
 
+struct ibv_pd *mlx4_import_pd(struct ibv_context *context, uint32_t fd,
+			      uint32_t handle)
+{
+	struct ibv_import_pd cmd = {
+		.handle = handle,
+		.type = UVERBS_OBJECT_PD,
+		.fd = fd,
+	};
+	struct mlx4_import_pd_resp resp;
+	struct mlx4_pd *pd;
+	int ret;
+
+	pd = malloc(sizeof(*pd));
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
 struct ibv_xrcd *mlx4_open_xrcd(struct ibv_context *context,
 				struct ibv_xrcd_init_attr *attr)
 {
-- 
2.20.1

