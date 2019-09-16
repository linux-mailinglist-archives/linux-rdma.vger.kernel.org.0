Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6C0EB3543
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2019 09:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfIPHMF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Sep 2019 03:12:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfIPHMF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Sep 2019 03:12:05 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C3872067D;
        Mon, 16 Sep 2019 07:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568617924;
        bh=A+ZIh35ztOXUnx+2f9PWall0qbfum2s3HVg0/rG+mEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SZAmUuhgx0q8nMLJWJGDt06gniqD9McYL4llzjqCFBz3kFVceAb9dK8SnwWHlhJ3Q
         j7DbZ5NbDP764DPkrY4FetwnLyq5DVYP084UaXe6SYP1jue2ta9UNmMXqPnHQ/57/K
         5/tUA0wQClrMLotCwfgY0LiKRu2oup0pKvA+RQbE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Mark Zhang <markz@mellanox.com>
Subject: [PATCH 1/4] RDMA/cm: Fix memory leak in cm_add/remove_one
Date:   Mon, 16 Sep 2019 10:11:51 +0300
Message-Id: <20190916071154.20383-2-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916071154.20383-1-leon@kernel.org>
References: <20190916071154.20383-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Morgenstein <jackm@dev.mellanox.co.il>

In the process of moving the debug counters sysfs entries, the commit
mentioned below eliminated the cm_infiniband sysfs directory.

This sysfs directory was tied to the cm_port object allocated in procedure
cm_add_one().

Before the commit below, this cm_port object was freed via a call to
kobject_put(port->kobj) in procedure cm_remove_port_fs().

Since port no longer uses its kobj, kobject_put(port->kobj) was eliminated.
This, however, meant that kfree was never called for the cm_port buffers.

Fix this by adding explicit kfree(port) calls to functions cm_add_one()
and cm_remove_one().

Note: the kfree call in the first chunk below (in the cm_add_one error
flow) fixes an old, undetected memory leak.

Fixes: c87e65cfb97c ("RDMA/cm: Move debug counters to be under relevant IB device")
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index da10e6ccb43c..5920c0085d35 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -4399,6 +4399,7 @@ static void cm_add_one(struct ib_device *ib_device)
 error1:
 	port_modify.set_port_cap_mask = 0;
 	port_modify.clr_port_cap_mask = IB_PORT_CM_SUP;
+	kfree(port);
 	while (--i) {
 		if (!rdma_cap_ib_cm(ib_device, i))
 			continue;
@@ -4407,6 +4408,7 @@ static void cm_add_one(struct ib_device *ib_device)
 		ib_modify_port(ib_device, port->port_num, 0, &port_modify);
 		ib_unregister_mad_agent(port->mad_agent);
 		cm_remove_port_fs(port);
+		kfree(port);
 	}
 free:
 	kfree(cm_dev);
@@ -4460,6 +4462,7 @@ static void cm_remove_one(struct ib_device *ib_device, void *client_data)
 		spin_unlock_irq(&cm.state_lock);
 		ib_unregister_mad_agent(cur_mad_agent);
 		cm_remove_port_fs(port);
+		kfree(port);
 	}

 	kfree(cm_dev);
--
2.20.1

