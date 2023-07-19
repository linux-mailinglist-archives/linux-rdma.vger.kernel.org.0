Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5EF759AFD
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jul 2023 18:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjGSQiJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jul 2023 12:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjGSQiH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jul 2023 12:38:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4106510CB
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jul 2023 09:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689784670; x=1721320670;
  h=date:from:to:cc:subject:message-id;
  bh=XHP3k2c+IQzlh3LPfweR7uE2XwnNTh5iMREGJlBWxGI=;
  b=R9tTt7TzzCxNZH6ocBxXb5r4OBsbkJDtCct4G9ed5kCkPGFRs2CAq7+A
   DdUuJxleTJlSGXWbaEsZihXNazWDpgUcdklZ0dhYKXy3e6jS/cucXyR0P
   kHEqpE/WYpE8sHEI2y4N8T9HD6RMcsVxwOH2xUltoA35DTiBCxPspibsF
   j1NXr/87dC4UnnIO+XZ+aUr60wwgvZ2JwxCXua/Rwx3Qe55VuaZQ0dCgl
   IENF3v+6rLaM2GJGMA2FTWOFoGaMvq/O+sm1hJCwBtbuhTN65FwkrBY2z
   OD7vd1W66++jlX+KeErmGOtyNgt0MK51WOOB4+jETuia09/eOwZ0KyDMq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="430285205"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="430285205"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 09:35:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="789478738"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="789478738"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jul 2023 09:35:39 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMA9L-0005HO-0G;
        Wed, 19 Jul 2023 16:35:39 +0000
Date:   Thu, 20 Jul 2023 00:35:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 5c719d7aef298e9b727f39b45e88528a96df3620
Message-ID: <202307200058.sgejfnrK-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: 5c719d7aef298e9b727f39b45e88528a96df3620  RDMA/rxe: Fix an error handling path in rxe_bind_mw()

elapsed time: 1652m

