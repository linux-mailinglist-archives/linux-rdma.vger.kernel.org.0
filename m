Return-Path: <linux-rdma+bounces-9104-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7867AA786CD
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 05:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4213D16D8A2
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 03:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4317722ACF2;
	Wed,  2 Apr 2025 03:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="HkEhmuvL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2F91853;
	Wed,  2 Apr 2025 03:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743564506; cv=none; b=jpIeChcc/hBFGbWYspUFa1cf1iCg8yEY5oky9WldTHfzCXAPSJHhQU/cQyNq43W6u/C8SXgzREKnVRJd5CVkYWmdy4y85MHC5lmXgkB88fQxhxe2U8HQ5JOILShE7OIFoVlm9Pq3FOkFZDDk/fFEw/ghoac82/y0VWfBq0DBciY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743564506; c=relaxed/simple;
	bh=IeyO2AjokWY+ax1HerEv85JrnWO0vAMbJXmLylQtOvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j3XWjhHTCc2y+AKIJgamJDHfSlI+GtP6H233AQsCeid5D8fLqEfSCnV/GJC7mG2nXSzsaFBbDErjO9dQiPmMKtW0deZQ8HN6wLR1Ir8ods/DnBVqZ+OFiBGd44NIMp0kEwkC6Jv4t3QTgUL/n2ebUqb4xDyGo6ga2hmpH0/uE+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=HkEhmuvL; arc=none smtp.client-ip=207.54.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1743564504; x=1775100504;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IeyO2AjokWY+ax1HerEv85JrnWO0vAMbJXmLylQtOvw=;
  b=HkEhmuvL8ubPgQVYDw2N/+dsLn+NJXdTfajbKf9I/WGnVOZSPq/4qu0R
   6aKle/i4H+fkhAl38t/YGEsRKcx5QfiGpP2zTOZyQhXWTmtms9xdI+zo9
   r1sDxTPVAVQVeeJt0OtMK8LGP4jtRwcKqTFvE6dXlS4tY4qmOl8o+kf0D
   eJerIsCJp6YPOj/z3oc+50ZoqYqCByrla8kW7dHSeXP3bFSN6taI3EMFU
   n0k704mNXwgL4YJr4wPJHEuBaHfo30EHWfTw+DS5BQo5eRu0k+wXolUXR
   cyf300zwXrG6yGB5OibcuktR9BuSz1r7Nt2oKA6oFL73JJSaQrIZpP4H2
   w==;
X-CSE-ConnectionGUID: FyWmWcSvSBCazxTY7uFNiA==
X-CSE-MsgGUID: qo+WiFpuRxynGl38f984GA==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="195195439"
X-IronPort-AV: E=Sophos;i="6.14,295,1736780400"; 
   d="scan'208";a="195195439"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 12:27:12 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 432AED4808;
	Wed,  2 Apr 2025 12:27:10 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 063CDBDCB1;
	Wed,  2 Apr 2025 12:27:10 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id CE6151A0071;
	Wed,  2 Apr 2025 11:27:08 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	matsuda-daisuke@fujitsu.com,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] RDMA/rxe: Fix null pointer dereference in ODP MR check
Date: Wed,  2 Apr 2025 11:26:57 +0800
Message-ID: <20250402032657.1762800-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The blktests/rnbd reported a null pointer dereference as following.
Similar to the mxl5, introduce a is_odp_mr() to check if the odp
is enabled in this mr.

