Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0F128AD69
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Oct 2020 06:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgJLE4U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Oct 2020 00:56:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgJLE4T (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Oct 2020 00:56:19 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 518212076C;
        Mon, 12 Oct 2020 04:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602478579;
        bh=rgesGTZtS+Q/witwdtwW8dBw4+gv/G6kpFE0gVB1/bk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XwIfvW2Brb+pFTnFxkVbD4c152536JQpCGLF62wHoUlmxJcZuJa9GevhUQPvxSlbt
         SHhTqDL9+ZdZCI1WbrbmCVOAtUtZ9wSK9xvQ5aVJiIQu2rdVs9hKYOxZrHipztzYkH
         s7J8zA2FqAsp4p8aUcDDTJZA8ZTSkzIp/ux+m8Ew=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc 3/3] RDMA/ucma: Fix use after free in destroy id flow
Date:   Mon, 12 Oct 2020 07:56:00 +0300
Message-Id: <20201012045600.418271-4-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012045600.418271-1-leon@kernel.org>
References: <20201012045600.418271-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@nvidia.com>

ucma_free_ctx should call to __destroy_id on all the connection
requests that have not been delivered to user space. Currently
it calls on the context itself and cause to use after free.

Fixes the below trace:
BUG: Unable to handle kernel data access on write at
0x5deadbeef0000108
Faulting instruction address: 0xc0080000002428f4
Oops: Kernel access of bad area, sig: 11 [#1]
Call Trace:
[c000000207f2b680] [c00800000024280c] .__destroy_id+0x28c/0x610 [rdma_ucm] (unreliable)
[c000000207f2b750] [c0080000002429c4] .__destroy_id+0x444/0x610 [rdma_ucm]
[c000000207f2b820] [c008000000242c24] .ucma_close+0x94/0xf0 [rdma_ucm]
[c000000207f2b8c0] [c00000000046fbdc] .__fput+0xac/0x330
[c000000207f2b960] [c00000000015d48c] .task_work_run+0xbc/0x110
[c000000207f2b9f0] [c00000000012fb00] .do_exit+0x430/0xc50
[c000000207f2bae0] [c0000000001303ec] .do_group_exit+0x5c/0xd0
[c000000207f2bb70] [c000000000144a34] .get_signal+0x194/0xe30
[c000000207f2bc60] [c00000000001f6b4] .do_notify_resume+0x124/0x470
[c000000207f2bd60] [c000000000032484]
.interrupt_exit_user_prepare+0x1b4/0x240
[c000000207f2be20] [c000000000010034] interrupt_return+0x14/0x1c0
Instruction dump:
7d094378 3906ffe8 4082ffa8 3f205dea 3f405dea e95d0120 e91d0118
6339dbee
635adbee e93f0888 7b3907c6 7b5a07c6 <f9480008> 6739f000 f90a0000
675af000
---[ end trace 9796e2b012b61b83 ]---

Fixes: a1d33b70dbbc ("RDMA/ucma: Rework how new connections are passed through event delivery")
Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/ucma.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 08a628246bd6..ffe2563ad345 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -112,7 +112,7 @@ struct ucma_multicast {

 struct ucma_event {
 	struct ucma_context	*ctx;
-	struct ucma_context	*listen_ctx;
+	struct ucma_context	*conn_req_ctx;
 	struct ucma_multicast	*mc;
 	struct list_head	list;
 	struct rdma_ucm_event_resp resp;
@@ -308,7 +308,7 @@ static int ucma_connect_event_handler(struct rdma_cm_id *cm_id,
 	uevent = ucma_create_uevent(listen_ctx, event);
 	if (!uevent)
 		goto err_alloc;
-	uevent->listen_ctx = listen_ctx;
+	uevent->conn_req_ctx = ctx;
 	uevent->resp.id = ctx->id;

 	ctx->cm_id->context = ctx;
@@ -534,7 +534,7 @@ static int ucma_free_ctx(struct ucma_context *ctx)
 	/* Cleanup events not yet reported to the user. */
 	mutex_lock(&ctx->file->mut);
 	list_for_each_entry_safe(uevent, tmp, &ctx->file->event_list, list) {
-		if (uevent->ctx == ctx || uevent->listen_ctx == ctx)
+		if (uevent->ctx == ctx || uevent->conn_req_ctx == ctx)
 			list_move_tail(&uevent->list, &list);
 	}
 	list_del(&ctx->list);
@@ -548,8 +548,9 @@ static int ucma_free_ctx(struct ucma_context *ctx)
 	 */
 	list_for_each_entry_safe(uevent, tmp, &list, list) {
 		list_del(&uevent->list);
-		if (uevent->resp.event == RDMA_CM_EVENT_CONNECT_REQUEST)
-			__destroy_id(uevent->ctx);
+		if (uevent->resp.event == RDMA_CM_EVENT_CONNECT_REQUEST &&
+		    uevent->conn_req_ctx != ctx)
+			__destroy_id(uevent->conn_req_ctx);
 		kfree(uevent);
 	}

--
2.26.2

