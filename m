Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAE07515E5
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jul 2023 03:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbjGMBsY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jul 2023 21:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjGMBsX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jul 2023 21:48:23 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33230B0
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jul 2023 18:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689212902; x=1720748902;
  h=date:from:to:cc:subject:message-id;
  bh=JzgYSWHKJGQq3SVUw0YgzV6bOTdstyg8IY5MKyDrtqE=;
  b=d6c8LKI0dlQylxjmROFmY3BRA8Us+d9s7tu1x0qP5y60W6qpKfiAp9Dr
   lSdUKyWC5jRYTrPyQJ9wB4oZuj6TYt2miXR2Cx60abnT06Gpz1Ce3WWKg
   WLiBeCMKumuKyRvorRaRepOpRoRtdsbW619XN6HVU89S60+L5u8vK2kUQ
   o+QHaKwRiTX99v+WbPW/1ULMh8fVshwLuI200myWiI1krEp1mBZJ4IiSG
   si5IaGqGSG2hFHY7v1LfISegXr07T6CYRHxjpSLzC7QgQV1N3vD247c1c
   443TCOyd052Kl8i5+HBAy7YaS+Ru7nXrHRPiVeCYQMf9cNLo0DJRxskQA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="344652362"
X-IronPort-AV: E=Sophos;i="6.01,201,1684825200"; 
   d="scan'208";a="344652362"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 18:48:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="835380019"
X-IronPort-AV: E=Sophos;i="6.01,201,1684825200"; 
   d="scan'208";a="835380019"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jul 2023 18:48:20 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qJlRL-00066v-2p;
        Thu, 13 Jul 2023 01:48:19 +0000
Date:   Thu, 13 Jul 2023 09:48:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 f877f22ac1e9bf1f9aded3765b0012851e1dc4c5
Message-ID: <202307130916.3j86iOlb-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: f877f22ac1e9bf1f9aded3765b0012851e1dc4c5  RDMA/irdma: Implement egress VLAN priority

elapsed time: 722m

