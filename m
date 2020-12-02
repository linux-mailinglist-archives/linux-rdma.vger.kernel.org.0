Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF212CB7FE
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Dec 2020 10:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388043AbgLBJBp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Dec 2020 04:01:45 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8906 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388028AbgLBJBo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Dec 2020 04:01:44 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CmCc34ztWz77Bh;
        Wed,  2 Dec 2020 17:00:35 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Wed, 2 Dec 2020 17:00:54 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 00/11] RDMA/hns: Updates for 5.11
Date:   Wed, 2 Dec 2020 16:59:02 +0800
Message-ID: <1606899553-54592-1-git-send-email-liweihang@huawei.com>
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

Lang Cheng (1):
  RDMA/hns: Fix coding style issues

Weihang Li (3):
  RDMA/hns: Do shift on traffic class of UD SQ WQE
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

 drivers/infiniband/hw/hns/hns_roce_ah.c     |  11 +-
 drivers/infiniband/hw/hns/hns_roce_alloc.c  |   4 +-
 drivers/infiniband/hw/hns/hns_roce_cmd.c    |  37 +++---
 drivers/infiniband/hw/hns/hns_roce_cmd.h    |   6 +-
 drivers/infiniband/hw/hns/hns_roce_common.h |  14 +--
 drivers/infiniband/hw/hns/hns_roce_cq.c     |  42 +++----
 drivers/infiniband/hw/hns/hns_roce_db.c     |   8 +-
 drivers/infiniband/hw/hns/hns_roce_device.h |  81 +++++--------
 drivers/infiniband/hw/hns/hns_roce_hem.c    |  42 +++----
 drivers/infiniband/hw/hns/hns_roce_hem.h    |   2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  37 +++---
 drivers/infiniband/hw/hns/hns_roce_hw_v1.h  |   2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 177 +++++++++-------------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   6 +-
 drivers/infiniband/hw/hns/hns_roce_main.c   |  19 +--
 drivers/infiniband/hw/hns/hns_roce_mr.c     |  25 ++--
 drivers/infiniband/hw/hns/hns_roce_pd.c     |  13 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  82 +++++++------
 drivers/infiniband/hw/hns/hns_roce_srq.c    |  48 ++++----
 19 files changed, 288 insertions(+), 368 deletions(-)

-- 
2.8.1

