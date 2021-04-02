Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AD73527B5
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Apr 2021 11:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbhDBJA6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Apr 2021 05:00:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16325 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhDBJA6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Apr 2021 05:00:58 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FBYr84lHKz9vsM;
        Fri,  2 Apr 2021 16:58:48 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Fri, 2 Apr 2021 17:00:46 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 0/6] RDMA/hns: Support RoCE on virtual functions of HIP09
Date:   Fri, 2 Apr 2021 16:58:10 +0800
Message-ID: <1617353896-40727-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series first do necessary refactor on function's resource code to
reduce the complexity of subsequent patches. Then the RoCE support for VFs
is introduced.

Wei Xu (4):
  RDMA/hns: Query the number of functions supported by the PF
  RDMA/hns: Reserve the resource for the VFs
  RDMA/hns: Set parameters of all the functions belong to a PF
  RDMA/hns: Enable RoCE on virtual functions

Xi Wang (2):
  RDMA/hns: Simplify function's resource related command
  RDMA/hns: Remove duplicated hem page size config code

 drivers/infiniband/hw/hns/hns_roce_common.h |  11 +
 drivers/infiniband/hw/hns/hns_roce_device.h |   6 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 553 ++++++++++++++++------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 236 +++---------
 4 files changed, 386 insertions(+), 420 deletions(-)

-- 
2.8.1

