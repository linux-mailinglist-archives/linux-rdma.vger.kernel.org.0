Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9983719201
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jun 2023 06:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjFAExF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jun 2023 00:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjFAExE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Jun 2023 00:53:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F8F123
        for <linux-rdma@vger.kernel.org>; Wed, 31 May 2023 21:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685595183; x=1717131183;
  h=date:from:to:cc:subject:message-id;
  bh=QU8BpeD4+laaIeF3p2vjebgHUTkK1mI1rO6QSgxoPME=;
  b=l9pWNefFJqDHpeZbze2PCOAOmfCedWPZsbQQblbpNouN5APNspRX6tKt
   q3nrjC5Ms+ebF26MSBtRL7ibBVD/1zLeE8hAg1nGXjFnDbIZy5WjrGFw2
   0OfqC59vX970q4FGvkLnbtJ+utDKBykJLW1uLClCsEF1VkwECY+Oo6bFd
   dPFXErux9zQdgNIR8gGWXu8OGOqvj+fjtnE3yuPDicGyQvvNHaw5gUKrM
   w57VY8lQWPAJCzFNQv0qcUkwRR8N9C3y67+Zovc4xhuo9F3FDqyp/DgRF
   T0XY6pC6Lx+cVuNXvNh0V1nUyHBCpImM8zEdWkr43KozJ6FNMxL4L/Qaa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="335801490"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; 
   d="scan'208";a="335801490"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 21:53:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="1037318280"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; 
   d="scan'208";a="1037318280"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 31 May 2023 21:53:01 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4aJ2-0001vH-2e;
        Thu, 01 Jun 2023 04:53:00 +0000
Date:   Thu, 01 Jun 2023 12:52:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:for-rc] BUILD SUCCESS
 5842d1d9c1b0d17e0c29eae65ae1f245f83682dd
Message-ID: <20230601045220.TlkZP%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: 5842d1d9c1b0d17e0c29eae65ae1f245f83682dd  RDMA/irdma: Fix Local Invalidate fencing

elapsed time: 731m

