Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15DA097AF1
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 15:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbfHUNdv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 09:33:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52002 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728492AbfHUNdv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 09:33:51 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 05809A0855F60CFA39AD;
        Wed, 21 Aug 2019 21:17:54 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Wed, 21 Aug 2019 21:17:45 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next 0/9] Fixes for hip08 driver
Date:   Wed, 21 Aug 2019 21:14:27 +0800
Message-ID: <1566393276-42555-1-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here optimizes some codes and removes some warnings
by sparse tool checking as well as fixes some defects.

Lang Cheng (3):
  RDMA/hns: Modify the data structure of hns_roce_av
  RDMA/hns: Fix cast from or to restricted __le32 for driver
  RDMA/hns: Add reset process for function-clear

Lijun Ou (3):
  RDMA/hns: Refactor the codes of creating qp
  RDMA/hns: Remove the some magic number
  RDMA/hns: Fix wrong assignment of qp_access_flags

Wenpeng Liang (2):
  RDMA/hns: Remove if-else judgment statements for creating srq
  RDMA/hns: Delete the not-used lines

Yixian Liu (1):
  RDMA/hns: Refactor cmd init and mode selection for hip08

 drivers/infiniband/hw/hns/hns_roce_ah.c     |  23 +--
 drivers/infiniband/hw/hns/hns_roce_cmd.c    |  14 +-
 drivers/infiniband/hw/hns/hns_roce_device.h |  17 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c    |  34 ++--
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  49 +++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 256 +++++++++++++++++++---------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   5 +-
 drivers/infiniband/hw/hns/hns_roce_main.c   |  18 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c     |   7 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 108 +++++++-----
 drivers/infiniband/hw/hns/hns_roce_srq.c    |  30 +---
 11 files changed, 314 insertions(+), 247 deletions(-)

-- 
2.8.1

