Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D4E756AAB
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jul 2023 19:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjGQRdW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jul 2023 13:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjGQRdV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Jul 2023 13:33:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0676E91
        for <linux-rdma@vger.kernel.org>; Mon, 17 Jul 2023 10:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689615186; x=1721151186;
  h=date:from:to:cc:subject:message-id;
  bh=1bSMTmTliW7quBPV4iHs+KOw3szF+earbc6J7r3mLRA=;
  b=FL0iAFP5MEJM2PvaUrGwABekPo2l4nJOVvCj7REzhDpgfI8hfO1lIs2L
   uTkMLjJWRWBY1vYzHingUoxO6DpkcgNe9c/2Y6tYNvDtFfVaDDjHFex21
   0I8771sD4DQXqbg32dPOZ7dkHeyCM9HHyifeBUBRajqLf7t3GkW46SWwH
   rVktcNKcv7DIQEMmmxb9vAjJlpBaoVhopaj+OKGNvGzkDwsYv/lhAuwC0
   xjpFlgiF9wxYTUgGxIwA0o0iOBF+lQhOAzZMyT1yYKx3Ks+8Ek1zhZZUc
   BdVRpcPVNe33B7I6PW2gSq0P8cEPxBAX4Tnf8dQXnQfV+RB0TOkrD14Ft
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="366033402"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="366033402"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 10:33:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="788725760"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="788725760"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jul 2023 10:33:05 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qLS5o-0009lq-0x;
        Mon, 17 Jul 2023 17:33:04 +0000
Date:   Tue, 18 Jul 2023 01:32:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: [rdma:for-rc] BUILD SUCCESS
 29900bf351e1a7e4643da5c3c3cd9df75c577b88
Message-ID: <202307180139.PFBUcS0r-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: 29900bf351e1a7e4643da5c3c3cd9df75c577b88  RDMA/bnxt_re: Fix hang during driver unload

elapsed time: 724m

