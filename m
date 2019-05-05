Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA29141E0
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2019 20:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfEESkb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 May 2019 14:40:31 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:55003 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfEESkb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 May 2019 14:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1557081628; x=1588617628;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=2NnolEqK7JiL9cOCj6Mai1I4lS17D1+99bPvcIA58Dc=;
  b=qXMYKnZNsoMp6gyGjX//nH/DjPgtcU/djPOBzs4kGVBTKQC9PvsKP3IS
   LCOIGvCDOD9HPbz2+V1eOGg09NI0o568540F0AUwAYnsZgr+wm6/0Jubn
   OP7OPF8DuOYx9Nofs/MTg0K3hqYFfjqnk9/Esqromy/oqkZ1lfqLSACz0
   M=;
X-IronPort-AV: E=Sophos;i="5.60,435,1549929600"; 
   d="scan'208";a="797946226"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 May 2019 18:40:26 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x45IeHWJ128030
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 5 May 2019 18:40:22 GMT
Received: from EX13D04UWB001.ant.amazon.com (10.43.161.46) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 5 May 2019 18:40:21 +0000
Received: from EX13MTAUEB001.ant.amazon.com (10.43.60.96) by
 EX13D04UWB001.ant.amazon.com (10.43.161.46) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 5 May 2019 18:40:21 +0000
Received: from galpress-VirtualBox.hfa16.amazon.com (10.85.90.212) by
 mail-relay.amazon.com (10.43.60.129) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sun, 5 May 2019 18:40:17 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leah Shalev <shalevl@amazon.com>,
        Dave Goodell <goodell@amazon.com>,
        Brian Barrett <bbarrett@amazon.com>,
        <linux-rdma@vger.kernel.org>, Sean Hefty <sean.hefty@intel.com>,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Steve Wise <larrystevenwise@gmail.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        "Gal Pressman" <galpress@amazon.com>
Subject: [PATCH for-next v7 00/11] RDMA/efa: Elastic Fabric Adapter (EFA) driver
Date:   Sun, 5 May 2019 20:59:20 +0300
Message-ID: <1557079171-19329-1-git-send-email-galpress@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello all,
The following v7 patchset introduces the Amazon Elastic Fabric Adapter (EFA)
driver.

EFA is a networking adapter designed to support user space network
communication, initially offered in the Amazon EC2 environment. First release
of EFA supports datagram send/receive operations and does not support
connection-oriented or read/write operations.

EFA supports Unreliable Datagrams (UD) as well as a new unordered, Scalable
Reliable Datagram protocol (SRD). SRD provides support for reliable datagrams
and more complete error handling than typical RD, but, unlike RD, it does not
support ordering nor segmentation.

EFA reliable datagram transport provides reliable out-of-order delivery,
transparently utilizing multiple network paths to reduce network tail
latency. Its interface is similar to UD, in particular it supports
message size up to MTU, with error handling extended to support reliable
communication. More information regarding SRD can be found at [1].

Kernel verbs and in-kernel services are initially not supported but are planned
for future releases.

EFA enabled EC2 instances have two different devices allocated, one for ENA
(netdev) and one for EFA, the two are separate pci devices with no in-kernel
communication between them.

This patchset also introduces RDMA subsystem ibdev_* print helpers which should
be used by the other new drivers that are currently under review (irdma, siw)
and over time by all drivers in the subsystem.
The print format is similar to the netdev_* helpers.

PR for rdma-core provider was sent:
https://github.com/linux-rdma/rdma-core/pull/475

Thanks to everyone who took the time to review our last submissions (Jason, Doug,
Sean, Dennis, Leon, Christoph, Parav, Sagi, Steve, Shiraz), it is very
appreciated.

Issues addressed in v7:
* Remove unused list field in mmap entry (Jason)
* Protect mmap xarray operations with a lock (Jason)
* Outstanding comments will be fixed in follow-up submission

