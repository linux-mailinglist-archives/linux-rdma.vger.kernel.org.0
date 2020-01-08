Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6BD134933
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2020 18:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbgAHRWh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jan 2020 12:22:37 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:41810 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729767AbgAHRWh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jan 2020 12:22:37 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 8 Jan 2020 19:22:32 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 008HMW8S009631;
        Wed, 8 Jan 2020 19:22:32 +0200
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 008HMWl3009571;
        Wed, 8 Jan 2020 19:22:32 +0200
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 008HMWwB009570;
        Wed, 8 Jan 2020 19:22:32 +0200
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     yishaih@mellanox.com, maorg@mellanox.com, michaelgur@mellanox.com
Subject: [PATCH rdma-next 11/14] RDMA/core: Fix locking in ib_uverbs_event_read
Date:   Wed,  8 Jan 2020 19:22:03 +0200
Message-Id: <1578504126-9400-12-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1578504126-9400-1-git-send-email-yishaih@mellanox.com>
References: <1578504126-9400-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

This should not be using ib_dev to test for disassociation, during
disassociation is_closed is set under lock and the waitq is triggered.

Instead check is_closed and be sure to re-obtain the lock to test the
value after the wait_event returns.

Fixes: 036b10635739 ("IB/uverbs: Enable device removal when there are active user space applications")
Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/uverbs_main.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 85dbd81..97770e7 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -215,7 +215,6 @@ void ib_uverbs_release_file(struct kref *ref)
 }
 
 static ssize_t ib_uverbs_event_read(struct ib_uverbs_event_queue *ev_queue,
-				    struct ib_uverbs_file *uverbs_file,
 				    struct file *filp, char __user *buf,
 				    size_t count, loff_t *pos,
 				    size_t eventsz)
@@ -233,19 +232,16 @@ static ssize_t ib_uverbs_event_read(struct ib_uverbs_event_queue *ev_queue,
 
 		if (wait_event_interruptible(ev_queue->poll_wait,
 					     (!list_empty(&ev_queue->event_list) ||
-			/* The barriers built into wait_event_interruptible()
-			 * and wake_up() guarentee this will see the null set
-			 * without using RCU
-			 */
-					     !uverbs_file->device->ib_dev)))
+					      ev_queue->is_closed)))
 			return -ERESTARTSYS;
 
+		spin_lock_irq(&ev_queue->lock);
+
 		/* If device was disassociated and no event exists set an error */
-		if (list_empty(&ev_queue->event_list) &&
-		    !uverbs_file->device->ib_dev)
+		if (list_empty(&ev_queue->event_list) && ev_queue->is_closed) {
+			spin_unlock_irq(&ev_queue->lock);
 			return -EIO;
-
-		spin_lock_irq(&ev_queue->lock);
+		}
 	}
 
 	event = list_entry(ev_queue->event_list.next, struct ib_uverbs_event, list);
@@ -280,8 +276,7 @@ static ssize_t ib_uverbs_async_event_read(struct file *filp, char __user *buf,
 {
 	struct ib_uverbs_async_event_file *file = filp->private_data;
 
-	return ib_uverbs_event_read(&file->ev_queue, file->uverbs_file, filp,
-				    buf, count, pos,
+	return ib_uverbs_event_read(&file->ev_queue, filp, buf, count, pos,
 				    sizeof(struct ib_uverbs_async_event_desc));
 }
 
@@ -291,9 +286,8 @@ static ssize_t ib_uverbs_comp_event_read(struct file *filp, char __user *buf,
 	struct ib_uverbs_completion_event_file *comp_ev_file =
 		filp->private_data;
 
-	return ib_uverbs_event_read(&comp_ev_file->ev_queue,
-				    comp_ev_file->uobj.ufile, filp,
-				    buf, count, pos,
+	return ib_uverbs_event_read(&comp_ev_file->ev_queue, filp, buf, count,
+				    pos,
 				    sizeof(struct ib_uverbs_comp_event_desc));
 }
 
@@ -316,7 +310,9 @@ static __poll_t ib_uverbs_event_poll(struct ib_uverbs_event_queue *ev_queue,
 static __poll_t ib_uverbs_async_event_poll(struct file *filp,
 					       struct poll_table_struct *wait)
 {
-	return ib_uverbs_event_poll(filp->private_data, filp, wait);
+	struct ib_uverbs_async_event_file *file = filp->private_data;
+
+	return ib_uverbs_event_poll(&file->ev_queue, filp, wait);
 }
 
 static __poll_t ib_uverbs_comp_event_poll(struct file *filp,
@@ -330,9 +326,9 @@ static __poll_t ib_uverbs_comp_event_poll(struct file *filp,
 
 static int ib_uverbs_async_event_fasync(int fd, struct file *filp, int on)
 {
-	struct ib_uverbs_event_queue *ev_queue = filp->private_data;
+	struct ib_uverbs_async_event_file *file = filp->private_data;
 
-	return fasync_helper(fd, filp, on, &ev_queue->async_queue);
+	return fasync_helper(fd, filp, on, &file->ev_queue.async_queue);
 }
 
 static int ib_uverbs_comp_event_fasync(int fd, struct file *filp, int on)
-- 
1.8.3.1

