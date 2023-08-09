Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3877C776274
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Aug 2023 16:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjHIO3T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Aug 2023 10:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbjHIO3T (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Aug 2023 10:29:19 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25981FCC;
        Wed,  9 Aug 2023 07:29:17 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RLXQy0FFXz9tH4;
        Wed,  9 Aug 2023 22:25:46 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 22:29:14 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>, <yuehaibing@huawei.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] rdma: Remove unused function declarations
Date:   Wed, 9 Aug 2023 22:27:18 +0800
Message-ID: <20230809142718.42316-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Commit c2261dd76b54 ("RDMA/device: Add ib_device_set_netdev() as an alternative to get_netdev")
declared but never implemented ib_device_netdev(), remove it.
Commit 922a8e9fb2e0 ("RDMA: iWARP Connection Manager.") declared but never implemented
iw_cm_unbind_qp() and iw_cm_get_qp().

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/rdma/ib_verbs.h |  2 --
 include/rdma/iw_cm.h    | 21 ---------------------
 2 files changed, 23 deletions(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 1e7774ac808f..533ab92684d8 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4440,8 +4440,6 @@ struct net_device *ib_get_net_dev_by_params(struct ib_device *dev, u32 port,
 					    const struct sockaddr *addr);
 int ib_device_set_netdev(struct ib_device *ib_dev, struct net_device *ndev,
 			 unsigned int port);
-struct net_device *ib_device_netdev(struct ib_device *dev, u32 port);
-
 struct ib_wq *ib_create_wq(struct ib_pd *pd,
 			   struct ib_wq_init_attr *init_attr);
 int ib_destroy_wq_user(struct ib_wq *wq, struct ib_udata *udata);
diff --git a/include/rdma/iw_cm.h b/include/rdma/iw_cm.h
index 03abd30e6c8c..2b22f153ef63 100644
--- a/include/rdma/iw_cm.h
+++ b/include/rdma/iw_cm.h
@@ -114,27 +114,6 @@ struct iw_cm_id *iw_create_cm_id(struct ib_device *device,
  */
 void iw_destroy_cm_id(struct iw_cm_id *cm_id);
 
-/**
- * iw_cm_bind_qp - Unbind the specified IW CM identifier and QP
- *
- * @cm_id: The IW CM idenfier to unbind from the QP.
- * @qp: The QP
- *
- * This is called by the provider when destroying the QP to ensure
- * that any references held by the IWCM are released. It may also
- * be called by the IWCM when destroying a CM_ID to that any
- * references held by the provider are released.
- */
-void iw_cm_unbind_qp(struct iw_cm_id *cm_id, struct ib_qp *qp);
-
-/**
- * iw_cm_get_qp - Return the ib_qp associated with a QPN
- *
- * @ib_device: The IB device
- * @qpn: The queue pair number
- */
-struct ib_qp *iw_cm_get_qp(struct ib_device *device, int qpn);
-
 /**
  * iw_cm_listen - Listen for incoming connection requests on the
  * specified IW CM id.
-- 
2.34.1

