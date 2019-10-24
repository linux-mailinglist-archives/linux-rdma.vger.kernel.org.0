Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E49C0E2D31
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 11:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391314AbfJXJZh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 05:25:37 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5150 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389413AbfJXJZh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Oct 2019 05:25:37 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 40327DF5030E5258B795;
        Thu, 24 Oct 2019 17:25:36 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Thu, 24 Oct 2019 17:25:25 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-rc 0/2] RDMA/hns: Fixes related to 64K page
Date:   Thu, 24 Oct 2019 17:21:55 +0800
Message-ID: <1571908917-16220-1-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently, some configurations can only support 4K page in hip08, this
series fixes them.

Lijun Ou (1):
  RDMA/hns: Fix to support 64K page for srq

Yangyang Li (1):
  RDMA/hns: Bugfix for qpc/cqc timer configuration

 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 ++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.8.1

