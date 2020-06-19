Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F54320042C
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2020 10:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbgFSIh6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Jun 2020 04:37:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:58405 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730983AbgFSIhz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Jun 2020 04:37:55 -0400
IronPort-SDR: +KggxEUDh+JGcGKdjwQvbENBa9qTAiGAeisWyvysJR7tStt9wCEGCbEAjDLBGZnf5CiDMMXyZo
 1SnuxgrF+tAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="144386883"
X-IronPort-AV: E=Sophos;i="5.75,254,1589266800"; 
   d="scan'208";a="144386883"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 01:37:54 -0700
IronPort-SDR: izbOhxaqojF429xCEr78R9lUe5fR6dr2rWvB5hN/U9P4/SnMU34UzmqNQYrriXAnqjqAIJ51Ys
 NNzvlRdwtyBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,254,1589266800"; 
   d="scan'208";a="277936346"
Received: from lkp-server02.sh.intel.com (HELO 5ce11009e457) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 19 Jun 2020 01:37:53 -0700
Received: from kbuild by 5ce11009e457 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jmCX2-0000lj-PE; Fri, 19 Jun 2020 08:37:52 +0000
Date:   Fri, 19 Jun 2020 16:36:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS WITH WARNING
 a7ca4c3ebe6994ba88eb23576b2c3901b08e1dec
Message-ID: <5eec792a.8RLhtHRc5fmqWH+V%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: a7ca4c3ebe6994ba88eb23576b2c3901b08e1dec  IB/srpt: Remove WARN_ON from srpt_cm_req_recv

Warning in current branch:

drivers/infiniband/core/cm.c:2065:12: sparse: sparse: context imbalance in 'cm_req_handler' - different lock contexts for basic block
drivers/infiniband/core/cm.c:2584:12: sparse: sparse: context imbalance in 'cm_rtu_handler' - different lock contexts for basic block
drivers/infiniband/core/cm.c:3382:12: sparse: sparse: context imbalance in 'cm_apr_handler' - different lock contexts for basic block
drivers/infiniband/core/cm.c:3427:12: sparse: sparse: context imbalance in 'cm_timewait_handler' - different lock contexts for basic block

Warning ids grouped by kconfigs:

recent_errors
|-- arm-randconfig-s031-20200618
|   |-- drivers-infiniband-core-cm.c:sparse:sparse:context-imbalance-in-cm_apr_handler-different-lock-contexts-for-basic-block
|   |-- drivers-infiniband-core-cm.c:sparse:sparse:context-imbalance-in-cm_req_handler-different-lock-contexts-for-basic-block
|   |-- drivers-infiniband-core-cm.c:sparse:sparse:context-imbalance-in-cm_rtu_handler-different-lock-contexts-for-basic-block
|   `-- drivers-infiniband-core-cm.c:sparse:sparse:context-imbalance-in-cm_timewait_handler-different-lock-contexts-for-basic-block
`-- riscv-randconfig-s032-20200618
    |-- drivers-infiniband-core-cm.c:sparse:sparse:context-imbalance-in-cm_apr_handler-different-lock-contexts-for-basic-block
    |-- drivers-infiniband-core-cm.c:sparse:sparse:context-imbalance-in-cm_req_handler-different-lock-contexts-for-basic-block
    |-- drivers-infiniband-core-cm.c:sparse:sparse:context-imbalance-in-cm_rtu_handler-different-lock-contexts-for-basic-block
    `-- drivers-infiniband-core-cm.c:sparse:sparse:context-imbalance-in-cm_timewait_handler-different-lock-contexts-for-basic-block

elapsed time: 725m

configs tested: 98
configs skipped: 1

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a002-20200618
i386                 randconfig-a006-20200618
i386                 randconfig-a001-20200618
i386                 randconfig-a004-20200618
i386                 randconfig-a005-20200618
i386                 randconfig-a003-20200618
x86_64               randconfig-a001-20200618
x86_64               randconfig-a003-20200618
x86_64               randconfig-a006-20200618
x86_64               randconfig-a002-20200618
x86_64               randconfig-a005-20200618
x86_64               randconfig-a004-20200618
i386                 randconfig-a011-20200618
i386                 randconfig-a015-20200618
i386                 randconfig-a014-20200618
i386                 randconfig-a013-20200618
i386                 randconfig-a016-20200618
i386                 randconfig-a012-20200618
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
