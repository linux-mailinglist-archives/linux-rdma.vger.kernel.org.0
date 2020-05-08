Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDCE1CA776
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2020 11:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgEHJqV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 May 2020 05:46:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53596 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727051AbgEHJqV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 8 May 2020 05:46:21 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A3DE996FC4F5A58B34F5;
        Fri,  8 May 2020 17:46:16 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 17:46:09 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 0/9] RDMA/hns: Various fixes and cleanups
Date:   Fri, 8 May 2020 17:45:50 +0800
Message-ID: <1588931159-56875-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series contains the following:
- #1 ~ #2 are fixes to solve issues found from previous versions.
- #3 ~ #5 are fixes for recent refactoring codes to 5.8.
- #6 ~ #9 are various cleanups.

Lang Cheng (2):
  RDMA/hns: Fix cmdq parameter of querying pf timer resource
  RDMA/hns: Store mr len information into mr obj

Lijun Ou (2):
  RDMA/hns: Bugfix for querying qkey
  RDMA/hns: Reserve one sge in order to avoid local length error

Weihang Li (3):
  RDMA/hns: Fix wrong assignment of SRQ's max_wr
  RDMA/hns: Fix error with to_hr_hem_entries_count()
  RDMA/hns: Remove redundant memcpy()

Wenpeng Liang (1):
  RDMA/hns: Fix assignment to ba_pg_sz of eqe

Xi Wang (1):
  RDMA/hns: Rename macro for defining hns hardware page size

 drivers/infiniband/hw/hns/hns_roce_alloc.c  |  6 ++--
 drivers/infiniband/hw/hns/hns_roce_cq.c     |  4 +--
 drivers/infiniband/hw/hns/hns_roce_device.h | 15 +++++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 53 ++++++++++++-----------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  4 ++-
 drivers/infiniband/hw/hns/hns_roce_mr.c     |  8 +++--
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  9 ++---
 drivers/infiniband/hw/hns/hns_roce_srq.c    | 10 +++---
 8 files changed, 56 insertions(+), 53 deletions(-)

-- 
2.8.1

