Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5B8913D315
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 05:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbgAPEOr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jan 2020 23:14:47 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8734 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730434AbgAPEOr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Jan 2020 23:14:47 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A0BE39CF337B353AFFFF;
        Thu, 16 Jan 2020 12:14:44 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Thu, 16 Jan 2020 12:14:34 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <shiraz.saleem@intel.com>, <aditr@vmware.com>,
        <mkalderon@marvell.com>, <aelior@marvell.com>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH RFC for-next 3/6] RDMA/i40iw: remove deliver net device event
Date:   Thu, 16 Jan 2020 12:10:44 +0800
Message-ID: <1579147847-12158-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1579147847-12158-1-git-send-email-liweihang@huawei.com>
References: <1579147847-12158-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

The code that handles the link event of the net device has been moved
into the core, and the related processing should been removed from the
provider's driver.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/i40iw/i40iw_main.c  |  6 -----
 drivers/infiniband/hw/i40iw/i40iw_utils.c | 44 -------------------------------
 2 files changed, 50 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_main.c b/drivers/infiniband/hw/i40iw/i40iw_main.c
index 2386143..6c41458e 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_main.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_main.c
@@ -99,10 +99,6 @@ static struct notifier_block i40iw_net_notifier = {
 	.notifier_call = i40iw_net_event
 };
 
-static struct notifier_block i40iw_netdevice_notifier = {
-	.notifier_call = i40iw_netdevice_event
-};
-
 /**
  * i40iw_find_i40e_handler - find a handler given a client info
  * @ldev: pointer to a client info
@@ -1401,7 +1397,6 @@ static void i40iw_register_notifiers(void)
 	register_inetaddr_notifier(&i40iw_inetaddr_notifier);
 	register_inet6addr_notifier(&i40iw_inetaddr6_notifier);
 	register_netevent_notifier(&i40iw_net_notifier);
-	register_netdevice_notifier(&i40iw_netdevice_notifier);
 }
 
 /**
@@ -1413,7 +1408,6 @@ static void i40iw_unregister_notifiers(void)
 	unregister_netevent_notifier(&i40iw_net_notifier);
 	unregister_inetaddr_notifier(&i40iw_inetaddr_notifier);
 	unregister_inet6addr_notifier(&i40iw_inetaddr6_notifier);
-	unregister_netdevice_notifier(&i40iw_netdevice_notifier);
 }
 
 /**
diff --git a/drivers/infiniband/hw/i40iw/i40iw_utils.c b/drivers/infiniband/hw/i40iw/i40iw_utils.c
index 0165246..09171e6 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_utils.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_utils.c
@@ -311,50 +311,6 @@ int i40iw_net_event(struct notifier_block *notifier, unsigned long event, void *
 }
 
 /**
- * i40iw_netdevice_event - system notifier for netdev events
- * @notfier: not used
- * @event: event for notifier
- * @ptr: netdev
- */
-int i40iw_netdevice_event(struct notifier_block *notifier,
-			  unsigned long event,
-			  void *ptr)
-{
-	struct net_device *event_netdev;
-	struct net_device *netdev;
-	struct i40iw_device *iwdev;
-	struct i40iw_handler *hdl;
-
-	event_netdev = netdev_notifier_info_to_dev(ptr);
-
-	hdl = i40iw_find_netdev(event_netdev);
-	if (!hdl)
-		return NOTIFY_DONE;
-
-	iwdev = &hdl->device;
-	if (iwdev->init_state < RDMA_DEV_REGISTERED || iwdev->closing)
-		return NOTIFY_DONE;
-
-	netdev = iwdev->ldev->netdev;
-	if (netdev != event_netdev)
-		return NOTIFY_DONE;
-
-	iwdev->iw_status = 1;
-
-	switch (event) {
-	case NETDEV_DOWN:
-		iwdev->iw_status = 0;
-		/* Fall through */
-	case NETDEV_UP:
-		i40iw_port_ibevent(iwdev);
-		break;
-	default:
-		break;
-	}
-	return NOTIFY_DONE;
-}
-
-/**
  * i40iw_get_cqp_request - get cqp struct
  * @cqp: device cqp ptr
  * @wait: cqp to be used in wait mode
-- 
2.8.1

