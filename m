Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C0630145C
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Jan 2021 10:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbhAWJvA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 23 Jan 2021 04:51:00 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11185 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbhAWJu7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 23 Jan 2021 04:50:59 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DNBCg5DF7zl7Vt;
        Sat, 23 Jan 2021 17:48:47 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Sat, 23 Jan 2021 17:50:09 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH v2 for-next 0/3] RDMA/hns: Refactor codes about memory
Date:   Sat, 23 Jan 2021 17:47:59 +0800
Message-ID: <1611395282-991-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series refactors memory related codes, including MR, MTR(Memory
Translate Region) and MPT(Memory Protection Table).

Changes since v1:
* Add static keyword for hns_roce_mr_free().
* Link: https://patchwork.kernel.org/project/linux-rdma/cover/1611236882-41498-1-git-send-email-liweihang@huawei.com/

Lang Cheng (2):
  RDMA/hns: Optimize the MR registration process
  RDMA/hns: Use new interface to set MPT related fields

Xi Wang (1):
  RDMA/hns: Refactor the MTR creation flow

 drivers/infiniband/hw/hns/hns_roce_common.h |  22 ++
 drivers/infiniband/hw/hns/hns_roce_cq.c     |   1 -
 drivers/infiniband/hw/hns/hns_roce_device.h |   5 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  77 +++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  39 +++
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 401 +++++++++++-----------------
 drivers/infiniband/hw/hns/hns_roce_qp.c     |   1 -
 drivers/infiniband/hw/hns/hns_roce_srq.c    |   2 -
 8 files changed, 257 insertions(+), 291 deletions(-)

-- 
2.8.1

