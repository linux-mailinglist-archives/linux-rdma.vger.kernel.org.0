Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A8544277F
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Nov 2021 08:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhKBHJE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Nov 2021 03:09:04 -0400
Received: from mga07.intel.com ([134.134.136.100]:15613 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230508AbhKBHJD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 2 Nov 2021 03:09:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10155"; a="294653929"
X-IronPort-AV: E=Sophos;i="5.87,202,1631602800"; 
   d="scan'208";a="294653929"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 00:06:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,202,1631602800"; 
   d="scan'208";a="467578905"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 02 Nov 2021 00:06:24 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mhnsF-000468-IW; Tue, 02 Nov 2021 07:06:23 +0000
Date:   Tue, 02 Nov 2021 15:05:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 6a463bc9d9997818a2df26c54319dc3a33c7ce38
Message-ID: <6180e33b./Gk9iYOLu/vRm8uU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 6a463bc9d9997818a2df26c54319dc3a33c7ce38  Merge branch 'for-rc' into rdma.git for-next

elapsed time: 720m

configs tested: 107
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       aspeed_g5_defconfig
arm                       netwinder_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                   sb1250_swarm_defconfig
powerpc                   bluestone_defconfig
arm                          moxart_defconfig
powerpc                    sam440ep_defconfig
arm                        shmobile_defconfig
m68k                          atari_defconfig
arm                            mmp2_defconfig
mips                        jmr3927_defconfig
arm                             ezx_defconfig
arm                         cm_x300_defconfig
powerpc                 linkstation_defconfig
sh                           se7712_defconfig
mips                          ath79_defconfig
sh                           se7705_defconfig
powerpc                      tqm8xx_defconfig
m68k                       m5475evb_defconfig
powerpc                      cm5200_defconfig
arm                        mvebu_v5_defconfig
microblaze                      mmu_defconfig
mips                     decstation_defconfig
arm                          ep93xx_defconfig
powerpc                   microwatt_defconfig
s390                             alldefconfig
arm                         orion5x_defconfig
arm                  randconfig-c002-20211101
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a012-20211101
x86_64               randconfig-a015-20211101
x86_64               randconfig-a016-20211101
x86_64               randconfig-a013-20211101
x86_64               randconfig-a011-20211101
x86_64               randconfig-a014-20211101
i386                 randconfig-a016-20211101
i386                 randconfig-a014-20211101
i386                 randconfig-a015-20211101
i386                 randconfig-a013-20211101
i386                 randconfig-a011-20211101
i386                 randconfig-a012-20211101
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20211101
x86_64               randconfig-a006-20211101
x86_64               randconfig-a001-20211101
x86_64               randconfig-a002-20211101
x86_64               randconfig-a003-20211101
x86_64               randconfig-a005-20211101
i386                 randconfig-a005-20211101
i386                 randconfig-a001-20211101
i386                 randconfig-a003-20211101
i386                 randconfig-a004-20211101
i386                 randconfig-a006-20211101
i386                 randconfig-a002-20211101
hexagon              randconfig-r041-20211101
hexagon              randconfig-r045-20211101

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
