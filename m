Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D01B3B81E5
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jun 2021 14:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbhF3MT7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Jun 2021 08:19:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:53166 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234376AbhF3MT5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Jun 2021 08:19:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="195490492"
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="195490492"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 05:17:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="641690106"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jun 2021 05:17:27 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lyZ9i-0009kl-JO; Wed, 30 Jun 2021 12:17:26 +0000
Date:   Wed, 30 Jun 2021 20:16:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 fb38ab9c38c97db7ac5711704e41450212ab231d
Message-ID: <60dc60a6.SIoPyj+JB/XKLP2l%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: fb38ab9c38c97db7ac5711704e41450212ab231d  RDMA: Use dma_map_sgtable for map umem pages

elapsed time: 721m

configs tested: 135
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
xtensa                           allyesconfig
arm                         at91_dt_defconfig
arm                       imx_v6_v7_defconfig
ia64                         bigsur_defconfig
powerpc                     mpc512x_defconfig
powerpc                     mpc5200_defconfig
sh                        edosk7760_defconfig
mips                            ar7_defconfig
sh                           se7712_defconfig
mips                      maltasmvp_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                           se7724_defconfig
sh                          sdk7786_defconfig
powerpc                     taishan_defconfig
arm                         hackkit_defconfig
m68k                        m5307c3_defconfig
powerpc                      mgcoge_defconfig
powerpc                     skiroot_defconfig
arm                      integrator_defconfig
powerpc                      chrp32_defconfig
parisc                              defconfig
arm                            mmp2_defconfig
arm                         palmz72_defconfig
powerpc                     stx_gp3_defconfig
powerpc                  mpc885_ads_defconfig
arm                            zeus_defconfig
riscv                    nommu_k210_defconfig
arc                         haps_hs_defconfig
arm                      pxa255-idp_defconfig
powerpc                     tqm8540_defconfig
mips                     cu1830-neo_defconfig
arm                         socfpga_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc64                           defconfig
sh                               j2_defconfig
arm                           u8500_defconfig
arc                          axs101_defconfig
arm                         shannon_defconfig
arm                          moxart_defconfig
mips                      pic32mzda_defconfig
mips                          rm200_defconfig
arm                           h5000_defconfig
openrisc                 simple_smp_defconfig
mips                        workpad_defconfig
powerpc                      pasemi_defconfig
powerpc                 mpc8560_ads_defconfig
sparc                       sparc32_defconfig
mips                           ci20_defconfig
sh                           se7780_defconfig
powerpc                     asp8347_defconfig
powerpc                       holly_defconfig
powerpc                       eiger_defconfig
parisc                           alldefconfig
powerpc                      arches_defconfig
powerpc                     tqm8548_defconfig
mips                          ath25_defconfig
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
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
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
i386                 randconfig-a002-20210629
i386                 randconfig-a001-20210629
i386                 randconfig-a003-20210629
i386                 randconfig-a006-20210629
i386                 randconfig-a005-20210629
i386                 randconfig-a004-20210629
x86_64               randconfig-a012-20210628
x86_64               randconfig-a016-20210628
x86_64               randconfig-a015-20210628
x86_64               randconfig-a013-20210628
x86_64               randconfig-a014-20210628
x86_64               randconfig-a011-20210628
i386                 randconfig-a011-20210628
i386                 randconfig-a014-20210628
i386                 randconfig-a013-20210628
i386                 randconfig-a015-20210628
i386                 randconfig-a016-20210628
i386                 randconfig-a012-20210628
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210628
x86_64               randconfig-b001-20210630
x86_64               randconfig-a002-20210628
x86_64               randconfig-a005-20210628
x86_64               randconfig-a001-20210628
x86_64               randconfig-a003-20210628
x86_64               randconfig-a004-20210628
x86_64               randconfig-a006-20210628

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
