Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35A6A97CB3
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 16:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbfHUOX6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 10:23:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40094 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbfHUOX6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Aug 2019 10:23:58 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LENW83086763;
        Wed, 21 Aug 2019 14:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=fNlWbrKfg81SqvFGiyhtRRDnDGEnlnD2h+oOjjo45jw=;
 b=p3yziPv2eKEpAWBdL+IODg1H+iDvOZ0VeFmh9J91UKdrssYSULC2DdCystnFcpG88IRP
 Ll8GpgidqHI+lygaSdxNfBuL65jwVG3uwFSJ4S8MZ1vMVMIUXb9JwKxvoln91ZwsPrkc
 jdrqYxRHQOsv12GSfWBeuhxUZTOTJTRgp2bLS8+kr98+4MBkdS05XchQabw8KqLuCofx
 5CaKsIOBsdR8t04hrQqOowHqCKutqtoJQi2yLz0dALaREAi/roQQfOoWiAaVOiIgJzCr
 6xXAPM0L5oSU0RXHD7Z4zKEF1eUqVTJk/rVAvQ6fLnTA3IVI6hVqmzILnzM7eRSOisL6 tQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2uea7qwxrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:23:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LEMq9e017101;
        Wed, 21 Aug 2019 14:23:32 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2uh2q4jwvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:23:32 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7LENPKJ011373;
        Wed, 21 Aug 2019 14:23:25 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Aug 2019 07:23:25 -0700
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
Subject: [PATCH v1 18/24] IB/core: ib_mr should not have ib_uobject pointer
Date:   Wed, 21 Aug 2019 17:21:19 +0300
Message-Id: <20190821142125.5706-19-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821142125.5706-1-yuval.shaia@oracle.com>
References: <20190821142125.5706-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908210158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908210158
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

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
index 08f39adb3a9d..25eab9dc9cad 100644
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
index 1d0215c1a504..a7722d54869e 100644
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
index e3ce38aa89b6..877932305ea7 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1785,7 +1785,6 @@ struct ib_mr {
 	enum ib_mr_type	   type;
 	bool		   need_inval;
 	union {
-		struct ib_uobject	*uobject;	/* user */
 		struct list_head	qp_entry;	/* FR */
 	};
 
@@ -2592,6 +2591,7 @@ struct ib_device_ops {
 
 	/* Object sharing callbacks */
 	clone_callback(ib_pd);
+	clone_callback(ib_mr);
 
 	DECLARE_RDMA_OBJ_SIZE(ib_ah);
 	DECLARE_RDMA_OBJ_SIZE(ib_cq);
@@ -2610,6 +2610,7 @@ static inline int trivial_clone_##ib_type(struct ib_udata *udata,	\
 
 /* Shared IB HW object support */
 trivial_clone_callback(ib_pd);
+trivial_clone_callback(ib_mr);
 
 struct ib_core_device {
 	/* device must be the first element in structure until,
-- 
2.20.1

