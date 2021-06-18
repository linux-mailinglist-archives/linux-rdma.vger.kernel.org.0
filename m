Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24BB83AC874
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 12:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhFRKM6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 06:12:58 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5040 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbhFRKM6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Jun 2021 06:12:58 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G5vgr2qQ4zXgLw;
        Fri, 18 Jun 2021 18:05:44 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 18:10:48 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 18 Jun 2021 18:10:47 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 00/10] RDMA/hns: Updates for 5.14
Date:   Fri, 18 Jun 2021 18:10:10 +0800
Message-ID: <1624011020-16992-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

As usual, this series collects some miscellaneous fixes and cleanups at the
end of 5.14 for the hns driver:
* #1 ~ #5 are fixes.
* #6 ~ #10 are some small cleanups.

Lang Cheng (2):
  RDMA/hns: Force rewrite inline flag of WQE
  RDMA/hns: Fix spelling mistakes of original

Wenpeng Liang (1):
  RDMA/hns: Encapsulate flushing CQE as a function

Xi Wang (1):
  RDMA/hns: Clean definitions of EQC structure

Yangyang Li (3):
  RDMA/hns: Add member assignments for qp_init_attr
  RDMA/hns: Delete unnecessary branch of hns_roce_v2_query_qp
  RDMA/hns: Modify function return value type

Yixing Liu (3):
  RDMA/hns: Fix uninitialized variable
  RDMA/hns: Fix some print issues
  RDMA/hns: Simplify the judgment in hns_roce_v2_post_send()

 drivers/infiniband/hw/hns/hns_roce_device.h |  5 ++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 60 ++++++++---------------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 19 ++-------
 drivers/infiniband/hw/hns/hns_roce_main.c   |  8 +---
 drivers/infiniband/hw/hns/hns_roce_mr.c     |  4 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 27 +++++++++----
 6 files changed, 44 insertions(+), 79 deletions(-)

-- 
2.7.4

