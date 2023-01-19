Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EB0674419
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jan 2023 22:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjASVNM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Jan 2023 16:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjASVMk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Jan 2023 16:12:40 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2559133
        for <linux-rdma@vger.kernel.org>; Thu, 19 Jan 2023 13:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674162445; x=1705698445;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kBCQ7BZ5f7EN7r2RwXONC+dS7Zf8GAoTJXBsZ4c8FsA=;
  b=BI3YEC/QSBqxWQeba9YC6N4nZ9hCtVIQn3RUIqtXqXaBn+9XA8cQhkr5
   vAZy0OyqP+5nNIyTTK8Un5atAxpe6nl6rj2HlTp6bRxVECeVDIFiXFfEJ
   Cz1FcnUtuL0Kyl423rvZM83J02z3T7QjZvXO+2spdZ1tu6LwRH8g2L4Hw
   Ae37odC2uTH4FU5h+JNdoBysHSzVEPKUAaaSdK88lqYn59rOxkZgwqHXt
   Xs9qHSzgE1CCdA4SGjEk13rrFjTjZxqhRNJ62Gt6zqCLRL1gxb3VhmUsz
   6dOZpk1JNBP5i0AxZvX15DwlnduhVBRsEcsKFkLUDZjEk1IkzGhiEdfVu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="327516631"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="327516631"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 13:07:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="662256519"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="662256519"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.209.49.55])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 13:07:23 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        sagi@grimberg.me
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc] IB/isert: Fix hang in iscsit_wait_for_tag
Date:   Thu, 19 Jan 2023 15:07:00 -0600
Message-Id: <20230119210659.1871-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mustafa Ismail <mustafa.ismail@intel.com>

Running fio can occasionally cause a hang when sbitmap_queue_get() fails to
return a tag in iscsit_allocate_cmd() and iscsit_wait_for_tag() is called
and will never return from the schedule(). This is because the polling
thread of the CQ is suspended, and will not poll for a SQ completion which
would free up a tag.
Fix this by creating a separate CQ for the SQ so that send completions are
processed on a separate thread and are not blocked when the RQ CQ is
stalled.

Fixes: 10e9cbb6b531 ("scsi: target: Convert target drivers to use sbitmap")
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 33 +++++++++++++++++++++++----------
 drivers/infiniband/ulp/isert/ib_isert.h |  3 ++-
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 7540488..f827b91 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -109,19 +109,27 @@ static int isert_sg_tablesize_set(const char *val, const struct kernel_param *kp
 	struct ib_qp_init_attr attr;
 	int ret, factor;
 
-	isert_conn->cq = ib_cq_pool_get(ib_dev, cq_size, -1, IB_POLL_WORKQUEUE);
-	if (IS_ERR(isert_conn->cq)) {
-		isert_err("Unable to allocate cq\n");
-		ret = PTR_ERR(isert_conn->cq);
+	isert_conn->snd_cq = ib_cq_pool_get(ib_dev, cq_size, -1,
+					    IB_POLL_WORKQUEUE);
+	if (IS_ERR(isert_conn->snd_cq)) {
+		isert_err("Unable to allocate send cq\n");
+		ret = PTR_ERR(isert_conn->snd_cq);
 		return ERR_PTR(ret);
 	}
+	isert_conn->rcv_cq = ib_cq_pool_get(ib_dev, cq_size, -1,
+					    IB_POLL_WORKQUEUE);
+	if (IS_ERR(isert_conn->rcv_cq)) {
+		isert_err("Unable to allocate receive cq\n");
+		ret = PTR_ERR(isert_conn->rcv_cq);
+		goto create_cq_err;
+	}
 	isert_conn->cq_size = cq_size;
 
 	memset(&attr, 0, sizeof(struct ib_qp_init_attr));
 	attr.event_handler = isert_qp_event_callback;
 	attr.qp_context = isert_conn;
-	attr.send_cq = isert_conn->cq;
-	attr.recv_cq = isert_conn->cq;
+	attr.send_cq = isert_conn->snd_cq;
+	attr.recv_cq = isert_conn->rcv_cq;
 	attr.cap.max_send_wr = ISERT_QP_MAX_REQ_DTOS + 1;
 	attr.cap.max_recv_wr = ISERT_QP_MAX_RECV_DTOS + 1;
 	factor = rdma_rw_mr_factor(device->ib_device, cma_id->port_num,
@@ -137,12 +145,16 @@ static int isert_sg_tablesize_set(const char *val, const struct kernel_param *kp
 	ret = rdma_create_qp(cma_id, device->pd, &attr);
 	if (ret) {
 		isert_err("rdma_create_qp failed for cma_id %d\n", ret);
-		ib_cq_pool_put(isert_conn->cq, isert_conn->cq_size);
-
-		return ERR_PTR(ret);
+		goto create_qp_err;
 	}
 
 	return cma_id->qp;
+create_qp_err:
+	ib_cq_pool_put(isert_conn->rcv_cq, isert_conn->cq_size);
+create_cq_err:
+	ib_cq_pool_put(isert_conn->snd_cq, isert_conn->cq_size);
+
+	return ERR_PTR(ret);
 }
 
 static int
@@ -409,7 +421,8 @@ static int isert_sg_tablesize_set(const char *val, const struct kernel_param *kp
 isert_destroy_qp(struct isert_conn *isert_conn)
 {
 	ib_destroy_qp(isert_conn->qp);
-	ib_cq_pool_put(isert_conn->cq, isert_conn->cq_size);
+	ib_cq_pool_put(isert_conn->snd_cq, isert_conn->cq_size);
+	ib_cq_pool_put(isert_conn->rcv_cq, isert_conn->cq_size);
 }
 
 static int
diff --git a/drivers/infiniband/ulp/isert/ib_isert.h b/drivers/infiniband/ulp/isert/ib_isert.h
index 0b2dfd6..0cd43af 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.h
+++ b/drivers/infiniband/ulp/isert/ib_isert.h
@@ -180,7 +180,8 @@ struct isert_conn {
 	struct iser_tx_desc	login_tx_desc;
 	struct rdma_cm_id	*cm_id;
 	struct ib_qp		*qp;
-	struct ib_cq		*cq;
+	struct ib_cq		*snd_cq;
+	struct ib_cq		*rcv_cq;
 	u32			cq_size;
 	struct isert_device	*device;
 	struct mutex		mutex;
-- 
1.8.3.1

