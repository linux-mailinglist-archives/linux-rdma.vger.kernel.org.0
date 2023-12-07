Return-Path: <linux-rdma+bounces-308-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D858086F3
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 12:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C1C7283FFF
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 11:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CE339AC4;
	Thu,  7 Dec 2023 11:46:15 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11E2D53;
	Thu,  7 Dec 2023 03:46:10 -0800 (PST)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SmCBb6hpnzYsnr;
	Thu,  7 Dec 2023 19:45:27 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 19:46:07 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v2 for-next 0/5] Bugfixes and improvements for hns RoCE
Date: Thu, 7 Dec 2023 19:42:26 +0800
Message-ID: <20231207114231.2872104-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected

Here are several bugfixes and improvements for hns RoCE.

v1 -> v2:
* Change applying target from -rc to -next
* Drop patch #6 in v1

Chengchang Tang (3):
  RDMA/hns: Rename the interrupts
  RDMA/hns: Remove unnecessary checks for NULL in mtr_alloc_bufs()
  RDMA/hns: Fix memory leak in free_mr_init()

Junxian Huang (2):
  RDMA/hns: Response dmac to userspace
  RDMA/hns: Add a max length of gid table

 drivers/infiniband/hw/hns/hns_roce_ah.c    |  7 +++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 22 +++++++++++++++++-----
 drivers/infiniband/hw/hns/hns_roce_mr.c    |  2 +-
 include/uapi/rdma/hns-abi.h                |  5 +++++
 4 files changed, 30 insertions(+), 6 deletions(-)

--
2.30.0


