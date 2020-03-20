Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C40C18C5BA
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 04:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgCTD1h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 23:27:37 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33378 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726738AbgCTD1h (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Mar 2020 23:27:37 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4B902A4F39B90F6B7971;
        Fri, 20 Mar 2020 11:27:32 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Fri, 20 Mar 2020 11:27:24 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 00/10] RDMA/hns: Various cleanups
Date:   Fri, 20 Mar 2020 11:23:32 +0800
Message-ID: <1584674622-52773-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series contains some cleanups for the hns driver:
- patch 1 unifies format of prints in hns_roce_hw_v2.c and hns_roce_pd.c.
- patch 2 ~ 5 are some simple modifications.
- patch 6 ~ 10 remove some dead codes.

Previous discussions can be found at:
https://patchwork.kernel.org/cover/11447213/

Changes since v1:
- Drop patch 3/11 from series v1 because it's wrong to use IS_ERR_OR_NULL
  on a pointer returned by kmalloc().

Lang Cheng (4):
  RDMA/hns: Simplify attribute judgment code
  RDMA/hns: Adjust the qp status value sequence of the hardware
  RDMA/hns: Remove definition of cq doorbell structure
  RDMA/hns: Remove redundant qpc setup operations

Lijun Ou (2):
  RDMA/hns: Unify format of prints
  RDMA/hns: Optimize hns_roce_alloc_vf_resource()

Weihang Li (3):
  RDMA/hns: Fix a wrong judgment of return value
  RDMA/hns: Remove redundant assignment of wc->smac when polling cq
  RDMA/hns: Remove redundant judgment of qp_type

Wenpeng Liang (1):
  RDMA/hns: Remove meaningless prints

 drivers/infiniband/hw/hns/hns_roce_hw_v1.c |   9 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 560 ++++++++---------------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |   7 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c    |   2 +-
 drivers/infiniband/hw/hns/hns_roce_pd.c    |   6 +-
 5 files changed, 159 insertions(+), 425 deletions(-)

-- 
2.8.1

