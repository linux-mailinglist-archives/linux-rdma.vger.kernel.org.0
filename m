Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1427558C0
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jul 2023 02:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjGQALm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 16 Jul 2023 20:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjGQALl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 16 Jul 2023 20:11:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5B4E61
        for <linux-rdma@vger.kernel.org>; Sun, 16 Jul 2023 17:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689552697; x=1721088697;
  h=date:from:to:cc:subject:message-id;
  bh=iBNA4kcmzmJmAvPaECcOm5eF2MLYBvXLdni7NZVKePY=;
  b=Ax/7VKNBsQ56QlRImvIaGiBLbrA8L0lYU0JtJqYznS3z2KJvPjBlC7RU
   wPb9/EIoqjLPIuWvDa9T61GA/fU7fTNciYFp019dEpOB+xt3OZjDPqtsX
   trvELtLji0sePD2GHkIDHOkDTpzeKjqMK6KxInq/nk/WLDflJZT+8z6bo
   joi3EelUsTyXBfsOq9zdw06415G5MN2NNqzGCWXDRsu0noW8HOpJ5WUhP
   GZARJognoDDn5vWt/hTn93/V266E+owqzyrfxZs4z6TQHy6QxrIo2ijVJ
   wT6ZJ3grtuL5X1izJ8rQ/xkrCtqEasC6a48d0jMCTl/8JGofEwwc1Iqhb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="363274782"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="363274782"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2023 17:11:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="700314152"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="700314152"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 16 Jul 2023 17:11:34 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qLBpt-00094T-1p;
        Mon, 17 Jul 2023 00:11:33 +0000
Date:   Mon, 17 Jul 2023 08:10:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 2c03afae5ff9b3548ae04dc1110fc6e66c613fe3
Message-ID: <202307170854.zPcHkqsM-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: 2c03afae5ff9b3548ae04dc1110fc6e66c613fe3  RDMA/bnxt_re: Fix hang during driver unload

elapsed time: 726m

configs tested: 150
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r023-20230716   gcc  
arc                  randconfig-r025-20230716   gcc  
arc                  randconfig-r043-20230716   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                     davinci_all_defconfig   clang
arm                                 defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                       imx_v4_v5_defconfig   clang
arm                  randconfig-r035-20230716   clang
arm                  randconfig-r046-20230716   gcc  
arm                         socfpga_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r002-20230716   gcc  
csky                 randconfig-r006-20230716   gcc  
csky                 randconfig-r033-20230716   gcc  
hexagon              randconfig-r015-20230716   clang
hexagon              randconfig-r035-20230716   clang
hexagon              randconfig-r041-20230716   clang
hexagon              randconfig-r045-20230716   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230716   gcc  
i386         buildonly-randconfig-r005-20230716   gcc  
i386         buildonly-randconfig-r006-20230716   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230716   gcc  
i386                 randconfig-i002-20230716   gcc  
i386                 randconfig-i003-20230716   gcc  
i386                 randconfig-i004-20230716   gcc  
i386                 randconfig-i005-20230716   gcc  
i386                 randconfig-i006-20230716   gcc  
i386                 randconfig-i011-20230716   clang
i386                 randconfig-i012-20230716   clang
i386                 randconfig-i013-20230716   clang
i386                 randconfig-i014-20230716   clang
i386                 randconfig-i015-20230716   clang
i386                 randconfig-i016-20230716   clang
i386                 randconfig-r002-20230716   gcc  
i386                 randconfig-r005-20230716   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230716   gcc  
loongarch            randconfig-r016-20230716   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
m68k                 randconfig-r023-20230716   gcc  
m68k                           sun3_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
m68k                           virt_defconfig   gcc  
microblaze           randconfig-r006-20230716   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                            ar7_defconfig   gcc  
mips                 randconfig-r022-20230716   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r011-20230716   gcc  
nios2                randconfig-r012-20230716   gcc  
nios2                randconfig-r031-20230716   gcc  
nios2                randconfig-r034-20230716   gcc  
openrisc             randconfig-r001-20230716   gcc  
openrisc             randconfig-r004-20230716   gcc  
openrisc             randconfig-r011-20230716   gcc  
openrisc             randconfig-r014-20230716   gcc  
openrisc             randconfig-r026-20230716   gcc  
openrisc             randconfig-r036-20230716   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230716   gcc  
parisc               randconfig-r016-20230716   gcc  
parisc               randconfig-r024-20230716   gcc  
parisc               randconfig-r032-20230716   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          g5_defconfig   clang
powerpc                       holly_defconfig   gcc  
powerpc                        icon_defconfig   clang
powerpc                   lite5200b_defconfig   clang
powerpc                     ppa8548_defconfig   clang
powerpc              randconfig-r013-20230716   clang
powerpc                     tqm8548_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r021-20230716   clang
riscv                randconfig-r024-20230716   clang
riscv                randconfig-r042-20230716   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230716   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r014-20230716   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r015-20230716   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r001-20230716   clang
um                   randconfig-r003-20230716   clang
um                   randconfig-r021-20230716   gcc  
um                   randconfig-r031-20230716   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230716   gcc  
x86_64       buildonly-randconfig-r002-20230716   gcc  
x86_64       buildonly-randconfig-r003-20230716   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r012-20230716   clang
x86_64               randconfig-r013-20230716   clang
x86_64               randconfig-r025-20230716   clang
x86_64               randconfig-x001-20230716   clang
x86_64               randconfig-x002-20230716   clang
x86_64               randconfig-x003-20230716   clang
x86_64               randconfig-x004-20230716   clang
x86_64               randconfig-x005-20230716   clang
x86_64               randconfig-x006-20230716   clang
x86_64               randconfig-x011-20230716   gcc  
x86_64               randconfig-x012-20230716   gcc  
x86_64               randconfig-x013-20230716   gcc  
x86_64               randconfig-x014-20230716   gcc  
x86_64               randconfig-x015-20230716   gcc  
x86_64               randconfig-x016-20230716   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa               randconfig-r022-20230716   gcc  
xtensa               randconfig-r026-20230716   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
