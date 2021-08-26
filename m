Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D428F3F8937
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Aug 2021 15:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242709AbhHZNm3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Aug 2021 09:42:29 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:18976 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242716AbhHZNm2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Aug 2021 09:42:28 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GwP6h4Sq0zbhfN;
        Thu, 26 Aug 2021 21:37:48 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 26 Aug 2021 21:41:27 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 26 Aug 2021 21:41:27 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 0/7] RDMA/hns: Updates for 5.15
Date:   Thu, 26 Aug 2021 21:37:29 +0800
Message-ID: <1629985056-57004-1-git-send-email-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

As usual, this series collects some miscellaneous fixes and cleanups at the
end of 5.15 for the hns driver:

* #1 ~ #2 are fixes.
* #3 ~ #7 are some small cleanups.

Weihang Li (1):
  RDMA/hns: Remove RST2RST error prints for hw v1

Wenpeng Liang (4):
  RDMA/hns: Fix query destination qpn
  RDMA/hns: Fix QP's resp incomplete assignment
  RDMA/hns: Remove dqpn filling when modify qp from Init to Init
  RDMA/hns: Adjust the order in which irq are requested and enabled

Xinhao Liu (1):
  RDMA/hns: Delete unnecessary blank lines.

Yixing Liu (1):
  RDMA/hns: Encapsulate the qp db as a function

 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  40 +++-----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |   1 -
 drivers/infiniband/hw/hns/hns_roce_qp.c    | 150 ++++++++++++++++-------------
 3 files changed, 98 insertions(+), 93 deletions(-)

--
2.8.1

