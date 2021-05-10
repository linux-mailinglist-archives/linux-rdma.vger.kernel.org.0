Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB720378EDA
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 15:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242365AbhEJNYh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 09:24:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2613 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352236AbhEJNOW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 May 2021 09:14:22 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Ff1cL2LBMzQlns;
        Mon, 10 May 2021 21:09:54 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 21:13:06 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH rdma-core 0/6] libhns: Add support for Dynamic Context Attachment
Date:   Mon, 10 May 2021 21:12:58 +0800
Message-ID: <1620652384-34097-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
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
Dynamic Context Attachment", and two RFC versions of this series has been
sent before.

No changes since RFC v2.
* Link: https://patchwork.kernel.org/project/linux-rdma/cover/1614847759-33139-1-git-send-email-liweihang@huawei.com/

Changes since RFC v1:
* Add direct verbs to set the parameters about size that used to
  configuring DCA. 
* Add man pages to explain what is DCA, how does it works and how to use
  it.
* Link: https://patchwork.kernel.org/project/linux-rdma/cover/1612667574-56673-1-git-send-email-liweihang@huawei.com/

Weihang Li (1):
  Update kernel headers

Xi Wang (5):
  libhns: Introduce DCA for RC QP
  libhns: Add support for shrinking DCA memory pool
  libhns: Add support for attaching QP's WQE buffer
  libhns: Add direct verbs support to config DCA
  libhns: Add man pages to introduce DCA feature

 CMakeLists.txt                             |   1 +
 debian/control                             |   2 +-
 debian/ibverbs-providers.install           |   1 +
 debian/ibverbs-providers.lintian-overrides |   4 +-
 debian/ibverbs-providers.symbols           |   6 +
 debian/libibverbs-dev.install              |   6 +
 kernel-headers/rdma/hns-abi.h              |  64 +++++
 providers/hns/CMakeLists.txt               |   9 +-
 providers/hns/hns_roce_u.c                 | 100 ++++++++
 providers/hns/hns_roce_u.h                 |  44 ++++
 providers/hns/hns_roce_u_abi.h             |   1 +
 providers/hns/hns_roce_u_buf.c             | 387 +++++++++++++++++++++++++++++
 providers/hns/hns_roce_u_hw_v2.c           | 130 ++++++++--
 providers/hns/hns_roce_u_hw_v2.h           |   7 +
 providers/hns/hns_roce_u_verbs.c           |  67 ++++-
 providers/hns/hnsdv.h                      |  61 +++++
 providers/hns/libhns.map                   |   9 +
 providers/hns/man/CMakeLists.txt           |   7 +
 providers/hns/man/hns_dca.7.md             |  35 +++
 providers/hns/man/hnsdv.7.md               |  34 +++
 providers/hns/man/hnsdv_create_qp.3.md     |  69 +++++
 providers/hns/man/hnsdv_is_supported.3.md  |  39 +++
 providers/hns/man/hnsdv_open_device.3.md   |  70 ++++++
 redhat/rdma-core.spec                      |   7 +-
 suse/rdma-core.spec                        |  21 +-
 25 files changed, 1149 insertions(+), 32 deletions(-)
 create mode 100644 providers/hns/hnsdv.h
 create mode 100644 providers/hns/libhns.map
 create mode 100644 providers/hns/man/CMakeLists.txt
 create mode 100644 providers/hns/man/hns_dca.7.md
 create mode 100644 providers/hns/man/hnsdv.7.md
 create mode 100644 providers/hns/man/hnsdv_create_qp.3.md
 create mode 100644 providers/hns/man/hnsdv_is_supported.3.md
 create mode 100644 providers/hns/man/hnsdv_open_device.3.md

-- 
2.7.4

