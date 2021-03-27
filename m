Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB8734B403
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Mar 2021 04:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhC0DYY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Mar 2021 23:24:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15325 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhC0DYN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Mar 2021 23:24:13 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F6kfQ1KWpz9yfY;
        Sat, 27 Mar 2021 11:22:06 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 11:24:01 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 0/5] RDMA/hns: Refactor and reorganization
Date:   Sat, 27 Mar 2021 11:21:29 +0800
Message-ID: <1616815294-13434-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Refactor the process of polling CQ and several control paths in the hns
driver.

Changes since v1:
- Avoid wrapping a function in another one.
- Make a rebase.
- Link: https://patchwork.kernel.org/project/linux-rdma/cover/1615972183-42510-1-git-send-email-liweihang@huawei.com/

P.S. This version is made based on "RDMA/hns: Support to select congestion
control algorithm" at https://patchwork.kernel.org/project/linux-rdma/cover/1616679236-7795-1-git-send-email-liweihang@huawei.com/
Sorry for just finding out there's merge conflict between these two series,
I will send a new version ASAP if something needs to be updated.

Weihang Li (1):
  RDMA/hns: Refactor hns_roce_v2_poll_one()

Xi Wang (3):
  RDMA/hns: Refactor reset state checking flow
  RDMA/hns: Reorganize process of setting HEM
  RDMA/hns: Simplify command fields for HEM base address configuration

Yixing Liu (1):
  RDMA/hns: Reorganize hns_roce_create_cq()

 drivers/infiniband/hw/hns/hns_roce_cmd.c    |  35 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c     |  86 ++-
 drivers/infiniband/hw/hns/hns_roce_device.h |  11 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |   2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 971 +++++++++++++++-------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 116 ++--
 6 files changed, 625 insertions(+), 596 deletions(-)

-- 
2.8.1

