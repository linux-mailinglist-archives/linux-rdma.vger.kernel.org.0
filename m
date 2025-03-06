Return-Path: <linux-rdma+bounces-8425-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD6EA54A46
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 13:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899AC188B446
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 12:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57BF205AAF;
	Thu,  6 Mar 2025 12:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GpTbgkM6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBAC204089
	for <linux-rdma@vger.kernel.org>; Thu,  6 Mar 2025 12:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741262688; cv=none; b=usshvpvQUBSsAGBA/FmYHaYQVOpOI8ab3m5OV2fji2iZByBeP6BS+XQiV+Gk9+04l2PEjYmB+t4K19F0LPqVUqF5fuMaat9Z0VRQvGydZLIciT61RVbQ1tj34FnF6w0EPltnZ1gUINA9+6fv7ctDGz//blQHI6gevYQCiQLucW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741262688; c=relaxed/simple;
	bh=GIyNYhZPNM87sGjq6IPdhM1+NQDWgdSGGK2i+Hr3fLo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O0c4q3rGJo1SVh/qfDTyTS3hBmVYMHZUcaRVba+TINmFcAX5hTwU+X4r3jBJx1MM6qYvPt1kmlDphJ9p9GzVIWCAFAnVlHnGh/jTpZa7olxbFeAebBZ9UeKVysVYrd0JUru+Lq1hP9oJwfOfPVQ5w427W/RKdfNWMc5ePWB/faY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GpTbgkM6; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741262681; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=L0o5zeStXqs2IkhFsNkbGSoWqi+sIzS6RQGqnp33ORA=;
	b=GpTbgkM6Cbw+xWq97QmqQ0gDv5SuXZUokpPwy2Mss2pC9ru299l0Bp8Nd+FVss/2KQqp+2+4wtBbIH3QZxBIB12k93sM8dZjOYfp/N8aIXzQz5a1s/UZlchA6ZCVTj7mHZoYD19lhbr+/VO2iucGjKY0pIvVf8qHEb88aEdAGzc=
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0WQomN5Q_1741262680 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Mar 2025 20:04:40 +0800
From: Cheng Xu <chengyou@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	KaiShen@linux.alibaba.com
Subject: [PATCH for-next] RDMA/erdma: Prevent use-after-free in erdma_accept_newconn()
Date: Thu,  6 Mar 2025 20:04:40 +0800
Message-Id: <20250306120440.72792-1-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the erdma_cep_put(new_cep) being called, new_cep will be freed,
and the following dereference will cause a UAF problem. Fix this issue.

Fixes: 920d93eac8b9 ("RDMA/erdma: Add connection management (CM) support")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_cm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_cm.c b/drivers/infiniband/hw/erdma/erdma_cm.c
index 1b23c698ec25..e0acc185e719 100644
--- a/drivers/infiniband/hw/erdma/erdma_cm.c
+++ b/drivers/infiniband/hw/erdma/erdma_cm.c
@@ -709,7 +709,6 @@ static void erdma_accept_newconn(struct erdma_cep *cep)
 		erdma_cancel_mpatimer(new_cep);
 
 		erdma_cep_put(new_cep);
-		new_cep->sock = NULL;
 	}
 
 	if (new_s) {
-- 
2.31.1


