Return-Path: <linux-rdma+bounces-5527-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BC69B1421
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Oct 2024 04:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1771C20C7C
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Oct 2024 02:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDD71386B4;
	Sat, 26 Oct 2024 02:01:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF7D538A;
	Sat, 26 Oct 2024 02:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729908097; cv=none; b=Di7kLsPMQRoMy+Q9sbWYQTkZ+XXAEzkMNTwwPvyuwgS8HEh1NIc45vTFIcM5KiEXyjK1jPXAJWwWxHbqi6VYyL1Q+0UUnfYxNwcCsFCf2HuW3/lhQ0cf30LqUYFGHambSXrxev0wtHjJs84/7ohsnakNQwoDzEd81b+1kkbETAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729908097; c=relaxed/simple;
	bh=OUlnjQamIFYDhm3S1rV1wcv1LVHYg85/AeIMk4BuloQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y4/tJgMbOfN0osZrsj0v8A+yDZDt1uhw9gWbrTgyELED1/ejQfr7xWFlDKqC//hENFEExgplHYYM+FAi1RufctyNm0nqhRaZQOn/lkMlbdiW1W3pib3Te4mnAXyWb6+2Jz5EUZq8jlUq/bp3VtNGamXkFfkcqPwnDrZRj2NkR9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Xb2sR0dlZzyTp6;
	Sat, 26 Oct 2024 09:59:55 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 717BE1400E3;
	Sat, 26 Oct 2024 10:01:29 +0800 (CST)
Received: from lihuafei.huawei.com (10.90.53.74) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 26 Oct 2024 10:01:28 +0800
From: Li Huafei <lihuafei1@huawei.com>
To: <tariqt@nvidia.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<gustavoars@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lihuafei1@huawei.com>
Subject: [PATCH] net/mlx4: Fix build errors with gcc 10.3.1
Date: Sat, 26 Oct 2024 18:02:21 +0800
Message-ID: <20241026100221.2242565-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf500004.china.huawei.com (7.202.181.242)

When compiling the kernel in my environment (with gcc version gcc
10.3.1), I encountered the following compilation check error:

 In function ‘check_copy_size’,
     inlined from ‘copy_to_user’ at ./include/linux/uaccess.h:210:7,
     inlined from ‘mlx4_init_user_cqes’ at drivers/net/ethernet/mellanox/mlx4/cq.c:317:9:
 ./include/linux/thread_info.h:244:4: error: call to ‘__bad_copy_from’ declared with attribute error: copy source size is too small
   244 |    __bad_copy_from();

mlx4_init_user_cqes() checks the size of the buf before copying data,
ensuring that there will be no out-of-bounds copying, so this should be
a false positive. I searched the git commit history and found that the
commit 75da0eba0a47 ("rapidio: avoid bogus __alloc_size warning") fixed
a similar issue, where the compiler encountered an error when expanding
the arguments of check_copy_size().  Saving the result of array_size()
to a temporary variable and using this variable as the argument of
copy_to_user() can avoid this gcc warning.

Additionally, I tested older (9.4.0) and newer (10.3.5) versions and did
not encounter the same problem, so this should be a bug in a specific
intermediate version.

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 drivers/net/ethernet/mellanox/mlx4/cq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/cq.c b/drivers/net/ethernet/mellanox/mlx4/cq.c
index e130e7259275..5169c7a4097b 100644
--- a/drivers/net/ethernet/mellanox/mlx4/cq.c
+++ b/drivers/net/ethernet/mellanox/mlx4/cq.c
@@ -293,6 +293,7 @@ static int mlx4_init_user_cqes(void *buf, int entries, int cqe_size)
 	void *init_ents;
 	int err = 0;
 	int i;
+	size_t size = array_size(entries, cqe_size);
 
 	init_ents = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!init_ents)
@@ -314,9 +315,7 @@ static int mlx4_init_user_cqes(void *buf, int entries, int cqe_size)
 			buf += PAGE_SIZE;
 		}
 	} else {
-		err = copy_to_user((void __user *)buf, init_ents,
-				   array_size(entries, cqe_size)) ?
-			-EFAULT : 0;
+		err = copy_to_user((void __user *)buf, init_ents, size) ? -EFAULT : 0;
 	}
 
 out:
-- 
2.25.1


