Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A31375BC90
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jul 2023 04:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjGUCyX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jul 2023 22:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGUCyW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jul 2023 22:54:22 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A001710;
        Thu, 20 Jul 2023 19:54:21 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R6Yx13mLFzLnt6;
        Fri, 21 Jul 2023 10:51:49 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 10:54:18 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v3 for-rc 0/2] RDMA/hns: Improvements for function resource configuration
Date:   Fri, 21 Jul 2023 10:51:44 +0800
Message-ID: <20230721025146.450831-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here are 3 patches involving function resource configuration.

1. #1: The first patch supports getting xrcd num from firmware.

2. #2: The second patch removes a redundant configuration in driver,
       which is now handled by firmware.

V2 removes 'inline' before function names in the third patch.

V3 removes the third patch in V1 and V2.

*** BLURB HERE ***

Junxian Huang (1):
  RDMA/hns: Remove VF extend configuration

Luoyouming (1):
  RDMA/hns: support get xrcd num from firmware

 drivers/infiniband/hw/hns/hns_roce_device.h |  1 -
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 89 +++------------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 13 +--
 3 files changed, 14 insertions(+), 89 deletions(-)

--
2.30.0

