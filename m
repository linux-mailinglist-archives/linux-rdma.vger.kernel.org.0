Return-Path: <linux-rdma+bounces-15138-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D201CD4702
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 00:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 795653003BDB
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 23:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E236A281357;
	Sun, 21 Dec 2025 23:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LuhEny4U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E31E24E4C3
	for <linux-rdma@vger.kernel.org>; Sun, 21 Dec 2025 23:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766360091; cv=none; b=XJehx6WWgGl0eR0HZSL60VuJ2lCWpiYxJtc+dt7EK/Ife3Py1eTuE/1iNW6cAm8niQbPuwGUwjQmx1Td1iM/MZDnKnhVH/JkWmnkOtyeX5e981Nh12suUfmwqfsjF91I3oc23k+7EBmUj06Usg6Z52bdQZvpYT5UcR2XYW/i7Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766360091; c=relaxed/simple;
	bh=FDPQAOFQ+Eab/e3x5CkS2ulRE4hZZ1o8g2esB2iVODQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jh6KXsWqiDVUl4A4nu/d0Ag8cNO4aIBUe4jTf1E6kYSM0G4T0c37PHEMV0nwEnFMEeJGsNnOSbjge9Gs2tJsuYp3VV2Ak/G+MN+JJqP6Ea8kOYQ24ff4UNDvcIvZiByip4VqwBMjH8vw3uB/6G2wzM6XsIYBIKBMFcZPb2UiP44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LuhEny4U; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766360087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NxSmCTpIhS01vsEOYi+6c0LnmInYC9xfqz1Ki84BGL0=;
	b=LuhEny4Uo/n3zDm5YHwC486nlNKG3puTdnqg3vV+4257g0O+zWEBO/BfRGW8HHN6BSEZHB
	82oQw/71Mz9SjF7aLFcXNzRz8Fdqmvkx4UHGyIv2g3RVcjdNeORPVuQ5uJKLP9yKzGypAu
	MiD6rsNoz5sY17sndYgvIoqQsdD1/ZQ=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH v2 2/2] RDMA/rxe: Replace struct rxe_sge with struct ib_sge
Date: Sun, 21 Dec 2025 18:34:04 -0500
Message-Id: <20251221233404.332108-2-yanjun.zhu@linux.dev>
In-Reply-To: <20251221233404.332108-1-yanjun.zhu@linux.dev>
References: <20251221233404.332108-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The struct rxe_sge is the same with struct ib_sge. Thus,
the struct rxe_sge can be repaced with the struct ib_sge.

No functional changes.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_mr.c   | 4 ++--
 drivers/infiniband/sw/rxe/rxe_resp.c | 2 +-
 include/uapi/rdma/rdma_user_rxe.h    | 8 +-------
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index b1df05238848..ac31cc599f13 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -341,7 +341,7 @@ int copy_data(
 	enum rxe_mr_copy_dir	dir)
 {
 	int			bytes;
-	struct rxe_sge		*sge	= &dma->sge[dma->cur_sge];
+	struct	ib_sge *sge	= &dma->sge[dma->cur_sge];
 	int			offset	= dma->sge_offset;
 	int			resid	= dma->resid;
 	struct rxe_mr		*mr	= NULL;
@@ -580,7 +580,7 @@ enum resp_states rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length)
 {
-	struct rxe_sge		*sge	= &dma->sge[dma->cur_sge];
+	struct	ib_sge *sge	= &dma->sge[dma->cur_sge];
 	int			offset	= dma->sge_offset;
 	int			resid	= dma->resid;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 711f73e0bbb1..74f5b695da7a 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -283,7 +283,7 @@ static enum resp_states get_srq_wqe(struct rxe_qp *qp)
 		rxe_dbg_qp(qp, "invalid num_sge in SRQ entry\n");
 		return RESPST_ERR_MALFORMED_WQE;
 	}
-	size = sizeof(*wqe) + wqe->dma.num_sge*sizeof(struct rxe_sge);
+	size = sizeof(*wqe) + wqe->dma.num_sge*sizeof(struct ib_sge);
 	memcpy(&qp->resp.srq_wqe, wqe, size);
 
 	qp->resp.wqe = &qp->resp.srq_wqe.wqe;
diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index bb092fccb813..74eaae779c81 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -132,12 +132,6 @@ struct rxe_send_wr {
 	} wr;
 };
 
-struct rxe_sge {
-	__aligned_u64 addr;
-	__u32	length;
-	__u32	lkey;
-};
-
 struct mminfo {
 	__aligned_u64		offset;
 	__u32			size;
@@ -154,7 +148,7 @@ struct rxe_dma_info {
 	union {
 		__DECLARE_FLEX_ARRAY(__u8, inline_data);
 		__DECLARE_FLEX_ARRAY(__u8, atomic_wr);
-		__DECLARE_FLEX_ARRAY(struct rxe_sge, sge);
+		__DECLARE_FLEX_ARRAY(struct ib_sge, sge);
 	};
 };
 
-- 
2.39.5


