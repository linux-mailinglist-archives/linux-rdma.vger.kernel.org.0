Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD6A4B9638
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Feb 2022 04:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiBQDBe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Feb 2022 22:01:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiBQDBd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Feb 2022 22:01:33 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4CC11798C
        for <linux-rdma@vger.kernel.org>; Wed, 16 Feb 2022 19:01:19 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V4g0B1t_1645066876;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V4g0B1t_1645066876)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Feb 2022 11:01:17 +0800
From:   Cheng Xu <chengyou.xc@alibaba-inc.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, chengyou@linux.alibaba.com,
        tonylu@linux.alibaba.com
Subject: [PATCH for-next v3 00/12] Elastic RDMA Adapter (ERDMA) driver
Date:   Thu, 17 Feb 2022 11:01:04 +0800
Message-Id: <20220217030116.6324-1-chengyou.xc@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Cheng Xu <chengyou@linux.alibaba.com>

Hello all,

This v3 patch set introduces the Elastic RDMA Adapter (ERDMA) driver,
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

Besides, this patchset contains a change in iw_query_port to fix this
issue [2]. This change lets the device drivers decide the return value of
iw_query_port when attached netdev is NULL. After this change, erdma can
register device successfully in pci probe function, and keep port state
invalid until a netdev is binded to it.

Fixed issues or changes in v3:
- Change char limit of column from 100 to 80.
- Remove unnecessary field or structure definitions in erdma.h.
- Use exactly type (bool, unsigned int) instead of "int" in erdma_dev.
- Make ibdev and pci device having the same lifecycle. ERDMA will remain
  an invalid port state until binded to the corresponding netdev.
- ib_core: allow query_port when netdev is NULL for iWarp device.
- Move large inline function in erdma.h to .c files.
- Use dev_{info, warn, err} or ibdev_{info, warn, err} instead of
  pr_{info, warn, err} function calls.
- Remove print function calls in userspace-triggered paths.
- Add necessary comments in CM part.
- Remove unused entries in map_cqe_opcode[] table.
- Use rdma_is_kernel_res instead of self-definitions.
- Remove unsed resources counter in erdma_dev.
- Use pgprot_device instead of pgprot_noncached in erdma_mmap.
- Remove disassociate_ucontext interface implementation

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
[2] https://lore.kernel.org/all/20220118141324.GF8034@ziepe.ca/

Thanks,
Cheng Xu

Cheng Xu (12):
  RDMA: Add ERDMA to rdma_driver_id definition
  RDMA/core: Allow calling query_port when netdev isn't attached in
    iWarp
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
 drivers/infiniband/core/device.c          |    7 +-
 drivers/infiniband/hw/Makefile            |    1 +
 drivers/infiniband/hw/erdma/Kconfig       |   10 +
 drivers/infiniband/hw/erdma/Makefile      |    4 +
 drivers/infiniband/hw/erdma/erdma.h       |  288 ++++
 drivers/infiniband/hw/erdma/erdma_cm.c    | 1440 ++++++++++++++++++++
 drivers/infiniband/hw/erdma/erdma_cm.h    |  167 +++
 drivers/infiniband/hw/erdma/erdma_cmdq.c  |  512 ++++++++
 drivers/infiniband/hw/erdma/erdma_cq.c    |  202 +++
 drivers/infiniband/hw/erdma/erdma_eq.c    |  366 ++++++
 drivers/infiniband/hw/erdma/erdma_hw.h    |  480 +++++++
 drivers/infiniband/hw/erdma/erdma_main.c  |  629 +++++++++
 drivers/infiniband/hw/erdma/erdma_qp.c    |  567 ++++++++
 drivers/infiniband/hw/erdma/erdma_verbs.c | 1447 +++++++++++++++++++++
 drivers/infiniband/hw/erdma/erdma_verbs.h |  345 +++++
 include/uapi/rdma/erdma-abi.h             |   49 +
 include/uapi/rdma/ib_user_ioctl_verbs.h   |    1 +
 19 files changed, 6523 insertions(+), 1 deletion(-)
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

