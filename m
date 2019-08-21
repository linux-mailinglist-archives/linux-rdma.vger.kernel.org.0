Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF4A797C97
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 16:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbfHUOWZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 10:22:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37864 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729646AbfHUOWY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Aug 2019 10:22:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LEEMAQ077937;
        Wed, 21 Aug 2019 14:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=W7/pUu22+A8c1nExIS3YuA36jEctFTpHfpteDc9MWXI=;
 b=lzS1lkVeiyy0D8ffVo9g1lkKB7rxbaX0MAweWDP7nsupje3+rWZ1T8h0pmLWcMwzlJv1
 /yzKzrLDz/24/mDVRZAbzBHlw4/nqQ6P6QSmPv9oX82Uxu5lohhJHU3Bj+snFSwS4jnF
 mq6Fg7QouH6w5MRZM8rBEpYZDysq+1KFjirKTr2kZ8ePEkwTMPx+QNba4G2JH0aGTpiM
 CdfbzJUNAMA8OghgTUEqGyWP1y5+hElVtKzmSgrft9ZJnJjnuYnTniURFFEKdK1IB35i
 bw64YimlREHnDRbTopn/J6FMqxCyg+BnWedvoO1xQH1YiXQj7VjRSM6CIjUESxGlR91k rA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2uea7qwxfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:22:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LEIY58094263;
        Wed, 21 Aug 2019 14:22:06 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2ugj7py7uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:22:06 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7LEM3J7014627;
        Wed, 21 Aug 2019 14:22:04 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Aug 2019 07:22:03 -0700
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
Subject: [PATCH v1 04/24] IB/{core,hw}: ib_pd should not have ib_uobject pointer
Date:   Wed, 21 Aug 2019 17:21:05 +0300
Message-Id: <20190821142125.5706-5-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821142125.5706-1-yuval.shaia@oracle.com>
References: <20190821142125.5706-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908210157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908210157
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
index f974b6854224..1d0215c1a504 100644
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
index 0ff5f9617639..bd4a09b2ec1e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -760,7 +760,6 @@ static int hns_roce_v1_rsv_lp_qp(struct hns_roce_dev *hr_dev)
 
 	free_mr->mr_free_pd = to_hr_pd(pd);
 	free_mr->mr_free_pd->ibpd.device  = &hr_dev->ib_dev;
-	free_mr->mr_free_pd->ibpd.uobject = NULL;
 	free_mr->mr_free_pd->ibpd.__internal_mr = NULL;
 	atomic_set(&free_mr->mr_free_pd->ibpd.usecnt, 0);
 
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 98e566acb746..93db6d4c7da4 100644
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
index 391499008a22..7b429b2e7cf6 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1509,7 +1509,6 @@ struct ib_pd {
 	u32			local_dma_lkey;
 	u32			flags;
 	struct ib_device       *device;
-	struct ib_uobject      *uobject;
 	atomic_t          	usecnt; /* count all resources */
 
 	u32			unsafe_global_rkey;
-- 
2.20.1

