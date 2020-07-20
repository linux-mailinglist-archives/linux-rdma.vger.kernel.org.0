Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50AA3226DB3
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jul 2020 19:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389197AbgGTR4g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jul 2020 13:56:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbgGTR4g (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Jul 2020 13:56:36 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DFD122B4E;
        Mon, 20 Jul 2020 17:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595267796;
        bh=qhw0GTQiIfXZ0DhBQqU/OdHCWAtszjxg73deSM2w53Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oUO8fQGfNp6dvXfyWWSR7taG9RCeGR/hPfAiqqRoqKrZ9UTIab9U/grDmD8Lkebuf
         BJE0TeHp0pzMS5k1LplFB6nIgnVJPW4anVbqkBXq5k7cxyUcw2BN0V6b80hurV/ecU
         +BgOMUR3E7O5Rmmmt3ToCCLZDYXSiLfr+taJCFaE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        kernel test robot <lkp@intel.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 1/2] RDMA/uverbs: Remove redundant assignments
Date:   Mon, 20 Jul 2020 20:56:26 +0300
Message-Id: <20200720175627.1273096-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720175627.1273096-1-leon@kernel.org>
References: <20200720175627.1273096-1-leon@kernel.org>
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
 drivers/infiniband/core/uverbs_cmd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index a66fc3e37a74..c36f22ab9bae 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -558,11 +558,11 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
 	struct ib_uverbs_open_xrcd	cmd;
 	struct ib_uxrcd_object         *obj;
 	struct ib_xrcd                 *xrcd = NULL;
-	struct fd			f = {NULL, 0};
 	struct inode                   *inode = NULL;
-	int				ret = 0;
 	int				new_xrcd = 0;
 	struct ib_device *ib_dev;
+	struct fd f = {};
+	int ret;
 
 	ret = uverbs_request(attrs, &cmd, sizeof(cmd));
 	if (ret)
@@ -1059,7 +1059,7 @@ static int ib_uverbs_resize_cq(struct uverbs_attr_bundle *attrs)
 	struct ib_uverbs_resize_cq	cmd;
 	struct ib_uverbs_resize_cq_resp	resp = {};
 	struct ib_cq			*cq;
-	int				ret = -EINVAL;
+	int ret;
 
 	ret = uverbs_request(attrs, &cmd, sizeof(cmd));
 	if (ret)
@@ -1504,10 +1504,10 @@ static int ib_uverbs_open_qp(struct uverbs_attr_bundle *attrs)
 	struct ib_uverbs_open_qp        cmd;
 	struct ib_uqp_object           *obj;
 	struct ib_xrcd		       *xrcd;
-	struct ib_uobject	       *uninitialized_var(xrcd_uobj);
 	struct ib_qp                   *qp;
 	struct ib_qp_open_attr          attr = {};
 	int ret;
+	struct ib_uobject *xrcd_uobj;
 	struct ib_device *ib_dev;
 
 	ret = uverbs_request(attrs, &cmd, sizeof(cmd));
@@ -3286,9 +3286,9 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
 	struct ib_usrq_object           *obj;
 	struct ib_pd                    *pd;
 	struct ib_srq                   *srq;
-	struct ib_uobject               *uninitialized_var(xrcd_uobj);
 	struct ib_srq_init_attr          attr;
 	int ret;
+	struct ib_uobject *xrcd_uobj;
 	struct ib_device *ib_dev;
 
 	obj = (struct ib_usrq_object *)uobj_alloc(UVERBS_OBJECT_SRQ, attrs,
-- 
2.26.2

