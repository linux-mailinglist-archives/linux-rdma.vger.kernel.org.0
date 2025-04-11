Return-Path: <linux-rdma+bounces-9366-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E132A85533
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 09:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BCA51B66EFF
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 07:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5629284B40;
	Fri, 11 Apr 2025 07:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WUO4j2Cx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729C4283C8A;
	Fri, 11 Apr 2025 07:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744355562; cv=none; b=Bg0wTjfrhdyfk0kq9ScmuLQrWCWB/i7wP6VkjXnGvXZOkhqpTMSC1+KuBeVmDR6Dzw8tq4/jfl0yKlbZ2VP71EQxB3TRNUiEW3hN0dIxf7nro0u+KvPUUTANusD8YYIeaUu6iYHhutT/H2a7TBxoAf5pWaAv+o8y0olivMUxEc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744355562; c=relaxed/simple;
	bh=yY1oHUe582lGxyx4eCz34x3c0y9yzaNniW+6J65cqqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lNwTltcd5kxI7dXEb/KRwV7eL/nK7sok//OfsyKobw+RT+kApU5/hQxT+FKQ8HnUCopEFoh2TLB/pNsScnX4G2ErH2C0WSU0WQ6NJtyFMgb6hk6G5/MyZMzapyMirn4uCY0JHuB6VjGRjN7F2IYewtRQmQw+e6AuxAdKjVOOU6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WUO4j2Cx; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=hTcAR
	Rvnn8qq+1dZy1r2KQFiwbDtnMu0NN5G/m8h1rY=; b=WUO4j2Cx0zqDMuEg6OOfF
	dAL+rj23i/NN4VUrnQUzMyL/bLmRtaJcTAMa9X/20nde/OHqa88CI5ifj/KHxkxI
	iY9JBihV8EYUO7iUD4vdmob/0WvgYgyiYsCGckXHxzPnt59WC16BIyUwu8y+/4OZ
	v76b+v5RN77UiGDF3dUER0=
