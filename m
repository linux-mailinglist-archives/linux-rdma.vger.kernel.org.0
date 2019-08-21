Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D60A797CC4
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 16:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbfHUOYd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 10:24:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40946 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbfHUOYb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Aug 2019 10:24:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LENVYu086699;
        Wed, 21 Aug 2019 14:24:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=RfAdhnost4bMej9JuUi7DlfUHMtpa23/Q9xe2PERx28=;
 b=ERps7v3Qre3rQaAM2A7q9qeNYF0rJlijSFucP/Gt3QL92joaGb0C+e78BJBUJEqfYT5M
 njiwT1hNehozJmWpEoI+gfHsSWyLJtXj5SZCDDFwpPzk7b000+ty4x4BhXF464KPY6sY
 Sm2pMr5NT63UkePNDd8BlUqabKUZ3nt5OwUeM04WnsMYOQoW1d0Y7UE6OrZP653bHRh7
 9bap4c4HnVWT1ZgsDsdJCO9Lu7+Dq68zXDwXLFPqWLhKT/aqgZZK5Zse6bv2YDxOJkE0
 cdLJyaER2LywPyfZTy8GzH1rXB6mr4jP3wEu+KMAPoGbFQx8GYgH68WXHBfZqcKLz7sG 8g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2uea7qwxwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:24:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LENRIc194596;
        Wed, 21 Aug 2019 14:24:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2ugj7qgfbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:24:02 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7LEO0kS015958;
        Wed, 21 Aug 2019 14:24:00 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Aug 2019 07:24:00 -0700
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
Subject: [PATCH v1 24/24] IB/uverbs: Add MR import verb
Date:   Wed, 21 Aug 2019 17:21:25 +0300
Message-Id: <20190821142125.5706-25-yuval.shaia@oracle.com>
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

Implementation of new verb which enable to import ib_mr object.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 79 ++++++++++++++++++++++++++++
 include/uapi/rdma/ib_user_verbs.h    |  1 +
 2 files changed, 80 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 92f04e7360b6..5aaa6a7e129f 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3875,6 +3875,15 @@ static void ib_uverbs_clone_ib_pd(union ib_uverbs_import_fr_fd_resp *resp,
 	resp->alloc_pd.pd_handle = handle;
 }
 
+static void ib_uverbs_clone_ib_mr(union ib_uverbs_import_fr_fd_resp *resp,
+				  struct ib_mr *mr,
+				  __u32 handle)
+{
+	resp->reg_mr.lkey = mr->lkey;
+	resp->reg_mr.rkey = mr->rkey;
+	resp->reg_mr.mr_handle = handle;
+}
+
 static int ib_uverbs_import_ib_pd(struct uverbs_attr_bundle *attrs)
 {
 	union ib_uverbs_import_fr_fd_resp resp = {0};
@@ -3941,6 +3950,74 @@ static int ib_uverbs_import_ib_pd(struct uverbs_attr_bundle *attrs)
 	return ret;
 }
 
+static int ib_uverbs_import_ib_mr(struct uverbs_attr_bundle *attrs)
+{
+	union ib_uverbs_import_fr_fd_resp resp = {0};
+	struct ib_uobject *src_uobj = NULL;
+	struct ib_uobject *dst_uobj = NULL;
+	struct ib_uverbs_import_fr_fd cmd;
+	struct ib_uverbs_file *src_file;
+	struct ib_device *ibdev;
+	struct ib_mr *mr;
+	struct file *filep;
+	int ret;
+
+	ret = uverbs_request(attrs, &cmd, sizeof(cmd));
+	if (ret)
+		return ret;
+
+	ret = ib_uverbs_import_lock(attrs, cmd.fd, UVERBS_OBJECT_MR,
+				    cmd.handle, &src_uobj, &filep,
+				    &src_file);
+	if (ret)
+		return ret;
+
+	mr = src_uobj->object;
+
+	dst_uobj = uobj_alloc(UVERBS_OBJECT_MR, attrs, &ibdev);
+	if (IS_ERR(dst_uobj)) {
+		ret = -ENOMEM;
+		goto uobj;
+	}
+
+	if (!ibdev->ops.clone_ib_mr) {
+		ret = -EINVAL;
+		goto uobj;
+	}
+
+	dst_uobj->object = src_uobj->object;
+	dst_uobj->refcnt = src_uobj->refcnt;
+
+	if (WARN_ON(!atomic_inc_not_zero(src_uobj->refcnt))) {
+		ret = -EINVAL;
+		goto uobj;
+	}
+
+	ret = ibdev->ops.clone_ib_mr(&attrs->driver_udata, mr);
+	if (ret)
+		goto uobj;
+
+	ib_uverbs_clone_ib_mr(&resp, dst_uobj->object, dst_uobj->id);
+
+	ret = uverbs_response(attrs, &resp, sizeof(resp));
+	if (ret)
+		goto uobj;
+
+	ret = uobj_alloc_commit(dst_uobj, attrs);
+
+	ib_uverbs_import_unlock(src_uobj, filep);
+
+	return ret;
+
+uobj:
+	ib_uverbs_import_unlock(src_uobj, filep);
+
+	if (!IS_ERR_OR_NULL(dst_uobj))
+		uobj_alloc_abort(dst_uobj, attrs);
+
+	return ret;
+}
+
 static int ib_uverbs_import_fr_fd(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_import_fr_fd cmd;
@@ -3953,6 +4030,8 @@ static int ib_uverbs_import_fr_fd(struct uverbs_attr_bundle *attrs)
 	switch (cmd.type) {
 	case UVERBS_OBJECT_PD:
 		return ib_uverbs_import_ib_pd(attrs);
+	case UVERBS_OBJECT_MR:
+		return ib_uverbs_import_ib_mr(attrs);
 	}
 
 	return -EINVAL;
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index 4274c40bcff8..cfd1a734d5f3 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -1311,6 +1311,7 @@ struct ib_uverbs_import_fr_fd {
 
 union ib_uverbs_import_fr_fd_resp {
 	struct ib_uverbs_alloc_pd_resp alloc_pd;
+	struct ib_uverbs_reg_mr_resp reg_mr;
 };
 
 #define IB_DEVICE_NAME_MAX 64
-- 
2.20.1

