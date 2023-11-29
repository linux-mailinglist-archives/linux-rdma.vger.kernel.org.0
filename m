Return-Path: <linux-rdma+bounces-131-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E32C7FD324
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 10:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FBB31C20970
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 09:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4396D18E1C;
	Wed, 29 Nov 2023 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0679819AE;
	Wed, 29 Nov 2023 01:48:10 -0800 (PST)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SgDy33z5hzWhp0;
	Wed, 29 Nov 2023 17:47:23 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 29 Nov 2023 17:48:07 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-rc 0/6] Bugfixes and improvements for hns RoCE
Date: Wed, 29 Nov 2023 17:44:28 +0800
Message-ID: <20231129094434.134528-1-huangjunxian6@hisilicon.com>
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
X-CFilter-Loop: Reflected

Here are several bugfixes and improvements for hns RoCE.

Chengchang Tang (4):
  RDMA/hns: Rename the interrupts
  RDMA/hns: Remove unnecessary checks for NULL in mtr_alloc_bufs()
  RDMA/hns: Fix memory leak in free_mr_init()
  RDMA/hns: Improve the readability of free mr uninit

Junxian Huang (2):
  RDMA/hns: Response dmac to userspace
  RDMA/hns: Add a max length of gid table

 drivers/infiniband/hw/hns/hns_roce_ah.c    |  7 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 87 +++++++++++++++-------
 drivers/infiniband/hw/hns/hns_roce_mr.c    |  2 +-
 include/uapi/rdma/hns-abi.h                |  5 ++
 4 files changed, 73 insertions(+), 28 deletions(-)

--
2.30.0