configs tested: 196
configs skipped: 20

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r005-20230718   gcc  
arc                  randconfig-r024-20230718   gcc  
arc                  randconfig-r031-20230718   gcc  
arc                  randconfig-r035-20230718   gcc  
arc                  randconfig-r043-20230718   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   clang
arm                                 defconfig   gcc  
arm                            hisi_defconfig   gcc  
arm                          ixp4xx_defconfig   clang
arm                            mps2_defconfig   gcc  
arm                           omap1_defconfig   clang
arm                          pxa3xx_defconfig   gcc  
arm                  randconfig-r015-20230718   gcc  
arm                  randconfig-r032-20230718   clang
arm                  randconfig-r034-20230718   clang
arm                  randconfig-r036-20230718   clang
arm                  randconfig-r046-20230718   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230718   gcc  
arm64                randconfig-r011-20230718   clang
arm64                randconfig-r012-20230718   clang
arm64                randconfig-r022-20230718   clang
arm64                randconfig-r023-20230718   clang
csky                                defconfig   gcc  
csky                 randconfig-r024-20230718   gcc  
csky                 randconfig-r025-20230718   gcc  
csky                 randconfig-r034-20230718   gcc  
hexagon              randconfig-r021-20230718   clang
hexagon              randconfig-r031-20230718   clang
hexagon              randconfig-r033-20230718   clang
hexagon              randconfig-r041-20230718   clang
hexagon              randconfig-r045-20230718   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230718   gcc  
i386         buildonly-randconfig-r005-20230718   gcc  
i386         buildonly-randconfig-r006-20230718   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230718   gcc  
i386                 randconfig-i002-20230718   gcc  
i386                 randconfig-i003-20230718   gcc  
i386                 randconfig-i004-20230718   gcc  
i386                 randconfig-i005-20230718   gcc  
i386                 randconfig-i006-20230718   gcc  
i386                 randconfig-i011-20230718   clang
i386                 randconfig-i012-20230718   clang
i386                 randconfig-i013-20230718   clang
i386                 randconfig-i014-20230718   clang
i386                 randconfig-i015-20230718   clang
i386                 randconfig-i016-20230718   clang
i386                 randconfig-r002-20230718   gcc  
i386                 randconfig-r006-20230718   gcc  
i386                 randconfig-r013-20230718   clang
i386                 randconfig-r015-20230718   clang
i386                 randconfig-r024-20230718   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r031-20230718   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r021-20230718   gcc  
m68k                 randconfig-r031-20230718   gcc  
microblaze           randconfig-r004-20230718   gcc  
microblaze           randconfig-r012-20230718   gcc  
microblaze           randconfig-r023-20230718   gcc  
microblaze           randconfig-r033-20230718   gcc  
microblaze           randconfig-r036-20230718   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                  cavium_octeon_defconfig   clang
mips                           ip22_defconfig   clang
mips                           jazz_defconfig   gcc  
mips                        qi_lb60_defconfig   clang
mips                 randconfig-r013-20230718   gcc  
mips                 randconfig-r016-20230718   gcc  
mips                 randconfig-r022-20230718   gcc  
mips                 randconfig-r023-20230718   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230718   gcc  
nios2                randconfig-r005-20230718   gcc  
nios2                randconfig-r035-20230718   gcc  
openrisc             randconfig-r014-20230718   gcc  
openrisc             randconfig-r034-20230718   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r022-20230718   gcc  
parisc               randconfig-r024-20230718   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      arches_defconfig   gcc  
powerpc                          g5_defconfig   clang
powerpc                    klondike_defconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc                    mvme5100_defconfig   clang
powerpc              randconfig-r005-20230718   gcc  
powerpc              randconfig-r006-20230718   gcc  
powerpc              randconfig-r014-20230718   clang
powerpc              randconfig-r015-20230718   clang
powerpc              randconfig-r023-20230718   clang
powerpc              randconfig-r025-20230718   clang
powerpc              randconfig-r033-20230718   gcc  
powerpc              randconfig-r034-20230718   gcc  
powerpc              randconfig-r036-20230718   gcc  
powerpc                     tqm8540_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                randconfig-r013-20230718   clang
riscv                randconfig-r016-20230718   clang
riscv                randconfig-r022-20230718   clang
riscv                randconfig-r023-20230718   clang
riscv                randconfig-r042-20230718   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230718   gcc  
s390                 randconfig-r006-20230718   gcc  
s390                 randconfig-r015-20230718   clang
s390                 randconfig-r025-20230718   clang
s390                 randconfig-r031-20230718   gcc  
s390                 randconfig-r044-20230718   clang
sh                               allmodconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                   randconfig-r001-20230718   gcc  
sh                   randconfig-r012-20230718   gcc  
sh                   randconfig-r021-20230718   gcc  
sh                   randconfig-r026-20230718   gcc  
sh                   randconfig-r034-20230718   gcc  
sh                          rsk7201_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230718   gcc  
sparc                randconfig-r004-20230718   gcc  
sparc                randconfig-r016-20230718   gcc  
sparc                randconfig-r024-20230718   gcc  
sparc                randconfig-r026-20230718   gcc  
sparc                randconfig-r031-20230718   gcc  
sparc64              randconfig-r004-20230718   gcc  
sparc64              randconfig-r036-20230718   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r002-20230718   clang
um                   randconfig-r011-20230718   gcc  
um                   randconfig-r026-20230718   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230718   gcc  
x86_64       buildonly-randconfig-r002-20230718   gcc  
x86_64       buildonly-randconfig-r003-20230718   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r012-20230718   clang
x86_64               randconfig-r014-20230718   clang
x86_64               randconfig-r021-20230718   clang
x86_64               randconfig-r032-20230718   gcc  
x86_64               randconfig-x001-20230718   clang
x86_64               randconfig-x002-20230718   clang
x86_64               randconfig-x003-20230718   clang
x86_64               randconfig-x004-20230718   clang
x86_64               randconfig-x005-20230718   clang
x86_64               randconfig-x006-20230718   clang
x86_64               randconfig-x011-20230718   gcc  
x86_64               randconfig-x012-20230718   gcc  
x86_64               randconfig-x013-20230718   gcc  
x86_64               randconfig-x014-20230718   gcc  
x86_64               randconfig-x015-20230718   gcc  
x86_64               randconfig-x016-20230718   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r006-20230718   gcc  
xtensa               randconfig-r033-20230718   gcc  
xtensa               randconfig-r034-20230718   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
