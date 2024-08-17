Return-Path: <linux-rdma+bounces-4399-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA66955672
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Aug 2024 10:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75DCE282008
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Aug 2024 08:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C196144D1F;
	Sat, 17 Aug 2024 08:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WHc/rpZm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D8C83A06
	for <linux-rdma@vger.kernel.org>; Sat, 17 Aug 2024 08:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723884205; cv=none; b=IKGeUKdZE7K7n82KXx2mOlaaQ77JHERdVEmOvq+gDE1c9YbaZgUKkn9nzeanSSpxBopbkGSH+ZcP+VR2bZEa0rY+VGWUC9vP6LmNn09bQGtqb/8OXeTq7LNYfHQut7cR8h8R/4RTMSoph+uGj0Xt5YzLcm2eaU154c8nWyGYfbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723884205; c=relaxed/simple;
	bh=7ZQjAvxekPI9hJAGy5Y/uqjIfbkBt90viKNDw5+uS5s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W0MBavd9p9AfZk8EZImTzI7MNZ6+DypR2hH0Hzlrn5iCpEg9/imB3aUAJiCigdZ1Bd7zAtedcjKC+1o0GOOyxXw1+sKqIrns3Hkbev75W5GiQba2yNj4NUuuq1W9bbGVvuAdrLYA63dkGP4D6jzpf3xVHultNAdhCKDCJ9NxjLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WHc/rpZm; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723884196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QQREKn+eZ5yKgYa1lky3OP+mFozFXFenH5D2Wfwt9Q4=;
	b=WHc/rpZmQqkd9oeg1abxyeWk5LziE3hq92il1PI4fBaQL+n0lx6KVUH1EQpS7FPVJBK5PI
	Gmoutv4VNMo6Ql+Fgub/KctoNlRMCeu8Tjo334nQHcKf4gmP07D6dFp1bjeRbxjxJZtwBO
	yBCgH/S3fKbQ4jdNRd+UAbDtsmXlL00=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: bvanassche@acm.org,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	shinichiro.kawasaki@wdc.com
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH 1/1] RDMA/iwcm: Fix WARNING:at_kernel/workqueue.c:#check_flush_dependency
Date: Sat, 17 Aug 2024 10:42:44 +0200
Message-Id: <20240817084244.536397-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When workqueue_flush is invoked, WQ_MEM_RECLAIM is checked to avoid
errors.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202408151633.fc01893c-oliver.sang@intel.com
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/core/iwcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
index 1a6339f3a63f..7e3a55349e10 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -1182,7 +1182,7 @@ static int __init iw_cm_init(void)
 	if (ret)
 		return ret;
 
-	iwcm_wq = alloc_ordered_workqueue("iw_cm_wq", 0);
+	iwcm_wq = alloc_ordered_workqueue("iw_cm_wq", WQ_MEM_RECLAIM);
 	if (!iwcm_wq)
 		goto err_alloc;
 
-- 
2.34.1


