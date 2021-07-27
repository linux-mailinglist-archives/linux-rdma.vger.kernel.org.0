Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371493D7068
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 09:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235745AbhG0HcB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jul 2021 03:32:01 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7067 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbhG0Hb6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Jul 2021 03:31:58 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GYpHZ5RKlzYh1Q;
        Tue, 27 Jul 2021 15:26:02 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 15:31:55 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 15:31:55 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v2 rdma-core 00/10] libhns: Add support for Dynamic Context Attachment
Date:   Tue, 27 Jul 2021 15:28:11 +0800
Message-ID: <1627370901-10054-1-git-send-email-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
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

Changes since v1:
* Add DCA pyverbs test cases.
* Add a shared memory mechanism to synchronize status of DCA.
* Link: https://patchwork.kernel.org/project/linux-rdma/cover/1620652384-34097-1-git-send-email-liweihang@huawei.com/

No changes since RFC v2.
* Link: https://patchwork.kernel.org/project/linux-rdma/cover/1614847759-33139-1-git-send-email-liweihang@huawei.com/

Changes since RFC v1:
* Add direct verbs to set the parameters about size that used to
  configuring DCA.
* Add man pages to explain what is DCA, how does it works and how to use
  it.
* Link: https://patchwork.kernel.org/project/linux-rdma/cover/1612667574-56673-1-git-send-email-liweihang@huawei.com/

Wenpeng Liang (1):
  Update kernel headers

Xi Wang (9):
  libhns: Introduce DCA for RC QP
  libhns: Add support for shrinking DCA memory pool
  libhns: Add support for attaching QP's WQE buffer
  libhns: Use shared memory to sync DCA status
  libhns: Sync DCA status by shared memory
  libhns: Add direct verbs support to config DCA
  libhns: Add man pages to introduce DCA feature
  pyverbs/hns: Initial support for HNS direct verbs
  tests: Add traffic test of send on HNS DCA QPEx

 CMakeLists.txt                             |   1 +
 debian/control                             |   2 +-
 debian/ibverbs-providers.install           |   1 +
 debian/ibverbs-providers.lintian-overrides |   4 +-
 debian/ibverbs-providers.symbols           |   6 +
 debian/libibverbs-dev.install              |   6 +
 kernel-headers/rdma/hns-abi.h              |  86 ++++++
 kernel-headers/rdma/mlx5-abi.h             |  17 +-
 providers/hns/CMakeLists.txt               |   9 +-
 providers/hns/hns_roce_u.c                 | 229 ++++++++++++++--
 providers/hns/hns_roce_u.h                 |  88 +++++-
 providers/hns/hns_roce_u_abi.h             |   7 +-
 providers/hns/hns_roce_u_buf.c             | 422 +++++++++++++++++++++++++++++
 providers/hns/hns_roce_u_hw_v2.c           | 178 ++++++++++--
 providers/hns/hns_roce_u_hw_v2.h           |   7 +
 providers/hns/hns_roce_u_verbs.c           |  67 ++++-
 providers/hns/hnsdv.h                      |  65 +++++
 providers/hns/libhns.map                   |   9 +
 providers/hns/man/CMakeLists.txt           |   7 +
 providers/hns/man/hns_dca.7.md             |  35 +++
 providers/hns/man/hnsdv.7.md               |  34 +++
 providers/hns/man/hnsdv_create_qp.3.md     |  69 +++++
 providers/hns/man/hnsdv_is_supported.3.md  |  39 +++
 providers/hns/man/hnsdv_open_device.3.md   |  74 +++++
 pyverbs/CMakeLists.txt                     |   1 +
 pyverbs/providers/hns/CMakeLists.txt       |   7 +
 pyverbs/providers/hns/__init__.pxd         |   0
 pyverbs/providers/hns/__init__.py          |   0
 pyverbs/providers/hns/hns_enums.pyx        |   1 +
 pyverbs/providers/hns/hnsdv.pxd            |  25 ++
 pyverbs/providers/hns/hnsdv.pyx            | 158 +++++++++++
 pyverbs/providers/hns/hnsdv_enums.pxd      |  21 ++
 pyverbs/providers/hns/libhns.pxd           |  28 ++
 redhat/rdma-core.spec                      |   7 +-
 suse/rdma-core.spec                        |  21 +-
 tests/hns_base.py                          |  80 ++++++
 tests/test_hns_dca.py                      |  37 +++
 37 files changed, 1781 insertions(+), 67 deletions(-)
 create mode 100644 providers/hns/hnsdv.h
 create mode 100644 providers/hns/libhns.map
 create mode 100644 providers/hns/man/CMakeLists.txt
 create mode 100644 providers/hns/man/hns_dca.7.md
 create mode 100644 providers/hns/man/hnsdv.7.md
 create mode 100644 providers/hns/man/hnsdv_create_qp.3.md
 create mode 100644 providers/hns/man/hnsdv_is_supported.3.md
 create mode 100644 providers/hns/man/hnsdv_open_device.3.md
 create mode 100644 pyverbs/providers/hns/CMakeLists.txt
 create mode 100644 pyverbs/providers/hns/__init__.pxd
 create mode 100644 pyverbs/providers/hns/__init__.py
 create mode 120000 pyverbs/providers/hns/hns_enums.pyx
 create mode 100644 pyverbs/providers/hns/hnsdv.pxd
 create mode 100644 pyverbs/providers/hns/hnsdv.pyx
 create mode 100644 pyverbs/providers/hns/hnsdv_enums.pxd
 create mode 100644 pyverbs/providers/hns/libhns.pxd
 create mode 100644 tests/hns_base.py
 create mode 100644 tests/test_hns_dca.py

--
2.8.1

