Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5FD4C9DF5
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Mar 2022 07:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239740AbiCBGtZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Mar 2022 01:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiCBGtZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Mar 2022 01:49:25 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1653B251E
        for <linux-rdma@vger.kernel.org>; Tue,  1 Mar 2022 22:48:41 -0800 (PST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K7l2S1RbgzbbwZ;
        Wed,  2 Mar 2022 14:44:00 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 14:48:40 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 14:48:39 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH v3 for-next 0/9] RDMA/hns: Clean up and refactor mailbox-related code
Date:   Wed, 2 Mar 2022 14:48:21 +0800
Message-ID: <20220302064830.61706-1-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

The following is the basic information of each patch:
(1) #1~#4: Preparing for refactoring
(2) #5: Formal Refactoring
(3) #6~#9: Follow-up cleanup

Changes since v2:
* Keep using ERR_CAST in the patch #7.
* v2 Link: https://patchwork.kernel.org/project/linux-rdma/cover/20220225112559.43300-1-liangwenpeng@huawei.com/

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
 drivers/infiniband/hw/hns/hns_roce_mr.c       |  44 ++----
 drivers/infiniband/hw/hns/hns_roce_srq.c      | 106 +++++++------
 9 files changed, 252 insertions(+), 254 deletions(-)

--
2.33.0

