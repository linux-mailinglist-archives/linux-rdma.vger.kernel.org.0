Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 483E497C9F
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 16:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbfHUOWu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 10:22:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60270 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbfHUOWu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Aug 2019 10:22:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LEEFbx062990;
        Wed, 21 Aug 2019 14:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=Bw5rBVMtFc/wy4cPAyGoP+bM791bvmcREz2jMYPokbQ=;
 b=G5QAXBhhZbet9kbUtQvhJT/6pQqBXXaD91waaKbRUrHMTeaHz5z1ujJZ5NYP9/ECNchn
 AqmL4cD74Z67lfRwl1ngRMnf1uMUCyg9xAUXAVuln1VRZhdc8zwFpXBz+kYICu2lu7Mb
 Cu5xidsdkw4pycHRwtjsE6uSmXPEL6Y64shF1nGXFOKfO+qvnlLwWEuTC5zQbCItvFnc
 k64eHfCD5Gcdg2OrHT7CPke4IDQFMZERkwbM82wLgIcUln3sT36RtbmpPTjIyHNkumVK
 s7rx2+MTKHVfB0O/HO2mJnuQicwoKF54SAVf2JBIjsAo9l1Ec5HFxltgqxNGJ9/isaMG ZA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2ue90tp3u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:22:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LEI5uh001562;
        Wed, 21 Aug 2019 14:22:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2uh2q4jvq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:22:24 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7LEMMxm031044;
        Wed, 21 Aug 2019 14:22:22 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Aug 2019 07:22:21 -0700
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
Subject: [PATCH v1 07/24] IB/uverbs: Add context import lock/unlock helper
Date:   Wed, 21 Aug 2019 17:21:08 +0300
Message-Id: <20190821142125.5706-8-yuval.shaia@oracle.com>
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
index 02b57240176c..e42a9b5c38b2 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -1095,6 +1095,7 @@ static int ib_uverbs_open(struct inode *inode, struct file *filp)
 	mutex_init(&file->umap_lock);
 	INIT_LIST_HEAD(&file->umaps);
 
+	file->filp = filp;
 	filp->private_data = file;
 	list_add_tail(&file->list, &dev->uverbs_file_list);
 	mutex_unlock(&dev->lists_mutex);
-- 
2.20.1

