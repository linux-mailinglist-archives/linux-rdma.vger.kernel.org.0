Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26393635C5
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Apr 2021 15:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhDRN4j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Apr 2021 09:56:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231460AbhDRN4h (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 18 Apr 2021 09:56:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB2EA61278;
        Sun, 18 Apr 2021 13:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618754169;
        bh=LzjajMkmrKzNp+lPlzX93b5lQw7lfFXlvRIpwzMrtsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oNG21P5OQ+R7LvXlQDVNShfFCoNXsxmTG7h54pNEOqRVa7ZlFzkkjSoZcFrtTSqCq
         k2+nnXe5rL3kOgw0ioslqFhzOmwcttSnK0oxWW7Yv5EX4/FrhUm9dGNGL8wPhR3RD+
         Xzz/6kkvs4CfGKDNOUDDaijzdwWiH5TZ7WT2unNPcq13p4+W5wbfNVxkp48i2mn6PR
         bKTr1HowanscVqJQkWo2KTXS3XajREmTueL4DeOsNDyn9PypsZstRyp/LYMoKrMaMe
         /SDYUkvJnNRa9nt1LIVQFBLeUR9Sr7uBthWxicfLPaJhLPlSk+xpWCbi/xgRGAH5Bq
         0hlTpkAaQtlOw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Parav Pandit <parav@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 1/3] RDMA/cma: Skip device which doesn't support CM
Date:   Sun, 18 Apr 2021 16:55:52 +0300
Message-Id: <f9cac00d52864ea7c61295e43fb64cf4db4fdae6.1618753862.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618753862.git.leonro@nvidia.com>
References: <cover.1618753862.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@nvidia.com>

A switchdev RDMA device do not support IB CM. When such device is added
to the RDMA CM's device list, when application invokes rdma_listen(),
cma attempts to listen to such device, however it has IB CM attribute
disabled
.
Due to this, rdma_listen() call fails to listen for other non
switchdev devices as well.

A below error message can be seen.

infiniband mlx5_0: RDMA CMA: cma_listen_on_dev, error -38

A failing call flow is below.

rdma_listen()
  cma_listen_on_all()
    cma_listen_on_dev()
      _cma_attach_to_dev()
      rdma_listen() <- fails on a specific switchdev device

Hence, when a IB device doesn't support IB CM or IW CM, avoid adding
such device to the cma list.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index bb7bd024f3bd..2dc302a83014 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4900,6 +4900,17 @@ static void cma_process_remove(struct cma_device *cma_dev)
 	wait_for_completion(&cma_dev->comp);
 }
 
+static bool cma_supported(struct ib_device *device)
+{
+	u32 i;
+
+	rdma_for_each_port(device, i) {
+		if (rdma_cap_ib_cm(device, i) || rdma_cap_iw_cm(device, i))
+			return true;
+	}
+	return false;
+}
+
 static int cma_add_one(struct ib_device *device)
 {
 	struct rdma_id_private *to_destroy;
@@ -4909,6 +4920,9 @@ static int cma_add_one(struct ib_device *device)
 	int ret;
 	u32 i;
 
+	if (!cma_supported(device))
+		return -EOPNOTSUPP;
+
 	cma_dev = kmalloc(sizeof(*cma_dev), GFP_KERNEL);
 	if (!cma_dev)
 		return -ENOMEM;
-- 
2.30.2

