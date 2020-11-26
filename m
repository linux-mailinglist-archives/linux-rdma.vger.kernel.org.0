Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9F62C4F1C
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Nov 2020 08:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388267AbgKZHGA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Nov 2020 02:06:00 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8405 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388093AbgKZHF7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Nov 2020 02:05:59 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ChTL82QgVz73vV;
        Thu, 26 Nov 2020 15:05:36 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Thu, 26 Nov 2020 15:05:49 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v4 for-next 0/2] RDMA/hns: Add supports for stash
Date:   Thu, 26 Nov 2020 15:04:09 +0800
Message-ID: <1606374251-21512-1-git-send-email-liweihang@huawei.com>
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

Changes since v3:
- Add strcuture name as a parameter when defining a field, the
  hr_reg_enable() will check the type and cast the array to __le32 *.
- Fix the alignment style of CQC and QPC structure.

Changes since v2:
- Replace hr_reg_set() with hr_reg_enable(), which supports to set a single
  bit.

Changes since v1:
- Fix comments from Jason about the unused macros.
- Rewrite hr_reg_set() to make it easier for driver to define and set a
  field.

Previous versions:
v3: https://patchwork.kernel.org/project/linux-rdma/cover/1605867440-2413-1-git-send-email-liweihang@huawei.com/
v2: https://patchwork.kernel.org/project/linux-rdma/cover/1605527919-48769-1-git-send-email-liweihang@huawei.com/
v1: https://patchwork.kernel.org/project/linux-rdma/cover/1601458452-55263-1-git-send-email-liweihang@huawei.com/

Lang Cheng (2):
  RDMA/hns: Add support for CQ stash
  RDMA/hns: Add support for QP stash

 drivers/infiniband/hw/hns/hns_roce_common.h |  12 ++
 drivers/infiniband/hw/hns/hns_roce_device.h |   1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |   9 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 167 +++++++++++++++-------------
 4 files changed, 112 insertions(+), 77 deletions(-)

-- 
2.8.1

