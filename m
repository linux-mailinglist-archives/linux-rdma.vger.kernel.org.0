Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE2F77D4F5
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Aug 2023 23:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbjHOVNA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Aug 2023 17:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240199AbjHOVMb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Aug 2023 17:12:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248D5114
        for <linux-rdma@vger.kernel.org>; Tue, 15 Aug 2023 14:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692133950; x=1723669950;
  h=date:from:to:cc:subject:message-id;
  bh=/RSYGjrUsqhZa+j3SUNK4yUlMYKEz6R3Wf9s3JM5Nls=;
  b=mYaNuSR9afjEzIjrILmA3PoDftpL2bPQfDtyrBlDLz99Qq7x/rg22tUL
   EGoPP7m/G1nTksd8E2uLdDJJKV4pijUaASxmg8TSdXvJdAApV8i+8hq46
   0xjwIy0dTq/kFJ8E8nPbOwbZcwg/fqmabUaiUEcUT0xkGmVOOHxtUvtLS
   43loRDOTcgk/2HbGgOYiG288niImJo8y9++7t/Hqkb+Wte9Y6mi1jJ2m/
   PhlnMTFgb0LpNVKsh4EFKWj79GlrUC+PjVxYfaC0WDRoukKICO6pRVeDY
   eA4zg5BpJVoTEUdqcatdoPWLqfZ+Y8ej28ajFDtzjlbaEW3rSwC/8+RXT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="362532639"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="362532639"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 14:12:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="907763125"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="907763125"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 15 Aug 2023 14:12:10 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qW1Kj-0001EX-2v;
        Tue, 15 Aug 2023 21:12:09 +0000
Date:   Wed, 16 Aug 2023 05:11:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 213d2b9bb2d6aa50f9cbc02a0eea2096899d2e75
Message-ID: <202308160525.K0rLlxif-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 213d2b9bb2d6aa50f9cbc02a0eea2096899d2e75  RDMA/bnxt_re: Protect the PD table bitmap

elapsed time: 725m

