Return-Path: <linux-rdma+bounces-6770-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3239FEC25
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Dec 2024 02:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE672188247A
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Dec 2024 01:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11EDEED7;
	Tue, 31 Dec 2024 01:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="QUMRFCM3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58445C2FB;
	Tue, 31 Dec 2024 01:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735608881; cv=none; b=fvLWPEqoQuh8Fb+rSgKpXH+FZG24PC7MybEUQ/DWNlNA6P4ktMCukl+9TmcvtDDWbDPVHoiBLoKhhvR/kOhzNHK1lA3w/9uNBdEns5ofk7HKJ5g9Lz0mZtpZiyRaMAL01w8Y6Mc3ACHodep3oRr4TTMGD204oqMVBvBlXQpXoyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735608881; c=relaxed/simple;
	bh=B/RWJgt7XRMgGjzqoj9c3PHtHf+2w4qSmQxnMVJcQq8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oA6JiywWABdVZPYqVEzOFstaa81AtkeG35tdjBQ9Qb2BND23UnFgr5wOGB1ztF7FxP+60adqHtTOMw7PzXLy1gEJien8KJYqlcxU50NlSjNtD4MCezGNAwImCLTCJLEx6l/Kl0Q+95uDUD7vz98Oqwt0ufbHBkOQKOICnD9k3eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=QUMRFCM3; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1735608880; x=1767144880;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B/RWJgt7XRMgGjzqoj9c3PHtHf+2w4qSmQxnMVJcQq8=;
  b=QUMRFCM3xncjQQN1GiXzlTFzj/Kbkp7TsB1aSBvA+RZcPkzAjp6Bor3x
   WVgs8GOLFJPuDNjSALuaXS4840i7nx7CnvpeCBvsjBc3rOHFxqHjvgy3Q
   srk/VYjXX2UY0j0SwZLJLMHOTy0UMyDdW6bSgX4h7QiI9eQXtFEQx7n0Q
   B1pDnGejgwECPq0oJHk7miar2yiZ2ZeyfzXtPriTKLnTVo+Qk6ZIFN6EA
   pU07xSr4RElQFTuKJkCut9xQU3hVVTtN0F/+hsg3g8kDj3sm2QhLXRI+t
   oFiZK+wsglBe4v6UVfT0MO3pBnvdFuakiaX6p7QGZt4hhtKWUrlQCl717
   Q==;
X-CSE-ConnectionGUID: R+bINXOmThacYVpJ/JY0mQ==
X-CSE-MsgGUID: WefOS+7PTqylE+XiE2VFhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11301"; a="185287178"
X-IronPort-AV: E=Sophos;i="6.12,278,1728918000"; 
   d="scan'208";a="185287178"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 10:34:31 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 361F9D4808;
	Tue, 31 Dec 2024 10:34:29 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 0E5F1D4C1F;
	Tue, 31 Dec 2024 10:34:29 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 7F94D20076D0F;
	Tue, 31 Dec 2024 10:34:28 +0900 (JST)
Received: from iaas-rpma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 21C651A006C;
	Tue, 31 Dec 2024 09:34:26 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-rdma@vger.kernel.org
Cc: haris.iqbal@ionos.com,
	Jack Wang <jinpu.wang@ionos.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-kernel@vger.kernel.org,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	shinichiro.kawasaki@wdc.com,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] RDMA/rtrs: server: Ensure 'ib_sge list' is accessible
Date: Tue, 31 Dec 2024 09:34:16 +0800
Message-Id: <20241231013416.1290920-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28892.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28892.003
X-TMASE-Result: 10-1.264800-10.000000
X-TMASE-MatchedRID: z0G37ECbopwM5CG8CYBPxQXGi/7cli9j9LMB0hXFSei7N2IdiDgmMwaB
	oVdU3bkBCuZTseam0Rh4BoHLZ4KzsifdCFu+J/OIEXjPIvKd74BBHuVYxc8DW53jW+hMr638BoS
	wZf0jyCh9FB5IPghfZz6GA+hFKox/Uzd6Gmj1uilO5y1KmK5bJUyQ5fRSh265tEh/ibLfCukDX/
	yNv61n9K3ypY9XPQPGnagtny7ZPcQfE8yM4pjsD24djWaei+WESnQ4MjwaO9cqtq5d3cxkNQwWx
	r7XDKH8IJrETis/dfwFczwVR7sCZRN7kptKQj74nMGEalgBwfGkuaWymaXcySXJfme/qFea7kjY
	qKFC/zHW9EZU65IpyejVjBtLh/B6FcG3+ZRETICP9kUX1Z+buE3LumkbQiNwVCqTSPu8tVR7AxI
	EOt4h2Q==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Move the declaration of the 'ib_sge list' variable outside the
'always_invalidate' block to ensure it remains accessible for use
throughout the function.

Previously, 'ib_sge list' was declared within the 'always_invalidate'
block, limiting its accessibility, then caused a
'BUG: kernel NULL pointer dereference'[1].
 ? __die_body.cold+0x19/0x27
 ? page_fault_oops+0x15a/0x2d0
 ? search_module_extables+0x19/0x60
 ? search_bpf_extables+0x5f/0x80
 ? exc_page_fault+0x7e/0x180
 ? asm_exc_page_fault+0x26/0x30
 ? memcpy_orig+0xd5/0x140
 rxe_mr_copy+0x1c3/0x200 [rdma_rxe]
 ? rxe_pool_get_index+0x4b/0x80 [rdma_rxe]
 copy_data+0xa5/0x230 [rdma_rxe]
 rxe_requester+0xd9b/0xf70 [rdma_rxe]
 ? finish_task_switch.isra.0+0x99/0x2e0
 rxe_sender+0x13/0x40 [rdma_rxe]
 do_task+0x68/0x1e0 [rdma_rxe]
 process_one_work+0x177/0x330
 worker_thread+0x252/0x390
 ? __pfx_worker_thread+0x10/0x10

This change ensures the variable is available for subsequent operations
that require it.

[1] https://lore.kernel.org/linux-rdma/6a1f3e8f-deb0-49f9-bc69-a9b03ecfcda7@fujitsu.com/

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index e83d95647852..65b7e669341c 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -351,6 +351,7 @@ static int send_io_resp_imm(struct rtrs_srv_con *con, struct rtrs_srv_op *id,
 	enum ib_send_flags flags;
 	u32 imm;
 	int err;
+	struct ib_sge list;
 
 	if (id->dir == READ) {
 		struct rtrs_msg_rdma_read *rd_msg = id->rd_msg;
@@ -401,7 +402,6 @@ static int send_io_resp_imm(struct rtrs_srv_con *con, struct rtrs_srv_op *id,
 	imm = rtrs_to_io_rsp_imm(id->msg_id, errno, need_inval);
 	imm_wr.wr.next = NULL;
 	if (always_invalidate) {
-		struct ib_sge list;
 		struct rtrs_msg_rkey_rsp *msg;
 
 		srv_mr = &srv_path->mrs[id->msg_id];
-- 
2.47.0


