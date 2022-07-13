Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAAC757330C
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Jul 2022 11:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbiGMJmS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Jul 2022 05:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiGMJmR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Jul 2022 05:42:17 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2368FF5D6E
        for <linux-rdma@vger.kernel.org>; Wed, 13 Jul 2022 02:42:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VJDAXTG_1657705332;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VJDAXTG_1657705332)
          by smtp.aliyun-inc.com;
          Wed, 13 Jul 2022 17:42:13 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com,
        chengyou@linux.alibaba.com, tonylu@linux.alibaba.com
Subject: [PATCH for-next v13 00/11] Elastic RDMA Adapter (ERDMA) driver
Date:   Wed, 13 Jul 2022 17:42:01 +0800
Message-Id: <20220713094212.30943-1-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello all,

This v13 patch set introduces the Elastic RDMA Adapter (ERDMA) driver,
which released in Apsara Conference 2021 by Alibaba. The PR of ERDMA
userspace provider has already been created [1].

ERDMA enables large-scale RDMA acceleration capability in Alibaba ECS
environment, initially offered in g7re instance. It can improve the
efficiency of large-scale distributed computing and communication
significantly and expand dynamically with the cluster scale of Alibaba
Cloud.

ERDMA is a RDMA networking adapter based on the Alibaba MOC hardware. It
works in the VPC network environment (overlay network), and uses iWarp
transport protocol. ERDMA supports reliable connection (RC). ERDMA also
supports both kernel space and user space verbs. Now we have already
supported HPC/AI applications with libfabric, NoF and some other internal
verbs libraries, such as xrdma, epsl, etc,.

For the ECS instance with RDMA enabled, our MOC hardware generates two
kinds of PCI devices: one for ERDMA, and one for the original net device
(virtio-net). They are separated PCI devices.

Fixed issues or changes in v13:
- Change the opensource license of code.
- Simplify some code which is unnecessary in device probe.
- Fix a bug in the error handler of erdma_proc_mpareply.

Fixed issues in v12:
- Use the bitmap API to allocate bitmaps. (From Christophe)
- Use the non-atomic bitmap API when applicable. (From Christophe)

Fixed issues in v11:
- Return -EIO when CMDQ response has error status.
- Eliminate static checker warnings.

Fixed issues in v10:
- Remove unneeded semicolon in erdma_qp.c reported by Abcci Robot.
- Remove duplicated include in erdma_cm.c reported by Abcci Robot.
- Fix return value check in erdma_alloc_ucontext() reported by Hulk
  Robot.
- Sort the include headers.

Fixed issues or changes in v9:
- Refactor the implementation of netdev bind flow in erdma.
- Remove the modification of iw_query_port due to the refactor.

Fixed issues or changes in v8:
- Sort the source order in drivers/infiniband/Kconfig.
- Remove !CPU_BIG_ENDIAN in our Kconfig, and fix warnings reported by
  sparse.
- Remove rdma_link_ops implementation in erdma. Instead, we implement a
  workqueue to handle the link operation after registering erdma device
  successfully.

Changes in v7:
- Fix a wrong doorbell records' address calculation issue in
  erdma_create_qp.
- Fix a condition race issue when reporting IW_CM_EVENT_CONNECT_REQUEST
  event in cm.
- Sorry for a mmap_free implementation missing, we add it in this version.
- Remove unnecessary reference to erdma_dev in erdma_ucontext.

Changes in v6:
- Rebase to the latest for-next code, and solve the compilation issues.

Fixed issues or changes in v5:
- Rename the reserved fields of structure definitions to improve
  readability.
- Remove some magic numbers and unnecessary initializations.
- Fix some coding style format issues.
- Fix some typos in comments.
- No casting in the assignment if the function's returned pointer is
  "void *".
- Re-write the polling functions (cmdq cq, verbs cq, aeq and ceq), which
  all check the valid bit in order to get next valid QE. This new
  implementation is more simple. Thank Wenpeng.
- Fix an issue reported by kernel test robot.
- Some minor changes in code (such as removing SRQ definitions since we do
  not support it yet).

Fixed issues in v4:
- Fix some typos.
- Use __GFP_ZERO flags in dma_alloc_coherent, instead of memset after
  buffer allocation.
- Use one single polling function for AEQ and CEQ, before there had two.
- Fix wrong iov_num when calling kernel_sendmsg.
- Add necessary comment in erdma_cm.
- Remove duplicated check in MPA processing function.
- Always return 0 in erdma_query_port.
- Directly return error code instead of assigning "ret", and then returning
  "ret" in init_kernel_qp.

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
- remove debugfs.
- fix issues reported by kernel test robot.
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
 drivers/infiniband/Kconfig                |   15 +-
 drivers/infiniband/hw/Makefile            |    1 +
 drivers/infiniband/hw/erdma/Kconfig       |   12 +
 drivers/infiniband/hw/erdma/Makefile      |    4 +
 drivers/infiniband/hw/erdma/erdma.h       |  287 ++++
 drivers/infiniband/hw/erdma/erdma_cm.c    | 1430 ++++++++++++++++++++
 drivers/infiniband/hw/erdma/erdma_cm.h    |  167 +++
 drivers/infiniband/hw/erdma/erdma_cmdq.c  |  493 +++++++
 drivers/infiniband/hw/erdma/erdma_cq.c    |  205 +++
 drivers/infiniband/hw/erdma/erdma_eq.c    |  329 +++++
 drivers/infiniband/hw/erdma/erdma_hw.h    |  508 +++++++
 drivers/infiniband/hw/erdma/erdma_main.c  |  608 +++++++++
 drivers/infiniband/hw/erdma/erdma_qp.c    |  566 ++++++++
 drivers/infiniband/hw/erdma/erdma_verbs.c | 1460 +++++++++++++++++++++
 drivers/infiniband/hw/erdma/erdma_verbs.h |  342 +++++
 include/uapi/rdma/erdma-abi.h             |   49 +
 include/uapi/rdma/ib_user_ioctl_verbs.h   |    1 +
 18 files changed, 6478 insertions(+), 7 deletions(-)
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

