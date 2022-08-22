Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F7F59BDC1
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Aug 2022 12:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiHVKpo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Aug 2022 06:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiHVKpe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Aug 2022 06:45:34 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442E62BB0E
        for <linux-rdma@vger.kernel.org>; Mon, 22 Aug 2022 03:45:31 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MB87Z27CYzlVlB;
        Mon, 22 Aug 2022 18:42:18 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 18:45:29 +0800
Received: from localhost.localdomain (10.67.165.2) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 18:45:29 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH v2 for-next 0/7] RDMA/hns: Add more restrack attributes to hns driver
Date:   Mon, 22 Aug 2022 18:44:48 +0800
Message-ID: <20220822104455.2311053-1-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The hns driver already supports CQ's restrack ops. Therefore, this patchset
supports QP/MR's restrack ops and CQ/QP/MR's restrack raw ops. Among them,
restrack ops dump the queue information maintained by the driver, and
restrack raw ops dump the queue context maintained by ROCEE.

Changes since v1:
* Add support for restrack raw ops.
* Add the result dumped by rdmatool in the commit message.
* v1 Link: https://patchwork.kernel.org/project/linux-rdma/cover/20220124124624.55352-1-liangwenpeng@huawei.com/

Wenpeng Liang (7):
  RDMA/hns: Remove redundant DFX file and DFX ops structure
  RDMA/hns: Add or remove CQ's restrack attributes
  RDMA/hns: Support CQ's restrack raw ops for hns driver
  RDMA/hns: Support QP's restrack ops for hns driver
  RDMA/hns: Support QP's restrack raw ops for hns driver
  RDMA/hns: Support MR's restrack ops for hns driver
  RDMA/hns: Support MR's restrack raw ops for hns driver

 drivers/infiniband/hw/hns/Makefile            |   2 +-
 drivers/infiniband/hw/hns/hns_roce_device.h   |  17 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    |  76 +++++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h    |   6 +-
 .../infiniband/hw/hns/hns_roce_hw_v2_dfx.c    |  34 ---
 drivers/infiniband/hw/hns/hns_roce_main.c     |  11 +-
 drivers/infiniband/hw/hns/hns_roce_restrack.c | 220 ++++++++++++++----
 7 files changed, 263 insertions(+), 103 deletions(-)
 delete mode 100644 drivers/infiniband/hw/hns/hns_roce_hw_v2_dfx.c

--
2.30.0

