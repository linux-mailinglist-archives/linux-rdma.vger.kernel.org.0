Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FD52B433A
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 13:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgKPMAZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 07:00:25 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7917 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgKPMAZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Nov 2020 07:00:25 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CZSLc14r6z6xlb;
        Mon, 16 Nov 2020 20:00:08 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 16 Nov 2020 20:00:12 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 0/2] RDMA/hns: Add supports for stash
Date:   Mon, 16 Nov 2020 19:58:37 +0800
Message-ID: <1605527919-48769-1-git-send-email-liweihang@huawei.com>
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

Changes since v1:
- Fix comments from Jason about the unused macros.
- Rewrite hr_reg_set() to make it easier for driver to define and set a
  field.
link: https://patchwork.kernel.org/project/linux-rdma/cover/1601458452-55263-1-git-send-email-liweihang@huawei.com/

Lang Cheng (2):
  RDMA/hns: Add support for CQ stash
  RDMA/hns: Add support for QP stash

 drivers/infiniband/hw/hns/hns_roce_common.h | 12 +++++++++
 drivers/infiniband/hw/hns/hns_roce_device.h |  1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  9 +++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 41 ++++++++++++++++++-----------
 4 files changed, 47 insertions(+), 16 deletions(-)

-- 
2.8.1

