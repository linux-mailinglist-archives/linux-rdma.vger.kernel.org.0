Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B565E6277
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Sep 2022 14:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiIVMeN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Sep 2022 08:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiIVMeL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Sep 2022 08:34:11 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F622E7205
        for <linux-rdma@vger.kernel.org>; Thu, 22 Sep 2022 05:34:10 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MYF5n47VYzHng0;
        Thu, 22 Sep 2022 20:31:57 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 20:34:08 +0800
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 20:34:01 +0800
From:   Haoyue Xu <xuhaoyue1@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>, <xuhaoyue1@hisilicon.com>
Subject: [PATCH for-next 00/12] RDMA/hns: Cleanups for kernel-6.1
Date:   Thu, 22 Sep 2022 20:33:03 +0800
Message-ID: <20220922123315.3732205-1-xuhaoyue1@hisilicon.com>
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

This series includes:
(1) #1: About the spelling mistakes.
(2) #2: About the unnecessary braces.
(3) #3: About the unnecessary brackets.
(4) #4 #5 #6 #7 #8 #9: About the redundant variables.
(5) #10 #11: About Repacing constant variables by macros.
(6) #12: About Unified log style.

Chengchang Tang (1):
  RDMA/hns: Remove redundant 'phy_addr' in hns_roce_hem_list_find_mtt()

Guofeng Yue (4):
  RDMA/hns: Cleanup for a spelling error of Asynchronous
  RDMA/hns: Remove unnecessary braces for single statement blocks
  RDMA/hns: Remove unnecessary brackets when getting point
  RDMA/hns: Unified Log Printing Style

Luoyouming (1):
  RDMA/hns: Repacing 'dseg_len' by macros in fill_ext_sge_inl_data()

Yangyang Li (2):
  RDMA/hns: Remove redundant 'num_mtt_segs' and 'max_extend_sg'
  RDMA/hns: Remove redundant 'max_srq_desc_sz' in caps

Yixing Liu (2):
  RDMA/hns: Remove redundant 'attr_mask' in modify_qp_init_to_init()
  RDMA/hns: Replacing magic number with macros in apply_func_caps()

Yunsheng Lin (2):
  RDMA/hns: Remove redundant 'bt_level' for hem_list_alloc_item()
  RDMA/hns: Remove redundant 'use_lowmem' argument from
    hns_roce_init_hem_table()

 drivers/infiniband/hw/hns/hns_roce_cq.c     |  6 +-
 drivers/infiniband/hw/hns/hns_roce_device.h |  7 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c    | 33 +++-----
 drivers/infiniband/hw/hns/hns_roce_hem.h    |  5 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 85 ++++++++++-----------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  8 +-
 drivers/infiniband/hw/hns/hns_roce_main.c   | 53 +++++++------
 drivers/infiniband/hw/hns/hns_roce_mr.c     |  6 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 16 ++--
 9 files changed, 98 insertions(+), 121 deletions(-)

-- 
2.30.0

