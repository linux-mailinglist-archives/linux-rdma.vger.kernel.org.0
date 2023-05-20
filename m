Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8A370A57B
	for <lists+linux-rdma@lfdr.de>; Sat, 20 May 2023 07:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjETFHl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 20 May 2023 01:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjETFHh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 20 May 2023 01:07:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C12E42
        for <linux-rdma@vger.kernel.org>; Fri, 19 May 2023 22:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684559256; x=1716095256;
  h=date:from:to:cc:subject:message-id;
  bh=KQ9dF6fxDtK7oAeVapDqnbxtepJevQ+e4T/GcdiUX0Y=;
  b=G0e3xpjqBjX/H0NWpNkqglz51yEfie/9TOBnmTxBkS5h31pyJrCCo5XY
   zq6VbiF0PZwkW31pR3FcL83M5CeI3stqQSXONJHlnKV3xsTi4z+6JmAuT
   bUx5x4i6N/qX10bD7uhLHjFzyT3WBoNu8IvPIxR6rtmXuQUpmZhZCv0k2
   0p0ivAlEexAEm2caS/CcoYWlLDpNYaILVO7WP/2QUMgcixey9iPHKqRvL
   sfnU3fdEfv1BT6/eJTje4OHdvg6xpdq5DtzBbad2hsEb4xg/lJ9APBqm1
   X5M5+knZq/Zc0+AVub+WCfokeAIE1ndBay6XdT7+o/IDFdXF1FC05pJ9H
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="332155731"
X-IronPort-AV: E=Sophos;i="6.00,178,1681196400"; 
   d="scan'208";a="332155731"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 22:07:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="735744063"
X-IronPort-AV: E=Sophos;i="6.00,178,1681196400"; 
   d="scan'208";a="735744063"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 19 May 2023 22:07:34 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q0EoX-000BKQ-2x;
        Sat, 20 May 2023 05:07:33 +0000
Date:   Sat, 20 May 2023 13:06:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 dd5fb04857d7346c9ea4901ec3ebe5b90b0e8868
Message-ID: <20230520050641.uBIh-%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: INFO setup_repo_specs: /db/releases/20230519164737/lkp-src/repo/*/rdma
https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-rc
branch HEAD: dd5fb04857d7346c9ea4901ec3ebe5b90b0e8868  RDMA/bnxt_re: Do not enable congestion control on VFs

elapsed time: 726m

configs tested: 193
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r023-20230519   gcc  
alpha                randconfig-r025-20230519   gcc  
alpha                randconfig-r034-20230517   gcc  
alpha                randconfig-r035-20230517   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r006-20230517   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                  randconfig-r003-20230517   gcc  
arc                  randconfig-r004-20230517   gcc  
arc                  randconfig-r026-20230519   gcc  
arc                  randconfig-r043-20230517   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                        multi_v5_defconfig   clang
arm                         mv78xx0_defconfig   clang
arm                  randconfig-r034-20230517   gcc  
arm                  randconfig-r036-20230517   gcc  
arm                  randconfig-r046-20230517   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r006-20230517   clang
arm64                randconfig-r014-20230517   gcc  
arm64                randconfig-r015-20230517   gcc  
csky         buildonly-randconfig-r005-20230517   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230517   gcc  
hexagon              randconfig-r021-20230519   clang
hexagon              randconfig-r035-20230517   clang
hexagon              randconfig-r041-20230517   clang
hexagon              randconfig-r045-20230517   clang
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
ia64         buildonly-randconfig-r004-20230517   gcc  
ia64         buildonly-randconfig-r005-20230517   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r025-20230519   gcc  
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230517   gcc  
loongarch            randconfig-r005-20230517   gcc  
loongarch            randconfig-r011-20230517   gcc  
loongarch            randconfig-r026-20230519   gcc  
loongarch            randconfig-r033-20230517   gcc  
loongarch            randconfig-r035-20230517   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r002-20230517   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                 randconfig-r014-20230517   gcc  
m68k                 randconfig-r021-20230517   gcc  
m68k                 randconfig-r022-20230519   gcc  
m68k                 randconfig-r023-20230517   gcc  
microblaze   buildonly-randconfig-r001-20230517   gcc  
microblaze   buildonly-randconfig-r003-20230517   gcc  
microblaze           randconfig-r003-20230517   gcc  
microblaze           randconfig-r012-20230517   gcc  
microblaze           randconfig-r031-20230517   gcc  
microblaze           randconfig-r033-20230517   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips         buildonly-randconfig-r003-20230517   gcc  
mips                     decstation_defconfig   gcc  
mips                 randconfig-r036-20230517   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230517   gcc  
nios2                randconfig-r013-20230517   gcc  
nios2                randconfig-r021-20230519   gcc  
nios2                randconfig-r023-20230519   gcc  
nios2                randconfig-r024-20230517   gcc  
nios2                randconfig-r032-20230517   gcc  
openrisc     buildonly-randconfig-r004-20230517   gcc  
openrisc                  or1klitex_defconfig   gcc  
openrisc             randconfig-r013-20230517   gcc  
openrisc             randconfig-r026-20230517   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230517   gcc  
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
powerpc              randconfig-r022-20230519   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                     sequoia_defconfig   gcc  
powerpc                     tqm8548_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230517   clang
riscv                randconfig-r002-20230517   clang
riscv                randconfig-r005-20230517   clang
riscv                randconfig-r023-20230517   gcc  
riscv                randconfig-r032-20230517   clang
riscv                randconfig-r042-20230517   gcc  
riscv                          rv32_defconfig   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r031-20230517   clang
s390                 randconfig-r044-20230517   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r004-20230517   gcc  
sh           buildonly-randconfig-r005-20230517   gcc  
sh           buildonly-randconfig-r006-20230517   gcc  
sh                          r7780mp_defconfig   gcc  
sh                   randconfig-r002-20230517   gcc  
sh                   randconfig-r015-20230517   gcc  
sh                   randconfig-r022-20230517   gcc  
sh                   randconfig-r025-20230517   gcc  
sh                   randconfig-r034-20230517   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r006-20230517   gcc  
sparc                randconfig-r016-20230517   gcc  
sparc                randconfig-r024-20230517   gcc  
sparc                randconfig-r024-20230519   gcc  
sparc                randconfig-r031-20230517   gcc  
sparc64              randconfig-r012-20230517   gcc  
sparc64              randconfig-r016-20230517   gcc  
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
xtensa       buildonly-randconfig-r001-20230517   gcc  
xtensa       buildonly-randconfig-r002-20230517   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa               randconfig-r002-20230517   gcc  
xtensa               randconfig-r006-20230517   gcc  
xtensa               randconfig-r021-20230517   gcc  
xtensa               randconfig-r031-20230517   gcc  
xtensa               randconfig-r035-20230517   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
