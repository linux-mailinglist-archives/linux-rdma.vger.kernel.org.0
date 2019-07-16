Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A91D6AE43
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2019 20:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388369AbfGPSOP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jul 2019 14:14:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43622 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388107AbfGPSOP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Jul 2019 14:14:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GI9PJG108123;
        Tue, 16 Jul 2019 18:14:00 GMT
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2tq6qtp8rc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:14:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GICUoT027420;
        Tue, 16 Jul 2019 18:13:59 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2tq4du2ueh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:13:59 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6GIDwke021554;
        Tue, 16 Jul 2019 18:13:58 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 18:13:58 +0000
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
Subject: [PATCH 15/25] IB/uverbs: Add PD import verb
Date:   Tue, 16 Jul 2019 21:11:50 +0300
Message-Id: <20190716181200.4239-16-srabinov7@gmail.com>
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
 definitions=main-1907160222
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>

Implementation of new verb which enable to import ib_pd object.

Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 95 ++++++++++++++++++++++++++++
 include/uapi/rdma/ib_user_verbs.h    | 14 ++++
 2 files changed, 109 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 0dd3ec98c739..9c73c7b10f8d 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3883,6 +3883,96 @@ static void ib_uverbs_import_unlock(struct ib_uobject *uobj,
 	fput(filep);
 }
 
+static void ib_uverbs_clone_ib_pd(union ib_uverbs_import_fr_fd_resp *resp,
+				  struct ib_pd *pd,
+				  __u32 handle)
+{
+	resp->alloc_pd.pd_handle = handle;
+}
+
+static int ib_uverbs_import_ib_pd(struct uverbs_attr_bundle *attrs)
+{
+	union ib_uverbs_import_fr_fd_resp resp = {0};
+	struct ib_uobject *src_uobj = NULL;
+	struct ib_uobject *dst_uobj = NULL;
+	struct ib_uverbs_import_fr_fd cmd;
+	struct ib_uverbs_file *src_file;
+	struct ib_device *ibdev;
+	struct ib_pd *pd;
+	struct file *filep;
+	int ret;
+
+	ret = uverbs_request(attrs, &cmd, sizeof(cmd));
+	if (ret)
+		return ret;
+
+	ret = ib_uverbs_import_lock(attrs, cmd.fd, UVERBS_OBJECT_PD,
+				    cmd.handle, &src_uobj, &filep,
+				    &src_file);
+	if (ret)
+		return ret;
+
+	pd = src_uobj->object;
+
+	dst_uobj = uobj_alloc(UVERBS_OBJECT_PD, attrs, &ibdev);
+	if (IS_ERR(dst_uobj)) {
+		ret = -ENOMEM;
+		goto uobj;
+	}
+
+	if (!ibdev->ops.clone_ib_pd) {
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
+	ret = ibdev->ops.clone_ib_pd(&attrs->driver_udata, pd);
+	if (ret)
+		goto uobj;
+
+	ib_uverbs_clone_ib_pd(&resp, dst_uobj->object, dst_uobj->id);
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
+	if (!IS_ERR_OR_NULL(dst_uobj))
+		uobj_alloc_abort(dst_uobj, attrs);
+
+	return ret;
+}
+
+static int ib_uverbs_import_fr_fd(struct uverbs_attr_bundle *attrs)
+{
+	struct ib_uverbs_import_fr_fd cmd;
+	int ret;
+
+	ret = uverbs_request(attrs, &cmd, sizeof(cmd));
+	if (ret)
+		return ret;
+
+	switch (cmd.type) {
+	case UVERBS_OBJECT_PD:
+		return ib_uverbs_import_ib_pd(attrs);
+	}
+
+	return -EINVAL;
+}
+
 /*
  * Describe the input structs for write(). Some write methods have an input
  * only struct, most have an input and output. If the struct has an output then
@@ -4015,6 +4105,11 @@ const struct uapi_definition uverbs_def_write_intf[] = {
 			UAPI_DEF_WRITE_IO(struct ib_uverbs_query_port,
 					  struct ib_uverbs_query_port_resp),
 			UAPI_DEF_METHOD_NEEDS_FN(query_port)),
+		DECLARE_UVERBS_WRITE(
+			IB_USER_VERBS_CMD_IMPORT_FR_FD,
+			ib_uverbs_import_fr_fd,
+			UAPI_DEF_WRITE_IO(struct ib_uverbs_import_fr_fd,
+					  union  ib_uverbs_import_fr_fd_resp)),
 		DECLARE_UVERBS_WRITE_EX(
 			IB_USER_VERBS_EX_CMD_QUERY_DEVICE,
 			ib_uverbs_ex_query_device,
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index 0474c7400268..4274c40bcff8 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -88,6 +88,7 @@ enum ib_uverbs_write_cmds {
 	IB_USER_VERBS_CMD_CLOSE_XRCD,
 	IB_USER_VERBS_CMD_CREATE_XSRQ,
 	IB_USER_VERBS_CMD_OPEN_QP,
+	IB_USER_VERBS_CMD_IMPORT_FR_FD,
 };
 
 enum {
@@ -1299,6 +1300,19 @@ struct ib_uverbs_ex_modify_cq {
 	__u32 reserved;
 };
 
+/* object sharing support */
+struct ib_uverbs_import_fr_fd {
+	__u64 response;
+	__u32 fd;
+	__u32 handle;
+	__u16 type;
+	__u8  reserved[6];
+};
+
+union ib_uverbs_import_fr_fd_resp {
+	struct ib_uverbs_alloc_pd_resp alloc_pd;
+};
+
 #define IB_DEVICE_NAME_MAX 64
 
 #endif /* IB_USER_VERBS_H */
-- 
2.20.1

