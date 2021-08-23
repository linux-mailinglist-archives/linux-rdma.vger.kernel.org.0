Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CFD3F4902
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 12:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbhHWKxL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Aug 2021 06:53:11 -0400
Received: from mga04.intel.com ([192.55.52.120]:4579 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234865AbhHWKxK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Aug 2021 06:53:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10084"; a="215235196"
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="215235196"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 03:52:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="514747735"
Received: from lkp-server02.sh.intel.com (HELO ca0e9373e375) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 23 Aug 2021 03:52:27 -0700
Received: from kbuild by ca0e9373e375 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mI7Z4-0000AM-A2; Mon, 23 Aug 2021 10:52:26 +0000
Date:   Mon, 23 Aug 2021 18:52:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 273691c3d28d18a9cf6bf3105da38484d90347b9
Message-ID: <61237dde.psSVuQ4VMQ4zfTVN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 273691c3d28d18a9cf6bf3105da38484d90347b9  RDMA/efa: Rename vector field in efa_irq struct to irqn

elapsed time: 721m

configs tested: 139
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7751_defconfig
sh                          sdk7786_defconfig
m68k                          sun3x_defconfig
sh                             shx3_defconfig
sh                        sh7757lcr_defconfig
xtensa                         virt_defconfig
mips                      bmips_stb_defconfig
sh                   secureedge5410_defconfig
sparc                       sparc32_defconfig
mips                      maltasmvp_defconfig
sh                           se7206_defconfig
mips                           jazz_defconfig
arm                       spear13xx_defconfig
arm                          pxa910_defconfig
m68k                                defconfig
mips                         tb0287_defconfig
powerpc                 mpc832x_mds_defconfig
mips                            e55_defconfig
microblaze                      mmu_defconfig
mips                        bcm63xx_defconfig
arm                         nhk8815_defconfig
riscv                            alldefconfig
mips                            gpr_defconfig
h8300                               defconfig
powerpc                     stx_gp3_defconfig
arm                            mps2_defconfig
powerpc                  mpc866_ads_defconfig
mips                           gcw0_defconfig
powerpc64                           defconfig
mips                           mtx1_defconfig
m68k                         amcore_defconfig
powerpc                      katmai_defconfig
powerpc                      pasemi_defconfig
mips                           ip32_defconfig
arm                           tegra_defconfig
openrisc                 simple_smp_defconfig
powerpc                        icon_defconfig
m68k                          multi_defconfig
powerpc                    amigaone_defconfig
powerpc                 mpc8540_ads_defconfig
arc                         haps_hs_defconfig
arm                       aspeed_g5_defconfig
arm                         s5pv210_defconfig
nios2                            allyesconfig
powerpc                 mpc8272_ads_defconfig
arc                      axs103_smp_defconfig
sh                ecovec24-romimage_defconfig
arm                          badge4_defconfig
sh                     sh7710voipgw_defconfig
s390                          debug_defconfig
arm                        clps711x_defconfig
powerpc                 linkstation_defconfig
mips                  decstation_64_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
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
x86_64               randconfig-a005-20210822
x86_64               randconfig-a006-20210822
x86_64               randconfig-a001-20210822
x86_64               randconfig-a003-20210822
x86_64               randconfig-a004-20210822
x86_64               randconfig-a002-20210822
i386                 randconfig-a006-20210822
i386                 randconfig-a001-20210822
i386                 randconfig-a002-20210822
i386                 randconfig-a005-20210822
i386                 randconfig-a003-20210822
i386                 randconfig-a004-20210822
arc                  randconfig-r043-20210822
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
i386                 randconfig-c001-20210822
s390                 randconfig-c005-20210822
arm                  randconfig-c002-20210822
riscv                randconfig-c006-20210822
powerpc              randconfig-c003-20210822
x86_64               randconfig-c007-20210822
mips                 randconfig-c004-20210822
x86_64               randconfig-a014-20210822
x86_64               randconfig-a015-20210822
x86_64               randconfig-a013-20210822
x86_64               randconfig-a012-20210822
x86_64               randconfig-a011-20210822
x86_64               randconfig-a016-20210822
i386                 randconfig-a011-20210822
i386                 randconfig-a016-20210822
i386                 randconfig-a012-20210822
i386                 randconfig-a014-20210822
i386                 randconfig-a013-20210822
i386                 randconfig-a015-20210822
hexagon              randconfig-r041-20210822
hexagon              randconfig-r045-20210822
riscv                randconfig-r042-20210822
s390                 randconfig-r044-20210822

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
