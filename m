Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596C72CC0C5
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Dec 2020 16:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgLBP0b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Dec 2020 10:26:31 -0500
Received: from mga11.intel.com ([192.55.52.93]:26663 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727920AbgLBP0b (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Dec 2020 10:26:31 -0500
IronPort-SDR: VQ3MuZvECJ9fyLosXBWOu8qBflTydYiWdRmsCIaQ1u0QlxmPh6TPYg0E3FWV82pd7lDFxpOiT9
 wLRGcn4Em0ww==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="169528549"
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="169528549"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 07:25:50 -0800
IronPort-SDR: XN4RVRB5rTvsTWDWL1fjGsdEuxZY51Hys2lTkKolYros+RKGZP6vYuJqvgZ+A4nDYlzDUgpJo2
 Jy2nAEZSttBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="316126758"
Received: from lkp-server01.sh.intel.com (HELO 54133fc185c3) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 02 Dec 2020 07:25:49 -0800
Received: from kbuild by 54133fc185c3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kkU0q-0000BR-Gb; Wed, 02 Dec 2020 15:25:48 +0000
Date:   Wed, 02 Dec 2020 23:25:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 93416ab0f994f6cf16fa0c695577f8b19d30c533
Message-ID: <5fc7b1f2.OUBfKikI5yFz/PcL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-rc
branch HEAD: 93416ab0f994f6cf16fa0c695577f8b19d30c533  RDMA/efa: Use the correct current and new states in modify QP

elapsed time: 830m

configs tested: 193
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
powerpc                  mpc885_ads_defconfig
arm                           stm32_defconfig
powerpc                      pmac32_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                          pxa3xx_defconfig
c6x                        evmc6457_defconfig
m68k                            q40_defconfig
arc                        nsim_700_defconfig
riscv                    nommu_k210_defconfig
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
sh                          sdk7786_defconfig
arm                           u8500_defconfig
sparc64                          alldefconfig
m68k                            mac_defconfig
mips                           gcw0_defconfig
xtensa                         virt_defconfig
c6x                        evmc6678_defconfig
sh                             shx3_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                     tqm5200_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                    mvme5100_defconfig
s390                                defconfig
arm                         s3c6400_defconfig
sparc                               defconfig
powerpc                     sequoia_defconfig
powerpc                 canyonlands_defconfig
arm                         nhk8815_defconfig
sh                         ap325rxa_defconfig
m68k                       m5475evb_defconfig
c6x                                 defconfig
powerpc                     ep8248e_defconfig
arm                          pcm027_defconfig
mips                           ip22_defconfig
m68k                       m5208evb_defconfig
m68k                        mvme16x_defconfig
m68k                          atari_defconfig
arc                        nsimosci_defconfig
sh                           se7722_defconfig
sh                   sh7724_generic_defconfig
arm                        magician_defconfig
arm                          exynos_defconfig
riscv                               defconfig
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
arm                         lpc18xx_defconfig
nios2                         10m50_defconfig
mips                       lemote2f_defconfig
mips                 decstation_r4k_defconfig
arm                     davinci_all_defconfig
powerpc                 mpc834x_itx_defconfig
sh                        apsh4ad0a_defconfig
sh                  sh7785lcr_32bit_defconfig
m68k                        m5407c3_defconfig
arm                       cns3420vb_defconfig
powerpc                 linkstation_defconfig
ia64                          tiger_defconfig
s390                             alldefconfig
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
i386                 randconfig-a004-20201202
i386                 randconfig-a005-20201202
i386                 randconfig-a001-20201202
i386                 randconfig-a002-20201202
i386                 randconfig-a006-20201202
i386                 randconfig-a003-20201202
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
x86_64               randconfig-a004-20201202
x86_64               randconfig-a006-20201202
x86_64               randconfig-a001-20201202
x86_64               randconfig-a002-20201202
x86_64               randconfig-a005-20201202
x86_64               randconfig-a003-20201202
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
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
