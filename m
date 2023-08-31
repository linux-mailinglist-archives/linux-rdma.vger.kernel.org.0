Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01E778EDB6
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Aug 2023 14:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243772AbjHaMyj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Aug 2023 08:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242207AbjHaMyj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 31 Aug 2023 08:54:39 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19801BC;
        Thu, 31 Aug 2023 05:54:36 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rc1H34xqxztRtH;
        Thu, 31 Aug 2023 20:50:39 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 31 Aug 2023 20:54:32 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v2 for-next 0/2] RDMA/hns: Add more debugging information for rdma-tool
Date:   Thu, 31 Aug 2023 20:51:37 +0800
Message-ID: <20230831125139.3593067-1-huangjunxian6@hisilicon.com>
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

1. #1: The first patch supports dumping QP/CQ/MR context entirely in raw
       data with rdma-tool.

2. #2: The second patch supports query of HW stats with rdma-tool.

V2 fixes the static warnings in V1, and drops the SW statistics patch.
The SW statistics will be implemented with a new solution and will be
sent separately later.

Chengchang Tang (2):
  RDMA/hns: Dump whole QP/CQ/MR resource in raw
  RDMA/hns: Support hns HW stats

 drivers/infiniband/hw/hns/hns_roce_device.h   | 28 +++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    | 51 ++++++++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h    |  1 +
 drivers/infiniband/hw/hns/hns_roce_main.c     | 79 +++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_restrack.c | 75 +-----------------
 5 files changed, 162 insertions(+), 72 deletions(-)

--
2.30.0

