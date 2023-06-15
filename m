Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E92D730F13
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jun 2023 08:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242097AbjFOGI0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Jun 2023 02:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243107AbjFOGHw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Jun 2023 02:07:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE24172A
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jun 2023 23:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686809269; x=1718345269;
  h=date:from:to:cc:subject:message-id;
  bh=TJCb6a0+Vq8X/VU3ucvv6Rmg6adAxe/o9VunhDHsrrM=;
  b=kMkyUE1ANI4tRAqPaqUA7kALonZkgpqpvao6TsCJ4rvqRuraal/KtHYp
   JzNUzKlISSoxXOHmfNQ3xMZlYkfig7LanfQjj3uOLJEcJXylxig7k8YGa
   j9ZA1p0EcsSQUjcgPPR//BK2k8OZobZRYr2tZFH1ScFp2Cn7/rVv+zmdu
   dIWrS2Vhh7oaeFnIFvcXGSY/ybxpIE5u+Mxg5kEa/1TgYqXxP9yKxGj73
   9ID9MX75Q+6pHQL93Np6aznbycR38yRt2P/eJl9UtmA1fphb99bHYZavv
   k9LM3wL1C4sX009NznYB/Bvu+fBxe+mbtxpfBzMCcrGtxLRhGIMJiK6nF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="361300330"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="361300330"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 23:07:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="836505757"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="836505757"
Received: from lkp-server02.sh.intel.com (HELO d59cacf64e9e) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 14 Jun 2023 23:07:47 -0700
Received: from kbuild by d59cacf64e9e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9g94-0001XV-0C;
        Thu, 15 Jun 2023 06:07:46 +0000
Date:   Thu, 15 Jun 2023 14:07:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:for-rc] BUILD SUCCESS
 0c7e314a6352664e12ec465f576cf039e95f8369
Message-ID: <202306151438.jXpSnsgj-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: 0c7e314a6352664e12ec465f576cf039e95f8369  RDMA/rxe: Fix rxe_cq_post

elapsed time: 733m

