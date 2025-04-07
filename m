Return-Path: <linux-rdma+bounces-9177-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F2BA7D9BD
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 11:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761B6188C715
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 09:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2101622371F;
	Mon,  7 Apr 2025 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IV0MYrDi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AE41A3172;
	Mon,  7 Apr 2025 09:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744018446; cv=none; b=orABzdSSbrm30u6AVgQbqkOSof1mpi5Pi8LoQAqDaL+mrqysHsNIjzJWtIZzmK9+l4fo8qYEgfwrIFY7sq9KXWXPBg1/81fUK8Xf2T4rcg+fdamMN/DFed6dNqmdSDHdc6zMoQ1PzLX4yMDWJMPKRjsbwFklUwRJnD0tw147Dn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744018446; c=relaxed/simple;
	bh=t/kHhND7Hj3MydX61T30q5XoLh8P02HpnY/cq7JYAQk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rhfwLEkpWvK0eF6Yfsx+7MDjX4xjX0NV/DVs+2QDKt9HGSyU5zWJifG4bbMKDdzlS4wdOpvXkybxYkPRRJ0it4SlNQHu3eGqTrSksSP0O0sOZYC9ahayIsRgRou46tcVS6digJ62K5Y/evE4Sm1/ejkIP60/r+WEAWPPHQ9mmdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IV0MYrDi; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=mtFJZ
	/SO0yLzoEdc4NR8yzNwh2VjDSHh+FsutDVGtrs=; b=IV0MYrDiMPExxWoGZ1u1N
	OGJkRSLW1D+ZZP6GOVEeK+WAk2ovu1ph7wqHgoQEkD+eF2P0rKciyZRM3b3BHScw
	dk6ZZC+p+zieEYbpBmy/uSCtSLophI/hp1gKLRR1aGAupsmd4Jn9WnyIwoCM4ozO
	QM3fsG1UZCmnoboBzIb8OU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnH+X1m_NnEBpKEw--.12333S2;
	Mon, 07 Apr 2025 17:33:43 +0800 (CST)
From: luoqing <l1138897701@163.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: luoqing@kylinos.cn,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rdma: infiniband: Added __alloc_cq request value Return value non-zero value determination
Date: Mon,  7 Apr 2025 17:33:41 +0800
Message-Id: <20250407093341.3245344-1-l1138897701@163.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnH+X1m_NnEBpKEw--.12333S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAryrAr15WrW8Kw45tFyUGFg_yoW5Ww4Upr
	4UJFyxGFWkKr18Gr1UAr1DXrW5Jw47Aay5CF47C3W5uF13Wa4UJr1kGryavFy7Jr45XFy7
	tr1DAw4kKr17GaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UQBMiUUUUU=
X-CM-SenderInfo: jorrjmiyzxliqr6rljoofrz/1tbiKAclRGfvrkGMBAABsg

From: luoqing <luoqing@kylinos.cn>

When the kernel allocates memory for completion queue object ib_cq on the specified
InfiniBand device dev and ensures that the allocated memory is cleared to zero,
if the ib_cq object is not initialized to 0, a non-null value is still returned,
and the kernel should exit and give a warning.
Avoid kernel crash when this memory is initialized.

ib_mad_init_device
	-->ib_mad_port_open
		-->__ib_alloc_cq
			-->rdma_zalloc_drv_obj(dev, ib_cq);

 #8 [ffff80211b3c7430] do_mem_abort at ffff4bedae5912c4
 #9 [ffff80211b3c7610] el1_ia at ffff4bedae592f8c
     PC: ffff4bed866f5aac  [__ib_alloc_cq+100]
     LR: ffff4bed866f5a98  [__ib_alloc_cq+80]
     SP: ffff80211b3c7620  PSTATE: 60400009
    X29: ffff80211b3c7620  X28: ffff4bedae5c7a70  X27: 0000000000000000
    X26: ffff4bed86737680  X25: ffff8020b62f4000  X24: 0000000000000002
    X23: 0000000000000280  X22: ffff4bedaf8a4d28  X21: ffff8020ca8d0000
    X20: 0000000000000000  X19: 0000000000000010  X18: ffff80211b3c7410
    X17: 00000000172acefd  X16: ffff4bedae8603e8  X15: 00000000b19d2ea3
    X14: 000000000950e09b  X13: 000000009bd4e304  X12: 00000000f81e149c
    X11: 0000000096b29e56  X10: 0000000000000f70   X9: ffff80211b3c7360
     X8: ffff80211b4e9350   X7: 0000000000000000   X6: ffff4bedaf2d08f0
     X5: ffff4bed86737680   X4: 0000000000000002   X3: 0000000000000000
     X2: 0000000000000280   X1: 00000000006080c0   X0: 0000000000000010
     X2: 0000000000000280   X1: 00000000006080c0   X0: 0000000000000010
 #10 [ffff80211b3c7620] __ib_alloc_cq at ffff4bed866f5aa8 [ib_core]
 #11 [ffff80211b3c7690] ib_mad_port_open at ffff4bed86711338 [ib_core]
 #12 [ffff80211b3c7710] ib_mad_init_device at ffff4bed867118d0 [ib_core]
 #13 [ffff80211b3c7760] add_client_context at ffff4bed866fca40 [ib_core]
 #14 [ffff80211b3c77a0] enable_device_and_get at ffff4bed866fcb90 [ib_core]
 #15 [ffff80211b3c77f0] ib_register_device at ffff4bed866fd750 [ib_core]
 #16 [ffff80211b3c78b0] irdma_ib_register_device at ffff4bed81ea3d20 [irdma]
 #17 [ffff80211b3c7920] irdma_probe at ffff4bed81e7130c [irdma]

When ib_cq is zero, the return value of cq is ZERO_SIZE_PTR ((void *)16) and is not non-null
cq = rdma_zalloc_drv_obj(dev, ib_cq);

Signed-off-by: luoqing <luoqing@kylinos.cn>
---
 drivers/infiniband/core/cq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index a70876a0a231..90ea9fc99fb7 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -221,7 +221,7 @@ struct ib_cq *__ib_alloc_cq(struct ib_device *dev, void *private, int nr_cqe,
 	int ret = -ENOMEM;
 
 	cq = rdma_zalloc_drv_obj(dev, ib_cq);
-	if (!cq)
+	if (unlikely(ZERO_OR_NULL_PTR(cq)))
 		return ERR_PTR(ret);
 
 	cq->device = dev;
-- 
2.27.0


