Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2286337696
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Mar 2021 16:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbhCKPMB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Mar 2021 10:12:01 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:17848 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbhCKPLo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Mar 2021 10:11:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1615475505; x=1647011505;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lUPBPwQ84Ur7HzhvvY3PzFiO4aRgmvq1u9kibJus/G4=;
  b=lZ+t0UPVxT4VGTrdtoqEcVvQb6oUYOjByx8xWh9VyObA+fgnbjokJoA6
   jRVGWB9d5SqGKt3n4WHCsDSBAuan0gHq3Uejq0zD56wkPZ16MfdUROwp1
   mB7cWh/JTesHJrY0nwMU16ms9QLnMVALEMUi52uvWV1mWGShIDOWhMy5i
   Y=;
IronPort-HdrOrdr: A9a23:ZG2n76484Vn4hbaZ/wPXwDjXdLJzesId70hD6mlaTxtJfsuE0/
 2/hfhz726WtB89elEF3eqBNq6JXG/G+fdOirU5EL++UGDd0leAA5pl6eLZrgHIPi3l66pg0r
 19eLJ1E936ATFB/KTHyS2ZN/pl/9Wd6qCvgo7lr0tFaQ1xcalv40NYJ2+gfHFefwVNCZonGJ
 f03KMumxOadW0TfoCHABA+M9TrncHBl57tfHc9ZiIP1Q/mt1yV1II=
X-IronPort-AV: E=Sophos;i="5.81,240,1610409600"; 
   d="scan'208";a="92155449"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 11 Mar 2021 15:09:37 +0000
Received: from EX13D19EUB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (Postfix) with ESMTPS id AC6F3A06A0;
        Thu, 11 Mar 2021 15:09:35 +0000 (UTC)
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 11 Mar 2021 15:09:34 +0000
Received: from 8c85908914bf.ant.amazon.com.com (10.1.213.27) by
 mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 11 Mar 2021 15:09:32 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH for-next] RDMA/core: Remove unused req_ncomp_notif device operation
Date:   Thu, 11 Mar 2021 17:09:21 +0200
Message-ID: <20210311150921.23726-1-galpress@amazon.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The request_ncomp_notif device operation and function are unused, remove
them.

Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/core/device.c |  1 -
 include/rdma/ib_verbs.h          | 15 ---------------
 2 files changed, 16 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index aac0fe14e1d9..08f4844abbe3 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2696,7 +2696,6 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, reg_dm_mr);
 	SET_DEVICE_OP(dev_ops, reg_user_mr);
 	SET_DEVICE_OP(dev_ops, reg_user_mr_dmabuf);
-	SET_DEVICE_OP(dev_ops, req_ncomp_notif);
 	SET_DEVICE_OP(dev_ops, req_notify_cq);
 	SET_DEVICE_OP(dev_ops, rereg_user_mr);
 	SET_DEVICE_OP(dev_ops, resize_cq);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index ca28fca5736b..21c19b1fcee7 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2301,7 +2301,6 @@ struct ib_device_ops {
 	int (*poll_cq)(struct ib_cq *cq, int num_entries, struct ib_wc *wc);
 	int (*peek_cq)(struct ib_cq *cq, int wc_cnt);
 	int (*req_notify_cq)(struct ib_cq *cq, enum ib_cq_notify_flags flags);
-	int (*req_ncomp_notif)(struct ib_cq *cq, int wc_cnt);
 	int (*post_srq_recv)(struct ib_srq *srq,
 			     const struct ib_recv_wr *recv_wr,
 			     const struct ib_recv_wr **bad_recv_wr);
@@ -3915,20 +3914,6 @@ struct ib_cq *ib_cq_pool_get(struct ib_device *dev, unsigned int nr_cqe,
 
 void ib_cq_pool_put(struct ib_cq *cq, unsigned int nr_cqe);
 
-/**
- * ib_req_ncomp_notif - Request completion notification when there are
- *   at least the specified number of unreaped completions on the CQ.
- * @cq: The CQ to generate an event for.
- * @wc_cnt: The number of unreaped completions that should be on the
- *   CQ before an event is generated.
- */
-static inline int ib_req_ncomp_notif(struct ib_cq *cq, int wc_cnt)
-{
-	return cq->device->ops.req_ncomp_notif ?
-		cq->device->ops.req_ncomp_notif(cq, wc_cnt) :
-		-ENOSYS;
-}
-
 /*
  * Drivers that don't need a DMA mapping at the RDMA layer, set dma_device to
  * NULL. This causes the ib_dma* helpers to just stash the kernel virtual
-- 
2.30.2

