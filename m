Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36932D5541
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Dec 2020 09:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387876AbgLJIWa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Dec 2020 03:22:30 -0500
Received: from mga01.intel.com ([192.55.52.88]:3587 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387879AbgLJIWX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Dec 2020 03:22:23 -0500
IronPort-SDR: n9Xm7WOMkjwW9+2wHK6kBaZFXds5sqCLPKGKjraSs0LcvHiEaTZErZ8MpTA59yyEOnG+fH8LQX
 aWlh598oBwFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="192529427"
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="192529427"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 00:21:42 -0800
IronPort-SDR: QwchZhHgYCNSL/rZC6zvKqd+en9JL3PCBIAo6cGiHIBuNi8D+bx4U9+C14iA0MhZgTaP9QLMPp
 khXHEAr4e6/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="375829843"
Received: from lkp-server01.sh.intel.com (HELO ecc0cebe68d1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 10 Dec 2020 00:21:36 -0800
Received: from kbuild by ecc0cebe68d1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1knHCh-00009k-J5; Thu, 10 Dec 2020 08:21:35 +0000
Date:   Thu, 10 Dec 2020 16:20:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-rc] BUILD SUCCESS
 340b940ea0ed12d9adbb8f72dea17d516b2019e8
Message-ID: <5fd1da52.i/kV5M9q/E0JF/PP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  for-rc
branch HEAD: 340b940ea0ed12d9adbb8f72dea17d516b2019e8  RDMA/cm: Fix an attempt to use non-valid pointer when cleaning timewait

elapsed time: 725m

configs tested: 166
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          kfr2r09_defconfig
x86_64                           alldefconfig
arm                     am200epdkit_defconfig
arm                  colibri_pxa270_defconfig
arm                          lpd270_defconfig
arm                              zx_defconfig
arm                         palmz72_defconfig
arm                            u300_defconfig
powerpc                        cell_defconfig
xtensa                generic_kc705_defconfig
s390                             allyesconfig
mips                         mpc30x_defconfig
openrisc                 simple_smp_defconfig
m68k                        stmark2_defconfig
sh                          r7780mp_defconfig
powerpc                   lite5200b_defconfig
mips                           ip32_defconfig
sh                            migor_defconfig
powerpc                    ge_imp3a_defconfig
arc                     haps_hs_smp_defconfig
powerpc                 mpc832x_mds_defconfig
mips                          malta_defconfig
powerpc                       eiger_defconfig
m68k                        mvme147_defconfig
powerpc                      tqm8xx_defconfig
arc                        vdk_hs38_defconfig
powerpc                      walnut_defconfig
ia64                         bigsur_defconfig
m68k                         apollo_defconfig
powerpc                     tqm8555_defconfig
riscv                            allmodconfig
m68k                        mvme16x_defconfig
mips                        omega2p_defconfig
ia64                        generic_defconfig
um                             i386_defconfig
mips                           gcw0_defconfig
sh                           se7724_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                           viper_defconfig
arm                           corgi_defconfig
m68k                        m5307c3_defconfig
powerpc                     ppa8548_defconfig
powerpc                     kilauea_defconfig
powerpc                      makalu_defconfig
powerpc                  iss476-smp_defconfig
arm                         socfpga_defconfig
alpha                            alldefconfig
arm                        vexpress_defconfig
powerpc                 mpc836x_rdk_defconfig
sh                          rsk7264_defconfig
sh                             sh03_defconfig
arm                          simpad_defconfig
arm                    vt8500_v6_v7_defconfig
mips                  maltasmvp_eva_defconfig
sh                        edosk7760_defconfig
arm                       imx_v6_v7_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                       aspeed_g4_defconfig
mips                        workpad_defconfig
powerpc                 mpc832x_rdb_defconfig
arc                         haps_hs_defconfig
arm                        cerfcube_defconfig
arm                          exynos_defconfig
arm                          pcm027_defconfig
mips                          ath25_defconfig
powerpc                 mpc834x_mds_defconfig
arm                        oxnas_v6_defconfig
s390                                defconfig
arm                        spear6xx_defconfig
arm                         s3c6400_defconfig
mips                         db1xxx_defconfig
mips                            ar7_defconfig
arm                       versatile_defconfig
powerpc                        icon_defconfig
arc                              allyesconfig
arm                           tegra_defconfig
arm                        multi_v5_defconfig
mips                          ath79_defconfig
riscv                    nommu_k210_defconfig
powerpc                 mpc8540_ads_defconfig
sh                             shx3_defconfig
powerpc                      pmac32_defconfig
openrisc                            defconfig
m68k                           sun3_defconfig
arm                        multi_v7_defconfig
sh                      rts7751r2d1_defconfig
mips                         bigsur_defconfig
mips                           xway_defconfig
mips                         cobalt_defconfig
mips                        nlm_xlp_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
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
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201209
i386                 randconfig-a005-20201209
i386                 randconfig-a001-20201209
i386                 randconfig-a002-20201209
i386                 randconfig-a006-20201209
i386                 randconfig-a003-20201209
i386                 randconfig-a001-20201210
i386                 randconfig-a004-20201210
i386                 randconfig-a003-20201210
i386                 randconfig-a002-20201210
i386                 randconfig-a005-20201210
i386                 randconfig-a006-20201210
x86_64               randconfig-a016-20201209
x86_64               randconfig-a012-20201209
x86_64               randconfig-a013-20201209
x86_64               randconfig-a014-20201209
x86_64               randconfig-a015-20201209
x86_64               randconfig-a011-20201209
i386                 randconfig-a013-20201209
i386                 randconfig-a014-20201209
i386                 randconfig-a011-20201209
i386                 randconfig-a015-20201209
i386                 randconfig-a012-20201209
i386                 randconfig-a016-20201209
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                               rhel-8.3
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201209
x86_64               randconfig-a006-20201209
x86_64               randconfig-a005-20201209
x86_64               randconfig-a001-20201209
x86_64               randconfig-a002-20201209
x86_64               randconfig-a003-20201209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
