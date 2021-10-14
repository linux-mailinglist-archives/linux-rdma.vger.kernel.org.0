Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2985942E0E6
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Oct 2021 20:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbhJNSOr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Oct 2021 14:14:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:6382 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230434AbhJNSOr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 14 Oct 2021 14:14:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="208560077"
X-IronPort-AV: E=Sophos;i="5.85,373,1624345200"; 
   d="scan'208";a="208560077"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 11:12:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,373,1624345200"; 
   d="scan'208";a="592714989"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 14 Oct 2021 11:12:40 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mb5Db-0006Ur-Q7; Thu, 14 Oct 2021 18:12:39 +0000
Date:   Fri, 15 Oct 2021 02:12:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 663991f32857b3b63c94c97de9dbb0ec8600144f
Message-ID: <61687307.ju6L3s0Iwg2FNbeZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-rc
branch HEAD: 663991f32857b3b63c94c97de9dbb0ec8600144f  RDMA/rdmavt: Fix error code in rvt_create_qp()

elapsed time: 1422m

configs tested: 238
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211013
i386                 randconfig-c001-20211014
sh                         microdev_defconfig
powerpc                   lite5200b_defconfig
powerpc                      cm5200_defconfig
powerpc                  iss476-smp_defconfig
powerpc                     akebono_defconfig
mips                         tb0226_defconfig
mips                        nlm_xlr_defconfig
sh                             shx3_defconfig
sh                           se7705_defconfig
powerpc                      chrp32_defconfig
mips                      pic32mzda_defconfig
arm                         orion5x_defconfig
arm                       aspeed_g5_defconfig
sh                          sdk7786_defconfig
sparc                            alldefconfig
ia64                         bigsur_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                   sh7724_generic_defconfig
arm                           spitz_defconfig
arm                       multi_v4t_defconfig
xtensa                           alldefconfig
sh                          polaris_defconfig
powerpc                     rainier_defconfig
arm                             ezx_defconfig
s390                             alldefconfig
mips                 decstation_r4k_defconfig
arm                          collie_defconfig
arm                       omap2plus_defconfig
mips                        bcm47xx_defconfig
arm                        multi_v5_defconfig
arm                      jornada720_defconfig
powerpc                     mpc5200_defconfig
arm                          iop32x_defconfig
powerpc                      ppc40x_defconfig
ia64                      gensparse_defconfig
arm                        shmobile_defconfig
powerpc                      mgcoge_defconfig
arm                        spear6xx_defconfig
mips                          ath79_defconfig
arm                      integrator_defconfig
xtensa                    xip_kc705_defconfig
mips                      maltaaprp_defconfig
powerpc                         ps3_defconfig
powerpc                 mpc8560_ads_defconfig
arm                        vexpress_defconfig
powerpc                 mpc837x_mds_defconfig
um                             i386_defconfig
csky                                defconfig
powerpc               mpc834x_itxgp_defconfig
m68k                          amiga_defconfig
mips                           xway_defconfig
m68k                         amcore_defconfig
arm                        mini2440_defconfig
mips                         tb0287_defconfig
sh                      rts7751r2d1_defconfig
powerpc                      pasemi_defconfig
mips                         bigsur_defconfig
xtensa                    smp_lx200_defconfig
m68k                           sun3_defconfig
arm                         cm_x300_defconfig
arm                         lubbock_defconfig
arm                         palmz72_defconfig
mips                            gpr_defconfig
um                                  defconfig
parisc                generic-32bit_defconfig
powerpc                       eiger_defconfig
mips                            e55_defconfig
ia64                             alldefconfig
arm                       aspeed_g4_defconfig
arm                     eseries_pxa_defconfig
mips                        omega2p_defconfig
powerpc                 mpc836x_mds_defconfig
arc                        vdk_hs38_defconfig
powerpc                 mpc8272_ads_defconfig
arm64                            alldefconfig
sh                        sh7757lcr_defconfig
arm                         shannon_defconfig
alpha                            allyesconfig
powerpc                   currituck_defconfig
arm                         s3c6400_defconfig
powerpc                    klondike_defconfig
arm                        magician_defconfig
mips                           ip32_defconfig
powerpc                    amigaone_defconfig
parisc                              defconfig
powerpc                      arches_defconfig
sparc                       sparc32_defconfig
sh                           se7750_defconfig
arc                      axs103_smp_defconfig
sh                          r7780mp_defconfig
sh                           se7751_defconfig
m68k                             alldefconfig
mips                         tb0219_defconfig
sh                          urquell_defconfig
arm                        mvebu_v5_defconfig
powerpc                 mpc8315_rdb_defconfig
nds32                               defconfig
arm                         lpc18xx_defconfig
sh                          landisk_defconfig
powerpc                 xes_mpc85xx_defconfig
m68k                       m5475evb_defconfig
m68k                        mvme147_defconfig
mips                malta_qemu_32r6_defconfig
mips                         mpc30x_defconfig
arm                         vf610m4_defconfig
x86_64                              defconfig
sh                           sh2007_defconfig
powerpc                     skiroot_defconfig
powerpc                      ppc64e_defconfig
powerpc                 canyonlands_defconfig
mips                        bcm63xx_defconfig
sh                           se7780_defconfig
powerpc                      pmac32_defconfig
sh                             sh03_defconfig
powerpc                     ep8248e_defconfig
m68k                       m5249evb_defconfig
m68k                        m5307c3_defconfig
m68k                       m5208evb_defconfig
arm                        mvebu_v7_defconfig
powerpc                    gamecube_defconfig
arm                          ixp4xx_defconfig
powerpc                     stx_gp3_defconfig
powerpc                   motionpro_defconfig
arm                          pcm027_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                  randconfig-c002-20211013
x86_64               randconfig-c001-20211013
arm                  randconfig-c002-20211014
x86_64               randconfig-c001-20211014
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
alpha                               defconfig
nios2                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
s390                                defconfig
parisc                           allyesconfig
s390                             allyesconfig
s390                             allmodconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211014
x86_64               randconfig-a004-20211014
x86_64               randconfig-a001-20211014
x86_64               randconfig-a005-20211014
x86_64               randconfig-a002-20211014
x86_64               randconfig-a003-20211014
i386                 randconfig-a003-20211014
i386                 randconfig-a001-20211014
i386                 randconfig-a005-20211014
i386                 randconfig-a004-20211014
i386                 randconfig-a002-20211014
i386                 randconfig-a006-20211014
x86_64               randconfig-a015-20211013
x86_64               randconfig-a012-20211013
x86_64               randconfig-a016-20211013
x86_64               randconfig-a014-20211013
x86_64               randconfig-a013-20211013
x86_64               randconfig-a011-20211013
i386                 randconfig-a016-20211013
i386                 randconfig-a014-20211013
i386                 randconfig-a011-20211013
i386                 randconfig-a015-20211013
i386                 randconfig-a012-20211013
i386                 randconfig-a013-20211013
arc                  randconfig-r043-20211014
arc                  randconfig-r043-20211013
s390                 randconfig-r044-20211013
riscv                randconfig-r042-20211013
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
arm                  randconfig-c002-20211014
i386                 randconfig-c001-20211014
s390                 randconfig-c005-20211014
x86_64               randconfig-c007-20211014
powerpc              randconfig-c003-20211014
riscv                randconfig-c006-20211014
x86_64               randconfig-a004-20211013
x86_64               randconfig-a006-20211013
x86_64               randconfig-a001-20211013
x86_64               randconfig-a005-20211013
x86_64               randconfig-a002-20211013
x86_64               randconfig-a003-20211013
i386                 randconfig-a001-20211013
i386                 randconfig-a003-20211013
i386                 randconfig-a004-20211013
i386                 randconfig-a005-20211013
i386                 randconfig-a002-20211013
i386                 randconfig-a006-20211013
x86_64               randconfig-a012-20211014
x86_64               randconfig-a015-20211014
x86_64               randconfig-a016-20211014
x86_64               randconfig-a014-20211014
x86_64               randconfig-a011-20211014
x86_64               randconfig-a013-20211014
i386                 randconfig-a016-20211014
i386                 randconfig-a014-20211014
i386                 randconfig-a011-20211014
i386                 randconfig-a015-20211014
i386                 randconfig-a012-20211014
i386                 randconfig-a013-20211014
hexagon              randconfig-r041-20211014
s390                 randconfig-r044-20211014
riscv                randconfig-r042-20211014
hexagon              randconfig-r045-20211014
hexagon              randconfig-r041-20211013
hexagon              randconfig-r045-20211013

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
