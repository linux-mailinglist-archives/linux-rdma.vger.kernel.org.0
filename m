Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6AC497FC4
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jan 2022 13:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241881AbiAXMqK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jan 2022 07:46:10 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:16734 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239685AbiAXMqK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jan 2022 07:46:10 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jj8kw1XGHzZfLp;
        Mon, 24 Jan 2022 20:42:16 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 20:46:08 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 20:46:08 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 0/4] RDMA/hns: Add more restrack attributes to hns driver
Date:   Mon, 24 Jan 2022 20:46:20 +0800
Message-ID: <20220124124624.55352-1-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

First refactored the restrack code of the driver, and then added more
restrack attributes.

Wenpeng Liang (4):
  RDMA/hns: Refactor the restrack code of CQ
  RDMA/hns: Add more restrack attributes to CQ
  RDMA/hns: Add support for QP's restrack attributes
  RDMA/hns: Add support for MR's restrack attributes

 drivers/infiniband/hw/hns/Makefile            |   2 +-
 drivers/infiniband/hw/hns/hns_roce_device.h   |  13 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    |  79 ++++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h    |  30 --
 .../infiniband/hw/hns/hns_roce_hw_v2_dfx.c    |  35 ---
 drivers/infiniband/hw/hns/hns_roce_main.c     |   2 +
 drivers/infiniband/hw/hns/hns_roce_restrack.c | 272 ++++++++++++++----
 7 files changed, 288 insertions(+), 145 deletions(-)
 delete mode 100644 drivers/infiniband/hw/hns/hns_roce_hw_v2_dfx.c

--
2.33.0

