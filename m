Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3997015D9
	for <lists+linux-rdma@lfdr.de>; Sat, 13 May 2023 11:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbjEMJmN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 13 May 2023 05:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjEMJmM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 13 May 2023 05:42:12 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB9940DA
        for <linux-rdma@vger.kernel.org>; Sat, 13 May 2023 02:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683970931; x=1715506931;
  h=date:from:to:cc:subject:message-id;
  bh=QD3mH2sqZIAxTfSzu10fGs3LQh5RUt9f9Ag+FlZ8LeA=;
  b=KeDqO6fb+OPDRsTaA0YIpvIdGo+/5Ys6iKfqTOBTJkOisZnDD6Np8XrT
   hLQ0xnMZuHemesto2a9GAP3/SsYwaTpkjO8p7WPcdRLXoHlFnhxaMO+2/
   0oVyqtbQu2wVwzaA7m59bLhSw9nLZtRvz7ndfyZQMGcyjxASOXqLVEovo
   yDjJy7HMFKgw5WT9v/K55GGIQ7naXI/ATaALXUvEA4N/Y6ValkAvwP2Mq
   WBwT/X+A2YgbKqLdndu52El8KOSoXC/skO3R6tgxnPFe6/QGc3veZWpJ/
   5MaABYuZLB99toX6u8W9YyY5l7aQ2tUB2IgQKaE5sVKCxmQNchEv+EYcC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="349784878"
X-IronPort-AV: E=Sophos;i="5.99,272,1677571200"; 
   d="scan'208";a="349784878"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 02:42:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="733324181"
X-IronPort-AV: E=Sophos;i="5.99,272,1677571200"; 
   d="scan'208";a="733324181"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 May 2023 02:42:09 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxllQ-0005RC-0V;
        Sat, 13 May 2023 09:42:08 +0000
Date:   Sat, 13 May 2023 17:41:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 78b6a9a3f445e121ca08195084206cb8faa6999f
Message-ID: <20230513094142.RbJT5%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-rc
branch HEAD: 78b6a9a3f445e121ca08195084206cb8faa6999f  MAINTAINERS: Update maintainers of HiSilicon RoCE

elapsed time: 725m

configs tested: 188
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230511   gcc  
alpha                randconfig-r003-20230511   gcc  
alpha                randconfig-r004-20230511   gcc  
alpha                randconfig-r006-20230511   gcc  
alpha                randconfig-r012-20230511   gcc  
alpha                randconfig-r014-20230512   gcc  
alpha                randconfig-r016-20230509   gcc  
alpha                randconfig-r022-20230509   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r001-20230511   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r002-20230509   gcc  
arc                  randconfig-r003-20230509   gcc  
arc                  randconfig-r015-20230509   gcc  
arc                  randconfig-r023-20230509   gcc  
arc                  randconfig-r025-20230509   gcc  
arc                  randconfig-r043-20230509   gcc  
arc                  randconfig-r043-20230511   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r001-20230511   clang
arm                                 defconfig   gcc  
arm                            hisi_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                            qcom_defconfig   gcc  
arm                  randconfig-r005-20230511   gcc  
arm                  randconfig-r021-20230511   clang
arm                  randconfig-r046-20230509   gcc  
arm                  randconfig-r046-20230511   clang
arm                         wpcm450_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230509   gcc  
arm64                randconfig-r001-20230511   clang
arm64                randconfig-r015-20230509   clang
arm64                randconfig-r021-20230509   clang
csky         buildonly-randconfig-r002-20230511   gcc  
csky         buildonly-randconfig-r006-20230511   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r005-20230511   gcc  
csky                 randconfig-r025-20230509   gcc  
hexagon              randconfig-r004-20230509   clang
hexagon              randconfig-r016-20230511   clang
hexagon              randconfig-r031-20230509   clang
hexagon              randconfig-r041-20230509   clang
hexagon              randconfig-r041-20230511   clang
hexagon              randconfig-r045-20230509   clang
hexagon              randconfig-r045-20230511   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r006-20230509   gcc  
ia64                 randconfig-r016-20230509   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r013-20230509   gcc  
loongarch            randconfig-r022-20230511   gcc  
loongarch            randconfig-r024-20230509   gcc  
loongarch            randconfig-r034-20230511   gcc  
m68k                             allmodconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k         buildonly-randconfig-r003-20230511   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                 randconfig-r001-20230509   gcc  
m68k                 randconfig-r011-20230509   gcc  
m68k                 randconfig-r013-20230512   gcc  
m68k                 randconfig-r022-20230511   gcc  
microblaze           randconfig-r015-20230512   gcc  
microblaze           randconfig-r021-20230511   gcc  
microblaze           randconfig-r024-20230511   gcc  
microblaze           randconfig-r026-20230511   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r004-20230509   clang
mips                 randconfig-r004-20230511   gcc  
mips                 randconfig-r012-20230509   gcc  
mips                 randconfig-r014-20230511   clang
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230509   gcc  
nios2                randconfig-r015-20230511   gcc  
nios2                randconfig-r023-20230511   gcc  
nios2                randconfig-r026-20230511   gcc  
nios2                randconfig-r036-20230509   gcc  
openrisc     buildonly-randconfig-r003-20230509   gcc  
openrisc             randconfig-r013-20230511   gcc  
openrisc             randconfig-r014-20230509   gcc  
openrisc             randconfig-r024-20230509   gcc  
openrisc             randconfig-r024-20230511   gcc  
openrisc             randconfig-r025-20230511   gcc  
openrisc             randconfig-r033-20230511   gcc  
openrisc             randconfig-r035-20230511   gcc  
openrisc             randconfig-r036-20230511   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc               randconfig-r011-20230512   gcc  
parisc               randconfig-r023-20230509   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r005-20230511   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc              randconfig-r003-20230511   clang
powerpc              randconfig-r005-20230509   gcc  
powerpc              randconfig-r022-20230509   clang
powerpc              randconfig-r023-20230511   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230511   gcc  
riscv        buildonly-randconfig-r006-20230511   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                randconfig-r003-20230509   gcc  
riscv                randconfig-r034-20230509   gcc  
riscv                randconfig-r042-20230509   clang
riscv                randconfig-r042-20230511   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r006-20230509   gcc  
s390                 randconfig-r011-20230509   clang
s390                 randconfig-r014-20230511   gcc  
s390                 randconfig-r026-20230509   clang
s390                 randconfig-r033-20230509   gcc  
s390                 randconfig-r044-20230509   clang
s390                 randconfig-r044-20230511   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230509   gcc  
sh           buildonly-randconfig-r002-20230509   gcc  
sh           buildonly-randconfig-r006-20230509   gcc  
sh                   randconfig-r011-20230511   gcc  
sh                          rsk7264_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230509   gcc  
sparc                randconfig-r002-20230511   gcc  
sparc                randconfig-r015-20230511   gcc  
sparc64              randconfig-r012-20230512   gcc  
sparc64              randconfig-r032-20230509   gcc  
sparc64              randconfig-r032-20230511   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                        randconfig-k001   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-syz   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r003-20230511   gcc  
xtensa       buildonly-randconfig-r004-20230509   gcc  
xtensa               randconfig-r006-20230511   gcc  
xtensa               randconfig-r012-20230511   gcc  
xtensa               randconfig-r016-20230512   gcc  
xtensa               randconfig-r035-20230509   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
