Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0B2D90EE
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2019 14:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733256AbfJPMbL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Oct 2019 08:31:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38972 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733261AbfJPMbK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Oct 2019 08:31:10 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6E0FE6CE9F79A0B34DFA;
        Wed, 16 Oct 2019 20:31:09 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Wed, 16 Oct 2019 20:31:00 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v5 rdma-core 0/4] Support UD on hip08
Date:   Wed, 16 Oct 2019 20:27:32 +0800
Message-ID: <1571228856-9573-1-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Enables hip08 to support Unreliable Datagram.

PR: https://github.com/linux-rdma/rdma-core/pull/587

Changelog:
v4->v5: Fix comments from Leon Romanovsky, including some code
	optimizations and remove printf in library.
v3->v4: Remove codes rely on kernel-headers changes about vlan and mac.
v2->v3: Remove patch "libhns: Support configuring loopback mode by user"
	from this patchset, it needs to be further considered.
v1->v2: Fix comments from Leon Romanovsky and do some fixes in patch(3/4).

Lijun Ou (2):
  libhns: Add support of handling AH for hip08
  libhns: Add UD support for hip08 in user mode

Yixian Liu (2):
  libhns: Simplify the calculation and usage of wqe idx for post verbs
  libhns: Refactor for post send

 providers/hns/hns_roce_u.c       |   2 +
 providers/hns/hns_roce_u.h       |  39 +++
 providers/hns/hns_roce_u_hw_v1.c |  27 +-
 providers/hns/hns_roce_u_hw_v2.c | 568 +++++++++++++++++++++------------------
 providers/hns/hns_roce_u_hw_v2.h |  91 +++++++
 providers/hns/hns_roce_u_verbs.c |  47 ++++
 6 files changed, 489 insertions(+), 285 deletions(-)

-- 
2.8.1

