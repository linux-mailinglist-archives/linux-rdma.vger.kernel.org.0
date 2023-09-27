Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEF67B0625
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Sep 2023 16:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjI0OFP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Sep 2023 10:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbjI0OFP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Sep 2023 10:05:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C643211D
        for <linux-rdma@vger.kernel.org>; Wed, 27 Sep 2023 07:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695823513; x=1727359513;
  h=date:from:to:cc:subject:message-id;
  bh=MyK6pOq12++1mNent/v+VHGDGpDkhozL0KfF2IRgAAs=;
  b=eE+k5erh9MCShuCTcaM0rF+V7zOWZ4yCrAy8DQwFvwL7xVsW1IS8nXRE
   0w03jaEnshFFHm5icFWK/RPPf3i2IVlh5Oo77rJa6bk5ldcM1SU3goCoh
   uzM4zRnuoNyOQrEIhIrzCndUYHU6rGZwt5It4cjI2DWdcFxMPkhO1SKtz
   Tk5bHZF9Ap9+oXRCmucdZFlUme7Km9ZaNxfQ4dyulXa/6NgxJUfR7l+ep
   0/evHKOdCnwNQM8POrl8FZKDYOk2Q3xtJhN22hAVEIr2YxvclivhVlUya
   ZQqdaIC4hzENdrHc4hrE8FfaOSE4bM4o/fAqPSZZT6qrMlFa2joiQBHKz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="366891188"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="366891188"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 07:04:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="749214829"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="749214829"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 27 Sep 2023 07:04:50 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qlV9j-0000Hd-2l;
        Wed, 27 Sep 2023 14:04:47 +0000
Date:   Wed, 27 Sep 2023 22:04:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 8dc0fd2f5693ab71f84fb16339c483999a909ab0
Message-ID: <202309272201.mr8RcxVs-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 8dc0fd2f5693ab71f84fb16339c483999a909ab0  RDMA/ipoib: Add support for XDR speed in ethtool

elapsed time: 1645m

configs tested: 169
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230926   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230927   gcc  
arm                           tegra_defconfig   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230926   gcc  
i386         buildonly-randconfig-001-20230927   gcc  
i386         buildonly-randconfig-002-20230926   gcc  
i386         buildonly-randconfig-002-20230927   gcc  
i386         buildonly-randconfig-003-20230926   gcc  
i386         buildonly-randconfig-003-20230927   gcc  
i386         buildonly-randconfig-004-20230926   gcc  
i386         buildonly-randconfig-004-20230927   gcc  
i386         buildonly-randconfig-005-20230926   gcc  
i386         buildonly-randconfig-005-20230927   gcc  
i386         buildonly-randconfig-006-20230926   gcc  
i386         buildonly-randconfig-006-20230927   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230927   gcc  
i386                  randconfig-002-20230927   gcc  
i386                  randconfig-003-20230927   gcc  
i386                  randconfig-004-20230927   gcc  
i386                  randconfig-005-20230927   gcc  
i386                  randconfig-006-20230927   gcc  
i386                  randconfig-011-20230926   gcc  
i386                  randconfig-011-20230927   gcc  
i386                  randconfig-012-20230926   gcc  
i386                  randconfig-012-20230927   gcc  
i386                  randconfig-013-20230926   gcc  
i386                  randconfig-013-20230927   gcc  
i386                  randconfig-014-20230926   gcc  
i386                  randconfig-014-20230927   gcc  
i386                  randconfig-015-20230926   gcc  
i386                  randconfig-015-20230927   gcc  
i386                  randconfig-016-20230926   gcc  
i386                  randconfig-016-20230927   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230926   gcc  
loongarch             randconfig-001-20230927   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath25_defconfig   clang
mips                           ci20_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                      chrp32_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230926   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230926   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20230927   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230926   gcc  
x86_64       buildonly-randconfig-001-20230927   gcc  
x86_64       buildonly-randconfig-002-20230926   gcc  
x86_64       buildonly-randconfig-002-20230927   gcc  
x86_64       buildonly-randconfig-003-20230926   gcc  
x86_64       buildonly-randconfig-003-20230927   gcc  
x86_64       buildonly-randconfig-004-20230926   gcc  
x86_64       buildonly-randconfig-004-20230927   gcc  
x86_64       buildonly-randconfig-005-20230926   gcc  
x86_64       buildonly-randconfig-005-20230927   gcc  
x86_64       buildonly-randconfig-006-20230926   gcc  
x86_64       buildonly-randconfig-006-20230927   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230927   gcc  
x86_64                randconfig-002-20230927   gcc  
x86_64                randconfig-003-20230927   gcc  
x86_64                randconfig-004-20230927   gcc  
x86_64                randconfig-005-20230927   gcc  
x86_64                randconfig-006-20230927   gcc  
x86_64                randconfig-011-20230927   gcc  
x86_64                randconfig-012-20230927   gcc  
x86_64                randconfig-013-20230927   gcc  
x86_64                randconfig-014-20230927   gcc  
x86_64                randconfig-015-20230927   gcc  
x86_64                randconfig-016-20230927   gcc  
x86_64                randconfig-071-20230926   gcc  
x86_64                randconfig-071-20230927   gcc  
x86_64                randconfig-072-20230926   gcc  
x86_64                randconfig-072-20230927   gcc  
x86_64                randconfig-073-20230926   gcc  
x86_64                randconfig-073-20230927   gcc  
x86_64                randconfig-074-20230926   gcc  
x86_64                randconfig-074-20230927   gcc  
x86_64                randconfig-075-20230926   gcc  
x86_64                randconfig-075-20230927   gcc  
x86_64                randconfig-076-20230926   gcc  
x86_64                randconfig-076-20230927   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
