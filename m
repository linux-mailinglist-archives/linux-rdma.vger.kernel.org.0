Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358D02108F8
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2020 12:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbgGAKKY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Jul 2020 06:10:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:64731 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729358AbgGAKKY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 1 Jul 2020 06:10:24 -0400
IronPort-SDR: Sbl9mD7eaL/AcP16Nf/VeiJBhaS+vQ1X/4VG2X2GZt3UmfRBPHhGljcdnr9PcXA2ZQbL6LzuRS
 OEb9IZQw2kbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="231402880"
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="231402880"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 03:10:23 -0700
IronPort-SDR: 4pOyfg+JjmSZelxJtmtI4zfXdmZsf2VyGaynrzUah5nwRIgDVhnhbfFdT7Qy7canfIdXGyGxjl
 PsO9nh15bMSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="386967267"
Received: from lkp-server01.sh.intel.com (HELO 28879958b202) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 01 Jul 2020 03:10:22 -0700
Received: from kbuild by 28879958b202 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jqZh7-0002ve-BJ; Wed, 01 Jul 2020 10:10:21 +0000
Date:   Wed, 01 Jul 2020 18:09:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS WITH WARNING
 c4334a99d3d6d8e2d1aa97655f44f637f17a3a11
Message-ID: <5efc60cd.Ltpyw3g8rPWHUuqU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: c4334a99d3d6d8e2d1aa97655f44f637f17a3a11  IB/hfi1: Convert PCIBIOS_* errors to generic -E* errors

Warning in current branch:

drivers/infiniband/core/cm.c:2065:12: sparse: sparse: context imbalance in 'cm_req_handler' - different lock contexts for basic block
drivers/infiniband/core/cm.c:2584:12: sparse: sparse: context imbalance in 'cm_rtu_handler' - different lock contexts for basic block
drivers/infiniband/core/cm.c:3382:12: sparse: sparse: context imbalance in 'cm_apr_handler' - different lock contexts for basic block
drivers/infiniband/core/cm.c:3427:12: sparse: sparse: context imbalance in 'cm_timewait_handler' - different lock contexts for basic block

Warning ids grouped by kconfigs:

recent_errors
`-- i386-randconfig-s002-20200630
    |-- drivers-infiniband-core-cm.c:sparse:sparse:context-imbalance-in-cm_apr_handler-different-lock-contexts-for-basic-block
    |-- drivers-infiniband-core-cm.c:sparse:sparse:context-imbalance-in-cm_req_handler-different-lock-contexts-for-basic-block
    |-- drivers-infiniband-core-cm.c:sparse:sparse:context-imbalance-in-cm_rtu_handler-different-lock-contexts-for-basic-block
    `-- drivers-infiniband-core-cm.c:sparse:sparse:context-imbalance-in-cm_timewait_handler-different-lock-contexts-for-basic-block

elapsed time: 1056m

configs tested: 103
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
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20200701
i386                 randconfig-a001-20200701
i386                 randconfig-a006-20200701
i386                 randconfig-a005-20200701
i386                 randconfig-a004-20200701
i386                 randconfig-a003-20200701
x86_64               randconfig-a011-20200630
x86_64               randconfig-a014-20200630
x86_64               randconfig-a013-20200630
x86_64               randconfig-a015-20200630
x86_64               randconfig-a016-20200630
x86_64               randconfig-a012-20200630
i386                 randconfig-a011-20200630
i386                 randconfig-a016-20200630
i386                 randconfig-a015-20200630
i386                 randconfig-a012-20200630
i386                 randconfig-a014-20200630
i386                 randconfig-a013-20200630
i386                 randconfig-a011-20200701
i386                 randconfig-a015-20200701
i386                 randconfig-a016-20200701
i386                 randconfig-a012-20200701
i386                 randconfig-a013-20200701
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