configs tested: 217
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230531   gcc  
alpha                randconfig-r006-20230531   gcc  
alpha                randconfig-r013-20230531   gcc  
alpha                randconfig-r024-20230531   gcc  
alpha                randconfig-r025-20230531   gcc  
alpha                randconfig-r031-20230531   gcc  
arc                              alldefconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r001-20230531   gcc  
arc          buildonly-randconfig-r002-20230531   gcc  
arc          buildonly-randconfig-r006-20230531   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                  randconfig-r003-20230531   gcc  
arc                  randconfig-r014-20230531   gcc  
arc                  randconfig-r043-20230531   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                         lpc32xx_defconfig   clang
arm                             mxs_defconfig   clang
arm                  randconfig-r021-20230531   gcc  
arm                  randconfig-r026-20230531   gcc  
arm                  randconfig-r046-20230531   gcc  
arm                        spear6xx_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r022-20230531   clang
arm64                randconfig-r033-20230531   gcc  
csky                             alldefconfig   gcc  
csky         buildonly-randconfig-r001-20230531   gcc  
csky         buildonly-randconfig-r005-20230531   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r005-20230531   gcc  
csky                 randconfig-r025-20230531   gcc  
csky                 randconfig-r035-20230531   gcc  
hexagon      buildonly-randconfig-r001-20230531   clang
hexagon              randconfig-r035-20230531   clang
hexagon              randconfig-r041-20230531   clang
hexagon              randconfig-r045-20230531   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230531   gcc  
i386                 randconfig-i002-20230531   gcc  
i386                 randconfig-i003-20230531   gcc  
i386                 randconfig-i004-20230531   gcc  
i386                 randconfig-i005-20230531   gcc  
i386                 randconfig-i006-20230531   gcc  
i386                 randconfig-i011-20230531   clang
i386                 randconfig-i012-20230531   clang
i386                 randconfig-i013-20230531   clang
i386                 randconfig-i014-20230531   clang
i386                 randconfig-i015-20230531   clang
i386                 randconfig-i016-20230531   clang
i386                 randconfig-i051-20230531   gcc  
i386                 randconfig-i052-20230531   gcc  
i386                 randconfig-i053-20230531   gcc  
i386                 randconfig-i054-20230531   gcc  
i386                 randconfig-i055-20230531   gcc  
i386                 randconfig-i056-20230531   gcc  
i386                 randconfig-i061-20230531   gcc  
i386                 randconfig-i062-20230531   gcc  
i386                 randconfig-i063-20230531   gcc  
i386                 randconfig-i064-20230531   gcc  
i386                 randconfig-i065-20230531   gcc  
i386                 randconfig-i066-20230531   gcc  
i386                 randconfig-r001-20230531   gcc  
i386                 randconfig-r006-20230531   gcc  
i386                 randconfig-r016-20230531   clang
i386                 randconfig-r026-20230531   clang
ia64                      gensparse_defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r005-20230531   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r021-20230531   gcc  
loongarch            randconfig-r025-20230531   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230531   gcc  
m68k                 randconfig-r034-20230531   gcc  
m68k                 randconfig-r036-20230531   gcc  
microblaze           randconfig-r013-20230531   gcc  
microblaze           randconfig-r015-20230531   gcc  
microblaze           randconfig-r022-20230531   gcc  
microblaze           randconfig-r024-20230531   gcc  
microblaze           randconfig-r032-20230531   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r003-20230531   clang
mips         buildonly-randconfig-r004-20230531   clang
mips         buildonly-randconfig-r006-20230531   clang
mips                           jazz_defconfig   gcc  
mips                      maltaaprp_defconfig   clang
mips                 randconfig-r005-20230531   clang
mips                 randconfig-r012-20230531   gcc  
mips                 randconfig-r022-20230531   gcc  
mips                 randconfig-r031-20230531   clang
nios2                            alldefconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230531   gcc  
nios2                randconfig-r002-20230531   gcc  
nios2                randconfig-r011-20230531   gcc  
nios2                randconfig-r012-20230531   gcc  
nios2                randconfig-r013-20230531   gcc  
nios2                randconfig-r026-20230531   gcc  
nios2                randconfig-r032-20230531   gcc  
openrisc     buildonly-randconfig-r001-20230531   gcc  
openrisc     buildonly-randconfig-r003-20230531   gcc  
openrisc     buildonly-randconfig-r004-20230531   gcc  
openrisc     buildonly-randconfig-r005-20230531   gcc  
openrisc             randconfig-r011-20230531   gcc  
openrisc             randconfig-r033-20230531   gcc  
parisc       buildonly-randconfig-r006-20230531   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r016-20230531   gcc  
parisc               randconfig-r024-20230531   gcc  
parisc               randconfig-r032-20230531   gcc  
parisc               randconfig-r034-20230531   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                    amigaone_defconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                       ebony_defconfig   clang
powerpc                    gamecube_defconfig   clang
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc              randconfig-r004-20230531   gcc  
powerpc              randconfig-r006-20230531   gcc  
powerpc              randconfig-r031-20230531   gcc  
powerpc              randconfig-r034-20230531   gcc  
powerpc              randconfig-r035-20230531   gcc  
powerpc                        warp_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230531   clang
riscv                               defconfig   gcc  
riscv                randconfig-r016-20230531   clang
riscv                randconfig-r021-20230531   clang
riscv                randconfig-r023-20230531   clang
riscv                randconfig-r036-20230531   gcc  
riscv                randconfig-r042-20230531   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r012-20230531   clang
s390                 randconfig-r014-20230531   clang
s390                 randconfig-r033-20230531   gcc  
s390                 randconfig-r044-20230531   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r005-20230531   gcc  
sh           buildonly-randconfig-r006-20230531   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                   randconfig-r003-20230531   gcc  
sh                   randconfig-r015-20230531   gcc  
sh                   randconfig-r036-20230531   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r011-20230531   gcc  
sparc64      buildonly-randconfig-r002-20230531   gcc  
sparc64      buildonly-randconfig-r004-20230531   gcc  
sparc64              randconfig-r002-20230531   gcc  
sparc64              randconfig-r003-20230531   gcc  
sparc64              randconfig-r005-20230531   gcc  
sparc64              randconfig-r014-20230531   gcc  
sparc64              randconfig-r015-20230531   gcc  
sparc64              randconfig-r023-20230531   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r002-20230531   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230531   gcc  
x86_64               randconfig-a002-20230531   gcc  
x86_64               randconfig-a003-20230531   gcc  
x86_64               randconfig-a004-20230531   gcc  
x86_64               randconfig-a005-20230531   gcc  
x86_64               randconfig-a006-20230531   gcc  
x86_64               randconfig-a011-20230531   clang
x86_64               randconfig-a012-20230531   clang
x86_64               randconfig-a013-20230531   clang
x86_64               randconfig-a014-20230531   clang
x86_64               randconfig-a015-20230531   clang
x86_64               randconfig-a016-20230531   clang
x86_64               randconfig-r004-20230531   gcc  
x86_64               randconfig-r011-20230531   clang
x86_64               randconfig-r033-20230531   gcc  
x86_64               randconfig-r034-20230531   gcc  
x86_64               randconfig-r036-20230531   gcc  
x86_64               randconfig-x051-20230531   clang
x86_64               randconfig-x052-20230531   clang
x86_64               randconfig-x053-20230531   clang
x86_64               randconfig-x054-20230531   clang
x86_64               randconfig-x055-20230531   clang
x86_64               randconfig-x056-20230531   clang
x86_64               randconfig-x061-20230531   clang
x86_64               randconfig-x062-20230531   clang
x86_64               randconfig-x063-20230531   clang
x86_64               randconfig-x064-20230531   clang
x86_64               randconfig-x065-20230531   clang
x86_64               randconfig-x066-20230531   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r001-20230531   gcc  
xtensa               randconfig-r014-20230531   gcc  
xtensa               randconfig-r023-20230531   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