Workqueue: rxe_wq do_work [rdma_rxe]
RIP: 0010:rxe_mr_copy+0x57/0x210 [rdma_rxe]
Code: 7c 04 48 89 f3 48 89 d5 41 89 cf 45 89 c4 0f 84 dc 00 00 00 89 ca e8 f8 f8 ff ff 85 c0 0f 85 75 01 00 00 49 8b 86 f0 00 00 00 <f6> 40 28 02 0f 85 98 01 00 00 41 8b 46 78 41 8b 8e 10 01 00 00 8d
RSP: 0018:ffffa0aac02cfcf8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff9079cd440024 RCX: 0000000000000000
RDX: 000000000000003c RSI: ffff9079cd440060 RDI: ffff9079cd665600
RBP: ffff9079c0e5e45a R08: 0000000000000000 R09: 0000000000000000
R10: 000000003c000000 R11: 0000000000225510 R12: 0000000000000000
R13: 0000000000000000 R14: ffff9079cd665600 R15: 000000000000003c
FS:  0000000000000000(0000) GS:ffff907ccfa80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000028 CR3: 0000000119498001 CR4: 00000000001726f0
Call Trace:
 <TASK>
 ? __die_body+0x1e/0x60
 ? page_fault_oops+0x14f/0x4c0
 ? rxe_mr_copy+0x57/0x210 [rdma_rxe]
 ? search_bpf_extables+0x5f/0x80
 ? exc_page_fault+0x7e/0x180
 ? asm_exc_page_fault+0x26/0x30
 ? rxe_mr_copy+0x57/0x210 [rdma_rxe]
 ? rxe_mr_copy+0x48/0x210 [rdma_rxe]
 ? rxe_pool_get_index+0x50/0x90 [rdma_rxe]
 rxe_receiver+0x1d98/0x2530 [rdma_rxe]
 ? psi_task_switch+0x1ff/0x250
 ? finish_task_switch+0x92/0x2d0
 ? __schedule+0xbdf/0x17c0
 do_task+0x65/0x1e0 [rdma_rxe]
 process_scheduled_works+0xaa/0x3f0
 worker_thread+0x117/0x240

Fixes: d03fb5c6599e ("RDMA/rxe: Allow registering MRs for On-Demand Paging")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h  | 6 ++++++
 drivers/infiniband/sw/rxe/rxe_mr.c   | 4 ++--
 drivers/infiniband/sw/rxe/rxe_resp.c | 4 ++--
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index feb386d98d1d..0bc3fbb6554f 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -140,6 +140,12 @@ static inline int qp_mtu(struct rxe_qp *qp)
 		return IB_MTU_4096;
 }
 
+static inline bool is_odp_mr(struct rxe_mr *mr)
+{
+	return IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING) && mr->umem &&
+	       mr->umem->is_odp;
+}
+
 void free_rd_atomic_resource(struct resp_res *res);
 
 static inline void rxe_advance_resp_resource(struct rxe_qp *qp)
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 868d2f0b74e9..432d864c3ce9 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -323,7 +323,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
 		return err;
 	}
 
-	if (mr->umem->is_odp)
+	if (is_odp_mr(mr))
 		return rxe_odp_mr_copy(mr, iova, addr, length, dir);
 	else
 		return rxe_mr_copy_xarray(mr, iova, addr, length, dir);
@@ -536,7 +536,7 @@ int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 	u64 *va;
 
 	/* ODP is not supported right now. WIP. */
-	if (mr->umem->is_odp)
+	if (is_odp_mr(mr))
 		return RESPST_ERR_UNSUPPORTED_OPCODE;
 
 	/* See IBA oA19-28 */
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 54ba9ee1acc5..5d9174e408db 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -650,7 +650,7 @@ static enum resp_states process_flush(struct rxe_qp *qp,
 	struct resp_res *res = qp->resp.res;
 
 	/* ODP is not supported right now. WIP. */
-	if (mr->umem->is_odp)
+	if (is_odp_mr(mr))
 		return RESPST_ERR_UNSUPPORTED_OPCODE;
 
 	/* oA19-14, oA19-15 */
@@ -706,7 +706,7 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
 	if (!res->replay) {
 		u64 iova = qp->resp.va + qp->resp.offset;
 
-		if (mr->umem->is_odp)
+		if (is_odp_mr(mr))
 			err = rxe_odp_atomic_op(mr, iova, pkt->opcode,
 						atmeth_comp(pkt),
 						atmeth_swap_add(pkt),
-- 
2.41.0


