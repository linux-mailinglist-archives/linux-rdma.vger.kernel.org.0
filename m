Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52ED91424F3
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jan 2020 09:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgATIXg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jan 2020 03:23:36 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9669 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726589AbgATIXg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Jan 2020 03:23:36 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DF4AB2C6DBE224906A78;
        Mon, 20 Jan 2020 16:23:31 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Mon, 20 Jan 2020 16:23:25 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 0/7] RDMA/hns: Refactor qp related code
Date:   Mon, 20 Jan 2020 16:19:30 +0800
Message-ID: <1579508377-55818-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series refactor qp related code, including creating, destroying qp and
so on to make the processs easier to understand and maintain.

Xi Wang (7):
  RDMA/hns: Optimize qp destroy flow
  RDMA/hns: Optimize qp context create and destroy flow
  RDMA/hns: Optimize qp number assign flow
  RDMA/hns: Optimize qp buffer allocation flow
  RDMA/hns: Optimize qp param setup flow
  RDMA/hns: Optimize kernel qp wrid allocation flow
  RDMA/hns: Optimize qp doorbell allocation flow

 drivers/infiniband/hw/hns/hns_roce_device.h |   6 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  19 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  43 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 755 ++++++++++++++++------------
 4 files changed, 431 insertions(+), 392 deletions(-)

-- 
2.8.1

