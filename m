Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB732B7D6B
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Nov 2020 13:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgKRMMc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Nov 2020 07:12:32 -0500
Received: from mga02.intel.com ([134.134.136.20]:54811 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727314AbgKRMMc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Nov 2020 07:12:32 -0500
IronPort-SDR: UncfS2zQo/DM2739C3hktYFzIVIwh3ycxrAjWcDEzNMPy9McwYYRIQonZ8HVpXi4DcBNfcWtuo
 XMkp6HJMsIRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="158137716"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="158137716"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 04:12:31 -0800
IronPort-SDR: R+A7hpF7+EuT7+X6UEEODnbBjVVYOee36TxH3CEwyPEuoNNpcQ088uAgN9spBThAlKZqf1KFZT
 rzosCMh412dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="325553667"
Received: from lkp-server02.sh.intel.com (HELO 67996b229c47) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 18 Nov 2020 04:12:30 -0800
Received: from kbuild by 67996b229c47 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kfMK5-00004Z-H6; Wed, 18 Nov 2020 12:12:29 +0000
Date:   Wed, 18 Nov 2020 20:12:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 ee415d73dcc24caef7f6bbf292dcc365613d2188
Message-ID: <5fb50f95.92e6HOluJfTimkQT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-rc
branch HEAD: ee415d73dcc24caef7f6bbf292dcc365613d2188  tools/testing/scatterlist: Fix test to compile and run

elapsed time: 724m

configs tested: 174
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          rsk7269_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                        edosk7760_defconfig
sh                         microdev_defconfig
sh                            shmin_defconfig
sh                            migor_defconfig
nios2                            alldefconfig
arc                           tb10x_defconfig
sh                              ul2_defconfig
arm                          lpd270_defconfig
sh                 kfr2r09-romimage_defconfig
arm                           corgi_defconfig
powerpc64                           defconfig
powerpc                     rainier_defconfig
powerpc                     mpc5200_defconfig
m68k                            mac_defconfig
arm                          tango4_defconfig
arm                        spear3xx_defconfig
powerpc                      mgcoge_defconfig
mips                           mtx1_defconfig
powerpc                    ge_imp3a_defconfig
arm                          gemini_defconfig
xtensa                    xip_kc705_defconfig
powerpc                     ksi8560_defconfig
microblaze                    nommu_defconfig
arm                          exynos_defconfig
mips                 decstation_r4k_defconfig
mips                      maltasmvp_defconfig
mips                           ci20_defconfig
arc                         haps_hs_defconfig
sh                   sh7770_generic_defconfig
mips                      loongson3_defconfig
arm                            mps2_defconfig
arc                     nsimosci_hs_defconfig
mips                            ar7_defconfig
powerpc                      cm5200_defconfig
mips                          malta_defconfig
openrisc                    or1ksim_defconfig
arm                         hackkit_defconfig
m68k                         apollo_defconfig
mips                          rm200_defconfig
mips                  decstation_64_defconfig
sh                            hp6xx_defconfig
arm                         shannon_defconfig
h8300                       h8s-sim_defconfig
sh                   sh7724_generic_defconfig
powerpc                    klondike_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                    gamecube_defconfig
arm                       mainstone_defconfig
mips                       bmips_be_defconfig
xtensa                       common_defconfig
arm                        neponset_defconfig
arm                            zeus_defconfig
arm                        clps711x_defconfig
sh                         ap325rxa_defconfig
mips                     cu1000-neo_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                          rsk7203_defconfig
powerpc                      pcm030_defconfig
openrisc                         alldefconfig
sparc                               defconfig
powerpc                     kilauea_defconfig
powerpc                    adder875_defconfig
m68k                         amcore_defconfig
mips                            e55_defconfig
arm                         socfpga_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                               j2_defconfig
xtensa                  cadence_csp_defconfig
sh                          polaris_defconfig
arm                            lart_defconfig
arm                          prima2_defconfig
h8300                            alldefconfig
mips                      bmips_stb_defconfig
arm                           h5000_defconfig
s390                             alldefconfig
i386                                defconfig
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
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                             allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201117
i386                 randconfig-a005-20201117
i386                 randconfig-a001-20201117
i386                 randconfig-a002-20201117
i386                 randconfig-a004-20201117
i386                 randconfig-a003-20201117
i386                 randconfig-a006-20201118
i386                 randconfig-a005-20201118
i386                 randconfig-a002-20201118
i386                 randconfig-a001-20201118
i386                 randconfig-a003-20201118
i386                 randconfig-a004-20201118
x86_64               randconfig-a005-20201118
x86_64               randconfig-a003-20201118
x86_64               randconfig-a004-20201118
x86_64               randconfig-a002-20201118
x86_64               randconfig-a006-20201118
x86_64               randconfig-a001-20201118
i386                 randconfig-a012-20201117
i386                 randconfig-a014-20201117
i386                 randconfig-a016-20201117
i386                 randconfig-a011-20201117
i386                 randconfig-a013-20201117
i386                 randconfig-a012-20201118
i386                 randconfig-a014-20201118
i386                 randconfig-a016-20201118
i386                 randconfig-a011-20201118
i386                 randconfig-a013-20201118
i386                 randconfig-a015-20201118
i386                 randconfig-a015-20201117
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
x86_64               randconfig-a003-20201117
x86_64               randconfig-a005-20201117
x86_64               randconfig-a004-20201117
x86_64               randconfig-a002-20201117
x86_64               randconfig-a001-20201117
x86_64               randconfig-a006-20201117
x86_64               randconfig-a015-20201116
x86_64               randconfig-a011-20201116
x86_64               randconfig-a014-20201116
x86_64               randconfig-a013-20201116
x86_64               randconfig-a016-20201116
x86_64               randconfig-a012-20201116
x86_64               randconfig-a015-20201118
x86_64               randconfig-a014-20201118
x86_64               randconfig-a011-20201118
x86_64               randconfig-a013-20201118
x86_64               randconfig-a016-20201118
x86_64               randconfig-a012-20201118

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
