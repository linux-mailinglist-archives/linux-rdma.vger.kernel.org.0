Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843BF77E9E6
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Aug 2023 21:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345866AbjHPTrN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Aug 2023 15:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345865AbjHPTqx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Aug 2023 15:46:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7577A12B
        for <linux-rdma@vger.kernel.org>; Wed, 16 Aug 2023 12:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692215212; x=1723751212;
  h=date:from:to:cc:subject:message-id;
  bh=qEenuUWlfV2N/mFt24opYwkTRgIUb4y+lFv9uzpP6ig=;
  b=jqSY6UTdTxWZ8LDtg6P+NWYHNcMsQIbAuo5Vc/1AhRLn8tY4TDKEsUgw
   n+y92qV0YF5wZovN6DsYMWwnwv4hpBgosjp829wF7xPWLm1mBPrP5hNXI
   2w3nRN9aquqPOCQxuYZErP6ezw1oFYlYjKV7lojufaCYu6ay3StWYAmhB
   EkqZ3hqDg27rrocYVqAwlAhjQ0DSPL5ykkIYmTq/f3yZVQHM6tkvkTUUg
   lLTO9Wb+L+VjoxoNC4rBaw5q1CNGKVVNyx3kjv24BCT0Nw8Oohy+8C4tI
   nmVZFjQKU9F2ZC8NfyCvd1hdI7KVTc0OCgXxiFM1mfL3d2U7pljD0VlVo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="372625153"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="372625153"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 12:46:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="1064962054"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="1064962054"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 16 Aug 2023 12:46:50 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWMTh-0000WH-2k;
        Wed, 16 Aug 2023 19:46:49 +0000
Date:   Thu, 17 Aug 2023 03:45:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 18ddaeb03bdb65b84fece11a8cac5bf583ae1b91
Message-ID: <202308170347.ESiwSbtA-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 18ddaeb03bdb65b84fece11a8cac5bf583ae1b91  RDMA/mlx4: Copy union directly

elapsed time: 728m

