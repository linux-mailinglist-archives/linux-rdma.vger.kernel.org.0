Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40D449043F
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jan 2022 09:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiAQIsb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jan 2022 03:48:31 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:37330 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229620AbiAQIsb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 Jan 2022 03:48:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V21zh4z_1642409308;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V21zh4z_1642409308)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 17 Jan 2022 16:48:29 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, chengyou@linux.alibaba.com,
        tonylu@linux.alibaba.com
Subject: [PATCH rdma-next v2 00/11] Elastic RDMA Adapter (ERDMA) driver
Date:   Mon, 17 Jan 2022 16:48:17 +0800
Message-Id: <20220117084828.80638-1-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello all,

This v2 patch set introduces the Elastic RDMA Adapter (ERDMA) driver,
which released in Apsara Conference 2021 by Alibaba. The PR of ERDMA
userspace provider has already been created [1].

ERDMA enables large-scale RDMA acceleration capability in Alibaba ECS
environment, initially offered in g7re instance. It can improve the
efficiency of large-scale distributed computing and communication
significantly and expand dynamically with the cluster scale of Alibaba
Cloud.

ERDMA is a RDMA networking adapter based on the Alibaba MOC hardware. It
works in the VPC network environment (overlay network), and uses iWarp
tranport protocol. ERDMA supports reliable connection (RC). ERDMA also
supports both kernel space and user space verbs. Now we have already
supported HPC/AI applications with libfabric, NoF and some other internal
verbs libraries, such as xrdma, epsl, etc,.

For the ECS instance with RDMA enabled, our MOC hardware generates two
kinds of PCI devices: one for ERDMA, and one for the original net device
(virtio-net). They are separated PCI devices, using "rdma link" command
with a filter inside our rdma_link_ops.newlink implementation can bind
them together properly.

Fixed issues in v2:
- No "extern" to function declarations.
- No inline functions in .c files, no void casting for functions with
  return values.
- Based on siw's newest kernel version, rewrite the code (mainly CM and
  CM related part) which originally based on an old siw version.
  version.
- remove debugfs.
- fix issues reported by kernel test rebot.
- Using RDMA_NLDEV_CMD_NEWLINK instead of binding in net notifiers.

[1] https://github.com/linux-rdma/rdma-core/pull/1126

Thanks,
Cheng Xu

Cheng Xu (11):
  RDMA: Add ERDMA to rdma_driver_id definition
  RDMA/erdma: Add the hardware related definitions
  RDMA/erdma: Add main include file
  RDMA/erdma: Add cmdq implementation
  RDMA/erdma: Add event queue implementation
  RDMA/erdma: Add verbs header file
  RDMA/erdma: Add verbs implementation
  RDMA/erdma: Add connection management (CM) support
  RDMA/erdma: Add the erdma module
  RDMA/erdma: Add the ABI definitions
  RDMA/erdma: Add driver to kernel build environment

 MAINTAINERS                               |    8 +
 drivers/infiniband/Kconfig                |    1 +
 drivers/infiniband/hw/Makefile            |    1 +
 drivers/infiniband/hw/erdma/Kconfig       |   10 +
 drivers/infiniband/hw/erdma/Makefile      |    4 +
 drivers/infiniband/hw/erdma/erdma.h       |  392 ++++++
 drivers/infiniband/hw/erdma/erdma_cm.c    | 1382 ++++++++++++++++++++
 drivers/infiniband/hw/erdma/erdma_cm.h    |  196 +++
 drivers/infiniband/hw/erdma/erdma_cmdq.c  |  494 ++++++++
 drivers/infiniband/hw/erdma/erdma_cq.c    |  199 +++
 drivers/infiniband/hw/erdma/erdma_eq.c    |  341 +++++
 drivers/infiniband/hw/erdma/erdma_hw.h    |  476 +++++++
 drivers/infiniband/hw/erdma/erdma_main.c  |  707 +++++++++++
 drivers/infiniband/hw/erdma/erdma_qp.c    |  547 ++++++++
 drivers/infiniband/hw/erdma/erdma_verbs.c | 1409 +++++++++++++++++++++
 drivers/infiniband/hw/erdma/erdma_verbs.h |  339 +++++
 include/uapi/rdma/erdma-abi.h             |   49 +
 include/uapi/rdma/ib_user_ioctl_verbs.h   |    1 +
 18 files changed, 6556 insertions(+)
 create mode 100644 drivers/infiniband/hw/erdma/Kconfig
 create mode 100644 drivers/infiniband/hw/erdma/Makefile
 create mode 100644 drivers/infiniband/hw/erdma/erdma.h
 create mode 100644 drivers/infiniband/hw/erdma/erdma_cm.c
 create mode 100644 drivers/infiniband/hw/erdma/erdma_cm.h
 create mode 100644 drivers/infiniband/hw/erdma/erdma_cmdq.c
 create mode 100644 drivers/infiniband/hw/erdma/erdma_cq.c
 create mode 100644 drivers/infiniband/hw/erdma/erdma_eq.c
 create mode 100644 drivers/infiniband/hw/erdma/erdma_hw.h
 create mode 100644 drivers/infiniband/hw/erdma/erdma_main.c
 create mode 100644 drivers/infiniband/hw/erdma/erdma_qp.c
 create mode 100644 drivers/infiniband/hw/erdma/erdma_verbs.c
 create mode 100644 drivers/infiniband/hw/erdma/erdma_verbs.h
 create mode 100644 include/uapi/rdma/erdma-abi.h

-- 
2.27.0

