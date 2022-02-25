Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289504C439A
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Feb 2022 12:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238550AbiBYL1K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Feb 2022 06:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbiBYL1I (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Feb 2022 06:27:08 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7930E1DBA81
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 03:26:21 -0800 (PST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K4nVD6wYqzBrJg;
        Fri, 25 Feb 2022 19:24:20 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 19:26:06 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 19:26:05 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH v2 for-next 0/9] RDMA/hns: Clean up and refactor mailbox-related code
Date:   Fri, 25 Feb 2022 19:25:50 +0800
Message-ID: <20220225112559.43300-1-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Mailbox-related code is getting harder to maintain. Especially after
removing the HIP06 code, the mailbox-related code needs to be cleaned
up and refactored more urgently.

The following is the basic information of each patch
(1) #1~#4: Preparing for refactoring
(2) #5: Formal Refactoring
(3) #6~#9: Follow-up cleanup

Changes since v1:
* Remove unnecessary mbox_msg assignment functions in patch #5.
* Add a new patch #7 to clean up the return value check of hns_roce_alloc_cmd_mailbox().
* v1 Link: https://patchwork.kernel.org/project/linux-rdma/cover/20220218110519.37375-1-liangwenpeng@huawei.com/

Chengchang Tang (5):
  RDMA/hns: Remove the unused parameter "op_modifier" in mailbox
  RDMA/hns: Remove fixed parameter “timeout” in the mailbox
  RDMA/hns: Refactor mailbox functions
  RDMA/hns: Remove similar code that configures the hardware contexts
  RDMA/hns: Refactor the alloc_srqc()

Wenpeng Liang (4):
  RDMA/hns: Remove redundant parameter "mailbox" in the mailbox
  RDMA/hns: Fix the wrong type of parameter "op" of the mailbox
  RDMA/hns: Clean up the return value check of
    hns_roce_alloc_cmd_mailbox()
  RDMA/hns: Refactor the alloc_cqc()

 drivers/infiniband/hw/hns/hns_roce_cmd.c      |  97 ++++++------
 drivers/infiniband/hw/hns/hns_roce_cmd.h      |   8 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c       |  71 +++++----
 drivers/infiniband/hw/hns/hns_roce_device.h   |  24 +--
 drivers/infiniband/hw/hns/hns_roce_hem.c      |   4 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    | 147 ++++++++----------
 .../infiniband/hw/hns/hns_roce_hw_v2_dfx.c    |   5 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c       |  46 ++----
 drivers/infiniband/hw/hns/hns_roce_srq.c      | 106 +++++++------
 9 files changed, 253 insertions(+), 255 deletions(-)

--
2.33.0

