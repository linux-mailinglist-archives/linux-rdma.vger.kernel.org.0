Return-Path: <linux-rdma+bounces-15168-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC35CD7FC2
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 04:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6A383014D96
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 03:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C9C2D6E72;
	Tue, 23 Dec 2025 03:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VAEZIdTE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A0914A8E;
	Tue, 23 Dec 2025 03:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766461434; cv=none; b=bTHnsCLBe3VOFo8UlRlkcu7dA6Yigg2xa6u4FjiSd8Wx5qOHJrznDAxNZe+4Ck53aoOY137MBMWbs4ctqUAAySmkANIW3c+EcxHoI885G2kYD7oKWjTmhsrvpvliw9M9N7GEAh5RH7gM0I48eMAzpN6H+65M8zPTZl/WaHZtZiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766461434; c=relaxed/simple;
	bh=wM68gCTTBChGaY+DkQVynzOks2Mwpoyw904gPRScWyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QE7RaLEIwm3KEKSqYI7d0aJTA7eaLCkmoqHUl2HvYpoZuZW1nbOIjWgEGa5l5byamnZbnQkB3F3cWEVLdsszkSNdBTfVHBTKuzQBJlTICgVEVHcPGZpLZNpRNBPJzVPQh3RqXV4zic6nBmXY9pMTHzKK8XBO8++oyIXSaXfXAOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VAEZIdTE; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=pE
	o0jKxFQMzyXleF0oKRWXlp3a7risG17txZoqwq2NA=; b=VAEZIdTE5wi8yFD1Hi
	AHH78Mv1pRXR2fjVY/OY+YDa1L7CH9dCTsPk1N94xOqn1UJ7k25cm6PUTU0fExhy
	2Qo/te0f6DLG0lSzU7skvqE2C21XE/IEQSeboIxr1E6lz0wsV+LUMBHRjv9kcjUe
	Yu9jFq74+ZkAMnn36BG1Oh7AA=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wCn7XjhD0ppaIHRBw--.35778S2;
	Tue, 23 Dec 2025 11:43:31 +0800 (CST)
From: Honggang LI <honggangli@163.com>
To: jinpu.wang@ionos.com,
	danil.kipnis@cloud.ionos.com
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Honggang LI <honggangli@163.com>
Subject: [PATCH] RDMA/rtrs: client: Fix clt_path::max_pages_per_mr calculation
Date: Tue, 23 Dec 2025 11:43:24 +0800
Message-ID: <20251223034324.13706-1-honggangli@163.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCn7XjhD0ppaIHRBw--.35778S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrtF4UJFyUKF4xXw1fCF45Jrb_yoW8JF18pF
	WfAryvvw1UJF4jy3Z2v34kur15CanrArW8Wr92v34kXFnaq342qFyqkw1UXryDJr1DXrW3
	tr4UZr4DKa4xuw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRO4S8UUUUU=
X-CM-SenderInfo: 5krqwwxdqjzxi6rwjhhfrp/xtbC6wPoLmlKD+MTuAAA3K

If the low two bytes of ib_dev::attrs::max_mr_size are zeros, the `min3`
function will set clt_path::max_pages_per_mr to zero.

`alloc_path_reqs` will pass zero, which is invalid,  as the third parameter
to `ib_alloc_mr`.

Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Signed-off-by: Honggang LI <honggangli@163.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 71387811b281..b9d66e4fab07 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1465,7 +1465,7 @@ static void query_fast_reg_mode(struct rtrs_clt_path *clt_path)
 	max_pages_per_mr   = ib_dev->attrs.max_mr_size;
 	do_div(max_pages_per_mr, (1ull << mr_page_shift));
 	clt_path->max_pages_per_mr =
-		min3(clt_path->max_pages_per_mr, (u32)max_pages_per_mr,
+		min(min_not_zero(clt_path->max_pages_per_mr, (u32)max_pages_per_mr),
 		     ib_dev->attrs.max_fast_reg_page_list_len);
 	clt_path->clt->max_segments =
 		min(clt_path->max_pages_per_mr, clt_path->clt->max_segments);
-- 
2.52.0


