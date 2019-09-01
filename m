Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70F24A4AB8
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Sep 2019 18:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfIAQw3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 1 Sep 2019 12:52:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48104 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbfIAQw3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 1 Sep 2019 12:52:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x81Gn7ox178813;
        Sun, 1 Sep 2019 16:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=W7/pUu22+A8c1nExIS3YuA36jEctFTpHfpteDc9MWXI=;
 b=M/qvPR644GS4hZM3pfwFt/orbheAgGDXCIM+TmOxhwTYNLLO1skUUDrT6Y6rjA1G5mbT
 0OUNXX2AoXZMhQxpOsMdaDou3lK0DE6XDAwnNLSkLc8HZms0CR1w2EAtnVeuHESEkre4
 G9KM4yPMmGLrTeeXmiue9wvCAgbItkcClGQHCRKVnPQRRsC2EvGasilo3XeJ/uQ4QQ+W
 YuhbDk+4T4NmLvTcrvTaF/Y7Y4vFaH8uO+uou9Vt9C0n68FdJu4bEL99IL2ftDNYet1p
 IOA1UvM50sWUsEzHb3k0PtObnt0w5m7M2j8/jKdr58wMZOXn4h4zN+sZm2G314v6DEaK fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2urhst00a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Sep 2019 16:51:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x81Gn14G171632;
        Sun, 1 Sep 2019 16:51:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2uqey7pb03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Sep 2019 16:51:43 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x81Gpfl5007184;
        Sun, 1 Sep 2019 16:51:42 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 01 Sep 2019 09:51:41 -0700
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
Subject: [PATCH v3 4/5] IB/{core,hw}: ib_pd should not have ib_uobject pointer
Date:   Sun,  1 Sep 2019 19:51:07 +0300
Message-Id: <20190901165108.11518-5-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190901165108.11518-1-yuval.shaia@oracle.com>
References: <20190901165108.11518-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9367 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909010192
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9367 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909010192
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

