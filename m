Return-Path: <linux-rdma+bounces-14381-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F00C4C0D1
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 08:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D8E413445E8
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 07:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9468D2459C9;
	Tue, 11 Nov 2025 07:17:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83EB1E1A05
	for <linux-rdma@vger.kernel.org>; Tue, 11 Nov 2025 07:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762845427; cv=none; b=M43f43EFrhNvpqDzHck8gj5utfQ/3Etbyo0g129Lr0sav8kjiHWX5X2/U3YH7sv1wl5KFsov1rwvcc3zXwhwck/KWXoYfkHoi48NiBByD8WsydPVM9Po/IrGbpjBY6I/LEQ3EyODJj2rN3B4xQWiEiHaolIPJlAUsPL0FuXlNdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762845427; c=relaxed/simple;
	bh=t8qb8ngGkt9bhx64coBCZ6S3V1qSjZaLVEavm3uE1SI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ig5k+swQnKKbA+/3itAumvtooe+f1pOH7fbHK148OpfImaPGcp2duHx47PjISZcFVZNBFlthCPBwM/y5gH23KBQu1LCZQe+SvkdHTdFPmA8kNFdUJ8C3f4Yc/WSqB3MpGCbB7BwR2x7//2FkdinQQpxlEIdG8CtTt5Md73hYUz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	<linux-rdma@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] RDMA/core: Prevent soft lockup during large user memory region cleanup
Date: Tue, 11 Nov 2025 15:01:07 +0800
Message-ID: <20251111070107.2627-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc13.internal.baidu.com (172.31.51.13) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

When a process exits with numerous large, pinned memory regions consisting
of 4KB pages, the cleanup of the memory region through __ib_umem_release()
may cause soft lockups. This is because unpin_user_page_range_dirty_lock()
is called in a tight loop for unpin and releasing page without yielding the
CPU.

Fix the soft lockup by adding cond_resched() calls in __ib_umem_release

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/infiniband/core/umem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index c5b6863..70c1520 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -59,6 +59,7 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
 		unpin_user_page_range_dirty_lock(sg_page(sg),
 			DIV_ROUND_UP(sg->length, PAGE_SIZE), make_dirty);
 
+	cond_resched();
 	sg_free_append_table(&umem->sgt_append);
 }
 
-- 
2.9.4


