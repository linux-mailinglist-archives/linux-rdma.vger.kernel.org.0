Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452AC70DC56
	for <lists+linux-rdma@lfdr.de>; Tue, 23 May 2023 14:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbjEWMSy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 May 2023 08:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjEWMSv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 May 2023 08:18:51 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3194F109;
        Tue, 23 May 2023 05:18:50 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QQYCJ0BVTz18LXn;
        Tue, 23 May 2023 20:14:20 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 20:18:47 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-rc 0/3] RDMA/hns: Bugfix and improvements
Date:   Tue, 23 May 2023 20:16:38 +0800
Message-ID: <20230523121641.3132102-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

1. #1-#2: The first two patches improves diagnostic information to
   the driver.

2. #3: The third patch removes unnecessary QP type checks.


Chengchang Tang (2):
  RDMA/hns: Fix hns_roce_table_get return value
  RDMA/hns: Add clear_hem return value to log

Junxian Huang (1):
  RDMA/hns: Remove unnecessary QP type checks

 drivers/infiniband/hw/hns/hns_roce_hem.c   | 51 ++++++++++++++--------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 22 ++--------
 2 files changed, 37 insertions(+), 36 deletions(-)

--
2.30.0

