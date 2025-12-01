Return-Path: <linux-rdma+bounces-14838-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C8651C95A56
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Dec 2025 04:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CB35434204C
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Dec 2025 03:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522BA1DB13A;
	Mon,  1 Dec 2025 03:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QJStc96g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324A51B0437;
	Mon,  1 Dec 2025 03:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764559562; cv=none; b=S2FYNgfZfxc0iEpUHbUA84sCrn5FgkkaNvLRrMyR6nXyuuykPua07+6iogM076K8wpK7yIaKVm4OTzQzO3C5iYvmXE0AAT4YYTWGVH91gSXlZ5yksH4Hmn+Jiq/Kef7uHqPoLUoQ7lgw4BwaqG3gcCiDvqeMiSUxppubM/vw6HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764559562; c=relaxed/simple;
	bh=zfBifsntN4vG8WbJlKPz1R2BTQH6mh1T2+SW5UUmtsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lKG3Jn57/DtVJmRYzAAWgc01L6gOiK9n0l9ObuqkKgTwmJAMz71aUzyAoaQflJfF9GSZh84MGTfIMqRjDREAeCF7qKtaoHkkOxBuE3tG4Afw8MQaSPzVyPgA38yhy9fIgi6Wrx3rxC9PZNH18+t4Ua9svmHi+sdQChsGga9ICp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QJStc96g; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=/B
	rluZetnGcifTzOmD/Gybqi5PVaohcEE7gcO3QN16Q=; b=QJStc96ge35Cgn8eQF
	9YV7R4+EZGwmfq8mBBynAOG5BzrQo2Xgmv2pDmh/CKzyZ0422ayvVVtIC1H6UEph
	lMa2w4WHl0ckojAqLdtrmoCoypZsvnCOtBqmBK/hQkrxsRIJJgwqm8xCXHAx05+X
	3eQEN0jrkz+itBlR365qRoqsE=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3X4SpCi1p1J13DQ--.46179S2;
	Mon, 01 Dec 2025 11:25:32 +0800 (CST)
From: Honggang LI <honggangli@163.com>
To: haris.iqbal@ionos.com,
	jinpu.wang@ionos.com
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	danil.kipnis@cloud.ionos.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Honggang LI <honggangli@163.com>
Subject: [PATCH] RDMA/rtrs: remove dead code
Date: Mon,  1 Dec 2025 11:24:05 +0800
Message-ID: <20251201032405.484231-1-honggangli@163.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X4SpCi1p1J13DQ--.46179S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr1fCrW8Kw4fAr4kCFyrCrg_yoWDWrcEgF
	s7Jr97JFyDCF1vya4YvFsxury0kw4UZws3J3ZxKwsIy3y7tFW5Xw1kXF48X3W5Xw4UCFnr
	Cw4xKrykKr4xtjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRiIJPPUUUUU==
X-CM-SenderInfo: 5krqwwxdqjzxi6rwjhhfrp/1tbiOhAXRWktB4huwAAAsd

As rkey had been initialized to zero, the WARN_ON_ONCE should never been
triggered. Remove it.

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Signed-off-by: Honggang LI <honggangli@163.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index ef4abdea3c2d..a95640e848a5 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -240,11 +240,7 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 	wr->wr.num_sge	= 1;
 	wr->remote_addr	= le64_to_cpu(id->rd_msg->desc[0].addr);
 	wr->rkey	= le32_to_cpu(id->rd_msg->desc[0].key);
-	if (rkey == 0)
-		rkey = wr->rkey;
-	else
-		/* Only one key is actually used */
-		WARN_ON_ONCE(rkey != wr->rkey);
+	rkey = wr->rkey;
 
 	wr->wr.opcode = IB_WR_RDMA_WRITE;
 	wr->wr.wr_cqe   = &io_comp_cqe;
-- 
2.51.1


