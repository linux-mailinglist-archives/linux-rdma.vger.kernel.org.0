Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3B2A168E3D
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2020 11:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgBVK0b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 22 Feb 2020 05:26:31 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43678 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727461AbgBVK0b (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 22 Feb 2020 05:26:31 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 57AD17A3A3995F59CDAC;
        Sat, 22 Feb 2020 18:26:26 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Sat, 22 Feb 2020 18:26:18 +0800
From:   Yixian Liu <liuyixian@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next 0/2] Fix and optimize for flush cqe process
Date:   Sat, 22 Feb 2020 18:25:56 +0800
Message-ID: <1582367158-27030-1-git-send-email-liuyixian@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Patch 1 adjust current flush framework to optimize the flush process
in aeq case. Patch 2 fixes the bug that currently there are two paths
to update producer index of qp by stopping doorbell update.

Yixian Liu (2):
  RDMA/hns: Use flush framework for the case in aeq
  RDMA/hns: Stop doorbell update while qp state error

 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 112 +++++++++++------------------
 drivers/infiniband/hw/hns/hns_roce_qp.c    |   9 +++
 2 files changed, 50 insertions(+), 71 deletions(-)

-- 
2.7.4

