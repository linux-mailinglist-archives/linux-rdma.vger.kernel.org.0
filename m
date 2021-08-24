Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CAE3F585B
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Aug 2021 08:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbhHXGks (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Aug 2021 02:40:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:46171 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231269AbhHXGkr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Aug 2021 02:40:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10085"; a="214123169"
X-IronPort-AV: E=Sophos;i="5.84,346,1620716400"; 
   d="scan'208";a="214123169"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 23:40:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,346,1620716400"; 
   d="scan'208";a="455343492"
Received: from lkp-server02.sh.intel.com (HELO 181e7be6f509) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 23 Aug 2021 23:40:01 -0700
Received: from kbuild by 181e7be6f509 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mIQ6K-0000Nx-KI; Tue, 24 Aug 2021 06:40:00 +0000
Date:   Tue, 24 Aug 2021 14:39:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 f8c549afd1e76ad78b1d044a307783c9b94ae3ab
Message-ID: <61249430.zLfmnAb10/fz9cnw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: f8c549afd1e76ad78b1d044a307783c9b94ae3ab  RDMA/hns: Ownerbit mode add control field

elapsed time: 736m

configs tested: 137
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                        spear6xx_defconfig
mips                malta_qemu_32r6_defconfig
sh                          sdk7786_defconfig
xtensa                       common_defconfig
powerpc                    adder875_defconfig
m68k                         apollo_defconfig
openrisc                            defconfig
powerpc                      bamboo_defconfig
arm                         s5pv210_defconfig
powerpc                     skiroot_defconfig
arm                         bcm2835_defconfig
mips                           rs90_defconfig
powerpc                       ppc64_defconfig
arm                       versatile_defconfig
sh                             shx3_defconfig
arm                          collie_defconfig
arm                     davinci_all_defconfig
mips                           ip32_defconfig
arm                        multi_v7_defconfig
arc                          axs101_defconfig
sh                 kfr2r09-romimage_defconfig
sh                         ap325rxa_defconfig
mips                          rm200_defconfig
arm                       netwinder_defconfig
openrisc                    or1ksim_defconfig
mips                     loongson2k_defconfig
mips                           mtx1_defconfig
m68k                       m5249evb_defconfig
m68k                       m5275evb_defconfig
arm                  colibri_pxa270_defconfig
powerpc                     mpc5200_defconfig
powerpc                      chrp32_defconfig
mips                           ip28_defconfig
s390                          debug_defconfig
mips                        qi_lb60_defconfig
arm                       spear13xx_defconfig
sh                           se7705_defconfig
arm                        cerfcube_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                        dreamcast_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
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
x86_64               randconfig-a005-20210824
x86_64               randconfig-a006-20210824
x86_64               randconfig-a001-20210824
x86_64               randconfig-a003-20210824
x86_64               randconfig-a004-20210824
x86_64               randconfig-a002-20210824
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
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
x86_64               randconfig-a016-20210822
x86_64               randconfig-a015-20210822
x86_64               randconfig-a013-20210822
x86_64               randconfig-a012-20210822
x86_64               randconfig-a011-20210822
i386                 randconfig-a011-20210822
i386                 randconfig-a016-20210822
i386                 randconfig-a012-20210822
i386                 randconfig-a014-20210822
i386                 randconfig-a013-20210822
i386                 randconfig-a015-20210822
hexagon              randconfig-r041-20210824
hexagon              randconfig-r045-20210824
riscv                randconfig-r042-20210824
s390                 randconfig-r044-20210824
hexagon              randconfig-r041-20210822
hexagon              randconfig-r045-20210822
riscv                randconfig-r042-20210822
s390                 randconfig-r044-20210822

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
