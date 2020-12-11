Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57022D78C7
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Dec 2020 16:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392489AbgLKPFq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Dec 2020 10:05:46 -0500
Received: from mga01.intel.com ([192.55.52.88]:17122 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389802AbgLKPES (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 11 Dec 2020 10:04:18 -0500
IronPort-SDR: eeT02KmSRpuuJNzAOYHkIKnaUBIoSX6FQ06htr9tOlPMrb2c6145MoLnJyTPr5bQ/baP2fUJBr
 WN7D1vYmYkyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9831"; a="192782640"
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; 
   d="scan'208";a="192782640"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2020 07:03:37 -0800
IronPort-SDR: 7y3Rflxvzt2Jz8zxCen95fMjzBBEbXRjSv8JIVsZmzkkTE/8kKgrmcZwl5EKZVJvCa0Bkufxpe
 kOXjUiAtCIlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; 
   d="scan'208";a="485172110"
Received: from lkp-server01.sh.intel.com (HELO ecc0cebe68d1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 11 Dec 2020 07:03:35 -0800
Received: from kbuild by ecc0cebe68d1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1knjxG-0000wO-P8; Fri, 11 Dec 2020 15:03:34 +0000
Date:   Fri, 11 Dec 2020 23:03:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 6f320f6990ee2dd13df89707f1a219ecfe2960ad
Message-ID: <5fd38a38.GDDbMA/rpWB9G9x5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: 6f320f6990ee2dd13df89707f1a219ecfe2960ad  RDMA/mlx4: Remove bogus dev_base_lock usage

elapsed time: 773m

configs tested: 196
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       omap2plus_defconfig
mips                         db1xxx_defconfig
powerpc                      cm5200_defconfig
mips                        maltaup_defconfig
powerpc                     skiroot_defconfig
mips                         bigsur_defconfig
powerpc                 canyonlands_defconfig
mips                           ci20_defconfig
m68k                                defconfig
xtensa                  nommu_kc705_defconfig
arc                         haps_hs_defconfig
sh                             shx3_defconfig
arm                          ixp4xx_defconfig
arm                          simpad_defconfig
sh                           se7705_defconfig
arm                          moxart_defconfig
powerpc                      walnut_defconfig
mips                     cu1000-neo_defconfig
arc                            hsdk_defconfig
mips                           ip28_defconfig
nds32                               defconfig
arc                        vdk_hs38_defconfig
riscv                            allyesconfig
sh                           sh2007_defconfig
powerpc                     tqm8560_defconfig
arm                           viper_defconfig
arm                          collie_defconfig
sh                 kfr2r09-romimage_defconfig
um                             i386_defconfig
mips                    maltaup_xpa_defconfig
arm                          ep93xx_defconfig
arm                            zeus_defconfig
sh                           se7343_defconfig
sh                            migor_defconfig
mips                        vocore2_defconfig
arm                         orion5x_defconfig
powerpc                 mpc836x_mds_defconfig
mips                      fuloong2e_defconfig
arm                        realview_defconfig
powerpc                      ppc6xx_defconfig
arm                       spear13xx_defconfig
powerpc                     mpc512x_defconfig
xtensa                    xip_kc705_defconfig
sh                          kfr2r09_defconfig
sparc                            alldefconfig
mips                        bcm47xx_defconfig
microblaze                      mmu_defconfig
arc                          axs103_defconfig
arm                     eseries_pxa_defconfig
arm                      tct_hammer_defconfig
powerpc                    mvme5100_defconfig
powerpc                      acadia_defconfig
arm                          imote2_defconfig
mips                malta_kvm_guest_defconfig
sh                          sdk7780_defconfig
powerpc                 mpc8560_ads_defconfig
arm                         lubbock_defconfig
arm                          tango4_defconfig
powerpc                         ps3_defconfig
sh                        sh7763rdp_defconfig
sparc64                          alldefconfig
h8300                               defconfig
sh                          rsk7201_defconfig
mips                            ar7_defconfig
mips                     loongson1c_defconfig
powerpc                  storcenter_defconfig
arm                      footbridge_defconfig
arm                          iop32x_defconfig
arm                         shannon_defconfig
c6x                                 defconfig
m68k                       m5249evb_defconfig
arm                           stm32_defconfig
arm                           h5000_defconfig
alpha                            alldefconfig
sh                         microdev_defconfig
arm                           u8500_defconfig
powerpc                        icon_defconfig
m68k                             alldefconfig
sh                          r7785rp_defconfig
sh                   secureedge5410_defconfig
ia64                          tiger_defconfig
arm                        mini2440_defconfig
sh                              ul2_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc64                           defconfig
powerpc                     rainier_defconfig
powerpc                        warp_defconfig
arm                          badge4_defconfig
mips                          rb532_defconfig
sh                          urquell_defconfig
sh                          sdk7786_defconfig
powerpc                      ppc64e_defconfig
arm                         palmz72_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                               j2_defconfig
arm                       versatile_defconfig
sh                   rts7751r2dplus_defconfig
sh                               alldefconfig
m68k                          amiga_defconfig
powerpc                      ppc40x_defconfig
powerpc                       ebony_defconfig
arm                         s5pv210_defconfig
powerpc                      makalu_defconfig
mips                          rm200_defconfig
arm                             mxs_defconfig
riscv                            alldefconfig
powerpc                      arches_defconfig
m68k                        m5272c3_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                           ip27_defconfig
arm                          gemini_defconfig
arm                      pxa255-idp_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
parisc                           allyesconfig
s390                                defconfig
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
i386                 randconfig-a014-20201210
i386                 randconfig-a013-20201210
i386                 randconfig-a012-20201210
i386                 randconfig-a011-20201210
i386                 randconfig-a016-20201210
i386                 randconfig-a015-20201210
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
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
x86_64               randconfig-a004-20201209
x86_64               randconfig-a006-20201209
x86_64               randconfig-a005-20201209
x86_64               randconfig-a001-20201209
x86_64               randconfig-a002-20201209
x86_64               randconfig-a003-20201209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
