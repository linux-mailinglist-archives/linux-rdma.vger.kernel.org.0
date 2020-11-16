Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CC02B42EC
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 12:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbgKPLfP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 06:35:15 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7914 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729455AbgKPLfP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Nov 2020 06:35:15 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CZRnY1RHPz6xJK;
        Mon, 16 Nov 2020 19:34:57 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 16 Nov 2020 19:35:01 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 0/7] RDMA/hns: Support UD for HIP09
Date:   Mon, 16 Nov 2020 19:33:21 +0800
Message-ID: <1605526408-6936-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series does cleanups on UD related code at first, including removing
dead code, adding necessary check and some refactors. Then the UD feature
is enabled on HIP09.

Changes since v1:
- Don't allow HIP08's user to create AH and UD QP from userspace and add
  .create_user_ah in #6.
- Drop #4 from the v1 series which needs more discussion about the reserved
  sl.
link: https://patchwork.kernel.org/project/linux-rdma/cover/1604057975-23388-1-git-send-email-liweihang@huawei.com/

Weihang Li (7):
  RDMA/hns: Only record vlan info for HIP08
  RDMA/hns: Fix missing fields in address vector
  RDMA/hns: Avoid setting loopback indicator when smac is same as dmac
  RDMA/hns: Remove the portn field in UD SQ WQE
  RDMA/hns: Simplify process of filling UD SQ WQE
  RDMA/hns: Add UD support for HIP09
  RDMA/hns: Add support for UD inline

 drivers/infiniband/hw/hns/hns_roce_ah.c     |  62 ++++-----
 drivers/infiniband/hw/hns/hns_roce_device.h |   4 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 196 ++++++++++++++++++++--------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  44 +++----
 drivers/infiniband/hw/hns/hns_roce_main.c   |   1 +
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  45 +++++--
 6 files changed, 229 insertions(+), 123 deletions(-)

-- 
2.8.1

