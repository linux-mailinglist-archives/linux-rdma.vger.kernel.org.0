Return-Path: <linux-rdma+bounces-15224-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F7ACDE8BE
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Dec 2025 10:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B2773009FB4
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Dec 2025 09:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DDA23D7E6;
	Fri, 26 Dec 2025 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="RlGNBdRQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21B519CD1D;
	Fri, 26 Dec 2025 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766742151; cv=none; b=g+F9N/wg8w9rKdkU8/J26qmS/E8MG98nrnh/wT2v2ZH6kAmj79f4TyY7aruVBN5CDTRFT6WeGkkX6/Gd3ab0p+mL9MjufeCyT5/J26I/H1RrfBPQRWQRtPyFQLM5q9DddKDtf/rNc/3R+qsbBDSAmPQ1+Edw/zQlukvU0udO/XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766742151; c=relaxed/simple;
	bh=5BXNp2D040taK7H3M5hXtvJlFuhRHWvtEn+5QepctJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M4JjUlCJsozSPRhFx1veuTnfmQa4AHDt+aqDt00d4G+UCQ/F2GIRp13218Qf99yaCRPeO/1q9E05B+cy4yzRSN8QV0KA3LfwDsK4iPCNV3MgpYQJC2HZiINuNi3uBeS80yhBTu42Blz8lWOmjRvGtmrJhf+s0aLKR1S5uN2fwN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=RlGNBdRQ; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1766742150; x=1798278150;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5BXNp2D040taK7H3M5hXtvJlFuhRHWvtEn+5QepctJc=;
  b=RlGNBdRQsPnH96b2TjxrMt9Rwd9J6Ma4KKaU3UVt8jrI9545xS3uWnYG
   mvB/E3cdreWu0qs+8haLvtC03ABNipqr8LMruyBYiJ0rHY2oZ71BFqdfH
   188W0MK9YoJuh2fDw+2ZzTf1yopdmCcpcCDyQoAnwlHe0Whmq6fFN59pW
   rId4DzSd43PY4j3p/0PJR72NY1qi1Bju1EcvZcXGhOwj3DXP3FVwKHq48
   aB7+fozJPtWqCVDCjrL0YgBNIqNXRbBo9zykcgFTlmzoYuI4RfhdjPqV3
   v9aPoZq6m9CkimL+eHvnd+gbqCpfIvRZDIHr6ASLtqKPBdRQj0WUy9i11
   g==;
X-CSE-ConnectionGUID: htCsIySDRkCo1UKqi83/4w==
X-CSE-MsgGUID: /BDCctPOTFWSUc639WHgfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11652"; a="223461253"
X-IronPort-AV: E=Sophos;i="6.21,177,1763391600"; 
   d="scan'208";a="223461253"
Received: from unknown (HELO az2uksmgr2.o.css.fujitsu.com) ([52.151.125.19])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2025 18:41:20 +0900
Received: from az2uksmgm2.o.css.fujitsu.com (unknown [10.151.22.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgr2.o.css.fujitsu.com (Postfix) with ESMTPS id CBB29820C0A;
	Fri, 26 Dec 2025 09:41:19 +0000 (UTC)
Received: from az2nlsmom2.o.css.fujitsu.com (az2nlsmom2.o.css.fujitsu.com [10.150.26.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm2.o.css.fujitsu.com (Postfix) with ESMTPS id 83DF51809C10;
	Fri, 26 Dec 2025 09:41:19 +0000 (UTC)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.135.44])
	by az2nlsmom2.o.css.fujitsu.com (Postfix) with ESMTP id BB5871802EEC;
	Fri, 26 Dec 2025 09:41:15 +0000 (UTC)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	Daisuke Matsuda <dskmtsd@gmail.com>,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] IB/rxe: ODP: Fix missing umem_odp->umem_mutex unlock
Date: Fri, 26 Dec 2025 17:41:12 +0800
Message-ID: <20251226094112.3042583-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rxe_odp_map_range_and_lock() should unlock umem_odp->umem_mutex on error.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_odp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index 8b6a8b064d3c..d22b08da2713 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -178,8 +178,10 @@ static int rxe_odp_map_range_and_lock(struct rxe_mr *mr, u64 iova, int length, u
 			return err;
 
 		need_fault = rxe_check_pagefault(umem_odp, iova, length);
-		if (need_fault)
+		if (need_fault) {
+			mutex_unlock(&umem_odp->umem_mutex);
 			return -EFAULT;
+		}
 	}
 
 	return 0;
-- 
2.41.0


