Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4D62A0485
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Oct 2020 12:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgJ3LlQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Oct 2020 07:41:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7107 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgJ3LlQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Oct 2020 07:41:16 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CN0kZ4rq5zLrSy;
        Fri, 30 Oct 2020 19:41:10 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Fri, 30 Oct 2020 19:40:59 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 0/8] RDMA/hns: Support UD for HIP09
Date:   Fri, 30 Oct 2020 19:39:27 +0800
Message-ID: <1604057975-23388-1-git-send-email-liweihang@huawei.com>
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

Jiaran Zhang (1):
  RDMA/hns: Add check for the validity of sl configuration in UD SQ WQE

Weihang Li (7):
  RDMA/hns: Only record vlan info for HIP08
  RDMA/hns: Fix missing fields in address vector
  RDMA/hns: Avoid setting loopback indicator when smac is same as dmac
  RDMA/hns: Remove the portn field in UD SQ WQE
  RDMA/hns: Simplify process of filling UD SQ WQE
  RDMA/hns: Add UD support for HIP09
  RDMA/hns: Add support for UD inline

 drivers/infiniband/hw/hns/hns_roce_ah.c     |  61 ++++----
 drivers/infiniband/hw/hns/hns_roce_device.h |   5 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 206 ++++++++++++++++++++--------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  44 +++---
 drivers/infiniband/hw/hns/hns_roce_qp.c     |   9 +-
 5 files changed, 209 insertions(+), 116 deletions(-)

-- 
2.8.1

