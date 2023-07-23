Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B198A75E4D8
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jul 2023 22:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjGWUbl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Jul 2023 16:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGWUbl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Jul 2023 16:31:41 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0441B8
        for <linux-rdma@vger.kernel.org>; Sun, 23 Jul 2023 13:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690144299; x=1721680299;
  h=date:from:to:cc:subject:message-id;
  bh=krFdCgp2ok5y6sXF/gEQ2v+6l3pw6vYKMSv7GKhfnMQ=;
  b=Ar60o8vGUbzzKXt1UNhrEXSfMxi/fe2XKCOMJlxgssYUHLpAbiHf++HQ
   HZr7PYS6Kr9gc2QIzC3PBwj9vG5XFDBEm0j0yDndch5yXS2kd42HTm5wc
   4XOylQwxvhNQOi9i45aocDJgWwuzV9sd0V8VivAUAQ+4kIayQ2NdLvuYg
   aGHD5Grfiyjl00y8eo4yJP7m62BOo3IM5r4dG490gnkU3iaLVGxbNPwh2
   JiZ19H/1NiqQmKaDnGm7BsWzJo2O4wDK/jkQ8TlPZSchVrUfiybw/Yibm
   ruQOId1AobaAuynJkDesN0gSTPBtxFGiU521137hQH3KvoN/h3ahB/VeL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="398206662"
X-IronPort-AV: E=Sophos;i="6.01,227,1684825200"; 
   d="scan'208";a="398206662"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2023 13:31:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="755084280"
X-IronPort-AV: E=Sophos;i="6.01,227,1684825200"; 
   d="scan'208";a="755084280"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 23 Jul 2023 13:31:36 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qNfjU-0009FD-0m;
        Sun, 23 Jul 2023 20:31:16 +0000
Date:   Mon, 24 Jul 2023 04:29:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 44725a87381353075273618eeedc9127e99c378e
Message-ID: <202307240410.LJ1T3RgB-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 44725a87381353075273618eeedc9127e99c378e  RDMA/qedr: Remove duplicate assignments of va

elapsed time: 726m

configs tested: 173
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r006-20230723   gcc  
alpha                randconfig-r035-20230723   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r011-20230723   gcc  
arc                  randconfig-r012-20230723   gcc  
arc                  randconfig-r026-20230723   gcc  
arc                  randconfig-r032-20230723   gcc  
arc                  randconfig-r043-20230723   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                        mvebu_v7_defconfig   gcc  
arm                  randconfig-r003-20230723   gcc  
arm                  randconfig-r024-20230723   clang
arm                  randconfig-r033-20230723   gcc  
arm                  randconfig-r046-20230723   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r014-20230723   gcc  
arm64                randconfig-r015-20230723   gcc  
arm64                randconfig-r016-20230723   gcc  
arm64                randconfig-r025-20230723   gcc  
arm64                randconfig-r032-20230723   clang
arm64                randconfig-r036-20230723   clang
csky                                defconfig   gcc  
csky                 randconfig-r024-20230723   gcc  
csky                 randconfig-r026-20230723   gcc  
hexagon              randconfig-r013-20230723   clang
hexagon              randconfig-r021-20230723   clang
hexagon              randconfig-r033-20230723   clang
hexagon              randconfig-r034-20230723   clang
hexagon              randconfig-r036-20230723   clang
hexagon              randconfig-r041-20230723   clang
hexagon              randconfig-r045-20230723   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230723   clang
i386         buildonly-randconfig-r005-20230723   clang
i386         buildonly-randconfig-r006-20230723   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230723   clang
i386                 randconfig-i002-20230723   clang
i386                 randconfig-i003-20230723   clang
i386                 randconfig-i004-20230723   clang
i386                 randconfig-i005-20230723   clang
i386                 randconfig-i006-20230723   clang
i386                 randconfig-i011-20230723   gcc  
i386                 randconfig-i012-20230723   gcc  
i386                 randconfig-i013-20230723   gcc  
i386                 randconfig-i014-20230723   gcc  
i386                 randconfig-i015-20230723   gcc  
i386                 randconfig-i016-20230723   gcc  
i386                 randconfig-r016-20230723   gcc  
i386                 randconfig-r021-20230723   gcc  
i386                 randconfig-r025-20230723   gcc  
i386                 randconfig-r031-20230723   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230723   gcc  
loongarch            randconfig-r021-20230723   gcc  
loongarch            randconfig-r023-20230723   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r012-20230723   gcc  
m68k                 randconfig-r016-20230723   gcc  
m68k                 randconfig-r026-20230723   gcc  
m68k                 randconfig-r031-20230723   gcc  
m68k                 randconfig-r034-20230723   gcc  
microblaze           randconfig-r014-20230723   gcc  
microblaze           randconfig-r015-20230723   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                           ip27_defconfig   clang
mips                     loongson1b_defconfig   gcc  
mips                     loongson1c_defconfig   clang
mips                 randconfig-r015-20230723   clang
mips                 randconfig-r024-20230723   clang
nios2                         10m50_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r024-20230723   gcc  
nios2                randconfig-r034-20230723   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc             randconfig-r011-20230723   gcc  
openrisc             randconfig-r021-20230723   gcc  
openrisc             randconfig-r022-20230723   gcc  
openrisc             randconfig-r023-20230723   gcc  
openrisc             randconfig-r035-20230723   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r015-20230723   gcc  
parisc               randconfig-r031-20230723   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc              randconfig-r003-20230723   clang
powerpc              randconfig-r034-20230723   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r013-20230723   gcc  
riscv                randconfig-r014-20230723   gcc  
riscv                randconfig-r036-20230723   clang
riscv                randconfig-r042-20230723   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r005-20230723   clang
s390                 randconfig-r012-20230723   gcc  
s390                 randconfig-r013-20230723   gcc  
s390                 randconfig-r022-20230723   gcc  
s390                 randconfig-r035-20230723   clang
s390                 randconfig-r044-20230723   gcc  
sh                               allmodconfig   gcc  
sh                         microdev_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                   randconfig-r004-20230723   gcc  
sh                   randconfig-r011-20230723   gcc  
sh                   randconfig-r032-20230723   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230723   gcc  
sparc                randconfig-r005-20230723   gcc  
sparc                randconfig-r011-20230723   gcc  
sparc                randconfig-r023-20230723   gcc  
sparc64              randconfig-r002-20230723   gcc  
sparc64              randconfig-r006-20230723   gcc  
sparc64              randconfig-r031-20230723   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r001-20230723   gcc  
um                   randconfig-r002-20230723   gcc  
um                   randconfig-r004-20230723   gcc  
um                   randconfig-r012-20230723   clang
um                   randconfig-r033-20230723   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230723   clang
x86_64       buildonly-randconfig-r002-20230723   clang
x86_64       buildonly-randconfig-r003-20230723   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r004-20230723   clang
x86_64               randconfig-r022-20230723   gcc  
x86_64               randconfig-r033-20230723   clang
x86_64               randconfig-x001-20230723   gcc  
x86_64               randconfig-x002-20230723   gcc  
x86_64               randconfig-x003-20230723   gcc  
x86_64               randconfig-x004-20230723   gcc  
x86_64               randconfig-x005-20230723   gcc  
x86_64               randconfig-x006-20230723   gcc  
x86_64               randconfig-x011-20230723   clang
x86_64               randconfig-x012-20230723   clang
x86_64               randconfig-x013-20230723   clang
x86_64               randconfig-x014-20230723   clang
x86_64               randconfig-x015-20230723   clang
x86_64               randconfig-x016-20230723   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r016-20230723   gcc  
xtensa               randconfig-r022-20230723   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
