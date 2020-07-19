Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEE3224FC8
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jul 2020 07:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgGSFWj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Jul 2020 01:22:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgGSFWi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 19 Jul 2020 01:22:38 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 664242073E;
        Sun, 19 Jul 2020 05:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595136158;
        bh=O6fSxLX/t3ehh+AuoPSNj36uKFckmymhXwCyF+wQMso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wClGNctUqKZNRjbwahqEKyPBgLqYq7xQeefsRIICjR8JlT3ucIeIQ6ZjSl6EjrEqF
         W2WWEU8+C5zG0pw6KUBgM47/aoI8JS9frzrq3IOXWMVA7hcdG7kaVHuTUw3hmD+cvB
         lBqQh+0FwsxS2orcr3WSyA71ZvbQziK7v2jLHvN4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 1/2] RDMA/core: Align abort/commit object scheme for write() and ioctl() paths
Date:   Sun, 19 Jul 2020 08:22:22 +0300
Message-Id: <20200719052223.75245-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200719052223.75245-1-leon@kernel.org>
References: <20200719052223.75245-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Create same logic flow for write() interface as we have for ioctl()
path by making sure that object is committed or aborted automatically
after HW object creation.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/uverbs_main.c             |  4 ++++
 drivers/infiniband/core/uverbs_std_types_device.c |  7 ++++++-
 include/rdma/uverbs_ioctl.h                       |  1 +
 include/rdma/uverbs_std_types.h                   | 14 ++++++++++++++
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 69e4755cc04b..37794d88b1f3 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -601,6 +601,7 @@ static ssize_t ib_uverbs_write(struct file *filp, const char __user *buf,
 	memset(bundle.attr_present, 0, sizeof(bundle.attr_present));
 	bundle.ufile = file;
 	bundle.context = NULL; /* only valid if bundle has uobject */
+	bundle.uobject = NULL;
 	if (!method_elm->is_ex) {
 		size_t in_len = hdr.in_words * 4 - sizeof(hdr);
 		size_t out_len = hdr.out_words * 4;
@@ -664,6 +665,9 @@ static ssize_t ib_uverbs_write(struct file *filp, const char __user *buf,
 	}
 
 	ret = method_elm->handler(&bundle);
+	if (bundle.uobject)
+		uverbs_finalize_object(bundle.uobject, UVERBS_ACCESS_NEW, true,
+				       !ret, &bundle);
 out_unlock:
 	srcu_read_unlock(&file->device->disassociate_srcu, srcu_key);
 	return (ret) ? : count;
diff --git a/drivers/infiniband/core/uverbs_std_types_device.c b/drivers/infiniband/core/uverbs_std_types_device.c
index 8e58605a17be..75df2094a010 100644
--- a/drivers/infiniband/core/uverbs_std_types_device.c
+++ b/drivers/infiniband/core/uverbs_std_types_device.c
@@ -38,7 +38,12 @@ static int UVERBS_HANDLER(UVERBS_METHOD_INVOKE_WRITE)(
 	    attrs->ucore.outlen < method_elm->resp_size)
 		return -ENOSPC;
 
-	return method_elm->handler(attrs);
+	attrs->uobject = NULL;
+	rc = method_elm->handler(attrs);
+	if (attrs->uobject)
+		uverbs_finalize_object(attrs->uobject, UVERBS_ACCESS_NEW, true,
+				       !rc, attrs);
+	return rc;
 }
 
 DECLARE_UVERBS_NAMED_METHOD(UVERBS_METHOD_INVOKE_WRITE,
diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index 86de10ea30af..db419c8dbd10 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -652,6 +652,7 @@ struct uverbs_attr_bundle {
 	struct ib_udata ucore;
 	struct ib_uverbs_file *ufile;
 	struct ib_ucontext *context;
+	struct ib_uobject *uobject;
 	DECLARE_BITMAP(attr_present, UVERBS_API_ATTR_BKEY_LEN);
 	struct uverbs_attr attrs[];
 };
diff --git a/include/rdma/uverbs_std_types.h b/include/rdma/uverbs_std_types.h
index bf0392ae15eb..8451b19103ee 100644
--- a/include/rdma/uverbs_std_types.h
+++ b/include/rdma/uverbs_std_types.h
@@ -110,6 +110,20 @@ static inline void uobj_alloc_abort(struct ib_uobject *uobj,
 	rdma_alloc_abort_uobject(uobj, attrs, false);
 }
 
+static inline void uobj_finalize_uobj_create(struct ib_uobject *uobj,
+					     struct uverbs_attr_bundle *attrs)
+{
+	/*
+	 * Tell the core code that the write() handler has completed
+	 * initializing the object and that the core should commit or
+	 * abort this object based upon the return code from the write()
+	 * method. Similar to what uverbs_finalize_uobj_create() does for
+	 * ioctl()
+	 */
+	WARN_ON(attrs->uobject);
+	attrs->uobject = uobj;
+}
+
 static inline struct ib_uobject *
 __uobj_alloc(const struct uverbs_api_object *obj,
 	     struct uverbs_attr_bundle *attrs, struct ib_device **ib_dev)
-- 
2.26.2

