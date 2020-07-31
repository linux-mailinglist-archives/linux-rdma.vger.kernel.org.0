Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B4C233EDF
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Jul 2020 08:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbgGaGEs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Jul 2020 02:04:48 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:5720 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730170AbgGaGEs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 31 Jul 2020 02:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1596175488; x=1627711488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CPaJfYCMhsmsHjWG77rqOrY2F0BIrSDDNqzJq8iqL3k=;
  b=AQ4BGwxuDMeJj2TNCMuFbFyn++5QDmqDiRur4198YPaMPvdXdn1O7+Cd
   gQe1qA8YBWkYSgkNtdnKxdwV+ebsy5GWeYCt1QBaT5OND0NZj0wnp5GNw
   ibrokK0ysxJaHz7/tS4p5BgHqhAy2eH08CW0071rYLMK78Sq7FPeDQxvB
   0=;
IronPort-SDR: LpdPCyOlZmn1AVMFmA1shZ83OAHUTYCGUev6BsGFQbmfJaHhqdmJwWmLyMLDJwN5j3IB7uZ8CH
 sw3xUYZPmEqw==
X-IronPort-AV: E=Sophos;i="5.75,417,1589241600"; 
   d="scan'208";a="45309268"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 31 Jul 2020 06:04:47 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id BE819A0524;
        Fri, 31 Jul 2020 06:04:45 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 31 Jul 2020 06:04:44 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 31 Jul 2020 06:04:43 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.212.6) by
 mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 31 Jul 2020 06:04:41 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        "Yossi Leybovich" <sleybo@amazon.com>
Subject: [PATCH for-next 1/4] RDMA/efa: Add a generic capability check helper
Date:   Fri, 31 Jul 2020 09:04:17 +0300
Message-ID: <20200731060420.17053-2-galpress@amazon.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200731060420.17053-1-galpress@amazon.com>
References: <20200731060420.17053-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Instead of adding a new function for each capability added, introduce a
generic helper to query device capabilities.

Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 08313f7c73bc..d5654fecf430 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -142,10 +142,9 @@ to_emmap(struct rdma_user_mmap_entry *rdma_entry)
 	return container_of(rdma_entry, struct efa_user_mmap_entry, rdma_entry);
 }
 
-static inline bool is_rdma_read_cap(struct efa_dev *dev)
-{
-	return dev->dev_attr.device_caps & EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_RDMA_READ_MASK;
-}
+#define EFA_DEV_CAP(dev, cap) \
+	((dev)->dev_attr.device_caps & \
+	 EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_##cap##_MASK)
 
 #define is_reserved_cleared(reserved) \
 	!memchr_inv(reserved, 0, sizeof(reserved))
@@ -220,7 +219,7 @@ int efa_query_device(struct ib_device *ibdev,
 		resp.max_rq_wr = dev_attr->max_rq_depth;
 		resp.max_rdma_size = dev_attr->max_rdma_size;
 
-		if (is_rdma_read_cap(dev))
+		if (EFA_DEV_CAP(dev, RDMA_READ))
 			resp.device_caps |= EFA_QUERY_DEVICE_CAPS_RDMA_READ;
 
 		err = ib_copy_to_udata(udata, &resp,
@@ -1369,7 +1368,7 @@ struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
 
 	supp_access_flags =
 		IB_ACCESS_LOCAL_WRITE |
-		(is_rdma_read_cap(dev) ? IB_ACCESS_REMOTE_READ : 0);
+		(EFA_DEV_CAP(dev, RDMA_READ) ? IB_ACCESS_REMOTE_READ : 0);
 
 	access_flags &= ~IB_ACCESS_OPTIONAL;
 	if (access_flags & ~supp_access_flags) {
-- 
2.27.0

