Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D62060CA6C
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Oct 2022 12:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbiJYKxn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Oct 2022 06:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiJYKxm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Oct 2022 06:53:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F22E18149D
        for <linux-rdma@vger.kernel.org>; Tue, 25 Oct 2022 03:53:41 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MxTFW3zvSzmVJm;
        Tue, 25 Oct 2022 18:48:47 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 18:53:39 +0800
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 18:53:38 +0800
From:   Haoyue Xu <xuhaoyue1@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <xuhaoyue1@hisilicon.com>
Subject: [PATCH for-rc 0/5] Fix sge_num bug and add cqe inline, refactor rq inline
Date:   Tue, 25 Oct 2022 18:52:39 +0800
Message-ID: <20221025105244.204570-1-xuhaoyue1@hisilicon.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Luoyouming <luoyouming@huawei.com>

The patchset mainly fixes and refactors the code relate
to inline features and supports cqe inline in user space.
1.#1-2: Fix the problem of sge
2.#3-4: Remove enable rq inline in kernel and add compatibility handling
3.#5: Support CQE inline in user space

The user space part is named "libhns: Support cqe inline,
handle rq inline compatibility, fix sge_num bug".

Luoyouming (5):
  RDMA/hns: Fix ext_sge num error when post send
  RDMA/hns: Fix the problem of sge nums
  RDMA/hns: Remove enable rq inline in kernel and add compatibility
    handling
  RDMA/hns: Support cqe inline in user space
  RDMA/hns: Remove rq inline in kernel

 drivers/infiniband/hw/hns/hns_roce_device.h |  26 +--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  93 ++++------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   3 +-
 drivers/infiniband/hw/hns/hns_roce_main.c   |  28 ++-
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 180 +++++++++++---------
 include/uapi/rdma/hns-abi.h                 |  21 +++
 6 files changed, 186 insertions(+), 165 deletions(-)

-- 
2.30.0

