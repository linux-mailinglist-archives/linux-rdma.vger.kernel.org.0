Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DD53D1AAD
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jul 2021 02:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhGUXkL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 19:40:11 -0400
Received: from mga02.intel.com ([134.134.136.20]:13807 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229600AbhGUXkL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Jul 2021 19:40:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="198743175"
X-IronPort-AV: E=Sophos;i="5.84,259,1620716400"; 
   d="scan'208";a="198743175"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 17:20:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,259,1620716400"; 
   d="scan'208";a="495537761"
Received: from lkp-server01.sh.intel.com (HELO b8b92b2878b0) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jul 2021 17:20:45 -0700
Received: from kbuild by b8b92b2878b0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m6MSD-0000gL-3M; Thu, 22 Jul 2021 00:20:45 +0000
Date:   Thu, 22 Jul 2021 08:20:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 07d0f314ba75cba17c3fad0a3d4e640e757897d7
Message-ID: <60f8b9c9.isdnsWjYVcr3UlYf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 07d0f314ba75cba17c3fad0a3d4e640e757897d7  Merge branch 'mlx5_dcs' into rdma.git for-next

elapsed time: 729m

configs tested: 149
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7750_defconfig
sh                          rsk7269_defconfig
mips                      bmips_stb_defconfig
arm                           h5000_defconfig
ia64                             allyesconfig
powerpc                      pasemi_defconfig
m68k                        mvme16x_defconfig
sh                          r7785rp_defconfig
sparc64                             defconfig
arc                     nsimosci_hs_defconfig
m68k                             allyesconfig
m68k                       m5208evb_defconfig
arm                           sama5_defconfig
mips                       rbtx49xx_defconfig
mips                          ath25_defconfig
powerpc                     mpc5200_defconfig
powerpc               mpc834x_itxgp_defconfig
sh                         apsh4a3a_defconfig
arm                             mxs_defconfig
arm                          pcm027_defconfig
arm                           tegra_defconfig
sh                               alldefconfig
powerpc                      mgcoge_defconfig
mips                         bigsur_defconfig
h8300                    h8300h-sim_defconfig
arm                         nhk8815_defconfig
arm                         bcm2835_defconfig
ia64                                defconfig
riscv                            alldefconfig
microblaze                          defconfig
parisc                generic-64bit_defconfig
arm                           stm32_defconfig
arm                         vf610m4_defconfig
x86_64                            allnoconfig
arm                        multi_v5_defconfig
powerpc                  mpc866_ads_defconfig
mips                     loongson2k_defconfig
sh                ecovec24-romimage_defconfig
arm                          ep93xx_defconfig
powerpc                         wii_defconfig
sh                           se7343_defconfig
mips                           ip28_defconfig
arm64                            alldefconfig
mips                     cu1000-neo_defconfig
riscv                    nommu_virt_defconfig
mips                 decstation_r4k_defconfig
xtensa                  nommu_kc705_defconfig
sh                        edosk7760_defconfig
m68k                          sun3x_defconfig
mips                    maltaup_xpa_defconfig
powerpc                      ppc40x_defconfig
powerpc                     tqm8560_defconfig
sh                          polaris_defconfig
mips                      fuloong2e_defconfig
powerpc                       holly_defconfig
arm                           viper_defconfig
arm                            mps2_defconfig
mips                         tb0287_defconfig
sh                          landisk_defconfig
arm                         socfpga_defconfig
powerpc64                           defconfig
powerpc                      cm5200_defconfig
arm                         palmz72_defconfig
ia64                             allmodconfig
m68k                             allmodconfig
m68k                                defconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210720
x86_64               randconfig-a006-20210720
x86_64               randconfig-a001-20210720
x86_64               randconfig-a005-20210720
x86_64               randconfig-a004-20210720
x86_64               randconfig-a002-20210720
i386                 randconfig-a005-20210720
i386                 randconfig-a003-20210720
i386                 randconfig-a004-20210720
i386                 randconfig-a002-20210720
i386                 randconfig-a001-20210720
i386                 randconfig-a006-20210720
i386                 randconfig-a005-20210719
i386                 randconfig-a004-20210719
i386                 randconfig-a006-20210719
i386                 randconfig-a001-20210719
i386                 randconfig-a003-20210719
i386                 randconfig-a002-20210719
x86_64               randconfig-a011-20210721
x86_64               randconfig-a016-20210721
x86_64               randconfig-a013-20210721
x86_64               randconfig-a014-20210721
x86_64               randconfig-a012-20210721
x86_64               randconfig-a015-20210721
i386                 randconfig-a016-20210720
i386                 randconfig-a013-20210720
i386                 randconfig-a012-20210720
i386                 randconfig-a014-20210720
i386                 randconfig-a011-20210720
i386                 randconfig-a015-20210720
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210721
x86_64               randconfig-b001-20210720
x86_64               randconfig-a011-20210720
x86_64               randconfig-a016-20210720
x86_64               randconfig-a013-20210720
x86_64               randconfig-a014-20210720
x86_64               randconfig-a012-20210720
x86_64               randconfig-a015-20210720

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