configs tested: 187
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230712   gcc  
alpha                randconfig-r015-20230712   gcc  
alpha                randconfig-r022-20230712   gcc  
alpha                randconfig-r033-20230712   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r022-20230712   gcc  
arc                  randconfig-r043-20230710   gcc  
arc                  randconfig-r043-20230712   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r012-20230712   gcc  
arm                  randconfig-r031-20230712   clang
arm                  randconfig-r046-20230710   gcc  
arm                  randconfig-r046-20230712   gcc  
arm                             rpc_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230712   gcc  
arm64                randconfig-r002-20230712   gcc  
arm64                randconfig-r004-20230712   gcc  
arm64                randconfig-r012-20230713   gcc  
arm64                randconfig-r021-20230712   clang
arm64                randconfig-r031-20230712   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230712   gcc  
csky                 randconfig-r004-20230712   gcc  
csky                 randconfig-r006-20230712   gcc  
csky                 randconfig-r014-20230713   gcc  
csky                 randconfig-r015-20230712   gcc  
csky                 randconfig-r023-20230712   gcc  
csky                 randconfig-r025-20230712   gcc  
hexagon              randconfig-r011-20230712   clang
hexagon              randconfig-r013-20230712   clang
hexagon              randconfig-r024-20230712   clang
hexagon              randconfig-r041-20230710   clang
hexagon              randconfig-r041-20230712   clang
hexagon              randconfig-r045-20230710   clang
hexagon              randconfig-r045-20230712   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230712   gcc  
i386         buildonly-randconfig-r004-20230713   clang
i386         buildonly-randconfig-r005-20230712   gcc  
i386         buildonly-randconfig-r005-20230713   clang
i386         buildonly-randconfig-r006-20230712   gcc  
i386         buildonly-randconfig-r006-20230713   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230712   gcc  
i386                 randconfig-i002-20230712   gcc  
i386                 randconfig-i003-20230712   gcc  
i386                 randconfig-i004-20230712   gcc  
i386                 randconfig-i005-20230712   gcc  
i386                 randconfig-i006-20230712   gcc  
i386                 randconfig-i011-20230712   clang
i386                 randconfig-i011-20230713   gcc  
i386                 randconfig-i012-20230712   clang
i386                 randconfig-i012-20230713   gcc  
i386                 randconfig-i013-20230712   clang
i386                 randconfig-i013-20230713   gcc  
i386                 randconfig-i014-20230712   clang
i386                 randconfig-i014-20230713   gcc  
i386                 randconfig-i015-20230712   clang
i386                 randconfig-i015-20230713   gcc  
i386                 randconfig-i016-20230712   clang
i386                 randconfig-i016-20230713   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r006-20230712   gcc  
loongarch            randconfig-r023-20230712   gcc  
loongarch            randconfig-r026-20230712   gcc  
loongarch            randconfig-r036-20230712   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r015-20230713   gcc  
microblaze           randconfig-r005-20230712   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                          malta_defconfig   clang
mips                 randconfig-r004-20230712   clang
nios2                               defconfig   gcc  
nios2                randconfig-r032-20230712   gcc  
nios2                randconfig-r033-20230712   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r021-20230712   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                      obs600_defconfig   clang
powerpc              randconfig-r003-20230712   gcc  
powerpc                    sam440ep_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r016-20230713   gcc  
riscv                randconfig-r025-20230712   clang
riscv                randconfig-r026-20230712   clang
riscv                randconfig-r042-20230710   clang
riscv                randconfig-r042-20230712   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r003-20230712   gcc  
s390                 randconfig-r011-20230713   gcc  
s390                 randconfig-r044-20230710   clang
s390                 randconfig-r044-20230712   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r035-20230712   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230712   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64              randconfig-r011-20230712   gcc  
sparc64              randconfig-r014-20230712   gcc  
sparc64              randconfig-r024-20230712   gcc  
sparc64              randconfig-r032-20230712   gcc  
sparc64              randconfig-r035-20230712   gcc  
um                               alldefconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r012-20230712   gcc  
um                   randconfig-r034-20230712   clang
um                           x86_64_defconfig   gcc  
x86_64                           alldefconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230712   gcc  
x86_64       buildonly-randconfig-r001-20230713   clang
x86_64       buildonly-randconfig-r002-20230712   gcc  
x86_64       buildonly-randconfig-r002-20230713   clang
x86_64       buildonly-randconfig-r003-20230712   gcc  
x86_64       buildonly-randconfig-r003-20230713   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r013-20230713   gcc  
x86_64               randconfig-r026-20230712   clang
x86_64               randconfig-r036-20230712   gcc  
x86_64               randconfig-x001-20230710   clang
x86_64               randconfig-x001-20230712   clang
x86_64               randconfig-x001-20230713   gcc  
x86_64               randconfig-x002-20230710   clang
x86_64               randconfig-x002-20230712   clang
x86_64               randconfig-x002-20230713   gcc  
x86_64               randconfig-x003-20230710   clang
x86_64               randconfig-x003-20230712   clang
x86_64               randconfig-x003-20230713   gcc  
x86_64               randconfig-x004-20230710   clang
x86_64               randconfig-x004-20230712   clang
x86_64               randconfig-x004-20230713   gcc  
x86_64               randconfig-x005-20230710   clang
x86_64               randconfig-x005-20230712   clang
x86_64               randconfig-x005-20230713   gcc  
x86_64               randconfig-x006-20230710   clang
x86_64               randconfig-x006-20230712   clang
x86_64               randconfig-x006-20230713   gcc  
x86_64               randconfig-x011-20230710   gcc  
x86_64               randconfig-x011-20230712   gcc  
x86_64               randconfig-x012-20230710   gcc  
x86_64               randconfig-x012-20230712   gcc  
x86_64               randconfig-x013-20230710   gcc  
x86_64               randconfig-x013-20230712   gcc  
x86_64               randconfig-x014-20230710   gcc  
x86_64               randconfig-x014-20230712   gcc  
x86_64               randconfig-x015-20230710   gcc  
x86_64               randconfig-x015-20230712   gcc  
x86_64               randconfig-x016-20230710   gcc  
x86_64               randconfig-x016-20230712   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa               randconfig-r006-20230712   gcc  
xtensa               randconfig-r016-20230712   gcc  
xtensa               randconfig-r024-20230712   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
