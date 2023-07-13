Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8457515E6
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jul 2023 03:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjGMBsb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jul 2023 21:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbjGMBsa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jul 2023 21:48:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD20AB0
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jul 2023 18:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689212909; x=1720748909;
  h=date:from:to:cc:subject:message-id;
  bh=nQQHILdeFFMGuHVGp120i/XoY+vUlk0YJWGOQzKMkkk=;
  b=ffUHmQmyc2lhcDRlKy/oI2C2r2/MDAoceJlqj3+fDFaPZFwyukZAiF14
   J3GO+IAhfYyHd/xSeOB1ZpNmY+D1u/0ZovjYuu4pGs9d5lmsArbkpJVPX
   JGKGdEw9jgzsw+ABxC4kmJLy4H+iUkN797n1GzK0Q9eVUEGEuch72I58H
   u7w/z7QoJYoLCotAbo/XnwdEQjXLEiwkZVOj+eUL+9rUfHVad4R47Mauu
   NNBkE1Mb6MGlcCJVG9XeRxtupYvOaGa+nFP4rTbN1OghotBQjqvoSuc4M
   fJfxkBX9iuT1wCFZNd0UadnX+s2ENlTn0COs1KBieFjGTCgGRlQDzBogG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="365085322"
X-IronPort-AV: E=Sophos;i="6.01,201,1684825200"; 
   d="scan'208";a="365085322"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 18:48:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="721725413"
X-IronPort-AV: E=Sophos;i="6.01,201,1684825200"; 
   d="scan'208";a="721725413"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 12 Jul 2023 18:48:20 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qJlRL-00066l-2G;
        Thu, 13 Jul 2023 01:48:19 +0000
Date:   Thu, 13 Jul 2023 09:48:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 e77ac83ee5fd1683b6dce01056f8e0b242336517
Message-ID: <202307130909.XllKID22-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: e77ac83ee5fd1683b6dce01056f8e0b242336517  RDMA/irdma: Fix data race on CQP request done

elapsed time: 722m

configs tested: 170
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230712   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r033-20230712   gcc  
arc                  randconfig-r043-20230712   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r004-20230712   clang
arm                  randconfig-r016-20230712   gcc  
arm                  randconfig-r046-20230712   gcc  
arm                             rpc_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230712   gcc  
arm64                randconfig-r012-20230713   gcc  
arm64                randconfig-r014-20230712   clang
csky                                defconfig   gcc  
csky                 randconfig-r004-20230712   gcc  
csky                 randconfig-r006-20230712   gcc  
csky                 randconfig-r013-20230712   gcc  
csky                 randconfig-r014-20230713   gcc  
csky                 randconfig-r034-20230712   gcc  
hexagon              randconfig-r003-20230712   clang
hexagon              randconfig-r035-20230712   clang
hexagon              randconfig-r041-20230712   clang
hexagon              randconfig-r045-20230712   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230712   gcc  
i386         buildonly-randconfig-r004-20230713   clang
i386         buildonly-randconfig-r005-20230712   gcc  
i386         buildonly-randconfig-r005-20230713   clang
i386         buildonly-randconfig-r006-20230712   gcc  
i386         buildonly-randconfig-r006-20230713   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230712   gcc  
i386                 randconfig-i002-20230712   gcc  
i386                 randconfig-i003-20230712   gcc  
i386                 randconfig-i004-20230712   gcc  
i386                 randconfig-i005-20230712   gcc  
i386                 randconfig-i006-20230712   gcc  
i386                 randconfig-i011-20230712   clang
i386                 randconfig-i011-20230713   gcc  
i386                 randconfig-i012-20230712   clang
i386                 randconfig-i012-20230713   gcc  
i386                 randconfig-i013-20230712   clang
i386                 randconfig-i013-20230713   gcc  
i386                 randconfig-i014-20230712   clang
i386                 randconfig-i014-20230713   gcc  
i386                 randconfig-i015-20230712   clang
i386                 randconfig-i015-20230713   gcc  
i386                 randconfig-i016-20230712   clang
i386                 randconfig-i016-20230713   gcc  
i386                 randconfig-r022-20230712   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230712   gcc  
loongarch            randconfig-r005-20230712   gcc  
loongarch            randconfig-r023-20230712   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230712   gcc  
m68k                 randconfig-r011-20230712   gcc  
m68k                 randconfig-r015-20230713   gcc  
m68k                 randconfig-r022-20230712   gcc  
microblaze           randconfig-r002-20230712   gcc  
microblaze           randconfig-r005-20230712   gcc  
microblaze           randconfig-r035-20230712   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                          malta_defconfig   clang
mips                 randconfig-r026-20230712   gcc  
mips                 randconfig-r031-20230712   clang
mips                 randconfig-r032-20230712   clang
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230712   gcc  
openrisc             randconfig-r014-20230712   gcc  
openrisc             randconfig-r016-20230712   gcc  
openrisc             randconfig-r024-20230712   gcc  
openrisc             randconfig-r032-20230712   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r021-20230712   gcc  
parisc               randconfig-r036-20230712   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                      obs600_defconfig   clang
powerpc              randconfig-r006-20230712   gcc  
powerpc              randconfig-r012-20230712   clang
powerpc              randconfig-r024-20230712   clang
powerpc                    sam440ep_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r016-20230713   gcc  
riscv                randconfig-r026-20230712   clang
riscv                randconfig-r042-20230712   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r003-20230712   gcc  
s390                 randconfig-r011-20230713   gcc  
s390                 randconfig-r023-20230712   clang
s390                 randconfig-r044-20230712   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r033-20230712   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64              randconfig-r013-20230712   gcc  
sparc64              randconfig-r023-20230712   gcc  
sparc64              randconfig-r024-20230712   gcc  
sparc64              randconfig-r031-20230712   gcc  
um                               alldefconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r001-20230712   clang
um                   randconfig-r025-20230712   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           alldefconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230712   gcc  
x86_64       buildonly-randconfig-r001-20230713   clang
x86_64       buildonly-randconfig-r002-20230712   gcc  
x86_64       buildonly-randconfig-r002-20230713   clang
x86_64       buildonly-randconfig-r003-20230712   gcc  
x86_64       buildonly-randconfig-r003-20230713   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r001-20230712   gcc  
x86_64               randconfig-r011-20230712   clang
x86_64               randconfig-r013-20230713   gcc  
x86_64               randconfig-r025-20230712   clang
x86_64               randconfig-x001-20230712   clang
x86_64               randconfig-x001-20230713   gcc  
x86_64               randconfig-x002-20230712   clang
x86_64               randconfig-x002-20230713   gcc  
x86_64               randconfig-x003-20230712   clang
x86_64               randconfig-x003-20230713   gcc  
x86_64               randconfig-x004-20230712   clang
x86_64               randconfig-x004-20230713   gcc  
x86_64               randconfig-x005-20230712   clang
x86_64               randconfig-x005-20230713   gcc  
x86_64               randconfig-x006-20230712   clang
x86_64               randconfig-x006-20230713   gcc  
x86_64               randconfig-x011-20230712   gcc  
x86_64               randconfig-x012-20230712   gcc  
x86_64               randconfig-x013-20230712   gcc  
x86_64               randconfig-x014-20230712   gcc  
x86_64               randconfig-x015-20230712   gcc  
x86_64               randconfig-x016-20230712   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa               randconfig-r015-20230712   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
