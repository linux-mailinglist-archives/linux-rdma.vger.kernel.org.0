Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7A347B876
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Dec 2021 03:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhLUCtC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Dec 2021 21:49:02 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:60577 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231163AbhLUCtB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Dec 2021 21:49:01 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V.IQ3Oh_1640054939;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V.IQ3Oh_1640054939)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Dec 2021 10:48:59 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, chengyou@linux.alibaba.com,
        tonylu@linux.alibaba.com
Subject: [PATCH rdma-next 00/11] Elastic RDMA Adapter (ERDMA) driver
Date:   Tue, 21 Dec 2021 10:48:47 +0800
Message-Id: <20211221024858.25938-1-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello all,

This patch set introduces the Elastic RDMA Adapter (ERDMA) driver, which
released in Apsara Conference 2021 by Alibaba.

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

For the ECS instance with RDMA enabled, there are two kinds of devices
allocated, one for ERDMA, and one for the original netdev (virtio-net).
They are different PCI deivces. ERDMA driver can get the information about
which netdev attached to in its PCIe barspace (by MAC address matching).

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
 drivers/infiniband/hw/erdma/Makefile      |    5 +
 drivers/infiniband/hw/erdma/erdma.h       |  381 +++++
 drivers/infiniband/hw/erdma/erdma_cm.c    | 1585 +++++++++++++++++++++
 drivers/infiniband/hw/erdma/erdma_cm.h    |  158 ++
 drivers/infiniband/hw/erdma/erdma_cmdq.c  |  489 +++++++
 drivers/infiniband/hw/erdma/erdma_cq.c    |  201 +++
 drivers/infiniband/hw/erdma/erdma_debug.c |  314 ++++
 drivers/infiniband/hw/erdma/erdma_debug.h |   18 +
 drivers/infiniband/hw/erdma/erdma_eq.c    |  346 +++++
 drivers/infiniband/hw/erdma/erdma_hw.h    |  474 ++++++
 drivers/infiniband/hw/erdma/erdma_main.c  |  711 +++++++++
 drivers/infiniband/hw/erdma/erdma_qp.c    |  624 ++++++++
 drivers/infiniband/hw/erdma/erdma_verbs.c | 1477 +++++++++++++++++++
 drivers/infiniband/hw/erdma/erdma_verbs.h |  366 +++++
 include/uapi/rdma/erdma-abi.h             |   49 +
 include/uapi/rdma/ib_user_ioctl_verbs.h   |    1 +
 20 files changed, 7219 insertions(+)
 create mode 100644 drivers/infiniband/hw/erdma/Kconfig
 create mode 100644 drivers/infiniband/hw/erdma/Makefile
 create mode 100644 drivers/infiniband/hw/erdma/erdma.h
 create mode 100644 drivers/infiniband/hw/erdma/erdma_cm.c
 create mode 100644 drivers/infiniband/hw/erdma/erdma_cm.h
 create mode 100644 drivers/infiniband/hw/erdma/erdma_cmdq.c
 create mode 100644 drivers/infiniband/hw/erdma/erdma_cq.c
 create mode 100644 drivers/infiniband/hw/erdma/erdma_debug.c
 create mode 100644 drivers/infiniband/hw/erdma/erdma_debug.h
 create mode 100644 drivers/infiniband/hw/erdma/erdma_eq.c
 create mode 100644 drivers/infiniband/hw/erdma/erdma_hw.h
 create mode 100644 drivers/infiniband/hw/erdma/erdma_main.c
 create mode 100644 drivers/infiniband/hw/erdma/erdma_qp.c
 create mode 100644 drivers/infiniband/hw/erdma/erdma_verbs.c
 create mode 100644 drivers/infiniband/hw/erdma/erdma_verbs.h
 create mode 100644 include/uapi/rdma/erdma-abi.h

-- 
2.27.0

