Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A923F1005
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Aug 2021 03:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbhHSBkp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Aug 2021 21:40:45 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:14228 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235348AbhHSBko (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Aug 2021 21:40:44 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GqnWL4xy4z1CYMW;
        Thu, 19 Aug 2021 09:39:42 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 19 Aug 2021 09:40:07 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 19 Aug 2021 09:40:07 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 0/3] RDMA/hns: Use ida to manage some index of resources and remove unused bitmap
Date:   Thu, 19 Aug 2021 09:36:17 +0800
Message-ID: <1629336980-17499-1-git-send-email-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use the ida interface to replace hns' own bitmap interface. The previous
ida patchset has replaced qp, cq, mr, pd, and xrcd. This ida patchset
will replace the remaining uar and srq. Since then, all replacements
have been completed.

Link to the previous ida patchset:
https://patchwork.kernel.org/project/linux-rdma/cover/1623325814-55737-1-git-send-email-liweihang@huawei.com/

Yangyang Li (3):
  RDMA/hns: Use IDA interface to manage uar index
  RDMA/hns: Use IDA interface to manage srq index
  RDMA/hns: Delete unused hns bitmap interface

 drivers/infiniband/hw/hns/hns_roce_alloc.c  | 74 +----------------------------
 drivers/infiniband/hw/hns/hns_roce_device.h | 16 ++-----
 drivers/infiniband/hw/hns/hns_roce_main.c   | 31 +++---------
 drivers/infiniband/hw/hns/hns_roce_pd.c     | 31 ++++++------
 drivers/infiniband/hw/hns/hns_roce_srq.c    | 28 +++++------
 5 files changed, 40 insertions(+), 140 deletions(-)

--
2.8.1

