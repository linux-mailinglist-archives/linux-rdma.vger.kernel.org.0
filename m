Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A847689FB
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 04:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjGaC0p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 30 Jul 2023 22:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGaC0p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 30 Jul 2023 22:26:45 -0400
Received: from mgamail.intel.com (unknown [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012E419C
        for <linux-rdma@vger.kernel.org>; Sun, 30 Jul 2023 19:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690770403; x=1722306403;
  h=date:from:to:cc:subject:message-id;
  bh=jrPr5/sv4BJ5CqnQDPwxUq7pPetwHllr9UoqbKRfJL0=;
  b=QOmnDIjOcllxXvL/SqZUP2wXBWL/B+N0d0DwSR+0b9ktvGCGNA65ITtk
   k+o0g7Q5W9poJeZwFRRVXG9Psy+dmFqek0EJHuLGIJLtYRdXcgElbptqZ
   vLVZApGZtAaDFKMvyWnJc0mg60Drb94U6YQkm7qAwlGe3Xn68Gb7yvJIR
   2J1l4IO4GFBVdbE5PlKqrHX+X7zueYQijZHfzYZuw239EY8hvDVfHINcq
   acebnocIja7Ayiy7W3OjN+EaGsOmvPuPG2SaBlCzsDQ81TY0gXJydNHsf
   G54kM8BTHpIfaOnh+KYerWv2MgL610qlIGe6L1HL3WK1/im4F4AF4QJhV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="353815868"
X-IronPort-AV: E=Sophos;i="6.01,243,1684825200"; 
   d="scan'208";a="353815868"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2023 19:26:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="763190711"
X-IronPort-AV: E=Sophos;i="6.01,243,1684825200"; 
   d="scan'208";a="763190711"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 30 Jul 2023 19:26:41 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qQIcL-0004sw-0K;
        Mon, 31 Jul 2023 02:26:41 +0000
Date:   Mon, 31 Jul 2023 10:26:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 5a752f23f43a670c62ff19bd6bc68281bf01e8ab
Message-ID: <202307311003.7uebUwm0-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 5a752f23f43a670c62ff19bd6bc68281bf01e8ab  RDMA/siw: Fix tx thread initialization.

elapsed time: 725m

configs tested: 127
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230730   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r016-20230730   clang
arm                  randconfig-r034-20230730   gcc  
arm                  randconfig-r046-20230730   clang
arm                        realview_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r024-20230730   gcc  
hexagon              randconfig-r001-20230730   clang
hexagon              randconfig-r011-20230730   clang
hexagon              randconfig-r041-20230730   clang
hexagon              randconfig-r045-20230730   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230730   clang
i386         buildonly-randconfig-r005-20230730   clang
i386         buildonly-randconfig-r006-20230730   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230730   clang
i386                 randconfig-i002-20230730   clang
i386                 randconfig-i003-20230730   clang
i386                 randconfig-i004-20230730   clang
i386                 randconfig-i005-20230730   clang
i386                 randconfig-i006-20230730   clang
i386                 randconfig-i011-20230730   gcc  
i386                 randconfig-i012-20230730   gcc  
i386                 randconfig-i013-20230730   gcc  
i386                 randconfig-i014-20230730   gcc  
i386                 randconfig-i015-20230730   gcc  
i386                 randconfig-i016-20230730   gcc  
i386                 randconfig-r024-20230730   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r035-20230730   gcc  
microblaze           randconfig-r004-20230730   gcc  
microblaze           randconfig-r014-20230730   gcc  
microblaze           randconfig-r036-20230730   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                 randconfig-r015-20230730   clang
mips                 randconfig-r025-20230730   clang
mips                 randconfig-r033-20230730   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r015-20230730   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r022-20230730   gcc  
parisc               randconfig-r026-20230730   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r001-20230730   clang
powerpc              randconfig-r006-20230730   clang
powerpc              randconfig-r012-20230730   gcc  
powerpc              randconfig-r013-20230730   gcc  
powerpc              randconfig-r022-20230730   gcc  
powerpc              randconfig-r031-20230730   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r035-20230730   clang
riscv                randconfig-r042-20230730   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r016-20230730   gcc  
s390                 randconfig-r031-20230730   clang
s390                 randconfig-r044-20230730   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r002-20230730   gcc  
sh                   randconfig-r012-20230730   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230730   gcc  
sparc                randconfig-r005-20230730   gcc  
sparc                randconfig-r014-20230730   gcc  
sparc                randconfig-r021-20230730   gcc  
sparc                randconfig-r026-20230730   gcc  
sparc64              randconfig-r005-20230730   gcc  
sparc64              randconfig-r011-20230730   gcc  
sparc64              randconfig-r023-20230730   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230730   clang
x86_64       buildonly-randconfig-r002-20230730   clang
x86_64       buildonly-randconfig-r003-20230730   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r023-20230730   gcc  
x86_64               randconfig-r034-20230730   clang
x86_64               randconfig-x001-20230730   gcc  
x86_64               randconfig-x002-20230730   gcc  
x86_64               randconfig-x003-20230730   gcc  
x86_64               randconfig-x004-20230730   gcc  
x86_64               randconfig-x005-20230730   gcc  
x86_64               randconfig-x006-20230730   gcc  
x86_64               randconfig-x011-20230730   clang
x86_64               randconfig-x012-20230730   clang
x86_64               randconfig-x013-20230730   clang
x86_64               randconfig-x014-20230730   clang
x86_64               randconfig-x015-20230730   clang
x86_64               randconfig-x016-20230730   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r003-20230730   gcc  
xtensa               randconfig-r004-20230730   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
