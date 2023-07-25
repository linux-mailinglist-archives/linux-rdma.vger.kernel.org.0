Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B35760898
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jul 2023 06:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjGYEcg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jul 2023 00:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjGYEcZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jul 2023 00:32:25 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8C92D71
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jul 2023 21:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690259518; x=1721795518;
  h=date:from:to:cc:subject:message-id;
  bh=ExAsTefgGNrxfsY3u7XanHsQwOsZV0FVzTLQge41hZ0=;
  b=SIoXLVx6Lncu82ZWFO+Dpw2CafR8BpBlw9wNGYSPcY8pvPyXfqpczi7b
   ARiOxmTTO/7CUW/woYAZSWyF7sWNsMIEOO07eI/m66y94KmSGSIoy1pn1
   AQjBPwCPTBics7q2kjjc0LIZ8plNHFEkDO2zEnN8ApuHd5EY11Isctyqq
   kS3p4fhbUxSPEeeVlYu+a6/+WdgwC4BFVsRGMwMLQlJN3mYcn6xTFkTB9
   ucEjNIfn10CdknG120YGr1MAeO2fNJPkQw8MNFhiZKUfrz0b6vwaPcpEl
   dMgm67ENlWXgf2xeHD5NNUarItwe4u2A+AdAMa31Nzjwq5u4AtjyuTXq6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="431414973"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="431414973"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 21:31:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="755572219"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="755572219"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 24 Jul 2023 21:31:56 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qO9iC-000AKR-09;
        Tue, 25 Jul 2023 04:31:53 +0000
Date:   Tue, 25 Jul 2023 12:30:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 24b1b5d85c1c1e1c0eb7b6d7b6986ecb6c80041d
Message-ID: <202307251243.TE6lJpwV-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 24b1b5d85c1c1e1c0eb7b6d7b6986ecb6c80041d  IB/hfi1: Use struct_size()

elapsed time: 914m

