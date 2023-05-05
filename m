Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F225F6F7B93
	for <lists+linux-rdma@lfdr.de>; Fri,  5 May 2023 05:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjEEDeG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 May 2023 23:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEEDeF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 May 2023 23:34:05 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593E1F4;
        Thu,  4 May 2023 20:34:04 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4QCGWG6D18z8RTWl;
        Fri,  5 May 2023 11:34:02 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl1.zte.com.cn with SMTP id 3453Xumv053050;
        Fri, 5 May 2023 11:33:56 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Fri, 5 May 2023 11:33:57 +0800 (CST)
Date:   Fri, 5 May 2023 11:33:57 +0800 (CST)
X-Zmail-TransId: 2afa64547925ffffffff8df-fa29f
X-Mailer: Zmail v1.0
Message-ID: <202305051133576690069@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <jgg@ziepe.ca>
Cc:     <leon@kernel.org>, <jiangjian@cdjrlc.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBSRE1BL2NvcmU6IFVzZSBmZGdldCgpIGFuZCBmZHB1dCgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 3453Xumv053050
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6454792A.000/4QCGWG6D18z8RTWl
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Ye Xingchen <ye.xingchen@zte.com.cn>

convert the fget()/fput() uses to fdget()/fdput().

Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 drivers/infiniband/core/rdma_core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index 29b1ab1d5f93..c35df0b27e86 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -335,7 +335,7 @@ lookup_get_fd_uobject(const struct uverbs_api_object *obj,
 		      enum rdma_lookup_mode mode)
 {
 	const struct uverbs_obj_fd_type *fd_type;
-	struct file *f;
+	struct fd f = fdget(fdno);
 	struct ib_uobject *uobject;
 	int fdno = id;

@@ -350,18 +350,17 @@ lookup_get_fd_uobject(const struct uverbs_api_object *obj,
 	fd_type =
 		container_of(obj->type_attrs, struct uverbs_obj_fd_type, type);

-	f = fget(fdno);
-	if (!f)
+	if (!f.file)
 		return ERR_PTR(-EBADF);

-	uobject = f->private_data;
+	uobject = f.file->private_data;
 	/*
 	 * fget(id) ensures we are not currently running
 	 * uverbs_uobject_fd_release(), and the caller is expected to ensure
 	 * that release is never done while a call to lookup is possible.
 	 */
-	if (f->f_op != fd_type->fops || uobject->ufile != ufile) {
-		fput(f);
+	if (f.file->f_op != fd_type->fops || uobject->ufile != ufile) {
+		fdput(f);
 		return ERR_PTR(-EBADF);
 	}

-- 
2.25.1
