Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634767E0EE0
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Nov 2023 12:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjKDLDE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 4 Nov 2023 07:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjKDLDD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 4 Nov 2023 07:03:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A68D53
        for <linux-rdma@vger.kernel.org>; Sat,  4 Nov 2023 04:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699095750; x=1730631750;
  h=date:from:to:cc:subject:message-id;
  bh=HPELIxEuFirGb7lLnU6i+o9IfJG/zeb70In1qTn+q0U=;
  b=nHkQyQFSRjMEYI6WZs9DLvg3/riBhtCeydixm1Ss9Bthmix+goWmJiPG
   lwRpqSrv7r5itG6a0VGoqTrv3W49/OgkmP6JxUeSHx485pRI/Caawl/Qf
   j64E5f3ZjIdQjO+gJLF65YxXAEMoBMlTkCcPV7AwWAQxGFUuMksYFC/Zr
   Y2u7Fq7bRLvg/PtyKyi4e+Te77j3HH1N8ys1PrxOlvulyxXkaMpMBsiC7
   nxJZE2xnNNQdXHNoLLpum8ShZv7NMQPEoEM2dNW1V29P4fXS6M7g1Tal5
   5yGS0F84UW4KrrMbjd/QwqaOda1murSxlvtHKoNJ936gJX13EaFLgvM37
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="391946486"
X-IronPort-AV: E=Sophos;i="6.03,276,1694761200"; 
   d="scan'208";a="391946486"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2023 04:02:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="1009061074"
X-IronPort-AV: E=Sophos;i="6.03,276,1694761200"; 
   d="scan'208";a="1009061074"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 04 Nov 2023 04:02:27 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzEQ5-0003sd-2m;
        Sat, 04 Nov 2023 11:02:25 +0000
Date:   Sat, 04 Nov 2023 19:02:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 2ef422f063b74adcc4a4a9004b0a87bb55e0a836
Message-ID: <202311041917.SVw7DxFa-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 2ef422f063b74adcc4a4a9004b0a87bb55e0a836  IB/mlx5: Fix init stage error handling to avoid double free of same QP and UAF

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-randconfig-002-20231101
|   `-- tools-testing-selftests-kvm-.gitignore:warning:ignored-by-one-of-the-.gitignore-files
|-- arm64-defconfig
|   `-- tools-testing-selftests-kvm-.gitignore:warning:ignored-by-one-of-the-.gitignore-files
|-- i386-allmodconfig
|   `-- tools-testing-selftests-kvm-.gitignore:warning:ignored-by-one-of-the-.gitignore-files
|-- i386-allnoconfig
|   `-- tools-testing-selftests-kvm-.gitignore:warning:ignored-by-one-of-the-.gitignore-files
|-- i386-debian-10.3
|   `-- tools-testing-selftests-kvm-.gitignore:warning:ignored-by-one-of-the-.gitignore-files
`-- i386-defconfig
    `-- tools-testing-selftests-kvm-.gitignore:warning:ignored-by-one-of-the-.gitignore-files

elapsed time: 5047m

configs tested: 143
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
arc                   randconfig-001-20231101   gcc  
arc                   randconfig-002-20231101   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231101   gcc  
arm                   randconfig-002-20231101   gcc  
arm                   randconfig-003-20231101   gcc  
arm                   randconfig-004-20231101   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231101   gcc  
arm64                 randconfig-002-20231101   gcc  
arm64                 randconfig-003-20231101   gcc  
arm64                 randconfig-004-20231101   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231101   gcc  
csky                  randconfig-002-20231101   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231101   gcc  
i386                  randconfig-002-20231101   gcc  
i386                  randconfig-003-20231101   gcc  
i386                  randconfig-004-20231101   gcc  
i386                  randconfig-005-20231101   gcc  
i386                  randconfig-006-20231101   gcc  
i386                  randconfig-011-20231101   gcc  
i386                  randconfig-012-20231101   gcc  
i386                  randconfig-013-20231101   gcc  
i386                  randconfig-014-20231101   gcc  
i386                  randconfig-015-20231101   gcc  
i386                  randconfig-016-20231101   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231101   gcc  
loongarch             randconfig-002-20231101   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231101   gcc  
nios2                 randconfig-002-20231101   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231101   gcc  
parisc                randconfig-002-20231101   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc               randconfig-001-20231101   gcc  
powerpc               randconfig-002-20231101   gcc  
powerpc               randconfig-003-20231101   gcc  
powerpc64             randconfig-001-20231101   gcc  
powerpc64             randconfig-002-20231101   gcc  
powerpc64             randconfig-003-20231101   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231101   gcc  
riscv                 randconfig-002-20231101   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231101   gcc  
s390                  randconfig-002-20231101   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
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
x86_64       buildonly-randconfig-001-20231101   gcc  
x86_64       buildonly-randconfig-002-20231101   gcc  
x86_64       buildonly-randconfig-003-20231101   gcc  
x86_64       buildonly-randconfig-004-20231101   gcc  
x86_64       buildonly-randconfig-005-20231101   gcc  
x86_64       buildonly-randconfig-006-20231101   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231101   gcc  
x86_64                randconfig-002-20231101   gcc  
x86_64                randconfig-003-20231101   gcc  
x86_64                randconfig-004-20231101   gcc  
x86_64                randconfig-005-20231101   gcc  
x86_64                randconfig-006-20231101   gcc  
x86_64                randconfig-011-20231101   gcc  
x86_64                randconfig-012-20231101   gcc  
x86_64                randconfig-013-20231101   gcc  
x86_64                randconfig-014-20231101   gcc  
x86_64                randconfig-015-20231101   gcc  
x86_64                randconfig-016-20231101   gcc  
x86_64                randconfig-071-20231102   gcc  
x86_64                randconfig-072-20231102   gcc  
x86_64                randconfig-073-20231102   gcc  
x86_64                randconfig-074-20231102   gcc  
x86_64                randconfig-075-20231102   gcc  
x86_64                randconfig-076-20231102   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
