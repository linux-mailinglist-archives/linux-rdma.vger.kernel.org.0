Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055AD2B1647
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Nov 2020 08:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgKMHUA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Nov 2020 02:20:00 -0500
Received: from mga09.intel.com ([134.134.136.24]:37319 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgKMHUA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 13 Nov 2020 02:20:00 -0500
IronPort-SDR: WWw90wWqoEFpXZ9f0dpeH3wE7pOtvZn/RuWHt+DmK/WCicSQrqVcqMJaghheqQ81RePnwoXE57
 tEPfJJZKFHmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="170607002"
X-IronPort-AV: E=Sophos;i="5.77,474,1596524400"; 
   d="scan'208";a="170607002"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 23:19:52 -0800
IronPort-SDR: I1RD9qajW58MT8aDSItc2oD0LalslieQq7mh8SU0rHVO+FooRaMffvyRDSNsxwEF5OVQQv/QTR
 00Sc4+VyTW8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,474,1596524400"; 
   d="scan'208";a="309083433"
Received: from lkp-server02.sh.intel.com (HELO 697932c29306) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 12 Nov 2020 23:19:50 -0800
Received: from kbuild by 697932c29306 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kdTN8-000089-0i; Fri, 13 Nov 2020 07:19:50 +0000
Date:   Fri, 13 Nov 2020 15:19:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 b1e678bf290db5a76f1b6a9f7c381310e03440d6
Message-ID: <5fae3394.H5Bio7VSD3q1WEUW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-rc
branch HEAD: b1e678bf290db5a76f1b6a9f7c381310e03440d6  RMDA/sw: Don't allow drivers using dma_virt_ops on highmem configs

elapsed time: 756m

configs tested: 221
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         bcm2835_defconfig
arm                        shmobile_defconfig
arm                        spear6xx_defconfig
arm                       aspeed_g5_defconfig
ia64                        generic_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                    ge_imp3a_defconfig
sparc                               defconfig
sparc64                          alldefconfig
sh                        dreamcast_defconfig
m68k                             alldefconfig
m68k                            q40_defconfig
arm                          ep93xx_defconfig
arm                       multi_v4t_defconfig
mips                      maltasmvp_defconfig
nios2                         10m50_defconfig
arm                             mxs_defconfig
arm                          prima2_defconfig
arm64                            alldefconfig
mips                          ath79_defconfig
powerpc                       maple_defconfig
sh                          polaris_defconfig
powerpc                     pq2fads_defconfig
sh                          kfr2r09_defconfig
arm                        mvebu_v5_defconfig
arm                       aspeed_g4_defconfig
m68k                          atari_defconfig
powerpc                     pseries_defconfig
arm                   milbeaut_m10v_defconfig
arm                        multi_v5_defconfig
mips                     loongson1c_defconfig
parisc                generic-32bit_defconfig
arm                          tango4_defconfig
arm                         s3c2410_defconfig
xtensa                              defconfig
sh                          lboxre2_defconfig
sh                           se7722_defconfig
m68k                         apollo_defconfig
powerpc                        warp_defconfig
arm                  colibri_pxa270_defconfig
arm                              alldefconfig
sh                          rsk7203_defconfig
mips                     loongson1b_defconfig
powerpc                    mvme5100_defconfig
sh                          sdk7786_defconfig
mips                       bmips_be_defconfig
sparc                       sparc32_defconfig
powerpc                     tqm8548_defconfig
um                            kunit_defconfig
arc                          axs103_defconfig
sh                           se7750_defconfig
arc                    vdk_hs38_smp_defconfig
arc                           tb10x_defconfig
c6x                              alldefconfig
arc                     nsimosci_hs_defconfig
xtensa                         virt_defconfig
arm                          gemini_defconfig
powerpc                      pasemi_defconfig
powerpc                      walnut_defconfig
mips                        vocore2_defconfig
arm                          imote2_defconfig
mips                           rs90_defconfig
arm                          exynos_defconfig
m68k                           sun3_defconfig
mips                        workpad_defconfig
ia64                                defconfig
mips                          ath25_defconfig
mips                         cobalt_defconfig
arm                        spear3xx_defconfig
powerpc                    adder875_defconfig
powerpc                       ebony_defconfig
xtensa                    smp_lx200_defconfig
microblaze                      mmu_defconfig
arm                        trizeps4_defconfig
c6x                                 defconfig
csky                             alldefconfig
arc                        nsim_700_defconfig
powerpc                  mpc885_ads_defconfig
sh                      rts7751r2d1_defconfig
h8300                     edosk2674_defconfig
mips                             allyesconfig
powerpc                 mpc836x_rdk_defconfig
nios2                            allyesconfig
arm                       imx_v6_v7_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                            dove_defconfig
sh                              ul2_defconfig
sh                            hp6xx_defconfig
microblaze                          defconfig
mips                malta_kvm_guest_defconfig
i386                             alldefconfig
mips                        maltaup_defconfig
arm                         mv78xx0_defconfig
s390                          debug_defconfig
arm                         hackkit_defconfig
x86_64                           allyesconfig
arc                 nsimosci_hs_smp_defconfig
arm                            pleb_defconfig
mips                        omega2p_defconfig
mips                          malta_defconfig
arm                      footbridge_defconfig
mips                 decstation_r4k_defconfig
arm                         nhk8815_defconfig
arm                         assabet_defconfig
arm                            u300_defconfig
openrisc                 simple_smp_defconfig
powerpc                 mpc832x_mds_defconfig
arm                          pxa168_defconfig
arm                         socfpga_defconfig
m68k                        m5307c3_defconfig
ia64                      gensparse_defconfig
m68k                        stmark2_defconfig
sh                               allmodconfig
arm                           spitz_defconfig
powerpc                      pmac32_defconfig
arm                           viper_defconfig
powerpc                      obs600_defconfig
sh                        sh7785lcr_defconfig
arm                         orion5x_defconfig
sh                          rsk7269_defconfig
powerpc                         wii_defconfig
xtensa                          iss_defconfig
mips                        nlm_xlr_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201112
i386                 randconfig-a005-20201112
i386                 randconfig-a002-20201112
i386                 randconfig-a001-20201112
i386                 randconfig-a003-20201112
i386                 randconfig-a004-20201112
i386                 randconfig-a006-20201113
i386                 randconfig-a005-20201113
i386                 randconfig-a002-20201113
i386                 randconfig-a001-20201113
i386                 randconfig-a003-20201113
i386                 randconfig-a004-20201113
i386                 randconfig-a006-20201111
i386                 randconfig-a005-20201111
i386                 randconfig-a002-20201111
i386                 randconfig-a001-20201111
i386                 randconfig-a003-20201111
i386                 randconfig-a004-20201111
x86_64               randconfig-a015-20201111
x86_64               randconfig-a011-20201111
x86_64               randconfig-a014-20201111
x86_64               randconfig-a013-20201111
x86_64               randconfig-a016-20201111
x86_64               randconfig-a012-20201111
x86_64               randconfig-a015-20201113
x86_64               randconfig-a011-20201113
x86_64               randconfig-a014-20201113
x86_64               randconfig-a013-20201113
x86_64               randconfig-a016-20201113
x86_64               randconfig-a012-20201113
i386                 randconfig-a012-20201113
i386                 randconfig-a014-20201113
i386                 randconfig-a016-20201113
i386                 randconfig-a011-20201113
i386                 randconfig-a015-20201113
i386                 randconfig-a013-20201113
i386                 randconfig-a012-20201111
i386                 randconfig-a014-20201111
i386                 randconfig-a016-20201111
i386                 randconfig-a011-20201111
i386                 randconfig-a015-20201111
i386                 randconfig-a013-20201111
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20201113
x86_64               randconfig-a005-20201113
x86_64               randconfig-a004-20201113
x86_64               randconfig-a002-20201113
x86_64               randconfig-a006-20201113
x86_64               randconfig-a001-20201113
x86_64               randconfig-a003-20201111
x86_64               randconfig-a005-20201111
x86_64               randconfig-a004-20201111
x86_64               randconfig-a002-20201111
x86_64               randconfig-a006-20201111
x86_64               randconfig-a001-20201111

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
