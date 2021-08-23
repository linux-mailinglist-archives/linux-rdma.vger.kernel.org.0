Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810943F4508
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 08:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbhHWGjE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Aug 2021 02:39:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:36293 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232202AbhHWGjD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Aug 2021 02:39:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10084"; a="196619024"
X-IronPort-AV: E=Sophos;i="5.84,343,1620716400"; 
   d="scan'208";a="196619024"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2021 23:38:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,343,1620716400"; 
   d="scan'208";a="683036504"
Received: from lkp-server02.sh.intel.com (HELO ca0e9373e375) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 22 Aug 2021 23:38:20 -0700
Received: from kbuild by ca0e9373e375 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mI3b9-00003H-A4; Mon, 23 Aug 2021 06:38:19 +0000
Date:   Mon, 23 Aug 2021 14:37:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 cc4f596cf85e97ca6606e1bd10b3b9851ef52ddf
Message-ID: <61234242.dsDMHYO4PVyoHn2C%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-rc
branch HEAD: cc4f596cf85e97ca6606e1bd10b3b9851ef52ddf  RDMA/rxe: Zero out index member of struct rxe_queue

elapsed time: 3487m

configs tested: 189
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
mips                           ip28_defconfig
mips                            ar7_defconfig
powerpc                     rainier_defconfig
powerpc                   bluestone_defconfig
arm                         lpc18xx_defconfig
arm                       multi_v4t_defconfig
s390                                defconfig
mips                        bcm63xx_defconfig
nios2                         10m50_defconfig
arm                        realview_defconfig
powerpc                       ppc64_defconfig
sh                            hp6xx_defconfig
mips                        nlm_xlp_defconfig
arm                        clps711x_defconfig
mips                         tb0219_defconfig
powerpc                 mpc8540_ads_defconfig
arm                         palmz72_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                         tb0287_defconfig
powerpc                 mpc832x_mds_defconfig
mips                            e55_defconfig
microblaze                      mmu_defconfig
arm                         nhk8815_defconfig
m68k                        mvme16x_defconfig
arm                            xcep_defconfig
sh                           se7780_defconfig
arm                          imote2_defconfig
arm                       imx_v4_v5_defconfig
arm                     eseries_pxa_defconfig
arm                        shmobile_defconfig
sh                        edosk7705_defconfig
powerpc                  iss476-smp_defconfig
powerpc                     tqm8541_defconfig
arm                           h3600_defconfig
parisc                generic-64bit_defconfig
riscv                    nommu_virt_defconfig
arc                     nsimosci_hs_defconfig
powerpc                      pasemi_defconfig
mips                           ip32_defconfig
arm                           tegra_defconfig
openrisc                 simple_smp_defconfig
powerpc                        icon_defconfig
m68k                          multi_defconfig
arc                        vdk_hs38_defconfig
alpha                            alldefconfig
powerpc                 mpc8313_rdb_defconfig
mips                          rb532_defconfig
ia64                      gensparse_defconfig
mips                         cobalt_defconfig
powerpc                    amigaone_defconfig
arc                         haps_hs_defconfig
arm                       aspeed_g5_defconfig
arm                         s5pv210_defconfig
nios2                            allyesconfig
arm                             pxa_defconfig
arm                            qcom_defconfig
powerpc                  storcenter_defconfig
arm                        oxnas_v6_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                     akebono_defconfig
sh                          rsk7203_defconfig
sh                               alldefconfig
sh                               j2_defconfig
s390                          debug_defconfig
powerpc                 linkstation_defconfig
mips                  decstation_64_defconfig
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
x86_64               randconfig-a014-20210821
x86_64               randconfig-a016-20210821
x86_64               randconfig-a015-20210821
x86_64               randconfig-a013-20210821
x86_64               randconfig-a012-20210821
x86_64               randconfig-a011-20210821
i386                 randconfig-a011-20210821
i386                 randconfig-a016-20210821
i386                 randconfig-a012-20210821
i386                 randconfig-a014-20210821
i386                 randconfig-a013-20210821
i386                 randconfig-a015-20210821
arc                  randconfig-r043-20210821
riscv                randconfig-r042-20210821
s390                 randconfig-r044-20210821
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
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20210821
i386                 randconfig-c001-20210821
arm                  randconfig-c002-20210821
riscv                randconfig-c006-20210821
powerpc              randconfig-c003-20210821
x86_64               randconfig-c007-20210821
i386                 randconfig-c001-20210822
s390                 randconfig-c005-20210822
arm                  randconfig-c002-20210822
riscv                randconfig-c006-20210822
powerpc              randconfig-c003-20210822
x86_64               randconfig-c007-20210822
mips                 randconfig-c004-20210822
mips                 randconfig-c004-20210821
x86_64               randconfig-a005-20210821
x86_64               randconfig-a001-20210821
x86_64               randconfig-a006-20210821
x86_64               randconfig-a003-20210821
x86_64               randconfig-a004-20210821
x86_64               randconfig-a002-20210821
i386                 randconfig-a006-20210821
i386                 randconfig-a001-20210821
i386                 randconfig-a002-20210821
i386                 randconfig-a005-20210821
i386                 randconfig-a004-20210821
i386                 randconfig-a003-20210821
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
hexagon              randconfig-r041-20210822
hexagon              randconfig-r045-20210822
riscv                randconfig-r042-20210822
s390                 randconfig-r044-20210822

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
