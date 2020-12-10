Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F8D2D5C83
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Dec 2020 14:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389743AbgLJN5U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Dec 2020 08:57:20 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9500 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389755AbgLJN5Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Dec 2020 08:57:16 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CsFnD3TJzzhq7X;
        Thu, 10 Dec 2020 21:56:00 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 10 Dec 2020 21:56:24 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v4 for-next 00/11] RDMA/hns: Updates for 5.11
Date:   Thu, 10 Dec 2020 21:54:28 +0800
Message-ID: <1607608479-54518-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There are miscellaneous updates for hns driver:
* #1 fixes a potential length issue when copying udata.
* #2 fixes the unreasonable judgment when using HEM of SRQ and SCCC.
* #3 fixes wrong value of Traffic Class.
* #4 and #5 fix issues about Service Level.
* #6 ~ #11 are cleanups, including removing dead code, fixing coding style
  issues and so on.

Changes since v3:
- Avoid an unused variable warning in #10.

Changes since v2:
- Remove WARN_ON() in #5 when filling QPC.

Changes since v1:
- Only do shift on tclass when using RoCEv2 in #3.

Previous version:
v3: https://patchwork.kernel.org/project/linux-rdma/cover/1607606572-11968-1-git-send-email-liweihang@huawei.com/
v2: https://patchwork.kernel.org/project/linux-rdma/cover/1607078436-26455-1-git-send-email-liweihang@huawei.com/
v1: https://patchwork.kernel.org/project/linux-rdma/cover/1606899553-54592-1-git-send-email-liweihang@huawei.com/

Lang Cheng (1):
  RDMA/hns: Fix coding style issues

Weihang Li (3):
  RDMA/hns: Do shift on traffic class when using RoCEv2
  RDMA/hns: Avoid filling sl in high 3 bits of vlan_id
  RDMA/hns: WARN_ON if get a reserved sl from users

Wenpeng Liang (3):
  RDMA/hns: Limit the length of data copied between kernel and userspace
  RDMA/hns: Normalization the judgment of some features
  RDMA/hns: Fix incorrect symbol types

Xinhao Liu (1):
  RDMA/hns: Clear redundant variable initialization

Yixian Liu (2):
  RDMA/hns: Remove unnecessary access right set during INIT2INIT
  RDMA/hns: Simplify AEQE process for different types of queue

Yixing Liu (1):
  RDMA/hns: Fix inaccurate prints

 drivers/infiniband/hw/hns/hns_roce_ah.c     |  13 +--
 drivers/infiniband/hw/hns/hns_roce_alloc.c  |   4 +-
 drivers/infiniband/hw/hns/hns_roce_cmd.c    |  37 +++---
 drivers/infiniband/hw/hns/hns_roce_cmd.h    |   6 +-
 drivers/infiniband/hw/hns/hns_roce_common.h |  14 +--
 drivers/infiniband/hw/hns/hns_roce_cq.c     |  42 +++----
 drivers/infiniband/hw/hns/hns_roce_db.c     |   8 +-
 drivers/infiniband/hw/hns/hns_roce_device.h |  87 ++++++--------
 drivers/infiniband/hw/hns/hns_roce_hem.c    |  44 +++----
 drivers/infiniband/hw/hns/hns_roce_hem.h    |   2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  41 +++----
 drivers/infiniband/hw/hns/hns_roce_hw_v1.h  |   2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 172 +++++++++-------------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   6 +-
 drivers/infiniband/hw/hns/hns_roce_main.c   |  19 +--
 drivers/infiniband/hw/hns/hns_roce_mr.c     |  25 ++--
 drivers/infiniband/hw/hns/hns_roce_pd.c     |  13 ++-
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  82 +++++++------
 drivers/infiniband/hw/hns/hns_roce_srq.c    |  48 ++++----
 19 files changed, 297 insertions(+), 368 deletions(-)

-- 
2.8.1

