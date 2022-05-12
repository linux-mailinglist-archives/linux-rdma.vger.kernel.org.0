Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D3052478B
	for <lists+linux-rdma@lfdr.de>; Thu, 12 May 2022 10:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351299AbiELIBT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 May 2022 04:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351288AbiELIBS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 May 2022 04:01:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73062580E2
        for <linux-rdma@vger.kernel.org>; Thu, 12 May 2022 01:01:17 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KzPKY5yGLzGpZJ;
        Thu, 12 May 2022 15:58:25 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 16:01:15 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 16:01:14 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 0/2] RDMA/hns: Use hr_reg_xxx() instead of remaining roce_set_xxx()/roce_get_xxx()
Date:   Thu, 12 May 2022 16:00:10 +0800
Message-ID: <20220512080012.38728-1-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

The current hns driver still partially uses roce_set_xxx()/roce_get_xxx()
to write and read data fields. To make the code clearer, replace all
roce_set_xxx()/roce_get_xxx() with hr_reg_xxx().

Wenpeng Liang (2):
  RDMA/hns: Use hr_reg_xxx() instead of remaining roce_set_xxx()
  RDMA/hns: Use hr_reg_read() instead of remaining roce_get_xxx()

 drivers/infiniband/hw/hns/hns_roce_device.h   |  14 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    | 398 ++++++------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h    | 324 +++++---------
 drivers/infiniband/hw/hns/hns_roce_restrack.c |  49 +--
 4 files changed, 261 insertions(+), 524 deletions(-)

--
2.33.0

