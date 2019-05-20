Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC60822D74
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 09:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbfETH4N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 03:56:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55834 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfETH4M (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 May 2019 03:56:12 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4K7mwTw147851;
        Mon, 20 May 2019 07:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=zhxeM4NX34yaGh6ZsqB9EUSRge3c56Du+vnsazWZ6os=;
 b=GbqBF4ZDOIBMvW6UmX6jcxJ6lLGQLa004TNd/gjtxMsSEza98NjgnRJ0nVIzW6+u21MD
 PyIxYqBPRRwOOqoyJbCH/vJ9ET5kYLMiIboR+qHPVLsBWRy8HJtog5Ch54d7/NW4Sgaa
 +WVDWVQZ451yw/omsc4+1aL0XX6Wo0gvFkynY79G5bEAziJSdzVOs1sKUsebf5z6ZpPk
 1WNJwkro1trlY6/vX6Q1K1guxImhrUjaFGxIgnj6kC4mqP9Euhqe191LGsp3l9NDL49o
 pfbhn5YkF2CRQafIjyfd9ZKmC3w9MIpJFZtHNoHlTM0DSPipWR1A1rno/tmAKBB+93Bw LA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2sj9ft57fm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 07:55:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4K7tYmJ123311;
        Mon, 20 May 2019 07:55:40 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2skbphnhrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 07:55:40 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4K7tdfS028869;
        Mon, 20 May 2019 07:55:39 GMT
Received: from srabinov-laptop.nl.oracle.com (/10.175.35.172)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 May 2019 07:55:39 +0000
From:   Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
To:     dledford@redhat.com, jgg@mellanox.com, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     shamir.rabinovitch@oracle.com, Jason Gunthorpe <jgg@ziepe.ca>,
        Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>,
        Gal Pressman <galpress@amazon.com>,
        Kamal Heib <kamalheib1@gmail.com>,
        Denis Drozdov <denisd@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Erez Alfasi <ereza@mellanox.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH for-next v2 4/4] IB/{core,hw}: ib_pd should not have ib_uobject pointer
Date:   Mon, 20 May 2019 10:53:21 +0300
Message-Id: <20190520075333.6002-5-shamir.rabinovitch@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520075333.6002-1-shamir.rabinovitch@oracle.com>
References: <20190520075333.6002-1-shamir.rabinovitch@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9262 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905200057
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9262 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905200057
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

future patches will add the ability to share ib_pd across multiple
ib_ucontext. given that, ib_pd will be pointed by 1 or more ib_uobject.
thus, having ib_uobject pointer in ib_pd is incorrect.

Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
---
 drivers/infiniband/core/uverbs_cmd.c       | 1 -
 drivers/infiniband/core/verbs.c            | 1 -
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 1 -
 drivers/infiniband/hw/mlx5/main.c          | 1 -
 drivers/infiniband/hw/mthca/mthca_qp.c     | 3 ++-
 include/rdma/ib_verbs.h                    | 1 -
 6 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index a850424ae184..696b22921962 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -421,7 +421,6 @@ static int ib_uverbs_alloc_pd(struct uverbs_attr_bundle *attrs)
 	}
 
 	pd->device  = ib_dev;
-	pd->uobject = uobj;
 	pd->__internal_mr = NULL;
 	atomic_set(&pd->usecnt, 0);
 	pd->res.type = RDMA_RESTRACK_PD;
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index e666a1f7608d..495f2b176bf2 100644
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
index 26d4ed447bea..b272af6d2e46 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -755,7 +755,6 @@ static int hns_roce_v1_rsv_lp_qp(struct hns_roce_dev *hr_dev)
 
 	free_mr->mr_free_pd = to_hr_pd(pd);
 	free_mr->mr_free_pd->ibpd.device  = &hr_dev->ib_dev;
-	free_mr->mr_free_pd->ibpd.uobject = NULL;
 	free_mr->mr_free_pd->ibpd.__internal_mr = NULL;
 	atomic_set(&free_mr->mr_free_pd->ibpd.usecnt, 0);
 
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 687f99172037..605eb1968868 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4880,7 +4880,6 @@ static int create_dev_resources(struct mlx5_ib_resources *devr)
 		return -ENOMEM;
 
 	devr->p0->device  = ibdev;
-	devr->p0->uobject = NULL;
 	atomic_set(&devr->p0->usecnt, 0);
 
 	ret = mlx5_ib_alloc_pd(devr->p0, NULL);
diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index 6d3a00d28e90..bd4db577cb8a 100644
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
index 0742095355f2..74cd31df1b32 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1581,7 +1581,6 @@ struct ib_pd {
 	u32			local_dma_lkey;
 	u32			flags;
 	struct ib_device       *device;
-	struct ib_uobject      *uobject;
 	atomic_t          	usecnt; /* count all resources */
 
 	u32			unsafe_global_rkey;
-- 
2.20.1

