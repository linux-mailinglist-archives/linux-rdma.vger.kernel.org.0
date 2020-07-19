Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987B8224FDF
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jul 2020 08:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgGSGDa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Jul 2020 02:03:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgGSGDa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 19 Jul 2020 02:03:30 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC8A520738;
        Sun, 19 Jul 2020 06:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595138610;
        bh=1jzLaoyxyefP6rWLrwe+WJakkCHxRk5aypLj89T5Wy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AOtIarOzND6rGAmcdIPDZrgK7wbsAcMQhoVxZ9vMijcJpx5OsWw7xsACe3gmYnht/
         rD8PuUDPzqV0XenqkPJRsfn4t6eeMB4L2YV+4CgynlXkcEHoCNApq8pg4mD14XTXnQ
         mBzIts/GdHc8YpqHXm9zi8R1xFXLRl6xyTv3QkMs=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        kernel test robot <lkp@intel.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 1/2] RDMA/uverbs: Remove redundant assignments
Date:   Sun, 19 Jul 2020 09:03:18 +0300
Message-Id: <20200719060319.77603-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200719060319.77603-1-leon@kernel.org>
References: <20200719060319.77603-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The kbuild reported the following warning, so clean whole uverbs_cmd.c file.

   drivers/infiniband/core/uverbs_cmd.c:1066:6: warning: Variable 'ret'
is reassigned a value before the old one has
been used. [redundantAssignment]
    ret = uverbs_request(attrs, &cmd, sizeof(cmd));
        ^
   drivers/infiniband/core/uverbs_cmd.c:1064:0: note: Variable 'ret' is
reassigned a value before the old one has been
used.
    int    ret = -EINVAL;
   ^

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index a66fc3e37a74..7d2b4258f573 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -558,9 +558,9 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
 	struct ib_uverbs_open_xrcd	cmd;
 	struct ib_uxrcd_object         *obj;
 	struct ib_xrcd                 *xrcd = NULL;
-	struct fd			f = {NULL, 0};
+	struct fd f = {};
 	struct inode                   *inode = NULL;
-	int				ret = 0;
+	int ret;
 	int				new_xrcd = 0;
 	struct ib_device *ib_dev;
 
@@ -761,7 +761,7 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_rereg_mr      cmd;
 	struct ib_uverbs_rereg_mr_resp resp;
-	struct ib_pd                *pd = NULL;
+	struct ib_pd *pd;
 	struct ib_mr                *mr;
 	struct ib_pd		    *old_pd;
 	int                          ret;
@@ -1059,7 +1059,7 @@ static int ib_uverbs_resize_cq(struct uverbs_attr_bundle *attrs)
 	struct ib_uverbs_resize_cq	cmd;
 	struct ib_uverbs_resize_cq_resp	resp = {};
 	struct ib_cq			*cq;
-	int				ret = -EINVAL;
+	int ret;
 
 	ret = uverbs_request(attrs, &cmd, sizeof(cmd));
 	if (ret)
@@ -1504,7 +1504,7 @@ static int ib_uverbs_open_qp(struct uverbs_attr_bundle *attrs)
 	struct ib_uverbs_open_qp        cmd;
 	struct ib_uqp_object           *obj;
 	struct ib_xrcd		       *xrcd;
-	struct ib_uobject	       *uninitialized_var(xrcd_uobj);
+	struct ib_uobject *xrcd_uobj;
 	struct ib_qp                   *qp;
 	struct ib_qp_open_attr          attr = {};
 	int ret;
@@ -3286,7 +3286,7 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
 	struct ib_usrq_object           *obj;
 	struct ib_pd                    *pd;
 	struct ib_srq                   *srq;
-	struct ib_uobject               *uninitialized_var(xrcd_uobj);
+	struct ib_uobject *xrcd_uobj;
 	struct ib_srq_init_attr          attr;
 	int ret;
 	struct ib_device *ib_dev;
-- 
2.26.2

