Return-Path: <linux-rdma+bounces-8674-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B168A5F84D
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 15:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55E5219C46FD
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 14:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026F6269838;
	Thu, 13 Mar 2025 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qom8EpKS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2732269833
	for <linux-rdma@vger.kernel.org>; Thu, 13 Mar 2025 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876228; cv=none; b=L8xoFr0XSyGDFAC6Dc9TUmfpiX0GGkR3taU3QsPKFOp6oM38A3KH21rcUuF8a29PS4yFJQNrebVTrKy0d/nJ7UZFgl/1vK53/8ZYj+Xy6ZfWwhlA+VlBDsP2ldbnGZhqSE4K2JRdHE9uoNydjR/gPIix/xvDYbrKGp3WaDIRkV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876228; c=relaxed/simple;
	bh=BIsA5iFGUZ55wp+iUT0C3BZ4IGaj9t+IxmlhrwgHn9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tc6nC6M5ZKVSsnRLEOjABR5G8p7qYc+y6OfAAJwVNA1Go5aIz75zuiaY/RwzyKHbdQMHfFktrNPpTgpqc4IAQOtQ1OjYKxTKo/3GmKSTt6dxhvOIVZijmbeD+zxAHAwjsijUF1S3u+oyjA6zuXwym5qcFDxnfoNKh75iS/2tsiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qom8EpKS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B67C4CEEA;
	Thu, 13 Mar 2025 14:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741876228;
	bh=BIsA5iFGUZ55wp+iUT0C3BZ4IGaj9t+IxmlhrwgHn9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qom8EpKSCqY9y/XhPMuX9Xss/NgcBAckB5Anw3dRg4B+D/XMfpLnyRN++/seZOf34
	 uF/BLTahSXsPgwA0/5OscaMOp+XxMUZW24UM4wqlr4JIeg9N9dYHmQzp/CeWOt24lV
	 gTznBn6/PS1adoW94g6NHa0pZpPti1tzsyjzhX7DWsgkdBVVa9I1OQm18qbB1O7W4C
	 QufIFAJmVN0UTNtpxXDp9mzCVT7W6GrDpMGY6JM2BXd40/nZMMgcsci+9rvMmrFP2I
	 eMl58B+peu66i61yhWDcnJoGXfM4du3Cr0UEvvmaZ5NMcKzoEhBuVglQETrwTRygLH
	 5hRqEzvwxpg+w==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 6/7] RDMA/mlx5: Fix mlx5_poll_one() cur_qp update flow
Date: Thu, 13 Mar 2025 16:29:53 +0200
Message-ID: <4ada09d41f1e36db62c44a9b25c209ea5f054316.1741875692.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741875692.git.leon@kernel.org>
References: <cover.1741875692.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

When cur_qp isn't NULL, in order to avoid fetching the QP from
the radix tree again we check if the next cqe QP is identical to
the one we already have.

The bug however is that we are checking if the QP is identical by
checking the QP number inside the CQE against the QP number inside the
mlx5_ib_qp, but that's wrong since the QP number from the CQE is from
FW so it should be matched against mlx5_core_qp which is our FW QP
number.

Otherwise we could use the wrong QP when handling a CQE which could
cause the kernel trace below.

This issue is mainly noticeable over QPs 0 & 1, since for now they are
the only QPs in our driver whereas the QP number inside mlx5_ib_qp
doesn't match the QP number inside mlx5_core_qp.

BUG: kernel NULL pointer dereference, address: 0000000000000012
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0000 [#1] SMP
 CPU: 0 UID: 0 PID: 7927 Comm: kworker/u62:1 Not tainted 6.14.0-rc3+ #189
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
 Workqueue: ib-comp-unb-wq ib_cq_poll_work [ib_core]
 RIP: 0010:mlx5_ib_poll_cq+0x4c7/0xd90 [mlx5_ib]
 Code: 03 00 00 8d 58 ff 21 cb 66 39 d3 74 39 48 c7 c7 3c 89 6e a0 0f b7 db e8 b7 d2 b3 e0 49 8b 86 60 03 00 00 48 c7 c7 4a 89 6e a0 <0f> b7 5c 98 02 e8 9f d2 b3 e0 41 0f b7 86 78 03 00 00 83 e8 01 21
 RSP: 0018:ffff88810511bd60 EFLAGS: 00010046
 RAX: 0000000000000010 RBX: 0000000000000000 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: ffff88885fa1b3c0 RDI: ffffffffa06e894a
 RBP: 00000000000000b0 R08: 0000000000000000 R09: ffff88810511bc10
 R10: 0000000000000001 R11: 0000000000000001 R12: ffff88810d593000
 R13: ffff88810e579108 R14: ffff888105146000 R15: 00000000000000b0
 FS:  0000000000000000(0000) GS:ffff88885fa00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000012 CR3: 00000001077e6001 CR4: 0000000000370eb0
 Call Trace:
  <TASK>
  ? __die+0x20/0x60
  ? page_fault_oops+0x150/0x3e0
  ? exc_page_fault+0x74/0x130
  ? asm_exc_page_fault+0x22/0x30
  ? mlx5_ib_poll_cq+0x4c7/0xd90 [mlx5_ib]
  __ib_process_cq+0x5a/0x150 [ib_core]
  ib_cq_poll_work+0x31/0x90 [ib_core]
  process_one_work+0x169/0x320
  worker_thread+0x288/0x3a0
  ? work_busy+0xb0/0xb0
  kthread+0xd7/0x1f0
  ? kthreads_online_cpu+0x130/0x130
  ? kthreads_online_cpu+0x130/0x130
  ret_from_fork+0x2d/0x50
  ? kthreads_online_cpu+0x130/0x130
  ret_from_fork_asm+0x11/0x20
  </TASK>

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Edward Srouji <edwards@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/cq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 4c54dc578069..1aa5311b03e9 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -490,7 +490,7 @@ static int mlx5_poll_one(struct mlx5_ib_cq *cq,
 	}
 
 	qpn = ntohl(cqe64->sop_drop_qpn) & 0xffffff;
-	if (!*cur_qp || (qpn != (*cur_qp)->ibqp.qp_num)) {
+	if (!*cur_qp || (qpn != (*cur_qp)->trans_qp.base.mqp.qpn)) {
 		/* We do not have to take the QP table lock here,
 		 * because CQs will be locked while QPs are removed
 		 * from the table.
-- 
2.48.1


