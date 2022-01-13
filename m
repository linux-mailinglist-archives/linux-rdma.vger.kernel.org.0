Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A9F48D108
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jan 2022 04:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbiAMDno (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jan 2022 22:43:44 -0500
Received: from mga02.intel.com ([134.134.136.20]:41506 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232274AbiAMDnd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Jan 2022 22:43:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642045413; x=1673581413;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ZE2MCODYH2KTPyC0BjmO1A6kXFK08CnDRl2j1tFiwAA=;
  b=nC5es5cENv6jGNyM2iKdukIf8S8173bwRzJo7FLOMNHc4bfeQ7edXG90
   ca4NICUoIKQufJc9ZeLY8wcy8ZSzRjDGgmXkxAxn9vX+9EgNwk7z4DjI4
   w1cAkRts9ZYmwsveEKs1Fpfgly1leLczX4msx4LW6kjIhlKgluUjduOgm
   XmkTGllcDriCMMWJq9eW9GiV6frfw4kjLzJ3URdLM3MVZzjNA5xTH53F4
   Chdt8cqIQQ7Bgix47SNVhetG8O0c2mWheHWsvZC/9i255DmeqCmoMCIIC
   Lg/Pc092u7mBZ6yxS9z4MW2fFyyHmI/w7Cr2/++1URk5Mya2+d469eRq1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="231267094"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="231267094"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 19:43:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="691649530"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 12 Jan 2022 19:43:31 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7r1O-0006nJ-CS; Thu, 13 Jan 2022 03:43:30 +0000
Date:   Thu, 13 Jan 2022 11:43:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 c40238e3b8c98993e3c70057f6099e24cc2380f7
Message-ID: <61df9fd5.Pb4pwZuUL3cgzUjA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: c40238e3b8c98993e3c70057f6099e24cc2380f7  RDMA/irdma: Remove the redundant return

elapsed time: 3503m

configs tested: 278
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220111
mips                 randconfig-c004-20220112
powerpc                     tqm8541_defconfig
nios2                            allyesconfig
powerpc                      ppc40x_defconfig
m68k                        stmark2_defconfig
sh                           se7721_defconfig
sh                           se7750_defconfig
arm                          badge4_defconfig
m68k                           sun3_defconfig
arm                         cm_x300_defconfig
csky                             alldefconfig
powerpc                      ppc6xx_defconfig
powerpc                         wii_defconfig
arm                           u8500_defconfig
nds32                               defconfig
m68k                       m5249evb_defconfig
h8300                               defconfig
mips                      loongson3_defconfig
microblaze                          defconfig
mips                        vocore2_defconfig
xtensa                  nommu_kc705_defconfig
nios2                               defconfig
sh                          sdk7780_defconfig
m68k                        mvme16x_defconfig
arm                        cerfcube_defconfig
m68k                          hp300_defconfig
arm                         axm55xx_defconfig
um                             i386_defconfig
sparc                            alldefconfig
arm                           stm32_defconfig
m68k                             alldefconfig
ia64                        generic_defconfig
ia64                         bigsur_defconfig
sh                     magicpanelr2_defconfig
arm                            pleb_defconfig
sh                          r7785rp_defconfig
arc                    vdk_hs38_smp_defconfig
mips                      fuloong2e_defconfig
powerpc                       ppc64_defconfig
powerpc                     taishan_defconfig
sh                           se7780_defconfig
sparc                            allyesconfig
xtensa                    smp_lx200_defconfig
arm                      footbridge_defconfig
sh                         ecovec24_defconfig
mips                  maltasmvp_eva_defconfig
sh                                  defconfig
powerpc                      ep88xc_defconfig
arm                        mini2440_defconfig
sh                            migor_defconfig
m68k                                defconfig
powerpc                      mgcoge_defconfig
s390                          debug_defconfig
arc                              allyesconfig
arm                       multi_v4t_defconfig
arm                           viper_defconfig
nios2                         3c120_defconfig
powerpc                      bamboo_defconfig
arm                        multi_v7_defconfig
powerpc                    klondike_defconfig
powerpc                 mpc834x_itx_defconfig
m68k                       bvme6000_defconfig
sh                        apsh4ad0a_defconfig
sh                              ul2_defconfig
arm                        realview_defconfig
powerpc                       holly_defconfig
powerpc                  storcenter_defconfig
arm                         assabet_defconfig
sh                          polaris_defconfig
arm                       aspeed_g5_defconfig
mips                      maltasmvp_defconfig
mips                           ci20_defconfig
powerpc                     pq2fads_defconfig
sh                          rsk7269_defconfig
um                           x86_64_defconfig
sh                               j2_defconfig
powerpc64                        alldefconfig
arm                            zeus_defconfig
nios2                         10m50_defconfig
ia64                                defconfig
riscv                            allmodconfig
mips                     decstation_defconfig
csky                                defconfig
powerpc                        warp_defconfig
h8300                       h8s-sim_defconfig
sh                           se7751_defconfig
parisc                generic-64bit_defconfig
h8300                     edosk2674_defconfig
arm                     eseries_pxa_defconfig
nds32                             allnoconfig
sh                        edosk7705_defconfig
arm                       omap2plus_defconfig
sparc64                             defconfig
mips                          rb532_defconfig
arc                          axs101_defconfig
sh                           sh2007_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                         microdev_defconfig
arm                          iop32x_defconfig
nds32                            alldefconfig
mips                         db1xxx_defconfig
arm                         vf610m4_defconfig
sh                        dreamcast_defconfig
arc                      axs103_smp_defconfig
sh                          r7780mp_defconfig
sh                             shx3_defconfig
s390                       zfcpdump_defconfig
sh                          urquell_defconfig
m68k                          amiga_defconfig
powerpc                    adder875_defconfig
parisc                           alldefconfig
mips                 decstation_r4k_defconfig
sh                           se7722_defconfig
sh                 kfr2r09-romimage_defconfig
sh                          landisk_defconfig
sh                           se7712_defconfig
powerpc                     rainier_defconfig
arm                        clps711x_defconfig
powerpc                      arches_defconfig
mips                       bmips_be_defconfig
m68k                         apollo_defconfig
mips                         bigsur_defconfig
arc                            hsdk_defconfig
arc                        nsim_700_defconfig
mips                        bcm47xx_defconfig
openrisc                            defconfig
sh                            shmin_defconfig
parisc                              defconfig
mips                           xway_defconfig
m68k                         amcore_defconfig
arm                            mps2_defconfig
mips                           jazz_defconfig
arm64                            alldefconfig
m68k                        m5272c3_defconfig
powerpc                 mpc834x_mds_defconfig
microblaze                      mmu_defconfig
sh                            titan_defconfig
mips                         mpc30x_defconfig
arc                          axs103_defconfig
arm                            hisi_defconfig
powerpc                      pcm030_defconfig
xtensa                       common_defconfig
powerpc                      pasemi_defconfig
mips                            ar7_defconfig
sh                           se7705_defconfig
m68k                            q40_defconfig
sh                        edosk7760_defconfig
mips                        jmr3927_defconfig
xtensa                           alldefconfig
sh                   rts7751r2dplus_defconfig
riscv                            allyesconfig
um                               alldefconfig
h8300                            alldefconfig
arm                             rpc_defconfig
x86_64                              defconfig
s390                             allyesconfig
arm                  randconfig-c002-20220111
arm                  randconfig-c002-20220112
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220111
arc                  randconfig-r043-20220111
s390                 randconfig-r044-20220111
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220111
x86_64                        randconfig-c007
riscv                randconfig-c006-20220111
powerpc              randconfig-c003-20220111
i386                          randconfig-c001
s390                 randconfig-c005-20220111
mips                 randconfig-c004-20220111
arm                  randconfig-c002-20220112
riscv                randconfig-c006-20220112
powerpc              randconfig-c003-20220112
mips                 randconfig-c004-20220112
arm                      tct_hammer_defconfig
arm                     am200epdkit_defconfig
arm                          imote2_defconfig
riscv                          rv32_defconfig
powerpc                     akebono_defconfig
mips                   sb1250_swarm_defconfig
arm                  colibri_pxa300_defconfig
mips                          malta_defconfig
arm                          ep93xx_defconfig
powerpc                 mpc836x_mds_defconfig
mips                        workpad_defconfig
mips                          ath79_defconfig
arm                         shannon_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                          collie_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                     kilauea_defconfig
arm                         bcm2835_defconfig
powerpc                        fsp2_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                        icon_defconfig
powerpc                          g5_defconfig
arm                                 defconfig
powerpc                   lite5200b_defconfig
powerpc                     ppa8548_defconfig
mips                           ip27_defconfig
powerpc                          allmodconfig
powerpc                     kmeter1_defconfig
mips                           mtx1_defconfig
powerpc                    ge_imp3a_defconfig
arm                            mmp2_defconfig
powerpc                  mpc866_ads_defconfig
mips                      pic32mzda_defconfig
powerpc                     tqm5200_defconfig
arm                         hackkit_defconfig
riscv                             allnoconfig
arm                          ixp4xx_defconfig
mips                          rm200_defconfig
powerpc                      acadia_defconfig
hexagon                          alldefconfig
powerpc                      pmac32_defconfig
mips                           ip22_defconfig
powerpc                 mpc8272_ads_defconfig
mips                        bcm63xx_defconfig
arm                        spear3xx_defconfig
powerpc                 mpc832x_mds_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220112
riscv                randconfig-r042-20220112
hexagon              randconfig-r041-20220112
hexagon              randconfig-r045-20220111
hexagon              randconfig-r041-20220111

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
