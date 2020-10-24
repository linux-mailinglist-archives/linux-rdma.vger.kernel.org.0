Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E81297A75
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Oct 2020 05:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759257AbgJXDIv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Oct 2020 23:08:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2174 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1759253AbgJXDIu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 23 Oct 2020 23:08:50 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0409AE525F016034042B;
        Sat, 24 Oct 2020 11:08:48 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Sat, 24 Oct 2020 11:08:37 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 0/2] RDMA/hns: Support GMV table
Date:   Sat, 24 Oct 2020 11:07:14 +0800
Message-ID: <1603508836-33054-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

GMV(GID/MAC/VLAN) table is used for HIP09 to store above information
together instead of filling them in different table respectively, so that
the users can just provide the index to the hardware when post send.

Weihang Li (2):
  RDMA/hns: Add support for configuring GMV table
  RDMA/hns: Add support for filling GMV table

 drivers/infiniband/hw/hns/hns_roce_device.h |  10 ++
 drivers/infiniband/hw/hns/hns_roce_hem.c    |  15 ++
 drivers/infiniband/hw/hns/hns_roce_hem.h    |   1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 222 +++++++++++++++++++++-------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  60 +++++++-
 drivers/infiniband/hw/hns/hns_roce_main.c   |  26 +++-
 6 files changed, 275 insertions(+), 59 deletions(-)

-- 
2.8.1

