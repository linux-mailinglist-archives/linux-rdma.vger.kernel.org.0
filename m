Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE1172EEDF
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jun 2023 00:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjFMWIa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Jun 2023 18:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjFMWI3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Jun 2023 18:08:29 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6740610DE
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jun 2023 15:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686694108; x=1718230108;
  h=date:from:to:cc:subject:message-id;
  bh=UtiXDU3P/o4xemkn1rzRjyBrjXDQziK6tSSrIMnLzQ8=;
  b=CTqBpxMmrRCBSPYJ6Di4UFhudoTTt7n9lfAtX7ZZEchy/HgwvtxdtjiE
   1j3XYWKqw8ErZmW2oQyWWKGe0zMpkjH+1G17DPcQKTuJqn962XOOOywVk
   e6u8t/PWVemgRvD/y3aj9hFAkKrz7W3molmoKq/Vx38nZuDZ+NBfdFnyr
   E4RfDs6vItf26T010HdO5Hmbk3Du/QMjb4QwzUHN1JSkXZ8Dr5i9pV7Wi
   xERB9QAwZlVpXLXJRaIYQ5x4odf94kGT6AerkhxE8mHriPv9gOzm5JQJl
   8kl/OpcY6wQRyp8WQSLIB4coyEeu3SE5Ztxs3wzwJIR+ojvGgUztXS6mu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="422061986"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="422061986"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 15:08:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="801655120"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="801655120"
Received: from lkp-server01.sh.intel.com (HELO 211f47bdb1cb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jun 2023 15:08:25 -0700
Received: from kbuild by 211f47bdb1cb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9CBd-0001qG-0n;
        Tue, 13 Jun 2023 22:08:25 +0000
Date:   Wed, 14 Jun 2023 06:08:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 56a1f96d30dc9b4133f7aa6d8e888033623f67db
Message-ID: <202306140618.Wpq7XFl7-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 56a1f96d30dc9b4133f7aa6d8e888033623f67db  RDMA/bnxt_re: Initialize opcode while sending message

elapsed time: 726m

configs tested: 135
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r025-20230612   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230612   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r012-20230612   gcc  
arc                  randconfig-r014-20230612   gcc  
arc                  randconfig-r016-20230612   gcc  
arc                  randconfig-r043-20230612   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r015-20230612   clang
arm                  randconfig-r026-20230612   clang
arm                  randconfig-r036-20230612   gcc  
arm                  randconfig-r046-20230612   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r003-20230612   clang
arm64        buildonly-randconfig-r006-20230612   clang
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230612   gcc  
csky                 randconfig-r031-20230612   gcc  
hexagon              randconfig-r001-20230612   clang
hexagon              randconfig-r041-20230612   clang
hexagon              randconfig-r045-20230612   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230612   clang
i386                 randconfig-i002-20230612   clang
i386                 randconfig-i003-20230612   clang
i386                 randconfig-i004-20230612   clang
i386                 randconfig-i005-20230612   clang
i386                 randconfig-i006-20230612   clang
i386                 randconfig-i011-20230612   gcc  
i386                 randconfig-i012-20230612   gcc  
i386                 randconfig-i013-20230612   gcc  
i386                 randconfig-i014-20230612   gcc  
i386                 randconfig-i015-20230612   gcc  
i386                 randconfig-i016-20230612   gcc  
i386                 randconfig-r016-20230612   gcc  
i386                 randconfig-r035-20230612   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230612   gcc  
loongarch    buildonly-randconfig-r003-20230612   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r033-20230612   gcc  
m68k                 randconfig-r035-20230612   gcc  
m68k                 randconfig-r036-20230612   gcc  
microblaze           randconfig-r014-20230612   gcc  
microblaze           randconfig-r024-20230612   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r001-20230612   gcc  
mips                 randconfig-r011-20230612   clang
mips                 randconfig-r024-20230612   clang
mips                 randconfig-r031-20230612   gcc  
nios2        buildonly-randconfig-r001-20230612   gcc  
nios2        buildonly-randconfig-r005-20230612   gcc  
nios2        buildonly-randconfig-r006-20230612   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r023-20230612   gcc  
parisc                           allyesconfig   gcc  
parisc       buildonly-randconfig-r001-20230612   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230612   gcc  
parisc               randconfig-r022-20230612   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r001-20230612   gcc  
powerpc      buildonly-randconfig-r004-20230612   gcc  
powerpc      buildonly-randconfig-r005-20230612   gcc  
powerpc              randconfig-r032-20230612   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r003-20230612   clang
riscv                randconfig-r013-20230612   gcc  
riscv                randconfig-r034-20230612   clang
riscv                randconfig-r042-20230612   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r005-20230612   clang
s390                 randconfig-r015-20230612   gcc  
s390                 randconfig-r021-20230612   gcc  
s390                 randconfig-r044-20230612   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r003-20230612   gcc  
sh                   randconfig-r002-20230612   gcc  
sh                   randconfig-r004-20230612   gcc  
sh                   randconfig-r012-20230612   gcc  
sh                   randconfig-r021-20230612   gcc  
sparc                            allyesconfig   gcc  
sparc        buildonly-randconfig-r002-20230612   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r022-20230612   gcc  
sparc                randconfig-r023-20230612   gcc  
sparc                randconfig-r033-20230612   gcc  
sparc64      buildonly-randconfig-r006-20230612   gcc  
sparc64              randconfig-r013-20230612   gcc  
sparc64              randconfig-r026-20230612   gcc  
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
x86_64               randconfig-r003-20230612   clang
x86_64               randconfig-r005-20230612   clang
x86_64               randconfig-r025-20230612   gcc  
x86_64               randconfig-r034-20230612   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r006-20230612   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
