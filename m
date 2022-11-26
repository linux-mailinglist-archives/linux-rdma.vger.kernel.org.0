Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CC663954D
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Nov 2022 11:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiKZKaL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 26 Nov 2022 05:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKZKaJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 26 Nov 2022 05:30:09 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B162A286E0;
        Sat, 26 Nov 2022 02:30:07 -0800 (PST)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NK7Db3pjfzpW8l;
        Sat, 26 Nov 2022 18:26:07 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 26 Nov 2022 18:30:05 +0800
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 26 Nov 2022 18:30:05 +0800
From:   Haoyue Xu <xuhaoyue1@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <xuhaoyue1@hisilicon.com>
Subject: [PATCH for-next 0/6] Bugfix for GID and PBL page
Date:   Sat, 26 Nov 2022 18:29:05 +0800
Message-ID: <20221126102911.2921820-1-xuhaoyue1@hisilicon.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

This patch set mainly fixes the GID problem caused by free mr.
The second and third patches fix the error on the PBL.
The last three patches fix minor errors found while running
the rdma-core tests.

1.#1: The GID problem caused by free mr
2.#2-#3: Fix the error on the PBL
3.#4-#5: Two minor return errors
4.#6: The default caps error

Chengchang Tang (5):
  RDMA/hns: Fix AH attr queried by query_qp
  RDMA/hns: Fix PBL page MTR find
  RDMA/hns: Fix page size cap from firmwall
  RDMA/hns: Fix error code of CMD
  RDMA/hns: Fix XRC caps on HIP08

Yixing Liu (1):
  RDMA/hns: Fix the gid problem caused by free mr

 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 214 ++++++++++++++++-----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  11 +-
 2 files changed, 179 insertions(+), 46 deletions(-)

-- 
2.30.0

