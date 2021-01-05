Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2252EA913
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Jan 2021 11:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbhAEKon (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jan 2021 05:44:43 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:53674 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbhAEKon (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jan 2021 05:44:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1609843482; x=1641379482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KxmLL+Dg7ZM+ZqvgEhTuozX8RS69ga7QDPlsyuFx3x0=;
  b=VpUsQuNPNqlFMD9OzeF7iRJIfLiHI9mi/ZaeOBFNfWYDs9vQJ+Q7J9mJ
   i62WOtgircb8z1qGQn7VJhRsssFPbcEsjyV2O2iznFdBVCHNpSPvf/qOg
   EpfukVDPJ6Upjh9nBpP6X8SBQb/D/LjPjqJ0u+PWvSW/Wh8+aOqeTKiPX
   4=;
X-IronPort-AV: E=Sophos;i="5.78,476,1599523200"; 
   d="scan'208";a="73134946"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 05 Jan 2021 10:43:54 +0000
Received: from EX13D13EUB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id D613EA2355;
        Tue,  5 Jan 2021 10:43:53 +0000 (UTC)
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D13EUB002.ant.amazon.com (10.43.166.205) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 5 Jan 2021 10:43:52 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.212.6) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 5 Jan 2021 10:43:48 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Leonid Feschuk <lfesch@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH for-next 1/2] RDMA/efa: Move host info set to first ucontext allocation
Date:   Tue, 5 Jan 2021 12:43:25 +0200
Message-ID: <20210105104326.67895-2-galpress@amazon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210105104326.67895-1-galpress@amazon.com>
References: <20210105104326.67895-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Downstream patch will require the userspace version which is passed as
part of ucontext allocation. Move the host info set there and make sure
it's only called once (on the first allocation).

Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Leonid Feschuk <lfesch@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa.h       | 7 +++++++
 drivers/infiniband/hw/efa/efa_main.c  | 4 +---
 drivers/infiniband/hw/efa/efa_verbs.c | 3 +++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index e5d9712e98c4..9c9cd5867489 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -45,6 +45,11 @@ struct efa_stats {
 	atomic64_t keep_alive_rcvd;
 };
 
+enum {
+	EFA_FLAGS_HOST_INFO_SET_BIT,
+	EFA_FLAGS_NUM,
+};
+
 struct efa_dev {
 	struct ib_device ibdev;
 	struct efa_com_dev edev;
@@ -62,6 +67,7 @@ struct efa_dev {
 	struct efa_irq admin_irq;
 
 	struct efa_stats stats;
+	DECLARE_BITMAP(flags, EFA_FLAGS_NUM);
 };
 
 struct efa_ucontext {
@@ -117,6 +123,7 @@ struct efa_ah {
 	u8 id[EFA_GID_SIZE];
 };
 
+void efa_set_host_info(struct efa_dev *dev);
 int efa_query_device(struct ib_device *ibdev,
 		     struct ib_device_attr *props,
 		     struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 0f578734bddb..90a033a6af6c 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -191,7 +191,7 @@ static void efa_stats_init(struct efa_dev *dev)
 		atomic64_set(s, 0);
 }
 
-static void efa_set_host_info(struct efa_dev *dev)
+void efa_set_host_info(struct efa_dev *dev)
 {
 	struct efa_admin_set_feature_resp resp = {};
 	struct efa_admin_set_feature_cmd cmd = {};
@@ -301,8 +301,6 @@ static int efa_ib_device_add(struct efa_dev *dev)
 	if (err)
 		goto err_release_doorbell_bar;
 
-	efa_set_host_info(dev);
-
 	dev->ibdev.node_type = RDMA_NODE_UNSPECIFIED;
 	dev->ibdev.phys_port_cnt = 1;
 	dev->ibdev.num_comp_vectors = 1;
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 2fe5708b2d9d..5c12bdc28ef0 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1695,6 +1695,9 @@ int efa_alloc_ucontext(struct ib_ucontext *ibucontext, struct ib_udata *udata)
 		goto err_out;
 	}
 
+	if (!test_and_set_bit(EFA_FLAGS_HOST_INFO_SET_BIT, dev->flags))
+		efa_set_host_info(dev);
+
 	err = efa_user_comp_handshake(ibucontext, &cmd);
 	if (err)
 		goto err_out;
-- 
2.30.0

