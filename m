Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCF12D27B7
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Dec 2020 10:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgLHJcK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Dec 2020 04:32:10 -0500
Received: from mga12.intel.com ([192.55.52.136]:18651 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727728AbgLHJcI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Dec 2020 04:32:08 -0500
IronPort-SDR: SGCAREeqbnRitne2O0/j1NiEj/2Rz0THixayS/1kCsarpWUxMYoqyxFz75yKXh/zNsyyztYkuI
 7zdiODbrFh9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="153099797"
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="153099797"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 01:31:26 -0800
IronPort-SDR: oULJXzDBH9ftkr6RuM3UkYfDxVHnxeBdx8qXpAL/nXuDQ1uHtbR496tKAFpEaCLCnfroAf7pTy
 ZviafRYyGUeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="375865292"
Received: from lkp-server01.sh.intel.com (HELO c88bd47c8831) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Dec 2020 01:30:18 -0800
Received: from kbuild by c88bd47c8831 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kmZK5-00007f-UJ; Tue, 08 Dec 2020 09:30:17 +0000
Date:   Tue, 08 Dec 2020 17:30:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 e432c04c17993011b2a2f59dcb5738e604bd552e
Message-ID: <5fcf47a5.pDDpJ5n00+BXDo6s%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-rc
branch HEAD: e432c04c17993011b2a2f59dcb5738e604bd552e  RDMA/core: Fix empty gid table for non IB/RoCE devices

elapsed time: 733m

configs tested: 136
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      walnut_defconfig
arm                         palmz72_defconfig
arm                          simpad_defconfig
powerpc                    ge_imp3a_defconfig
arm                          ep93xx_defconfig
sh                           se7780_defconfig
powerpc                     tqm8555_defconfig
arc                          axs103_defconfig
powerpc                  mpc885_ads_defconfig
mips                           ip28_defconfig
powerpc                     pq2fads_defconfig
powerpc                 mpc832x_rdb_defconfig
c6x                         dsk6455_defconfig
m68k                        m5272c3_defconfig
m68k                          hp300_defconfig
s390                          debug_defconfig
arm                             ezx_defconfig
mips                            gpr_defconfig
microblaze                          defconfig
microblaze                    nommu_defconfig
powerpc                   motionpro_defconfig
arm                       imx_v4_v5_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                         wii_defconfig
mips                         cobalt_defconfig
m68k                        stmark2_defconfig
powerpc                 mpc836x_rdk_defconfig
arc                          axs101_defconfig
h8300                     edosk2674_defconfig
sh                          urquell_defconfig
xtensa                           alldefconfig
sh                     sh7710voipgw_defconfig
powerpc                          allyesconfig
mips                          rm200_defconfig
arm                          ixp4xx_defconfig
sh                           se7619_defconfig
arm                      jornada720_defconfig
powerpc                     mpc5200_defconfig
sh                          landisk_defconfig
alpha                            alldefconfig
openrisc                            defconfig
powerpc                      ppc40x_defconfig
arm                       omap2plus_defconfig
arm                         lpc18xx_defconfig
sh                          sdk7780_defconfig
m68k                       m5275evb_defconfig
mips                         tb0287_defconfig
m68k                             alldefconfig
arm                           omap1_defconfig
um                            kunit_defconfig
xtensa                    xip_kc705_defconfig
m68k                       m5475evb_defconfig
mips                malta_qemu_32r6_defconfig
m68k                       m5249evb_defconfig
powerpc                     kilauea_defconfig
sh                   sh7770_generic_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201208
i386                 randconfig-a005-20201208
i386                 randconfig-a001-20201208
i386                 randconfig-a002-20201208
i386                 randconfig-a006-20201208
i386                 randconfig-a003-20201208
i386                 randconfig-a005-20201207
i386                 randconfig-a004-20201207
i386                 randconfig-a001-20201207
i386                 randconfig-a002-20201207
i386                 randconfig-a006-20201207
i386                 randconfig-a003-20201207
x86_64               randconfig-a016-20201207
x86_64               randconfig-a012-20201207
x86_64               randconfig-a014-20201207
x86_64               randconfig-a013-20201207
x86_64               randconfig-a015-20201207
x86_64               randconfig-a011-20201207
i386                 randconfig-a014-20201207
i386                 randconfig-a013-20201207
i386                 randconfig-a011-20201207
i386                 randconfig-a015-20201207
i386                 randconfig-a012-20201207
i386                 randconfig-a016-20201207
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201207
x86_64               randconfig-a006-20201207
x86_64               randconfig-a002-20201207
x86_64               randconfig-a001-20201207
x86_64               randconfig-a005-20201207
x86_64               randconfig-a003-20201207

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
