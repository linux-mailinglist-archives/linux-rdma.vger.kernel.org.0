Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724DC73F08E
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jun 2023 03:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjF0BbN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Jun 2023 21:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjF0Bax (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Jun 2023 21:30:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F1B1991
        for <linux-rdma@vger.kernel.org>; Mon, 26 Jun 2023 18:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687829451; x=1719365451;
  h=date:from:to:cc:subject:message-id;
  bh=D/vPsh2id2LxF3KIscTyLIrTTF6JpA2ae8K2iEMgFF8=;
  b=EbUfg7nriZMXUqgM5uoCcLXciexD0y0+XUr0IYcAaH31aweAo8XX0vNX
   q6MULTrjPA0nOr02vhtxbXHgn2hralG6Xm91MwzDkWRPE0mqjDjUTO13X
   TOGy+7CjBnBF3z17AAIqAYpByOZOEM3BIYmrFbaEjfZaOcXdYVldm5Cps
   TYjz57k6MOkqSmiBXLPZVKcdniSM2/jZNpBGtcGLU2gdH3ZxhCTkw/Y5m
   tPVoLYen/R8h2CytEq5yGTJlkUYtRPxHrUR7GbD9GgibMpjbQ1K8AABBc
   6s1oe+g/3JttlEAD8aWbl7rxvPe3e5yTCeXbd/tQpfw2SJ4nmw8BnXkMi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="364890159"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="364890159"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 18:30:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="716355107"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="716355107"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 26 Jun 2023 18:30:47 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qDxXa-000BZX-2c;
        Tue, 27 Jun 2023 01:30:46 +0000
Date:   Tue, 27 Jun 2023 09:29:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 360da60d6c6edb9740de7a8e6d8969d62ceff956
Message-ID: <202306270947.lagFvY0x-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 360da60d6c6edb9740de7a8e6d8969d62ceff956  RDMA/bnxt_re: Enable low latency push

elapsed time: 7676m

configs tested: 237
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r016-20230622   gcc  
alpha                randconfig-r022-20230622   gcc  
alpha                randconfig-r024-20230621   gcc  
alpha                randconfig-r026-20230622   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230621   gcc  
arc                  randconfig-r006-20230622   gcc  
arc                  randconfig-r016-20230622   gcc  
arc                  randconfig-r024-20230622   gcc  
arc                  randconfig-r043-20230621   gcc  
arc                  randconfig-r043-20230622   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                          collie_defconfig   clang
arm                                 defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                  randconfig-r004-20230622   gcc  
arm                  randconfig-r005-20230621   clang
arm                  randconfig-r006-20230622   gcc  
arm                  randconfig-r016-20230621   gcc  
arm                  randconfig-r024-20230621   gcc  
arm                  randconfig-r035-20230621   clang
arm                  randconfig-r035-20230622   gcc  
arm                  randconfig-r046-20230621   gcc  
arm                  randconfig-r046-20230622   clang
arm                           spitz_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230621   gcc  
arm64                randconfig-r005-20230622   clang
arm64                randconfig-r013-20230622   gcc  
arm64                randconfig-r021-20230621   clang
arm64                randconfig-r021-20230622   gcc  
arm64                randconfig-r032-20230622   clang
csky                                defconfig   gcc  
csky                 randconfig-r001-20230621   gcc  
csky                 randconfig-r004-20230621   gcc  
csky                 randconfig-r014-20230621   gcc  
csky                 randconfig-r023-20230621   gcc  
csky                 randconfig-r025-20230622   gcc  
csky                 randconfig-r032-20230622   gcc  
csky                 randconfig-r036-20230622   gcc  
hexagon                             defconfig   clang
hexagon              randconfig-r003-20230622   clang
hexagon              randconfig-r005-20230622   clang
hexagon              randconfig-r013-20230622   clang
hexagon              randconfig-r014-20230622   clang
hexagon              randconfig-r023-20230621   clang
hexagon              randconfig-r041-20230621   clang
hexagon              randconfig-r041-20230622   clang
hexagon              randconfig-r045-20230621   clang
hexagon              randconfig-r045-20230622   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230621   gcc  
i386         buildonly-randconfig-r005-20230621   gcc  
i386         buildonly-randconfig-r006-20230621   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230621   gcc  
i386                 randconfig-i002-20230621   gcc  
i386                 randconfig-i003-20230621   gcc  
i386                 randconfig-i004-20230621   gcc  
i386                 randconfig-i005-20230621   gcc  
i386                 randconfig-i006-20230621   gcc  
i386                 randconfig-i011-20230621   clang
i386                 randconfig-i011-20230623   clang
i386                 randconfig-i012-20230621   clang
i386                 randconfig-i012-20230623   clang
i386                 randconfig-i013-20230621   clang
i386                 randconfig-i013-20230623   clang
i386                 randconfig-i014-20230621   clang
i386                 randconfig-i014-20230623   clang
i386                 randconfig-i015-20230621   clang
i386                 randconfig-i015-20230623   clang
i386                 randconfig-i016-20230621   clang
i386                 randconfig-i016-20230622   gcc  
i386                 randconfig-i016-20230623   clang
i386                 randconfig-r006-20230622   clang
i386                 randconfig-r012-20230622   gcc  
i386                 randconfig-r014-20230622   gcc  
i386                 randconfig-r015-20230622   gcc  
i386                 randconfig-r021-20230621   clang
i386                 randconfig-r031-20230622   clang
i386                 randconfig-r032-20230621   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r015-20230621   gcc  
loongarch            randconfig-r032-20230622   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                 randconfig-r002-20230622   gcc  
m68k                 randconfig-r005-20230622   gcc  
m68k                 randconfig-r015-20230622   gcc  
m68k                 randconfig-r021-20230621   gcc  
m68k                 randconfig-r022-20230621   gcc  
microblaze           randconfig-r003-20230622   gcc  
microblaze           randconfig-r013-20230621   gcc  
microblaze           randconfig-r016-20230622   gcc  
microblaze           randconfig-r023-20230622   gcc  
microblaze           randconfig-r033-20230622   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm63xx_defconfig   clang
mips                         bigsur_defconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                       lemote2f_defconfig   clang
mips                     loongson1b_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   clang
mips                        omega2p_defconfig   clang
mips                 randconfig-r003-20230621   clang
mips                 randconfig-r012-20230621   gcc  
mips                 randconfig-r021-20230622   clang
mips                 randconfig-r024-20230622   clang
mips                 randconfig-r032-20230622   gcc  
mips                 randconfig-r035-20230622   gcc  
mips                       rbtx49xx_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230622   gcc  
nios2                randconfig-r013-20230621   gcc  
nios2                randconfig-r024-20230621   gcc  
nios2                randconfig-r026-20230621   gcc  
nios2                randconfig-r031-20230621   gcc  
nios2                randconfig-r034-20230622   gcc  
nios2                randconfig-r035-20230622   gcc  
nios2                randconfig-r036-20230621   gcc  
openrisc             randconfig-r016-20230621   gcc  
openrisc             randconfig-r022-20230621   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230622   gcc  
parisc               randconfig-r023-20230622   gcc  
parisc               randconfig-r033-20230622   gcc  
parisc               randconfig-r034-20230622   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      chrp32_defconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                        fsp2_defconfig   clang
powerpc                 linkstation_defconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                 mpc85xx_cds_defconfig   gcc  
powerpc                     ppa8548_defconfig   clang
powerpc                       ppc64_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc                     rainier_defconfig   gcc  
powerpc              randconfig-r004-20230622   clang
powerpc              randconfig-r006-20230621   gcc  
powerpc              randconfig-r011-20230621   clang
powerpc              randconfig-r015-20230622   gcc  
powerpc              randconfig-r034-20230622   clang
powerpc                     sequoia_defconfig   gcc  
powerpc                     tqm5200_defconfig   clang
powerpc                      tqm8xx_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r005-20230621   gcc  
riscv                randconfig-r023-20230621   clang
riscv                randconfig-r026-20230621   clang
riscv                randconfig-r042-20230621   clang
riscv                randconfig-r042-20230622   gcc  
riscv                          rv32_defconfig   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230622   clang
s390                 randconfig-r002-20230621   gcc  
s390                 randconfig-r022-20230621   clang
s390                 randconfig-r025-20230622   gcc  
s390                 randconfig-r026-20230622   gcc  
s390                 randconfig-r036-20230622   clang
s390                 randconfig-r044-20230621   clang
s390                 randconfig-r044-20230622   gcc  
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                         microdev_defconfig   gcc  
sh                   randconfig-r001-20230622   gcc  
sh                   randconfig-r002-20230622   gcc  
sh                   randconfig-r006-20230621   gcc  
sh                   randconfig-r031-20230622   gcc  
sh                          rsk7264_defconfig   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r011-20230622   gcc  
sparc                randconfig-r036-20230622   gcc  
sparc64              randconfig-r004-20230622   gcc  
sparc64              randconfig-r011-20230621   gcc  
sparc64              randconfig-r025-20230621   gcc  
sparc64              randconfig-r026-20230621   gcc  
sparc64              randconfig-r033-20230622   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r003-20230622   gcc  
um                   randconfig-r012-20230621   gcc  
um                   randconfig-r034-20230621   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230621   gcc  
x86_64       buildonly-randconfig-r002-20230621   gcc  
x86_64       buildonly-randconfig-r003-20230621   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r015-20230621   clang
x86_64               randconfig-r025-20230621   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa               randconfig-r011-20230622   gcc  
xtensa               randconfig-r012-20230622   gcc  
xtensa               randconfig-r014-20230621   gcc  
xtensa               randconfig-r036-20230622   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
