Return-Path: <linux-rdma+bounces-14078-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8B3C1194F
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 22:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1927F4E4434
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 21:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF0D2E62D8;
	Mon, 27 Oct 2025 21:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l8j1c7lt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D072D7DDA
	for <linux-rdma@vger.kernel.org>; Mon, 27 Oct 2025 21:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761601952; cv=none; b=CbTBYRGgyKTUJuquyGiO/prMQkCLlnSifGPLjhgxpOsYGm9fvq4IRlSf+cafhZvESh6bcatIJYrUQmSRHFXnZAdM0E+8AlCReibnatkh/16OsO4Ga7k2R+DzPFi3xXugZOEwZhEnDwUX0OO1hOwMKgb9TuRJOaU7321DLqoonOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761601952; c=relaxed/simple;
	bh=oRQ7UZ3b5/BoWh3JI9cMKIDCgHT/mhx7zm1iyCeJLNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n3FvjHqIrRUZIDc/rf86LsAtGAgAVF2F34sqnvwXCVBEbZIcIpMJbxkgF7SaVP9SWC4pSdWwJKd9mLTaxeNuiYmkMWeegxAtO0rFWYiC6I91619yjQOq6WwsyjMFS1sZHPR8P4rYofrDWXOhgC4PM/FYdjI7Z0nsjgx7NdZdiDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l8j1c7lt; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761601942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r2pIxSnCnPNhUCNA30a8AhVi54JnWaUOvwuCVpkone8=;
	b=l8j1c7ltPsAj8xQ60DlQ8BeSGMF0dHKpnk1kqEpvnr98A7r/i+ARplmM3WnHt58IJe8mqR
	Ekq0hia3AW6eHnpK/gPB3NOP1y+s2qkO1QPr0usfPgBf5wj/WQUhiR07SvVWmwySuLsvlj
	B1IWU1tHJJLZ5NgCVE1VOdJl8Lyw6Z8=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>,
	Liu Yi <asatsuyu.liu@gmail.com>
Subject: [PATCH RDMA V2 1/1] RDMA/rxe: Fix null deref on srq->rq.queue after resize failure
Date: Mon, 27 Oct 2025 14:52:03 -0700
Message-ID: <20251027215203.1321-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

A NULL pointer dereference can occur in rxe_srq_chk_attr() when
ibv_modify_srq() is invoked twice in succession under certain error
conditions. The first call may fail in rxe_queue_resize(), which leads
rxe_srq_from_attr() to set srq->rq.queue = NULL. The second call then
triggers a crash (null deref) when accessing
srq->rq.queue->buf->index_mask.

Call Trace:
<TASK>
rxe_modify_srq+0x170/0x480 [rdma_rxe]
? __pfx_rxe_modify_srq+0x10/0x10 [rdma_rxe]
? uverbs_try_lock_object+0x4f/0xa0 [ib_uverbs]
? rdma_lookup_get_uobject+0x1f0/0x380 [ib_uverbs]
ib_uverbs_modify_srq+0x204/0x290 [ib_uverbs]
? __pfx_ib_uverbs_modify_srq+0x10/0x10 [ib_uverbs]
? tryinc_node_nr_active+0xe6/0x150
? uverbs_fill_udata+0xed/0x4f0 [ib_uverbs]
ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x2c0/0x470 [ib_uverbs]
? __pfx_ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x10/0x10 [ib_uverbs]
? uverbs_fill_udata+0xed/0x4f0 [ib_uverbs]
ib_uverbs_run_method+0x55a/0x6e0 [ib_uverbs]
? __pfx_ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x10/0x10 [ib_uverbs]
ib_uverbs_cmd_verbs+0x54d/0x800 [ib_uverbs]
? __pfx_ib_uverbs_cmd_verbs+0x10/0x10 [ib_uverbs]
? __pfx___raw_spin_lock_irqsave+0x10/0x10
? __pfx_do_vfs_ioctl+0x10/0x10
? ioctl_has_perm.constprop.0.isra.0+0x2c7/0x4c0
? __pfx_ioctl_has_perm.constprop.0.isra.0+0x10/0x10
ib_uverbs_ioctl+0x13e/0x220 [ib_uverbs]
? __pfx_ib_uverbs_ioctl+0x10/0x10 [ib_uverbs]
__x64_sys_ioctl+0x138/0x1c0
do_syscall_64+0x82/0x250
? fdget_pos+0x58/0x4c0
? ksys_write+0xf3/0x1c0
? __pfx_ksys_write+0x10/0x10
? do_syscall_64+0xc8/0x250
? __pfx_vm_mmap_pgoff+0x10/0x10
? fget+0x173/0x230
? fput+0x2a/0x80
? ksys_mmap_pgoff+0x224/0x4c0
? do_syscall_64+0xc8/0x250
? do_user_addr_fault+0x37b/0xfe0
? clear_bhb_loop+0x50/0xa0
? clear_bhb_loop+0x50/0xa0
? clear_bhb_loop+0x50/0xa0
entry_SYSCALL_64_after_hwframe+0x76/0x7e

Reported-by: Liu Yi <asatsuyu.liu@gmail.com>
Fixes: 8700e3e7c485 ("Soft RoCE driver")
Tested-by: Liu Yi <asatsuyu.liu@gmail.com>
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
V1->V2: Remove err_free label and modify the commit logs,
        rebase to rdma repository.
---
 drivers/infiniband/sw/rxe/rxe_srq.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
index 3661cb627d28..2a234f26ac10 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -171,7 +171,7 @@ int rxe_srq_from_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 				       udata, mi, &srq->rq.producer_lock,
 				       &srq->rq.consumer_lock);
 		if (err)
-			goto err_free;
+			return err;
 
 		srq->rq.max_wr = attr->max_wr;
 	}
@@ -180,11 +180,6 @@ int rxe_srq_from_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 		srq->limit = attr->srq_limit;
 
 	return 0;
-
-err_free:
-	rxe_queue_cleanup(q);
-	srq->rq.queue = NULL;
-	return err;
 }
 
 void rxe_srq_cleanup(struct rxe_pool_elem *elem)
-- 
2.51.0


