Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD1029D77C
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Oct 2020 23:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733005AbgJ1WYn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Oct 2020 18:24:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732649AbgJ1WWX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Oct 2020 18:22:23 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D25ED2222B;
        Wed, 28 Oct 2020 06:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603867856;
        bh=pdyqwookFdKHx/L0xEZjzidki8/nv150rb5h0kxgJiw=;
        h=From:To:Cc:Subject:Date:From;
        b=G2bpjIzajqVgUG60F/FnIUdykqfIV1SwUhWDmUyvnS98XSOSdY+GyXp8PvWT/ukg1
         XoUmrYVG+vqtx/l6H0ZjBruU1X8VrQMchTGdZVACc/cA7nnX11QoV0gdBN8xyeDZRN
         KtfNVe+vJ9SVsk5x1qgsQVdR9KlhzZOwypVBu6/M=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org,
        "Nicholas A. Bellinger" <nab@risingtidesystems.com>,
        target-devel@vger.kernel.org
Subject: [PATCH rdma-next v2] IB/srpt: Fix memory leak in srpt_add_one
Date:   Wed, 28 Oct 2020 08:50:51 +0200
Message-Id: <20201028065051.112430-1-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
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
v2:
 * Added an extra parameter to srpt_unregister_mad_agent() to eliminate
   an extra obfuscation call.
v1:
https://lore.kernel.org/linux-rdma/20201027055920.1760663-1-leon@kernel.org
 * Fixed and updated commit message.
 * Remove port_cnt check from __srpt_unregister_mad_agent().
v0:
https://lore.kernel.org/linux-rdma/20201026132737.1338171-1-leon@kernel.org
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 0065eb17ae36..1b096305de1a 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -622,10 +622,11 @@ static int srpt_refresh_port(struct srpt_port *sport)
 /**
  * srpt_unregister_mad_agent - unregister MAD callback functions
  * @sdev: SRPT HCA pointer.
+ * #port_cnt: number of ports with registered MAD
  *
  * Note: It is safe to call this function more than once for the same device.
  */
-static void srpt_unregister_mad_agent(struct srpt_device *sdev)
+static void srpt_unregister_mad_agent(struct srpt_device *sdev, int port_cnt)
 {
 	struct ib_port_modify port_modify = {
 		.clr_port_cap_mask = IB_PORT_DEVICE_MGMT_SUP,
@@ -633,7 +634,7 @@ static void srpt_unregister_mad_agent(struct srpt_device *sdev)
 	struct srpt_port *sport;
 	int i;

-	for (i = 1; i <= sdev->device->phys_port_cnt; i++) {
+	for (i = 1; i <= port_cnt; i++) {
 		sport = &sdev->port[i - 1];
 		WARN_ON(sport->port != i);
 		if (sport->mad_agent) {
@@ -3185,7 +3186,8 @@ static int srpt_add_one(struct ib_device *device)
 		if (ret) {
 			pr_err("MAD registration failed for %s-%d.\n",
 			       dev_name(&sdev->device->dev), i);
-			goto err_event;
+			i--;
+			goto err_port;
 		}
 	}

@@ -3197,7 +3199,8 @@ static int srpt_add_one(struct ib_device *device)
 	pr_debug("added %s.\n", dev_name(&device->dev));
 	return 0;

-err_event:
+err_port:
+	srpt_unregister_mad_agent(sdev, i);
 	ib_unregister_event_handler(&sdev->event_handler);
 err_cm:
 	if (sdev->cm_id)
@@ -3221,7 +3224,7 @@ static void srpt_remove_one(struct ib_device *device, void *client_data)
 	struct srpt_device *sdev = client_data;
 	int i;

-	srpt_unregister_mad_agent(sdev);
+	srpt_unregister_mad_agent(sdev, sdev->device->phys_port_cnt);

 	ib_unregister_event_handler(&sdev->event_handler);

--
2.28.0

