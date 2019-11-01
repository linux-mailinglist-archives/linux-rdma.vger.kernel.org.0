Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 888D0EBBFF
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2019 03:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfKAChM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Oct 2019 22:37:12 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5244 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727419AbfKAChM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 31 Oct 2019 22:37:12 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 628865E24FB6613E6C25;
        Fri,  1 Nov 2019 10:37:10 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Fri, 1 Nov 2019 10:37:02 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-rc 0/2] RDMA/hns: Fix incorrect assignments
Date:   Fri, 1 Nov 2019 10:33:28 +0800
Message-ID: <1572575610-52530-1-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

1. HNS_ROCE_HEM_CHUNK_LEN in patch 1/2 is used to initialize sg table, its
current value is larger than needed.
2. srq_desc_size in patch 2/2 is used to allocate srq buffer, buffer size
may be less than expected.

Sirong Wang (1):
  RDMA/hns: Correct the value of HNS_ROCE_HEM_CHUNK_LEN

Wenpeng Liang (1):
  RDMA/hns: Correct the value of srq_desc_size

 drivers/infiniband/hw/hns/hns_roce_hem.h | 2 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.8.1

