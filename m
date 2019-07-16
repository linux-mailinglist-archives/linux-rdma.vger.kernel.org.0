Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 071256AE6C
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2019 20:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388310AbfGPSUA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jul 2019 14:20:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42712 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbfGPSUA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Jul 2019 14:20:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GIIotj124139;
        Tue, 16 Jul 2019 18:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=pngtMV6x0h6HWpQL4+Dyy/Ibs4L6R30SUfrpPtO61Ts=;
 b=M8tZO0Eu2P4k+0fp/5mLr/B1JkBGhWFz3ksDmTDYEW8kh3oMKF2Z87tC5ykOrNzwqrtD
 5nwXo76qhYIcYtKHWfrLOw3LaDKCk4IulCM1NyyzWcsHvi2sTdToqLavtTufc/wfUr70
 /qkf8nIbvHLEKVwGnjXy8SvUcjw97YKsSucsXmxh6lWNYdOITroW9S6cPMISWZ53sNkX
 YIAHaD660ZRVpg6q2QjsTkGfT0qVSmi3LRzhgDZA//sv4TCHnqQZeloszflKeqEG47v2
 Wq3SFWlOAh3gmoZJDnSDufza0gpV4TXX0Zr6ng0H6kabmFYsf6aA5f1LBCFm7Xglzh3K MA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2tq7xqx5bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:19:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GIHpjV149741;
        Tue, 16 Jul 2019 18:19:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2tsctwcgjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:19:33 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6GIJXPx024651;
        Tue, 16 Jul 2019 18:19:33 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 18:19:32 +0000
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
Subject: [PATCH rdma-core 06/12] rxe: Implementation of import PD callback
Date:   Tue, 16 Jul 2019 21:18:34 +0300
Message-Id: <20190716181840.4579-7-yuval.shaia@oracle.com>
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
Add implementation of mlx5 related PD attributes.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
---
 providers/rxe/rxe-abi.h |  2 ++
 providers/rxe/rxe.c     | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/providers/rxe/rxe-abi.h b/providers/rxe/rxe-abi.h
index b4680a24..1b1d7248 100644
--- a/providers/rxe/rxe-abi.h
+++ b/providers/rxe/rxe-abi.h
@@ -49,5 +49,7 @@ DECLARE_DRV_CMD(urxe_modify_srq, IB_USER_VERBS_CMD_MODIFY_SRQ,
 		rxe_modify_srq_cmd, empty);
 DECLARE_DRV_CMD(urxe_resize_cq, IB_USER_VERBS_CMD_RESIZE_CQ,
 		empty, rxe_resize_cq_resp);
+DECLARE_DRV_CMD(urxe_import_pd, IB_USER_VERBS_CMD_IMPORT_PD,
+		empty, ib_uverbs_alloc_pd_resp);
 
 #endif /* RXE_ABI_H */
diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
index 2efb646c..6a8194a4 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -49,6 +49,7 @@
 #include <pthread.h>
 #include <stddef.h>
 
+#include <rdma/ib_user_ioctl_cmds.h>
 #include <infiniband/driver.h>
 #include <infiniband/verbs.h>
 
@@ -111,6 +112,32 @@ static struct ibv_pd *rxe_alloc_pd(struct ibv_context *context)
 	return pd;
 }
 
+static struct ibv_pd *rxe_import_pd(struct ibv_context *context, uint32_t fd,
+				    uint32_t handle)
+{
+	struct ibv_import_pd cmd = {
+		.handle = handle,
+		.type = UVERBS_OBJECT_PD,
+		.fd = fd,
+	};
+	struct urxe_import_pd_resp resp;
+	struct ibv_pd *pd;
+	int ret;
+
+	pd = calloc(1, sizeof(*pd));
+	if (!pd)
+		return NULL;
+
+	ret = ibv_cmd_import_pd(context, pd, &cmd, sizeof(cmd), &resp.ibv_resp,
+				sizeof(resp));
+	if (ret) {
+		free(pd);
+		return NULL;
+	}
+
+	return pd;
+}
+
 static int rxe_dealloc_pd(struct ibv_pd *pd)
 {
 	int ret;
@@ -835,6 +862,7 @@ static const struct verbs_context_ops rxe_ctx_ops = {
 	.query_port = rxe_query_port,
 	.alloc_pd = rxe_alloc_pd,
 	.dealloc_pd = rxe_dealloc_pd,
+	.import_pd = rxe_import_pd,
 	.reg_mr = rxe_reg_mr,
 	.dereg_mr = rxe_dereg_mr,
 	.create_cq = rxe_create_cq,
-- 
2.20.1

