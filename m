Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1953C13F5
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Sep 2019 10:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfI2Icq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 29 Sep 2019 04:32:46 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49906 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725906AbfI2Icp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 29 Sep 2019 04:32:45 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 31BAEBFB80F0333CA10A;
        Sun, 29 Sep 2019 16:32:43 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Sun, 29 Sep 2019 16:32:37 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v4 rdma-core 0/4] Support UD on hip08
Date:   Sun, 29 Sep 2019 16:29:10 +0800
Message-ID: <1569745754-45346-1-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PR: https://github.com/linux-rdma/rdma-core/pull/587

Changelog:
v3->v4: Remove codes rely on kernel-headers changes, these codes are used
	to get vlan and mac information from kernel, which is still under
	consideration.
v2->v3: Remove patch "libhns: Support configuring loopback mode by user"
	from this patchset, it needs to be further considered.
v1->v2: Fix comments from Leon Romanovsky and do some fixes in patch(3/4).

Lijun Ou (2):
  libhns: Add support of handling AH for hip08
  libhns: Add UD support for hip08 in user mode

Yixian Liu (2):
  libhns: Bugfix for wqe idx calc of post verbs
  libhns: Refactor for post send

 providers/hns/hns_roce_u.c       |   2 +
 providers/hns/hns_roce_u.h       |  40 +++
 providers/hns/hns_roce_u_hw_v1.c |  27 +-
 providers/hns/hns_roce_u_hw_v2.c | 575 +++++++++++++++++++++------------------
 providers/hns/hns_roce_u_hw_v2.h |  91 +++++++
 providers/hns/hns_roce_u_verbs.c |  47 ++++
 6 files changed, 497 insertions(+), 285 deletions(-)

-- 
2.8.1

