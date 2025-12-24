Return-Path: <linux-rdma+bounces-15210-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3273CDBDCB
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Dec 2025 10:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CABF3079712
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Dec 2025 09:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03A02FFDEC;
	Wed, 24 Dec 2025 09:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PAYVbZAR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A122340A72;
	Wed, 24 Dec 2025 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766569898; cv=none; b=FtoG21f+fjWp6+nB627f7OB4KhizOh54PMhi2DBi5YZYvmkDBq7T8GZvcX6VxsrPJmRd8EaZCr1vJ+do0A9NwFseeheYnLykq6HI0+F0hc2pYIFzinsV9LDzqjtNbJ7tVQr2JhF9fcbI+ZWekVsnxgS/UhQeqpFnCacgq+K+lTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766569898; c=relaxed/simple;
	bh=yw2fYu0PPFjo0dAfqlENDaFVIlGH8hBG1/SQoNs17Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IESRl4ZYQrjY2Gd4BaH5zcZ/QHTxfmvwfo9rDXjFuJeDjb4Tn/MVjAFziDLac0e8VivNWznNCNS07AzoIwv58HPzVSWtDBsOnyQ1wqYBYgCUNXiCcWiZZy249gLKB1sYD/27Wra5dTldyYlYO3S+qfuF85fa8ED7ItG0otisQxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PAYVbZAR; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=0v
	JPRDSR/EH9t8/kf6i7PS8sTqbOLtbglU2gMkfbSJc=; b=PAYVbZARTaRonco37B
	L9MJme6D/NYFqT+3c2DFA7x5f+q9BrATPDJ5ivurDGOugizbK/3aCihGnhEX0K5v
	Bnt9ocsvl3DtiV1DHz1I/P0IgyyBnr3KuEWKhomJe7pCbw2lxC6zgIZr5sF/+rTq
	Y3xNMDgjBGI6eSnsrnbypQaQo=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wAHUMCDt0tp8yb_CA--.15323S2;
	Wed, 24 Dec 2025 17:51:00 +0800 (CST)
From: Honggang LI <honggangli@163.com>
To: haris.iqbal@ionos.com,
	jinpu.wang@ionos.com
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	danil.kipnis@cloud.ionos.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Honggang LI <honggangli@163.com>
Subject: [PATCH v2] RDMA/rtrs: client: Fix clt_path::max_pages_per_mr calculation
Date: Wed, 24 Dec 2025 17:50:30 +0800
Message-ID: <20251224095030.156465-1-honggangli@163.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHUMCDt0tp8yb_CA--.15323S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr4kWr1kXF1rGrWkWF4Durg_yoW8Jw1fpF
	WfAryqvw17JF47Kan2v34kZry3uwsxArWvgr92v34rWFnYq342qryvk34UWr1DJr1DZrWa
	qF4UXF4kKayI93DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRvksfUUUUU=
X-CM-SenderInfo: 5krqwwxdqjzxi6rwjhhfrp/xtbCwwU8gWlLt4UohwAA3E

If device max_mr_size bits in the range [mr_page_shift+31:mr_page_shift]
are zero, the `min3` function will set clt_path::max_pages_per_mr to
zero.

`alloc_path_reqs` will pass zero, which is invalid, as the third parameter
to `ib_alloc_mr`.

v1 -> v2:
Correct the commit message and set max_pages_per_mr to U32_MAX
as Michael Gur suggested.
Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Signed-off-by: Honggang LI <honggangli@163.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 71387811b281..e477d2c0ff35 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1464,6 +1464,8 @@ static void query_fast_reg_mode(struct rtrs_clt_path *clt_path)
 	mr_page_shift      = max(12, ffs(ib_dev->attrs.page_size_cap) - 1);
 	max_pages_per_mr   = ib_dev->attrs.max_mr_size;
 	do_div(max_pages_per_mr, (1ull << mr_page_shift));
+	if ((u32)max_pages_per_mr == 0)
+		max_pages_per_mr = U32_MAX;
 	clt_path->max_pages_per_mr =
 		min3(clt_path->max_pages_per_mr, (u32)max_pages_per_mr,
 		     ib_dev->attrs.max_fast_reg_page_list_len);
-- 
2.52.0


