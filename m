Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A2677DF0E
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Aug 2023 12:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbjHPKmz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Aug 2023 06:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243863AbjHPKmp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Aug 2023 06:42:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD071FCE
        for <linux-rdma@vger.kernel.org>; Wed, 16 Aug 2023 03:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692182563; x=1723718563;
  h=date:from:to:cc:subject:message-id;
  bh=+qA4uZZqLUYMXNjEA6RU9KKMTBugRltyxi7rwb5v/QQ=;
  b=lhei8m6AIGfphJ11Zyxg79q7SVse1XYvJ+YkMO0ihDo4Pf3qu821yZyd
   F+dJTmlhRn+tyqcQ9DX5M1KM4IbawgHy9lhETIW7GxaUQvBaPITXVSs/r
   Mjwoy4Yr0b67cjMZDedJeXPj9q7A8L/R6Z9HZ9PQDoywHHGdV85ZesNsx
   tCj5cPsyZKqDQmR5Z9TMsyW9lxC6IUBEUXSAx8SRu/arm/iI0BKtShj0+
   ry4xyv8nJEQ34V+Cb4snsWlCwlkgbX3aNwieMwicyypZZClzunpPNh+0m
   GDwa0G895ngqFH9iYSk+EoRSXmdVHngrCJU07XuoHszV1BkDkJFsOwdlV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="376226551"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="376226551"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 03:42:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="763595821"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="763595821"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 16 Aug 2023 03:42:42 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWDz6-0000Er-3C;
        Wed, 16 Aug 2023 10:42:40 +0000
Date:   Wed, 16 Aug 2023 18:42:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 0a30e59f22b207f2ed415daa44cfc0533adc329e
Message-ID: <202308161810.ScXt8FRW-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 0a30e59f22b207f2ed415daa44cfc0533adc329e  RDMA/bnxt_re: Add support for dmabuf pinned memory regions

elapsed time: 935m

configs tested: 172
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r006-20230816   gcc  
alpha                randconfig-r016-20230816   gcc  
alpha                randconfig-r022-20230816   gcc  
alpha                randconfig-r025-20230816   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                  randconfig-r005-20230816   gcc  
arc                  randconfig-r006-20230816   gcc  
arc                  randconfig-r011-20230816   gcc  
arc                  randconfig-r021-20230816   gcc  
arc                  randconfig-r043-20230816   gcc  
arc                           tb10x_defconfig   gcc  
arm                              alldefconfig   clang
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   gcc  
arm                       multi_v4t_defconfig   gcc  
arm                          pxa168_defconfig   clang
arm                  randconfig-r036-20230816   clang
arm                  randconfig-r046-20230816   gcc  
arm                           sama5_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r016-20230816   clang
arm64                randconfig-r034-20230816   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r003-20230816   gcc  
csky                 randconfig-r014-20230816   gcc  
csky                 randconfig-r034-20230816   gcc  
hexagon              randconfig-r033-20230816   clang
hexagon              randconfig-r041-20230816   clang
hexagon              randconfig-r045-20230816   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230816   gcc  
i386         buildonly-randconfig-r005-20230816   gcc  
i386         buildonly-randconfig-r006-20230816   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230816   gcc  
i386                 randconfig-i002-20230816   gcc  
i386                 randconfig-i003-20230816   gcc  
i386                 randconfig-i004-20230816   gcc  
i386                 randconfig-i005-20230816   gcc  
i386                 randconfig-i006-20230816   gcc  
i386                 randconfig-i011-20230816   clang
i386                 randconfig-i012-20230816   clang
i386                 randconfig-i013-20230816   clang
i386                 randconfig-i014-20230816   clang
i386                 randconfig-i015-20230816   clang
i386                 randconfig-i016-20230816   clang
i386                 randconfig-r023-20230816   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r026-20230816   gcc  
loongarch            randconfig-r031-20230816   gcc  
m68k                             alldefconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r032-20230816   gcc  
m68k                           sun3_defconfig   gcc  
microblaze           randconfig-r001-20230816   gcc  
microblaze           randconfig-r011-20230816   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm63xx_defconfig   clang
mips                  cavium_octeon_defconfig   clang
mips                         cobalt_defconfig   gcc  
mips                            gpr_defconfig   gcc  
mips                        qi_lb60_defconfig   clang
mips                        qi_lb60_defconfig   gcc  
mips                 randconfig-r003-20230816   clang
mips                 randconfig-r022-20230816   gcc  
mips                           rs90_defconfig   clang
mips                         rt305x_defconfig   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r002-20230816   gcc  
openrisc             randconfig-r023-20230816   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc               randconfig-r004-20230816   gcc  
parisc               randconfig-r024-20230816   gcc  
parisc               randconfig-r033-20230816   gcc  
parisc               randconfig-r035-20230816   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      arches_defconfig   gcc  
powerpc                   bluestone_defconfig   clang
powerpc                     ksi8560_defconfig   clang
powerpc                       maple_defconfig   gcc  
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                     powernv_defconfig   clang
powerpc              randconfig-r013-20230816   clang
powerpc                      tqm8xx_defconfig   gcc  
powerpc                 xes_mpc85xx_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r021-20230816   clang
riscv                randconfig-r042-20230816   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r002-20230816   gcc  
s390                 randconfig-r015-20230816   clang
s390                 randconfig-r032-20230816   gcc  
s390                 randconfig-r044-20230816   clang
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                               j2_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                         microdev_defconfig   gcc  
sh                   randconfig-r001-20230816   gcc  
sh                   randconfig-r002-20230816   gcc  
sh                   randconfig-r024-20230816   gcc  
sh                   randconfig-r025-20230816   gcc  
sh                          rsk7203_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r021-20230816   gcc  
sparc                randconfig-r023-20230816   gcc  
sparc                randconfig-r026-20230816   gcc  
sparc                randconfig-r036-20230816   gcc  
sparc64              randconfig-r001-20230816   gcc  
sparc64              randconfig-r004-20230816   gcc  
sparc64              randconfig-r014-20230816   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r005-20230816   clang
um                   randconfig-r012-20230816   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230816   gcc  
x86_64       buildonly-randconfig-r002-20230816   gcc  
x86_64       buildonly-randconfig-r003-20230816   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r025-20230816   clang
x86_64               randconfig-x001-20230816   clang
x86_64               randconfig-x002-20230816   clang
x86_64               randconfig-x003-20230816   clang
x86_64               randconfig-x004-20230816   clang
x86_64               randconfig-x005-20230816   clang
x86_64               randconfig-x006-20230816   clang
x86_64               randconfig-x011-20230816   gcc  
x86_64               randconfig-x012-20230816   gcc  
x86_64               randconfig-x013-20230816   gcc  
x86_64               randconfig-x014-20230816   gcc  
x86_64               randconfig-x015-20230816   gcc  
x86_64               randconfig-x016-20230816   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r006-20230816   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
