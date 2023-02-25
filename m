Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D110F6A28B6
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Feb 2023 11:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjBYKEY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 Feb 2023 05:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBYKEX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 25 Feb 2023 05:04:23 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50B6109
        for <linux-rdma@vger.kernel.org>; Sat, 25 Feb 2023 02:04:21 -0800 (PST)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PP2PC2vMSzKpth;
        Sat, 25 Feb 2023 18:02:23 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Sat, 25 Feb 2023 18:04:18 +0800
From:   Haoyue Xu <xuhaoyue1@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <xuhaoyue1@hisilicon.com>
Subject: [RFC PATCH for-next 0/1] Add SVE ldr and str instruction
Date:   Sat, 25 Feb 2023 18:02:50 +0800
Message-ID: <20230225100253.3993383-1-xuhaoyue1@hisilicon.com>
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

The first patch is for kernel space, and The last two patches are for
user space.
We want to use SVE instruction in our functions. Is this the right way to use it?
If anyone has ever used this before?
Please let me know your suggestions on this.

Yixing Liu (1):
  RDMA/hns: Add SVE DIRECT WQE flag to support libhns

 drivers/infiniband/hw/hns/hns_roce_device.h | 1 +
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 3 +++
 include/uapi/rdma/hns-abi.h                 | 1 +
 3 files changed, 5 insertions(+)

-- 
2.30.0

