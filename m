Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDDFB15A1EF
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2020 08:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgBLH1B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Feb 2020 02:27:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:59720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728329AbgBLH1B (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Feb 2020 02:27:01 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 726922082F;
        Wed, 12 Feb 2020 07:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581492420;
        bh=RSUI/H6x+z0XYi0bO9Ap2uA+C6Mk/JBemjNBWZdcvUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MKvq52bVOvpi+UD92C51glAt9zyG4wv7TtBMeOib+BgoX6gJEboeUmE80wam8XgKn
         1GK4GUp0YGQuq+SzbtQBcJ1t8U2NaMPNcSZnHLhEAqaLUDWNYfTeyGV5GSLERyfcZu
         p3VoYjy2CqCTvg9jJD2Q2RHmJCRbThaK0JRY8VHg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Maor Gottlieb <maorg@mellanox.com>,
        Michael Guralnik <michaelgur@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Valentine Fatiev <valentinef@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Yonatan Cohen <yonatanc@mellanox.com>,
        Zhu Yanjun <yanjunz@mellanox.com>
Subject: [PATCH rdma-rc 6/9] IB/mlx5: Fix async events cleanup flows
Date:   Wed, 12 Feb 2020 09:26:32 +0200
Message-Id: <20200212072635.682689-7-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200212072635.682689-1-leon@kernel.org>
References: <20200212072635.682689-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

Fix async events flows to prevent race between the read event
APIs and their destroy uobj API.

In both async command/event flows, delete the event entry from the list
before its memory de-allocation and fix the async command flow to check
properly for the 'is_destroyed' under the lock.

The above comes to prevent accessing an entry post its de-allocation.

Fixes: f7c8416ccea5 ("RDMA/core: Simplify destruction of FD uobjects")
Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/devx.c | 51 +++++++++++++++++--------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index d7efc9f6daf0..46e1ab771f10 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2319,14 +2319,12 @@ static int deliver_event(struct devx_event_subscription *event_sub,
 
 	if (ev_file->omit_data) {
 		spin_lock_irqsave(&ev_file->lock, flags);
-		if (!list_empty(&event_sub->event_list)) {
+		if (!list_empty(&event_sub->event_list) ||
+		    ev_file->is_destroyed) {
 			spin_unlock_irqrestore(&ev_file->lock, flags);
 			return 0;
 		}
 
-		/* is_destroyed is ignored here because we don't have any memory
-		 * allocation to clean up for the omit_data case
-		 */
 		list_add_tail(&event_sub->event_list, &ev_file->event_list);
 		spin_unlock_irqrestore(&ev_file->lock, flags);
 		wake_up_interruptible(&ev_file->poll_wait);
@@ -2473,11 +2471,11 @@ static ssize_t devx_async_cmd_event_read(struct file *filp, char __user *buf,
 			return -ERESTARTSYS;
 		}
 
-		if (list_empty(&ev_queue->event_list) &&
-		    ev_queue->is_destroyed)
-			return -EIO;
-
 		spin_lock_irq(&ev_queue->lock);
+		if (ev_queue->is_destroyed) {
+			spin_unlock_irq(&ev_queue->lock);
+			return -EIO;
+		}
 	}
 
 	event = list_entry(ev_queue->event_list.next,
@@ -2551,10 +2549,6 @@ static ssize_t devx_async_event_read(struct file *filp, char __user *buf,
 		return -EOVERFLOW;
 	}
 
-	if (ev_file->is_destroyed) {
-		spin_unlock_irq(&ev_file->lock);
-		return -EIO;
-	}
 
 	while (list_empty(&ev_file->event_list)) {
 		spin_unlock_irq(&ev_file->lock);
@@ -2667,8 +2661,10 @@ static int devx_async_cmd_event_destroy_uobj(struct ib_uobject *uobj,
 
 	spin_lock_irq(&comp_ev_file->ev_queue.lock);
 	list_for_each_entry_safe(entry, tmp,
-				 &comp_ev_file->ev_queue.event_list, list)
+				 &comp_ev_file->ev_queue.event_list, list) {
+		list_del(&entry->list);
 		kvfree(entry);
+	}
 	spin_unlock_irq(&comp_ev_file->ev_queue.lock);
 	return 0;
 };
@@ -2680,11 +2676,29 @@ static int devx_async_event_destroy_uobj(struct ib_uobject *uobj,
 		container_of(uobj, struct devx_async_event_file,
 			     uobj);
 	struct devx_event_subscription *event_sub, *event_sub_tmp;
-	struct devx_async_event_data *entry, *tmp;
 	struct mlx5_ib_dev *dev = ev_file->dev;
 
 	spin_lock_irq(&ev_file->lock);
 	ev_file->is_destroyed = 1;
+
+	/* free the pending events allocation */
+	if (ev_file->omit_data) {
+		struct devx_event_subscription *event_sub, *tmp;
+
+		list_for_each_entry_safe(event_sub, tmp, &ev_file->event_list,
+					 event_list)
+			list_del_init(&event_sub->event_list);
+
+	} else {
+		struct devx_async_event_data *entry, *tmp;
+
+		list_for_each_entry_safe(entry, tmp, &ev_file->event_list,
+					 list) {
+			list_del(&entry->list);
+			kfree(entry);
+		}
+	}
+
 	spin_unlock_irq(&ev_file->lock);
 	wake_up_interruptible(&ev_file->poll_wait);
 
@@ -2699,15 +2713,6 @@ static int devx_async_event_destroy_uobj(struct ib_uobject *uobj,
 	}
 	mutex_unlock(&dev->devx_event_table.event_xa_lock);
 
-	/* free the pending events allocation */
-	if (!ev_file->omit_data) {
-		spin_lock_irq(&ev_file->lock);
-		list_for_each_entry_safe(entry, tmp,
-					 &ev_file->event_list, list)
-			kfree(entry); /* read can't come any more */
-		spin_unlock_irq(&ev_file->lock);
-	}
-
 	put_device(&dev->ib_dev.dev);
 	return 0;
 };
-- 
2.24.1

