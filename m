Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAA43A45E4
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Jun 2021 18:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhFKQCo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Jun 2021 12:02:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230511AbhFKQCi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 11 Jun 2021 12:02:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7AC73613EE;
        Fri, 11 Jun 2021 16:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623427240;
        bh=AYCjSRiA7MOVAgL8C74NLeUPsyYwawhjVdH2ejk7qrk=;
        h=From:To:Cc:Subject:Date:From;
        b=XGyPAZCZyBODjwuShIY3AQDb0Po7xfRaw8NN+jQ8Pq/Z7x2IVsOmc7Oomv5uoGS5t
         v8BojlZZwtwsKInnRAISoHMkmHWrBjmpQgPXkrf374ND3i84zPpkSG6kgpxYU2LK0b
         HtQCaQl8RT9aPyPZG3KQDuCMjiqwszP+aPBXaWhf+tA78owUQV5A+8aBrp+pzCQfHp
         duJB2XvbT8W49BrXZeJCxrw7CMkooDpwQNotG01GxODAUlF8iO5XJQxKF1ZJrwHzJl
         P4Z+ieqchm9s5lRp0T++2rVivuGJdQSe3bIHLTNEpeBGG+K0PQNfJMuBKLntU92C/R
         ynX7gkJ8uxwAQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        clang-built-linux@googlegroups.com,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next v2 00/15] Reorganize sysfs file creation for struct ib_devices
Date:   Fri, 11 Jun 2021 19:00:19 +0300
Message-Id: <cover.1623427137.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v2:
 * Make port_attributes visible in init_net namespace.
 * Fixed hfi1 compilation warning.
v1: https://lore.kernel.org/lkml/cover.1623053078.git.leonro@nvidia.com
 * Added two new patches to the series
     RDMA/core: Allow port_groups to be used with namespaces
     RDMA: Remove rdma_set_device_sysfs_group()
 * Fixed missing ops definition in device.c
 * Passed proper internal validation and review
 * changed EXPORT_SYMBOL to be EXPORT_SYMBOL_GPL for the ib_port_sysfs_create_groups
 * qib was converted to use .is_visible() callback together with static
   attribute_group declaration.
v0: https://lore.kernel.org/linux-rdma/0-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com/

-------------------------------------------------------------------------------
From Jason,

IB has a complex sysfs with a deep nesting of attributes. Nathan and Kees
recently noticed this was not even slightly sane with how it was handling
attributes and a deeper inspection shows the whole thing is a pretty
"ick" coding style.

Further review shows the ick extends outward from the ib_port sysfs and
basically everything is pretty crazy.

Simplify all of it:

 - Organize the ib_port and gid_attr's kobj's to have clear setup/destroy
   function pairings that work only on their own kobjs.

 - All memory allocated in service of a kobject's attributes is freed as
   part of the kobj release function. Thus all the error handling defers
   the memory frees to a put.

 - Build up lists of groups for every kobject and add the entire group
   list as a one-shot operation as the last thing in setup function.

 - Remove essentially all the error cleanup. The final kobject_put() will
   always free any memory allocated or do an internal kobject_del() if
   required. The new ordering eliminates all the other cleanup cases.

 - Make all attributes use proper typing for the kobj they are attached
   to. Split device and port hw_stats handling.

 - Create a ib_port_attribute type and change hfi1, qib and the CM code to
   work with attribute lists of ib_port_attribute type instead of building
   their own kobject madness

Thanks

Jason Gunthorpe (15):
  RDMA: Split the alloc_hw_stats() ops to port and device variants
  RDMA/core: Replace the ib_port_data hw_stats pointers with a ib_port
    pointer
  RDMA/core: Split port and device counter sysfs attributes
  RDMA/core: Split gid_attrs related sysfs from add_port()
  RDMA/core: Simplify how the gid_attrs sysfs is created
  RDMA/core: Simplify how the port sysfs is created
  RDMA/core: Create the device hw_counters through the normal groups
    mechanism
  RDMA/core: Remove the kobject_uevent() NOP
  RDMA/core: Expose the ib port sysfs attribute machinery
  RDMA/cm: Use an attribute_group on the ib_port_attribute intead of
    kobj's
  RDMA/qib: Use attributes for the port sysfs
  RDMA/hfi1: Use attributes for the port sysfs
  RDMA: Change ops->init_port to ops->port_groups
  RDMA/core: Allow port_groups to be used with namespaces
  RDMA: Remove rdma_set_device_sysfs_group()

 drivers/infiniband/core/cm.c                  |  227 ++--
 drivers/infiniband/core/core_priv.h           |   13 +-
 drivers/infiniband/core/counters.c            |    4 +-
 drivers/infiniband/core/device.c              |   30 +-
 drivers/infiniband/core/nldev.c               |   10 +-
 drivers/infiniband/core/sysfs.c               | 1100 ++++++++---------
 drivers/infiniband/hw/bnxt_re/hw_counters.c   |    7 +-
 drivers/infiniband/hw/bnxt_re/hw_counters.h   |    4 +-
 drivers/infiniband/hw/bnxt_re/main.c          |    4 +-
 drivers/infiniband/hw/cxgb4/provider.c        |   11 +-
 drivers/infiniband/hw/efa/efa.h               |    3 +-
 drivers/infiniband/hw/efa/efa_main.c          |    3 +-
 drivers/infiniband/hw/efa/efa_verbs.c         |   11 +-
 drivers/infiniband/hw/hfi1/hfi.h              |    7 +-
 drivers/infiniband/hw/hfi1/sysfs.c            |  530 +++-----
 drivers/infiniband/hw/hfi1/verbs.c            |   92 +-
 drivers/infiniband/hw/irdma/verbs.c           |   11 +-
 drivers/infiniband/hw/mlx4/main.c             |   27 +-
 drivers/infiniband/hw/mlx5/counters.c         |   42 +-
 drivers/infiniband/hw/mlx5/main.c             |    2 +-
 drivers/infiniband/hw/mthca/mthca_provider.c  |    2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_main.c    |    2 +-
 drivers/infiniband/hw/qedr/main.c             |    2 +-
 drivers/infiniband/hw/qib/qib.h               |    8 +-
 drivers/infiniband/hw/qib/qib_sysfs.c         |  616 ++++-----
 drivers/infiniband/hw/qib/qib_verbs.c         |    6 +-
 drivers/infiniband/hw/usnic/usnic_ib_main.c   |    3 +-
 .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    |    2 +-
 drivers/infiniband/sw/rdmavt/vt.c             |    2 +-
 drivers/infiniband/sw/rxe/rxe_hw_counters.c   |    7 +-
 drivers/infiniband/sw/rxe/rxe_hw_counters.h   |    4 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c         |    4 +-
 include/rdma/ib_sysfs.h                       |   37 +
 include/rdma/ib_verbs.h                       |   68 +-
 34 files changed, 1319 insertions(+), 1582 deletions(-)
 create mode 100644 include/rdma/ib_sysfs.h

-- 
2.31.1

