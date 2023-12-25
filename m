Return-Path: <linux-rdma+bounces-483-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EB481DEE7
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Dec 2023 08:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AEC6B20FCB
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Dec 2023 07:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155A215B0;
	Mon, 25 Dec 2023 07:57:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05C76FA1;
	Mon, 25 Dec 2023 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Sz9FV1Hmbz1R5pL;
	Mon, 25 Dec 2023 15:55:58 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 5B1F21A0172;
	Mon, 25 Dec 2023 15:57:16 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Dec 2023 15:57:15 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next 0/6] RDMA/hns: Improvement for multi-level addressing
Date: Mon, 25 Dec 2023 15:53:24 +0800
Message-ID: <20231225075330.4116470-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500006.china.huawei.com (7.221.188.68)

This series optimizes multi-level addressing for hns.

Patch #1, #2 and #6 are optimization of multi-level addressing codes.

Patch #3 is prepared for the following optimizations.

Patch #4 and #5 introduce adaptive pagesize and hopnum to improve HW
performance.

Chengchang Tang (5):
  RDMA/hns: Refactor mtr find
  RDMA/hns: Refactor mtr_init_buf_cfg()
  RDMA/hns: Alloc MTR memory before alloc_mtt()
  RDMA/hns: Support flexible pagesize
  RDMA/hns: Support adaptive PBL hopnum

Yunsheng Lin (1):
  RDMA/hns: Simplify 'struct hns_roce_hem' allocation

 drivers/infiniband/hw/hns/hns_roce_alloc.c  |   6 -
 drivers/infiniband/hw/hns/hns_roce_cq.c     |  11 +-
 drivers/infiniband/hw/hns/hns_roce_device.h |  16 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c    |  95 +----
 drivers/infiniband/hw/hns/hns_roce_hem.h    |  56 +--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 111 +++---
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 386 +++++++++++++++-----
 7 files changed, 386 insertions(+), 295 deletions(-)

--
2.30.0


