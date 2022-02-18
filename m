Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0A94BB79B
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Feb 2022 12:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbiBRLFz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Feb 2022 06:05:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiBRLFj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Feb 2022 06:05:39 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E790F291FA7
        for <linux-rdma@vger.kernel.org>; Fri, 18 Feb 2022 03:05:22 -0800 (PST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K0TMd3Cbpz9sl8;
        Fri, 18 Feb 2022 19:03:41 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Feb 2022 19:05:20 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Feb 2022 19:05:20 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 0/8] RDMA/hns: Clean up and refactor mailbox-related code
Date:   Fri, 18 Feb 2022 19:05:11 +0800
Message-ID: <20220218110519.37375-1-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
and refactored more urgently.

The following is the basic information of each patch
(1) #1~#4: Preparing for refactoring
(2) #5: Formal Refactoring
(3) #6~#7: Follow-up cleanup

Chengchang Tang (5):
  RDMA/hns: Remove the unused parameter "op_modifier" in mailbox
  RDMA/hns: Remove fixed parameter “timeout” in the mailbox
  RDMA/hns: Refactor mailbox functions
  RDMA/hns: Remove similar code that configures the hardware contexts
  RDMA/hns: Refactor the alloc_srqc()

Wenpeng Liang (3):
  RDMA/hns: Remove redundant parameter "mailbox" in the mailbox
  RDMA/hns: Fix the wrong type of parameter "op" of the mailbox
  RDMA/hns: Refactor the alloc_cqc()

 drivers/infiniband/hw/hns/hns_roce_cmd.c      | 108 +++++++------
 drivers/infiniband/hw/hns/hns_roce_cmd.h      |   8 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c       |  71 +++++----
 drivers/infiniband/hw/hns/hns_roce_device.h   |  24 +--
 drivers/infiniband/hw/hns/hns_roce_hem.c      |   4 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    | 143 ++++++++----------
 .../infiniband/hw/hns/hns_roce_hw_v2_dfx.c    |   5 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c       |  38 ++---
 drivers/infiniband/hw/hns/hns_roce_srq.c      | 104 +++++++------
 9 files changed, 260 insertions(+), 245 deletions(-)

--
2.33.0

