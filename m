Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1B41C6A3A
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 09:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgEFHlW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 03:41:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgEFHlV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 May 2020 03:41:21 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E670220735;
        Wed,  6 May 2020 07:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588750881;
        bh=ALMxftaQhlIJUaBfOSipB4QV6LN6HWgThKOJEoKDj9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I/yNv1ax1qY7Zre+ei28jJO6V2CUwsS4aBJfHBbWYfFyKORXaU2gwn7yXV6raA7Rq
         ydLMot9aBmrfC7PTW29eQoawEkgA/YSd23VJUQnJdWLiex6j9bHvzGQCHOf8Wg/vVq
         2mA0SU4T8/4PJJCwYIM2bcbpnvWjyoSwuUjLd0b8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org,
        Sagi Grimberg <sagi@rimberg.me>
Subject: [PATCH rdma-next 7/9] IB/uverbs: Fix create WQ to use the given user handle
Date:   Wed,  6 May 2020 10:40:47 +0300
Message-Id: <20200506074049.8347-8-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506074049.8347-1-leon@kernel.org>
References: <20200506074049.8347-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

Fix create WQ to use the given user handle, in addition dropped some
duplicated code from this flow.

Fixes: fd3c7904db6e ("IB/core: Change idr objects to use the new schema")
Fixes: f213c0527210 ("IB/uverbs: Add WQ support")
Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index d1971169d9b0..c72e53c8533e 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -2970,6 +2970,7 @@ static int ib_uverbs_ex_create_wq(struct uverbs_attr_bundle *attrs)
 	wq_init_attr.event_handler = ib_uverbs_wq_event_handler;
 	wq_init_attr.create_flags = cmd.create_flags;
 	INIT_LIST_HEAD(&obj->uevent.event_list);
+	obj->uevent.uobject.user_handle = cmd.user_handle;
 
 	wq = pd->device->ops.create_wq(pd, &wq_init_attr, &attrs->driver_udata);
 	if (IS_ERR(wq)) {
@@ -2986,8 +2987,6 @@ static int ib_uverbs_ex_create_wq(struct uverbs_attr_bundle *attrs)
 	atomic_set(&wq->usecnt, 0);
 	atomic_inc(&pd->usecnt);
 	atomic_inc(&cq->usecnt);
-	wq->uobject = obj;
-	obj->uevent.uobject.object = wq;
 	obj->uevent.event_file = attrs->ufile->default_async_file;
 	if (obj->uevent.event_file)
 		uverbs_uobject_get(&obj->uevent.event_file->uobj);
-- 
2.26.2

