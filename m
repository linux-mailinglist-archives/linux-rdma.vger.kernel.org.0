Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C98393FBC
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 11:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbhE1JUx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 05:20:53 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2077 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234926AbhE1JUx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 05:20:53 -0400
Received: from dggeml765-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FrzXd330gzWnmg;
        Fri, 28 May 2021 17:14:41 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggeml765-chm.china.huawei.com (10.1.199.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 17:19:17 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 17:19:17 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 0/2] RDMA/hns: Add support for userspace Direct WQE
Date:   Fri, 28 May 2021 17:19:03 +0800
Message-ID: <1622193545-3281-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Direct wqe is a mechanism to fill wqe directly into the hardware. In the
case of light load, the wqe will be filled into pcie bar space of the
hardware, this will reduce one memory access operation and therefore
reduce the latency. 

This series first refactor current uar mmap process to add branch for
direct wqe, then the feature is enabled.

The related userspace series is named "libhns: Add support for direct WQE".

Xi Wang (1):
  RDMA/hns: Refactor hns uar mmap flow

Yixing Liu (1):
  RDMA/hns: Support direct WQE of userspace

 drivers/infiniband/hw/hns/hns_roce_device.h |  7 ++-
 drivers/infiniband/hw/hns/hns_roce_main.c   | 72 +++++++++++++++++++++++++++--
 drivers/infiniband/hw/hns/hns_roce_pd.c     |  8 +++-
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  5 ++
 include/uapi/rdma/hns-abi.h                 |  6 +++
 5 files changed, 89 insertions(+), 9 deletions(-)

-- 
2.7.4

