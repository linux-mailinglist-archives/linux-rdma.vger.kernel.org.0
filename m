Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655DD621288
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Nov 2022 14:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbiKHNjy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Nov 2022 08:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbiKHNjw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Nov 2022 08:39:52 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537D517590;
        Tue,  8 Nov 2022 05:39:51 -0800 (PST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N68Mw5DL6zHvd7;
        Tue,  8 Nov 2022 21:39:24 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 21:39:48 +0800
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 21:39:48 +0800
From:   Haoyue Xu <xuhaoyue1@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <xuhaoyue1@hisilicon.com>
Subject: [PATCH v3 for-rc 0/2] Fix sge_num bug
Date:   Tue, 8 Nov 2022 21:38:45 +0800
Message-ID: <20221108133847.2304539-1-xuhaoyue1@hisilicon.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

The patchset mainly fixes the sge_num bug relates to sq_inline.

Changes since v2:
1. Move the refactor rq_inline and new CQE inline patches to go 
into for-next after this bugfix apply.
2. Change the commit message to better explain the bug.
V2 Link: https://patchwork.kernel.org/project/linux-rdma/cover/20221026095054.2384620-1-xuhaoyue1@hisilicon.com/

Luoyouming (2):
  RDMA/hns: Fix ext_sge num error when post send
  RDMA/hns: Fix the problem of sge nums

 drivers/infiniband/hw/hns/hns_roce_device.h |   3 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |   3 +-
 drivers/infiniband/hw/hns/hns_roce_main.c   |  18 +++-
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 107 ++++++++++++++++----
 include/uapi/rdma/hns-abi.h                 |  15 +++
 5 files changed, 125 insertions(+), 21 deletions(-)

-- 
2.30.0

