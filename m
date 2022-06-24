Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BB2559851
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jun 2022 13:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiFXLKY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jun 2022 07:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiFXLKX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jun 2022 07:10:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D6A55378
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jun 2022 04:10:22 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LTvWj5Z5GzkWkX;
        Fri, 24 Jun 2022 19:09:05 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 24 Jun 2022 19:10:20 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 24 Jun 2022 19:10:20 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 0/5] Supports recovery of on-chip RAM 1bit ECC errors
Date:   Fri, 24 Jun 2022 19:08:40 +0800
Message-ID: <20220624110845.48184-1-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Add support for the 1bit ECC error recovery by abnormal interrupt reporting
and adjusts the structure of the abnormal interrupt handler.

The following is the outline of each patch:
(1)#1~#4: Cleanup and bugfix for the abnormal interrupt handler.
(2)#5: Support for the 1bit ECC error recovery.

Haoyue Xu (5):
  RDMA/hns: Remove unused abnormal interrupt of type RAS
  RDMA/hns: Fix the wrong type of return value of the interrupt handler
  RDMA/hns: Fix incorrect clearing of interrupt status register
  RDMA/hns: Refactor the abnormal interrupt handler function
  RDMA/hns: Recover 1bit-ECC error of RAM on chip

 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 267 ++++++++++++++++++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  13 +-
 2 files changed, 244 insertions(+), 36 deletions(-)

--
2.33.0

