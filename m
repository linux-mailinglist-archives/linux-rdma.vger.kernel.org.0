Return-Path: <linux-rdma+bounces-8590-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14649A5D6CA
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 08:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55587175A6C
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 07:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8141E32C5;
	Wed, 12 Mar 2025 07:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="DBjlOl0n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE28C13B
	for <linux-rdma@vger.kernel.org>; Wed, 12 Mar 2025 07:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741762929; cv=none; b=sIFBwTcRJXZDUxcAUqGZ8fyAdayQVzWbyyFudzxP3R/jxRedgLzQwzvS1tnyucjF/TLF0u3YY9xvYz7ETuj1wYZJV4g3KgGp93ZqqV82b3P9agmTfr9f4lOjds3pdAMZPkTxeDGFywIB7axjTR9xIEG6xfp696bB/pTyh/JlpC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741762929; c=relaxed/simple;
	bh=ckDTY0wQvRNm3UVXRDC1wMZ0EjI/rBWS84bxV841MFE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DuDq6gP6S4zQFTW3ZFsltjUPGJxwTcJrwrsiC7d9NWRyCSPi4o8ER46gwJnvNXlawrne2+MhTDqip8c84ZKxJ4QYyxc0APBzoHeFU6axqucEkUSfaNbUirWM0kO6q0EuiLCnX2SEWm2YZ4/1w2a0xpQYuLXayeWNr354cTg8zlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=DBjlOl0n; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1741762927; x=1773298927;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ckDTY0wQvRNm3UVXRDC1wMZ0EjI/rBWS84bxV841MFE=;
  b=DBjlOl0nyuSnnEVq8q2OVUpku8HZYMHNqWPOCPAHMxqVjSR/wOSfEkPm
   2ist9dyXHe3QY/2uTVxWEFzDzcLcSlArCMGXeaFlYaN4zb/RUjem3ndMD
   8V/7r1EwfyLbPcBX8y3XNqeIh6JrY1uf/UurGZWrU9f2V4/7haeRIi5aP
   aoGuT5jpyikD5rV9Ads28CGAsjVT1Z/0ohuGDNrba5+hUnGCpzMQXVcyU
   qPDA8uHHwXySW6HC5qKUVS+KQdBVZ9h6viqbtHscORU55kZ9MZ6xBT6T0
   +nblH2HM/DnjYZ8T94LvHNY5hQ72iQVig4IqHjKDuivx2+ak8+RCssKUG
   A==;
X-CSE-ConnectionGUID: 8FLgRQtvSFqzG/rIW+nKZA==
X-CSE-MsgGUID: ppfrIHuFShCxMKqaD/QElw==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="180163368"
X-IronPort-AV: E=Sophos;i="6.14,241,1736780400"; 
   d="scan'208";a="180163368"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 16:01:58 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 1545ED6EAD
	for <linux-rdma@vger.kernel.org>; Wed, 12 Mar 2025 16:01:56 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id E30A416E7C
	for <linux-rdma@vger.kernel.org>; Wed, 12 Mar 2025 16:01:55 +0900 (JST)
Received: from sm-x86-stp01.ssoft.mng.com (unknown [10.124.178.20])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id A58B22005348;
	Wed, 12 Mar 2025 16:01:55 +0900 (JST)
From: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To: linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next] RDMA/rxe: Improve readability of ODP pagefault interface
Date: Wed, 12 Mar 2025 15:59:37 +0900
Message-Id: <20250312065937.1787241-1-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a meaningful constant explicitly instead of hard-coding a literal.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_odp.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index a82e5011360c..94f7bbe14981 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -37,8 +37,9 @@ const struct mmu_interval_notifier_ops rxe_mn_ops = {
 	.invalidate = rxe_ib_invalidate_range,
 };
 
-#define RXE_PAGEFAULT_RDONLY BIT(1)
-#define RXE_PAGEFAULT_SNAPSHOT BIT(2)
+#define RXE_PAGEFAULT_DEFAULT 0
+#define RXE_PAGEFAULT_RDONLY BIT(0)
+#define RXE_PAGEFAULT_SNAPSHOT BIT(1)
 static int rxe_odp_do_pagefault_and_lock(struct rxe_mr *mr, u64 user_va, int bcnt, u32 flags)
 {
 	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
@@ -222,7 +223,7 @@ int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		    enum rxe_mr_copy_dir dir)
 {
 	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
-	u32 flags = 0;
+	u32 flags = RXE_PAGEFAULT_DEFAULT;
 	int err;
 
 	if (length == 0)
@@ -236,7 +237,7 @@ int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		break;
 
 	case RXE_FROM_MR_OBJ:
-		flags = RXE_PAGEFAULT_RDONLY;
+		flags |= RXE_PAGEFAULT_RDONLY;
 		break;
 
 	default:
@@ -312,7 +313,8 @@ int rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
 	int err;
 
-	err = rxe_odp_map_range_and_lock(mr, iova, sizeof(char), 0);
+	err = rxe_odp_map_range_and_lock(mr, iova, sizeof(char),
+					 RXE_PAGEFAULT_DEFAULT);
 	if (err < 0)
 		return err;
 
-- 
2.34.1


