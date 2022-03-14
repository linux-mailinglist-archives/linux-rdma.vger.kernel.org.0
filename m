Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343254D7AEF
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Mar 2022 07:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbiCNGs6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Mar 2022 02:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiCNGsx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Mar 2022 02:48:53 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808A23D493
        for <linux-rdma@vger.kernel.org>; Sun, 13 Mar 2022 23:47:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V75.E0H_1647240459;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V75.E0H_1647240459)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 14 Mar 2022 14:47:40 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, chengyou@linux.alibaba.com,
        tonylu@linux.alibaba.com, BMT@zurich.ibm.com
Subject: [PATCH for-next v4 00/12] Elastic RDMA Adapter (ERDMA) driver
Date:   Mon, 14 Mar 2022 14:47:27 +0800
Message-Id: <20220314064739.81647-1-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello all,

This v4 patch set introduces the Elastic RDMA Adapter (ERDMA) driver,
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
 drivers/infiniband/hw/erdma/erdma_cm.c    | 1439 ++++++++++++++++++++
 drivers/infiniband/hw/erdma/erdma_cm.h    |  168 +++
 drivers/infiniband/hw/erdma/erdma_cmdq.c  |  511 +++++++
 drivers/infiniband/hw/erdma/erdma_cq.c    |  202 +++
 drivers/infiniband/hw/erdma/erdma_eq.c    |  347 +++++
 drivers/infiniband/hw/erdma/erdma_hw.h    |  498 +++++++
 drivers/infiniband/hw/erdma/erdma_main.c  |  645 +++++++++
 drivers/infiniband/hw/erdma/erdma_qp.c    |  569 ++++++++
 drivers/infiniband/hw/erdma/erdma_verbs.c | 1464 +++++++++++++++++++++
 drivers/infiniband/hw/erdma/erdma_verbs.h |  344 +++++
 include/uapi/rdma/erdma-abi.h             |   49 +
 include/uapi/rdma/ib_user_ioctl_verbs.h   |    1 +
 19 files changed, 6555 insertions(+), 1 deletion(-)
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

