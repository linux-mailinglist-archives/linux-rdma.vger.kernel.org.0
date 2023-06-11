Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FAF72B49F
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 00:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjFKWhW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Jun 2023 18:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjFKWhU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 11 Jun 2023 18:37:20 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7A5B3
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jun 2023 15:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686523039; x=1718059039;
  h=date:from:to:cc:subject:message-id;
  bh=5YRk/56DCl7AocPFxLxVWfph4HiFjwbnXPFCo/rkPd4=;
  b=X93cl57n0DKQoRw5++aBd7f52pKW/hDrNO26mJU7FseZ6iqlL7RR73Ze
   x0vUfh4+uAL06+xO9vh2yIQiwTKyryBzxJG1cIYX6HQvt6hMTgjl14tAD
   /ksatqQJbTaEPhmsNuhGjn+iMXFV8XDx9eoCeOB+TOazaslmrB3i1WMco
   KIP7QPGyBAw5PNkviOoYMaygBUMJsrDLAjN5kQ7S97WgqS0U3nuN9+afg
   6ivo8CP8LBGxxvUJgXaB0cBng/Eg4C4hJ4OgxY0vngP6Ryvyj9fsdR2q5
   +R3DNCjBR3AzgDt+azZVAQvaXHcng6V/a+kKBnis34gTUeKOqGJf9uK7K
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="361270443"
X-IronPort-AV: E=Sophos;i="6.00,235,1681196400"; 
   d="scan'208";a="361270443"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 15:37:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="714182538"
X-IronPort-AV: E=Sophos;i="6.00,235,1681196400"; 
   d="scan'208";a="714182538"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 11 Jun 2023 15:37:17 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q8TgT-000B8X-0J;
        Sun, 11 Jun 2023 22:37:17 +0000
Date:   Mon, 12 Jun 2023 06:36:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 3b3dfd58bace12e8348e5863e05867afd2ead28b
Message-ID: <202306120641.ac9XqDzC-lkp@intel.com>
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
branch HEAD: 3b3dfd58bace12e8348e5863e05867afd2ead28b  RDMA/erdma: Refactor the original doorbell allocation mechanism

elapsed time: 726m

configs tested: 152
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230611   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                  randconfig-r043-20230611   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                            mmp2_defconfig   clang
arm                  randconfig-r025-20230611   gcc  
arm                  randconfig-r033-20230611   clang
arm                  randconfig-r046-20230611   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r004-20230611   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r005-20230611   gcc  
csky         buildonly-randconfig-r001-20230611   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230611   gcc  
csky                 randconfig-r004-20230611   gcc  
hexagon      buildonly-randconfig-r002-20230611   clang
hexagon                             defconfig   clang
hexagon              randconfig-r001-20230611   clang
hexagon              randconfig-r005-20230611   clang
hexagon              randconfig-r041-20230611   clang
hexagon              randconfig-r045-20230611   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r005-20230611   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230611   gcc  
i386                 randconfig-i002-20230611   gcc  
i386                 randconfig-i003-20230611   gcc  
i386                 randconfig-i004-20230611   gcc  
i386                 randconfig-i005-20230611   gcc  
i386                 randconfig-i006-20230611   gcc  
i386                 randconfig-i011-20230611   clang
i386                 randconfig-i012-20230611   clang
i386                 randconfig-i013-20230611   clang
i386                 randconfig-i014-20230611   clang
i386                 randconfig-i015-20230611   clang
i386                 randconfig-i016-20230611   clang
i386                 randconfig-r006-20230611   gcc  
i386                 randconfig-r023-20230611   clang
i386                 randconfig-r032-20230611   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r024-20230611   gcc  
loongarch            randconfig-r025-20230611   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k         buildonly-randconfig-r006-20230611   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                            q40_defconfig   gcc  
m68k                 randconfig-r003-20230611   gcc  
m68k                 randconfig-r013-20230611   gcc  
m68k                 randconfig-r022-20230611   gcc  
microblaze           randconfig-r002-20230611   gcc  
microblaze           randconfig-r015-20230611   gcc  
microblaze           randconfig-r021-20230611   gcc  
microblaze           randconfig-r023-20230611   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm63xx_defconfig   clang
mips                         cobalt_defconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                       lemote2f_defconfig   clang
mips                      maltasmvp_defconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
nios2                            allyesconfig   gcc  
nios2        buildonly-randconfig-r003-20230611   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230611   gcc  
nios2                randconfig-r014-20230611   gcc  
nios2                randconfig-r035-20230611   gcc  
openrisc                  or1klitex_defconfig   gcc  
openrisc             randconfig-r006-20230611   gcc  
openrisc             randconfig-r031-20230611   gcc  
openrisc             randconfig-r034-20230611   gcc  
parisc                           allyesconfig   gcc  
parisc       buildonly-randconfig-r001-20230611   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     asp8347_defconfig   gcc  
powerpc                 canyonlands_defconfig   gcc  
powerpc                        fsp2_defconfig   clang
powerpc                  iss476-smp_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc              randconfig-r016-20230611   clang
powerpc              randconfig-r032-20230611   gcc  
powerpc                     tqm8555_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv        buildonly-randconfig-r004-20230611   clang
riscv                               defconfig   gcc  
riscv                randconfig-r022-20230611   clang
riscv                randconfig-r035-20230611   gcc  
riscv                randconfig-r042-20230611   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230611   clang
sh                               allmodconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                   randconfig-r021-20230611   gcc  
sh                           se7712_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230611   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64      buildonly-randconfig-r006-20230611   gcc  
sparc64              randconfig-r031-20230611   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230611   gcc  
x86_64               randconfig-a002-20230611   gcc  
x86_64               randconfig-a003-20230611   gcc  
x86_64               randconfig-a004-20230611   gcc  
x86_64               randconfig-a005-20230611   gcc  
x86_64               randconfig-a006-20230611   gcc  
x86_64               randconfig-a011-20230611   clang
x86_64               randconfig-a012-20230611   clang
x86_64               randconfig-a013-20230611   clang
x86_64               randconfig-a014-20230611   clang
x86_64               randconfig-a015-20230611   clang
x86_64               randconfig-a016-20230611   clang
x86_64               randconfig-r036-20230611   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r003-20230611   gcc  
xtensa                       common_defconfig   gcc  
xtensa               randconfig-r024-20230611   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
