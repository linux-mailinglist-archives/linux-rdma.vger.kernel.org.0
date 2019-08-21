Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84C9B97C99
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 16:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbfHUOWe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 10:22:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38048 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbfHUOWd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Aug 2019 10:22:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LEEHrL077884;
        Wed, 21 Aug 2019 14:22:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=GppTcegOZNSFGJx1fZ1VJ8VchLWZNXF7yVI4JCwVViI=;
 b=a1l6JjQL3srCpIrankLXfRjpiqTxJXo28adF9cq/IdDuPV48M+YJ9b40i9XhztQBMaaE
 LQUuQkT+wx0TzeNmdnOq1rZrizuU+85cPYtZbR+Iz0suG0FsL2FeVuvQu+AHcwQjeSyr
 UDK/9yXOh0n/LAHB7i+Zu4K5ErjGxAicSCfhwd4y3QKwuz9wuBHRcZSAtjI6a8ROguRy
 hOY1v8FLlrGYBH1YIBs5ToI5xB5zWwLXmDK92Ywe0dzMXe1sPFghiOkuVxXC+HubmSaV
 T2jkUoES8rJE7w4PnXreYur7llRbI/juxLLegdKlIooSzMGNzRDSQ0S6nrtxv7bpbef2 Tg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2uea7qwxh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:22:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LEIV5q182086;
        Wed, 21 Aug 2019 14:22:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2ugj7qgdq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:22:14 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7LEM9oX016984;
        Wed, 21 Aug 2019 14:22:10 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Aug 2019 07:22:09 -0700
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
Subject: [PATCH v1 05/24] IB/core: ib_uobject need HW object reference count
Date:   Wed, 21 Aug 2019 17:21:06 +0300
Message-Id: <20190821142125.5706-6-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821142125.5706-1-yuval.shaia@oracle.com>
References: <20190821142125.5706-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908210157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908210157
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
index 7b429b2e7cf6..7e69866fc419 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1496,6 +1496,13 @@ struct ib_uobject {
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

