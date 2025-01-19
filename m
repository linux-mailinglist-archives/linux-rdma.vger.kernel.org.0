Return-Path: <linux-rdma+bounces-7099-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05133A16357
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 18:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320E53A5F36
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 17:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09E11DE3C0;
	Sun, 19 Jan 2025 17:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FQ4D1UAW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBD61B21AA
	for <linux-rdma@vger.kernel.org>; Sun, 19 Jan 2025 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737307732; cv=none; b=uLXgPtFo7bF2Sq3IVArWxeN2oe3Z4/wtnh2BVz5ldttvsLB6+LkOr3Gh0U5boD2AIXCzybH8aKxbLZOdeM1nGPISFXUlQ58O8I4ni6ZESsg5IFWsGJRmKF9J5QYsqQ6n3PRrti8dG3cdnSzJmyrI7KtWwk2Y4fRul7qqub9682A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737307732; c=relaxed/simple;
	bh=eLgGF/rdRLdff8SHS8qMTtB3HhlOTPEAofy+UBrU1uk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AK2u7JM8qDCin5Bt3kAIsd3QhWajWqNOrLAsWtYEoALsqdTQJ9IGk6xSW24JBFWaVBOR4fO8T/oiO7cI2Y+vXudkg5McYFJ0DgBBN6iQ0z4nmo1PkrJJCVExamANEPJpHKppF1PJi7+/UN6GglITKh4TjKlpOpHvYI2DtxLvgLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FQ4D1UAW; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737307728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NYVKceX/q6XRL3z/pd1rWkpqPx+frEy0JzAYOQYG/Bw=;
	b=FQ4D1UAWACBdFT2xLEDYQASy3BRA/JLm8AGGUViVh1mFSje1dMTGEvTeQWiUOGL6yEBU5Y
	x7lsl4E4vV5pAQUqnuofSjNw2774H0AstrVvzLObhe71SUeUqDa2GXSEQ2/3X08x903Bpi
	8rV4Bm2crZH2RblADhuOWVIu8VN47vs=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	zyjzyj2000@gmail.com,
	linux-rdma@vger.kernel.org
Subject: [PATCH 2/3] RDMA/rxe: Add query_gid support
Date: Sun, 19 Jan 2025 18:28:30 +0100
Message-Id: <20250119172831.3123110-3-yanjun.zhu@linux.dev>
In-Reply-To: <20250119172831.3123110-1-yanjun.zhu@linux.dev>
References: <20250119172831.3123110-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The query_gid is not implemented in RXE. After the raw_gid is added,
this query_gid should be implemented in RXE.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 837566cd682c..22d6312ecbc7 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -79,6 +79,18 @@ static int rxe_query_port(struct ib_device *ibdev,
 	return err;
 }
 
+static int rxe_query_gid(struct ib_device *ibdev, u32 port, int idx,
+			 union ib_gid *gid)
+{
+	struct rxe_dev *rxe = to_rdev(ibdev);
+
+	/* subnet_prefix == interface_id == 0; */
+	memset(gid, 0, sizeof(*gid));
+	memcpy(gid->raw, rxe->raw_gid, ETH_ALEN);
+
+	return 0;
+}
+
 static int rxe_query_pkey(struct ib_device *ibdev,
 			  u32 port_num, u16 index, u16 *pkey)
 {
@@ -1493,6 +1505,7 @@ static const struct ib_device_ops rxe_dev_ops = {
 	.query_ah = rxe_query_ah,
 	.query_device = rxe_query_device,
 	.query_pkey = rxe_query_pkey,
+	.query_gid = rxe_query_gid,
 	.query_port = rxe_query_port,
 	.query_qp = rxe_query_qp,
 	.query_srq = rxe_query_srq,
-- 
2.34.1


