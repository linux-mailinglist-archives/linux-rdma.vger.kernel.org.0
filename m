Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B23C47EC4C
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Dec 2021 07:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245692AbhLXGzY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Dec 2021 01:55:24 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:35772 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241330AbhLXGzY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Dec 2021 01:55:24 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V.bLroP_1640328922;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V.bLroP_1640328922)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 24 Dec 2021 14:55:22 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     leon@kernel.org
Cc:     dledford@redhat.com, jgg@mellanox.com, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, chengyou@linux.alibaba.com
Subject: [PATCH rdma-core 0/5] Elastic RDMA Adapter (ERDMA) userspace provider driver
Date:   Fri, 24 Dec 2021 14:55:17 +0800
Message-Id: <20211224065522.29734-1-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello all,

This patch set introduces the Elastic RDMA Adapter (ERDMA) userspace
provider driver of *rdma-core*, and this patch set is used for review
purpose. The kernel driver of ERDMA can refer this link [1].

The main feature of ERDMA userspace provider includes: supports RC QP,
supports RDMA Write/Send/RDMA Read/Immediate opcode in post_send, supports
post_recv, and supports CQs with polling mode and event mode. Now we does
not support SRQ yet.

Thanks,
Cheng Xu

[1] https://lwn.net/Articles/879373/

Cheng Xu (5):
  RDMA-CORE/erdma: Add userspace verbs related header files.
  RDMA-CORE/erdma: Add userspace verbs implementation
  RDMA-CORE/erdma: Add the main module of the provider
  RDMA-CORE/erdma: Add the application interface
  RDMA-CORE/erdma: Add to the build environment

 CMakeLists.txt                            |   1 +
 MAINTAINERS                               |   5 +
 README.md                                 |   1 +
 kernel-headers/CMakeLists.txt             |   2 +
 kernel-headers/rdma/erdma-abi.h           |  49 ++
 kernel-headers/rdma/ib_user_ioctl_verbs.h |   1 +
 libibverbs/verbs.h                        |   1 +
 providers/erdma/CMakeLists.txt            |   5 +
 providers/erdma/erdma.c                   | 133 +++
 providers/erdma/erdma.h                   |  60 ++
 providers/erdma/erdma_abi.h               |  21 +
 providers/erdma/erdma_db.c                | 110 +++
 providers/erdma/erdma_db.h                |  17 +
 providers/erdma/erdma_hw.h                | 206 +++++
 providers/erdma/erdma_verbs.c             | 934 ++++++++++++++++++++++
 providers/erdma/erdma_verbs.h             | 134 ++++
 redhat/rdma-core.spec                     |   2 +
 17 files changed, 1682 insertions(+)
 create mode 100644 kernel-headers/rdma/erdma-abi.h
 create mode 100644 providers/erdma/CMakeLists.txt
 create mode 100644 providers/erdma/erdma.c
 create mode 100644 providers/erdma/erdma.h
 create mode 100644 providers/erdma/erdma_abi.h
 create mode 100644 providers/erdma/erdma_db.c
 create mode 100644 providers/erdma/erdma_db.h
 create mode 100644 providers/erdma/erdma_hw.h
 create mode 100644 providers/erdma/erdma_verbs.c
 create mode 100644 providers/erdma/erdma_verbs.h

-- 
2.27.0

