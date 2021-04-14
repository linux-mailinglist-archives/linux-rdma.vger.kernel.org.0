Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38DDA35F44D
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Apr 2021 14:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhDNMy1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Apr 2021 08:54:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:22621 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350972AbhDNMyV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 14 Apr 2021 08:54:21 -0400
IronPort-SDR: Zz5aipQSObCmGRcaEh7BkAfcfw/VHUeaDbiyyvmeeI/GuUOQA1EO8y2XDYC8twAOb45JqRzUiH
 k72vjfvTW4jA==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="194740969"
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="194740969"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 05:53:57 -0700
IronPort-SDR: ESYN2Wl+s+S6xYEqJXUnm9iCQeUeUT/HfIAH4A0iv2vrV6o3VgeYcVsZ+j0Ww5DGRVvQX7H+94
 Pml3+xTJUtmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="418309111"
Received: from lkp-server02.sh.intel.com (HELO fa9c8fcc3464) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 14 Apr 2021 05:53:53 -0700
Received: from kbuild by fa9c8fcc3464 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lWf1l-00001v-2I; Wed, 14 Apr 2021 12:53:53 +0000
Date:   Wed, 14 Apr 2021 20:52:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 3ccbd9333f2783e27d8a631337fbd4d625ffea76
Message-ID: <6076e5a4.gzRpkqkSH16+MxI/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 3ccbd9333f2783e27d8a631337fbd4d625ffea76  RDMA/ipoib: Print a message if only child interface is UP

elapsed time: 722m

configs tested: 183
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
mips                           ip28_defconfig
powerpc                     asp8347_defconfig
ia64                        generic_defconfig
arc                     nsimosci_hs_defconfig
mips                           gcw0_defconfig
arm                           corgi_defconfig
sh                           se7724_defconfig
powerpc                      obs600_defconfig
arm                            mmp2_defconfig
arc                        nsim_700_defconfig
arm                       imx_v4_v5_defconfig
openrisc                         alldefconfig
m68k                          atari_defconfig
mips                malta_qemu_32r6_defconfig
arm                          iop32x_defconfig
arm                           sunxi_defconfig
sh                          urquell_defconfig
h8300                    h8300h-sim_defconfig
arm                          collie_defconfig
nds32                            alldefconfig
arm                         socfpga_defconfig
sparc64                             defconfig
powerpc                        warp_defconfig
mips                        nlm_xlr_defconfig
ia64                      gensparse_defconfig
h8300                       h8s-sim_defconfig
powerpc                       ebony_defconfig
powerpc                      ppc6xx_defconfig
mips                          rb532_defconfig
sh                        sh7785lcr_defconfig
mips                         db1xxx_defconfig
sh                            titan_defconfig
m68k                         amcore_defconfig
arm                       netwinder_defconfig
m68k                        mvme147_defconfig
ia64                            zx1_defconfig
powerpc                         ps3_defconfig
sh                                  defconfig
s390                             allyesconfig
mips                         tb0287_defconfig
arc                        vdk_hs38_defconfig
mips                         bigsur_defconfig
arm                         vf610m4_defconfig
powerpc                     tqm8548_defconfig
powerpc                      ppc44x_defconfig
i386                             alldefconfig
mips                          rm200_defconfig
arm                          pcm027_defconfig
arm                        cerfcube_defconfig
microblaze                          defconfig
arm                     eseries_pxa_defconfig
sparc                            allyesconfig
mips                        maltaup_defconfig
xtensa                  nommu_kc705_defconfig
arc                          axs101_defconfig
powerpc                 mpc8540_ads_defconfig
mips                        qi_lb60_defconfig
arm                            dove_defconfig
powerpc                     tqm8540_defconfig
sh                ecovec24-romimage_defconfig
arm                          lpd270_defconfig
mips                           ci20_defconfig
arm                        multi_v7_defconfig
arm                        spear3xx_defconfig
mips                           xway_defconfig
sh                   secureedge5410_defconfig
alpha                               defconfig
arm                        realview_defconfig
arm                       versatile_defconfig
mips                        bcm63xx_defconfig
arm                        clps711x_defconfig
xtensa                generic_kc705_defconfig
arm                      footbridge_defconfig
sparc64                          alldefconfig
arm                      jornada720_defconfig
powerpc                   motionpro_defconfig
mips                            gpr_defconfig
m68k                             allyesconfig
arm                       aspeed_g4_defconfig
arm                           sama5_defconfig
s390                             allmodconfig
mips                       rbtx49xx_defconfig
powerpc                     mpc512x_defconfig
arm                        trizeps4_defconfig
powerpc                       eiger_defconfig
sh                   rts7751r2dplus_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210413
i386                 randconfig-a003-20210413
i386                 randconfig-a001-20210413
i386                 randconfig-a006-20210413
i386                 randconfig-a005-20210413
i386                 randconfig-a004-20210413
i386                 randconfig-a002-20210413
i386                 randconfig-a003-20210414
i386                 randconfig-a006-20210414
i386                 randconfig-a001-20210414
i386                 randconfig-a005-20210414
i386                 randconfig-a004-20210414
i386                 randconfig-a002-20210414
x86_64               randconfig-a014-20210414
x86_64               randconfig-a015-20210414
x86_64               randconfig-a011-20210414
x86_64               randconfig-a013-20210414
x86_64               randconfig-a012-20210414
x86_64               randconfig-a016-20210414
x86_64               randconfig-a003-20210413
x86_64               randconfig-a002-20210413
x86_64               randconfig-a001-20210413
x86_64               randconfig-a005-20210413
x86_64               randconfig-a004-20210413
i386                 randconfig-a015-20210413
i386                 randconfig-a014-20210413
i386                 randconfig-a013-20210413
i386                 randconfig-a012-20210413
i386                 randconfig-a016-20210413
i386                 randconfig-a011-20210413
i386                 randconfig-a015-20210414
i386                 randconfig-a014-20210414
i386                 randconfig-a013-20210414
i386                 randconfig-a012-20210414
i386                 randconfig-a016-20210414
i386                 randconfig-a011-20210414
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20210413
x86_64               randconfig-a015-20210413
x86_64               randconfig-a011-20210413
x86_64               randconfig-a013-20210413
x86_64               randconfig-a012-20210413
x86_64               randconfig-a016-20210413
x86_64               randconfig-a003-20210414
x86_64               randconfig-a002-20210414
x86_64               randconfig-a005-20210414
x86_64               randconfig-a001-20210414
x86_64               randconfig-a006-20210414
x86_64               randconfig-a004-20210414

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
