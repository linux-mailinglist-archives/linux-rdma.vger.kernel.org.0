Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507DA759F1C
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jul 2023 21:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjGST5S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jul 2023 15:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjGST5S (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jul 2023 15:57:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF641FD6
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jul 2023 12:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689796636; x=1721332636;
  h=date:from:to:cc:subject:message-id;
  bh=4iz0sM5hPPful/BjVRkWmtekydnsvd9/2IM0r0IRZ38=;
  b=WYh8sGyWeDba/Z2uLEVm38Qawvmmhaf+PKJBOw3By63F1u/iUYWOSZ2r
   0jwQLuIynQIgsbxZPYPKcXyb9JfYSH7VaqrFI9NzfJbwYgKmkf/ovRycQ
   QqbJlCL5LQB7uHTplNIgf5UC9BVtFbnudO4GU7Ptgxxs9JnZeymoUdu9v
   cW6+sANQBqb6WG3Ush3U9/QrrmzANALpCDeFJQnEcHH+swTx/txeYSywY
   2Ye4VttXU7DU0/K2iSznIW2gWFD8B+SJBR24DVktdxobfwRKYm7KB5pMX
   1oM53sryZZOHc31EbpW294EF36OUA9mOM4mYeSGuikll6E7skFwuqyMj5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="346861898"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="346861898"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 12:57:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="814248177"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="814248177"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jul 2023 12:57:14 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMDIN-0005R9-2E;
        Wed, 19 Jul 2023 19:57:12 +0000
Date:   Thu, 20 Jul 2023 03:56:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 b3d2b014b259ba758d72d7026685091bde1cf2d6
Message-ID: <202307200326.imluTH0L-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: b3d2b014b259ba758d72d7026685091bde1cf2d6  RDMA/irdma: Fix building without IPv6

elapsed time: 727m

configs tested: 174
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r021-20230718   gcc  
alpha                randconfig-r022-20230718   gcc  
alpha                randconfig-r023-20230718   gcc  
alpha                randconfig-r036-20230718   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r031-20230718   gcc  
arc                  randconfig-r043-20230718   gcc  
arc                  randconfig-r043-20230719   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   clang
arm                                 defconfig   gcc  
arm                            mps2_defconfig   gcc  
arm                           omap1_defconfig   clang
arm                  randconfig-r001-20230718   clang
arm                  randconfig-r003-20230718   clang
arm                  randconfig-r026-20230718   gcc  
arm                  randconfig-r032-20230718   clang
arm                  randconfig-r046-20230718   gcc  
arm                  randconfig-r046-20230719   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230718   gcc  
arm64                randconfig-r011-20230718   clang
arm64                randconfig-r012-20230718   clang
arm64                randconfig-r034-20230718   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r016-20230718   gcc  
csky                 randconfig-r026-20230718   gcc  
csky                 randconfig-r034-20230718   gcc  
csky                 randconfig-r035-20230718   gcc  
hexagon              randconfig-r041-20230718   clang
hexagon              randconfig-r041-20230719   clang
hexagon              randconfig-r045-20230718   clang
hexagon              randconfig-r045-20230719   clang
i386                             allyesconfig   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230718   gcc  
i386         buildonly-randconfig-r005-20230718   gcc  
i386         buildonly-randconfig-r006-20230718   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230718   gcc  
i386                 randconfig-i002-20230718   gcc  
i386                 randconfig-i003-20230718   gcc  
i386                 randconfig-i004-20230718   gcc  
i386                 randconfig-i005-20230718   gcc  
i386                 randconfig-i006-20230718   gcc  
i386                 randconfig-i011-20230718   clang
i386                 randconfig-i012-20230718   clang
i386                 randconfig-i013-20230718   clang
i386                 randconfig-i014-20230718   clang
i386                 randconfig-i015-20230718   clang
i386                 randconfig-i016-20230718   clang
i386                 randconfig-r001-20230718   gcc  
i386                 randconfig-r004-20230718   gcc  
i386                 randconfig-r015-20230718   clang
i386                 randconfig-r035-20230718   gcc  
i386                 randconfig-r036-20230718   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r016-20230718   gcc  
loongarch            randconfig-r022-20230718   gcc  
loongarch            randconfig-r031-20230718   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r004-20230718   gcc  
m68k                 randconfig-r006-20230718   gcc  
m68k                 randconfig-r026-20230718   gcc  
m68k                 randconfig-r032-20230718   gcc  
microblaze           randconfig-r012-20230718   gcc  
microblaze           randconfig-r016-20230718   gcc  
microblaze           randconfig-r033-20230718   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        qi_lb60_defconfig   clang
mips                 randconfig-r005-20230718   clang
mips                       rbtx49xx_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230718   gcc  
nios2                randconfig-r005-20230718   gcc  
nios2                randconfig-r013-20230718   gcc  
nios2                randconfig-r015-20230718   gcc  
nios2                randconfig-r031-20230718   gcc  
openrisc             randconfig-r014-20230718   gcc  
openrisc             randconfig-r021-20230718   gcc  
openrisc             randconfig-r031-20230718   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r021-20230718   gcc  
parisc               randconfig-r025-20230718   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      arches_defconfig   gcc  
powerpc              randconfig-r014-20230718   clang
powerpc              randconfig-r015-20230718   clang
powerpc              randconfig-r022-20230718   clang
powerpc              randconfig-r036-20230718   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r003-20230718   gcc  
riscv                randconfig-r006-20230718   gcc  
riscv                randconfig-r035-20230718   gcc  
riscv                randconfig-r042-20230718   clang
riscv                randconfig-r042-20230719   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r005-20230718   gcc  
s390                 randconfig-r044-20230718   clang
s390                 randconfig-r044-20230719   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r011-20230718   gcc  
sh                   randconfig-r024-20230718   gcc  
sh                   randconfig-r033-20230718   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230718   gcc  
sparc                randconfig-r004-20230718   gcc  
sparc                randconfig-r012-20230718   gcc  
sparc                randconfig-r021-20230718   gcc  
sparc                randconfig-r024-20230718   gcc  
sparc                randconfig-r025-20230718   gcc  
sparc64              randconfig-r011-20230718   gcc  
sparc64              randconfig-r023-20230718   gcc  
sparc64              randconfig-r024-20230718   gcc  
sparc64              randconfig-r025-20230718   gcc  
sparc64              randconfig-r033-20230718   gcc  
sparc64              randconfig-r034-20230718   gcc  
sparc64              randconfig-r036-20230718   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r025-20230718   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230718   gcc  
x86_64       buildonly-randconfig-r002-20230718   gcc  
x86_64       buildonly-randconfig-r003-20230718   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r012-20230718   clang
x86_64               randconfig-r014-20230718   clang
x86_64               randconfig-r023-20230718   clang
x86_64               randconfig-r032-20230718   gcc  
x86_64               randconfig-x001-20230718   clang
x86_64               randconfig-x002-20230718   clang
x86_64               randconfig-x003-20230718   clang
x86_64               randconfig-x004-20230718   clang
x86_64               randconfig-x005-20230718   clang
x86_64               randconfig-x006-20230718   clang
x86_64               randconfig-x011-20230718   gcc  
x86_64               randconfig-x012-20230718   gcc  
x86_64               randconfig-x013-20230718   gcc  
x86_64               randconfig-x014-20230718   gcc  
x86_64               randconfig-x015-20230718   gcc  
x86_64               randconfig-x016-20230718   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r006-20230718   gcc  
xtensa               randconfig-r011-20230718   gcc  
xtensa               randconfig-r024-20230718   gcc  
xtensa               randconfig-r034-20230718   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
