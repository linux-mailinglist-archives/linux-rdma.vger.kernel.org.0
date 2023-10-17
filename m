Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484787CC3BB
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Oct 2023 14:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343662AbjJQM4B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Oct 2023 08:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbjJQMz6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Oct 2023 08:55:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAC683;
        Tue, 17 Oct 2023 05:55:56 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S8v585wSWzVldY;
        Tue, 17 Oct 2023 20:52:12 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 17 Oct 2023 20:55:51 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-rc 0/7] Bugfixes for hns RoCE
Date:   Tue, 17 Oct 2023 20:52:32 +0800
Message-ID: <20231017125239.164455-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here is a patchset of several bugfixes.

Chengchang Tang (3):
  RDMA/hns: Fix printing level of asynchronous events
  RDMA/hns: Fix uninitialized ucmd in hns_roce_create_qp_common()
  RDMA/hns: Fix signed-unsigned mixed comparisons

Junxian Huang (2):
  RDMA/hns: Fix unnecessary port_num transition in HW stats allocation
  RDMA/hns: Fix init failure of RoCE VF and HIP08

Luoyouming (2):
  RDMA/hns: Add check for SL
  RDMA/hns: The UD mode can only be configured with DCQCN

 drivers/infiniband/hw/hns/hns_roce_ah.c    | 13 ++++++++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 34 +++++++++++++---------
 drivers/infiniband/hw/hns/hns_roce_main.c  | 22 +++++++-------
 drivers/infiniband/hw/hns/hns_roce_qp.c    |  2 +-
 4 files changed, 43 insertions(+), 28 deletions(-)

--
2.30.0

