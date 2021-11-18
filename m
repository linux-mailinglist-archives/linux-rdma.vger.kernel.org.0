Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C814557BF
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Nov 2021 10:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhKRJLS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Nov 2021 04:11:18 -0500
Received: from mga04.intel.com ([192.55.52.120]:20780 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229978AbhKRJKt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Nov 2021 04:10:49 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="232868728"
X-IronPort-AV: E=Sophos;i="5.87,244,1631602800"; 
   d="scan'208";a="232868728"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 01:07:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,244,1631602800"; 
   d="scan'208";a="550096730"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 18 Nov 2021 01:07:43 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mndOQ-0002rs-K3; Thu, 18 Nov 2021 09:07:42 +0000
Date:   Thu, 18 Nov 2021 17:06:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 a917dfb66c0a1fa1caacf3d71edcafcab48e6ff0
Message-ID: <619617a2.t6UGexTvUw4qXyqQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: a917dfb66c0a1fa1caacf3d71edcafcab48e6ff0  RDMA/bnxt_re: Scan the whole bitmap when checking if "disabling RCFW with pending cmd-bit"

elapsed time: 728m

configs tested: 200
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211118
i386                 randconfig-c001-20211117
sh                          rsk7269_defconfig
riscv                            alldefconfig
powerpc                     stx_gp3_defconfig
arc                     nsimosci_hs_defconfig
arm                         hackkit_defconfig
xtensa                    xip_kc705_defconfig
sh                        edosk7760_defconfig
arm                       aspeed_g5_defconfig
mips                         mpc30x_defconfig
arc                     haps_hs_smp_defconfig
arm                            hisi_defconfig
powerpc                      acadia_defconfig
openrisc                 simple_smp_defconfig
arm                           sunxi_defconfig
riscv                    nommu_k210_defconfig
arm                           sama7_defconfig
arm                        mvebu_v7_defconfig
sh                        sh7785lcr_defconfig
arm                      jornada720_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                    ge_imp3a_defconfig
sh                   secureedge5410_defconfig
mips                      loongson3_defconfig
i386                             alldefconfig
arm                         lpc18xx_defconfig
arm                         socfpga_defconfig
sh                             espt_defconfig
sh                            hp6xx_defconfig
mips                           ip22_defconfig
m68k                       m5475evb_defconfig
m68k                        m5307c3_defconfig
m68k                          amiga_defconfig
powerpc                      arches_defconfig
arm                      integrator_defconfig
m68k                                defconfig
powerpc                     akebono_defconfig
arm                     eseries_pxa_defconfig
arc                           tb10x_defconfig
powerpc                     kilauea_defconfig
powerpc                       holly_defconfig
xtensa                              defconfig
arm                            mps2_defconfig
arm                          collie_defconfig
sh                        edosk7705_defconfig
mips                  cavium_octeon_defconfig
mips                     cu1000-neo_defconfig
arm                       netwinder_defconfig
arm                  colibri_pxa270_defconfig
m68k                          hp300_defconfig
arm                       imx_v6_v7_defconfig
arm                             mxs_defconfig
ia64                          tiger_defconfig
sh                           se7343_defconfig
arm                           tegra_defconfig
powerpc                  mpc866_ads_defconfig
mips                           gcw0_defconfig
arm                   milbeaut_m10v_defconfig
arm                       spear13xx_defconfig
mips                           mtx1_defconfig
parisc                generic-64bit_defconfig
powerpc                     asp8347_defconfig
arm                           stm32_defconfig
arm                        magician_defconfig
arm                         assabet_defconfig
arm                  colibri_pxa300_defconfig
sh                           se7750_defconfig
m68k                       m5208evb_defconfig
powerpc                     ksi8560_defconfig
powerpc                      makalu_defconfig
mips                     cu1830-neo_defconfig
mips                         bigsur_defconfig
powerpc                      cm5200_defconfig
arm                          exynos_defconfig
mips                         tb0287_defconfig
powerpc64                           defconfig
arm                       versatile_defconfig
arm                            dove_defconfig
openrisc                         alldefconfig
powerpc                      mgcoge_defconfig
powerpc                    klondike_defconfig
xtensa                          iss_defconfig
arm                  randconfig-c002-20211117
arm                  randconfig-c002-20211118
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
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
x86_64               randconfig-a005-20211117
x86_64               randconfig-a003-20211117
x86_64               randconfig-a002-20211117
x86_64               randconfig-a001-20211117
x86_64               randconfig-a006-20211117
x86_64               randconfig-a004-20211117
i386                 randconfig-a006-20211117
i386                 randconfig-a003-20211117
i386                 randconfig-a005-20211117
i386                 randconfig-a001-20211117
i386                 randconfig-a004-20211117
i386                 randconfig-a002-20211117
x86_64               randconfig-a015-20211118
x86_64               randconfig-a012-20211118
x86_64               randconfig-a011-20211118
x86_64               randconfig-a013-20211118
x86_64               randconfig-a016-20211118
x86_64               randconfig-a014-20211118
i386                 randconfig-a016-20211118
i386                 randconfig-a014-20211118
i386                 randconfig-a012-20211118
i386                 randconfig-a011-20211118
i386                 randconfig-a013-20211118
i386                 randconfig-a015-20211118
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
i386                 randconfig-c001-20211118
x86_64               randconfig-c007-20211118
arm                  randconfig-c002-20211118
s390                 randconfig-c005-20211118
powerpc              randconfig-c003-20211118
riscv                randconfig-c006-20211118
mips                 randconfig-c004-20211118
x86_64               randconfig-c007-20211117
i386                 randconfig-c001-20211117
arm                  randconfig-c002-20211117
riscv                randconfig-c006-20211117
powerpc              randconfig-c003-20211117
s390                 randconfig-c005-20211117
mips                 randconfig-c004-20211117
x86_64               randconfig-a005-20211118
x86_64               randconfig-a003-20211118
x86_64               randconfig-a001-20211118
x86_64               randconfig-a002-20211118
x86_64               randconfig-a006-20211118
x86_64               randconfig-a004-20211118
i386                 randconfig-a006-20211118
i386                 randconfig-a003-20211118
i386                 randconfig-a001-20211118
i386                 randconfig-a005-20211118
i386                 randconfig-a004-20211118
i386                 randconfig-a002-20211118
x86_64               randconfig-a015-20211117
x86_64               randconfig-a013-20211117
x86_64               randconfig-a011-20211117
x86_64               randconfig-a012-20211117
x86_64               randconfig-a016-20211117
x86_64               randconfig-a014-20211117
i386                 randconfig-a014-20211117
i386                 randconfig-a016-20211117
i386                 randconfig-a012-20211117
i386                 randconfig-a013-20211117
i386                 randconfig-a011-20211117
i386                 randconfig-a015-20211117
hexagon              randconfig-r045-20211117
hexagon              randconfig-r041-20211117
s390                 randconfig-r044-20211117
riscv                randconfig-r042-20211117
hexagon              randconfig-r045-20211118
hexagon              randconfig-r041-20211118

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
