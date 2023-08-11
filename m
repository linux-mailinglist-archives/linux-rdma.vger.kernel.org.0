Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3299E7788E2
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Aug 2023 10:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjHKIZk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Aug 2023 04:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjHKIZj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Aug 2023 04:25:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0CC2D41
        for <linux-rdma@vger.kernel.org>; Fri, 11 Aug 2023 01:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691742338; x=1723278338;
  h=date:from:to:cc:subject:message-id;
  bh=0mrC9O0U4y/0/TpLT9Rgzlokdy50ZJko7WO90ydTuzM=;
  b=mtgzm9IwYEE0Ur0rGQLu2NfEuR1xrmynSDWNjXV7905P1i+1XqFDNJSS
   5DZmsVbtbcTSgRg5w7Y2PAAB7zfq0adynfUAea03H3z2J6Mjxfbz+12ON
   hZEAHa7jTXVM6/LgazeE470YSHDMeXn0RCQuOE0IG9pxrsgvDTT5GD/Sa
   fXiX8rBNCT1UaUnREMmfKTHWfwDi2WbDQ/qKZhSE+UCIINSsxOhXqqNSb
   4QoJ+NN7ZrgMHwK89iL54ZNqsrpq3fZ4CO58QXQJAjs7257PLDDds7W04
   jZlaxkPwUof9ORuR3wNQ+73bQzhmWXFtSXcl2yPfjRQnrv9XWeiY8iT7K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="369098193"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="369098193"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 01:25:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="735711788"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="735711788"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 11 Aug 2023 01:25:37 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUNSi-0007dw-1v;
        Fri, 11 Aug 2023 08:25:36 +0000
Date:   Fri, 11 Aug 2023 16:24:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:for-rc] BUILD SUCCESS
 64b632654b97319b253c2c902fe4c11349aaa70f
Message-ID: <202308111653.mTt5Q4Ko-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: 64b632654b97319b253c2c902fe4c11349aaa70f  RDMA/bnxt_re: Initialize dpi_tbl_lock mutex

elapsed time: 732m

