Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5186D2307DB
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jul 2020 12:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgG1KnU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jul 2020 06:43:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8290 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728655AbgG1KnT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Jul 2020 06:43:19 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F3DDEC02ED9ED256DC1C;
        Tue, 28 Jul 2020 18:43:16 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 28 Jul 2020 18:43:08 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 0/7] RDMA/hns: Updates for kernel v5.8
Date:   Tue, 28 Jul 2020 18:42:14 +0800
Message-ID: <1595932941-40613-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These are some miscellaneous changes of hns driver. #1 ~ #5 are cleanups
and #6 ~ #7 are small fixes.

Changes since v1:
- Fix comments from Leon about the judgment of return value in #2.
- Rewrite the commit message and remove the unused macro in #3.

Lang Cheng (4):
  RDMA/hns: Remove redundant hardware opcode definitions
  RDMA/hns: Remove support for HIP08_A
  RDMA/hns: Delete unnecessary memset when allocating VF resource
  RDMA/hns: Fix error during modify qp RTS2RTS

Weihang Li (2):
  RDMA/hns: Refactor hns_roce_v2_set_hem()
  RDMA/hns: Remove redundant parameters in set_rc_wqe()

Xi Wang (1):
  RDMA/hns: Fix the unneeded process when getting a general type of CQE
    error

 drivers/infiniband/hw/hns/hns_roce_device.h |   5 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 209 +++++++++++++++-------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  19 +--
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  10 --
 4 files changed, 115 insertions(+), 128 deletions(-)

-- 
2.8.1

