Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCBF2BA73A
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Nov 2020 11:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgKTKTL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Nov 2020 05:19:11 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7661 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgKTKTL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Nov 2020 05:19:11 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Ccsvq3zGwz15N9C;
        Fri, 20 Nov 2020 18:18:47 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Fri, 20 Nov 2020 18:18:56 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v3 for-next 0/2] RDMA/hns: Add supports for stash
Date:   Fri, 20 Nov 2020 18:17:18 +0800
Message-ID: <1605867440-2413-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Stash is a mechanism that uses the core information carried by the ARM AXI
bus to access the L3 cache. The CPU and I/O subsystems can access the L3
cache consistently by enabling stash, so the performance can be improved.

Changes since v2:
- Replace hr_reg_set() with hr_reg_enable(), which supports to set a single
  bit.
link: https://patchwork.kernel.org/project/linux-rdma/cover/1605527919-48769-1-git-send-email-liweihang@huawei.com/

Changes since v1:
- Fix comments from Jason about the unused macros.
- Rewrite hr_reg_set() to make it easier for driver to define and set a
  field.
link: https://patchwork.kernel.org/project/linux-rdma/cover/1601458452-55263-1-git-send-email-liweihang@huawei.com/

Lang Cheng (2):
  RDMA/hns: Add support for CQ stash
  RDMA/hns: Add support for QP stash

 drivers/infiniband/hw/hns/hns_roce_common.h | 10 +++++++
 drivers/infiniband/hw/hns/hns_roce_device.h |  1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  9 +++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 41 ++++++++++++++++++-----------
 4 files changed, 45 insertions(+), 16 deletions(-)

-- 
2.8.1

