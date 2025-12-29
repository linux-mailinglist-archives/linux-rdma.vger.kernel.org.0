Return-Path: <linux-rdma+bounces-15234-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B187ECE5C3C
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Dec 2025 03:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C2B03007954
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Dec 2025 02:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C1225DB1A;
	Mon, 29 Dec 2025 02:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NJfbDsaE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF602580DE;
	Mon, 29 Dec 2025 02:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766977042; cv=none; b=eJmyDH0xcARfGWl0jB/YYzkN4e6CjlRA+kZat4R3OhhlO1AGoPRirkNLPAVw+KOcluYa/rsjGD9uKmQoOSH+T66cfEGnxHtxjlwRVxjnOjIteQVARewUxqFP4sKqViBbi33eN02qq2/3OM4lsRMq/N6Jh+6TB2D1IDdWOy5BL5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766977042; c=relaxed/simple;
	bh=RHrJ7c20CNlTMKbfp7jtUCGPgEt43f+mBG1dpsPifOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KPqmBYQuWq3rixsWjTsjnHjgqM9d+d7vMPpfVmjyJw9bg/NK0ugdNZxfUhSsU5cdUnS7o7iUkh9u73wiJTx7luzh7BPSHeqrJm5HUP3NlApXEI92/pBvI7X4vun2c7DOjtYEfuhH0a6h6sRog/yboB/tdhA2cIknQJ+0crjIVl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NJfbDsaE; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=3y
	9aIO7gaTSCFRWziBB07R3/lMUL4QaGinizzH1qIPw=; b=NJfbDsaEELQJ1jodXl
	KmCEGpqcQ9ucIMh1KXqq87ls6Jq0i2UPEGAcstxRn9JiGXe/f2HVFd+JCQ4Bn3kv
	OQ7aMFQlb/Vpve65HhS4whXDUt1TSlMwsIH4zGMdvvQkJ9zrRoC6MClQPPpsrfdg
	23gtAPIBbxgoMlSKTTDAvTBEU=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wB3oMb47VFpdUonDA--.27460S2;
	Mon, 29 Dec 2025 10:56:57 +0800 (CST)
From: Honggang LI <honggangli@163.com>
To: haris.iqbal@ionos.com,
	jinpu.wang@ionos.com
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Honggang LI <honggangli@163.com>
Subject: [PATCH v3] RDMA/rtrs: client: Fix clt_path::max_pages_per_mr calculation
Date: Mon, 29 Dec 2025 10:56:17 +0800
Message-ID: <20251229025617.13241-1-honggangli@163.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3oMb47VFpdUonDA--.27460S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr4kWr1kXF1rJw1fGw43GFg_yoW8Gr4fpF
	WfAryqvwnrJF4jkan2v34kZry3uwsIyrW0gr92q34rWFnIq342qryvk34jgr1DJr1DZrWY
	qF4UXr4kKayI93DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pReWlDUUUUU=
X-CM-SenderInfo: 5krqwwxdqjzxi6rwjhhfrp/xtbC7BporWlR7fpoqwAA3f

If device max_mr_size bits in the range [mr_page_shift+31:mr_page_shift]
are zero, the `min3` function will set clt_path::max_pages_per_mr to
zero.

`alloc_path_reqs` will pass zero, which is invalid, as the third parameter
to `ib_alloc_mr`.

Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Signed-off-by: Honggang LI <honggangli@163.com>
---
v2 -> v3:
Use `min_not_zero`.
v1 -> v2:
Correct the commit message and set max_pages_per_mr to U32_MAX
as Michael Gur suggested.
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 71387811b281..2b397a544cb9 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1464,6 +1464,7 @@ static void query_fast_reg_mode(struct rtrs_clt_path *clt_path)
 	mr_page_shift      = max(12, ffs(ib_dev->attrs.page_size_cap) - 1);
 	max_pages_per_mr   = ib_dev->attrs.max_mr_size;
 	do_div(max_pages_per_mr, (1ull << mr_page_shift));
+	max_pages_per_mr = min_not_zero((u32)max_pages_per_mr, U32_MAX);
 	clt_path->max_pages_per_mr =
 		min3(clt_path->max_pages_per_mr, (u32)max_pages_per_mr,
 		     ib_dev->attrs.max_fast_reg_page_list_len);
-- 
2.52.0


