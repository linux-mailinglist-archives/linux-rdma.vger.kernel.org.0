Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0801971232
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 08:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732528AbfGWG6J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 02:58:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731708AbfGWG6J (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jul 2019 02:58:09 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE74C20644;
        Tue, 23 Jul 2019 06:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563865088;
        bh=IeCgu5WK3KNemDLzqPIqlaj4I40RXcLwzGI5tMLifuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LrWQJFgO6v0Mh9P/CDtyt1btmy0fwnteMD6DkUeOkZoVdfZq2yNmpwcNUnaeFT12P
         9aJ3hUCk5wSppEW2S/EDvD6xOyfgYf7e0nlJVBHMEBzS0qTeM0CvB0FuPjicvGtef1
         NHcknSm3LUewzQPZF5TOuo7Jslvu1d4mqpqE2U+E=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Alex Vainman <alexv@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Haggai Eran <haggaie@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagig@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-rc 10/10] IB/counters: Initialize port counter and annotate mutex_destroy
Date:   Tue, 23 Jul 2019 09:57:33 +0300
Message-Id: <20190723065733.4899-11-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190723065733.4899-1-leon@kernel.org>
References: <20190723065733.4899-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

Annotate mutex_destroy for port counters during counters release
operation and during error unwinding during init flow.

Also port counter object should be initialized even if alloc_stats is
unsupported, so that other QP bind operations can avoid call trace
if they try to bind QP on RDMA device which doesn't support counters.

Fixes: f34a55e497e81 ("RDMA/core: Get sum value of all counters when perform a sysfs stat read")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Mark Zhang <markz@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/counters.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index c7d445635476..d60416f0bf3a 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -595,9 +595,9 @@ int rdma_counter_get_mode(struct ib_device *dev, u8 port,
 void rdma_counter_init(struct ib_device *dev)
 {
 	struct rdma_port_counter *port_counter;
-	u32 port;
+	u32 port, i;

-	if (!dev->ops.alloc_hw_stats || !dev->port_data)
+	if (!dev->port_data)
 		return;

 	rdma_for_each_port(dev, port) {
@@ -605,6 +605,9 @@ void rdma_counter_init(struct ib_device *dev)
 		port_counter->mode.mode = RDMA_COUNTER_MODE_NONE;
 		mutex_init(&port_counter->lock);

+		if (!dev->ops.alloc_hw_stats)
+			continue;
+
 		port_counter->hstats = dev->ops.alloc_hw_stats(dev, port);
 		if (!port_counter->hstats)
 			goto fail;
@@ -613,13 +616,12 @@ void rdma_counter_init(struct ib_device *dev)
 	return;

 fail:
-	rdma_for_each_port(dev, port) {
+	for (i = port; i >= rdma_start_port(dev); i--) {
 		port_counter = &dev->port_data[port].port_counter;
 		kfree(port_counter->hstats);
 		port_counter->hstats = NULL;
+		mutex_destroy(&port_counter->lock);
 	}
-
-	return;
 }

 void rdma_counter_release(struct ib_device *dev)
@@ -627,11 +629,9 @@ void rdma_counter_release(struct ib_device *dev)
 	struct rdma_port_counter *port_counter;
 	u32 port;

-	if (!dev->ops.alloc_hw_stats)
-		return;
-
 	rdma_for_each_port(dev, port) {
 		port_counter = &dev->port_data[port].port_counter;
 		kfree(port_counter->hstats);
+		mutex_destroy(&port_counter->lock);
 	}
 }
--
2.20.1

