Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E7A1C8291
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2020 08:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgEGGeB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 May 2020 02:34:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbgEGGeB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 7 May 2020 02:34:01 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 224682078C;
        Thu,  7 May 2020 06:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588833240;
        bh=3MXTAdeXKlfn05LxTAX6VVlYrGqHEhR0hu3UWVpQPNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PIJf/vLfS+Y1UEadvnqD/OsuFKQKKDHk2jrw+fwNHVflH+2HIAF/CqFEAZFLscB/X
         qPk+3gzCO7EkEgBBZyr6o5eS+DSCE6uHiYpmjdCE2F8/NfknV0HzkRryggj93J2s7H
         lc1KaDXFSPMjqGf6MSPPLKa4hvcT/2Tq2Xo7Se7A=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-rc 2/2] RDMA/uverbs: Move IB_EVENT_DEVICE_FATAL to destroy_uobj
Date:   Thu,  7 May 2020 09:33:48 +0300
Message-Id: <20200507063348.98713-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200507063348.98713-1-leon@kernel.org>
References: <20200507063348.98713-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

When multiple async FDs were allowed to exist the idea what for all
broadcast events to be delivered to all async FDs, however
IB_EVENT_DEVICE_FATAL was missed.

Instead of having ib_uverbs_free_hw_resources() special case the global
async_fd, have it cause the event during the uobject destruction. Every
async fd is now a uobject so simply generate the IB_EVENT_DEVICE_FATAL
while destroying the async fd uobject. This ensures every async FD gets a
copy of the event.

Fixes: d680e88e2013 ("RDMA/core: Add UVERBS_METHOD_ASYNC_EVENT_ALLOC")
Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/uverbs.h                    |  3 +++
 drivers/infiniband/core/uverbs_main.c               | 10 +++-------
 drivers/infiniband/core/uverbs_std_types_async_fd.c |  4 ++++
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
index 2673cb1cd655..3d189c7ee59e 100644
--- a/drivers/infiniband/core/uverbs.h
+++ b/drivers/infiniband/core/uverbs.h
@@ -228,6 +228,9 @@ void ib_uverbs_release_ucq(struct ib_uverbs_completion_event_file *ev_file,
 			   struct ib_ucq_object *uobj);
 void ib_uverbs_release_uevent(struct ib_uevent_object *uobj);
 void ib_uverbs_release_file(struct kref *ref);
+void ib_uverbs_async_handler(struct ib_uverbs_async_event_file *async_file,
+			     __u64 element, __u64 event,
+			     struct list_head *obj_list, u32 *counter);
 
 void ib_uverbs_comp_handler(struct ib_cq *cq, void *cq_context);
 void ib_uverbs_cq_event_handler(struct ib_event *event, void *context_ptr);
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index cb5b59123d8f..1bab8de14757 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -386,10 +386,9 @@ void ib_uverbs_comp_handler(struct ib_cq *cq, void *cq_context)
 	kill_fasync(&ev_queue->async_queue, SIGIO, POLL_IN);
 }
 
-static void
-ib_uverbs_async_handler(struct ib_uverbs_async_event_file *async_file,
-			__u64 element, __u64 event, struct list_head *obj_list,
-			u32 *counter)
+void ib_uverbs_async_handler(struct ib_uverbs_async_event_file *async_file,
+			     __u64 element, __u64 event,
+			     struct list_head *obj_list, u32 *counter)
 {
 	struct ib_uverbs_event *entry;
 	unsigned long flags;
@@ -1187,9 +1186,6 @@ static void ib_uverbs_free_hw_resources(struct ib_uverbs_device *uverbs_dev,
 		 */
 		mutex_unlock(&uverbs_dev->lists_mutex);
 
-		ib_uverbs_async_handler(READ_ONCE(file->async_file), 0,
-					IB_EVENT_DEVICE_FATAL, NULL, NULL);
-
 		uverbs_destroy_ufile_hw(file, RDMA_REMOVE_DRIVER_REMOVE);
 		kref_put(&file->ref, ib_uverbs_release_file);
 
diff --git a/drivers/infiniband/core/uverbs_std_types_async_fd.c b/drivers/infiniband/core/uverbs_std_types_async_fd.c
index 462deb506b16..61899eaf1f91 100644
--- a/drivers/infiniband/core/uverbs_std_types_async_fd.c
+++ b/drivers/infiniband/core/uverbs_std_types_async_fd.c
@@ -26,6 +26,10 @@ static int uverbs_async_event_destroy_uobj(struct ib_uobject *uobj,
 		container_of(uobj, struct ib_uverbs_async_event_file, uobj);
 
 	ib_unregister_event_handler(&event_file->event_handler);
+
+	if (why == RDMA_REMOVE_DRIVER_REMOVE)
+		ib_uverbs_async_handler(event_file, 0, IB_EVENT_DEVICE_FATAL,
+					NULL, NULL);
 	return 0;
 }
 
-- 
2.26.2