Received: from localhost (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgBXThbEwPhnm38MAA--.12885S2;
	Fri, 11 Apr 2025 15:12:04 +0800 (CST)
From: Honggang LI <honggangli@163.com>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	matsuda-daisuke@fujitsu.com
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Honggang LI <honggangli@163.com>
Subject: [PATCH] RDMA/rxe: Fix kernel panic for fast registered MR
Date: Fri, 11 Apr 2025 15:11:41 +0800
Message-ID: <20250411071141.82619-1-honggangli@163.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgBXThbEwPhnm38MAA--.12885S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gw43tF4fGryUtF48Cw47XFb_yoW7ur4DpF
	WrJ3WYkF48G3WUZa1DAr1jg3y7Za17Za4DWr9Fq3sruF15urWUWasxtryjgryDtr1DJay2
	qF1UXw4vkw4fGaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEeMK9UUUUU=
X-CM-SenderInfo: 5krqwwxdqjzxi6rwjhhfrp/1tbiOgksRWf4vxhJ4wAAsI

`rxe_reg_fast_mr` does not set the `umem` for fast registered MRs.
Check the `umem` pointer before check `umem->is_odp` flag, otherwise
we will have kernel panic issue.

[ 1475.416503] BUG: kernel NULL pointer dereference, address: 0000000000000028
[ 1475.416560] #PF: supervisor read access in kernel mode
[ 1475.416583] #PF: error_code(0x0000) - not-present page
[ 1475.416607] PGD 0 P4D 0
[ 1475.416625] Oops: Oops: 0000 [#1] SMP PTI
[ 1475.416649] CPU: 2 UID: 0 PID: 6106 Comm: kworker/u33:0 Kdump: loaded Not tainted 6.15.0-0.rc0.20250401git08733088b566.8.fc43.x86_64 #1 PREEMPT(lazy)
[ 1475.416694] Hardware name: Powerleader PR1715R/X9DRD-iF, BIOS 3.3 09/10/2018
[ 1475.416721] Workqueue: rxe_wq do_work [rdma_rxe]
[ 1475.416774] RIP: 0010:rxe_mr_copy+0x71/0xf0 [rdma_rxe]
[ 1475.416819] Code: 3c 24 4c 8b 4c 24 08 85 c0 44 8b 5c 24 18 4c 8b 54 24 10 44 8b 44 24 1c 75 4f 48 8b 87 f0 00 00 00 44 89 d9 4c 89 d2 4c 89 ce <f6> 40 28 02 74 09 48 83 c4 20 e9 20 47 00 00 48 83 c4 20 e9 57 f7
[ 1475.416874] RSP: 0018:ffffcbcfc936fd70 EFLAGS: 00010246
[ 1475.416897] RAX: 0000000000000000 RBX: ffff8a9c48314328 RCX: 000000000000003c
[ 1475.416924] RDX: ffff8a9dc5f7110a RSI: ffff8a9c4ce40024 RDI: ffff8a9c44ae9200
[ 1475.416949] RBP: ffff8a9c4007f800 R08: 0000000000000000 R09: ffff8a9c4ce40024
[ 1475.416974] R10: ffff8a9dc5f7110a R11: 000000000000003c R12: ffff8a9c45112000
[ 1475.416999] R13: ffff8a9c4007f800 R14: 0000000000000000 R15: ffff8a9c4007fc28
[ 1475.417024] FS:  0000000000000000(0000) GS:ffff8a9dfb58e000(0000) knlGS:0000000000000000
[ 1475.417052] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1475.417075] CR2: 0000000000000028 CR3: 000000040282e006 CR4: 00000000001726f0
[ 1475.417103] Call Trace:
[ 1475.417119]  <TASK>
[ 1475.417135]  execute+0x281/0x310 [rdma_rxe]
[ 1475.417179]  rxe_receiver+0x41f/0xda0 [rdma_rxe]
[ 1475.417219]  do_task+0x61/0x1d0 [rdma_rxe]
[ 1475.417256]  process_one_work+0x18e/0x350
[ 1475.417286]  worker_thread+0x25a/0x3a0
[ 1475.417309]  ? __pfx_worker_thread+0x10/0x10
[ 1475.417334]  kthread+0xfc/0x240
[ 1475.417354]  ? __pfx_kthread+0x10/0x10
[ 1475.417374]  ret_from_fork+0x34/0x50
[ 1475.417396]  ? __pfx_kthread+0x10/0x10
[ 1475.417416]  ret_from_fork_asm+0x1a/0x30
[ 1475.418046]  </TASK>
[ 1475.418615] Modules linked in: rnbd_server rtrs_server rtrs_core rdma_cm iw_cm ib_cm brd rdma_rxe ib_uverbs ip6_udp_tunnel udp_tunnel ib_core rfkill intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel sunrpc kvm binfmt_misc rapl intel_cstate iTCO_wdt intel_pmc_bxt iTCO_vendor_support ipmi_ssif intel_uncore pcspkr isci acpi_ipmi i2c_i801 i2c_smbus mgag200 ipmi_si mei_me lpc_ich libsas mei scsi_transport_sas ipmi_devintf ioatdma joydev ipmi_msghandler acpi_pad ip6_tables ip_tables fuse loop nfnetlink zram lz4hc_compress lz4_compress igb polyval_clmulni polyval_generic ghash_clmulni_intel sha512_ssse3 sha256_ssse3 dca sha1_ssse3 i2c_algo_bit wmi
[ 1475.422332] CR2: 0000000000000028

Fixes: 2fae67ab63db ("RDMA/rxe: Add support for Send/Recv/Write/Read with ODP")
Fixes: d03fb5c6599e ("RDMA/rxe: Allow registering MRs for On-Demand Paging")
Signed-off-by: Honggang LI <honggangli@163.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c   | 4 ++--
 drivers/infiniband/sw/rxe/rxe_odp.c  | 2 +-
 drivers/infiniband/sw/rxe/rxe_resp.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 868d2f0b74e9..7aebb359f69d 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -323,7 +323,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
 		return err;
 	}
 
-	if (mr->umem->is_odp)
+	if (mr->umem && mr->umem->is_odp)
 		return rxe_odp_mr_copy(mr, iova, addr, length, dir);
 	else
 		return rxe_mr_copy_xarray(mr, iova, addr, length, dir);
@@ -536,7 +536,7 @@ int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 	u64 *va;
 
 	/* ODP is not supported right now. WIP. */
-	if (mr->umem->is_odp)
+	if (mr->umem && mr->umem->is_odp)
 		return RESPST_ERR_UNSUPPORTED_OPCODE;
 
 	/* See IBA oA19-28 */
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index 9f6e2bb2a269..066a50da06f4 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -229,7 +229,7 @@ int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 	if (length == 0)
 		return 0;
 
-	if (unlikely(!mr->umem->is_odp))
+	if (unlikely(!(mr->umem && mr->umem->is_odp)))
 		return -EOPNOTSUPP;
 
 	switch (dir) {
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 54ba9ee1acc5..e27efc93a138 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -650,7 +650,7 @@ static enum resp_states process_flush(struct rxe_qp *qp,
 	struct resp_res *res = qp->resp.res;
 
 	/* ODP is not supported right now. WIP. */
-	if (mr->umem->is_odp)
+	if (mr->umem && mr->umem->is_odp)
 		return RESPST_ERR_UNSUPPORTED_OPCODE;
 
 	/* oA19-14, oA19-15 */
@@ -706,7 +706,7 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
 	if (!res->replay) {
 		u64 iova = qp->resp.va + qp->resp.offset;
 
-		if (mr->umem->is_odp)
+		if (mr->umem && mr->umem->is_odp)
 			err = rxe_odp_atomic_op(mr, iova, pkt->opcode,
 						atmeth_comp(pkt),
 						atmeth_swap_add(pkt),
-- 
2.49.0


