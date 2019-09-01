Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0D58A4AB7
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Sep 2019 18:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbfIAQwL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 1 Sep 2019 12:52:11 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51892 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbfIAQwL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 1 Sep 2019 12:52:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x81GnjmR189843;
        Sun, 1 Sep 2019 16:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=VeuuSbgJsr3vMgQxGcoLtEHGK4EpQvKS9cPP2SYHtwI=;
 b=W5LMBy3zpMFzJkJ/J0VOOP/E8hAe0pmtIc9bZRsnbpanaLZ9MxES/a6bSHsIwQLxJUGX
 DJ67FZhlzQLJ29DD3S2m5UCCLVBmsPOW0OOXX+6zJ3O0+oXa5Ipos+uLYTsKnIINuulS
 0xQ5YVwPyTWQIftkQCMNf4owBlqatGM0vZTBALJTuPSLASVP/SLj85dFDqi+bf2uudUR
 It5Crry+6p/KIFqmCmfdB2sbzzHDhIig05hnsm5V6s+qxcXI0irCvSkMbW+5RZoiqeKl
 XasEZ4ypMBfqEVQlseWHamJB5qbvm0SnnNWl1hCO1fb3LHc787B1zcOxQiLYNPJIBeUY vg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2urht5r07w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Sep 2019 16:51:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x81Gn14J171632;
        Sun, 1 Sep 2019 16:51:48 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2uqey7pb0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Sep 2019 16:51:48 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x81GpkKf007197;
        Sun, 1 Sep 2019 16:51:47 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 01 Sep 2019 09:51:46 -0700
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
Subject: [PATCH v3 5/5] IB/core: ib_mr should not have ib_uobject pointer
Date:   Sun,  1 Sep 2019 19:51:08 +0300
Message-Id: <20190901165108.11518-6-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190901165108.11518-1-yuval.shaia@oracle.com>
References: <20190901165108.11518-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9367 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909010192
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9367 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909010192
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
 include/rdma/ib_verbs.h                       | 5 +----
 4 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index d1f0c04f0ae8..54326ee25eaa 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -761,7 +761,6 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
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
index 7b429b2e7cf6..7abe25bbe281 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1774,10 +1774,7 @@ struct ib_mr {
 	unsigned int	   page_size;
 	enum ib_mr_type	   type;
 	bool		   need_inval;
-	union {
-		struct ib_uobject	*uobject;	/* user */
-		struct list_head	qp_entry;	/* FR */
-	};
+	struct list_head	qp_entry;	/* FR */
 
 	struct ib_dm      *dm;
 	struct ib_sig_attrs *sig_attrs; /* only for IB_MR_TYPE_INTEGRITY MRs */
-- 
2.20.1

