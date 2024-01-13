Return-Path: <linux-rdma+bounces-616-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3786582CAA4
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Jan 2024 10:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEDCC1F23041
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Jan 2024 09:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3F47FF;
	Sat, 13 Jan 2024 09:03:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC6F7E6;
	Sat, 13 Jan 2024 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TBsqs3yDqz1xm4K;
	Sat, 13 Jan 2024 17:02:49 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 097391A0190;
	Sat, 13 Jan 2024 17:03:30 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 13 Jan 2024 17:03:29 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v2 for-next 0/6] RDMA/hns: Improvement for multi-level addressing
Date: Sat, 13 Jan 2024 16:59:29 +0800
Message-ID: <20240113085935.2838701-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500006.china.huawei.com (7.221.188.68)

This series optimizes multi-level addressing for hns.

Patch #1, #2 and #6 are optimization of multi-level addressing codes.

Patch #3 is prepared for the following optimizations.

Patch #4 and #5 introduce adaptive pagesize and hopnum to improve HW
performance.

v1 -> v2:
* Remove the kmem page size modification in patch #4. Only adjust page
  size for umem.

Chengchang Tang (5):
  RDMA/hns: Refactor mtr find
  RDMA/hns: Refactor mtr_init_buf_cfg()
  RDMA/hns: Alloc MTR memory before alloc_mtt()
  RDMA/hns: Support flexible umem page size
  RDMA/hns: Support adaptive PBL hopnum

Yunsheng Lin (1):
  RDMA/hns: Simplify 'struct hns_roce_hem' allocation

 drivers/infiniband/hw/hns/hns_roce_cq.c     |  11 +-
 drivers/infiniband/hw/hns/hns_roce_device.h |  16 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c    |  95 ++----
 drivers/infiniband/hw/hns/hns_roce_hem.h    |  56 +---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 111 ++++---
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 339 ++++++++++++++------
 6 files changed, 339 insertions(+), 289 deletions(-)

--
2.30.0


