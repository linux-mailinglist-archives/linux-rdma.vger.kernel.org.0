Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17E93FC0B3
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Aug 2021 04:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239319AbhHaCIE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Aug 2021 22:08:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:34417 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232187AbhHaCIE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 30 Aug 2021 22:08:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="240632665"
X-IronPort-AV: E=Sophos;i="5.84,365,1620716400"; 
   d="scan'208";a="240632665"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 19:06:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,365,1620716400"; 
   d="scan'208";a="459741990"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 30 Aug 2021 19:06:54 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mKtAr-0005hy-Gk; Tue, 31 Aug 2021 02:06:53 +0000
Date:   Tue, 31 Aug 2021 10:06:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 6a217437f9f5482a3f6f2dc5fcd27cf0f62409ac
Message-ID: <612d8eb4.ABPpasVx3OldKxuq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 6a217437f9f5482a3f6f2dc5fcd27cf0f62409ac  Merge branch 'sg_nents' into rdma.git for-next

elapsed time: 725m

configs tested: 176
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210830
xtensa                         virt_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                      katmai_defconfig
xtensa                          iss_defconfig
openrisc                    or1ksim_defconfig
arm                        multi_v7_defconfig
arm                            pleb_defconfig
sh                            titan_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                     tqm8548_defconfig
m68k                       m5275evb_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                      pmac32_defconfig
um                                  defconfig
arm                          collie_defconfig
powerpc                     tqm8541_defconfig
mips                          ath25_defconfig
arc                     nsimosci_hs_defconfig
arm                         nhk8815_defconfig
mips                      bmips_stb_defconfig
x86_64                            allnoconfig
sparc                       sparc32_defconfig
xtensa                           alldefconfig
microblaze                          defconfig
powerpc                  mpc866_ads_defconfig
arm                           viper_defconfig
powerpc                      makalu_defconfig
arc                        nsimosci_defconfig
powerpc                     powernv_defconfig
sh                          sdk7786_defconfig
csky                                defconfig
arm                        neponset_defconfig
arm                       omap2plus_defconfig
arm                           corgi_defconfig
powerpc                   microwatt_defconfig
mips                           ip28_defconfig
powerpc                          g5_defconfig
powerpc                        cell_defconfig
ia64                             alldefconfig
sh                      rts7751r2d1_defconfig
powerpc                     pq2fads_defconfig
arm                         s3c6400_defconfig
sh                        apsh4ad0a_defconfig
h8300                     edosk2674_defconfig
arm                         axm55xx_defconfig
mips                          rm200_defconfig
mips                         tb0219_defconfig
mips                           xway_defconfig
arm                          badge4_defconfig
mips                         cobalt_defconfig
sh                        edosk7705_defconfig
mips                            ar7_defconfig
ia64                        generic_defconfig
sparc64                             defconfig
arm                          iop32x_defconfig
powerpc                         ps3_defconfig
mips                         db1xxx_defconfig
m68k                        mvme16x_defconfig
m68k                             alldefconfig
mips                     loongson2k_defconfig
mips                      fuloong2e_defconfig
powerpc                      bamboo_defconfig
arm                         s3c2410_defconfig
arm                           sunxi_defconfig
mips                           jazz_defconfig
sh                           se7619_defconfig
powerpc                     stx_gp3_defconfig
sh                   rts7751r2dplus_defconfig
mips                     cu1830-neo_defconfig
alpha                            alldefconfig
mips                       bmips_be_defconfig
h8300                       h8s-sim_defconfig
sh                           se7724_defconfig
m68k                        m5407c3_defconfig
sh                         apsh4a3a_defconfig
powerpc                 mpc834x_mds_defconfig
mips                        vocore2_defconfig
nios2                         3c120_defconfig
m68k                            q40_defconfig
sh                           se7751_defconfig
powerpc               mpc834x_itxgp_defconfig
sh                   sh7770_generic_defconfig
mips                         mpc30x_defconfig
powerpc                     mpc5200_defconfig
arm                         bcm2835_defconfig
arm                       netwinder_defconfig
powerpc                     tqm8555_defconfig
powerpc                      chrp32_defconfig
sh                           se7722_defconfig
m68k                       m5249evb_defconfig
arm                        oxnas_v6_defconfig
mips                        bcm63xx_defconfig
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
x86_64               randconfig-a014-20210830
x86_64               randconfig-a015-20210830
x86_64               randconfig-a013-20210830
x86_64               randconfig-a016-20210830
x86_64               randconfig-a012-20210830
x86_64               randconfig-a011-20210830
i386                 randconfig-a016-20210830
i386                 randconfig-a011-20210830
i386                 randconfig-a015-20210830
i386                 randconfig-a014-20210830
i386                 randconfig-a012-20210830
i386                 randconfig-a013-20210830
s390                 randconfig-r044-20210830
arc                  randconfig-r043-20210830
riscv                randconfig-r042-20210830
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
i386                 randconfig-c001-20210830
s390                 randconfig-c005-20210830
riscv                randconfig-c006-20210830
powerpc              randconfig-c003-20210830
mips                 randconfig-c004-20210830
arm                  randconfig-c002-20210830
x86_64               randconfig-c007-20210830
x86_64               randconfig-a005-20210830
x86_64               randconfig-a001-20210830
x86_64               randconfig-a003-20210830
x86_64               randconfig-a002-20210830
x86_64               randconfig-a004-20210830
x86_64               randconfig-a006-20210830
i386                 randconfig-a005-20210830
i386                 randconfig-a002-20210830
i386                 randconfig-a003-20210830
i386                 randconfig-a006-20210830
i386                 randconfig-a004-20210830
i386                 randconfig-a001-20210830

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
