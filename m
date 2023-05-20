Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3D670A62C
	for <lists+linux-rdma@lfdr.de>; Sat, 20 May 2023 09:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjETHhm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 20 May 2023 03:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjETHhl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 20 May 2023 03:37:41 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0B0186
        for <linux-rdma@vger.kernel.org>; Sat, 20 May 2023 00:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684568259; x=1716104259;
  h=date:from:to:cc:subject:message-id;
  bh=yooIGKaylcvsuTCTa6pfkCcPgJ/v1L5F6E1JV5/9TGk=;
  b=At3rpF/Fu6UCfDnO1ArZd+C2vKPn/XyNbZzWh/t6fIuZd4Z3E07OOnbq
   44hMn2BfoN/GQ90uGBkndDHjGL3CmBJx8gwvmOnfNAu0wb7bENAi5kW3+
   nJnqyFZJ9SNpLT9l1gW2JqZs4gZws0XYfzs1cV2oM+tchljRVQKIsCG+W
   rGZxI3iItcWeYhgixIHplhhLWpkBAB3cLWDKD/UNTEbkm9d/R0udym+SI
   z4tVmdTD6TLnbKuuXc5BfPSp+3BvbLdFNplYfDpM2ac7bepNTO8HF7lkI
   mBF1TeIz2qKpu8yTFn2ZCof9tMGQmFmzcZuvjMhnk3vVSYY+45GSoGX30
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="416025089"
X-IronPort-AV: E=Sophos;i="6.00,179,1681196400"; 
   d="scan'208";a="416025089"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2023 00:37:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="735770707"
X-IronPort-AV: E=Sophos;i="6.00,179,1681196400"; 
   d="scan'208";a="735770707"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 20 May 2023 00:37:37 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q0H9l-000BOq-0W;
        Sat, 20 May 2023 07:37:37 +0000
Date:   Sat, 20 May 2023 15:36:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 8c1ee346da583718fb0a7791a1f84bdafb103caf
Message-ID: <20230520073650.zVMXk%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: INFO setup_repo_specs: /db/releases/20230519164737/lkp-src/repo/*/rdma
https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 8c1ee346da583718fb0a7791a1f84bdafb103caf  RDMA/bnxt_re: Remove unnecessary checks

elapsed time: 728m

configs tested: 189
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r014-20230517   gcc  
alpha                randconfig-r023-20230519   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                  randconfig-r004-20230517   gcc  
arc                  randconfig-r022-20230517   gcc  
arc                  randconfig-r033-20230517   gcc  
arc                  randconfig-r043-20230517   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r005-20230517   clang
arm                                 defconfig   gcc  
arm                        multi_v5_defconfig   clang
arm                         mv78xx0_defconfig   clang
arm                  randconfig-r025-20230517   clang
arm                  randconfig-r031-20230517   gcc  
arm                  randconfig-r034-20230517   gcc  
arm                  randconfig-r035-20230517   gcc  
arm                  randconfig-r036-20230517   gcc  
arm                  randconfig-r046-20230517   clang
arm                        spear3xx_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r023-20230517   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r006-20230517   gcc  
hexagon              randconfig-r012-20230517   clang
hexagon              randconfig-r016-20230517   clang
hexagon              randconfig-r031-20230517   clang
hexagon              randconfig-r041-20230517   clang
hexagon              randconfig-r045-20230517   clang
i386                             allyesconfig   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r005-20230517   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r005-20230517   gcc  
ia64                 randconfig-r013-20230517   gcc  
ia64                 randconfig-r022-20230517   gcc  
ia64                 randconfig-r025-20230519   gcc  
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230517   gcc  
loongarch            randconfig-r003-20230517   gcc  
loongarch            randconfig-r011-20230517   gcc  
loongarch            randconfig-r023-20230517   gcc  
loongarch            randconfig-r026-20230519   gcc  
loongarch            randconfig-r033-20230517   gcc  
loongarch            randconfig-r035-20230517   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r002-20230517   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r021-20230517   gcc  
m68k                 randconfig-r022-20230519   gcc  
microblaze   buildonly-randconfig-r001-20230517   gcc  
microblaze   buildonly-randconfig-r002-20230517   gcc  
microblaze           randconfig-r003-20230517   gcc  
microblaze           randconfig-r012-20230517   gcc  
microblaze           randconfig-r021-20230517   gcc  
microblaze           randconfig-r031-20230517   gcc  
microblaze           randconfig-r033-20230517   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips         buildonly-randconfig-r003-20230517   gcc  
mips                     cu1000-neo_defconfig   clang
mips                        qi_lb60_defconfig   clang
mips                 randconfig-r032-20230517   gcc  
mips                       rbtx49xx_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230517   gcc  
nios2                randconfig-r004-20230517   gcc  
nios2                randconfig-r013-20230517   gcc  
nios2                randconfig-r015-20230517   gcc  
nios2                randconfig-r021-20230519   gcc  
nios2                randconfig-r024-20230517   gcc  
openrisc     buildonly-randconfig-r004-20230517   gcc  
openrisc             randconfig-r011-20230517   gcc  
openrisc             randconfig-r012-20230517   gcc  
openrisc             randconfig-r035-20230517   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230517   gcc  
parisc               randconfig-r024-20230519   gcc  
parisc               randconfig-r026-20230517   gcc  
parisc               randconfig-r032-20230517   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   bluestone_defconfig   clang
powerpc                 canyonlands_defconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                      katmai_defconfig   clang
powerpc                      mgcoge_defconfig   gcc  
powerpc                 mpc8315_rdb_defconfig   clang
powerpc              randconfig-r011-20230517   gcc  
powerpc              randconfig-r013-20230517   gcc  
powerpc              randconfig-r016-20230517   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                     sequoia_defconfig   gcc  
powerpc                     tqm8548_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r003-20230517   clang
riscv                randconfig-r005-20230517   clang
riscv                randconfig-r023-20230517   gcc  
riscv                randconfig-r024-20230517   gcc  
riscv                randconfig-r034-20230517   clang
riscv                randconfig-r042-20230517   gcc  
riscv                          rv32_defconfig   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230517   clang
s390                 randconfig-r021-20230517   gcc  
s390                 randconfig-r044-20230517   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r006-20230517   gcc  
sh                          r7780mp_defconfig   gcc  
sh                   randconfig-r002-20230517   gcc  
sh                   randconfig-r015-20230517   gcc  
sh                   randconfig-r022-20230517   gcc  
sh                   randconfig-r025-20230517   gcc  
sh                   randconfig-r036-20230517   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230517   gcc  
sparc                randconfig-r024-20230517   gcc  
sparc64      buildonly-randconfig-r004-20230517   gcc  
sparc64              randconfig-r016-20230517   gcc  
sparc64              randconfig-r026-20230517   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                        randconfig-k001   clang
x86_64                        randconfig-x051   gcc  
x86_64                        randconfig-x052   clang
x86_64                        randconfig-x053   gcc  
x86_64                        randconfig-x054   clang
x86_64                        randconfig-x055   gcc  
x86_64                        randconfig-x056   clang
x86_64                        randconfig-x061   gcc  
x86_64                        randconfig-x062   clang
x86_64                        randconfig-x063   gcc  
x86_64                        randconfig-x064   clang
x86_64                        randconfig-x065   gcc  
x86_64                        randconfig-x066   clang
x86_64                               rhel-8.3   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa       buildonly-randconfig-r003-20230517   gcc  
xtensa               randconfig-r001-20230517   gcc  
xtensa               randconfig-r006-20230517   gcc  
xtensa               randconfig-r014-20230517   gcc  
xtensa               randconfig-r032-20230517   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
