Return-Path: <linux-rdma+bounces-15402-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D219D09E9E
	for <lists+linux-rdma@lfdr.de>; Fri, 09 Jan 2026 13:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17D22317092D
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jan 2026 12:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA92C35971B;
	Fri,  9 Jan 2026 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cLCNezeJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822ED336EDA;
	Fri,  9 Jan 2026 12:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962251; cv=none; b=ZJZ/f53D4Ey4gy5O88XyxLrm7LTkRaSiYVraEplmGd7iBRfY0TdFBREGKGGYPkxPz21TX/Mq2clvj4bloKymsUsyRBC3KOISu82pqQYUGQ7CTbuwMQwm9kJcqGVZJNYWySBdQGtc6mMOwrz3tvRJ3eQ4VHWveTGH6GlpmJ0xebI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962251; c=relaxed/simple;
	bh=8pDDfY7TDl2vdKSx/8E0/tRnOGT+/B2sMv3x6LMfcqc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=EW98xmmY9e4RnckXZFzu4SvBxMX1wxK7dD/jNZo7Y+0PUL/ZAC1tOfwt0612q6XgYul3a3GvQLf3JtFppQicjEd6la2JMXmj8Bk66qFp9nvTTrEjEMaq0NVqu2tZPARu4ikwKdv6ncuI3LFikl5bFk8IHAMKzXL7Ef8k82o4emA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cLCNezeJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id 333FA201AC6B; Fri,  9 Jan 2026 04:37:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 333FA201AC6B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767962250;
	bh=EXT/ImmfH7DzAjHJomYxcMYRtAUxh3OJ4GJBQG7DiBY=;
	h=From:To:Cc:Subject:Date:From;
	b=cLCNezeJ11+lFhI1tHs1sLrPvZw6zjvR2z7HLfgnhMt7lbG8vVS1Zis7LnzjvXr8w
	 mCIXTl0t482/tJY9LqUVK553LD2wfXNVjoybCDIWHRHLSyvl0wuaL78Z5WB3Srvj2a
	 WSUe8PGrl4kitQbg6z8tDEXeDMLXdQpo6HNzC9Bk=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	shirazsaleem@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 1/1] RDMA/mana_ib: take CQ type from the device type
Date: Fri,  9 Jan 2026 04:37:30 -0800
Message-Id: <1767962250-2118-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Get CQ type from the used gdma device. The MANA_IB_CREATE_RNIC_CQ
flag is ignored. It was used in older kernel versions where
the mana_ib was shared between ethernet and rnic.

Fixes: d4293f96ce0b ("RDMA/mana_ib: unify mana_ib functions to support any gdma device")
Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/cq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index 1becc8779..2dce1b677 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -24,6 +24,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 	cq->comp_vector = attr->comp_vector % ibdev->num_comp_vectors;
 	cq->cq_handle = INVALID_MANA_HANDLE;
+	is_rnic_cq = mana_ib_is_rnic(mdev);
 
 	if (udata) {
 		if (udata->inlen < offsetof(struct mana_ib_create_cq, flags))
@@ -35,8 +36,6 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 			return err;
 		}
 
-		is_rnic_cq = !!(ucmd.flags & MANA_IB_CREATE_RNIC_CQ);
-
 		if ((!is_rnic_cq && attr->cqe > mdev->adapter_caps.max_qp_wr) ||
 		    attr->cqe > U32_MAX / COMP_ENTRY_SIZE) {
 			ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr->cqe);
@@ -55,7 +54,6 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 							  ibucontext);
 		doorbell = mana_ucontext->doorbell;
 	} else {
-		is_rnic_cq = true;
 		buf_size = MANA_PAGE_ALIGN(roundup_pow_of_two(attr->cqe * COMP_ENTRY_SIZE));
 		cq->cqe = buf_size / COMP_ENTRY_SIZE;
 		err = mana_ib_create_kernel_queue(mdev, buf_size, GDMA_CQ, &cq->queue);
-- 
2.43.0


