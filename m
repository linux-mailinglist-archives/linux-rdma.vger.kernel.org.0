Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAA5440CB6
	for <lists+linux-rdma@lfdr.de>; Sun, 31 Oct 2021 05:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbhJaEYl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 31 Oct 2021 00:24:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:18769 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229620AbhJaEYk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 31 Oct 2021 00:24:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10153"; a="317055067"
X-IronPort-AV: E=Sophos;i="5.87,196,1631602800"; 
   d="scan'208";a="317055067"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2021 21:22:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,196,1631602800"; 
   d="scan'208";a="488169477"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 30 Oct 2021 21:22:06 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mh2M9-00026D-KZ; Sun, 31 Oct 2021 04:22:05 +0000
Date:   Sun, 31 Oct 2021 12:21:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-rc] BUILD SUCCESS
 4f960393a0ee9a39469ceb7c8077ae8db665cc12
Message-ID: <617e19d2.5TIQZoymCqKvVJGG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: 4f960393a0ee9a39469ceb7c8077ae8db665cc12  RDMA/qedr: Fix NULL deref for query_qp on the GSI QP

elapsed time: 2168m

configs tested: 320
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
i386                 randconfig-c001-20211028
powerpc              randconfig-c003-20211028
s390                       zfcpdump_defconfig
powerpc                 mpc8272_ads_defconfig
arc                              alldefconfig
sh                            shmin_defconfig
powerpc                 canyonlands_defconfig
mips                        vocore2_defconfig
sh                          landisk_defconfig
um                           x86_64_defconfig
sh                           se7751_defconfig
arm                          exynos_defconfig
m68k                          multi_defconfig
mips                         tb0287_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                        m5407c3_defconfig
arc                        nsimosci_defconfig
sh                           se7721_defconfig
arm                           corgi_defconfig
arm                     am200epdkit_defconfig
powerpc                     mpc83xx_defconfig
xtensa                  cadence_csp_defconfig
powerpc               mpc834x_itxgp_defconfig
m68k                         amcore_defconfig
sh                        apsh4ad0a_defconfig
arm                        magician_defconfig
mips                   sb1250_swarm_defconfig
arm                         vf610m4_defconfig
powerpc                     skiroot_defconfig
powerpc                     ksi8560_defconfig
mips                      maltasmvp_defconfig
h8300                            alldefconfig
arm                       imx_v4_v5_defconfig
mips                        workpad_defconfig
x86_64                           allyesconfig
arc                         haps_hs_defconfig
mips                           ip32_defconfig
arm                          badge4_defconfig
arm                            lart_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                      loongson3_defconfig
arm                            mps2_defconfig
sh                      rts7751r2d1_defconfig
sh                           se7206_defconfig
powerpc                     mpc512x_defconfig
sh                           se7780_defconfig
arm                       omap2plus_defconfig
powerpc                     redwood_defconfig
m68k                          atari_defconfig
mips                        jmr3927_defconfig
mips                     loongson1b_defconfig
arc                        nsim_700_defconfig
mips                            e55_defconfig
xtensa                generic_kc705_defconfig
powerpc                     pq2fads_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                        edosk7760_defconfig
sh                   sh7770_generic_defconfig
arm                    vt8500_v6_v7_defconfig
openrisc                         alldefconfig
arm                         bcm2835_defconfig
sh                          kfr2r09_defconfig
parisc                generic-32bit_defconfig
sh                             shx3_defconfig
powerpc                      pasemi_defconfig
powerpc                      arches_defconfig
arm                           sama7_defconfig
sparc                       sparc64_defconfig
arc                     nsimosci_hs_defconfig
mips                      fuloong2e_defconfig
arm                           h3600_defconfig
arm                         s5pv210_defconfig
s390                             alldefconfig
arm                             pxa_defconfig
powerpc                    klondike_defconfig
arm                       netwinder_defconfig
powerpc                   microwatt_defconfig
powerpc                        cell_defconfig
riscv                    nommu_k210_defconfig
m68k                       m5475evb_defconfig
sh                           se7724_defconfig
powerpc                    mvme5100_defconfig
m68k                        mvme147_defconfig
h8300                     edosk2674_defconfig
powerpc                   lite5200b_defconfig
riscv                    nommu_virt_defconfig
xtensa                              defconfig
arm                          pxa168_defconfig
riscv                          rv32_defconfig
sh                 kfr2r09-romimage_defconfig
sh                         apsh4a3a_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                          lboxre2_defconfig
arm                       imx_v6_v7_defconfig
powerpc                          g5_defconfig
ia64                            zx1_defconfig
xtensa                  nommu_kc705_defconfig
arm                         hackkit_defconfig
um                             i386_defconfig
arm                           omap1_defconfig
powerpc                       maple_defconfig
m68k                       m5249evb_defconfig
arm                            dove_defconfig
arm                          pxa910_defconfig
arm                            xcep_defconfig
mips                       capcella_defconfig
mips                        bcm63xx_defconfig
powerpc                 mpc836x_rdk_defconfig
m68k                            mac_defconfig
um                               alldefconfig
xtensa                    xip_kc705_defconfig
mips                         bigsur_defconfig
sh                   secureedge5410_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                          polaris_defconfig
mips                          rm200_defconfig
mips                malta_qemu_32r6_defconfig
arm                         shannon_defconfig
nios2                         10m50_defconfig
arm64                            alldefconfig
powerpc                        warp_defconfig
mips                          ath25_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                        omega2p_defconfig
arm                          pcm027_defconfig
arm                        realview_defconfig
sh                         ecovec24_defconfig
powerpc                     tqm8541_defconfig
sh                          rsk7269_defconfig
sh                               j2_defconfig
arm                        multi_v5_defconfig
mips                             allyesconfig
nds32                             allnoconfig
arc                           tb10x_defconfig
mips                          rb532_defconfig
sparc                       sparc32_defconfig
powerpc                     powernv_defconfig
powerpc                 mpc8560_ads_defconfig
arm                           stm32_defconfig
microblaze                      mmu_defconfig
openrisc                  or1klitex_defconfig
sh                           sh2007_defconfig
arm                          ixp4xx_defconfig
powerpc                  iss476-smp_defconfig
xtensa                    smp_lx200_defconfig
powerpc                      katmai_defconfig
arm                        oxnas_v6_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                      ppc64e_defconfig
microblaze                          defconfig
sh                        edosk7705_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                         db1xxx_defconfig
sh                          r7785rp_defconfig
ia64                             alldefconfig
sh                          urquell_defconfig
arm                           h5000_defconfig
mips                            gpr_defconfig
arm                        spear6xx_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                    socrates_defconfig
powerpc                     tqm8548_defconfig
s390                          debug_defconfig
m68k                          amiga_defconfig
sh                        sh7763rdp_defconfig
powerpc                     tqm8560_defconfig
mips                       lemote2f_defconfig
arm                     eseries_pxa_defconfig
arm                      footbridge_defconfig
mips                         tb0219_defconfig
arc                                 defconfig
arm                           sama5_defconfig
arm                  randconfig-c002-20211031
arm                  randconfig-c002-20211028
arm                  randconfig-c002-20211029
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                              allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
xtensa                           allyesconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                              defconfig
s390                                defconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20211028
x86_64               randconfig-a004-20211028
x86_64               randconfig-a005-20211028
x86_64               randconfig-a001-20211028
x86_64               randconfig-a006-20211028
x86_64               randconfig-a003-20211028
x86_64               randconfig-a005-20211031
x86_64               randconfig-a004-20211031
x86_64               randconfig-a002-20211031
x86_64               randconfig-a003-20211031
x86_64               randconfig-a001-20211031
x86_64               randconfig-a006-20211031
i386                 randconfig-a004-20211028
i386                 randconfig-a003-20211028
i386                 randconfig-a002-20211028
i386                 randconfig-a006-20211028
i386                 randconfig-a001-20211028
i386                 randconfig-a005-20211028
i386                 randconfig-a003-20211031
i386                 randconfig-a006-20211031
i386                 randconfig-a002-20211031
i386                 randconfig-a005-20211031
i386                 randconfig-a001-20211031
i386                 randconfig-a004-20211031
x86_64               randconfig-a015-20211029
x86_64               randconfig-a013-20211029
x86_64               randconfig-a011-20211029
x86_64               randconfig-a014-20211029
x86_64               randconfig-a012-20211029
x86_64               randconfig-a016-20211029
i386                 randconfig-a012-20211029
i386                 randconfig-a013-20211029
i386                 randconfig-a011-20211029
i386                 randconfig-a015-20211029
i386                 randconfig-a016-20211029
i386                 randconfig-a014-20211029
arc                  randconfig-r043-20211031
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20211028
powerpc              randconfig-c003-20211028
riscv                randconfig-c006-20211028
x86_64               randconfig-c007-20211028
mips                 randconfig-c004-20211028
s390                 randconfig-c005-20211028
i386                 randconfig-c001-20211028
powerpc              randconfig-c003-20211031
riscv                randconfig-c006-20211031
x86_64               randconfig-c007-20211031
mips                 randconfig-c004-20211031
s390                 randconfig-c005-20211031
arm                  randconfig-c002-20211031
i386                 randconfig-c001-20211031
arm                  randconfig-c002-20211029
powerpc              randconfig-c003-20211029
riscv                randconfig-c006-20211029
x86_64               randconfig-c007-20211029
mips                 randconfig-c004-20211029
s390                 randconfig-c005-20211029
i386                 randconfig-c001-20211029
x86_64               randconfig-a005-20211030
x86_64               randconfig-a004-20211030
x86_64               randconfig-a002-20211030
x86_64               randconfig-a003-20211030
x86_64               randconfig-a001-20211030
x86_64               randconfig-a006-20211030
x86_64               randconfig-a002-20211029
x86_64               randconfig-a004-20211029
x86_64               randconfig-a005-20211029
x86_64               randconfig-a001-20211029
x86_64               randconfig-a006-20211029
x86_64               randconfig-a003-20211029
i386                 randconfig-a004-20211029
i386                 randconfig-a003-20211029
i386                 randconfig-a002-20211029
i386                 randconfig-a001-20211029
i386                 randconfig-a006-20211029
i386                 randconfig-a005-20211029
x86_64               randconfig-a013-20211031
x86_64               randconfig-a015-20211031
x86_64               randconfig-a014-20211031
x86_64               randconfig-a011-20211031
x86_64               randconfig-a016-20211031
x86_64               randconfig-a012-20211031
x86_64               randconfig-a015-20211028
x86_64               randconfig-a013-20211028
x86_64               randconfig-a011-20211028
x86_64               randconfig-a014-20211028
x86_64               randconfig-a012-20211028
x86_64               randconfig-a016-20211028
i386                 randconfig-a013-20211031
i386                 randconfig-a012-20211031
i386                 randconfig-a014-20211031
i386                 randconfig-a015-20211031
i386                 randconfig-a011-20211031
i386                 randconfig-a016-20211031
i386                 randconfig-a012-20211028
i386                 randconfig-a013-20211028
i386                 randconfig-a011-20211028
i386                 randconfig-a015-20211028
i386                 randconfig-a016-20211028
i386                 randconfig-a014-20211028
hexagon              randconfig-r045-20211028
riscv                randconfig-r042-20211028
s390                 randconfig-r044-20211028
hexagon              randconfig-r041-20211028
hexagon              randconfig-r045-20211029
hexagon              randconfig-r041-20211029

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
