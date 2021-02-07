Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC14031211C
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Feb 2021 04:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhBGDQH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 6 Feb 2021 22:16:07 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12860 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhBGDP5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 6 Feb 2021 22:15:57 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DYDl44Svbz7hKs;
        Sun,  7 Feb 2021 11:13:52 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Sun, 7 Feb 2021 11:15:08 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH RFC rdma-core 0/5] libhns: Add support for Dynamic Context Attachment
Date:   Sun, 7 Feb 2021 11:12:49 +0800
Message-ID: <1612667574-56673-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The HIP09 introduces the DCA(Dynamic Context Attachment) feature which
supports many RC QPs to share the WQE buffer in a memory pool. If a QP
enables DCA feature, the WQE's buffer will not be allocated when creating
but when the users start to post WRs. This will reduce the memory
consumption when there are too many QPs are inactive.

Please note that we didn't find the right way to get user's configuration,
so in #4 we still use environment variable to achieve this. We will be
appreciated if anyone can provide some sugggestions.

This series is associated with the kernel series "RDMA/hns: Add support for
Dynamic Context Attachment", you can review it at:
https://patchwork.kernel.org/project/linux-rdma/cover/1611394994-50363-1-git-send-email-liweihang@huawei.com/

Weihang Li (1):
  Update kernel headers

Xi Wang (4):
  libhns: Introduce DCA for RC QP
  libhns: Add support for shrinking DCA memory pool
  libhns: Add support for attaching QP's WQE buffer
  libhns: Add support for configuring DCA

 kernel-headers/rdma/hns-abi.h    |  64 +++++++
 libibverbs/cmd_qp.c              |   3 +-
 libibverbs/verbs.h               |   1 +
 providers/hns/hns_roce_u.c       |  89 +++++++++
 providers/hns/hns_roce_u.h       |  42 +++++
 providers/hns/hns_roce_u_buf.c   | 384 +++++++++++++++++++++++++++++++++++++++
 providers/hns/hns_roce_u_hw_v2.c | 138 +++++++++++++-
 providers/hns/hns_roce_u_hw_v2.h |   7 +
 providers/hns/hns_roce_u_verbs.c |  44 ++++-
 9 files changed, 754 insertions(+), 18 deletions(-)

-- 
2.8.1

