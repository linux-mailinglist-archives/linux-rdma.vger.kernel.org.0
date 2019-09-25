Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60BF4BDD41
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2019 13:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391030AbfIYLjY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Sep 2019 07:39:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59718 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389120AbfIYLjY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Sep 2019 07:39:24 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6BE6AEB49D500297DFB5;
        Wed, 25 Sep 2019 19:39:21 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Wed, 25 Sep 2019 19:39:12 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v3 rdma-core 0/4] Support UD on hip08
Date:   Wed, 25 Sep 2019 19:35:47 +0800
Message-ID: <1569411351-57148-1-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patchset enables hip08 to support Unreliable Datagram.

PR: https://github.com/linux-rdma/rdma-core/pull/575

Changelog:
v2->v3: Remove patch "libhns: Support configuring loopback mode by user"
	from this patchset, it needs to be further considered.
v1->v2: Fix comments from Leon Romanovsky and do some fixes in patch(3/4).

Lijun Ou (2):
  libhns: Add support of handling AH for hip08
  libhns: Add UD support for hip08 in user mode

Yixian Liu (2):
  libhns: Bugfix for wqe idx calc of post verbs
  libhns: Refactor for post send

 kernel-headers/rdma/hns-abi.h    |   7 +
 providers/hns/hns_roce_u.c       |   2 +
 providers/hns/hns_roce_u.h       |  40 +++
 providers/hns/hns_roce_u_abi.h   |   3 +-
 providers/hns/hns_roce_u_hw_v1.c |  27 +-
 providers/hns/hns_roce_u_hw_v2.c | 573 +++++++++++++++++++++------------------
 providers/hns/hns_roce_u_hw_v2.h |  91 +++++++
 providers/hns/hns_roce_u_verbs.c |  59 ++++
 8 files changed, 516 insertions(+), 286 deletions(-)

-- 
2.8.1

