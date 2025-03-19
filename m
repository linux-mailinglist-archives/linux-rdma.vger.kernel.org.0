Return-Path: <linux-rdma+bounces-8824-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4BDA68D19
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 13:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DDD342165A
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 12:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC28E255E3C;
	Wed, 19 Mar 2025 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMBVEr4s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAB5250BF3
	for <linux-rdma@vger.kernel.org>; Wed, 19 Mar 2025 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742388148; cv=none; b=a6n9oyJ1Wvvf+kXrjjJ7WgDqsWaA+Sm+NqDr9zHH9KXy55SPxAmsv7nrobonK2ACpdy5lLlO3IOjFThermrayHK5BAQzzb/NIhdz8cu43B51v26l/Y9beFsoE+6SmQI9pIila5IUVekhnn2FX2cb8Y7SSRcKiT/0n4DqlZmx+r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742388148; c=relaxed/simple;
	bh=UNowoy5w8fq91GwqQUqRXX5F2WnhXSDFy/4GtZIc8NY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mBFBBqQiKbSodzMz8X7jeCDLKQDOg9+U59wFMPPrlbsQY+RdQOfrecmQHnjzwIFHFazEkhvqt2IyS9rsqO3QdlvPjpq2Tqx9JnCnkU5w8NTkC1fG1sxHGhkvMlCgvIjjF7lJ6Eodjo4ECBv/bIq7ZoErp1TWbRDOFsrTb4vdJBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMBVEr4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1DCC4CEE9;
	Wed, 19 Mar 2025 12:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742388148;
	bh=UNowoy5w8fq91GwqQUqRXX5F2WnhXSDFy/4GtZIc8NY=;
	h=From:To:Cc:Subject:Date:From;
	b=gMBVEr4s6FCqjvEWvmJ/fODby82fU3HZszJ/cngG0FyvezZJwzb+RNbfcMz+i/CQv
	 zaRKQHB+iSYFvVPAtqEqbvBn+Kv4nUCRSmxpKW0QlwjqbP+kZQijXW3QfYtqRCRKY6
	 CyQLOIbVVac4cVxpt0B7D+K3r+JFtoPF9CAi3QDzrI4L55IcmnS5+25f8hS3s2zrbU
	 dWvq9WxCfEBoiZNPiTOe2pbBlHi+oDXeW7oSKlezbFaFMBMmNDh+3C0XjCHlMB58Vj
	 A7OO6vGeWQTnd61wPr18i1qwAcU9UsTEitEKsjTr6SUBI+/RZ8e6YCxk6D9zi4qtM1
	 sU1CYRa4/YAjQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shay Drory <shayd@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/core: Silence oversized kvmalloc() warning
Date: Wed, 19 Mar 2025 14:42:21 +0200
Message-ID: <c6cb92379de668be94894f49c2cfa40e73f94d56.1742388096.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shay Drory <shayd@nvidia.com>

syzkaller triggered an oversized kvmalloc() warning.
Silence it by adding __GFP_NOWARN.

syzkaller log:
 WARNING: CPU: 7 PID: 518 at mm/util.c:665 __kvmalloc_node_noprof+0x175/0x180
 CPU: 7 UID: 0 PID: 518 Comm: c_repro Not tainted 6.11.0-rc6+ #6
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 RIP: 0010:__kvmalloc_node_noprof+0x175/0x180
 RSP: 0018:ffffc90001e67c10 EFLAGS: 00010246
 RAX: 0000000000000100 RBX: 0000000000000400 RCX: ffffffff8149d46b
 RDX: 0000000000000000 RSI: ffff8881030fae80 RDI: 0000000000000002
 RBP: 000000712c800000 R08: 0000000000000100 R09: 0000000000000000
 R10: ffffc90001e67c10 R11: 0030ae0601000000 R12: 0000000000000000
 R13: 0000000000000000 R14: 00000000ffffffff R15: 0000000000000000
 FS:  00007fde79159740(0000) GS:ffff88813bdc0000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000020000180 CR3: 0000000105eb4005 CR4: 00000000003706b0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <TASK>
  ib_umem_odp_get+0x1f6/0x390
  mlx5_ib_reg_user_mr+0x1e8/0x450
  ib_uverbs_reg_mr+0x28b/0x440
  ib_uverbs_write+0x7d3/0xa30
  vfs_write+0x1ac/0x6c0
  ksys_write+0x134/0x170
  ? __sanitizer_cov_trace_pc+0x1c/0x50
  do_syscall_64+0x50/0x110
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: 37824952dc8f ("RDMA/odp: Use kvcalloc for the dma_list and page_list")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/umem_odp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index e9fa22d31c23..c48ef6083020 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -76,12 +76,14 @@ static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
 
 		npfns = (end - start) >> PAGE_SHIFT;
 		umem_odp->pfn_list = kvcalloc(
-			npfns, sizeof(*umem_odp->pfn_list), GFP_KERNEL);
+			npfns, sizeof(*umem_odp->pfn_list),
+			GFP_KERNEL | __GFP_NOWARN);
 		if (!umem_odp->pfn_list)
 			return -ENOMEM;
 
 		umem_odp->dma_list = kvcalloc(
-			ndmas, sizeof(*umem_odp->dma_list), GFP_KERNEL);
+			ndmas, sizeof(*umem_odp->dma_list),
+			GFP_KERNEL | __GFP_NOWARN);
 		if (!umem_odp->dma_list) {
 			ret = -ENOMEM;
 			goto out_pfn_list;
-- 
2.48.1


