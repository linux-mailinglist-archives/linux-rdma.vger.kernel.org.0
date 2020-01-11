Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D66A1380DF
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jan 2020 11:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgAKKgf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 11 Jan 2020 05:36:35 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9156 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729408AbgAKKgf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 11 Jan 2020 05:36:35 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 45C9FDC514740EBB6DA4;
        Sat, 11 Jan 2020 18:36:33 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Sat, 11 Jan 2020 18:36:25 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 0/3] RDMA/hns: Get pf capabilities from firmware
Date:   Sat, 11 Jan 2020 18:32:38 +0800
Message-ID: <1578738761-3176-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series add new interfaces to get capablities from firmware of
different types of hardware. If it fails, all capabilities will be set
with a default value. In addition, we remove some redundant fields in
struct hns_roce_caps.

Lijun Ou (2):
  RDMA/hns: Add interfaces to get pf capabilities from firmware
  RDMA/hns: Get pf capabilities from firmware

Weihang Li (1):
  RDMA/hns: Remove some redundant variables related to capbilities

 drivers/infiniband/hw/hns/hns_roce_device.h |   9 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 437 ++++++++++++++++++++++------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 156 ++++++++++
 drivers/infiniband/hw/hns/hns_roce_main.c   |   2 +-
 4 files changed, 511 insertions(+), 93 deletions(-)

-- 
2.8.1

