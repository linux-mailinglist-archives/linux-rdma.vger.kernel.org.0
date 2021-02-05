Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB7A31081E
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 10:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhBEJo1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 04:44:27 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12840 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhBEJmb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 04:42:31 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DX9Q45ynzz7hVY;
        Fri,  5 Feb 2021 17:40:28 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Feb 2021 17:41:47 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next 00/12] RDMA/hns: Updates for 5.12
Date:   Fri, 5 Feb 2021 17:39:22 +0800
Message-ID: <1612517974-31867-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

As usual, this series collects some miscellaneous fixes and cleanups at the
end of 5.12 for the hns driver:
* #1 ~ #3 fix some non-urgent issues.
* #4 ~ #6 make some changes on existing features.
* #7 ~ #12 are cleanups, just do some refactor and delete dead code.

This series is made based on the series named  "RDMA/hns: Several fixes and
cleanups of RQ/SRQ" which is still being reviewed: 
https://patchwork.kernel.org/project/linux-rdma/cover/1611997090-48820-1-git-send-email-liweihang@huawei.com/

I'm worried that it will be too late for 5.12 if any patch of this series
needs changes, so I send it before the previous one is merged. If there is
any comment or merge conflict on it, I will fix them as soon as possible,
thanks.

Lang Cheng (3):
  RDMA/hns: Replace wmb&__raw_writeq with writeq
  RDMA/hns: Move HIP06 related definitions into hns_roce_hw_v1.h
  RDMA/hns: Avoid unnecessary memset on WQEs in post_send

Lijun Ou (1):
  RDMA/hns: Disable RQ inline by default

Weihang Li (2):
  RDMA/hns: Avoid filling sgid index when modifying QP to RTR
  RDMA/hns: Fix type of sq_signal_bits

Xi Wang (1):
  RDMA/hns: Add mapped page count checking for MTR

Xinhao Liu (2):
  RDMA/hns: Remove some magic numbers
  RDMA/hns: Delete redundant judgment when preparing descriptors

Yixian Liu (1):
  RDMA/hns: Remove unnecessary wrap around for EQ's consumer index

Yixing Liu (2):
  RDMA/hns: Adjust definition of FRMR fields
  RDMA/hns: Skip qp_flow_control_init() for HIP09

 drivers/infiniband/hw/hns/hns_roce_device.h |  45 +---------
 drivers/infiniband/hw/hns/hns_roce_hem.c    |   9 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  31 +++----
 drivers/infiniband/hw/hns/hns_roce_hw_v1.h  |  43 ++++++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 125 +++++++++-------------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  12 +--
 drivers/infiniband/hw/hns/hns_roce_main.c   |  16 ----
 drivers/infiniband/hw/hns/hns_roce_mr.c     |  56 ++++++++-----
 8 files changed, 148 insertions(+), 189 deletions(-)

-- 
2.8.1

