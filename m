Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F16786E33
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Aug 2023 13:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240239AbjHXLoE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Aug 2023 07:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241134AbjHXLoB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Aug 2023 07:44:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651921736
        for <linux-rdma@vger.kernel.org>; Thu, 24 Aug 2023 04:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692877439; x=1724413439;
  h=date:from:to:cc:subject:message-id;
  bh=sNYzuUKiaT+vxUUaoqNhh/Nvgep249nEzPi1U0e37tc=;
  b=L3Qa5gALK+D3r51fe3I9NNnki9kllfiun4gIzIrsB5yiWISDKeTWmzqn
   ZKxBZGPxAtQ104Md/L7rsdfHMdauu8iD8iES413wPdsaGAMm58fVMLXQX
   E5oyvW1bHpZQbo2HlnM8OSUONzansD3yWddDx0Bk54rrVqPS5vT+MFyGA
   4APtkFjc3U0anRxog2QOJebfAYZvz0KoPsDqKYYyWp1lOgBngFz0Op25Y
   HP4RnS3AxGeh4jyls8pIa9J2J6T+xVV9ZVrMU89skO5EFwPjUk20c0/8U
   /iybcMhuy4cqMFGH/Uy0IdrxknXSn6PTlOHk3i3v1CJJaWKJYcMVckHx1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="354745287"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="354745287"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 04:43:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="686835595"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="686835595"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 24 Aug 2023 04:43:56 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZ8kl-00021l-34;
        Thu, 24 Aug 2023 11:43:55 +0000
Date:   Thu, 24 Aug 2023 19:43:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 f5acc36b0714b7b8510a8b436087d33a65cb05f4
Message-ID: <202308241945.hSrouuA3-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: f5acc36b0714b7b8510a8b436087d33a65cb05f4  IB/hfi1: Reduce printing of errors during driver shut down

elapsed time: 2671m

