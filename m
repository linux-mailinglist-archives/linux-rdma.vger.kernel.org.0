Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49E93F7235
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Aug 2021 11:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239525AbhHYJrx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Aug 2021 05:47:53 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:18039 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239403AbhHYJrx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Aug 2021 05:47:53 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GvgyY0gtfzbj5m;
        Wed, 25 Aug 2021 17:43:17 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 25 Aug 2021 17:47:03 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 25 Aug 2021 17:47:03 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 0/3] RDMA/hns: Fix some errors in the congestion control algorithm
Date:   Wed, 25 Aug 2021 17:43:09 +0800
Message-ID: <1629884592-23424-1-git-send-email-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix three dip_idx related errors.

Junxian Huang (3):
  RDMA/hns: Bugfix for data type of dip_idx
  RDMA/hns: Bugfix for the missing assignment for dip_idx
  RDMA/hns: Bugfix for incorrect association between dip_idx and dgid

 drivers/infiniband/hw/hns/hns_roce_device.h |  9 ++++++++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 13 +++++++++++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  2 +-
 drivers/infiniband/hw/hns/hns_roce_main.c   |  8 ++++++--
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 10 +++++++++-
 5 files changed, 35 insertions(+), 7 deletions(-)

--
2.8.1