configs tested: 196
configs skipped: 17

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230724   gcc  
alpha                randconfig-r006-20230724   gcc  
alpha                randconfig-r016-20230724   gcc  
alpha                randconfig-r031-20230724   gcc  
alpha                randconfig-r032-20230724   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                  randconfig-r043-20230724   gcc  
arc                  randconfig-r043-20230725   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                            qcom_defconfig   gcc  
arm                  randconfig-r002-20230724   clang
arm                  randconfig-r011-20230724   gcc  
arm                  randconfig-r012-20230724   gcc  
arm                  randconfig-r046-20230724   gcc  
arm                           stm32_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230724   gcc  
arm64                randconfig-r023-20230724   clang
arm64                randconfig-r031-20230724   gcc  
arm64                randconfig-r032-20230725   clang
csky                                defconfig   gcc  
csky                 randconfig-r011-20230724   gcc  
hexagon              randconfig-r002-20230724   clang
hexagon              randconfig-r041-20230724   clang
hexagon              randconfig-r045-20230724   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230723   clang
i386         buildonly-randconfig-r004-20230724   gcc  
i386         buildonly-randconfig-r005-20230723   clang
i386         buildonly-randconfig-r005-20230724   gcc  
i386         buildonly-randconfig-r006-20230723   clang
i386         buildonly-randconfig-r006-20230724   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230724   gcc  
i386                 randconfig-i002-20230724   gcc  
i386                 randconfig-i003-20230724   gcc  
i386                 randconfig-i004-20230724   gcc  
i386                 randconfig-i005-20230724   gcc  
i386                 randconfig-i006-20230724   gcc  
i386                 randconfig-i011-20230724   clang
i386                 randconfig-i012-20230724   clang
i386                 randconfig-i013-20230724   clang
i386                 randconfig-i014-20230724   clang
i386                 randconfig-i015-20230724   clang
i386                 randconfig-i016-20230724   clang
i386                 randconfig-r025-20230724   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch            randconfig-r016-20230724   gcc  
loongarch            randconfig-r025-20230724   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                 randconfig-r014-20230724   gcc  
m68k                 randconfig-r015-20230724   gcc  
m68k                 randconfig-r023-20230724   gcc  
m68k                 randconfig-r031-20230724   gcc  
m68k                 randconfig-r035-20230724   gcc  
microblaze           randconfig-r001-20230724   gcc  
microblaze           randconfig-r004-20230724   gcc  
microblaze           randconfig-r015-20230724   gcc  
microblaze           randconfig-r016-20230724   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                 randconfig-r004-20230724   clang
mips                 randconfig-r005-20230724   clang
mips                 randconfig-r034-20230725   gcc  
nios2                         3c120_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230724   gcc  
nios2                randconfig-r023-20230725   gcc  
nios2                randconfig-r025-20230724   gcc  
openrisc             randconfig-r012-20230724   gcc  
openrisc             randconfig-r021-20230724   gcc  
openrisc             randconfig-r026-20230724   gcc  
openrisc             randconfig-r033-20230725   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230724   gcc  
parisc               randconfig-r005-20230724   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      chrp32_defconfig   gcc  
powerpc                      ppc40x_defconfig   gcc  
powerpc              randconfig-r006-20230724   gcc  
powerpc              randconfig-r023-20230724   clang
powerpc              randconfig-r036-20230724   gcc  
powerpc                     stx_gp3_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r004-20230724   gcc  
riscv                randconfig-r013-20230724   clang
riscv                randconfig-r042-20230724   clang
riscv                randconfig-r042-20230725   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r021-20230724   clang
s390                 randconfig-r022-20230724   clang
s390                 randconfig-r026-20230724   clang
s390                 randconfig-r033-20230724   gcc  
s390                 randconfig-r044-20230724   clang
s390                 randconfig-r044-20230725   gcc  
sh                               allmodconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                   randconfig-r004-20230724   gcc  
sh                   randconfig-r013-20230724   gcc  
sh                             sh03_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230724   gcc  
sparc                randconfig-r005-20230724   gcc  
sparc                randconfig-r012-20230724   gcc  
sparc                randconfig-r013-20230724   gcc  
sparc                randconfig-r021-20230725   gcc  
sparc                randconfig-r036-20230724   gcc  
sparc64              randconfig-r003-20230724   gcc  
sparc64              randconfig-r035-20230724   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r003-20230724   clang
um                   randconfig-r006-20230724   clang
um                   randconfig-r024-20230724   gcc  
um                   randconfig-r035-20230724   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230723   clang
x86_64       buildonly-randconfig-r001-20230724   gcc  
x86_64       buildonly-randconfig-r002-20230723   clang
x86_64       buildonly-randconfig-r002-20230724   gcc  
x86_64       buildonly-randconfig-r003-20230723   clang
x86_64       buildonly-randconfig-r003-20230724   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r006-20230724   gcc  
x86_64               randconfig-r011-20230724   clang
x86_64               randconfig-r013-20230724   clang
x86_64               randconfig-r016-20230724   clang
x86_64               randconfig-r022-20230725   gcc  
x86_64               randconfig-r025-20230725   gcc  
x86_64               randconfig-x001-20230724   clang
x86_64               randconfig-x001-20230725   gcc  
x86_64               randconfig-x002-20230724   clang
x86_64               randconfig-x002-20230725   gcc  
x86_64               randconfig-x003-20230724   clang
x86_64               randconfig-x003-20230725   gcc  
x86_64               randconfig-x004-20230724   clang
x86_64               randconfig-x004-20230725   gcc  
x86_64               randconfig-x005-20230724   clang
x86_64               randconfig-x005-20230725   gcc  
x86_64               randconfig-x006-20230724   clang
x86_64               randconfig-x006-20230725   gcc  
x86_64               randconfig-x011-20230724   gcc  
x86_64               randconfig-x012-20230724   gcc  
x86_64               randconfig-x013-20230724   gcc  
x86_64               randconfig-x014-20230724   gcc  
x86_64               randconfig-x015-20230724   gcc  
x86_64               randconfig-x016-20230724   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa               randconfig-r003-20230724   gcc  
xtensa               randconfig-r004-20230724   gcc  
xtensa               randconfig-r012-20230724   gcc  
xtensa               randconfig-r015-20230724   gcc  
xtensa               randconfig-r033-20230724   gcc  
xtensa               randconfig-r034-20230724   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
