Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D2973F0FC
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jun 2023 04:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjF0C4B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Jun 2023 22:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjF0Cz7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Jun 2023 22:55:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9479719A3
        for <linux-rdma@vger.kernel.org>; Mon, 26 Jun 2023 19:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687834556; x=1719370556;
  h=date:from:to:cc:subject:message-id;
  bh=sB0VW1+SVyc/dDlAK0KGHsI8nxFzoafrphqeM7BDST4=;
  b=mRaJq7nZEmP/1fuUnn71fOj/QQ0OQT8FJTVnouPz8/JtObx2fcBn8HUa
   8JroXRaazSrlnj4fgEenKvknt6TRogv5VmLW0IDHOFGGkI3Fz/WcS3MR+
   VeJkmJynSsKDtM/GzYaZ2TRKwHYVSRPLEEnjAv6wVEn1imfz1oodaPqjL
   Bhgafa1uIb/VXC8sWkcGtNumYgvtZgOaW8l28PoQ+Wt6Ptx9VtMws9BWM
   W2tazESLMwdxbeHwl5dOUvDl1czjZggt9d2oRUBMPlZnQ/toYQzWmgEA8
   qA8JpbVuZcgzyEfdgkVJZ0+yQzJBYfT4P54kFLu5hL0Lg2P1c43UbuTja
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="363999910"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="363999910"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 19:55:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="716375402"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="716375402"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 26 Jun 2023 19:55:54 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qDyrx-000BfR-29;
        Tue, 27 Jun 2023 02:55:53 +0000
Date:   Tue, 27 Jun 2023 10:55:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 d1d7fc3bf6d2e6fb5d81a24dbb4120779a447b33
Message-ID: <202306271015.RqPWvxxw-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: d1d7fc3bf6d2e6fb5d81a24dbb4120779a447b33  RDMA/bnxt_re: Fix spelling mistake "priviledged" -> "privileged"

elapsed time: 721m

configs tested: 162
configs skipped: 18

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230626   gcc  
alpha                randconfig-r015-20230626   gcc  
arc                              alldefconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                  randconfig-r006-20230626   gcc  
arc                  randconfig-r012-20230626   gcc  
arc                  randconfig-r023-20230626   gcc  
arc                  randconfig-r035-20230626   gcc  
arc                  randconfig-r043-20230626   gcc  
arm                              alldefconfig   clang
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   gcc  
arm                          ep93xx_defconfig   clang
arm                  randconfig-r001-20230626   gcc  
arm                  randconfig-r003-20230626   gcc  
arm                  randconfig-r004-20230626   gcc  
arm                  randconfig-r006-20230626   gcc  
arm                  randconfig-r013-20230626   clang
arm                  randconfig-r014-20230626   clang
arm                  randconfig-r022-20230626   clang
arm                  randconfig-r032-20230626   gcc  
arm                  randconfig-r034-20230626   gcc  
arm                  randconfig-r046-20230626   clang
arm                        spear6xx_defconfig   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r012-20230626   gcc  
arm64                randconfig-r021-20230626   gcc  
arm64                randconfig-r023-20230626   gcc  
arm64                randconfig-r036-20230626   clang
csky                                defconfig   gcc  
csky                 randconfig-r011-20230626   gcc  
csky                 randconfig-r013-20230626   gcc  
hexagon              randconfig-r016-20230626   clang
hexagon              randconfig-r026-20230626   clang
hexagon              randconfig-r031-20230626   clang
hexagon              randconfig-r041-20230626   clang
hexagon              randconfig-r045-20230626   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230626   clang
i386         buildonly-randconfig-r005-20230626   clang
i386         buildonly-randconfig-r006-20230626   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230626   clang
i386                 randconfig-i002-20230626   clang
i386                 randconfig-i003-20230626   clang
i386                 randconfig-i004-20230626   clang
i386                 randconfig-i005-20230626   clang
i386                 randconfig-i006-20230626   clang
i386                 randconfig-i011-20230626   gcc  
i386                 randconfig-i012-20230626   gcc  
i386                 randconfig-i013-20230626   gcc  
i386                 randconfig-i014-20230626   gcc  
i386                 randconfig-i015-20230626   gcc  
i386                 randconfig-i016-20230626   gcc  
i386                 randconfig-r002-20230626   clang
i386                 randconfig-r016-20230626   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r013-20230626   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r024-20230626   gcc  
microblaze           randconfig-r005-20230626   gcc  
microblaze           randconfig-r011-20230626   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                            ar7_defconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                 randconfig-r001-20230626   gcc  
mips                 randconfig-r033-20230626   gcc  
mips                 randconfig-r034-20230626   gcc  
mips                 randconfig-r035-20230626   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230626   gcc  
nios2                randconfig-r012-20230626   gcc  
nios2                randconfig-r014-20230626   gcc  
nios2                randconfig-r022-20230626   gcc  
nios2                randconfig-r033-20230626   gcc  
openrisc             randconfig-r011-20230626   gcc  
openrisc             randconfig-r014-20230626   gcc  
openrisc             randconfig-r015-20230626   gcc  
openrisc             randconfig-r025-20230626   gcc  
openrisc             randconfig-r026-20230626   gcc  
openrisc             randconfig-r036-20230626   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230626   gcc  
parisc               randconfig-r026-20230626   gcc  
parisc               randconfig-r031-20230626   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc               mpc834x_itxgp_defconfig   clang
powerpc                 mpc8540_ads_defconfig   gcc  
powerpc              randconfig-r021-20230626   gcc  
powerpc                     tqm8540_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230626   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r011-20230626   gcc  
s390                 randconfig-r031-20230626   clang
s390                 randconfig-r044-20230626   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r002-20230626   gcc  
sh                   randconfig-r004-20230626   gcc  
sh                   randconfig-r005-20230626   gcc  
sh                   randconfig-r006-20230626   gcc  
sh                   randconfig-r012-20230626   gcc  
sh                   randconfig-r014-20230626   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230626   gcc  
sparc64              randconfig-r013-20230626   gcc  
sparc64              randconfig-r016-20230626   gcc  
sparc64              randconfig-r025-20230626   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r002-20230626   gcc  
um                   randconfig-r024-20230626   clang
um                   randconfig-r032-20230626   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230626   clang
x86_64       buildonly-randconfig-r002-20230626   clang
x86_64       buildonly-randconfig-r003-20230626   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r022-20230626   gcc  
x86_64               randconfig-r036-20230626   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                       common_defconfig   gcc  
xtensa                              defconfig   gcc  
xtensa               randconfig-r016-20230626   gcc  
xtensa               randconfig-r034-20230626   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
