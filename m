Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA7077DD2B
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Aug 2023 11:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243293AbjHPJV1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Aug 2023 05:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243288AbjHPJVC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Aug 2023 05:21:02 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65562135;
        Wed, 16 Aug 2023 02:21:00 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RQjGc22pNzFqg5;
        Wed, 16 Aug 2023 17:18:00 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 17:20:57 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next 0/3] RDMA/hns: Add more debugging information for rdma-tool
Date:   Wed, 16 Aug 2023 17:18:09 +0800
Message-ID: <20230816091812.2899366-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

1. #1: The first patch supports dumping QP/CQ/MR context entirely in raw
       data with rdma-tool.

2. #2: The second patch supports query of HW stats with rdma-tool.

3. #3: The last patch supports query of SW stats with rdma-tool.

Chengchang Tang (3):
  RDMA/hns: Dump whole QP/CQ/MR resource in raw
  RDMA/hns: Support hns HW stats
  RDMA/hns: Support hns SW stats

 drivers/infiniband/hw/hns/hns_roce_ah.c       |   6 +-
 drivers/infiniband/hw/hns/hns_roce_cmd.c      |  19 ++-
 drivers/infiniband/hw/hns/hns_roce_cq.c       |  15 +-
 drivers/infiniband/hw/hns/hns_roce_device.h   |  50 ++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    |  59 +++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h    |   1 +
 drivers/infiniband/hw/hns/hns_roce_main.c     | 152 +++++++++++++++++-
 drivers/infiniband/hw/hns/hns_roce_mr.c       |  26 ++-
 drivers/infiniband/hw/hns/hns_roce_pd.c       |  10 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c       |   8 +-
 drivers/infiniband/hw/hns/hns_roce_restrack.c |  75 +--------
 drivers/infiniband/hw/hns/hns_roce_srq.c      |   6 +-
 12 files changed, 325 insertions(+), 102 deletions(-)

--
2.30.0