configs tested: 190
configs skipped: 16

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230614   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230612   gcc  
alpha                randconfig-r014-20230614   gcc  
alpha                randconfig-r022-20230612   gcc  
alpha                randconfig-r025-20230612   gcc  
alpha                randconfig-r025-20230614   gcc  
alpha                randconfig-r026-20230612   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r001-20230614   gcc  
arc          buildonly-randconfig-r003-20230614   gcc  
arc          buildonly-randconfig-r006-20230614   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r012-20230614   gcc  
arc                  randconfig-r021-20230612   gcc  
arc                  randconfig-r043-20230612   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r001-20230614   clang
arm                                 defconfig   gcc  
arm                         nhk8815_defconfig   gcc  
arm                  randconfig-r005-20230612   gcc  
arm                  randconfig-r023-20230614   clang
arm                  randconfig-r026-20230612   clang
arm                  randconfig-r036-20230612   gcc  
arm                  randconfig-r046-20230612   clang
arm                           sama5_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230612   clang
arm64                randconfig-r015-20230614   gcc  
arm64                randconfig-r016-20230614   gcc  
arm64                randconfig-r031-20230612   clang
arm64                randconfig-r036-20230612   clang
csky                                defconfig   gcc  
csky                 randconfig-r002-20230612   gcc  
csky                 randconfig-r003-20230612   gcc  
csky                 randconfig-r011-20230614   gcc  
csky                 randconfig-r026-20230614   gcc  
csky                 randconfig-r031-20230612   gcc  
csky                 randconfig-r034-20230612   gcc  
csky                 randconfig-r036-20230612   gcc  
hexagon      buildonly-randconfig-r004-20230614   clang
hexagon              randconfig-r003-20230612   clang
hexagon              randconfig-r004-20230612   clang
hexagon              randconfig-r014-20230614   clang
hexagon              randconfig-r035-20230612   clang
hexagon              randconfig-r036-20230612   clang
hexagon              randconfig-r041-20230612   clang
hexagon              randconfig-r045-20230612   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r005-20230614   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230614   clang
i386                 randconfig-i002-20230614   clang
i386                 randconfig-i003-20230614   clang
i386                 randconfig-i004-20230614   clang
i386                 randconfig-i005-20230614   clang
i386                 randconfig-i006-20230614   clang
i386                 randconfig-i011-20230612   gcc  
i386                 randconfig-i011-20230614   gcc  
i386                 randconfig-i012-20230612   gcc  
i386                 randconfig-i012-20230614   gcc  
i386                 randconfig-i013-20230612   gcc  
i386                 randconfig-i013-20230614   gcc  
i386                 randconfig-i014-20230612   gcc  
i386                 randconfig-i014-20230614   gcc  
i386                 randconfig-i015-20230612   gcc  
i386                 randconfig-i015-20230614   gcc  
i386                 randconfig-i016-20230612   gcc  
i386                 randconfig-i016-20230614   gcc  
i386                 randconfig-r025-20230612   gcc  
i386                 randconfig-r031-20230612   clang
i386                 randconfig-r035-20230612   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230612   gcc  
loongarch            randconfig-r006-20230612   gcc  
loongarch            randconfig-r013-20230614   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k         buildonly-randconfig-r002-20230614   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                 randconfig-r002-20230612   gcc  
m68k                 randconfig-r003-20230612   gcc  
m68k                 randconfig-r012-20230614   gcc  
m68k                 randconfig-r013-20230614   gcc  
m68k                 randconfig-r032-20230612   gcc  
m68k                 randconfig-r033-20230612   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze   buildonly-randconfig-r006-20230614   gcc  
microblaze           randconfig-r016-20230614   gcc  
microblaze           randconfig-r021-20230614   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   clang
mips                 randconfig-r001-20230612   gcc  
mips                 randconfig-r021-20230612   clang
mips                 randconfig-r024-20230612   clang
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230612   gcc  
nios2                randconfig-r004-20230612   gcc  
nios2                randconfig-r032-20230612   gcc  
openrisc             randconfig-r001-20230612   gcc  
openrisc             randconfig-r006-20230612   gcc  
openrisc             randconfig-r024-20230612   gcc  
openrisc             randconfig-r034-20230612   gcc  
parisc                           allyesconfig   gcc  
parisc       buildonly-randconfig-r003-20230614   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r013-20230614   gcc  
parisc               randconfig-r023-20230612   gcc  
parisc               randconfig-r031-20230612   gcc  
parisc               randconfig-r033-20230612   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r005-20230614   gcc  
powerpc              randconfig-r001-20230612   clang
powerpc              randconfig-r011-20230614   gcc  
powerpc              randconfig-r015-20230614   gcc  
powerpc              randconfig-r032-20230612   clang
powerpc                     stx_gp3_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv        buildonly-randconfig-r001-20230614   gcc  
riscv        buildonly-randconfig-r003-20230614   gcc  
riscv        buildonly-randconfig-r004-20230614   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230612   gcc  
riscv                          rv32_defconfig   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r001-20230614   gcc  
s390         buildonly-randconfig-r002-20230614   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230612   clang
s390                 randconfig-r015-20230614   gcc  
s390                 randconfig-r016-20230614   gcc  
s390                 randconfig-r021-20230612   gcc  
s390                 randconfig-r025-20230612   gcc  
s390                 randconfig-r044-20230612   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r006-20230614   gcc  
sh                           se7343_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r011-20230614   gcc  
sparc                randconfig-r022-20230612   gcc  
sparc                randconfig-r023-20230612   gcc  
sparc64              randconfig-r004-20230612   gcc  
sparc64              randconfig-r006-20230612   gcc  
sparc64              randconfig-r011-20230614   gcc  
sparc64              randconfig-r015-20230614   gcc  
sparc64              randconfig-r035-20230612   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230612   clang
x86_64               randconfig-a002-20230612   clang
x86_64               randconfig-a003-20230612   clang
x86_64               randconfig-a004-20230612   clang
x86_64               randconfig-a005-20230612   clang
x86_64               randconfig-a006-20230612   clang
x86_64               randconfig-a011-20230612   gcc  
x86_64               randconfig-a012-20230612   gcc  
x86_64               randconfig-a013-20230612   gcc  
x86_64               randconfig-a014-20230612   gcc  
x86_64               randconfig-a015-20230612   gcc  
x86_64               randconfig-a016-20230612   gcc  
x86_64               randconfig-r022-20230614   gcc  
x86_64               randconfig-r033-20230612   clang
x86_64               randconfig-r034-20230612   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r002-20230614   gcc  
xtensa       buildonly-randconfig-r006-20230614   gcc  
xtensa               randconfig-r014-20230614   gcc  
xtensa               randconfig-r016-20230614   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