configs tested: 437
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230823   gcc  
alpha                randconfig-r002-20230824   gcc  
alpha                randconfig-r003-20230824   gcc  
alpha                randconfig-r006-20230823   gcc  
alpha                randconfig-r014-20230823   gcc  
alpha                randconfig-r014-20230824   gcc  
alpha                randconfig-r015-20230823   gcc  
alpha                randconfig-r034-20230823   gcc  
alpha                randconfig-r035-20230823   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                   randconfig-001-20230824   gcc  
arc                  randconfig-r011-20230823   gcc  
arc                  randconfig-r012-20230823   gcc  
arc                  randconfig-r013-20230823   gcc  
arc                  randconfig-r023-20230824   gcc  
arc                  randconfig-r025-20230824   gcc  
arc                  randconfig-r034-20230823   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                         bcm2835_defconfig   gcc  
arm                                 defconfig   gcc  
arm                            dove_defconfig   clang
arm                           h3600_defconfig   gcc  
arm                       imx_v4_v5_defconfig   clang
arm                      integrator_defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                            mps2_defconfig   gcc  
arm                        mvebu_v5_defconfig   clang
arm                          pxa3xx_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20230823   clang
arm                   randconfig-001-20230824   gcc  
arm                  randconfig-r001-20230823   gcc  
arm                  randconfig-r002-20230823   gcc  
arm                  randconfig-r003-20230823   gcc  
arm                  randconfig-r013-20230824   gcc  
arm                  randconfig-r016-20230824   gcc  
arm                  randconfig-r024-20230824   gcc  
arm                  randconfig-r025-20230823   clang
arm                        shmobile_defconfig   gcc  
arm                           sunxi_defconfig   gcc  
arm                       versatile_defconfig   gcc  
arm                    vt8500_v6_v7_defconfig   clang
arm                         wpcm450_defconfig   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r006-20230823   clang
arm64                randconfig-r015-20230823   gcc  
arm64                randconfig-r021-20230823   gcc  
arm64                randconfig-r026-20230823   gcc  
arm64                randconfig-r031-20230823   clang
arm64                randconfig-r036-20230823   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230823   gcc  
csky                 randconfig-r011-20230824   gcc  
csky                 randconfig-r012-20230823   gcc  
csky                 randconfig-r014-20230823   gcc  
csky                 randconfig-r015-20230823   gcc  
csky                 randconfig-r021-20230823   gcc  
csky                 randconfig-r023-20230824   gcc  
csky                 randconfig-r031-20230823   gcc  
hexagon               randconfig-001-20230823   clang
hexagon               randconfig-001-20230824   clang
hexagon               randconfig-002-20230823   clang
hexagon               randconfig-002-20230824   clang
hexagon              randconfig-r002-20230823   clang
hexagon              randconfig-r002-20230824   clang
hexagon              randconfig-r003-20230823   clang
hexagon              randconfig-r014-20230823   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230823   clang
i386         buildonly-randconfig-001-20230824   gcc  
i386         buildonly-randconfig-002-20230823   clang
i386         buildonly-randconfig-002-20230824   gcc  
i386         buildonly-randconfig-003-20230823   clang
i386         buildonly-randconfig-003-20230824   gcc  
i386         buildonly-randconfig-004-20230823   clang
i386         buildonly-randconfig-004-20230824   gcc  
i386         buildonly-randconfig-005-20230823   clang
i386         buildonly-randconfig-005-20230824   gcc  
i386         buildonly-randconfig-006-20230823   clang
i386         buildonly-randconfig-006-20230824   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230823   clang
i386                  randconfig-001-20230824   gcc  
i386                  randconfig-002-20230823   clang
i386                  randconfig-002-20230824   gcc  
i386                  randconfig-003-20230823   clang
i386                  randconfig-003-20230824   gcc  
i386                  randconfig-004-20230823   clang
i386                  randconfig-004-20230824   gcc  
i386                  randconfig-005-20230823   clang
i386                  randconfig-005-20230824   gcc  
i386                  randconfig-006-20230823   clang
i386                  randconfig-006-20230824   gcc  
i386                  randconfig-011-20230823   gcc  
i386                  randconfig-011-20230824   clang
i386                  randconfig-012-20230823   gcc  
i386                  randconfig-012-20230824   clang
i386                  randconfig-013-20230823   gcc  
i386                  randconfig-013-20230824   clang
i386                  randconfig-014-20230823   gcc  
i386                  randconfig-014-20230824   clang
i386                  randconfig-015-20230823   gcc  
i386                  randconfig-015-20230824   clang
i386                  randconfig-016-20230823   gcc  
i386                  randconfig-016-20230824   clang
i386                 randconfig-r004-20230824   gcc  
i386                 randconfig-r011-20230823   gcc  
i386                 randconfig-r013-20230823   gcc  
i386                 randconfig-r014-20230823   gcc  
i386                 randconfig-r016-20230823   gcc  
i386                 randconfig-r022-20230823   gcc  
i386                 randconfig-r025-20230823   gcc  
i386                 randconfig-r031-20230824   gcc  
i386                 randconfig-r035-20230824   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230823   gcc  
loongarch             randconfig-001-20230824   gcc  
loongarch            randconfig-r001-20230823   gcc  
loongarch            randconfig-r005-20230824   gcc  
loongarch            randconfig-r006-20230824   gcc  
loongarch            randconfig-r013-20230823   gcc  
loongarch            randconfig-r024-20230823   gcc  
loongarch            randconfig-r036-20230823   gcc  
m68k                             alldefconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                 randconfig-r004-20230823   gcc  
m68k                 randconfig-r005-20230824   gcc  
m68k                 randconfig-r023-20230823   gcc  
m68k                 randconfig-r024-20230824   gcc  
m68k                           virt_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r003-20230823   gcc  
microblaze           randconfig-r004-20230824   gcc  
microblaze           randconfig-r006-20230823   gcc  
microblaze           randconfig-r012-20230823   gcc  
microblaze           randconfig-r014-20230823   gcc  
microblaze           randconfig-r022-20230824   gcc  
microblaze           randconfig-r025-20230823   gcc  
microblaze           randconfig-r032-20230824   gcc  
microblaze           randconfig-r034-20230823   gcc  
microblaze           randconfig-r036-20230823   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                           ip32_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
mips                        omega2p_defconfig   clang
mips                      pic32mzda_defconfig   clang
mips                 randconfig-r002-20230823   gcc  
mips                 randconfig-r003-20230823   gcc  
mips                 randconfig-r004-20230823   gcc  
mips                 randconfig-r006-20230823   gcc  
mips                 randconfig-r012-20230824   gcc  
mips                 randconfig-r021-20230823   clang
mips                 randconfig-r021-20230824   gcc  
mips                 randconfig-r031-20230824   clang
mips                 randconfig-r032-20230823   gcc  
mips                 randconfig-r034-20230824   clang
mips                 randconfig-r036-20230824   clang
mips                           rs90_defconfig   clang
mips                           xway_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230823   gcc  
nios2                randconfig-r005-20230823   gcc  
nios2                randconfig-r011-20230823   gcc  
nios2                randconfig-r015-20230823   gcc  
nios2                randconfig-r016-20230823   gcc  
nios2                randconfig-r022-20230824   gcc  
nios2                randconfig-r032-20230823   gcc  
nios2                randconfig-r034-20230823   gcc  
openrisc                         alldefconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc             randconfig-r003-20230823   gcc  
openrisc             randconfig-r003-20230824   gcc  
openrisc             randconfig-r005-20230823   gcc  
openrisc             randconfig-r006-20230824   gcc  
openrisc             randconfig-r015-20230823   gcc  
openrisc             randconfig-r023-20230823   gcc  
openrisc             randconfig-r026-20230824   gcc  
openrisc             randconfig-r034-20230824   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc               randconfig-r001-20230823   gcc  
parisc               randconfig-r002-20230823   gcc  
parisc               randconfig-r004-20230823   gcc  
parisc               randconfig-r006-20230823   gcc  
parisc               randconfig-r012-20230823   gcc  
parisc               randconfig-r013-20230823   gcc  
parisc               randconfig-r013-20230824   gcc  
parisc               randconfig-r025-20230823   gcc  
parisc               randconfig-r025-20230824   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                     asp8347_defconfig   gcc  
powerpc                      bamboo_defconfig   gcc  
powerpc                        cell_defconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                          g5_defconfig   gcc  
powerpc                    ge_imp3a_defconfig   clang
powerpc                   lite5200b_defconfig   clang
powerpc                       maple_defconfig   gcc  
powerpc                   microwatt_defconfig   clang
powerpc                   motionpro_defconfig   gcc  
powerpc                     mpc5200_defconfig   clang
powerpc                      pasemi_defconfig   gcc  
powerpc                      ppc40x_defconfig   gcc  
powerpc                     rainier_defconfig   gcc  
powerpc              randconfig-r003-20230823   clang
powerpc              randconfig-r005-20230823   clang
powerpc              randconfig-r016-20230823   gcc  
powerpc              randconfig-r021-20230823   gcc  
powerpc              randconfig-r031-20230823   clang
powerpc              randconfig-r035-20230823   clang
powerpc                     tqm8555_defconfig   gcc  
powerpc64            randconfig-r001-20230823   clang
powerpc64            randconfig-r002-20230823   clang
powerpc64            randconfig-r004-20230823   clang
powerpc64            randconfig-r014-20230823   gcc  
powerpc64            randconfig-r015-20230824   clang
powerpc64            randconfig-r021-20230824   clang
powerpc64            randconfig-r022-20230823   gcc  
powerpc64            randconfig-r032-20230823   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_virt_defconfig   gcc  
riscv                 randconfig-001-20230823   clang
riscv                 randconfig-001-20230824   gcc  
riscv                randconfig-r004-20230823   clang
riscv                randconfig-r013-20230823   gcc  
riscv                randconfig-r022-20230823   gcc  
riscv                randconfig-r023-20230823   gcc  
riscv                          rv32_defconfig   gcc  
s390                             alldefconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230824   clang
s390                 randconfig-r001-20230824   gcc  
s390                 randconfig-r002-20230823   clang
s390                 randconfig-r011-20230823   gcc  
s390                 randconfig-r013-20230823   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                   randconfig-r002-20230823   gcc  
sh                   randconfig-r006-20230823   gcc  
sh                   randconfig-r014-20230824   gcc  
sh                   randconfig-r022-20230823   gcc  
sh                   randconfig-r024-20230823   gcc  
sh                   randconfig-r026-20230823   gcc  
sh                   randconfig-r033-20230823   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          rsk7203_defconfig   gcc  
sh                          rsk7264_defconfig   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r004-20230823   gcc  
sparc                randconfig-r011-20230824   gcc  
sparc                randconfig-r016-20230824   gcc  
sparc                randconfig-r024-20230823   gcc  
sparc                randconfig-r025-20230823   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r001-20230824   gcc  
sparc64              randconfig-r003-20230823   gcc  
sparc64              randconfig-r016-20230823   gcc  
sparc64              randconfig-r022-20230823   gcc  
sparc64              randconfig-r024-20230823   gcc  
sparc64              randconfig-r026-20230823   gcc  
sparc64              randconfig-r032-20230823   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r005-20230823   gcc  
um                   randconfig-r014-20230823   clang
um                   randconfig-r024-20230823   clang
um                   randconfig-r025-20230823   clang
um                   randconfig-r031-20230823   gcc  
um                   randconfig-r033-20230824   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230823   clang
x86_64       buildonly-randconfig-001-20230824   gcc  
x86_64       buildonly-randconfig-002-20230823   clang
x86_64       buildonly-randconfig-002-20230824   gcc  
x86_64       buildonly-randconfig-003-20230823   clang
x86_64       buildonly-randconfig-003-20230824   gcc  
x86_64       buildonly-randconfig-004-20230823   clang
x86_64       buildonly-randconfig-004-20230824   gcc  
x86_64       buildonly-randconfig-005-20230823   clang
x86_64       buildonly-randconfig-005-20230824   gcc  
x86_64       buildonly-randconfig-006-20230823   clang
x86_64       buildonly-randconfig-006-20230824   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20230823   gcc  
x86_64                randconfig-001-20230824   clang
x86_64                randconfig-002-20230823   gcc  
x86_64                randconfig-002-20230824   clang
x86_64                randconfig-003-20230823   gcc  
x86_64                randconfig-003-20230824   clang
x86_64                randconfig-004-20230823   gcc  
x86_64                randconfig-004-20230824   clang
x86_64                randconfig-005-20230823   gcc  
x86_64                randconfig-005-20230824   clang
x86_64                randconfig-006-20230823   gcc  
x86_64                randconfig-006-20230824   clang
x86_64                randconfig-011-20230823   clang
x86_64                randconfig-011-20230824   gcc  
x86_64                randconfig-012-20230823   clang
x86_64                randconfig-012-20230824   gcc  
x86_64                randconfig-013-20230823   clang
x86_64                randconfig-013-20230824   gcc  
x86_64                randconfig-014-20230823   clang
x86_64                randconfig-014-20230824   gcc  
x86_64                randconfig-015-20230823   clang
x86_64                randconfig-015-20230824   gcc  
x86_64                randconfig-016-20230823   clang
x86_64                randconfig-016-20230824   gcc  
x86_64                randconfig-071-20230823   clang
x86_64                randconfig-071-20230824   gcc  
x86_64                randconfig-072-20230823   clang
x86_64                randconfig-072-20230824   gcc  
x86_64                randconfig-073-20230823   clang
x86_64                randconfig-073-20230824   gcc  
x86_64                randconfig-074-20230823   clang
x86_64                randconfig-074-20230824   gcc  
x86_64                randconfig-075-20230823   clang
x86_64                randconfig-075-20230824   gcc  
x86_64                randconfig-076-20230823   clang
x86_64                randconfig-076-20230824   gcc  
x86_64               randconfig-r002-20230823   clang
x86_64               randconfig-r003-20230823   clang
x86_64               randconfig-r011-20230823   gcc  
x86_64               randconfig-r012-20230823   gcc  
x86_64               randconfig-r021-20230823   gcc  
x86_64               randconfig-r023-20230823   gcc  
x86_64               randconfig-r024-20230823   gcc  
x86_64               randconfig-r035-20230823   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                              defconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa               randconfig-r001-20230823   gcc  
xtensa               randconfig-r003-20230823   gcc  
xtensa               randconfig-r004-20230823   gcc  
xtensa               randconfig-r005-20230823   gcc  
xtensa               randconfig-r012-20230824   gcc  
xtensa               randconfig-r014-20230823   gcc  
xtensa               randconfig-r015-20230823   gcc  
xtensa               randconfig-r026-20230823   gcc  
xtensa               randconfig-r026-20230824   gcc  
xtensa               randconfig-r031-20230823   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
