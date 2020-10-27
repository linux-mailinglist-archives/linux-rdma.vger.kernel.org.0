Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF6629A460
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Oct 2020 06:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506137AbgJ0F72 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Oct 2020 01:59:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506136AbgJ0F71 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Oct 2020 01:59:27 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 195B5217A0;
        Tue, 27 Oct 2020 05:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603778366;
        bh=d/py5uqvbgb903RAH2V3wPiJRQmTTQD1Sesj4l3Fn+k=;
        h=From:To:Cc:Subject:Date:From;
        b=c2a775Z8OH8T3lnN3D7Ln52rbvHIe1+pHtxeMDTfAocHL5s69MXbZVPVg9WquAz2R
         SopBAjd7RO5sEvR9KgGG9vWPX5c57xPqd+BZvKpy9FH2Oxm9ErPtLQUCxPW5DcvWD8
         EicmB70oKN3gNP1vaKwMxMv380dKIBF5pUomxg3g=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org,
        "Nicholas A. Bellinger" <nab@risingtidesystems.com>,
        target-devel@vger.kernel.org
Subject: [PATCH rdma-next v1] IB/srpt: Fix memory leak in srpt_add_one
Date:   Tue, 27 Oct 2020 07:59:20 +0200
Message-Id: <20201027055920.1760663-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@nvidia.com>

Failure in srpt_refresh_port() for the second port will leave MAD
registered for the first one, however, the srpt_add_one() will be
marked as "failed" and SRPT will leak resources for that registered
but not used and released first port.

Unregister the MAD agent for all ports in case of failure.

Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Changelog:
v1:
 * Fixed and updated commit message.
 * Remove port_cnt check from __srpt_unregister_mad_agent().
v0: https://lore.kernel.org/linux-rdma/20201026132737.1338171-1-leon@kernel.org

---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 0065eb17ae36..2747a3af545f 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -619,13 +619,7 @@ static int srpt_refresh_port(struct srpt_port *sport)
 	return 0;
 }

-/**
- * srpt_unregister_mad_agent - unregister MAD callback functions
- * @sdev: SRPT HCA pointer.
- *
- * Note: It is safe to call this function more than once for the same device.
- */
-static void srpt_unregister_mad_agent(struct srpt_device *sdev)
+static void __srpt_unregister_mad_agent(struct srpt_device *sdev, int port_cnt)
 {
 	struct ib_port_modify port_modify = {
 		.clr_port_cap_mask = IB_PORT_DEVICE_MGMT_SUP,
@@ -633,7 +627,7 @@ static void srpt_unregister_mad_agent(struct srpt_device *sdev)
 	struct srpt_port *sport;
 	int i;

-	for (i = 1; i <= sdev->device->phys_port_cnt; i++) {
+	for (i = 1; i <= port_cnt; i++) {
 		sport = &sdev->port[i - 1];
 		WARN_ON(sport->port != i);
 		if (sport->mad_agent) {
@@ -644,6 +638,17 @@ static void srpt_unregister_mad_agent(struct srpt_device *sdev)
 	}
 }

+/**
+ * srpt_unregister_mad_agent - unregister MAD callback functions
+ * @sdev: SRPT HCA pointer.
+ *
+ * Note: It is safe to call this function more than once for the same device.
+ */
+static void srpt_unregister_mad_agent(struct srpt_device *sdev)
+{
+	__srpt_unregister_mad_agent(sdev, sdev->device->phys_port_cnt);
+}
+
 /**
  * srpt_alloc_ioctx - allocate a SRPT I/O context structure
  * @sdev: SRPT HCA pointer.
@@ -3185,7 +3190,8 @@ static int srpt_add_one(struct ib_device *device)
 		if (ret) {
 			pr_err("MAD registration failed for %s-%d.\n",
 			       dev_name(&sdev->device->dev), i);
-			goto err_event;
+			i--;
+			goto err_port;
 		}
 	}

@@ -3197,7 +3203,8 @@ static int srpt_add_one(struct ib_device *device)
 	pr_debug("added %s.\n", dev_name(&device->dev));
 	return 0;

-err_event:
+err_port:
+	__srpt_unregister_mad_agent(sdev, i);
 	ib_unregister_event_handler(&sdev->event_handler);
 err_cm:
 	if (sdev->cm_id)
--
2.26.2

