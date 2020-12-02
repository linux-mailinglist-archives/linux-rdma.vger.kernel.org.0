Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F409C2CC0C6
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Dec 2020 16:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgLBP0c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Dec 2020 10:26:32 -0500
Received: from mga06.intel.com ([134.134.136.31]:31828 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbgLBP0c (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Dec 2020 10:26:32 -0500
IronPort-SDR: Q2zl44AgRIKGghmhHLMokekPmhCuzyGetf2iJ8yc/f3oyLCIZKkE3hKeuTNBR94CdDiV4v51qe
 3wLCdmHnZ/MQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="234638080"
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="234638080"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 07:25:50 -0800
IronPort-SDR: TVx+KykHKdEsaKuA4FI0JHZbodjJ3nlILeruPJOJiG0HjxXdMIhuiqUTqhYbrl3DBJWKruWXkb
 DKAt+6G1DITQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="335594605"
Received: from lkp-server01.sh.intel.com (HELO 54133fc185c3) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 Dec 2020 07:25:48 -0800
Received: from kbuild by 54133fc185c3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kkU0q-0000BO-4X; Wed, 02 Dec 2020 15:25:48 +0000
Date:   Wed, 02 Dec 2020 23:25:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 87524494a7d939e6e120e893e2bdcc35599dfda1
Message-ID: <5fc7b1f9.P9A/KihvDK9LGFkC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: 87524494a7d939e6e120e893e2bdcc35599dfda1  RDMA/efa: Use dma_set_mask_and_coherent() to simplify code

elapsed time: 830m

configs tested: 151
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                         ps3_defconfig
mips                malta_qemu_32r6_defconfig
x86_64                           alldefconfig
mips                          ath25_defconfig
sh                          rsk7201_defconfig
openrisc                         alldefconfig
sh                               j2_defconfig
mips                       capcella_defconfig
arm                           viper_defconfig
c6x                        evmc6474_defconfig
riscv                    nommu_k210_defconfig
arm                          pxa3xx_defconfig
c6x                        evmc6457_defconfig
m68k                            q40_defconfig
arc                        nsim_700_defconfig
sh                           se7705_defconfig
m68k                         apollo_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                        realview_defconfig
microblaze                          defconfig
nios2                               defconfig
mips                malta_kvm_guest_defconfig
sh                ecovec24-romimage_defconfig
powerpc                         wii_defconfig
arm                      integrator_defconfig
arm                          imote2_defconfig
mips                           ip28_defconfig
powerpc                  mpc866_ads_defconfig
mips                          rm200_defconfig
arm                              zx_defconfig
mips                           gcw0_defconfig
xtensa                         virt_defconfig
c6x                        evmc6678_defconfig
sh                             shx3_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                     tqm5200_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                    mvme5100_defconfig
s390                                defconfig
m68k                       m5208evb_defconfig
m68k                        mvme16x_defconfig
m68k                          atari_defconfig
arc                        nsimosci_defconfig
powerpc                        fsp2_defconfig
powerpc                      ppc40x_defconfig
h8300                               defconfig
powerpc                      ppc44x_defconfig
arm                              alldefconfig
powerpc                     mpc5200_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                       ebony_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                           se7343_defconfig
sh                           se7750_defconfig
arm                        shmobile_defconfig
openrisc                            defconfig
xtensa                  cadence_csp_defconfig
powerpc                      pasemi_defconfig
arm                      footbridge_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                      fuloong2e_defconfig
sparc                            allyesconfig
sparc                       sparc64_defconfig
arm                        vexpress_defconfig
powerpc                       eiger_defconfig
powerpc                  storcenter_defconfig
parisc                generic-32bit_defconfig
mips                    maltaup_xpa_defconfig
mips                            e55_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201201
i386                 randconfig-a005-20201201
i386                 randconfig-a001-20201201
i386                 randconfig-a002-20201201
i386                 randconfig-a006-20201201
i386                 randconfig-a003-20201201
x86_64               randconfig-a016-20201201
x86_64               randconfig-a012-20201201
x86_64               randconfig-a014-20201201
x86_64               randconfig-a013-20201201
x86_64               randconfig-a015-20201201
x86_64               randconfig-a011-20201201
i386                 randconfig-a014-20201202
i386                 randconfig-a013-20201202
i386                 randconfig-a011-20201202
i386                 randconfig-a015-20201202
i386                 randconfig-a012-20201202
i386                 randconfig-a016-20201202
i386                 randconfig-a014-20201201
i386                 randconfig-a013-20201201
i386                 randconfig-a011-20201201
i386                 randconfig-a015-20201201
i386                 randconfig-a012-20201201
i386                 randconfig-a016-20201201
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
x86_64               randconfig-a004-20201201
x86_64               randconfig-a006-20201201
x86_64               randconfig-a001-20201201
x86_64               randconfig-a002-20201201
x86_64               randconfig-a005-20201201
x86_64               randconfig-a003-20201201
x86_64               randconfig-a016-20201202
x86_64               randconfig-a012-20201202
x86_64               randconfig-a014-20201202
x86_64               randconfig-a013-20201202
x86_64               randconfig-a015-20201202
x86_64               randconfig-a011-20201202

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
