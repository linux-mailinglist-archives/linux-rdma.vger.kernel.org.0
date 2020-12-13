Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186E72D8D49
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Dec 2020 14:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394646AbgLMNau (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Dec 2020 08:30:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:53656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394650AbgLMNak (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 13 Dec 2020 08:30:40 -0500
From:   Leon Romanovsky <leon@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc 5/5] RDMA/ucma: Fix memory leak of connection request
Date:   Sun, 13 Dec 2020 15:29:40 +0200
Message-Id: <20201213132940.345554-6-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201213132940.345554-1-leon@kernel.org>
References: <20201213132940.345554-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@nvidia.com>

Add missing call to xa_erase when destroy connection request.
It fixes the below memory leak.

unreferenced object 0xffff88812a340490 (size 576):
comm “kworker/5:0”, pid 96291, jiffies 4296565270 (age 1835.596s)
hex dump (first 32 bytes):
00 20 03 00 00 00 00 00 00 00 00 00 00 00 00 00 . …………..
a0 d3 1a a0 ff ff ff ff a8 04 34 2a 81 88 ff ff ……….4*….
backtrace:
[<0000000059399d4c>] xas_alloc+0x94/0xb0
[<00000000d855673c>] xas_create+0x1f4/0×4c0
[<00000000336166d1>] xas_store+0x52/0×5e0
[<000000006b811da0>] __xa_alloc+0xab/0×140
[<00000000cf0e9936>] ucma_alloc_ctx+0x197/0×1f0 [rdma_ucm]
[<000000008f99b6bb>] ucma_event_handler+0x17b/0×2e0 [rdma_ucm]
[<000000000a07fc34>] cma_cm_event_handler+0x6f/0×390 [rdma_cm]
[<00000000fe05d574>] cma_ib_req_handler+0x1163/0×2370 [rdma_cm]
[<000000004516baf4>] cm_work_handler+0xeda/0×2340 [ib_cm]
[<000000008a83945b>] process_one_work+0x27c/0×610
[<00000000b71b71e2>] worker_thread+0x2d/0×3c0
[<00000000caab54ff>] kthread+0x125/0×140
[<000000004303d699>] ret_from_fork+0x1f/0×30

Fixes: a1d33b70dbbc ("RDMA/ucma: Rework how new connections are passed through event delivery")
Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/ucma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 7dab9a27a145..b0b9ea90a27d 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -549,8 +549,10 @@ static int ucma_free_ctx(struct ucma_context *ctx)
 	list_for_each_entry_safe(uevent, tmp, &list, list) {
 		list_del(&uevent->list);
 		if (uevent->resp.event == RDMA_CM_EVENT_CONNECT_REQUEST &&
-		    uevent->conn_req_ctx != ctx)
+		    uevent->conn_req_ctx != ctx) {
+			xa_erase(&ctx_table, uevent->conn_req_ctx->id);
 			__destroy_id(uevent->conn_req_ctx);
+		}
 		kfree(uevent);
 	}

--
2.29.2

