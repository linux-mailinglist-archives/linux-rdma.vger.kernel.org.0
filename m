Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1DA289E9F
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Oct 2020 07:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbgJJFpA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 10 Oct 2020 01:45:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:52999 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730823AbgJJFnw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 10 Oct 2020 01:43:52 -0400
IronPort-SDR: Qpy0/eWO8oISwVz5R6fX06wJe8hzVVGbNVq2OTgPhub0V16XYeOSCKO+7f7OhakpE/09RS8rud
 9/uVV/hHeMeg==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="153395695"
X-IronPort-AV: E=Sophos;i="5.77,357,1596524400"; 
   d="scan'208";a="153395695"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 22:43:35 -0700
IronPort-SDR: cqw7LrzlctiEHfm8QfkqO+rw4sDTglDm339e8MnXaJ4Dz1Z96NCFZl4W0Y113n5go+t0/+r3Yl
 vJI9iZ4sHWdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,357,1596524400"; 
   d="scan'208";a="329116918"
Received: from lkp-server02.sh.intel.com (HELO 3104d2c277ac) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 09 Oct 2020 22:43:34 -0700
Received: from kbuild by 3104d2c277ac with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kR7fJ-00002I-Et; Sat, 10 Oct 2020 05:43:33 +0000
Date:   Sat, 10 Oct 2020 13:43:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 b2b6b3d6aeaa7b4d0ab0d6ba0346d1130addcfab
Message-ID: <5f8149ee.jaTcdzJ+OE6RT+6H%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  for-next
branch HEAD: b2b6b3d6aeaa7b4d0ab0d6ba0346d1130addcfab  Merge branch 'dynamic_sg' into rdma.git for-next

elapsed time: 722m

configs tested: 153
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                                 defconfig
c6x                                 defconfig
riscv                    nommu_virt_defconfig
sparc64                          alldefconfig
arm                          iop32x_defconfig
powerpc                     pq2fads_defconfig
arm                        spear6xx_defconfig
arm                          ep93xx_defconfig
ia64                             alldefconfig
nios2                         3c120_defconfig
powerpc                      walnut_defconfig
powerpc                    gamecube_defconfig
xtensa                          iss_defconfig
sh                             shx3_defconfig
arm                         hackkit_defconfig
sh                             sh03_defconfig
mips                            gpr_defconfig
powerpc                 mpc834x_mds_defconfig
arm                         nhk8815_defconfig
parisc                           allyesconfig
powerpc                      tqm8xx_defconfig
mips                      fuloong2e_defconfig
sh                          sdk7780_defconfig
m68k                          atari_defconfig
mips                     loongson1c_defconfig
powerpc                     mpc83xx_defconfig
arm                             pxa_defconfig
powerpc                      cm5200_defconfig
powerpc                      bamboo_defconfig
powerpc                         wii_defconfig
sh                            shmin_defconfig
powerpc                     kmeter1_defconfig
powerpc                 mpc836x_rdk_defconfig
m68k                        m5307c3_defconfig
arc                      axs103_smp_defconfig
arm                           sama5_defconfig
powerpc                     stx_gp3_defconfig
mips                           ci20_defconfig
h8300                            allyesconfig
mips                malta_qemu_32r6_defconfig
powerpc                       ppc64_defconfig
arm                       mainstone_defconfig
powerpc                     tqm5200_defconfig
um                             i386_defconfig
sparc64                             defconfig
openrisc                 simple_smp_defconfig
sh                        edosk7705_defconfig
sh                 kfr2r09-romimage_defconfig
mips                      pic32mzda_defconfig
arc                            hsdk_defconfig
arm                          lpd270_defconfig
arm                     davinci_all_defconfig
m68k                        m5272c3_defconfig
arm                            u300_defconfig
arm                           viper_defconfig
mips                       lemote2f_defconfig
powerpc                    sam440ep_defconfig
powerpc                      ppc64e_defconfig
mips                       capcella_defconfig
arc                         haps_hs_defconfig
sh                           se7712_defconfig
mips                        bcm47xx_defconfig
arm                         s3c2410_defconfig
sh                           sh2007_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                        qi_lb60_defconfig
arm                          tango4_defconfig
h8300                            alldefconfig
powerpc                     ppa8548_defconfig
arm                           sunxi_defconfig
sh                           se7705_defconfig
riscv                    nommu_k210_defconfig
m68k                         amcore_defconfig
arm                             ezx_defconfig
arm                         lpc18xx_defconfig
powerpc                      pasemi_defconfig
riscv                            alldefconfig
powerpc                     tqm8548_defconfig
mips                      loongson3_defconfig
arm                          imote2_defconfig
powerpc                  mpc866_ads_defconfig
i386                             alldefconfig
xtensa                  audio_kc705_defconfig
arm                       spear13xx_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
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
i386                 randconfig-a006-20201009
i386                 randconfig-a005-20201009
i386                 randconfig-a001-20201009
i386                 randconfig-a004-20201009
i386                 randconfig-a002-20201009
i386                 randconfig-a003-20201009
x86_64               randconfig-a012-20201009
x86_64               randconfig-a015-20201009
x86_64               randconfig-a013-20201009
x86_64               randconfig-a014-20201009
x86_64               randconfig-a011-20201009
x86_64               randconfig-a016-20201009
i386                 randconfig-a015-20201009
i386                 randconfig-a013-20201009
i386                 randconfig-a014-20201009
i386                 randconfig-a016-20201009
i386                 randconfig-a011-20201009
i386                 randconfig-a012-20201009
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201009
x86_64               randconfig-a003-20201009
x86_64               randconfig-a005-20201009
x86_64               randconfig-a001-20201009
x86_64               randconfig-a002-20201009
x86_64               randconfig-a006-20201009

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
