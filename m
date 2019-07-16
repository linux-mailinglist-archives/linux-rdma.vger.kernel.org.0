Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 243096AE36
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2019 20:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfGPSNL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jul 2019 14:13:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42590 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388346AbfGPSNL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Jul 2019 14:13:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GI9aRk108197;
        Tue, 16 Jul 2019 18:12:55 GMT
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2tq6qtp8jn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:12:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GICV6O027488;
        Tue, 16 Jul 2019 18:12:55 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2tq4du2u33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:12:55 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6GICrRQ030495;
        Tue, 16 Jul 2019 18:12:53 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 18:12:50 +0000
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
Cc:     Shamir Rabinovitch <srabinov7@gmail.com>
Subject: [PATCH 04/25] IB/{core,hw}: ib_pd should not have ib_uobject pointer
Date:   Tue, 16 Jul 2019 21:11:39 +0300
Message-Id: <20190716181200.4239-5-srabinov7@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190716181200.4239-1-srabinov7@gmail.com>
References: <20190716181200.4239-1-srabinov7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907160223
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1034
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907160222
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>

As a preparation step to shared PD, where ib_pd object will be pointed
by one or more ib_uobjects, remove ib_uobject pointer from ib_pd struct.

Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
---
 drivers/infiniband/core/uverbs_cmd.c       | 1 -
 drivers/infiniband/core/verbs.c            | 1 -
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 1 -
 drivers/infiniband/hw/mlx5/main.c          | 1 -
 drivers/infiniband/hw/mthca/mthca_qp.c     | 3 ++-
 include/rdma/ib_verbs.h                    | 1 -
 6 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 204a93305f1c..d1f0c04f0ae8 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -432,7 +432,6 @@ static int ib_uverbs_alloc_pd(struct uverbs_attr_bundle *attrs)
 	}
 
 	pd->device  = ib_dev;
-	pd->uobject = uobj;
 	pd->__internal_mr = NULL;
 	atomic_set(&pd->usecnt, 0);
 	pd->res.type = RDMA_RESTRACK_PD;
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 92349bf37589..56341f514914 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -263,7 +263,6 @@ struct ib_pd *__ib_alloc_pd(struct ib_device *device, unsigned int flags,
 		return ERR_PTR(-ENOMEM);
 
 	pd->device = device;
-	pd->uobject = NULL;
 	pd->__internal_mr = NULL;
 	atomic_set(&pd->usecnt, 0);
 	pd->flags = flags;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 1a2c7dad2a0d..247f8939914c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -760,7 +760,6 @@ static int hns_roce_v1_rsv_lp_qp(struct hns_roce_dev *hr_dev)
 
 	free_mr->mr_free_pd = to_hr_pd(pd);
 	free_mr->mr_free_pd->ibpd.device  = &hr_dev->ib_dev;
-	free_mr->mr_free_pd->ibpd.uobject = NULL;
 	free_mr->mr_free_pd->ibpd.__internal_mr = NULL;
 	atomic_set(&free_mr->mr_free_pd->ibpd.usecnt, 0);
 
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index c2a5780cb394..34378acb28d4 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4937,7 +4937,6 @@ static int create_dev_resources(struct mlx5_ib_resources *devr)
 		return -ENOMEM;
 
 	devr->p0->device  = ibdev;
-	devr->p0->uobject = NULL;
 	atomic_set(&devr->p0->usecnt, 0);
 
 	ret = mlx5_ib_alloc_pd(devr->p0, NULL);
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index d04c245359eb..b1a9169e3af6 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -956,7 +956,8 @@ static int mthca_max_data_size(struct mthca_dev *dev, struct mthca_qp *qp, int d
 static inline int mthca_max_inline_data(struct mthca_pd *pd, int max_data_size)
 {
 	/* We don't support inline data for kernel QPs (yet). */
-	return pd->ibpd.uobject ? max_data_size - MTHCA_INLINE_HEADER_SIZE : 0;
+	return !rdma_is_kernel_res(&pd->ibpd.res) ?
+		max_data_size - MTHCA_INLINE_HEADER_SIZE : 0;
 }
 
 static void mthca_adjust_qp_caps(struct mthca_dev *dev,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index c5f8a9f17063..0900952d9b1f 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1457,7 +1457,6 @@ struct ib_pd {
 	u32			local_dma_lkey;
 	u32			flags;
 	struct ib_device       *device;
-	struct ib_uobject      *uobject;
 	atomic_t          	usecnt; /* count all resources */
 
 	u32			unsafe_global_rkey;
-- 
2.20.1

