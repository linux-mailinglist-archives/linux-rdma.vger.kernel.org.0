Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21D369FC29
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2019 09:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfH1Hq3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Aug 2019 03:46:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45848 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfH1Hq2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Aug 2019 03:46:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7S7hg15135405;
        Wed, 28 Aug 2019 07:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=/uKWKfZKHxnopONxtzqg6DLer8B2DFebpi3V4z54eiA=;
 b=haO332dSH58RDaLGQS6w1BIzsRtyIu3YadQoh7WQi49QF7QyTbR0uaQ5czFTPfs/y8/c
 nooTPNtZXjKhxXN9uQ/m0YRqlV2wljiU77P7qLMjKIDNr6+mwGjJuoTPvjUnawkhzgsY
 r0xXmMRsbcM6arVYMCmiuwlrW5tiY/6DsnsOnDUq3rJPryHaDIvwvDtC2OUL+cmq8TcA
 IRcW8x1iW1Ou0tUF2LbDGeO5P0/DCIhyg4Aq/l7G9cafdRsDIebAwSe3oWENr8/ivrFq
 /h6Ly5pdzxSm/AJcP3kKOOLYHNvKPBDNMlrFefvfdGKM22AGCCp2EweFbpZhBhOmtHTy 3w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2unnbhg2c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 07:46:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7S7cKCO158971;
        Wed, 28 Aug 2019 07:42:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2undupmrvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 07:42:18 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7S7gI13016674;
        Wed, 28 Aug 2019 07:42:18 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Aug 2019 00:42:18 -0700
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     dledford@redhat.com, jgg@ziepe.ca, oulijun@huawei.com,
        xavier.huwei@huawei.com, leon@kernel.org, majd@mellanox.com,
        markz@mellanox.com, swise@opengridcomputing.com,
        galpress@amazon.com, monis@mellanox.com, israelr@mellanox.com,
        maxg@mellanox.com, dan.carpenter@oracle.com, kamalheib1@gmail.com,
        yuval.shaia@oracle.com, denisd@mellanox.com, yuvalav@mellanox.com,
        dennis.dalessandro@intel.com, ereza@mellanox.com, will@kernel.org,
        linux-rdma@vger.kernel.org, jgg@mellanox.com, srabinov7@gmail.com,
        santosh.shilimkar@oracle.com
Subject: [PATCH 4/4] IB/core: ib_mr should not have ib_uobject pointer
Date:   Wed, 28 Aug 2019 10:41:34 +0300
Message-Id: <20190828074134.17042-5-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828074134.17042-1-yuval.shaia@oracle.com>
References: <20190828074134.17042-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908280080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908280081
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
 include/rdma/ib_verbs.h                       | 1 -
 4 files changed, 6 deletions(-)

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
index 7b429b2e7cf6..fc4b1a0d3bf2 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1775,7 +1775,6 @@ struct ib_mr {
 	enum ib_mr_type	   type;
 	bool		   need_inval;
 	union {
-		struct ib_uobject	*uobject;	/* user */
 		struct list_head	qp_entry;	/* FR */
 	};
 
-- 
2.20.1

