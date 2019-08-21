Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 217BB97CEC
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 16:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbfHUO2U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 10:28:20 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40158 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbfHUO2U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Aug 2019 10:28:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LENWGx071690;
        Wed, 21 Aug 2019 14:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=kvOfN0B/wXgfdBbnvAiqnUduYetF9SZ+iTehEmRkrGc=;
 b=CB2hYMwfKDqhBbbx7ssurxTegp/JVMwN5Lkfqd+LG5aMmpvDq67BC7b3Mn86tNqKvMZ+
 QolSbOV4egv0QdW3j3JRL6xH0wkuB6Xjg/P9hxILj/D41XIdGESNSEdwioKu493mh0UF
 K7tXj2CcdCR68m7etJ1NpxCIZLLLGL+U6OUHiEnRFWOhhCNrGKrAhOW67e52dwxx6sHr
 YhL6fToyWIlBPfhzIL4BJGxMQDpiBMD3D0Zzgz2z1pC7K1HdqHDJ2i2YdLD9CP3pzi6e
 rtdprFQceZa+F2EjxDx9vFIi1qw7vdZIYCWAMy1/IHqRUqhoAsa3GW8hWWgXGkAjMxGj bg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2ue90tp50f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:28:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LEMY6J115118;
        Wed, 21 Aug 2019 14:28:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2ug26a3gca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:27:59 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7LERwG8018800;
        Wed, 21 Aug 2019 14:27:58 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Aug 2019 07:27:57 -0700
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
Subject: [PATCH v1 rdma-core 10/12] mlx5: Implementation of import MR callback
Date:   Wed, 21 Aug 2019 17:26:37 +0300
Message-Id: <20190821142639.5807-11-yuval.shaia@oracle.com>
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
index 06e2b471..858ae7c2 100644
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
index 3d2510c3..b4964b17 100644
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

