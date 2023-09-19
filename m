Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380997A6ED5
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 00:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjISWuI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Sep 2023 18:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjISWuH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Sep 2023 18:50:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D672BA
        for <linux-rdma@vger.kernel.org>; Tue, 19 Sep 2023 15:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695163801; x=1726699801;
  h=date:from:to:cc:subject:message-id;
  bh=hHyGUzPJ1I3C32CXAII3lanHEwkLc4Zz+HKHb5Ev3i0=;
  b=XIxEy+CUczh/Kxn+k4HQuE6eo97EAAI/ckmNcOxV58I6zGr69xZP7TGb
   os9GprAemwU60Hb8ttgNU75kAn2Xgt6hEmqv3yRzE0jm1cw4KImy8jrL8
   dPcfIfRb9fbQtrIVn6uu5Mc1YFEQNi74vb4gtHE3wC1XxvxfwfetLDdIq
   SmlWvurMjId0lCk4ekADixJJNUTy990zXkv+/xxiHYZjN2yx2SmwI3Tpt
   /CrVC2NINseC+0Pa/ocbjaIpTTRqDxFvB83dxz3epN/Cyn9ZInWk7bvn8
   Z8op976ceVcXFayvjYVZ8zRfZj9nDHv9cVurpCTfMIqJiGgwK40Xo2E41
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="466384869"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="466384869"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 15:49:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="836604989"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="836604989"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Sep 2023 15:49:48 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qijVq-00081M-2A;
        Tue, 19 Sep 2023 22:49:46 +0000
Date:   Wed, 20 Sep 2023 06:44:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 c5930a1aa08aafe6ffe15b5d28fe875f88f6ac86
Message-ID: <202309200610.tDGKROV3-lkp@intel.com>
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
branch HEAD: c5930a1aa08aafe6ffe15b5d28fe875f88f6ac86  RDMA/rtrs: Fix the problem of variable not initialized fully

elapsed time: 728m

configs tested: 185
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
arc                   randconfig-001-20230919   gcc  
arc                   randconfig-001-20230920   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                   randconfig-001-20230919   gcc  
arm                   randconfig-001-20230920   gcc  
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
i386         buildonly-randconfig-001-20230920   gcc  
i386         buildonly-randconfig-002-20230919   gcc  
i386         buildonly-randconfig-002-20230920   gcc  
i386         buildonly-randconfig-003-20230920   gcc  
i386         buildonly-randconfig-004-20230920   gcc  
i386         buildonly-randconfig-005-20230920   gcc  
i386         buildonly-randconfig-006-20230920   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230919   gcc  
i386                  randconfig-001-20230920   gcc  
i386                  randconfig-002-20230919   gcc  
i386                  randconfig-002-20230920   gcc  
i386                  randconfig-003-20230919   gcc  
i386                  randconfig-003-20230920   gcc  
i386                  randconfig-004-20230919   gcc  
i386                  randconfig-004-20230920   gcc  
i386                  randconfig-005-20230919   gcc  
i386                  randconfig-005-20230920   gcc  
i386                  randconfig-006-20230919   gcc  
i386                  randconfig-006-20230920   gcc  
i386                  randconfig-011-20230920   gcc  
i386                  randconfig-012-20230920   gcc  
i386                  randconfig-013-20230920   gcc  
i386                  randconfig-014-20230920   gcc  
i386                  randconfig-015-20230920   gcc  
i386                  randconfig-016-20230920   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230919   gcc  
loongarch             randconfig-001-20230920   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath25_defconfig   clang
mips                         bigsur_defconfig   gcc  
mips                        qi_lb60_defconfig   clang
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
parisc                generic-32bit_defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                      bamboo_defconfig   gcc  
powerpc                     ppa8548_defconfig   clang
powerpc                        warp_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230919   gcc  
riscv                 randconfig-001-20230920   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230919   gcc  
s390                  randconfig-001-20230920   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20230919   gcc  
sparc                 randconfig-001-20230920   gcc  
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
x86_64       buildonly-randconfig-001-20230919   gcc  
x86_64       buildonly-randconfig-001-20230920   gcc  
x86_64       buildonly-randconfig-002-20230919   gcc  
x86_64       buildonly-randconfig-002-20230920   gcc  
x86_64       buildonly-randconfig-003-20230919   gcc  
x86_64       buildonly-randconfig-003-20230920   gcc  
x86_64       buildonly-randconfig-004-20230919   gcc  
x86_64       buildonly-randconfig-004-20230920   gcc  
x86_64       buildonly-randconfig-005-20230919   gcc  
x86_64       buildonly-randconfig-005-20230920   gcc  
x86_64       buildonly-randconfig-006-20230919   gcc  
x86_64       buildonly-randconfig-006-20230920   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230919   gcc  
x86_64                randconfig-001-20230920   gcc  
x86_64                randconfig-002-20230919   gcc  
x86_64                randconfig-002-20230920   gcc  
x86_64                randconfig-003-20230919   gcc  
x86_64                randconfig-003-20230920   gcc  
x86_64                randconfig-004-20230919   gcc  
x86_64                randconfig-004-20230920   gcc  
x86_64                randconfig-005-20230919   gcc  
x86_64                randconfig-005-20230920   gcc  
x86_64                randconfig-006-20230919   gcc  
x86_64                randconfig-006-20230920   gcc  
x86_64                randconfig-011-20230919   gcc  
x86_64                randconfig-011-20230920   gcc  
x86_64                randconfig-012-20230919   gcc  
x86_64                randconfig-012-20230920   gcc  
x86_64                randconfig-013-20230919   gcc  
x86_64                randconfig-013-20230920   gcc  
x86_64                randconfig-014-20230919   gcc  
x86_64                randconfig-014-20230920   gcc  
x86_64                randconfig-015-20230919   gcc  
x86_64                randconfig-015-20230920   gcc  
x86_64                randconfig-016-20230919   gcc  
x86_64                randconfig-016-20230920   gcc  
x86_64                randconfig-071-20230919   gcc  
x86_64                randconfig-071-20230920   gcc  
x86_64                randconfig-072-20230919   gcc  
x86_64                randconfig-072-20230920   gcc  
x86_64                randconfig-073-20230919   gcc  
x86_64                randconfig-073-20230920   gcc  
x86_64                randconfig-074-20230919   gcc  
x86_64                randconfig-074-20230920   gcc  
x86_64                randconfig-075-20230919   gcc  
x86_64                randconfig-075-20230920   gcc  
x86_64                randconfig-076-20230919   gcc  
x86_64                randconfig-076-20230920   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                              defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
