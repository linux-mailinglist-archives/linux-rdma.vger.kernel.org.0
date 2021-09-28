Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC4B41B6E7
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Sep 2021 21:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242311AbhI1TIZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Sep 2021 15:08:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:22044 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242305AbhI1TIY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Sep 2021 15:08:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="221580189"
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="221580189"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 12:06:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="708033411"
Received: from lkp-server02.sh.intel.com (HELO f7acefbbae94) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 28 Sep 2021 12:06:34 -0700
Received: from kbuild by f7acefbbae94 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mVIQz-0001Qn-Tn; Tue, 28 Sep 2021 19:06:33 +0000
Date:   Wed, 29 Sep 2021 03:05:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 450f4f6aa1a369cc3ffadc1c7e27dfab3e90199f
Message-ID: <61536785.jAR9yuhMNSVBFcRF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 450f4f6aa1a369cc3ffadc1c7e27dfab3e90199f  RDMA/rxe: Only allow invalidate for appropriate MRs

elapsed time: 432m

configs tested: 146
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
h8300                       h8s-sim_defconfig
sh                         ecovec24_defconfig
sh                   rts7751r2dplus_defconfig
sh                        edosk7705_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                  colibri_pxa270_defconfig
powerpc                     ppa8548_defconfig
xtensa                    xip_kc705_defconfig
arm                            hisi_defconfig
x86_64                              defconfig
mips                  decstation_64_defconfig
arm                        clps711x_defconfig
powerpc                 mpc8560_ads_defconfig
mips                           rs90_defconfig
powerpc                     kilauea_defconfig
arc                        vdk_hs38_defconfig
sh                          landisk_defconfig
powerpc                      pasemi_defconfig
parisc                           alldefconfig
ia64                                defconfig
powerpc                     taishan_defconfig
mips                     decstation_defconfig
arm                         s5pv210_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                     skiroot_defconfig
sh                          rsk7269_defconfig
sh                          r7785rp_defconfig
powerpc                        fsp2_defconfig
alpha                               defconfig
s390                             alldefconfig
arc                          axs103_defconfig
powerpc                     redwood_defconfig
arm                        shmobile_defconfig
arm                         s3c6400_defconfig
powerpc                  storcenter_defconfig
m68k                           sun3_defconfig
powerpc                      mgcoge_defconfig
parisc                              defconfig
arm                           u8500_defconfig
mips                         tb0226_defconfig
arm                          lpd270_defconfig
mips                        bcm63xx_defconfig
arm                           h3600_defconfig
mips                      bmips_stb_defconfig
arm                          pcm027_defconfig
arm                          iop32x_defconfig
mips                         rt305x_defconfig
sh                                  defconfig
sh                          rsk7264_defconfig
powerpc                       ebony_defconfig
riscv                            alldefconfig
h8300                            allyesconfig
arm                        spear6xx_defconfig
m68k                        mvme16x_defconfig
sparc                       sparc32_defconfig
arm                          gemini_defconfig
m68k                            q40_defconfig
powerpc                     powernv_defconfig
sh                           sh2007_defconfig
mips                           ip22_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                     pseries_defconfig
arm                           h5000_defconfig
h8300                               defconfig
arm                          pxa3xx_defconfig
mips                           xway_defconfig
microblaze                      mmu_defconfig
mips                      maltasmvp_defconfig
x86_64               randconfig-c001-20210928
arm                  randconfig-c002-20210928
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
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
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
i386                 randconfig-a001-20210928
i386                 randconfig-a005-20210928
i386                 randconfig-a002-20210928
i386                 randconfig-a006-20210928
i386                 randconfig-a004-20210928
i386                 randconfig-a003-20210928
x86_64               randconfig-a002-20210928
x86_64               randconfig-a005-20210928
x86_64               randconfig-a001-20210928
x86_64               randconfig-a006-20210928
x86_64               randconfig-a003-20210928
x86_64               randconfig-a004-20210928
hexagon              randconfig-r045-20210928
hexagon              randconfig-r041-20210928

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
