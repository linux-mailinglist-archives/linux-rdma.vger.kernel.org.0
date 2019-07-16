Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9606AE71
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2019 20:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388361AbfGPSUU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jul 2019 14:20:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43024 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbfGPSUU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Jul 2019 14:20:20 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GIIsd7124175;
        Tue, 16 Jul 2019 18:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=taw/wT9sGKi1wvgSDjwi+h6OvcmdLIraq6CUyKqq2W0=;
 b=Y+Vb+bAlfCWdZaP942yEix3haFYV4qVrxpsH5rv/0o7t0wgT+eDmew+8RIW/kQJ0mMti
 k2TkvTK3n5gVUhDtLVyKxYIdYDH0ufpVbtSlcf0TdNuRTDqyguRGiH7ERnLp8NhU3ctA
 NKfQSgQG/kJGc47DotVbZ15fHQ+f6BpJUMKEYTlR52fOYsY9YV/r9aVBcP4sfr0GocrN
 DTXWyF+OgTJDA5ok1TucqPdGba2oS+R0zD+Rp/Ds4M+egYwEgu+z2s8Fxh1M+1yuosUL
 FbGh4gizMuZ+Z/arVMuwNRwSYN+xBG7NuIETYmkN9x7LXbBkEc3xjmpQij8xWecCo+Yo CA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2tq7xqx5cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:19:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GIHpFx149751;
        Tue, 16 Jul 2019 18:19:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2tsctwcgs3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:19:52 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6GIJpKO003317;
        Tue, 16 Jul 2019 18:19:51 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 18:19:51 +0000
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
Subject: [PATCH rdma-core 09/12] mlx4: Implementation of import MR callback
Date:   Tue, 16 Jul 2019 21:18:37 +0300
Message-Id: <20190716181840.4579-10-yuval.shaia@oracle.com>
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
Add implementation of mlx4 related MR attributes.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
---
 providers/mlx4/mlx4.c  |  1 +
 providers/mlx4/mlx4.h  |  2 ++
 providers/mlx4/verbs.c | 26 ++++++++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/providers/mlx4/mlx4.c b/providers/mlx4/mlx4.c
index 62ea5539..40935ca0 100644
--- a/providers/mlx4/mlx4.c
+++ b/providers/mlx4/mlx4.c
@@ -86,6 +86,7 @@ static const struct verbs_context_ops mlx4_ctx_ops = {
 	.query_port    = mlx4_query_port,
 	.alloc_pd      = mlx4_alloc_pd,
 	.dealloc_pd    = mlx4_free_pd,
+	.import_mr     = mlx4_import_mr,
 	.import_pd     = mlx4_import_pd,
 	.reg_mr	       = mlx4_reg_mr,
 	.rereg_mr      = mlx4_rereg_mr,
diff --git a/providers/mlx4/mlx4.h b/providers/mlx4/mlx4.h
index 0f6e6ecf..fc06317c 100644
--- a/providers/mlx4/mlx4.h
+++ b/providers/mlx4/mlx4.h
@@ -316,6 +316,8 @@ int mlx4_query_rt_values(struct ibv_context *context,
 			 struct ibv_values_ex *values);
 struct ibv_pd *mlx4_alloc_pd(struct ibv_context *context);
 int mlx4_free_pd(struct ibv_pd *pd);
+struct ibv_mr *mlx4_import_mr(struct ibv_context *context, uint32_t fd,
+			      uint32_t handle);
 struct ibv_pd *mlx4_import_pd(struct ibv_context *context, uint32_t fd,
 			      uint32_t handle);
 struct ibv_xrcd *mlx4_open_xrcd(struct ibv_context *context,
diff --git a/providers/mlx4/verbs.c b/providers/mlx4/verbs.c
index fd8d396f..ab1efa67 100644
--- a/providers/mlx4/verbs.c
+++ b/providers/mlx4/verbs.c
@@ -239,6 +239,32 @@ int mlx4_free_pd(struct ibv_pd *pd)
 	return 0;
 }
 
+struct ibv_mr *mlx4_import_mr(struct ibv_context *context, uint32_t fd,
+			      uint32_t handle)
+{
+	struct ibv_import_mr cmd = {
+		.handle = handle,
+		.type = UVERBS_OBJECT_MR,
+		.fd = fd,
+	};
+	struct ib_uverbs_import_fr_fd_resp resp;
+	struct verbs_mr *vmr;
+	int ret;
+
+	vmr = calloc(1, sizeof(*vmr));
+	if (!vmr)
+		return NULL;
+
+	ret = ibv_cmd_import_mr(context, vmr, &cmd, sizeof(cmd), &resp,
+				sizeof(resp));
+	if (ret) {
+		free(vmr);
+		return NULL;
+	}
+
+	return &vmr->ibv_mr;
+}
+
 struct ibv_pd *mlx4_import_pd(struct ibv_context *context, uint32_t fd,
 			      uint32_t handle)
 {
-- 
2.20.1

