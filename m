Return-Path: <linux-rdma+bounces-10113-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47148AAD425
	for <lists+linux-rdma@lfdr.de>; Wed,  7 May 2025 05:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5993E3BBE13
	for <lists+linux-rdma@lfdr.de>; Wed,  7 May 2025 03:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E80D149C64;
	Wed,  7 May 2025 03:39:11 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6878A29
	for <linux-rdma@vger.kernel.org>; Wed,  7 May 2025 03:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746589151; cv=none; b=GIPfQWRKuZ/C9nH6jZpgphrykODV6sYgSFGqZ6t/KEk+u9G2pNZ40VJ9h9oALWnEpyBtgBy46zlRbehkfA1Pg4SH3AHHC4XsdW3ZOiAe8PeWBfKJrCHzxyg1SH4hI5RKTroBMnyxLG8vIsbBTTYXr4maDBHlNK5FjJaE9TEg6MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746589151; c=relaxed/simple;
	bh=/D5ggKn0Wt1lkChYXqfFtjaZLAEXpgD9gphkMNz/wSA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gWTzQLIfP8aO2+X/IodO2aOmOvX86+wGuYGQ1oBc9xypve817tdN6dZSo8DXfG1Z6vAhSflrgtWzoNDhcUAiAP+2co90pArz/UC2AZQ8f1OWdO/D4tK5oTiEDM2OTRqDapTGEeGkOGdIhLw4iCyVpv4GaLu+RfQJ+hr4Yakl/5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Zsgqs0htXzyVGg;
	Wed,  7 May 2025 11:34:49 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 60108140135;
	Wed,  7 May 2025 11:39:04 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 May 2025 11:39:03 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>,
	<paulmck@kernel.org>
Subject: [PATCH for-next] RDMA/hns: Fix build error of hns_roce_trace
Date: Wed, 7 May 2025 11:39:03 +0800
Message-ID: <20250507033903.2879433-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100018.china.huawei.com (7.202.181.17)

Add include path to find hns_roce_trace.h to fix the following
build error:

In file included from drivers/infiniband/hw/hns/hns_roce_trace.h:213,
                 from drivers/infiniband/hw/hns/hns_roce_hw_v2.c:53:
./include/trace/define_trace.h:110:42: fatal error: ./hns_roce_trace.h: No such file or directory
  110 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
      |                                          ^
compilation terminated.

Fixes: 02007e3ddc07 ("RDMA/hns: Add trace for flush CQE")
Reported-by: Paul E. McKenney <paulmck@kernel.org>
Closes: https://lore.kernel.org/linux-next/b7dd4dda-37d8-47e4-8d78-b6585be21cfd@paulmck-laptop/T/#t
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/hns/Makefile b/drivers/infiniband/hw/hns/Makefile
index 7917af8e6380..baf592e6f21b 100644
--- a/drivers/infiniband/hw/hns/Makefile
+++ b/drivers/infiniband/hw/hns/Makefile
@@ -4,6 +4,7 @@
 #
 
 ccflags-y :=  -I $(srctree)/drivers/net/ethernet/hisilicon/hns3
+ccflags-y +=  -I $(src)
 
 hns-roce-hw-v2-objs := hns_roce_main.o hns_roce_cmd.o hns_roce_pd.o \
 	hns_roce_ah.o hns_roce_hem.o hns_roce_mr.o hns_roce_qp.o \
-- 
2.33.0


