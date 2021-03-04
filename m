Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01EF632CED4
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Mar 2021 09:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236856AbhCDIwp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Mar 2021 03:52:45 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13124 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236805AbhCDIwR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Mar 2021 03:52:17 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Drl1F0532z16F9X;
        Thu,  4 Mar 2021 16:49:53 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Mar 2021 16:51:34 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: [PATCH RFC v2 rdma-core 0/6] libhns: Add support for Dynamic Context Attachment
Date:   Thu, 4 Mar 2021 16:49:13 +0800
Message-ID: <1614847759-33139-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
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

For more detailed information, please refer to the man pages provided by
the last patch of this series.

This series is associated with the kernel one "RDMA/hns: Add support for
Dynamic Context Attachment", you can review it at:
https://patchwork.kernel.org/project/linux-rdma/cover/1611394994-50363-1-git-send-email-liweihang@huawei.com/

Changes since v1:
- Add direct verbs to set the parameters about size that used to
  configuring DCA. 
- Add man pages to explain what is DCA, how does it works and how to use
  it.
- Link: https://patchwork.kernel.org/project/linux-rdma/cover/1612667574-56673-1-git-send-email-liweihang@huawei.com/

Weihang Li (1):
  Update kernel headers

Xi Wang (5):
  libhns: Introduce DCA for RC QP
  libhns: Add support for shrinking DCA memory pool
  libhns: Add support for attaching QP's WQE buffer
  libhns: Add direct verb to support config DCA memory pool
  libhns: Add man pages to introduce DCA feature

 CMakeLists.txt                             |   1 +
 debian/ibverbs-providers.install           |   1 +
 debian/ibverbs-providers.lintian-overrides |   4 +-
 debian/ibverbs-providers.symbols           |   5 +
 debian/libibverbs-dev.install              |   6 +
 kernel-headers/rdma/hns-abi.h              |  64 +++++
 libibverbs/cmd_qp.c                        |   3 +-
 libibverbs/man/ibv_create_qp_ex.3          |   1 +
 libibverbs/verbs.h                         |   1 +
 providers/hns/CMakeLists.txt               |   9 +-
 providers/hns/hns_roce_u.c                 |  96 +++++++
 providers/hns/hns_roce_u.h                 |  44 ++++
 providers/hns/hns_roce_u_abi.h             |   1 +
 providers/hns/hns_roce_u_buf.c             | 387 +++++++++++++++++++++++++++++
 providers/hns/hns_roce_u_hw_v2.c           | 138 +++++++++-
 providers/hns/hns_roce_u_hw_v2.h           |   7 +
 providers/hns/hns_roce_u_verbs.c           |  44 +++-
 providers/hns/hnsdv.h                      |  44 ++++
 providers/hns/libhns.map                   |   8 +
 providers/hns/man/CMakeLists.txt           |   6 +
 providers/hns/man/hns_dca.7.md             |  35 +++
 providers/hns/man/hnsdv.7.md               |  34 +++
 providers/hns/man/hnsdv_is_supported.3.md  |  39 +++
 providers/hns/man/hnsdv_open_device.3.md   |  70 ++++++
 redhat/rdma-core.spec                      |   5 +
 suse/rdma-core.spec                        |  19 ++
 26 files changed, 1051 insertions(+), 21 deletions(-)
 create mode 100644 providers/hns/hnsdv.h
 create mode 100644 providers/hns/libhns.map
 create mode 100644 providers/hns/man/CMakeLists.txt
 create mode 100644 providers/hns/man/hns_dca.7.md
 create mode 100644 providers/hns/man/hnsdv.7.md
 create mode 100644 providers/hns/man/hnsdv_is_supported.3.md
 create mode 100644 providers/hns/man/hnsdv_open_device.3.md

-- 
2.8.1

