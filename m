Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C2F444D33
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Nov 2021 03:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhKDCJM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Nov 2021 22:09:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:18812 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230198AbhKDCJM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 3 Nov 2021 22:09:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="229088627"
X-IronPort-AV: E=Sophos;i="5.87,207,1631602800"; 
   d="scan'208";a="229088627"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 19:06:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,207,1631602800"; 
   d="scan'208";a="450037225"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 03 Nov 2021 19:06:32 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1miS9A-00060E-79; Thu, 04 Nov 2021 02:06:32 +0000
Date:   Thu, 04 Nov 2021 10:06:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 f1a090f09f42be5a5542009f0be310fdb3e768fc
Message-ID: <6183400d.est4R+RFEh/OSPyg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: f1a090f09f42be5a5542009f0be310fdb3e768fc  RDMA/core: Require the driver to set the IOVA correctly during rereg_mr

elapsed time: 729m

configs tested: 177
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211103
powerpc                   motionpro_defconfig
ia64                        generic_defconfig
powerpc                     tqm8560_defconfig
powerpc                    sam440ep_defconfig
m68k                          hp300_defconfig
m68k                            q40_defconfig
mips                         bigsur_defconfig
s390                                defconfig
h8300                            allyesconfig
sh                           se7750_defconfig
arm                            xcep_defconfig
arm                     eseries_pxa_defconfig
mips                        qi_lb60_defconfig
arm                           sama7_defconfig
powerpc                   microwatt_defconfig
sh                        sh7785lcr_defconfig
sh                          kfr2r09_defconfig
powerpc                      mgcoge_defconfig
arm                          exynos_defconfig
riscv                             allnoconfig
m68k                        stmark2_defconfig
m68k                       m5475evb_defconfig
mips                     loongson1b_defconfig
powerpc                        fsp2_defconfig
m68k                         amcore_defconfig
powerpc                      cm5200_defconfig
mips                         mpc30x_defconfig
powerpc                        icon_defconfig
sh                           se7721_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                         lpc18xx_defconfig
powerpc                    amigaone_defconfig
um                           x86_64_defconfig
arm                       multi_v4t_defconfig
sh                         ap325rxa_defconfig
powerpc                     sequoia_defconfig
h8300                    h8300h-sim_defconfig
arm                          pxa910_defconfig
powerpc                  iss476-smp_defconfig
sh                   sh7770_generic_defconfig
mips                          rb532_defconfig
arm                           h5000_defconfig
arm                        neponset_defconfig
ia64                             allmodconfig
powerpc                 mpc836x_rdk_defconfig
arm                       aspeed_g4_defconfig
mips                           mtx1_defconfig
powerpc                      acadia_defconfig
powerpc                          allyesconfig
sh                        edosk7760_defconfig
mips                malta_qemu_32r6_defconfig
sh                             espt_defconfig
sh                           se7712_defconfig
arc                              alldefconfig
arc                        nsimosci_defconfig
sh                               allmodconfig
openrisc                            defconfig
powerpc                      arches_defconfig
powerpc                     ppa8548_defconfig
nios2                         3c120_defconfig
arm64                            alldefconfig
arm                           stm32_defconfig
powerpc                     tqm8548_defconfig
sh                           se7780_defconfig
mips                           jazz_defconfig
arm                        mvebu_v7_defconfig
powerpc                      pmac32_defconfig
sh                     sh7710voipgw_defconfig
mips                           xway_defconfig
mips                     loongson1c_defconfig
mips                       capcella_defconfig
sparc                       sparc64_defconfig
arm                     am200epdkit_defconfig
arm                         bcm2835_defconfig
sh                             sh03_defconfig
arm                           tegra_defconfig
arm                        multi_v5_defconfig
arm                          simpad_defconfig
sh                         microdev_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                            shmin_defconfig
riscv                    nommu_k210_defconfig
arm                        mvebu_v5_defconfig
openrisc                  or1klitex_defconfig
powerpc                     pq2fads_defconfig
nios2                         10m50_defconfig
powerpc                      ppc6xx_defconfig
mips                      maltasmvp_defconfig
arm                         axm55xx_defconfig
powerpc                   lite5200b_defconfig
powerpc                         ps3_defconfig
mips                      bmips_stb_defconfig
arm                            dove_defconfig
powerpc                     tqm8540_defconfig
arm                     davinci_all_defconfig
xtensa                    smp_lx200_defconfig
arm                   milbeaut_m10v_defconfig
mips                          ath79_defconfig
mips                     loongson2k_defconfig
arm                  randconfig-c002-20211103
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc                           allyesconfig
s390                             allyesconfig
s390                             allmodconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64               randconfig-a012-20211103
x86_64               randconfig-a015-20211103
x86_64               randconfig-a016-20211103
x86_64               randconfig-a011-20211103
x86_64               randconfig-a013-20211103
x86_64               randconfig-a014-20211103
i386                 randconfig-a014-20211103
i386                 randconfig-a016-20211103
i386                 randconfig-a013-20211103
i386                 randconfig-a015-20211103
i386                 randconfig-a011-20211103
i386                 randconfig-a012-20211103
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
mips                 randconfig-c004-20211103
arm                  randconfig-c002-20211103
i386                 randconfig-c001-20211103
s390                 randconfig-c005-20211103
powerpc              randconfig-c003-20211103
riscv                randconfig-c006-20211103
x86_64               randconfig-c007-20211103
x86_64               randconfig-a006-20211103
x86_64               randconfig-a004-20211103
x86_64               randconfig-a001-20211103
x86_64               randconfig-a002-20211103
x86_64               randconfig-a005-20211103
x86_64               randconfig-a003-20211103
i386                 randconfig-a005-20211103
i386                 randconfig-a003-20211103
i386                 randconfig-a001-20211103
i386                 randconfig-a004-20211103
i386                 randconfig-a006-20211103
i386                 randconfig-a002-20211103
hexagon              randconfig-r041-20211103
hexagon              randconfig-r045-20211103

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
