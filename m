Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AF472D076
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 22:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbjFLUbL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 16:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjFLUbK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 16:31:10 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F031191
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 13:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686601869; x=1718137869;
  h=date:from:to:cc:subject:message-id;
  bh=6KRa6RAXlY2SnG3Y0gqJAW4qWJv9/EsghR1kkADcIww=;
  b=Xftxpmrlxtar5559PxINJ6uuVT48ZEIfvXCW4cdsJNnLcs0DoZ7deIQR
   u7g6YbbJv8Ith1TimfHVxUP2eFRTaRCjim9KmvifxeBiiaYm+5uQwdDam
   NWlaDHiamUyeNKTuZeeZiECGcAV7x7Kq+aYZSlMxC3rKRWmLr3yNoEp9F
   dj+q0dK14hKhfIEgiz7S4MXCCI/GPTovMJpGP/DVjdvvq8dMKv2LwNvaM
   A2UQeIXwnAHWE6voZQAxiAV/HH4ke/rrsE3F0enKzzamExgRmbOx1ZAn3
   y0q7wUGBNH/Vzi0oiu3VHBu/ntlPpytrPy3keQuJ0pcpD+RvIaaoNqcAQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="421744630"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="421744630"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 13:31:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="781370041"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="781370041"
Received: from lkp-server01.sh.intel.com (HELO 211f47bdb1cb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jun 2023 13:31:06 -0700
Received: from kbuild by 211f47bdb1cb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q8oBt-0000gE-2C;
        Mon, 12 Jun 2023 20:31:05 +0000
Date:   Tue, 13 Jun 2023 04:30:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 830f93f47068b1632cc127871fbf27e918efdf46
Message-ID: <202306130436.wVEmL9te-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 830f93f47068b1632cc127871fbf27e918efdf46  RDMA/bnxt_re: optimize the parameters passed to helper functions

elapsed time: 731m

configs tested: 141
configs skipped: 15

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230612   gcc  
alpha                randconfig-r011-20230612   gcc  
alpha                randconfig-r015-20230612   gcc  
alpha                randconfig-r022-20230612   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r006-20230612   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230612   gcc  
arc                  randconfig-r025-20230612   gcc  
arc                  randconfig-r033-20230612   gcc  
arc                  randconfig-r043-20230612   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r011-20230612   clang
arm                  randconfig-r012-20230612   clang
arm                  randconfig-r016-20230612   clang
arm                  randconfig-r046-20230612   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230612   clang
arm64                               defconfig   gcc  
arm64                randconfig-r034-20230612   clang
csky                                defconfig   gcc  
csky                 randconfig-r005-20230612   gcc  
csky                 randconfig-r032-20230612   gcc  
csky                 randconfig-r035-20230612   gcc  
csky                 randconfig-r036-20230612   gcc  
hexagon              randconfig-r003-20230612   clang
hexagon              randconfig-r016-20230612   clang
hexagon              randconfig-r041-20230612   clang
hexagon              randconfig-r045-20230612   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r006-20230612   clang
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
i386                 randconfig-r035-20230612   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230612   gcc  
loongarch            randconfig-r005-20230612   gcc  
loongarch            randconfig-r016-20230612   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k         buildonly-randconfig-r004-20230612   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r012-20230612   gcc  
m68k                 randconfig-r023-20230612   gcc  
microblaze   buildonly-randconfig-r002-20230612   gcc  
microblaze           randconfig-r003-20230612   gcc  
microblaze           randconfig-r013-20230612   gcc  
microblaze           randconfig-r031-20230612   gcc  
microblaze           randconfig-r033-20230612   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r021-20230612   clang
mips                 randconfig-r031-20230612   gcc  
mips                 randconfig-r034-20230612   gcc  
nios2        buildonly-randconfig-r004-20230612   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230612   gcc  
nios2                randconfig-r022-20230612   gcc  
openrisc             randconfig-r004-20230612   gcc  
openrisc             randconfig-r024-20230612   gcc  
openrisc             randconfig-r036-20230612   gcc  
parisc                           allyesconfig   gcc  
parisc       buildonly-randconfig-r001-20230612   gcc  
parisc       buildonly-randconfig-r003-20230612   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230612   gcc  
parisc               randconfig-r034-20230612   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r002-20230612   gcc  
powerpc              randconfig-r015-20230612   gcc  
powerpc              randconfig-r031-20230612   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv        buildonly-randconfig-r005-20230612   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r011-20230612   gcc  
riscv                randconfig-r042-20230612   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230612   clang
s390                 randconfig-r003-20230612   clang
s390                 randconfig-r005-20230612   clang
s390                 randconfig-r013-20230612   gcc  
s390                 randconfig-r025-20230612   gcc  
s390                 randconfig-r026-20230612   gcc  
s390                 randconfig-r044-20230612   gcc  
sh                               allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r036-20230612   gcc  
sparc64              randconfig-r006-20230612   gcc  
sparc64              randconfig-r013-20230612   gcc  
sparc64              randconfig-r014-20230612   gcc  
sparc64              randconfig-r021-20230612   gcc  
sparc64              randconfig-r032-20230612   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230613   gcc  
x86_64               randconfig-a002-20230613   gcc  
x86_64               randconfig-a003-20230613   gcc  
x86_64               randconfig-a004-20230613   gcc  
x86_64               randconfig-a005-20230613   gcc  
x86_64               randconfig-a006-20230613   gcc  
x86_64               randconfig-a011-20230612   gcc  
x86_64               randconfig-a012-20230612   gcc  
x86_64               randconfig-a013-20230612   gcc  
x86_64               randconfig-a014-20230612   gcc  
x86_64               randconfig-a015-20230612   gcc  
x86_64               randconfig-a016-20230612   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r002-20230612   gcc  
xtensa               randconfig-r013-20230612   gcc  
xtensa               randconfig-r014-20230612   gcc  
xtensa               randconfig-r033-20230612   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