configs tested: 215
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230717   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r006-20230717   gcc  
arc                  randconfig-r012-20230717   gcc  
arc                  randconfig-r016-20230717   gcc  
arc                  randconfig-r036-20230717   gcc  
arc                  randconfig-r043-20230717   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                   milbeaut_m10v_defconfig   clang
arm                         mv78xx0_defconfig   clang
arm                        mvebu_v7_defconfig   gcc  
arm                          pxa168_defconfig   clang
arm                  randconfig-r005-20230717   gcc  
arm                  randconfig-r006-20230717   gcc  
arm                  randconfig-r021-20230717   clang
arm                  randconfig-r032-20230717   gcc  
arm                  randconfig-r034-20230717   gcc  
arm                  randconfig-r046-20230717   clang
arm                        realview_defconfig   gcc  
arm                           sama5_defconfig   gcc  
arm                          sp7021_defconfig   clang
arm                        spear6xx_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm                       versatile_defconfig   clang
arm                         vf610m4_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r013-20230717   gcc  
arm64                randconfig-r014-20230717   gcc  
arm64                randconfig-r021-20230717   gcc  
arm64                randconfig-r023-20230717   gcc  
arm64                randconfig-r024-20230717   gcc  
arm64                randconfig-r026-20230717   gcc  
arm64                randconfig-r034-20230717   clang
csky                                defconfig   gcc  
csky                 randconfig-r001-20230717   gcc  
csky                 randconfig-r002-20230717   gcc  
csky                 randconfig-r013-20230717   gcc  
csky                 randconfig-r023-20230717   gcc  
csky                 randconfig-r025-20230717   gcc  
hexagon              randconfig-r005-20230717   clang
hexagon              randconfig-r033-20230717   clang
hexagon              randconfig-r041-20230717   clang
hexagon              randconfig-r045-20230717   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230717   clang
i386         buildonly-randconfig-r005-20230717   clang
i386         buildonly-randconfig-r006-20230717   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230717   clang
i386                 randconfig-i002-20230717   clang
i386                 randconfig-i003-20230717   clang
i386                 randconfig-i004-20230717   clang
i386                 randconfig-i005-20230717   clang
i386                 randconfig-i006-20230717   clang
i386                 randconfig-i011-20230717   gcc  
i386                 randconfig-i012-20230717   gcc  
i386                 randconfig-i013-20230717   gcc  
i386                 randconfig-i014-20230717   gcc  
i386                 randconfig-i015-20230717   gcc  
i386                 randconfig-i016-20230717   gcc  
i386                 randconfig-r004-20230717   clang
i386                 randconfig-r005-20230717   clang
i386                 randconfig-r013-20230717   gcc  
i386                 randconfig-r015-20230717   gcc  
i386                 randconfig-r016-20230717   gcc  
i386                 randconfig-r031-20230717   clang
i386                 randconfig-r035-20230717   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230717   gcc  
loongarch            randconfig-r021-20230717   gcc  
loongarch            randconfig-r023-20230717   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                 randconfig-r012-20230717   gcc  
m68k                 randconfig-r015-20230717   gcc  
m68k                 randconfig-r032-20230717   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
microblaze           randconfig-r002-20230717   gcc  
microblaze           randconfig-r006-20230717   gcc  
microblaze           randconfig-r014-20230717   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                            gpr_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
mips                        omega2p_defconfig   clang
mips                 randconfig-r022-20230717   clang
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230717   gcc  
nios2                randconfig-r016-20230717   gcc  
nios2                randconfig-r024-20230717   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r012-20230717   gcc  
openrisc             randconfig-r013-20230717   gcc  
openrisc             randconfig-r026-20230717   gcc  
openrisc             randconfig-r032-20230717   gcc  
openrisc             randconfig-r034-20230717   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc               randconfig-r002-20230717   gcc  
parisc               randconfig-r015-20230717   gcc  
parisc               randconfig-r025-20230717   gcc  
parisc               randconfig-r031-20230717   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      chrp32_defconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc                    ge_imp3a_defconfig   clang
powerpc                 mpc8313_rdb_defconfig   clang
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                      pasemi_defconfig   gcc  
powerpc                      pmac32_defconfig   clang
powerpc                     powernv_defconfig   clang
powerpc                      ppc44x_defconfig   clang
powerpc              randconfig-r016-20230717   gcc  
powerpc                     redwood_defconfig   gcc  
powerpc                     sequoia_defconfig   gcc  
powerpc                     tqm8540_defconfig   clang
powerpc                     tqm8555_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r026-20230717   gcc  
riscv                randconfig-r033-20230717   clang
riscv                randconfig-r034-20230717   clang
riscv                randconfig-r035-20230717   clang
riscv                randconfig-r042-20230717   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230717   clang
s390                 randconfig-r002-20230717   clang
s390                 randconfig-r005-20230717   clang
s390                 randconfig-r033-20230717   clang
s390                 randconfig-r044-20230717   gcc  
sh                               allmodconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                   randconfig-r014-20230717   gcc  
sh                   randconfig-r022-20230717   gcc  
sh                   randconfig-r031-20230717   gcc  
sh                   randconfig-r036-20230717   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sh                            titan_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r011-20230717   gcc  
sparc                randconfig-r022-20230717   gcc  
sparc                randconfig-r033-20230717   gcc  
sparc                randconfig-r036-20230717   gcc  
sparc64              randconfig-r001-20230717   gcc  
sparc64              randconfig-r011-20230717   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r001-20230717   gcc  
um                   randconfig-r004-20230717   gcc  
um                   randconfig-r022-20230717   clang
um                   randconfig-r025-20230717   clang
um                   randconfig-r031-20230717   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230717   clang
x86_64       buildonly-randconfig-r002-20230717   clang
x86_64       buildonly-randconfig-r003-20230717   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r003-20230717   clang
x86_64               randconfig-r011-20230717   gcc  
x86_64               randconfig-r026-20230717   gcc  
x86_64               randconfig-x001-20230717   gcc  
x86_64               randconfig-x002-20230717   gcc  
x86_64               randconfig-x003-20230717   gcc  
x86_64               randconfig-x004-20230717   gcc  
x86_64               randconfig-x005-20230717   gcc  
x86_64               randconfig-x006-20230717   gcc  
x86_64               randconfig-x011-20230717   clang
x86_64               randconfig-x012-20230717   clang
x86_64               randconfig-x013-20230717   clang
x86_64               randconfig-x014-20230717   clang
x86_64               randconfig-x015-20230717   clang
x86_64               randconfig-x016-20230717   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa               randconfig-r024-20230717   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
