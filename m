Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712236D6C89
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Apr 2023 20:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbjDDSno (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Apr 2023 14:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbjDDSnn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Apr 2023 14:43:43 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3986910F6
        for <linux-rdma@vger.kernel.org>; Tue,  4 Apr 2023 11:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680633822; x=1712169822;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=L/NdXOhVNyluUEK+gZ1xq13CPZA564M4s9l/OLHckS8=;
  b=hN1xH1Yhy7yM9Y+i8liFYd8y2PHNPVizm1JjVMSVBG0GbT+FYzHvD9pa
   cbHW1GayN1jLRyaxQVfde1yIDqCGE9/JnPcU+vHgnLHHntWihJDqeY9ER
   8Of9zRG75C0BAymyMNv52FApKxrgaGuTzICDmQI9u7Yo94bRerO3d33Wd
   3i29IdkzrNIh3qBtIipixd+oY9U9B98VVIq5MUFx94k/5tqS3VDxQsm0I
   XVRd+gp9sZZVE1oCkPrqd3x1juWBgwAQhR1z3ujuqp7OIzhqMPS2x1vlm
   oLZJoNibLw1Zc0j+Wi4rOpFfm2fb2h0K/+U1xnsBZqqi3QiLkAPQGdWn+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="342295856"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="342295856"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 11:43:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="755740977"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="755740977"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Apr 2023 11:43:40 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pjld5-000Pyo-0R;
        Tue, 04 Apr 2023 18:43:39 +0000
Date:   Wed, 05 Apr 2023 02:42:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 f13bcef04ba0467b7901998c22408d5847d314a1
Message-ID: <642c6faf.TlZ6UoBLMGLtj/iY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: f13bcef04ba0467b7901998c22408d5847d314a1  RDMA/bnxt_re: Enable congestion control by default

elapsed time: 733m

configs tested: 213
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230403   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r016-20230403   gcc  
alpha                randconfig-r023-20230403   gcc  
alpha                randconfig-r036-20230404   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r006-20230403   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r022-20230403   gcc  
arc                  randconfig-r032-20230403   gcc  
arc                  randconfig-r034-20230403   gcc  
arc                  randconfig-r043-20230403   gcc  
arc                  randconfig-r043-20230404   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          exynos_defconfig   gcc  
arm                  randconfig-r046-20230403   clang
arm                  randconfig-r046-20230404   gcc  
arm                           sama5_defconfig   gcc  
arm                         socfpga_defconfig   clang
arm                        spear3xx_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230403   clang
arm64                randconfig-r013-20230403   gcc  
arm64                randconfig-r021-20230403   gcc  
arm64                randconfig-r024-20230403   gcc  
arm64                randconfig-r033-20230403   clang
csky         buildonly-randconfig-r001-20230403   gcc  
csky         buildonly-randconfig-r002-20230403   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230403   gcc  
csky                 randconfig-r013-20230403   gcc  
csky                 randconfig-r015-20230403   gcc  
csky                 randconfig-r033-20230403   gcc  
hexagon      buildonly-randconfig-r006-20230403   clang
hexagon      buildonly-randconfig-r006-20230404   clang
hexagon              randconfig-r001-20230403   clang
hexagon              randconfig-r005-20230403   clang
hexagon              randconfig-r006-20230403   clang
hexagon              randconfig-r041-20230403   clang
hexagon              randconfig-r041-20230404   clang
hexagon              randconfig-r045-20230403   clang
hexagon              randconfig-r045-20230404   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r002-20230403   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230403   clang
i386                 randconfig-a002-20230403   clang
i386                 randconfig-a003-20230403   clang
i386                 randconfig-a004-20230403   clang
i386                 randconfig-a005-20230403   clang
i386                 randconfig-a006-20230403   clang
i386                 randconfig-a011-20230403   gcc  
i386                          randconfig-a011   clang
i386                 randconfig-a012-20230403   gcc  
i386                          randconfig-a012   gcc  
i386                 randconfig-a013-20230403   gcc  
i386                          randconfig-a013   clang
i386                 randconfig-a014-20230403   gcc  
i386                          randconfig-a014   gcc  
i386                 randconfig-a015-20230403   gcc  
i386                          randconfig-a015   clang
i386                 randconfig-a016-20230403   gcc  
i386                          randconfig-a016   gcc  
i386                 randconfig-r015-20230403   gcc  
i386                 randconfig-r021-20230403   gcc  
i386                 randconfig-r022-20230403   gcc  
i386                 randconfig-r023-20230403   gcc  
i386                 randconfig-r026-20230403   gcc  
ia64                             alldefconfig   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r004-20230403   gcc  
ia64         buildonly-randconfig-r004-20230404   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r012-20230403   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r011-20230403   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230403   gcc  
m68k         buildonly-randconfig-r002-20230403   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                 randconfig-r024-20230403   gcc  
m68k                 randconfig-r026-20230403   gcc  
m68k                 randconfig-r033-20230403   gcc  
m68k                 randconfig-r034-20230404   gcc  
microblaze   buildonly-randconfig-r005-20230403   gcc  
microblaze   buildonly-randconfig-r006-20230403   gcc  
microblaze           randconfig-r015-20230403   gcc  
microblaze           randconfig-r023-20230403   gcc  
microblaze           randconfig-r024-20230403   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r001-20230403   gcc  
mips                           gcw0_defconfig   gcc  
mips                     loongson2k_defconfig   clang
mips                 randconfig-r025-20230403   clang
nios2        buildonly-randconfig-r004-20230403   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230403   gcc  
nios2                randconfig-r014-20230403   gcc  
nios2                randconfig-r024-20230403   gcc  
nios2                randconfig-r032-20230403   gcc  
nios2                randconfig-r033-20230404   gcc  
nios2                randconfig-r035-20230403   gcc  
openrisc     buildonly-randconfig-r003-20230403   gcc  
openrisc     buildonly-randconfig-r005-20230404   gcc  
openrisc             randconfig-r011-20230403   gcc  
openrisc             randconfig-r013-20230403   gcc  
openrisc             randconfig-r025-20230403   gcc  
openrisc             randconfig-r026-20230403   gcc  
parisc       buildonly-randconfig-r003-20230403   gcc  
parisc       buildonly-randconfig-r004-20230403   gcc  
parisc       buildonly-randconfig-r005-20230403   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230403   gcc  
parisc               randconfig-r013-20230403   gcc  
parisc               randconfig-r014-20230403   gcc  
parisc               randconfig-r036-20230403   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r003-20230404   clang
powerpc      buildonly-randconfig-r005-20230403   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc              randconfig-r005-20230403   clang
powerpc              randconfig-r012-20230403   gcc  
powerpc              randconfig-r014-20230403   gcc  
powerpc              randconfig-r016-20230403   gcc  
powerpc              randconfig-r025-20230403   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230403   gcc  
riscv        buildonly-randconfig-r003-20230403   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                randconfig-r006-20230403   clang
riscv                randconfig-r021-20230403   gcc  
riscv                randconfig-r042-20230403   gcc  
riscv                randconfig-r042-20230404   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230403   clang
s390                 randconfig-r012-20230403   gcc  
s390                 randconfig-r015-20230403   gcc  
s390                 randconfig-r031-20230404   gcc  
s390                 randconfig-r044-20230403   gcc  
s390                 randconfig-r044-20230404   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r003-20230403   gcc  
sh                          landisk_defconfig   gcc  
sh                   randconfig-r011-20230403   gcc  
sh                   randconfig-r031-20230403   gcc  
sparc        buildonly-randconfig-r001-20230404   gcc  
sparc        buildonly-randconfig-r004-20230403   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r023-20230403   gcc  
sparc                randconfig-r025-20230403   gcc  
sparc                randconfig-r031-20230403   gcc  
sparc64      buildonly-randconfig-r006-20230403   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r004-20230403   gcc  
sparc64              randconfig-r012-20230403   gcc  
sparc64              randconfig-r024-20230403   gcc  
sparc64              randconfig-r026-20230403   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r005-20230403   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230403   clang
x86_64                        randconfig-a001   clang
x86_64               randconfig-a002-20230403   clang
x86_64               randconfig-a003-20230403   clang
x86_64                        randconfig-a003   clang
x86_64               randconfig-a004-20230403   clang
x86_64               randconfig-a005-20230403   clang
x86_64                        randconfig-a005   clang
x86_64               randconfig-a006-20230403   clang
x86_64               randconfig-a011-20230403   gcc  
x86_64               randconfig-a012-20230403   gcc  
x86_64                        randconfig-a012   clang
x86_64               randconfig-a013-20230403   gcc  
x86_64               randconfig-a014-20230403   gcc  
x86_64                        randconfig-a014   clang
x86_64               randconfig-a015-20230403   gcc  
x86_64               randconfig-a016-20230403   gcc  
x86_64                        randconfig-a016   clang
x86_64               randconfig-k001-20230403   gcc  
x86_64               randconfig-r001-20230403   clang
x86_64               randconfig-r016-20230403   gcc  
x86_64               randconfig-r021-20230403   gcc  
x86_64               randconfig-r022-20230403   gcc  
x86_64               randconfig-r023-20230403   gcc  
x86_64               randconfig-r026-20230403   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r021-20230403   gcc  
xtensa               randconfig-r022-20230403   gcc  
xtensa               randconfig-r026-20230403   gcc  
xtensa               randconfig-r031-20230403   gcc  
xtensa               randconfig-r035-20230404   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
