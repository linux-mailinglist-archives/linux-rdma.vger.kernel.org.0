Return-Path: <linux-rdma+bounces-15571-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C38D23B7A
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 10:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 17AF1302CA8A
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 09:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E0835BDD9;
	Thu, 15 Jan 2026 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VDdg3qnW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9E81E5714;
	Thu, 15 Jan 2026 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469786; cv=none; b=YHU15A0+tbVAFQ/RUdwBHg/dMl1YNryjrhmwJGZxlW60jao+MOfHFiFP1uKQn7fxXTcBBD72uFMdvpz8C1AWyuZakIF/mgypsr2eXsLoXEwhHvgOsJMWdM4l2o/O9e/4ybusp8ZQ+U71b6OOofkagj6GmlVuDbiSoiJiEB4PhgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469786; c=relaxed/simple;
	bh=xQxEaqH4wba/vNuwXbmJUd5EZab78YcBzbqSMchNWxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EXsGdYUM2zgjqQXxMylheLbsPASR5iXJk8yF9Di0Yu8XfmEggh3v1ZVycJPgF+RAmTX1/p5jaC8Kb3RysERKtNp2XwJuTppw7pGS/7Aq6QdisltuBua5QBChLWPQ3TcnK47iczK7r/69lFAQ4mzycrBGrEkdTcI68TXK8g2e3A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VDdg3qnW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id 0FDF920B7165; Thu, 15 Jan 2026 01:36:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0FDF920B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768469785;
	bh=k8PqDCsP5V15sWMgIxygyRQXgjNht3sJfTLhdwWNz40=;
	h=From:To:Cc:Subject:Date:From;
	b=VDdg3qnWroik5ta82Id59mymr4MHR7lVa28ss7jMECusr9LfYkvvy8dtKhWRS2Mi4
	 9Y0dvuaFjaU1n37fiOr9i6iDqlhV6efsCU5+r79XLnP1XnJ/h2w3RK7n5PMB3/oxq4
	 R3KGT9NNB7z23eiSMcJkd8YB0p1cFbLqGaO+y7cE=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	shirazsaleem@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v2 1/1] RDMA/mana_ib: take CQ type from the device type
Date: Thu, 15 Jan 2026 01:36:25 -0800
Message-ID: <20260115093625.177306-1-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konstantin Taranov <kotaranov@microsoft.com>

Get CQ type from the used gdma device. The MANA_IB_CREATE_RNIC_CQ
flag is ignored. It was used in older kernel versions where
the mana_ib was shared between ethernet and rnic.

Fixes: d4293f96ce0b ("RDMA/mana_ib: unify mana_ib functions to support any gdma device")
Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
v2: added comment that the flag is reserved
 drivers/infiniband/hw/mana/cq.c | 4 +---
 include/uapi/rdma/mana-abi.h    | 3 +++
 2 files changed, 4 insertions(+), 3 deletions(-)

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
diff --git a/include/uapi/rdma/mana-abi.h b/include/uapi/rdma/mana-abi.h
index 45c2df619..a75bf32b8 100644
--- a/include/uapi/rdma/mana-abi.h
+++ b/include/uapi/rdma/mana-abi.h
@@ -17,6 +17,9 @@
 #define MANA_IB_UVERBS_ABI_VERSION 1
 
 enum mana_ib_create_cq_flags {
+	/* Reserved for backward compatibility. Legacy
+	 * kernel versions use it to create CQs in RNIC
+	 */
 	MANA_IB_CREATE_RNIC_CQ	= 1 << 0,
 };
 
-- 
2.43.0


