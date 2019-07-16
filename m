Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC766AE3C
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2019 20:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388366AbfGPSNg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jul 2019 14:13:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36902 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388036AbfGPSNg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Jul 2019 14:13:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GI9U60115848;
        Tue, 16 Jul 2019 18:13:20 GMT
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2tq7xqx4c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:13:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GICmej148845;
        Tue, 16 Jul 2019 18:13:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2tq5bcjeu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:13:19 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6GIDG9d024284;
        Tue, 16 Jul 2019 18:13:17 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 18:13:16 +0000
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
Subject: [PATCH 08/25] IB/uverbs: ufile must be freed only when not used anymore
Date:   Tue, 16 Jul 2019 21:11:43 +0300
Message-Id: <20190716181200.4239-9-srabinov7@gmail.com>
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

ufile (&ucontext) with the process who own them must not be released
when there are other ufile (&ucontext) that depens at them.

Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
---
 drivers/infiniband/core/rdma_core.c   | 29 +++++++++++++++++++++++++++
 drivers/infiniband/core/uverbs.h      | 22 ++++++++++++++++++++
 drivers/infiniband/core/uverbs_cmd.c  | 16 +++++++++++++++
 drivers/infiniband/core/uverbs_main.c |  4 ++++
 4 files changed, 71 insertions(+)

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index 651625f632d7..c81ff8e28fc6 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -841,6 +841,33 @@ static void ufile_destroy_ucontext(struct ib_uverbs_file *ufile,
 	ufile->ucontext = NULL;
 }
 
+static void __uverbs_ufile_refcount(struct ib_uverbs_file *ufile)
+{
+	int wait;
+
+	if (ufile->parent) {
+		pr_debug("%s: release parent ufile. ufile %p parent %p\n",
+			 __func__, ufile, ufile->parent);
+		if (atomic_dec_and_test(&ufile->parent->refcount))
+			complete(&ufile->parent->context_released);
+	}
+
+	if (!atomic_dec_and_test(&ufile->refcount)) {
+wait:
+		wait = wait_for_completion_interruptible_timeout(
+			&ufile->context_released, 3*HZ);
+		if (wait == -ERESTARTSYS) {
+			WARN_ONCE(1,
+			"signal while waiting for context release! ufile %p\n",
+				ufile);
+		} else if (wait == 0) {
+			pr_debug("%s: timeout while waiting for context release! ufile %p\n",
+				 __func__, ufile);
+			goto wait;
+		}
+	}
+}
+
 static int __uverbs_cleanup_ufile(struct ib_uverbs_file *ufile,
 				  enum rdma_remove_reason reason)
 {
@@ -923,6 +950,8 @@ void uverbs_destroy_ufile_hw(struct ib_uverbs_file *ufile,
 	if (!list_empty(&ufile->uobjects))
 		__uverbs_cleanup_ufile(ufile, reason);
 
+	__uverbs_ufile_refcount(ufile);
+
 	ufile_destroy_ucontext(ufile, reason);
 
 done:
diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
index cf76336cb460..c7e711188567 100644
--- a/drivers/infiniband/core/uverbs.h
+++ b/drivers/infiniband/core/uverbs.h
@@ -165,6 +165,28 @@ struct ib_uverbs_file {
 	struct xarray		idr;
 
 	struct file	       *filp;
+
+	/* context sharing support */
+
+	/*
+	 * refcount=1 : zero external context depend on this context
+	 * refcount>1 : (refcount-1) external context depend on this context
+	 */
+	atomic_t		refcount;
+
+	/*
+	 * parent =NULL : this context has not imported any objects
+	 * parent!=NULL : this context imported objects from parent context
+	 */
+	struct ib_uverbs_file  *parent;
+
+	/*
+	 * context_released completion is signalled by the last
+	 * user of this context in case of shared context.
+	 * any pre matured release of the context will be delayed
+	 * till the last user of this context is gone.
+	 */
+	struct completion	context_released;
 };
 
 struct ib_uverbs_event {
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 21f0a1a986f4..8d015587946b 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3816,6 +3816,10 @@ static int ib_uverbs_import_lock(struct uverbs_attr_bundle *attrs,
 	struct ib_uverbs_device *fd_dev;
 	int ret = 0;
 
+	/* shared context cannot import */
+	if (atomic_read(&file->refcount) > 1)
+		return -EINVAL;
+
 	*filep = fget(fd);
 	if (!*filep)
 		return -EINVAL;
@@ -3829,6 +3833,18 @@ static int ib_uverbs_import_lock(struct uverbs_attr_bundle *attrs,
 	*ufile = (*filep)->private_data;
 	fd_dev = (*ufile)->device;
 
+	if (file->parent) {
+		/* multiple import must use same parent context! */
+		if (file->parent != *ufile) {
+			ret = -EINVAL;
+			goto file;
+		}
+	} else {
+		/* first import must update parent refcount */
+		file->parent = *ufile;
+		atomic_inc(&(*ufile)->refcount);
+	}
+
 	/* check that both files belong to same ib_device */
 	if (dev != fd_dev) {
 		ret = -EINVAL;
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index fa88a586284c..3c28034a7a9a 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -1081,6 +1081,10 @@ static int ib_uverbs_open(struct inode *inode, struct file *filp)
 		goto err;
 	}
 
+	/* shared context support */
+	atomic_set(&file->refcount, 1);
+	init_completion(&file->context_released);
+
 	file->device	 = dev;
 	kref_init(&file->ref);
 	mutex_init(&file->ucontext_lock);
-- 
2.20.1

