Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C940D35EB42
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Apr 2021 05:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhDNDLg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 23:11:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:30278 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232933AbhDNDLe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Apr 2021 23:11:34 -0400
IronPort-SDR: 8roZi80jyb06SEyGEAjU5vQT8CHSAQ6OSv5VkHvUOsVXF0pFP7qn5CN4BrKcUdADchI9qMg12V
 PoEPTB9TV3/g==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="191367087"
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="191367087"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 20:11:13 -0700
IronPort-SDR: C/mpgC3KYhBo3/c9yy4OfoxhjGu6klZfZJncyQ1QpX6YXZ0gykpd96vnH36pW3+Wkp/uDsVJPm
 QUQulzOLgMNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="418121231"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 13 Apr 2021 20:11:12 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lWVvr-0001W1-IF; Wed, 14 Apr 2021 03:11:11 +0000
Date:   Wed, 14 Apr 2021 11:10:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 7f4a8592ff29f19c5a2ca549d0973821319afaad
Message-ID: <60765d16.GYEKjQc7cuCJr0Zx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 7f4a8592ff29f19c5a2ca549d0973821319afaad  RDMA/rtrs-clt: destroy sysfs after removing session from active list

elapsed time: 720m

configs tested: 168
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
riscv                            allyesconfig
sh                          rsk7269_defconfig
sh                             sh03_defconfig
ia64                                defconfig
openrisc                 simple_smp_defconfig
openrisc                         alldefconfig
powerpc64                           defconfig
sh                        apsh4ad0a_defconfig
h8300                       h8s-sim_defconfig
sh                           se7206_defconfig
s390                             allmodconfig
riscv             nommu_k210_sdcard_defconfig
sh                           se7343_defconfig
arm                       aspeed_g4_defconfig
powerpc                      cm5200_defconfig
arm                   milbeaut_m10v_defconfig
arm                        mvebu_v7_defconfig
mips                          ath79_defconfig
microblaze                          defconfig
arm                       imx_v4_v5_defconfig
m68k                          atari_defconfig
mips                malta_qemu_32r6_defconfig
arm                          iop32x_defconfig
arm                           sunxi_defconfig
arc                         haps_hs_defconfig
powerpc                     taishan_defconfig
powerpc64                        alldefconfig
powerpc                     ksi8560_defconfig
xtensa                  cadence_csp_defconfig
sh                          urquell_defconfig
h8300                    h8300h-sim_defconfig
arm                          collie_defconfig
powerpc                    socrates_defconfig
powerpc                   lite5200b_defconfig
powerpc                      bamboo_defconfig
arm                            xcep_defconfig
mips                        nlm_xlp_defconfig
powerpc                  iss476-smp_defconfig
mips                         db1xxx_defconfig
sh                            titan_defconfig
m68k                         amcore_defconfig
arm                       netwinder_defconfig
m68k                        mvme147_defconfig
ia64                            zx1_defconfig
mips                        workpad_defconfig
sh                          polaris_defconfig
powerpc                     tqm5200_defconfig
arm                         assabet_defconfig
sh                          landisk_defconfig
csky                             alldefconfig
powerpc                     tqm8560_defconfig
arm                       spear13xx_defconfig
arc                     haps_hs_smp_defconfig
mips                        maltaup_defconfig
arm                        realview_defconfig
arm                     am200epdkit_defconfig
arm                     eseries_pxa_defconfig
sparc                            allyesconfig
xtensa                  nommu_kc705_defconfig
mips                           ip27_defconfig
sh                   sh7724_generic_defconfig
powerpc                 xes_mpc85xx_defconfig
xtensa                  audio_kc705_defconfig
arm                             ezx_defconfig
h8300                            alldefconfig
arm                           corgi_defconfig
mips                        omega2p_defconfig
arm                          ixp4xx_defconfig
powerpc                     tqm8540_defconfig
arm                          pxa3xx_defconfig
powerpc                      ep88xc_defconfig
powerpc                     rainier_defconfig
arm                          pxa168_defconfig
mips                           ci20_defconfig
powerpc                 mpc834x_itx_defconfig
sparc64                             defconfig
powerpc                     sequoia_defconfig
arm                         bcm2835_defconfig
sh                          rsk7201_defconfig
arc                          axs103_defconfig
arm                        clps711x_defconfig
xtensa                generic_kc705_defconfig
arm                      footbridge_defconfig
sparc64                          alldefconfig
arm                      jornada720_defconfig
powerpc                    amigaone_defconfig
powerpc                     powernv_defconfig
powerpc                       ebony_defconfig
sh                        edosk7760_defconfig
arm                           stm32_defconfig
sh                        sh7785lcr_defconfig
powerpc                 canyonlands_defconfig
arm                       multi_v4t_defconfig
sh                     magicpanelr2_defconfig
ia64                             allmodconfig
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
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210413
x86_64               randconfig-a002-20210413
x86_64               randconfig-a001-20210413
x86_64               randconfig-a005-20210413
x86_64               randconfig-a006-20210413
x86_64               randconfig-a004-20210413
i386                 randconfig-a003-20210413
i386                 randconfig-a001-20210413
i386                 randconfig-a006-20210413
i386                 randconfig-a005-20210413
i386                 randconfig-a004-20210413
i386                 randconfig-a002-20210413
i386                 randconfig-a015-20210413
i386                 randconfig-a014-20210413
i386                 randconfig-a013-20210413
i386                 randconfig-a012-20210413
i386                 randconfig-a016-20210413
i386                 randconfig-a011-20210413
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20210413
x86_64               randconfig-a015-20210413
x86_64               randconfig-a011-20210413
x86_64               randconfig-a013-20210413
x86_64               randconfig-a012-20210413
x86_64               randconfig-a016-20210413

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
