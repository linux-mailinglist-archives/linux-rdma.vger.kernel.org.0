Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3902825A797
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 10:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgIBIRN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 04:17:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgIBIRN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Sep 2020 04:17:13 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FAF42087C;
        Wed,  2 Sep 2020 08:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599034633;
        bh=hZfElmrz4UYQHT8B6IK1aT7KtRiA21PizcbjzxgSPdg=;
        h=From:To:Cc:Subject:Date:From;
        b=ChveX6bExmVQ0Ip5QydKByYXZW+4uc33JZl4qmSZcUf6YRk8Xqwsaa7QBSmWoX2NV
         r19DjrGuSGYvK6PFQID2ohH5vOEhosVIiU+XnEH/01BFE0U7Q3yfgVO0T67VXgrK+0
         5rKXxS5oMsPTbsjEzEsJwLvP9+88QLKdqFIOrOk8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/core: Change how failing destroy is handled during uobj abort
Date:   Wed,  2 Sep 2020 11:17:08 +0300
Message-Id: <20200902081708.746631-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

Currently it triggers a WARN_ON and then goes ahead and destroys the
uobject anyhow, leaking any driver memory.

The only place that leaks driver memory should be during FD close() in
uverbs_destroy_ufile_hw().

Drivers are only allowed to fail destroy uobjects if they guarentee
destroy will eventually succeed. uverbs_destroy_ufile_hw() provides the
loop to give the driver that chance.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/rdma_core.c | 30 ++++++++++++++---------------
 include/rdma/ib_verbs.h             |  5 -----
 2 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index d5bf25c6eadc..492ee941ecdf 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -130,17 +130,6 @@ static int uverbs_destroy_uobject(struct ib_uobject *uobj,
 	lockdep_assert_held(&ufile->hw_destroy_rwsem);
 	assert_uverbs_usecnt(uobj, UVERBS_LOOKUP_WRITE);
 
-	if (reason == RDMA_REMOVE_ABORT_HWOBJ) {
-		reason = RDMA_REMOVE_ABORT;
-		ret = uobj->uapi_object->type_class->destroy_hw(uobj, reason,
-								attrs);
-		/*
-		 * Drivers are not permitted to ignore RDMA_REMOVE_ABORT, see
-		 * ib_is_destroy_retryable, cleanup_retryable == false here.
-		 */
-		WARN_ON(ret);
-	}
-
 	if (reason == RDMA_REMOVE_ABORT) {
 		WARN_ON(!list_empty(&uobj->list));
 		WARN_ON(!uobj->context);
@@ -674,11 +663,22 @@ void rdma_alloc_abort_uobject(struct ib_uobject *uobj,
 			      bool hw_obj_valid)
 {
 	struct ib_uverbs_file *ufile = uobj->ufile;
+	int ret;
+
+	if (hw_obj_valid) {
+		ret = uobj->uapi_object->type_class->destroy_hw(
+			uobj, RDMA_REMOVE_ABORT, attrs);
+		/*
+		 * If the driver couldn't destroy the object then go ahead and
+		 * commit it. Leaking objects that can't be destroyed is only
+		 * done during FD close after the driver has a few more tries to
+		 * destroy it.
+		 */
+		if (WARN_ON(ret))
+			return rdma_alloc_commit_uobject(uobj, attrs);
+	}
 
-	uverbs_destroy_uobject(uobj,
-			       hw_obj_valid ? RDMA_REMOVE_ABORT_HWOBJ :
-					      RDMA_REMOVE_ABORT,
-			       attrs);
+	uverbs_destroy_uobject(uobj, RDMA_REMOVE_ABORT, attrs);
 
 	/* Matches the down_read in rdma_alloc_begin_uobject */
 	up_read(&ufile->hw_destroy_rwsem);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 73738fe91e5b..72805a7813c9 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1464,11 +1464,6 @@ enum rdma_remove_reason {
 	RDMA_REMOVE_DRIVER_REMOVE,
 	/* uobj is being cleaned-up before being committed */
 	RDMA_REMOVE_ABORT,
-	/*
-	 * uobj has been fully created, with the uobj->object set, but is being
-	 * cleaned up before being comitted
-	 */
-	RDMA_REMOVE_ABORT_HWOBJ,
 };
 
 struct ib_rdmacg_object {
-- 
2.26.2

