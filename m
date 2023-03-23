Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D9C6C733B
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Mar 2023 23:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjCWWlw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Mar 2023 18:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWWlu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Mar 2023 18:41:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1F928E82
        for <linux-rdma@vger.kernel.org>; Thu, 23 Mar 2023 15:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679611309; x=1711147309;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zkb0jjzC6vwZ34rNiw0KorWZZdC+XRcm70esYQcybqA=;
  b=YIDrs1JuNrUHKD6B4boVwqSyhtT36Qz4UfBwzN9hvHMlqqvfUDQ+E1fj
   Y2ixEV4TuCs1+CKeXxIvWTavcUKfGcnUDbmjAaqr5VZJl4JXDsAnwQrf2
   Qqx7gfecsMoCF+V8CAJhSSKE8vXcNiodimu2MyZ3mIyAMpEWuqTFDd2hO
   6e/NjhPx/GbwsAFXeoQ/+li7BZEGKEhVNCVhnUvAjPBo26NjGUN/V5pvx
   0/Bzz3+WSyIWnGL6n1S3pczpHPpiNP+DkXfZE/+OXqFLCgJKNl+L7twqb
   DUhz6++qypxBxwoajmfhxxZNUg/AU9iSXb1tX987qYL9E9F29fsMLGdS3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="323506871"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="323506871"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 15:41:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="715000268"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="715000268"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 23 Mar 2023 15:41:47 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfTcw-000Elo-2W;
        Thu, 23 Mar 2023 22:41:46 +0000
Date:   Fri, 24 Mar 2023 06:40:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 58e84f6b3e84e46524b7e5a916b53c1ad798bc8f
Message-ID: <641cd573.kR57WAnqG2TsGFQ7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: 58e84f6b3e84e46524b7e5a916b53c1ad798bc8f  RDMA/cma: Allow UD qp_type to join multicast only

elapsed time: 801m

configs tested: 184
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230322   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r012-20230323   gcc  
alpha                randconfig-r014-20230323   gcc  
alpha                randconfig-r025-20230322   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r016-20230322   gcc  
arc                  randconfig-r023-20230322   gcc  
arc                  randconfig-r036-20230322   gcc  
arc                  randconfig-r043-20230322   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r001-20230322   clang
arm                                 defconfig   gcc  
arm                       imx_v4_v5_defconfig   clang
arm                  randconfig-r011-20230322   clang
arm                  randconfig-r014-20230323   gcc  
arm                  randconfig-r021-20230322   clang
arm                  randconfig-r032-20230322   gcc  
arm                  randconfig-r035-20230322   gcc  
arm                  randconfig-r046-20230322   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r022-20230322   gcc  
arm64                randconfig-r023-20230322   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r013-20230322   gcc  
csky                 randconfig-r025-20230322   gcc  
csky                 randconfig-r026-20230322   gcc  
csky                 randconfig-r034-20230322   gcc  
hexagon      buildonly-randconfig-r004-20230322   clang
hexagon              randconfig-r004-20230322   clang
hexagon              randconfig-r013-20230322   clang
hexagon              randconfig-r014-20230322   clang
hexagon              randconfig-r031-20230322   clang
hexagon              randconfig-r041-20230322   clang
hexagon              randconfig-r045-20230322   clang
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
i386                          randconfig-c001   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r005-20230322   gcc  
ia64                 randconfig-r011-20230322   gcc  
ia64                 randconfig-r024-20230322   gcc  
ia64                 randconfig-r025-20230322   gcc  
ia64                 randconfig-r033-20230322   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r003-20230322   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r023-20230322   gcc  
loongarch            randconfig-r026-20230322   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230322   gcc  
m68k         buildonly-randconfig-r002-20230322   gcc  
m68k         buildonly-randconfig-r006-20230322   gcc  
m68k                                defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                 randconfig-r015-20230322   gcc  
m68k                 randconfig-r026-20230322   gcc  
m68k                 randconfig-r034-20230322   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze   buildonly-randconfig-r004-20230322   gcc  
microblaze   buildonly-randconfig-r006-20230322   gcc  
microblaze           randconfig-r011-20230323   gcc  
microblaze           randconfig-r021-20230322   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r012-20230323   gcc  
mips                 randconfig-r021-20230322   clang
mips                 randconfig-r023-20230322   clang
mips                 randconfig-r034-20230322   gcc  
mips                           xway_defconfig   gcc  
nios2        buildonly-randconfig-r005-20230322   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230322   gcc  
nios2                randconfig-r015-20230322   gcc  
nios2                randconfig-r016-20230323   gcc  
nios2                randconfig-r033-20230322   gcc  
nios2                randconfig-r035-20230322   gcc  
openrisc             randconfig-r014-20230322   gcc  
openrisc             randconfig-r032-20230322   gcc  
openrisc             randconfig-r036-20230322   gcc  
parisc                           alldefconfig   gcc  
parisc       buildonly-randconfig-r005-20230322   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230322   gcc  
parisc               randconfig-r006-20230322   gcc  
parisc               randconfig-r013-20230322   gcc  
parisc               randconfig-r013-20230323   gcc  
parisc               randconfig-r024-20230322   gcc  
parisc               randconfig-r025-20230322   gcc  
parisc               randconfig-r031-20230322   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r003-20230322   gcc  
powerpc      buildonly-randconfig-r005-20230322   gcc  
powerpc                 mpc836x_mds_defconfig   clang
powerpc                     powernv_defconfig   clang
powerpc              randconfig-r011-20230323   clang
powerpc              randconfig-r013-20230322   gcc  
powerpc              randconfig-r015-20230322   gcc  
powerpc              randconfig-r015-20230323   clang
powerpc              randconfig-r035-20230322   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230322   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230322   clang
s390                 randconfig-r003-20230322   clang
s390                 randconfig-r013-20230323   clang
s390                 randconfig-r044-20230322   gcc  
sh                               allmodconfig   gcc  
sh                                  defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                   randconfig-r016-20230322   gcc  
sh                   randconfig-r026-20230322   gcc  
sh                          rsk7264_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc        buildonly-randconfig-r004-20230322   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230322   gcc  
sparc                randconfig-r006-20230322   gcc  
sparc                randconfig-r014-20230322   gcc  
sparc                randconfig-r016-20230322   gcc  
sparc64      buildonly-randconfig-r001-20230322   gcc  
sparc64      buildonly-randconfig-r002-20230322   gcc  
sparc64      buildonly-randconfig-r006-20230322   gcc  
sparc64              randconfig-r015-20230323   gcc  
sparc64              randconfig-r016-20230323   gcc  
sparc64              randconfig-r022-20230322   gcc  
sparc64              randconfig-r032-20230322   gcc  
sparc64              randconfig-r036-20230322   gcc  
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
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230322   gcc  
xtensa               randconfig-r001-20230322   gcc  
xtensa               randconfig-r002-20230322   gcc  
xtensa               randconfig-r012-20230322   gcc  
xtensa               randconfig-r024-20230322   gcc  
xtensa               randconfig-r031-20230322   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