configs tested: 208
configs skipped: 22

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r021-20230815   gcc  
alpha                randconfig-r033-20230816   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                  randconfig-r001-20230815   gcc  
arc                  randconfig-r006-20230816   gcc  
arc                  randconfig-r035-20230815   gcc  
arm                              alldefconfig   clang
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                       multi_v4t_defconfig   gcc  
arm                  randconfig-r003-20230816   clang
arm                  randconfig-r004-20230815   gcc  
arm                  randconfig-r016-20230815   clang
arm                  randconfig-r031-20230815   gcc  
arm                         socfpga_defconfig   clang
arm                        vexpress_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r005-20230815   gcc  
csky                 randconfig-r023-20230815   gcc  
csky                 randconfig-r026-20230816   gcc  
csky                 randconfig-r032-20230816   gcc  
hexagon              randconfig-r012-20230815   clang
hexagon              randconfig-r016-20230816   clang
hexagon              randconfig-r026-20230815   clang
hexagon              randconfig-r035-20230815   clang
hexagon              randconfig-r041-20230816   clang
hexagon              randconfig-r045-20230816   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230815   clang
i386         buildonly-randconfig-r004-20230816   gcc  
i386         buildonly-randconfig-r005-20230815   clang
i386         buildonly-randconfig-r005-20230816   gcc  
i386         buildonly-randconfig-r006-20230815   clang
i386         buildonly-randconfig-r006-20230816   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230815   clang
i386                 randconfig-i001-20230816   gcc  
i386                 randconfig-i002-20230815   clang
i386                 randconfig-i002-20230816   gcc  
i386                 randconfig-i003-20230815   clang
i386                 randconfig-i003-20230816   gcc  
i386                 randconfig-i004-20230815   clang
i386                 randconfig-i004-20230816   gcc  
i386                 randconfig-i005-20230815   clang
i386                 randconfig-i005-20230816   gcc  
i386                 randconfig-i006-20230815   clang
i386                 randconfig-i006-20230816   gcc  
i386                 randconfig-i011-20230815   gcc  
i386                 randconfig-i011-20230816   clang
i386                 randconfig-i012-20230815   gcc  
i386                 randconfig-i012-20230816   clang
i386                 randconfig-i013-20230815   gcc  
i386                 randconfig-i013-20230816   clang
i386                 randconfig-i014-20230815   gcc  
i386                 randconfig-i014-20230816   clang
i386                 randconfig-i015-20230815   gcc  
i386                 randconfig-i015-20230816   clang
i386                 randconfig-i016-20230815   gcc  
i386                 randconfig-i016-20230816   clang
i386                 randconfig-r003-20230815   clang
i386                 randconfig-r024-20230815   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r033-20230815   gcc  
m68k                             alldefconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r015-20230815   gcc  
m68k                 randconfig-r032-20230815   gcc  
microblaze           randconfig-r022-20230816   gcc  
microblaze           randconfig-r034-20230816   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ci20_defconfig   gcc  
mips                        qi_lb60_defconfig   clang
mips                        qi_lb60_defconfig   gcc  
mips                 randconfig-r006-20230815   gcc  
mips                 randconfig-r032-20230815   gcc  
mips                         rt305x_defconfig   gcc  
nios2                            alldefconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r011-20230815   gcc  
nios2                randconfig-r012-20230815   gcc  
nios2                randconfig-r031-20230816   gcc  
nios2                randconfig-r032-20230816   gcc  
openrisc             randconfig-r002-20230816   gcc  
openrisc             randconfig-r012-20230815   gcc  
openrisc             randconfig-r014-20230815   gcc  
openrisc             randconfig-r015-20230815   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r022-20230815   gcc  
parisc               randconfig-r026-20230815   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   bluestone_defconfig   clang
powerpc                       maple_defconfig   gcc  
powerpc                      pmac32_defconfig   clang
powerpc              randconfig-r001-20230815   clang
powerpc              randconfig-r011-20230815   gcc  
powerpc              randconfig-r013-20230815   gcc  
powerpc                  storcenter_defconfig   gcc  
powerpc                      tqm8xx_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r012-20230816   clang
riscv                randconfig-r014-20230816   clang
riscv                randconfig-r025-20230815   gcc  
riscv                randconfig-r042-20230816   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r015-20230816   clang
s390                 randconfig-r044-20230815   gcc  
s390                 randconfig-r044-20230816   clang
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                               j2_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                   randconfig-r001-20230816   gcc  
sh                   randconfig-r013-20230815   gcc  
sh                   randconfig-r021-20230815   gcc  
sh                   randconfig-r021-20230816   gcc  
sh                   randconfig-r034-20230815   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230815   gcc  
sparc                randconfig-r024-20230816   gcc  
sparc                randconfig-r036-20230815   gcc  
sparc64              randconfig-r002-20230815   gcc  
sparc64              randconfig-r004-20230816   gcc  
sparc64              randconfig-r005-20230815   gcc  
sparc64              randconfig-r011-20230815   gcc  
sparc64              randconfig-r016-20230815   gcc  
sparc64              randconfig-r034-20230815   gcc  
sparc64              randconfig-r034-20230816   gcc  
sparc64              randconfig-r035-20230816   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r001-20230816   clang
um                   randconfig-r025-20230815   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230815   clang
x86_64       buildonly-randconfig-r001-20230816   gcc  
x86_64       buildonly-randconfig-r002-20230815   clang
x86_64       buildonly-randconfig-r002-20230816   gcc  
x86_64       buildonly-randconfig-r003-20230815   clang
x86_64       buildonly-randconfig-r003-20230816   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r002-20230815   clang
x86_64               randconfig-r015-20230815   gcc  
x86_64               randconfig-r016-20230815   gcc  
x86_64               randconfig-r034-20230815   clang
x86_64               randconfig-r035-20230816   gcc  
x86_64               randconfig-x001-20230815   gcc  
x86_64               randconfig-x001-20230816   clang
x86_64               randconfig-x002-20230815   gcc  
x86_64               randconfig-x002-20230816   clang
x86_64               randconfig-x003-20230815   gcc  
x86_64               randconfig-x003-20230816   clang
x86_64               randconfig-x004-20230815   gcc  
x86_64               randconfig-x004-20230816   clang
x86_64               randconfig-x005-20230815   gcc  
x86_64               randconfig-x005-20230816   clang
x86_64               randconfig-x006-20230815   gcc  
x86_64               randconfig-x006-20230816   clang
x86_64               randconfig-x011-20230815   clang
x86_64               randconfig-x011-20230816   gcc  
x86_64               randconfig-x012-20230815   clang
x86_64               randconfig-x012-20230816   gcc  
x86_64               randconfig-x013-20230815   clang
x86_64               randconfig-x013-20230816   gcc  
x86_64               randconfig-x014-20230815   clang
x86_64               randconfig-x014-20230816   gcc  
x86_64               randconfig-x015-20230815   clang
x86_64               randconfig-x015-20230816   gcc  
x86_64               randconfig-x016-20230815   clang
x86_64               randconfig-x016-20230816   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                       common_defconfig   gcc  
xtensa               randconfig-r031-20230815   gcc  
xtensa               randconfig-r036-20230815   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
