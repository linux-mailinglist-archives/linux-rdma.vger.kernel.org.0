Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45A0A6AE37
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2019 20:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388345AbfGPSNV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jul 2019 14:13:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36610 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387949AbfGPSNV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Jul 2019 14:13:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GI9G9w115477;
        Tue, 16 Jul 2019 18:13:01 GMT
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2tq7xqx4ar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:13:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GICcvn114710;
        Tue, 16 Jul 2019 18:13:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2tq6mn1mpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:13:00 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6GICxvB024080;
        Tue, 16 Jul 2019 18:12:59 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 18:12:58 +0000
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
Subject: [PATCH 05/25] IB/core: ib_uobject need HW object reference count
Date:   Tue, 16 Jul 2019 21:11:40 +0300
Message-Id: <20190716181200.4239-6-srabinov7@gmail.com>
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

This new refcnt will points to the refcnt member of the HW object and will
behaves as expected by refcnt, i.e. will be increased and decreased as a
result of usage changes and will destroy the object when reaches to zero.
For a non-shared object refcnt will remain NULL.

Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
---
 drivers/infiniband/core/rdma_core.c | 23 +++++++++++++++++++++--
 include/rdma/ib_verbs.h             |  7 +++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index ccf4d069c25c..651625f632d7 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -516,7 +516,26 @@ static int __must_check destroy_hw_idr_uobject(struct ib_uobject *uobj,
 	const struct uverbs_obj_idr_type *idr_type =
 		container_of(uobj->uapi_object->type_attrs,
 			     struct uverbs_obj_idr_type, type);
-	int ret = idr_type->destroy_object(uobj, why, attrs);
+	static DEFINE_MUTEX(lock);
+	int ret, count;
+
+	mutex_lock(&lock);
+
+	if (uobj->refcnt) {
+		count = atomic_dec_return(uobj->refcnt);
+		WARN_ON(count < 0); /* use after free! */
+		if (count) {
+			mutex_unlock(&lock);
+			goto skip;
+		}
+	}
+
+	ret = idr_type->destroy_object(uobj, why, attrs);
+
+	if (ret)
+		atomic_inc(uobj->refcnt);
+
+	mutex_unlock(&lock);
 
 	/*
 	 * We can only fail gracefully if the user requested to destroy the
@@ -525,7 +544,7 @@ static int __must_check destroy_hw_idr_uobject(struct ib_uobject *uobj,
 	 */
 	if (ib_is_destroy_retryable(ret, why, uobj))
 		return ret;
-
+skip:
 	if (why == RDMA_REMOVE_ABORT)
 		return 0;
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 0900952d9b1f..d19c0394b05a 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1444,6 +1444,13 @@ struct ib_uobject {
 	struct rcu_head		rcu;		/* kfree_rcu() overhead */
 
 	const struct uverbs_api_object *uapi_object;
+
+	/*
+	 * ib_X HW object sharing support
+	 * - NULL for HW objects that are not shareable
+	 * - Pointer to ib_X reference counter for shareable HW objects
+	 */
+	atomic_t	       *refcnt;		/* ib_X object ref count */
 };
 
 struct ib_udata {
-- 
2.20.1

