Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6113A3A386C
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Jun 2021 02:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbhFKASa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 20:18:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:19832 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231180AbhFKASa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Jun 2021 20:18:30 -0400
IronPort-SDR: u3462+brZbSIJpJUybFVITJl79WPwrl7Ru7PEiFNa9ACYF43x6uBcoKhpqTFvcjDhTu/yhu3nE
 /vTQkDlf8IDQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="205464015"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="205464015"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 17:16:32 -0700
IronPort-SDR: kcLIywuu0BxB1DDe1yZq+594HrPABtn/TZZjvr+t348nmS/Q7EeqzZNu8C5deLaIb7uAVvaXSg
 suW3mt/kpvPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="483063492"
Received: from lkp-server02.sh.intel.com (HELO 3cb98b298c7e) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 10 Jun 2021 17:16:30 -0700
Received: from kbuild by 3cb98b298c7e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lrUqc-0000Lh-Jl; Fri, 11 Jun 2021 00:16:30 +0000
Date:   Fri, 11 Jun 2021 08:15:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-rc] BUILD SUCCESS
 2ba0aa2feebda680ecfc3c552e867cf4d1b05a3a
Message-ID: <60c2ab2d.71vcS7WAyxC9Mqfo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: 2ba0aa2feebda680ecfc3c552e867cf4d1b05a3a  IB/mlx5: Fix initializing CQ fragments buffer

elapsed time: 720m

