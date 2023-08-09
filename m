Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CF4775352
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Aug 2023 08:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjHIG5d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Aug 2023 02:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHIG5b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Aug 2023 02:57:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40864133
        for <linux-rdma@vger.kernel.org>; Tue,  8 Aug 2023 23:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691564251; x=1723100251;
  h=date:from:to:cc:subject:message-id;
  bh=wesb8ghFElHtByLpjuuzfeB+fDOfArOLu3a1po/Kl0M=;
  b=b5BN++lZNZNOOD/4+IUfe2OvD4WjXeSgouoJuSWXHuW/H992M0L6bSdB
   D3VT0Io3aOMMSVJorvpnKh8Z5i9acKRCrBqBV1FhxrHkk8276h4vu20YF
   gXEEewkvF5sr5NFJWNSuj2pO8eIfL/NTa6cFhHcv9RcDnonwadRapd/TA
   vWEYXZeSxXs9Ky6MyD4Bjfkau93NP15LzyS8M849Lj1KLCcM+fSNabJ0F
   nVFCRd/aAAnFneCXMJiRWmqgN68fCOBSQL2uYl4821sfDf7X32SGrU9FP
   lfaKLjwjvSjcC48P9i20YCWzUf+Z+k34VsJULAyKJMzcWpiUlC2ODmWRJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="434927227"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="434927227"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 23:57:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="725260901"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="725260901"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 08 Aug 2023 23:57:25 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qTd8G-0005u2-3A;
        Wed, 09 Aug 2023 06:57:24 +0000
Date:   Wed, 09 Aug 2023 14:56:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: [rdma:for-rc] BUILD SUCCESS
 8e7b295da1ed051baedd068b7f785f5d959ef95d
Message-ID: <202308091447.rwmh15TG-lkp@intel.com>
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
branch HEAD: 8e7b295da1ed051baedd068b7f785f5d959ef95d  MAINTAINERS: Remove maintainer of HiSilicon RoCE

elapsed time: 737m

configs tested: 136
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r023-20230808   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r015-20230808   gcc  
arc                  randconfig-r043-20230808   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r003-20230808   gcc  
arm                  randconfig-r032-20230808   gcc  
arm                  randconfig-r046-20230808   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230808   gcc  
csky                 randconfig-r014-20230808   gcc  
csky                 randconfig-r016-20230808   gcc  
hexagon              randconfig-r016-20230808   clang
hexagon              randconfig-r022-20230808   clang
hexagon              randconfig-r026-20230808   clang
hexagon              randconfig-r041-20230808   clang
hexagon              randconfig-r045-20230808   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230808   clang
i386         buildonly-randconfig-r005-20230808   clang
i386         buildonly-randconfig-r006-20230808   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230808   clang
i386                 randconfig-i002-20230808   clang
i386                 randconfig-i003-20230808   clang
i386                 randconfig-i004-20230808   clang
i386                 randconfig-i005-20230808   clang
i386                 randconfig-i006-20230808   clang
i386                 randconfig-i011-20230808   gcc  
i386                 randconfig-i012-20230808   gcc  
i386                 randconfig-i013-20230808   gcc  
i386                 randconfig-i014-20230808   gcc  
i386                 randconfig-i015-20230808   gcc  
i386                 randconfig-i016-20230808   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r021-20230808   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r011-20230808   gcc  
m68k                 randconfig-r012-20230808   gcc  
m68k                 randconfig-r024-20230808   gcc  
m68k                 randconfig-r034-20230808   gcc  
microblaze           randconfig-r002-20230808   gcc  
microblaze           randconfig-r006-20230808   gcc  
microblaze           randconfig-r013-20230808   gcc  
microblaze           randconfig-r033-20230808   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r013-20230808   clang
mips                 randconfig-r023-20230808   clang
mips                 randconfig-r024-20230808   clang
nios2                               defconfig   gcc  
nios2                randconfig-r013-20230808   gcc  
nios2                randconfig-r036-20230808   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r005-20230808   gcc  
parisc               randconfig-r013-20230808   gcc  
parisc               randconfig-r026-20230808   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r004-20230808   clang
powerpc              randconfig-r011-20230808   gcc  
powerpc              randconfig-r014-20230808   gcc  
powerpc              randconfig-r022-20230808   gcc  
powerpc              randconfig-r031-20230808   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230808   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r015-20230808   gcc  
s390                 randconfig-r034-20230808   clang
s390                 randconfig-r035-20230808   clang
s390                 randconfig-r044-20230808   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r001-20230808   gcc  
sh                   randconfig-r002-20230808   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r025-20230808   gcc  
sparc64              randconfig-r004-20230808   gcc  
sparc64              randconfig-r006-20230808   gcc  
sparc64              randconfig-r011-20230808   gcc  
sparc64              randconfig-r014-20230808   gcc  
sparc64              randconfig-r025-20230808   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r012-20230808   clang
um                   randconfig-r021-20230808   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230808   clang
x86_64       buildonly-randconfig-r002-20230808   clang
x86_64       buildonly-randconfig-r003-20230808   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r012-20230808   gcc  
x86_64               randconfig-r033-20230808   clang
x86_64               randconfig-r036-20230808   clang
x86_64               randconfig-x001-20230808   gcc  
x86_64               randconfig-x002-20230808   gcc  
x86_64               randconfig-x003-20230808   gcc  
x86_64               randconfig-x004-20230808   gcc  
x86_64               randconfig-x005-20230808   gcc  
x86_64               randconfig-x006-20230808   gcc  
x86_64               randconfig-x011-20230808   clang
x86_64               randconfig-x012-20230808   clang
x86_64               randconfig-x013-20230808   clang
x86_64               randconfig-x014-20230808   clang
x86_64               randconfig-x015-20230808   clang
x86_64               randconfig-x016-20230808   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r016-20230808   gcc  
xtensa               randconfig-r031-20230808   gcc  
xtensa               randconfig-r035-20230808   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
