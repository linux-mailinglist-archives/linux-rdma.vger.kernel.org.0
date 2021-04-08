Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0C5358425
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 15:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhDHNGS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 09:06:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:3953 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229741AbhDHNGR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Apr 2021 09:06:17 -0400
IronPort-SDR: A0jpAjJTnRMCcti7AuUELCfELzHH9xW/pc9GcRz0gZM8rqj+Wlvww4eGcoFqzMvr3OEQTHU9uU
 c3e98mBcjzGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="173616179"
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="173616179"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 06:04:11 -0700
IronPort-SDR: 5slic5/8qUyOYM+iVWqJDkaEiQwWQZyrXxkba2qRbJwwsTPvg1I+jI8juFti4x2rOqpk7QrlAr
 5unt+3IRbKZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="419140304"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 08 Apr 2021 06:04:09 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lUUKO-000F3g-Q9; Thu, 08 Apr 2021 13:04:08 +0000
Date:   Thu, 08 Apr 2021 21:03:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 7d8f346504ebde71d92905e3055d40ea8f34416e
Message-ID: <606eff1b.vdzQ/jO0LN/v3mvr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 7d8f346504ebde71d92905e3055d40ea8f34416e  RDMA/core: Make the wc status prompt message clearer

elapsed time: 731m

configs tested: 224
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
arm                         hackkit_defconfig
arm                           u8500_defconfig
mips                       bmips_be_defconfig
arm                           h5000_defconfig
mips                      loongson3_defconfig
ia64                             allyesconfig
arm                         lpc18xx_defconfig
arc                         haps_hs_defconfig
riscv                            alldefconfig
powerpc                     mpc83xx_defconfig
openrisc                 simple_smp_defconfig
powerpc                    amigaone_defconfig
arc                      axs103_smp_defconfig
mips                        bcm47xx_defconfig
arm                            lart_defconfig
arm                         assabet_defconfig
arm                          exynos_defconfig
arm                           viper_defconfig
sh                          lboxre2_defconfig
arc                          axs101_defconfig
powerpc                      chrp32_defconfig
arm                        keystone_defconfig
alpha                            allyesconfig
sh                            shmin_defconfig
mips                           ci20_defconfig
mips                        maltaup_defconfig
mips                         mpc30x_defconfig
arm                        cerfcube_defconfig
xtensa                  cadence_csp_defconfig
arm                        oxnas_v6_defconfig
powerpc                      ppc44x_defconfig
arm                  colibri_pxa300_defconfig
arm                         bcm2835_defconfig
m68k                         apollo_defconfig
arm                            hisi_defconfig
mips                            e55_defconfig
m68k                         amcore_defconfig
powerpc                   currituck_defconfig
sh                            hp6xx_defconfig
arc                     nsimosci_hs_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                         socfpga_defconfig
mips                      malta_kvm_defconfig
i386                                defconfig
s390                       zfcpdump_defconfig
nios2                         3c120_defconfig
m68k                        m5407c3_defconfig
powerpc                    klondike_defconfig
arm                         at91_dt_defconfig
powerpc                 mpc8272_ads_defconfig
sh                   sh7770_generic_defconfig
arm                          collie_defconfig
powerpc                     mpc5200_defconfig
arm                       omap2plus_defconfig
csky                                defconfig
arm                        mvebu_v7_defconfig
arm                        neponset_defconfig
mips                  cavium_octeon_defconfig
ia64                        generic_defconfig
arm                           tegra_defconfig
powerpc                     stx_gp3_defconfig
m68k                        stmark2_defconfig
arm                        spear3xx_defconfig
mips                           gcw0_defconfig
arm                          moxart_defconfig
m68k                       m5475evb_defconfig
powerpc                       maple_defconfig
powerpc64                           defconfig
mips                     cu1000-neo_defconfig
sh                   secureedge5410_defconfig
arm                         nhk8815_defconfig
sh                          kfr2r09_defconfig
arm                      footbridge_defconfig
xtensa                           alldefconfig
arm                          iop32x_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                      ppc64e_defconfig
sh                           se7343_defconfig
sh                        sh7785lcr_defconfig
sh                          rsk7201_defconfig
arm                        shmobile_defconfig
riscv             nommu_k210_sdcard_defconfig
arc                                 defconfig
powerpc                    socrates_defconfig
mips                            ar7_defconfig
sh                          sdk7786_defconfig
arm                     am200epdkit_defconfig
arm                           sunxi_defconfig
arm                            zeus_defconfig
powerpc                     sbc8548_defconfig
arm                       netwinder_defconfig
powerpc                        warp_defconfig
arm                         cm_x300_defconfig
sh                          urquell_defconfig
alpha                            alldefconfig
m68k                        m5307c3_defconfig
arm                      tct_hammer_defconfig
mips                           ip28_defconfig
sh                   sh7724_generic_defconfig
sh                          rsk7269_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                         ps3_defconfig
x86_64                           alldefconfig
arm                            xcep_defconfig
alpha                               defconfig
m68k                          hp300_defconfig
nios2                            alldefconfig
arm                     davinci_all_defconfig
sh                      rts7751r2d1_defconfig
powerpc                      mgcoge_defconfig
powerpc                         wii_defconfig
m68k                          amiga_defconfig
powerpc                    mvme5100_defconfig
mips                    maltaup_xpa_defconfig
arm                        trizeps4_defconfig
mips                malta_kvm_guest_defconfig
powerpc                      tqm8xx_defconfig
powerpc                     tqm8541_defconfig
powerpc                        fsp2_defconfig
um                               allyesconfig
powerpc                      ppc40x_defconfig
mips                        nlm_xlr_defconfig
arm                          pxa3xx_defconfig
arc                    vdk_hs38_smp_defconfig
mips                           ip32_defconfig
sh                         ap325rxa_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                      bamboo_defconfig
mips                      pistachio_defconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210408
x86_64               randconfig-a005-20210408
x86_64               randconfig-a003-20210408
x86_64               randconfig-a001-20210408
x86_64               randconfig-a002-20210408
x86_64               randconfig-a006-20210408
i386                 randconfig-a006-20210407
i386                 randconfig-a003-20210407
i386                 randconfig-a001-20210407
i386                 randconfig-a004-20210407
i386                 randconfig-a002-20210407
i386                 randconfig-a005-20210407
i386                 randconfig-a006-20210408
i386                 randconfig-a003-20210408
i386                 randconfig-a001-20210408
i386                 randconfig-a004-20210408
i386                 randconfig-a005-20210408
i386                 randconfig-a002-20210408
x86_64               randconfig-a014-20210407
x86_64               randconfig-a015-20210407
x86_64               randconfig-a013-20210407
x86_64               randconfig-a011-20210407
x86_64               randconfig-a012-20210407
x86_64               randconfig-a016-20210407
i386                 randconfig-a014-20210408
i386                 randconfig-a016-20210408
i386                 randconfig-a011-20210408
i386                 randconfig-a012-20210408
i386                 randconfig-a013-20210408
i386                 randconfig-a015-20210408
i386                 randconfig-a014-20210407
i386                 randconfig-a011-20210407
i386                 randconfig-a016-20210407
i386                 randconfig-a012-20210407
i386                 randconfig-a015-20210407
i386                 randconfig-a013-20210407
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20210408
x86_64               randconfig-a015-20210408
x86_64               randconfig-a012-20210408
x86_64               randconfig-a011-20210408
x86_64               randconfig-a013-20210408
x86_64               randconfig-a016-20210408
x86_64               randconfig-a004-20210407
x86_64               randconfig-a003-20210407
x86_64               randconfig-a005-20210407
x86_64               randconfig-a001-20210407
x86_64               randconfig-a002-20210407
x86_64               randconfig-a006-20210407

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
