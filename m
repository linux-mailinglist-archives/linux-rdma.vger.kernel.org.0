Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0C56AE47
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2019 20:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfGPSOk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jul 2019 14:14:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44056 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbfGPSOj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Jul 2019 14:14:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GIEPXd112506;
        Tue, 16 Jul 2019 18:14:25 GMT
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2tq6qtp8t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:14:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GICafU148526;
        Tue, 16 Jul 2019 18:14:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2tq5bcjf73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:14:24 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6GIENuA021768;
        Tue, 16 Jul 2019 18:14:23 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 18:14:23 +0000
From:   Shamir Rabinovitch <srabinov7@gmail.com>
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
Subject: [PATCH 19/25] IB/core: ib_mr should not have ib_uobject pointer
Date:   Tue, 16 Jul 2019 21:11:54 +0300
Message-Id: <20190716181200.4239-20-srabinov7@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190716181200.4239-1-srabinov7@gmail.com>
References: <20190716181200.4239-1-srabinov7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907160223
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1034
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907160223
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yuval Shaia <yuval.shaia@oracle.com>

As a preparation step to shared MR, where ib_mr object will be pointed
by one or more ib_uobjects, remove ib_uobject pointer from ib_mr struct.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 drivers/infiniband/core/uverbs_cmd.c          | 1 -
 drivers/infiniband/core/uverbs_std_types_mr.c | 1 -
 drivers/infiniband/core/verbs.c               | 3 ---
 include/rdma/ib_verbs.h                       | 3 ++-
 4 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 9c73c7b10f8d..dc1ffcf44ee5 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -765,7 +765,6 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 	mr->type    = IB_MR_TYPE_USER;
 	mr->dm	    = NULL;
 	mr->sig_attrs = NULL;
-	mr->uobject = uobj;
 	atomic_inc(&pd->usecnt);
 	mr->res.type = RDMA_RESTRACK_MR;
 	rdma_restrack_uadd(&mr->res);
diff --git a/drivers/infiniband/core/uverbs_std_types_mr.c b/drivers/infiniband/core/uverbs_std_types_mr.c
index c1286a52dc84..5219af8960a3 100644
--- a/drivers/infiniband/core/uverbs_std_types_mr.c
+++ b/drivers/infiniband/core/uverbs_std_types_mr.c
@@ -130,7 +130,6 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DM_MR_REG)(
 	mr->pd      = pd;
 	mr->type    = IB_MR_TYPE_DM;
 	mr->dm      = dm;
-	mr->uobject = uobj;
 	atomic_inc(&pd->usecnt);
 	atomic_inc(&dm->usecnt);
 
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 56341f514914..854d71bd2bf9 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -299,7 +299,6 @@ struct ib_pd *__ib_alloc_pd(struct ib_device *device, unsigned int flags,
 		mr->device	= pd->device;
 		mr->pd		= pd;
 		mr->type        = IB_MR_TYPE_DMA;
-		mr->uobject	= NULL;
 		mr->need_inval	= false;
 
 		pd->__internal_mr = mr;
@@ -2035,7 +2034,6 @@ struct ib_mr *ib_alloc_mr_user(struct ib_pd *pd, enum ib_mr_type mr_type,
 		mr->device  = pd->device;
 		mr->pd      = pd;
 		mr->dm      = NULL;
-		mr->uobject = NULL;
 		atomic_inc(&pd->usecnt);
 		mr->need_inval = false;
 		mr->res.type = RDMA_RESTRACK_MR;
@@ -2088,7 +2086,6 @@ struct ib_mr *ib_alloc_mr_integrity(struct ib_pd *pd,
 	mr->device = pd->device;
 	mr->pd = pd;
 	mr->dm = NULL;
-	mr->uobject = NULL;
 	atomic_inc(&pd->usecnt);
 	mr->need_inval = false;
 	mr->res.type = RDMA_RESTRACK_MR;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 320c4b31ef68..0ff2732794c9 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1733,7 +1733,6 @@ struct ib_mr {
 	enum ib_mr_type	   type;
 	bool		   need_inval;
 	union {
-		struct ib_uobject	*uobject;	/* user */
 		struct list_head	qp_entry;	/* FR */
 	};
 
@@ -2540,6 +2539,7 @@ struct ib_device_ops {
 
 	/* Object sharing callbacks */
 	clone_callback(ib_pd);
+	clone_callback(ib_mr);
 
 	DECLARE_RDMA_OBJ_SIZE(ib_ah);
 	DECLARE_RDMA_OBJ_SIZE(ib_cq);
@@ -2558,6 +2558,7 @@ static inline int trivial_clone_##ib_type(struct ib_udata *udata,	\
 
 /* Shared IB HW object support */
 trivial_clone_callback(ib_pd);
+trivial_clone_callback(ib_mr);
 
 struct ib_core_device {
 	/* device must be the first element in structure until,
-- 
2.20.1

