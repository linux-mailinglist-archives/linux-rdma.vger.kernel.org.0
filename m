Return-Path: <linux-rdma+bounces-8638-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A80DA5EBE3
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 07:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2841758A5
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 06:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F1A1B87F3;
	Thu, 13 Mar 2025 06:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="RT1Da9Tv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A718136658
	for <linux-rdma@vger.kernel.org>; Thu, 13 Mar 2025 06:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741848488; cv=none; b=X0a0YPe0fytS9RK2FvflgjIE1VMrP/xmhw8au+vhDgDA4Jmd3brGifF0ml63mHPMXogNRepFrmcWcxbM58cvBp8TcAiow/JEzSGSLYPfvqZKzIF0nUS6pa+mbbZdDX2AzcaFvD53zeKC1NBW9bnRPCvgYLNBWqGpDSDOHUzV4pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741848488; c=relaxed/simple;
	bh=/rPywIaJbIaR5UFs0mXbN7lDRfponBrE6p1AeZjw9T8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o0tA+q/aqIWenn1imRLm2XXe27GqBBt29k/mSTTHRJSnQVK/7yQDID5jwVq7U6bGYnX1B+JioCAAiWQtcgjTiYKLEsnDeqxWl/9j1fy7Kf4rVfMnbY4024cej16qGULDGndo2aY0t6CC0g8brCJ/IsAERXgqi5CRtN8RMhEM0gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=RT1Da9Tv; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1741848487; x=1773384487;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/rPywIaJbIaR5UFs0mXbN7lDRfponBrE6p1AeZjw9T8=;
  b=RT1Da9TvVB2i+XDtnEQ7XRhSKfV6kIHAADT5N0csxzVarJ6j4ipFdcz7
   D3jbcUnE3OoH/T+omsCnVIkniOVgNH2S2VV8GuznR7rtVy8bBfe7s5tLT
   pQsBkmL1CD0Jd4+Cf2C6uWN6mo8x4swe8HIynJZAmwTscmtWjeXOY7A/x
   b7L5is1fNFpIWJn/vsMH6czv7cf94ClYsoRFuiQtyCqWKNYWmoX0HPNQp
   zsE/WHd2jXPzkb2DuG7xGzWqzOzFZY8s3HCmFdzkzx+WROw4ce7DGPZin
   6D8Vtf8IDGntNYYONoFHVizxNiTfgsZ6GzS+0PeBA0vE9x/Bd/gLQ7e1v
   Q==;
X-CSE-ConnectionGUID: X1vziNBqS0CQd4IPDcpcpA==
X-CSE-MsgGUID: 7GKCal0QTQKm6l8s+onftg==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="192994772"
X-IronPort-AV: E=Sophos;i="6.14,244,1736780400"; 
   d="scan'208";a="192994772"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 15:46:39 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 3E462D4C33
	for <linux-rdma@vger.kernel.org>; Thu, 13 Mar 2025 15:46:37 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 0F1DCD52BD
	for <linux-rdma@vger.kernel.org>; Thu, 13 Mar 2025 15:46:37 +0900 (JST)
Received: from sm-x86-stp01.ssoft.mng.com (unknown [10.124.178.20])
	by m3004.s.css.fujitsu.com (Postfix) with ESMTP id AF1E020053F1;
	Thu, 13 Mar 2025 15:46:36 +0900 (JST)
From: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To: linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next] RDMA/rxe: Fix incorrect return value of rxe_odp_atomic_op()
Date: Thu, 13 Mar 2025 15:45:40 +0900
Message-Id: <20250313064540.2619115-1-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rxe_mr_do_atomic_op() returns enum resp_states numbers, so the ODP
counterpart must not return raw errno codes.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_odp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index 94f7bbe14981..9f6e2bb2a269 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -316,7 +316,7 @@ int rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 	err = rxe_odp_map_range_and_lock(mr, iova, sizeof(char),
 					 RXE_PAGEFAULT_DEFAULT);
 	if (err < 0)
-		return err;
+		return RESPST_ERR_RKEY_VIOLATION;
 
 	err = rxe_odp_do_atomic_op(mr, iova, opcode, compare, swap_add,
 				   orig_val);
-- 
2.43.0