configs tested: 198
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r012-20230811   gcc  
alpha                randconfig-r032-20230811   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                  randconfig-r004-20230811   gcc  
arc                  randconfig-r006-20230811   gcc  
arc                  randconfig-r014-20230811   gcc  
arc                  randconfig-r043-20230811   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g4_defconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                                 defconfig   gcc  
arm                            dove_defconfig   clang
arm                       imx_v6_v7_defconfig   gcc  
arm                            mmp2_defconfig   clang
arm                        mvebu_v5_defconfig   clang
arm                        neponset_defconfig   clang
arm                  randconfig-r016-20230811   clang
arm                  randconfig-r021-20230811   clang
arm                  randconfig-r046-20230811   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r023-20230811   gcc  
arm64                randconfig-r024-20230811   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r034-20230811   gcc  
csky                 randconfig-r035-20230811   gcc  
hexagon              randconfig-r004-20230811   clang
hexagon              randconfig-r041-20230811   clang
hexagon              randconfig-r045-20230811   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230811   clang
i386         buildonly-randconfig-r005-20230811   clang
i386         buildonly-randconfig-r006-20230811   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230811   clang
i386                 randconfig-i002-20230811   clang
i386                 randconfig-i003-20230811   clang
i386                 randconfig-i004-20230811   clang
i386                 randconfig-i005-20230811   clang
i386                 randconfig-i006-20230811   clang
i386                 randconfig-i011-20230811   gcc  
i386                 randconfig-i012-20230811   gcc  
i386                 randconfig-i013-20230811   gcc  
i386                 randconfig-i014-20230811   gcc  
i386                 randconfig-i015-20230811   gcc  
i386                 randconfig-i016-20230811   gcc  
i386                 randconfig-r003-20230811   clang
i386                 randconfig-r006-20230811   clang
i386                 randconfig-r014-20230811   gcc  
i386                 randconfig-r015-20230811   gcc  
i386                 randconfig-r026-20230811   gcc  
i386                 randconfig-r031-20230811   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230811   gcc  
loongarch            randconfig-r033-20230811   gcc  
loongarch            randconfig-r035-20230811   gcc  
loongarch            randconfig-r036-20230811   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                 randconfig-r001-20230811   gcc  
m68k                 randconfig-r032-20230811   gcc  
m68k                        stmark2_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze           randconfig-r005-20230811   gcc  
microblaze           randconfig-r023-20230811   gcc  
microblaze           randconfig-r024-20230811   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                            ar7_defconfig   gcc  
mips                  cavium_octeon_defconfig   clang
mips                           ci20_defconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                           jazz_defconfig   gcc  
mips                       lemote2f_defconfig   clang
mips                      maltaaprp_defconfig   clang
mips                        maltaup_defconfig   clang
mips                 randconfig-r002-20230811   gcc  
mips                 randconfig-r005-20230811   gcc  
mips                 randconfig-r006-20230811   gcc  
mips                 randconfig-r011-20230811   clang
mips                 randconfig-r013-20230811   clang
mips                 randconfig-r015-20230811   clang
mips                 randconfig-r025-20230811   clang
mips                 randconfig-r031-20230811   gcc  
mips                 randconfig-r033-20230811   gcc  
mips                       rbtx49xx_defconfig   clang
mips                   sb1250_swarm_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230811   gcc  
nios2                randconfig-r024-20230811   gcc  
nios2                randconfig-r031-20230811   gcc  
openrisc             randconfig-r034-20230811   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc               randconfig-r003-20230811   gcc  
parisc               randconfig-r011-20230811   gcc  
parisc               randconfig-r022-20230811   gcc  
parisc               randconfig-r034-20230811   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                       holly_defconfig   gcc  
powerpc                        icon_defconfig   clang
powerpc                    klondike_defconfig   gcc  
powerpc                     ksi8560_defconfig   clang
powerpc                 linkstation_defconfig   gcc  
powerpc              randconfig-r005-20230811   clang
powerpc              randconfig-r022-20230811   gcc  
powerpc              randconfig-r034-20230811   clang
powerpc              randconfig-r035-20230811   clang
powerpc                  storcenter_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230811   clang
riscv                randconfig-r005-20230811   clang
riscv                randconfig-r006-20230811   clang
riscv                randconfig-r012-20230811   gcc  
riscv                randconfig-r026-20230811   gcc  
riscv                randconfig-r042-20230811   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r013-20230811   gcc  
s390                 randconfig-r014-20230811   gcc  
s390                 randconfig-r015-20230811   gcc  
s390                 randconfig-r044-20230811   gcc  
sh                               allmodconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                   randconfig-r011-20230811   gcc  
sh                   randconfig-r013-20230811   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7721_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230811   gcc  
sparc                randconfig-r003-20230811   gcc  
sparc                randconfig-r015-20230811   gcc  
sparc                randconfig-r016-20230811   gcc  
sparc                randconfig-r021-20230811   gcc  
sparc64              randconfig-r004-20230811   gcc  
sparc64              randconfig-r014-20230811   gcc  
sparc64              randconfig-r023-20230811   gcc  
sparc64              randconfig-r033-20230811   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r011-20230811   clang
um                   randconfig-r022-20230811   clang
um                   randconfig-r032-20230811   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230811   clang
x86_64       buildonly-randconfig-r002-20230811   clang
x86_64       buildonly-randconfig-r003-20230811   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r003-20230811   clang
x86_64               randconfig-r012-20230811   gcc  
x86_64               randconfig-r036-20230811   clang
x86_64               randconfig-x001-20230811   gcc  
x86_64               randconfig-x002-20230811   gcc  
x86_64               randconfig-x003-20230811   gcc  
x86_64               randconfig-x004-20230811   gcc  
x86_64               randconfig-x005-20230811   gcc  
x86_64               randconfig-x006-20230811   gcc  
x86_64               randconfig-x011-20230811   clang
x86_64               randconfig-x012-20230811   clang
x86_64               randconfig-x013-20230811   clang
x86_64               randconfig-x014-20230811   clang
x86_64               randconfig-x015-20230811   clang
x86_64               randconfig-x016-20230811   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r012-20230811   gcc  
xtensa               randconfig-r016-20230811   gcc  
xtensa               randconfig-r035-20230811   gcc  
xtensa               randconfig-r036-20230811   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
