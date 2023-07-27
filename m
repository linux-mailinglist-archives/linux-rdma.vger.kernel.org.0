Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38CC76430F
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 02:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjG0Akp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Jul 2023 20:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjG0Ako (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Jul 2023 20:40:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F852688
        for <linux-rdma@vger.kernel.org>; Wed, 26 Jul 2023 17:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690418438; x=1721954438;
  h=date:from:to:cc:subject:message-id;
  bh=8RdQWxoXsRCjsmHDqD/8Fg8tNFFpoXWPKk6gsQvJ5p4=;
  b=nENvx31XvGCY+9peJFN4gX+CCK0QTuq2pNnzt9yeDDLiEu3psfphaKJf
   4Es1J+eF+VpPgsOkSauHnIjpSUTF8hIJcyo9d32S9B+IPdZ2Z68jcXK3D
   6YJO//VY3a3h0gLh2ee72QhLjVrW15oUcz+Mj1L5Ee1yGdvS0mK/2S3+C
   1I/+F6IaZX/fed+YZG9DBUFH46IF/jeSsAow08+QMpPNGolF/rmYwIiti
   yPXHffEkb2XyjbdxY0GY143JjESWTFar9kQQCSTFmc510Cm05EEZy4rF6
   9wJFe8RhrNLC8vZdIgHABrDQZI0bdQ8k67Tp05ydXtqq9VhTkb+LEqDBV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="365629092"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="365629092"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 17:40:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="726732432"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="726732432"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 26 Jul 2023 17:40:36 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOp3T-0001U1-12;
        Thu, 27 Jul 2023 00:40:35 +0000
Date:   Thu, 27 Jul 2023 08:39:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 ae463563b7a1b7d4a3d0b065b09d37a76b693937
Message-ID: <202307270848.5AdFnlIk-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: ae463563b7a1b7d4a3d0b065b09d37a76b693937  RDMA/irdma: Report correct WC error

elapsed time: 723m

configs tested: 148
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230726   gcc  
alpha                randconfig-r013-20230726   gcc  
alpha                randconfig-r032-20230726   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230726   gcc  
arc                  randconfig-r012-20230726   gcc  
arc                  randconfig-r043-20230726   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r025-20230726   gcc  
arm                  randconfig-r032-20230726   clang
arm                  randconfig-r046-20230726   gcc  
arm                         s5pv210_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r011-20230726   clang
arm64                randconfig-r026-20230726   clang
csky                                defconfig   gcc  
csky                 randconfig-r016-20230726   gcc  
hexagon              randconfig-r036-20230726   clang
hexagon              randconfig-r041-20230726   clang
hexagon              randconfig-r045-20230726   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230726   gcc  
i386         buildonly-randconfig-r005-20230726   gcc  
i386         buildonly-randconfig-r006-20230726   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230726   gcc  
i386                 randconfig-i002-20230726   gcc  
i386                 randconfig-i003-20230726   gcc  
i386                 randconfig-i004-20230726   gcc  
i386                 randconfig-i005-20230726   gcc  
i386                 randconfig-i006-20230726   gcc  
i386                 randconfig-i011-20230726   clang
i386                 randconfig-i012-20230726   clang
i386                 randconfig-i013-20230726   clang
i386                 randconfig-i014-20230726   clang
i386                 randconfig-i015-20230726   clang
i386                 randconfig-i016-20230726   clang
i386                 randconfig-r006-20230726   gcc  
i386                 randconfig-r034-20230726   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r016-20230726   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                 randconfig-r002-20230726   gcc  
m68k                 randconfig-r024-20230726   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                       lemote2f_defconfig   clang
mips                     loongson2k_defconfig   clang
mips                malta_qemu_32r6_defconfig   clang
mips                 randconfig-r032-20230726   clang
mips                 randconfig-r035-20230726   clang
mips                          rb532_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r014-20230726   gcc  
nios2                randconfig-r015-20230726   gcc  
nios2                randconfig-r025-20230726   gcc  
nios2                randconfig-r033-20230726   gcc  
nios2                randconfig-r034-20230726   gcc  
openrisc             randconfig-r005-20230726   gcc  
openrisc             randconfig-r022-20230726   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230726   gcc  
parisc               randconfig-r006-20230726   gcc  
parisc               randconfig-r011-20230726   gcc  
parisc               randconfig-r014-20230726   gcc  
parisc               randconfig-r022-20230726   gcc  
parisc               randconfig-r035-20230726   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                       ebony_defconfig   clang
powerpc                    ge_imp3a_defconfig   clang
powerpc                     ppa8548_defconfig   clang
powerpc              randconfig-r005-20230726   gcc  
powerpc              randconfig-r013-20230726   clang
powerpc              randconfig-r025-20230726   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r015-20230726   clang
riscv                randconfig-r022-20230726   clang
riscv                randconfig-r024-20230726   clang
riscv                randconfig-r025-20230726   clang
riscv                randconfig-r036-20230726   gcc  
riscv                randconfig-r042-20230726   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230726   gcc  
s390                 randconfig-r044-20230726   clang
sh                               allmodconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                   randconfig-r001-20230726   gcc  
sh                   randconfig-r003-20230726   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r026-20230726   gcc  
sparc                randconfig-r033-20230726   gcc  
sparc64              randconfig-r004-20230726   gcc  
sparc64              randconfig-r013-20230726   gcc  
sparc64              randconfig-r023-20230726   gcc  
sparc64              randconfig-r031-20230726   gcc  
sparc64              randconfig-r036-20230726   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230726   gcc  
x86_64       buildonly-randconfig-r002-20230726   gcc  
x86_64       buildonly-randconfig-r003-20230726   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230726   clang
x86_64               randconfig-x002-20230726   clang
x86_64               randconfig-x003-20230726   clang
x86_64               randconfig-x004-20230726   clang
x86_64               randconfig-x005-20230726   clang
x86_64               randconfig-x006-20230726   clang
x86_64               randconfig-x011-20230726   gcc  
x86_64               randconfig-x012-20230726   gcc  
x86_64               randconfig-x013-20230726   gcc  
x86_64               randconfig-x014-20230726   gcc  
x86_64               randconfig-x015-20230726   gcc  
x86_64               randconfig-x016-20230726   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r015-20230726   gcc  
xtensa               randconfig-r021-20230726   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
