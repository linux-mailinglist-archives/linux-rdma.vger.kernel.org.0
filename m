Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467A1740B5F
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jun 2023 10:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbjF1I1H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Jun 2023 04:27:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:64637 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234066AbjF1IZF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Jun 2023 04:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687940705; x=1719476705;
  h=date:from:to:cc:subject:message-id;
  bh=BKuECJzZcHVU5MEwcqstk9VNEoJG1wo4rZzKRhj8/io=;
  b=WepXVypwsZWeF+HBbQGpLOz+LX1bFKivuWkNqWfRETMXlGEYtyprbq4z
   xc/fkSBzY0cR3vAdK48P5NQlTDkDrYnHemfGHZc/Ry43bZ8QOO723IwmD
   wbw1PBWeNjghiHNtLaxFo8gOewAOwv5Kfi4RAKeSV2g18yQPMrkYYJo7H
   XxV9gWlDqsezs6hscFFCL3/+CkRWSqFvw5aD3uX66taDUwaOSLQEKLZSC
   CqRabYWH8Zk5AVgkEN4sDrtusSMk/qmgW3QZPQblRuaF6C2NGJMDDR1Jc
   La82fnWqupmzyG0nllvTBYIrqBzYv+JNWdAc3TGicPQr/vEv7W4tB6sBJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="342099984"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="342099984"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 23:14:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="890929161"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="890929161"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 Jun 2023 23:14:12 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qEORP-000Cvj-0A;
        Wed, 28 Jun 2023 06:14:11 +0000
Date:   Wed, 28 Jun 2023 14:13:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 5f004bcaee4cb552cf1b46a505f18f08777db7e5
Message-ID: <202306281432.HeN6LXtd-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 5f004bcaee4cb552cf1b46a505f18f08777db7e5  Merge tag 'v6.4' into rdma.git for-next

elapsed time: 731m

configs tested: 133
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r012-20230627   gcc  
alpha                randconfig-r016-20230627   gcc  
alpha                randconfig-r022-20230627   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230627   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                       netwinder_defconfig   clang
arm                  randconfig-r005-20230627   clang
arm                  randconfig-r046-20230627   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r013-20230627   clang
csky                                defconfig   gcc  
hexagon              randconfig-r023-20230627   clang
hexagon              randconfig-r026-20230627   clang
hexagon              randconfig-r032-20230627   clang
hexagon              randconfig-r041-20230627   clang
hexagon              randconfig-r045-20230627   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230627   gcc  
i386         buildonly-randconfig-r005-20230627   gcc  
i386         buildonly-randconfig-r006-20230627   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230627   gcc  
i386                 randconfig-i002-20230627   gcc  
i386                 randconfig-i003-20230627   gcc  
i386                 randconfig-i004-20230627   gcc  
i386                 randconfig-i005-20230627   gcc  
i386                 randconfig-i006-20230627   gcc  
i386                 randconfig-i011-20230627   clang
i386                 randconfig-i012-20230627   clang
i386                 randconfig-i013-20230627   clang
i386                 randconfig-i014-20230627   clang
i386                 randconfig-i015-20230627   clang
i386                 randconfig-i016-20230627   clang
i386                 randconfig-r032-20230627   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r036-20230627   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r003-20230627   gcc  
m68k                 randconfig-r005-20230627   gcc  
m68k                 randconfig-r015-20230627   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                           ci20_defconfig   gcc  
mips                 randconfig-r011-20230627   gcc  
mips                 randconfig-r025-20230627   gcc  
mips                          rb532_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230627   gcc  
nios2                randconfig-r013-20230627   gcc  
nios2                randconfig-r014-20230627   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc             randconfig-r024-20230627   gcc  
openrisc             randconfig-r031-20230627   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230627   gcc  
parisc               randconfig-r026-20230627   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                    gamecube_defconfig   clang
powerpc              randconfig-r003-20230627   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230627   gcc  
riscv                randconfig-r004-20230627   gcc  
riscv                randconfig-r014-20230627   clang
riscv                randconfig-r015-20230627   clang
riscv                randconfig-r042-20230627   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r002-20230627   gcc  
s390                 randconfig-r006-20230627   gcc  
s390                 randconfig-r044-20230627   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r024-20230627   gcc  
sh                           se7705_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r033-20230627   gcc  
sparc64              randconfig-r035-20230627   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230627   gcc  
x86_64       buildonly-randconfig-r002-20230627   gcc  
x86_64       buildonly-randconfig-r003-20230627   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r025-20230627   clang
x86_64               randconfig-r031-20230627   gcc  
x86_64               randconfig-x001-20230627   clang
x86_64               randconfig-x002-20230627   clang
x86_64               randconfig-x003-20230627   clang
x86_64               randconfig-x004-20230627   clang
x86_64               randconfig-x005-20230627   clang
x86_64               randconfig-x006-20230627   clang
x86_64               randconfig-x011-20230627   gcc  
x86_64               randconfig-x012-20230627   gcc  
x86_64               randconfig-x013-20230627   gcc  
x86_64               randconfig-x014-20230627   gcc  
x86_64               randconfig-x015-20230627   gcc  
x86_64               randconfig-x016-20230627   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r022-20230627   gcc  
xtensa               randconfig-r023-20230627   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
