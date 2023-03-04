Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4874A6AA8DE
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Mar 2023 10:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjCDJR3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 4 Mar 2023 04:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCDJR3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 4 Mar 2023 04:17:29 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D4E1423F
        for <linux-rdma@vger.kernel.org>; Sat,  4 Mar 2023 01:17:27 -0800 (PST)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PTK3G5LKTzrSNc;
        Sat,  4 Mar 2023 17:16:42 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 4 Mar 2023 17:17:24 +0800
From:   Haoyue Xu <xuhaoyue1@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <xuhaoyue1@hisilicon.com>
Subject: [PATCH for-next 0/2] Support query vf caps
Date:   Sat, 4 Mar 2023 17:15:53 +0800
Message-ID: <20230304091555.2241298-1-xuhaoyue1@hisilicon.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

VF originally used default caps in the driver.
The patchset add a command to query the VF's caps,
which makes it more extensible.

Yixing Liu (2):
  RDMA/hns: Add new cmq command to support query vf caps
  RDMA/hns: remove set_default function

 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 191 ++++++---------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  37 +---
 2 files changed, 61 insertions(+), 167 deletions(-)

-- 
2.30.0

