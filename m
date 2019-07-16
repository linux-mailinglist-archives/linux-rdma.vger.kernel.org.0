Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9826AE70
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2019 20:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388355AbfGPSUS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jul 2019 14:20:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42994 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbfGPSUS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Jul 2019 14:20:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GIIhIq124109;
        Tue, 16 Jul 2019 18:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=imp+w28Zkh+8fx8L+/kd1wJEUGNQCyQJutoIJLOnh1s=;
 b=xHRop0jUbgVLeneUHyXqD8ffG/3mieKx1dTkxbmbwG+84xh3OHOkr9fOwvE6xYMqA8iI
 NRENxME+PvqbBFChggXejrZNzuZihUBNuoawU/44Ka9aMTCDFG9A+4pBzZcWZVLwEOk2
 r38m0/EamwHzlhwhx6NIK/QsBH//xNZyvcrRl3oZNPwibt0HGQ+ZrVsdurhlXPw+umKE
 WZT9Thlg8+nJpwes23rMd21XULfKdGtG+SN1D5xk++YRsb7sn3H/W822KQhGJGKFSB5J
 kJQFRl6ppDbB55Mq1K+ZkQsQTdb6lgbTs5GIxkz3Qx7OIW9JsffBNPCfszdq9bjnpYJe qw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2tq7xqx5dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:19:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GIHqwa125014;
        Tue, 16 Jul 2019 18:19:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2tq6mn1qff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:19:59 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6GIJvMd001528;
        Tue, 16 Jul 2019 18:19:57 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 18:19:57 +0000
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
Subject: [PATCH rdma-core 10/12] mlx5: Implementation of import MR callback
Date:   Tue, 16 Jul 2019 21:18:38 +0300
Message-Id: <20190716181840.4579-11-yuval.shaia@oracle.com>
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

The import MR verb take care of importing the generic part of the MR
object and then triggers provider's specific callback to take care of
provider's specific attributes.
Add implementation of mlx5 related MR attributes.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
---
 providers/mlx5/mlx5.c  |  1 +
 providers/mlx5/mlx5.h  |  2 ++
 providers/mlx5/verbs.c | 26 ++++++++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/providers/mlx5/mlx5.c b/providers/mlx5/mlx5.c
index c16b30b3..8d1fa232 100644
--- a/providers/mlx5/mlx5.c
+++ b/providers/mlx5/mlx5.c
@@ -91,6 +91,7 @@ static const struct verbs_context_ops mlx5_ctx_common_ops = {
 	.alloc_pd      = mlx5_alloc_pd,
 	.async_event   = mlx5_async_event,
 	.dealloc_pd    = mlx5_free_pd,
+	.import_mr     = mlx5_import_mr,
 	.import_pd     = mlx5_import_pd,
 	.reg_mr	       = mlx5_reg_mr,
 	.rereg_mr      = mlx5_rereg_mr,
diff --git a/providers/mlx5/mlx5.h b/providers/mlx5/mlx5.h
index 19831cee..28eae9cc 100644
--- a/providers/mlx5/mlx5.h
+++ b/providers/mlx5/mlx5.h
@@ -816,6 +816,8 @@ int mlx5_query_port(struct ibv_context *context, uint8_t port,
 
 struct ibv_pd *mlx5_alloc_pd(struct ibv_context *context);
 int mlx5_free_pd(struct ibv_pd *pd);
+struct ibv_mr *mlx5_import_mr(struct ibv_context *context, uint32_t fd,
+			      uint32_t handle);
 struct ibv_pd *mlx5_import_pd(struct ibv_context *context, uint32_t fd,
 			      uint32_t handle);
 
diff --git a/providers/mlx5/verbs.c b/providers/mlx5/verbs.c
index 0f7182e3..d5979170 100644
--- a/providers/mlx5/verbs.c
+++ b/providers/mlx5/verbs.c
@@ -178,6 +178,32 @@ struct ibv_pd *mlx5_alloc_pd(struct ibv_context *context)
 	return &pd->ibv_pd;
 }
 
+struct ibv_mr *mlx5_import_mr(struct ibv_context *context, uint32_t fd,
+			      uint32_t handle)
+{
+	struct ibv_import_mr cmd = {
+		.handle = handle,
+		.type = UVERBS_OBJECT_MR,
+		.fd = fd,
+	};
+	struct ib_uverbs_import_fr_fd_resp resp = {0};
+	struct mlx5_mr *mr;
+	int ret;
+
+	mr = calloc(1, sizeof(*mr));
+	if (!mr)
+		return NULL;
+
+	ret = ibv_cmd_import_mr(context, &mr->vmr, &cmd, sizeof(cmd), &resp,
+				sizeof(resp));
+	if (ret) {
+		free(mr);
+		return NULL;
+	}
+
+	return &mr->vmr.ibv_mr;
+}
+
 struct ibv_pd *mlx5_import_pd(struct ibv_context *context, uint32_t fd,
 			      uint32_t handle)
 {
-- 
2.20.1

