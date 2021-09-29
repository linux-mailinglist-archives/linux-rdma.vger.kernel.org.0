Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DF441C36B
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Sep 2021 13:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244528AbhI2L1S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Sep 2021 07:27:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:25410 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244822AbhI2L1S (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 Sep 2021 07:27:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="288575335"
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="288575335"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 04:25:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="538779188"
Received: from lkp-server02.sh.intel.com (HELO f7acefbbae94) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 29 Sep 2021 04:25:26 -0700
Received: from kbuild by f7acefbbae94 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mVXiH-0002UT-Lv; Wed, 29 Sep 2021 11:25:25 +0000
Date:   Wed, 29 Sep 2021 19:25:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 d30ef6d5c013c19e907f2a3a3d6eee04fcd3de0d
Message-ID: <61544d14.ZGTGAQ0PjvCKGxff%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: d30ef6d5c013c19e907f2a3a3d6eee04fcd3de0d  Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux

elapsed time: 1065m

configs tested: 138
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210928
powerpc                    amigaone_defconfig
powerpc                     ksi8560_defconfig
sh                         ap325rxa_defconfig
powerpc                      mgcoge_defconfig
riscv                            allyesconfig
mips                       lemote2f_defconfig
sh                        sh7757lcr_defconfig
arm                       imx_v4_v5_defconfig
arm                         bcm2835_defconfig
powerpc                     ep8248e_defconfig
m68k                       bvme6000_defconfig
sh                           se7721_defconfig
mips                     loongson1c_defconfig
mips                         mpc30x_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                     tqm8560_defconfig
arm                  colibri_pxa300_defconfig
powerpc                    gamecube_defconfig
arm                          ixp4xx_defconfig
ia64                      gensparse_defconfig
powerpc                        icon_defconfig
m68k                          atari_defconfig
arc                        nsim_700_defconfig
arm                           tegra_defconfig
mips                      maltasmvp_defconfig
sh                          rsk7203_defconfig
riscv                            alldefconfig
sparc64                             defconfig
arm                            hisi_defconfig
mips                           ip32_defconfig
powerpc                     kilauea_defconfig
arm                           corgi_defconfig
mips                           mtx1_defconfig
mips                        maltaup_defconfig
microblaze                      mmu_defconfig
powerpc                     skiroot_defconfig
arm                            mmp2_defconfig
arm                         assabet_defconfig
m68k                            mac_defconfig
sh                           sh2007_defconfig
powerpc                 linkstation_defconfig
sh                             shx3_defconfig
x86_64               randconfig-c001-20210928
arm                  randconfig-c002-20210928
x86_64               randconfig-c001-20210929
arm                  randconfig-c002-20210929
i386                 randconfig-c001-20210929
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
s390                                defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210929
i386                 randconfig-a005-20210929
i386                 randconfig-a002-20210929
i386                 randconfig-a006-20210929
i386                 randconfig-a004-20210929
i386                 randconfig-a003-20210929
x86_64               randconfig-a014-20210928
x86_64               randconfig-a011-20210928
x86_64               randconfig-a013-20210928
x86_64               randconfig-a012-20210928
x86_64               randconfig-a015-20210928
x86_64               randconfig-a016-20210928
i386                 randconfig-a014-20210928
i386                 randconfig-a013-20210928
i386                 randconfig-a016-20210928
i386                 randconfig-a011-20210928
i386                 randconfig-a015-20210928
i386                 randconfig-a012-20210928
arc                  randconfig-r043-20210928
riscv                randconfig-r042-20210928
s390                 randconfig-r044-20210928
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
powerpc              randconfig-c003-20210929
mips                 randconfig-c004-20210929
arm                  randconfig-c002-20210929
x86_64               randconfig-c007-20210929
riscv                randconfig-c006-20210929
s390                 randconfig-c005-20210929
i386                 randconfig-c001-20210929
x86_64               randconfig-a002-20210928
x86_64               randconfig-a005-20210928
x86_64               randconfig-a001-20210928
x86_64               randconfig-a006-20210928
x86_64               randconfig-a003-20210928
x86_64               randconfig-a004-20210928
i386                 randconfig-a001-20210928
i386                 randconfig-a005-20210928
i386                 randconfig-a002-20210928
i386                 randconfig-a006-20210928
i386                 randconfig-a004-20210928
i386                 randconfig-a003-20210928
hexagon              randconfig-r045-20210928
hexagon              randconfig-r041-20210928

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
