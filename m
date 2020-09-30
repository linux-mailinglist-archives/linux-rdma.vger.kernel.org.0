Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3720A27E542
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Sep 2020 11:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgI3Jfl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Sep 2020 05:35:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38854 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728599AbgI3Jfk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Sep 2020 05:35:40 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7E25B7DB5DF3E9F105C1;
        Wed, 30 Sep 2020 17:35:38 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Wed, 30 Sep 2020 17:35:28 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 0/3] RDMA/hns: Add supports for stash
Date:   Wed, 30 Sep 2020 17:34:09 +0800
Message-ID: <1601458452-55263-1-git-send-email-liweihang@huawei.com>
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

Lang Cheng (3):
  RDMA/hns: Add support for CQ stash
  RDMA/hns: Add new interfaces to set/clear/read fields in QPC
  RDMA/hns: Add support for QP stash

 drivers/infiniband/hw/hns/hns_roce_common.h | 26 ++++++++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_device.h |  1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  9 +++++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  5 +++++
 4 files changed, 41 insertions(+)

-- 
2.8.1

