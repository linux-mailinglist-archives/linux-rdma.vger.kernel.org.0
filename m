Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C090C6AE39
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2019 20:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfGPSN1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jul 2019 14:13:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42856 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388036AbfGPSN1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Jul 2019 14:13:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GI9Qb5108132;
        Tue, 16 Jul 2019 18:13:12 GMT
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2tq6qtp8mq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:13:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GICULp136925;
        Tue, 16 Jul 2019 18:13:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2tsctwcc1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:13:11 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6GIDA54030687;
        Tue, 16 Jul 2019 18:13:10 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 18:13:10 +0000
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
Subject: [PATCH 07/25] IB/uverbs: Add context import lock/unlock helper
Date:   Tue, 16 Jul 2019 21:11:42 +0300
Message-Id: <20190716181200.4239-8-srabinov7@gmail.com>
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

The lock/unlock helpers will be used in every import verb.

Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
---
 drivers/infiniband/core/uverbs.h      |  2 +
 drivers/infiniband/core/uverbs_cmd.c  | 73 +++++++++++++++++++++++++++
 drivers/infiniband/core/uverbs_main.c |  1 +
 3 files changed, 76 insertions(+)

diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
index 1e5aeb39f774..cf76336cb460 100644
--- a/drivers/infiniband/core/uverbs.h
+++ b/drivers/infiniband/core/uverbs.h
@@ -163,6 +163,8 @@ struct ib_uverbs_file {
 	struct page *disassociate_page;
 
 	struct xarray		idr;
+
+	struct file	       *filp;
 };
 
 struct ib_uverbs_event {
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 4f42f9732dca..21f0a1a986f4 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -43,6 +43,7 @@
 
 #include <rdma/uverbs_types.h>
 #include <rdma/uverbs_std_types.h>
+#include <rdma/uverbs_ioctl.h>
 #include "rdma_core.h"
 
 #include "uverbs.h"
@@ -3791,6 +3792,78 @@ static void uverbs_init_attrs_ufile(struct uverbs_attr_bundle *attrs_bundle,
 	};
 }
 
+/* ib_uverbs_import_lock - Function which gathers code that is
+ *	common in the import verbs.
+ *
+ *	This function guarntee that both source and destination files are
+ *	protected from race with vfs close. The current file is protected
+ *	from such race because verb is executed in a system-call context.
+ *	The other file is protected by 'fget'. This function also ensures
+ *	that ib_uobject identified by the type & handle is locked for read.
+ *
+ *	Callers of this helper must also call ib_uverbs_import_unlock
+ *	to undo any locking performed by this helper.
+ */
+static int ib_uverbs_import_lock(struct uverbs_attr_bundle *attrs,
+				 int fd, u16 type, u32 handle,
+				 struct ib_uobject **uobj,
+				 struct file **filep,
+				 struct ib_uverbs_file **ufile)
+{
+	struct ib_uverbs_file *file = attrs->ufile;
+	struct ib_uverbs_device *dev = file->device;
+	struct uverbs_attr_bundle fd_attrs;
+	struct ib_uverbs_device *fd_dev;
+	int ret = 0;
+
+	*filep = fget(fd);
+	if (!*filep)
+		return -EINVAL;
+
+	/* check uverbs ops exist */
+	if ((*filep)->f_op != file->filp->f_op) {
+		ret = -EINVAL;
+		goto file;
+	}
+
+	*ufile = (*filep)->private_data;
+	fd_dev = (*ufile)->device;
+
+	/* check that both files belong to same ib_device */
+	if (dev != fd_dev) {
+		ret = -EINVAL;
+		goto file;
+	}
+
+	uverbs_init_attrs_ufile(&fd_attrs, *ufile);
+
+	*uobj = uobj_get_read(type, handle, &fd_attrs);
+	if (IS_ERR(*uobj)) {
+		ret = -EINVAL;
+		goto file;
+	}
+
+	/* verify ib_object is shareable */
+	if (!(*uobj)->refcnt) {
+		ret = -EINVAL;
+		goto uobj;
+	}
+
+	return 0;
+uobj:
+	uobj_put_read(*uobj);
+file:
+	fput(*filep);
+	return ret;
+}
+
+static void ib_uverbs_import_unlock(struct ib_uobject *uobj,
+				    struct file *filep)
+{
+	uobj_put_read(uobj);
+	fput(filep);
+}
+
 /*
  * Describe the input structs for write(). Some write methods have an input
  * only struct, most have an input and output. If the struct has an output then
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 11c13c1381cf..fa88a586284c 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -1091,6 +1091,7 @@ static int ib_uverbs_open(struct inode *inode, struct file *filp)
 	mutex_init(&file->umap_lock);
 	INIT_LIST_HEAD(&file->umaps);
 
+	file->filp = filp;
 	filp->private_data = file;
 	list_add_tail(&file->list, &dev->uverbs_file_list);
 	mutex_unlock(&dev->lists_mutex);
-- 
2.20.1