Issues addressed in v6:
* Remove BUG_ONs from __dynamic_ibdev_dbg
* Remove redundant udata checks (Leon)
* Remove rdma_user_mmap_page usage
* Remove umem->page_shift usage
* Make efa_destroy_qp_handle function static
* Misc prints cleanups

Issues addressed in v5:
* Adapt to subsystem verbs API changes
* Remove unnecessary 'do ... while' in ibdev_dbg (Jason)
* Use a non-macro implementation for ibdev_dbg (Jason)
* Use for_each_sg_dma_page() in umem iterations (Jason)
* Remove unused enum value EFA_ADMIN_START_CMD_RANGE (Leon)
* Don't assume the sg element offset is zero (Jason)
* Cherry-picked Shiraz's new ib_umem_find_single_pg_size() work, encountered
  some issues, debugging with Shiraz off-list. Will convert to use his work once
  solved.

Issues addressed in v4:
* Add RDMA subsystem ibdev_* printk helpers (Leon, Jason)
* Use xarray for mmap keys (Jason)
* Use module_pci_driver macro (Jason)
* Remove redundant cast in efa_remove (Jason)
* Avoid unnecessary use of pci_get_drvdata (Jason)
* Remove unnecessary admin queue sizes macros (Leon)
* Remove EFA_DEVICE_RUNNING bit (Leon, Jason)
* Remove incorrect comment in efa_com_validate_version (Leon)
* Keep lists sorted (Jason)
* Keep efa_com_dev as part of efa_dev instead of allocating it (Jason)

Issues addressed in v3:
* Use new rdma_udata_to_drv_context API
* Adapt to new core ucontext allocations
* Remove EFA transport/protocol/node type and use unspecified instead (Leon, Jason)
* Replace stats lock with atomic variables (Leon, Jason, Steve)
* Remove vertical alignment from structs (Steve)
* Remove license text from ABI file (Leon)
* Undefine macro when it's no longer used (Steve)
* Fix kdoc formatting (Steve)
* Remove unneeded lock from reg read destroy flow (Steve)
* Prefer {} initializations over memset (Leon)
* Remove highmem WARN_ON_ONCE (Steve)
* ib_alloc_device returns NULL in case of error (Leon)
* Remove redundant check from remove remove device flow (Leon)
* Remove redundant zero assignments after memsets
* Remove unnecessary WARN_ON_ONCEs from create QP verbs (Steve)
* Remove redundant memsets (Steve, Shiraz)
* Change all non-privileged flows error prints to debug level (Steve, Leon, Jason, Shiraz)
* Remove likely/unlikelys from control path (Leon, Jason)
* Fixes to reg MR indirect flow wrong PAGE_SIZE usage (Jason)
* Use decimal array size in ABI file (Steve)
* Remove redundant comments (Steve, Shiraz)
* Change efa_verbs.c to GPL-2.0 OR Linux-OpenIB license (Leon, Jason)
* Replace WARN in admin completion processing with WARN_ONCE (Steve)

Major issues addressed in this v2:
* Userspace libibverbs provider is implemented and attached for review.
* Respect the atomic requirement of create/destroy AH flows using the new
  sleepable flag [2].
* Change link layer from Ethernet to Unspecified (Proprietary EC2 link layer).
* Use RDMA mmap API.
* Coherent DMA memory is no longer mapped to the userspace, streaming DMA
  mappings are used instead.
* Introduce alloc/dealloc PD admin commands, PDs are now backed by an object on
  the device. This removes the bitmap used for PD number allocations.
* Addressed the mmap lifetime issues:
  Each ucontext now uses a new User Access Region (UAR) abstraction.
  Objects which are tied to a specific UAR will not be allocated to a different
  user until the UAR is deallocated (on application exit).
  DMA memory will be unmapped when the QP/CQ is destroyed, but the buffers will
  remain allocated until application exit.
  The mmap entries now remain valid until application exit and allow for reuse
  of the same mmap key more than once.
* SRD QP type is now a driver QP type (previously was IB_QPT_SRD).
* Match UD QP Infiniband semantics, including 40 bytes offset, state transitions,
  QKey validation, etc.