configs tested: 193
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230816   gcc  
alpha                randconfig-r012-20230816   gcc  
alpha                randconfig-r022-20230816   gcc  
alpha                randconfig-r025-20230816   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                  randconfig-r023-20230816   gcc  
arc                  randconfig-r026-20230817   gcc  
arc                  randconfig-r035-20230817   gcc  
arc                  randconfig-r043-20230816   gcc  
arc                  randconfig-r043-20230817   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r036-20230816   clang
arm                  randconfig-r046-20230816   gcc  
arm                        realview_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r021-20230817   gcc  
arm64                randconfig-r034-20230816   gcc  
arm64                randconfig-r035-20230816   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r032-20230817   gcc  
csky                 randconfig-r036-20230817   gcc  
hexagon              randconfig-r002-20230816   clang
hexagon              randconfig-r033-20230816   clang
hexagon              randconfig-r041-20230816   clang
hexagon              randconfig-r045-20230816   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230816   gcc  
i386         buildonly-randconfig-r004-20230817   clang
i386         buildonly-randconfig-r005-20230816   gcc  
i386         buildonly-randconfig-r005-20230817   clang
i386         buildonly-randconfig-r006-20230816   gcc  
i386         buildonly-randconfig-r006-20230817   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230816   gcc  
i386                 randconfig-i001-20230817   clang
i386                 randconfig-i002-20230816   gcc  
i386                 randconfig-i002-20230817   clang
i386                 randconfig-i003-20230816   gcc  
i386                 randconfig-i003-20230817   clang
i386                 randconfig-i004-20230816   gcc  
i386                 randconfig-i004-20230817   clang
i386                 randconfig-i005-20230816   gcc  
i386                 randconfig-i005-20230817   clang
i386                 randconfig-i006-20230816   gcc  
i386                 randconfig-i006-20230817   clang
i386                 randconfig-i011-20230816   clang
i386                 randconfig-i012-20230816   clang
i386                 randconfig-i013-20230816   clang
i386                 randconfig-i014-20230816   clang
i386                 randconfig-i015-20230816   clang
i386                 randconfig-i016-20230816   clang
i386                 randconfig-r011-20230816   clang
i386                 randconfig-r022-20230816   clang
i386                 randconfig-r025-20230817   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230816   gcc  
loongarch            randconfig-r005-20230816   gcc  
loongarch            randconfig-r031-20230816   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r004-20230816   gcc  
m68k                 randconfig-r012-20230816   gcc  
m68k                 randconfig-r015-20230816   gcc  
m68k                 randconfig-r016-20230816   gcc  
m68k                 randconfig-r032-20230816   gcc  
microblaze           randconfig-r002-20230816   gcc  
microblaze           randconfig-r005-20230816   gcc  
microblaze           randconfig-r011-20230816   gcc  
microblaze           randconfig-r022-20230817   gcc  
microblaze           randconfig-r025-20230816   gcc  
microblaze           randconfig-r031-20230816   gcc  
microblaze           randconfig-r033-20230816   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ci20_defconfig   gcc  
mips                     cu1000-neo_defconfig   gcc  
mips                 randconfig-r003-20230816   clang
mips                 randconfig-r005-20230816   clang
mips                 randconfig-r015-20230816   gcc  
mips                           rs90_defconfig   clang
mips                   sb1250_swarm_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230816   gcc  
nios2                randconfig-r013-20230816   gcc  
nios2                randconfig-r024-20230816   gcc  
nios2                randconfig-r033-20230817   gcc  
nios2                randconfig-r034-20230816   gcc  
openrisc             randconfig-r023-20230816   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230816   gcc  
parisc               randconfig-r003-20230816   gcc  
parisc               randconfig-r006-20230816   gcc  
parisc               randconfig-r016-20230816   gcc  
parisc               randconfig-r021-20230816   gcc  
parisc               randconfig-r033-20230816   gcc  
parisc               randconfig-r035-20230816   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                    ge_imp3a_defconfig   clang
powerpc                 mpc8315_rdb_defconfig   gcc  
powerpc              randconfig-r006-20230816   gcc  
powerpc              randconfig-r013-20230816   clang
powerpc              randconfig-r026-20230817   gcc  
powerpc                     redwood_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r021-20230817   gcc  
riscv                randconfig-r032-20230816   gcc  
riscv                randconfig-r042-20230816   clang
riscv                randconfig-r042-20230817   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230816   gcc  
s390                 randconfig-r014-20230816   clang
s390                 randconfig-r021-20230816   clang
s390                 randconfig-r044-20230816   clang
s390                 randconfig-r044-20230817   gcc  
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                   randconfig-r006-20230816   gcc  
sh                   randconfig-r026-20230816   gcc  
sh                          rsk7269_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r015-20230816   gcc  
sparc                randconfig-r021-20230816   gcc  
sparc                randconfig-r026-20230816   gcc  
sparc64              randconfig-r022-20230816   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r014-20230816   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230816   gcc  
x86_64       buildonly-randconfig-r001-20230817   clang
x86_64       buildonly-randconfig-r002-20230816   gcc  
x86_64       buildonly-randconfig-r002-20230817   clang
x86_64       buildonly-randconfig-r003-20230816   gcc  
x86_64       buildonly-randconfig-r003-20230817   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r001-20230816   gcc  
x86_64               randconfig-r023-20230817   gcc  
x86_64               randconfig-r035-20230816   gcc  
x86_64               randconfig-x001-20230816   clang
x86_64               randconfig-x001-20230817   gcc  
x86_64               randconfig-x002-20230816   clang
x86_64               randconfig-x002-20230817   gcc  
x86_64               randconfig-x003-20230816   clang
x86_64               randconfig-x003-20230817   gcc  
x86_64               randconfig-x004-20230816   clang
x86_64               randconfig-x004-20230817   gcc  
x86_64               randconfig-x005-20230816   clang
x86_64               randconfig-x005-20230817   gcc  
x86_64               randconfig-x006-20230816   clang
x86_64               randconfig-x006-20230817   gcc  
x86_64               randconfig-x011-20230816   gcc  
x86_64               randconfig-x012-20230816   gcc  
x86_64               randconfig-x013-20230816   gcc  
x86_64               randconfig-x014-20230816   gcc  
x86_64               randconfig-x015-20230816   gcc  
x86_64               randconfig-x016-20230816   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r003-20230816   gcc  
xtensa               randconfig-r011-20230816   gcc  
xtensa               randconfig-r013-20230816   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
