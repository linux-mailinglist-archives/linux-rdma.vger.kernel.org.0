Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D72404316
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Sep 2021 03:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbhIIBqj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Sep 2021 21:46:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:46987 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230457AbhIIBqi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Sep 2021 21:46:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="200847885"
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="200847885"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 18:45:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="525167668"
Received: from lkp-server01.sh.intel.com (HELO 730d49888f40) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 08 Sep 2021 18:45:25 -0700
Received: from kbuild by 730d49888f40 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mO981-0002qj-0d; Thu, 09 Sep 2021 01:45:25 +0000
Date:   Thu, 09 Sep 2021 09:45:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-rc] BUILD SUCCESS
 2169b908894df2ce83e7eb4a399d3224b2635126
Message-ID: <61396724.77r6ku0zo3oqsF3T%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: 2169b908894df2ce83e7eb4a399d3224b2635126  IB/hfi1: make hist static

elapsed time: 762m

configs tested: 163
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210908
nds32                            alldefconfig
mips                      bmips_stb_defconfig
powerpc                     rainier_defconfig
powerpc                     tqm8548_defconfig
arm                       multi_v4t_defconfig
powerpc                      obs600_defconfig
powerpc                      walnut_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                       ppc64_defconfig
sh                        edosk7705_defconfig
h8300                    h8300h-sim_defconfig
sh                           se7750_defconfig
sh                           se7722_defconfig
mips                     loongson1c_defconfig
powerpc                       holly_defconfig
m68k                                defconfig
arm                         nhk8815_defconfig
sh                           se7751_defconfig
mips                         bigsur_defconfig
m68k                          amiga_defconfig
arm                            pleb_defconfig
m68k                            mac_defconfig
s390                          debug_defconfig
powerpc                    socrates_defconfig
sparc                               defconfig
xtensa                  cadence_csp_defconfig
arm                           sama5_defconfig
powerpc                     taishan_defconfig
m68k                        m5272c3_defconfig
microblaze                      mmu_defconfig
arm                       aspeed_g4_defconfig
sh                          rsk7264_defconfig
arm                        mvebu_v5_defconfig
m68k                        mvme147_defconfig
powerpc                      mgcoge_defconfig
powerpc                   lite5200b_defconfig
arm                             rpc_defconfig
arm                     am200epdkit_defconfig
powerpc                     skiroot_defconfig
m68k                       m5208evb_defconfig
m68k                        m5407c3_defconfig
openrisc                            defconfig
arm                       versatile_defconfig
arm                        cerfcube_defconfig
arm                          ixp4xx_defconfig
powerpc                     pq2fads_defconfig
mips                           rs90_defconfig
mips                       bmips_be_defconfig
arm                        oxnas_v6_defconfig
arm                         socfpga_defconfig
mips                           xway_defconfig
mips                          rb532_defconfig
ia64                             allmodconfig
arm                         at91_dt_defconfig
powerpc                      ppc6xx_defconfig
arm                        multi_v5_defconfig
powerpc                     kilauea_defconfig
mips                        workpad_defconfig
powerpc                        warp_defconfig
arm                         mv78xx0_defconfig
sh                           se7343_defconfig
sh                      rts7751r2d1_defconfig
arc                      axs103_smp_defconfig
sh                          sdk7780_defconfig
powerpc                        fsp2_defconfig
arm                       netwinder_defconfig
arm                        keystone_defconfig
mips                     cu1830-neo_defconfig
mips                           ip27_defconfig
powerpc                 mpc837x_mds_defconfig
sh                        sh7785lcr_defconfig
sh                          landisk_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                 linkstation_defconfig
sh                               j2_defconfig
arm                    vt8500_v6_v7_defconfig
arm                            qcom_defconfig
sh                        apsh4ad0a_defconfig
arm                        spear3xx_defconfig
x86_64               randconfig-c001-20210908
arm                  randconfig-c002-20210908
x86_64                            allnoconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64               randconfig-a004-20210908
x86_64               randconfig-a006-20210908
x86_64               randconfig-a003-20210908
x86_64               randconfig-a001-20210908
x86_64               randconfig-a005-20210908
x86_64               randconfig-a002-20210908
i386                 randconfig-a005-20210908
i386                 randconfig-a004-20210908
i386                 randconfig-a006-20210908
i386                 randconfig-a002-20210908
i386                 randconfig-a001-20210908
i386                 randconfig-a003-20210908
arc                  randconfig-r043-20210908
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
s390                 randconfig-c005-20210908
powerpc              randconfig-c003-20210908
mips                 randconfig-c004-20210908
i386                 randconfig-c001-20210908
x86_64               randconfig-a016-20210908
x86_64               randconfig-a011-20210908
x86_64               randconfig-a012-20210908
x86_64               randconfig-a015-20210908
x86_64               randconfig-a014-20210908
x86_64               randconfig-a013-20210908
i386                 randconfig-a012-20210908
i386                 randconfig-a015-20210908
i386                 randconfig-a011-20210908
i386                 randconfig-a013-20210908
i386                 randconfig-a014-20210908
i386                 randconfig-a016-20210908
riscv                randconfig-r042-20210908
hexagon              randconfig-r045-20210908
s390                 randconfig-r044-20210908
hexagon              randconfig-r041-20210908

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