* Move AH reference counts to the device (previously was in the driver).
  When creating more than one AH with the same GID, the same device resource is
  used internally. Instead of keeping the reference count in the driver (and issue
  one create AH command only), each AH creation is now passed on to the device
  (accompanied with the PD number).
  This allows for future optimizations for AHs that are no longer used by a
  specific PD.
* Removed all stub functions, which will mark EFA driver as a non-kverbs provider [3].
* Replace all pr_* prints with dev_* prints

[1] https://github.com/amzn/rdma-core/wiki/SRD
[2] https://patchwork.kernel.org/cover/10725727/
[3] https://patchwork.kernel.org/cover/10775039/

Thanks,
Gal

Gal Pressman (11):
  RDMA: Add EFA related definitions
  RDMA/efa: Add EFA device definitions
  RDMA/efa: Add the efa.h header file
  RDMA/efa: Add the efa_com.h file
  RDMA/efa: Add the com service API definitions
  RDMA/efa: Add the ABI definitions
  RDMA/efa: Implement functions that submit and complete admin commands
  RDMA/efa: Add common command handlers
  RDMA/efa: Add EFA verbs implementation
  RDMA/efa: Add the efa module
  RDMA/efa: Add driver to Kconfig/Makefile

 MAINTAINERS                                     |    9 +
 drivers/infiniband/Kconfig                      |    1 +
 drivers/infiniband/core/sysfs.c                 |    1 +
 drivers/infiniband/core/verbs.c                 |    2 +
 drivers/infiniband/hw/Makefile                  |    1 +
 drivers/infiniband/hw/efa/Kconfig               |   15 +
 drivers/infiniband/hw/efa/Makefile              |    9 +
 drivers/infiniband/hw/efa/efa.h                 |  162 ++
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h |  794 ++++++++++
 drivers/infiniband/hw/efa/efa_admin_defs.h      |  136 ++
 drivers/infiniband/hw/efa/efa_com.c             | 1160 ++++++++++++++
 drivers/infiniband/hw/efa/efa_com.h             |  144 ++
 drivers/infiniband/hw/efa/efa_com_cmd.c         |  692 +++++++++
 drivers/infiniband/hw/efa/efa_com_cmd.h         |  270 ++++
 drivers/infiniband/hw/efa/efa_common_defs.h     |   18 +
 drivers/infiniband/hw/efa/efa_main.c            |  533 +++++++
 drivers/infiniband/hw/efa/efa_regs_defs.h       |  113 ++
 drivers/infiniband/hw/efa/efa_verbs.c           | 1871 +++++++++++++++++++++++
 include/rdma/ib_verbs.h                         |    4 +-
 include/uapi/rdma/efa-abi.h                     |  101 ++
 include/uapi/rdma/rdma_user_ioctl_cmds.h        |    1 +
 21 files changed, 6036 insertions(+), 1 deletion(-)
 create mode 100644 drivers/infiniband/hw/efa/Kconfig
 create mode 100644 drivers/infiniband/hw/efa/Makefile
 create mode 100644 drivers/infiniband/hw/efa/efa.h
 create mode 100644 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
 create mode 100644 drivers/infiniband/hw/efa/efa_admin_defs.h
 create mode 100644 drivers/infiniband/hw/efa/efa_com.c
 create mode 100644 drivers/infiniband/hw/efa/efa_com.h
 create mode 100644 drivers/infiniband/hw/efa/efa_com_cmd.c
 create mode 100644 drivers/infiniband/hw/efa/efa_com_cmd.h
 create mode 100644 drivers/infiniband/hw/efa/efa_common_defs.h
 create mode 100644 drivers/infiniband/hw/efa/efa_main.c
 create mode 100644 drivers/infiniband/hw/efa/efa_regs_defs.h
 create mode 100644 drivers/infiniband/hw/efa/efa_verbs.c
 create mode 100644 include/uapi/rdma/efa-abi.h

-- 
2.7.4

