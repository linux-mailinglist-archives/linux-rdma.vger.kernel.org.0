Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAD959FE3B
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2019 11:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfH1JQZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Aug 2019 05:16:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55300 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfH1JQZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Aug 2019 05:16:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7S994LP020631;
        Wed, 28 Aug 2019 09:16:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=W7/pUu22+A8c1nExIS3YuA36jEctFTpHfpteDc9MWXI=;
 b=WQAcdN/pcKY3sx0g3IvVfRjivisfnmRUHVFwPOHbrPjdc0B7ST/oCv1cvevr3BkXhVvt
 acaO5GezlStUq1fGmwiZnLjzxb6qhDZGZOMzUDjPl0WOvC2nB+oExuxnaIFjayy/lvGQ
 TU70thEqeJDHabR7uixok052bH08ntb2EFG6dLYNtj5VeMxTr5cIky4LxJfbhS0loVMU
 sTwsC5/Ls5uPUDdo0ep++gJZGiMcWp9o3gqZGAdMS/bGgKMc1rN/0qqAO33Ho18jgDS5
 sCj2C4yZEQaTGCXAAZnupEhxvoHie8Z8LXgjH4YNWXJtuJsgKEKkdhg2YKgUFL9wTlRV Ig== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2unnbhgp31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 09:16:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7S997aV184460;
        Wed, 28 Aug 2019 09:16:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2undw77qad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 09:16:01 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7S9G19u002789;
        Wed, 28 Aug 2019 09:16:01 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Aug 2019 02:16:01 -0700
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     dledford@redhat.com, jgg@ziepe.ca, oulijun@huawei.com,
        xavier.huwei@huawei.com, leon@kernel.org, parav@mellanox.com,
        markz@mellanox.com, swise@opengridcomputing.com,
        galpress@amazon.com, israelr@mellanox.com, monis@mellanox.com,
        maxg@mellanox.com, kamalheib1@gmail.com, yuval.shaia@oracle.com,
        denisd@mellanox.com, yuvalav@mellanox.com,
        dennis.dalessandro@intel.com, ereza@mellanox.com, will@kernel.org,
        linux-rdma@vger.kernel.org, jgg@mellanox.com, srabinov7@gmail.com,
        santosh.shilimkar@oracle.com
Cc:     Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Subject: [PATCH v1 3/5] IB/{core,hw}: ib_pd should not have ib_uobject pointer
Date:   Wed, 28 Aug 2019 12:15:31 +0300
Message-Id: <20190828091533.3129-4-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828091533.3129-1-yuval.shaia@oracle.com>
References: <20190828091533.3129-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908280098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908280098
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

