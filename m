Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01B638C420
	for <lists+linux-rdma@lfdr.de>; Fri, 21 May 2021 11:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbhEUJ5M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 May 2021 05:57:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5652 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbhEUJzU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 May 2021 05:55:20 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fmhgw15Ylz16Pnm;
        Fri, 21 May 2021 17:51:08 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 17:53:55 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 21 May 2021 17:53:55 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH v2 for-next 12/17] RDMA/i40iw: Use refcount_t instead of atomic_t on refcount of i40iw_cqp_request
Date:   Fri, 21 May 2021 17:53:40 +0800
Message-ID: <1621590825-60693-13-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621590825-60693-1-git-send-email-liweihang@huawei.com>
References: <1621590825-60693-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The refcount_t API will WARN on underflow and overflow of a reference
counter, and avoid use-after-free risks.

Cc: Faisal Latif <faisal.latif@intel.com>
Cc: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/i40iw/i40iw.h       |  2 +-
 drivers/infiniband/hw/i40iw/i40iw_main.c  |  2 +-
 drivers/infiniband/hw/i40iw/i40iw_utils.c | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw.h b/drivers/infiniband/hw/i40iw/i40iw.h
index be4094a..15c5dd6 100644
--- a/drivers/infiniband/hw/i40iw/i40iw.h
+++ b/drivers/infiniband/hw/i40iw/i40iw.h
@@ -137,7 +137,7 @@ struct i40iw_cqp_request {
 	struct cqp_commands_info info;
 	wait_queue_head_t waitq;
 	struct list_head list;
-	atomic_t refcount;
+	refcount_t refcount;
 	void (*callback_fcn)(struct i40iw_cqp_request*, u32);
 	void *param;
 	struct i40iw_cqp_compl_info compl_info;
diff --git a/drivers/infiniband/hw/i40iw/i40iw_main.c b/drivers/infiniband/hw/i40iw/i40iw_main.c
index b496f30..fc48555 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_main.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_main.c
@@ -1125,7 +1125,7 @@ static enum i40iw_status_code i40iw_alloc_local_mac_ipaddr_entry(struct i40iw_de
 	}
 
 	/* increment refcount, because we need the cqp request ret value */
-	atomic_inc(&cqp_request->refcount);
+	refcount_inc(&cqp_request->refcount);
 
 	cqp_info = &cqp_request->info;
 	cqp_info->cqp_cmd = OP_ALLOC_LOCAL_MAC_IPADDR_ENTRY;
diff --git a/drivers/infiniband/hw/i40iw/i40iw_utils.c b/drivers/infiniband/hw/i40iw/i40iw_utils.c
index 9ff825f..32ff432b 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_utils.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_utils.c
@@ -384,10 +384,10 @@ struct i40iw_cqp_request *i40iw_get_cqp_request(struct i40iw_cqp *cqp, bool wait
 	}
 
 	if (wait) {
-		atomic_set(&cqp_request->refcount, 2);
+		refcount_set(&cqp_request->refcount, 2);
 		cqp_request->waiting = true;
 	} else {
-		atomic_set(&cqp_request->refcount, 1);
+		refcount_set(&cqp_request->refcount, 1);
 	}
 	return cqp_request;
 }
@@ -424,7 +424,7 @@ void i40iw_free_cqp_request(struct i40iw_cqp *cqp, struct i40iw_cqp_request *cqp
 void i40iw_put_cqp_request(struct i40iw_cqp *cqp,
 			   struct i40iw_cqp_request *cqp_request)
 {
-	if (atomic_dec_and_test(&cqp_request->refcount))
+	if (refcount_dec_and_test(&cqp_request->refcount))
 		i40iw_free_cqp_request(cqp, cqp_request);
 }
 
@@ -445,7 +445,7 @@ static void i40iw_free_pending_cqp_request(struct i40iw_cqp *cqp,
 	}
 	i40iw_put_cqp_request(cqp, cqp_request);
 	wait_event_timeout(iwdev->close_wq,
-			   !atomic_read(&cqp_request->refcount),
+			   !refcount_read(&cqp_request->refcount),
 			   1000);
 }
 
@@ -1005,7 +1005,7 @@ static void i40iw_cqp_manage_hmc_fcn_callback(struct i40iw_cqp_request *cqp_requ
 
 	if (hmcfcninfo && hmcfcninfo->callback_fcn) {
 		i40iw_debug(&iwdev->sc_dev, I40IW_DEBUG_HMC, "%s1\n", __func__);
-		atomic_inc(&cqp_request->refcount);
+		refcount_inc(&cqp_request->refcount);
 		work = &iwdev->virtchnl_w[hmcfcninfo->iw_vf_idx];
 		work->cqp_request = cqp_request;
 		INIT_WORK(&work->work, i40iw_cqp_manage_hmc_fcn_worker);
-- 
2.7.4

