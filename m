Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD0C36AE4F
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2019 20:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388328AbfGPSPR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jul 2019 14:15:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38416 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388184AbfGPSPQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Jul 2019 14:15:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GIEZ8A120215;
        Tue, 16 Jul 2019 18:15:00 GMT
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2tq7xqx4m5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:15:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GICW8e027515;
        Tue, 16 Jul 2019 18:15:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2tq4du2uvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:15:00 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6GIEwOD025321;
        Tue, 16 Jul 2019 18:14:58 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 18:14:58 +0000
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
Subject: [PATCH 25/25] IB/uverbs: Add MR import verb
Date:   Tue, 16 Jul 2019 21:12:00 +0300
Message-Id: <20190716181200.4239-26-srabinov7@gmail.com>
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

Implementation of new verb which enable to import ib_mr object.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 79 ++++++++++++++++++++++++++++
 include/uapi/rdma/ib_user_verbs.h    |  1 +
 2 files changed, 80 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 229fc8e48391..e1da443f05ff 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3891,6 +3891,15 @@ static void ib_uverbs_clone_ib_pd(union ib_uverbs_import_fr_fd_resp *resp,
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
@@ -3957,6 +3966,74 @@ static int ib_uverbs_import_ib_pd(struct uverbs_attr_bundle *attrs)
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
@@ -3969,6 +4046,8 @@ static int ib_uverbs_import_fr_fd(struct uverbs_attr_bundle *attrs)
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