configs tested: 246
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          sdk7780_defconfig
arc                    vdk_hs38_smp_defconfig
arm                         vf610m4_defconfig
m68k                           sun3_defconfig
mips                        nlm_xlp_defconfig
powerpc                  mpc885_ads_defconfig
arm                         lpc18xx_defconfig
arm                          pxa910_defconfig
xtensa                  cadence_csp_defconfig
mips                           gcw0_defconfig
sh                 kfr2r09-romimage_defconfig
arm                  colibri_pxa270_defconfig
mips                       lemote2f_defconfig
arm                  colibri_pxa300_defconfig
arm                         bcm2835_defconfig
arm                      tct_hammer_defconfig
csky                             alldefconfig
sparc                       sparc32_defconfig
sh                              ul2_defconfig
arm                          pxa3xx_defconfig
sh                          r7780mp_defconfig
arm                       cns3420vb_defconfig
sparc                            alldefconfig
arm                          ep93xx_defconfig
sh                          rsk7264_defconfig
ia64                        generic_defconfig
arm                           viper_defconfig
powerpc                 mpc836x_mds_defconfig
arm                        clps711x_defconfig
sh                   sh7770_generic_defconfig
sh                          lboxre2_defconfig
sh                        edosk7760_defconfig
ia64                          tiger_defconfig
h8300                    h8300h-sim_defconfig
arm                        oxnas_v6_defconfig
arm                       mainstone_defconfig
arm                           sama5_defconfig
powerpc                 mpc832x_mds_defconfig
mips                          rb532_defconfig
xtensa                          iss_defconfig
arc                          axs101_defconfig
mips                      pic32mzda_defconfig
sparc                       sparc64_defconfig
mips                           jazz_defconfig
microblaze                      mmu_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                    mvme5100_defconfig
sh                           se7619_defconfig
mips                 decstation_r4k_defconfig
openrisc                    or1ksim_defconfig
arm                        shmobile_defconfig
arc                         haps_hs_defconfig
powerpc                         wii_defconfig
mips                        vocore2_defconfig
mips                     cu1830-neo_defconfig
mips                            ar7_defconfig
mips                        maltaup_defconfig
arm                        multi_v5_defconfig
xtensa                           alldefconfig
sh                        sh7785lcr_defconfig
arm                     davinci_all_defconfig
powerpc                 mpc8560_ads_defconfig
arm                      pxa255-idp_defconfig
mips                           ip32_defconfig
powerpc                     tqm8560_defconfig
s390                       zfcpdump_defconfig
powerpc                    socrates_defconfig
arm                          badge4_defconfig
xtensa                       common_defconfig
ia64                             allmodconfig
sh                          polaris_defconfig
arc                                 defconfig
m68k                          sun3x_defconfig
arm                      footbridge_defconfig
arm                   milbeaut_m10v_defconfig
openrisc                  or1klitex_defconfig
powerpc64                           defconfig
i386                                defconfig
xtensa                    xip_kc705_defconfig
mips                         mpc30x_defconfig
h8300                            alldefconfig
sh                           se7721_defconfig
um                                  defconfig
mips                      maltaaprp_defconfig
sh                      rts7751r2d1_defconfig
arm                         axm55xx_defconfig
powerpc                      pasemi_defconfig
powerpc                      makalu_defconfig
mips                        workpad_defconfig
powerpc                      mgcoge_defconfig
m68k                       m5249evb_defconfig
arm                           h5000_defconfig
microblaze                          defconfig
h8300                     edosk2674_defconfig
arm                         at91_dt_defconfig
sh                               alldefconfig
powerpc                 mpc8272_ads_defconfig
h8300                               defconfig
mips                         tb0287_defconfig
sh                         ap325rxa_defconfig
powerpc                     asp8347_defconfig
mips                      fuloong2e_defconfig
um                           x86_64_defconfig
ia64                         bigsur_defconfig
sh                     sh7710voipgw_defconfig
powerpc                    ge_imp3a_defconfig
sh                          urquell_defconfig
arm                          gemini_defconfig
parisc                           alldefconfig
mips                            gpr_defconfig
m68k                       m5475evb_defconfig
mips                             allyesconfig
m68k                        mvme147_defconfig
sh                           se7343_defconfig
nios2                               defconfig
sh                           se7712_defconfig
mips                      pistachio_defconfig
arm                       spear13xx_defconfig
sh                           se7780_defconfig
sh                          rsk7269_defconfig
mips                         bigsur_defconfig
powerpc                     ep8248e_defconfig
powerpc                         ps3_defconfig
arm                            mmp2_defconfig
powerpc                     sequoia_defconfig
arm                        mvebu_v7_defconfig
alpha                               defconfig
powerpc                     powernv_defconfig
powerpc                     ppa8548_defconfig
parisc                generic-64bit_defconfig
powerpc                       holly_defconfig
powerpc                     tqm8555_defconfig
mips                         db1xxx_defconfig
sh                               j2_defconfig
powerpc                      pmac32_defconfig
powerpc                          allmodconfig
arc                           tb10x_defconfig
arm                          lpd270_defconfig
mips                         rt305x_defconfig
powerpc                      tqm8xx_defconfig
nios2                         3c120_defconfig
openrisc                         alldefconfig
sh                            titan_defconfig
m68k                       bvme6000_defconfig
mips                           ci20_defconfig
powerpc                     tqm8541_defconfig
arc                            hsdk_defconfig
powerpc                       ppc64_defconfig
arm                        neponset_defconfig
mips                     loongson2k_defconfig
m68k                        mvme16x_defconfig
mips                       bmips_be_defconfig
arm                            mps2_defconfig
mips                      maltasmvp_defconfig
arm                           sunxi_defconfig
powerpc                 linkstation_defconfig
powerpc                   lite5200b_defconfig
powerpc                      ppc44x_defconfig
x86_64                            allnoconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
csky                                defconfig
alpha                            allyesconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210609
i386                 randconfig-a006-20210609
i386                 randconfig-a004-20210609
i386                 randconfig-a001-20210609
i386                 randconfig-a002-20210609
i386                 randconfig-a005-20210609
i386                 randconfig-a002-20210610
i386                 randconfig-a001-20210610
i386                 randconfig-a003-20210610
i386                 randconfig-a006-20210610
i386                 randconfig-a004-20210610
i386                 randconfig-a005-20210610
x86_64               randconfig-a015-20210610
x86_64               randconfig-a011-20210610
x86_64               randconfig-a012-20210610
x86_64               randconfig-a014-20210610
x86_64               randconfig-a016-20210610
x86_64               randconfig-a013-20210610
i386                 randconfig-a015-20210608
i386                 randconfig-a013-20210608
i386                 randconfig-a016-20210608
i386                 randconfig-a011-20210608
i386                 randconfig-a012-20210608
i386                 randconfig-a014-20210608
i386                 randconfig-a015-20210610
i386                 randconfig-a013-20210610
i386                 randconfig-a016-20210610
i386                 randconfig-a014-20210610
i386                 randconfig-a012-20210610
i386                 randconfig-a011-20210610
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210610
x86_64               randconfig-a001-20210610
x86_64               randconfig-a004-20210610
x86_64               randconfig-a003-20210610
x86_64               randconfig-a006-20210610
x86_64               randconfig-a005-20210610
x86_64               randconfig-a002-20210607
x86_64               randconfig-a004-20210607
x86_64               randconfig-a003-20210607
x86_64               randconfig-a006-20210607
x86_64               randconfig-a005-20210607
x86_64               randconfig-a001-20210607

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
