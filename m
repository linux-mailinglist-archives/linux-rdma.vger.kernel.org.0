Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B7D45CF53
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Nov 2021 22:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242430AbhKXVnn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Nov 2021 16:43:43 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:56187 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241959AbhKXVnm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Nov 2021 16:43:42 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id q00BmS3woBazoq00FmFPk9; Wed, 24 Nov 2021 22:40:31 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 24 Nov 2021 22:40:31 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     bharat@chelsio.com, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/3] RDMA/cxgb4: Use bitmap_set() when applicable
Date:   Wed, 24 Nov 2021 22:40:25 +0100
Message-Id: <fd978b837935ed04863ffecfd495c4601a986df6.1637789139.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1637789139.git.christophe.jaillet@wanadoo.fr>
References: <cover.1637789139.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The 'alloc->table' bitmap has just been allocated, so this is safe to use
the faster and non-atomic 'bitmap_set()' function. There is no need to
hand-write it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/infiniband/hw/cxgb4/id_table.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/id_table.c b/drivers/infiniband/hw/cxgb4/id_table.c
index 9d08a48c4926..e09faa659d68 100644
--- a/drivers/infiniband/hw/cxgb4/id_table.c
+++ b/drivers/infiniband/hw/cxgb4/id_table.c
@@ -82,8 +82,6 @@ void c4iw_id_free(struct c4iw_id_table *alloc, u32 obj)
 int c4iw_id_table_alloc(struct c4iw_id_table *alloc, u32 start, u32 num,
 			u32 reserved, u32 flags)
 {
-	int i;
-
 	alloc->start = start;
 	alloc->flags = flags;
 	if (flags & C4IW_ID_TABLE_F_RANDOM)
@@ -97,8 +95,7 @@ int c4iw_id_table_alloc(struct c4iw_id_table *alloc, u32 start, u32 num,
 		return -ENOMEM;
 
 	if (!(alloc->flags & C4IW_ID_TABLE_F_EMPTY))
-		for (i = 0; i < reserved; ++i)
-			set_bit(i, alloc->table);
+		bitmap_set(alloc->table, 0, reserved);
 
 	return 0;
 }
-- 
2.30.2

