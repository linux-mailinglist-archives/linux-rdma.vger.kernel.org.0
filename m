Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40BD72A45ED
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Nov 2020 14:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgKCNHm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Nov 2020 08:07:42 -0500
Received: from mga04.intel.com ([192.55.52.120]:17648 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728027AbgKCNGc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Nov 2020 08:06:32 -0500
IronPort-SDR: xx0nGUdD92kkgXzUctZyat3PKZPW6i1MqTw2tmn9UHYSvzOqxeg99p+SF53yYzsYhWvI2Iosqq
 DLAQtlVKqhsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="166455683"
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="166455683"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 05:06:31 -0800
IronPort-SDR: SwhB7QRI+NxOwnXikb4sX1CsQVizsDysevMeaQwNLrFpnLO/Sj7w781ckljTbKIUan0a8barZw
 MVnPHGcCfEcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="363592636"
Received: from lkp-server02.sh.intel.com (HELO e61783667810) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 03 Nov 2020 05:06:29 -0800
Received: from kbuild by e61783667810 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kZw17-0000Fb-2l; Tue, 03 Nov 2020 13:06:29 +0000
Date:   Tue, 03 Nov 2020 21:05:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-rc] BUILD SUCCESS
 00469c97ef64f6b7e3ab08c5eeb0378260baf983
Message-ID: <5fa15598.tcvErape/TwAjczl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  for-rc
branch HEAD: 00469c97ef64f6b7e3ab08c5eeb0378260baf983  RDMA/vmw_pvrdma: Fix the active_speed and phys_state value

elapsed time: 722m

configs tested: 186
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 mpc8272_ads_defconfig
um                             i386_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                        vocore2_defconfig
arm                         ebsa110_defconfig
powerpc                      pasemi_defconfig
arm64                            alldefconfig
ia64                            zx1_defconfig
mips                  cavium_octeon_defconfig
mips                     loongson1b_defconfig
arm                           h3600_defconfig
powerpc                     sequoia_defconfig
sh                        sh7757lcr_defconfig
arm                        spear3xx_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                       rbtx49xx_defconfig
arm                          exynos_defconfig
arm                        neponset_defconfig
arm                        oxnas_v6_defconfig
arc                     nsimosci_hs_defconfig
sh                          rsk7269_defconfig
powerpc                      obs600_defconfig
ia64                             alldefconfig
powerpc                    sam440ep_defconfig
powerpc                   bluestone_defconfig
arc                        vdk_hs38_defconfig
nds32                               defconfig
arm                            qcom_defconfig
ia64                          tiger_defconfig
mips                         bigsur_defconfig
mips                         db1xxx_defconfig
arm                        shmobile_defconfig
m68k                        m5407c3_defconfig
mips                        qi_lb60_defconfig
arm                            u300_defconfig
powerpc                          allmodconfig
riscv                            alldefconfig
powerpc                      arches_defconfig
powerpc                    gamecube_defconfig
powerpc                     redwood_defconfig
mips                      bmips_stb_defconfig
arm                         lubbock_defconfig
arm                        vexpress_defconfig
powerpc                     mpc512x_defconfig
arm                         axm55xx_defconfig
parisc                           alldefconfig
powerpc                    socrates_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                    ge_imp3a_defconfig
sh                          rsk7264_defconfig
powerpc                     asp8347_defconfig
powerpc                        fsp2_defconfig
arm                          ep93xx_defconfig
powerpc                  iss476-smp_defconfig
arm                     davinci_all_defconfig
arm                       omap2plus_defconfig
sh                             sh03_defconfig
arm                      pxa255-idp_defconfig
ia64                             allyesconfig
sh                          rsk7203_defconfig
powerpc                    adder875_defconfig
powerpc                      cm5200_defconfig
arm                        mvebu_v5_defconfig
m68k                          sun3x_defconfig
xtensa                         virt_defconfig
sparc                       sparc64_defconfig
m68k                       m5275evb_defconfig
m68k                        m5272c3_defconfig
xtensa                  cadence_csp_defconfig
arm                            zeus_defconfig
mips                      malta_kvm_defconfig
sh                         apsh4a3a_defconfig
powerpc                     ep8248e_defconfig
arm                          pcm027_defconfig
powerpc                     stx_gp3_defconfig
m68k                       m5475evb_defconfig
m68k                        m5307c3_defconfig
mips                           jazz_defconfig
arm                          prima2_defconfig
mips                          rb532_defconfig
powerpc64                           defconfig
arm                       imx_v6_v7_defconfig
sh                   sh7770_generic_defconfig
mips                           ip32_defconfig
arm                             mxs_defconfig
openrisc                            defconfig
powerpc                       holly_defconfig
arm                        mvebu_v7_defconfig
powerpc                    mvme5100_defconfig
powerpc                      acadia_defconfig
powerpc                     ppa8548_defconfig
arm                       spear13xx_defconfig
arm                          pxa168_defconfig
xtensa                  nommu_kc705_defconfig
h8300                     edosk2674_defconfig
arm                       mainstone_defconfig
xtensa                  audio_kc705_defconfig
powerpc                      ppc44x_defconfig
mips                           gcw0_defconfig
arm                           sama5_defconfig
m68k                          atari_defconfig
arm                         lpc18xx_defconfig
nds32                             allnoconfig
ia64                                defconfig
sh                            shmin_defconfig
ia64                             allmodconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20201103
x86_64               randconfig-a005-20201103
x86_64               randconfig-a003-20201103
x86_64               randconfig-a002-20201103
x86_64               randconfig-a006-20201103
x86_64               randconfig-a001-20201103
i386                 randconfig-a004-20201103
i386                 randconfig-a006-20201103
i386                 randconfig-a005-20201103
i386                 randconfig-a001-20201103
i386                 randconfig-a002-20201103
i386                 randconfig-a003-20201103
x86_64               randconfig-a012-20201102
x86_64               randconfig-a011-20201102
x86_64               randconfig-a013-20201102
x86_64               randconfig-a015-20201102
x86_64               randconfig-a016-20201102
x86_64               randconfig-a014-20201102
i386                 randconfig-a013-20201103
i386                 randconfig-a015-20201103
i386                 randconfig-a014-20201103
i386                 randconfig-a016-20201103
i386                 randconfig-a011-20201103
i386                 randconfig-a012-20201103
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64               randconfig-a004-20201102
x86_64               randconfig-a003-20201102
x86_64               randconfig-a002-20201102
x86_64               randconfig-a001-20201102
x86_64               randconfig-a005-20201102
x86_64               randconfig-a006-20201102
x86_64               randconfig-a012-20201103
x86_64               randconfig-a015-20201103
x86_64               randconfig-a011-20201103
x86_64               randconfig-a013-20201103
x86_64               randconfig-a014-20201103
x86_64               randconfig-a016-20201103

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
