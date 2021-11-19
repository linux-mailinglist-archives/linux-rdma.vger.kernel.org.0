Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A15C45703C
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Nov 2021 15:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbhKSOJn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Nov 2021 09:09:43 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:26334 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbhKSOJn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Nov 2021 09:09:43 -0500
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Hwdd26x3Pzbhw5;
        Fri, 19 Nov 2021 22:01:42 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 19 Nov 2021 22:06:39 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 19 Nov 2021 22:06:39 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 0/9] RDMA/hns: Cleanup for clearing static warnings
Date:   Fri, 19 Nov 2021 22:01:59 +0800
Message-ID: <20211119140208.40416-1-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Most static warnings are detected by tools, mainly about:

(1) #1~2: About printing format.
(2) #3  : About code comments.
(3) #4~6: About variable definition and initialization.
(4) #7~9: Other miscellaneous.

Haoyue Xu (1):
  RDMA/hns: Initialize variable in the right place

Xinhao Liu (7):
  RDMA/hns: Correct the hex print format
  RDMA/hns: Correct the print format to be consistent with the variable
    type
  RDMA/hns: Replace tab with space in the right-side comments
  RDMA/hns: Correct the type of variables participating in the shift
    operation
  RDMA/hns: Correctly initialize the members of Array[][]
  RDMA/hns: Add void conversion for function whose return value is not
    used
  RDMA/hns: Remove magic number

Yixing Liu (1):
  RDMA/hns: Remove macros that are no longer used

 drivers/infiniband/hw/hns/hns_roce_cmd.c    | 10 +++---
 drivers/infiniband/hw/hns/hns_roce_device.h | 40 ++++++++++-----------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 23 ++++++------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 18 +---------
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 10 +++---
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  2 +-
 6 files changed, 45 insertions(+), 58 deletions(-)

--
2.33.0

