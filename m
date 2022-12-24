Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC12E6559C7
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Dec 2022 11:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiLXKXJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 24 Dec 2022 05:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiLXKXI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 24 Dec 2022 05:23:08 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8857CBCBF;
        Sat, 24 Dec 2022 02:23:07 -0800 (PST)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NfKpj5V79zRq32;
        Sat, 24 Dec 2022 18:21:49 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 24 Dec 2022 18:23:05 +0800
From:   Haoyue Xu <xuhaoyue1@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <xuhaoyue1@hisilicon.com>
Subject: [PATCH for-next 0/3] Refactor rq inline and add cqe inline
Date:   Sat, 24 Dec 2022 18:21:58 +0800
Message-ID: <20221224102201.3114536-1-xuhaoyue1@hisilicon.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

The patchset mainly removes the kernel space
rq inline features and supports cqe inline in user space.

Luoyouming (3):
  RDMA/hns: Remove rq inline in kernel
  RDMA/hns: Add compatibility handling for only support userspace rq
    inline
  RDMA/hns: Support cqe inline in user space

 drivers/infiniband/hw/hns/hns_roce_device.h |  19 +---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 109 ++++++--------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   3 +-
 drivers/infiniband/hw/hns/hns_roce_main.c   |  12 +++
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  66 +-----------
 include/uapi/rdma/hns-abi.h                 |   4 +
 6 files changed, 54 insertions(+), 159 deletions(-)

-- 
2.30.0

