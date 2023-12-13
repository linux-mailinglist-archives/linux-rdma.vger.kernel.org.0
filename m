Return-Path: <linux-rdma+bounces-403-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA446810C32
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Dec 2023 09:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B60A1F21158
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Dec 2023 08:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D08C1D53A;
	Wed, 13 Dec 2023 08:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LDo2Eh9J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647F6109
	for <linux-rdma@vger.kernel.org>; Wed, 13 Dec 2023 00:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702455374; x=1733991374;
  h=date:from:to:cc:subject:message-id;
  bh=E5TdElb55u0YFWjkchRi07SHjQBtNRZu6x6A5j107KI=;
  b=LDo2Eh9J1HZ0dHx1UTL/cDwkK2N7MDwgSXKGrNQwHU0xN5PFisQQuxMX
   cbjmumZbTkhuqPq6OzngPZNzBfjnRXVLx18epiHbjGBZEhYQf5cTJUolQ
   08/6CV8f2TsCghcMJeTQ1KR9/bAe5Ih7Zhfi8rT78sKEThgOnyHED1UXV
   iVxMnjl1pK54p1XTm2xauAKc10mrACOew4JAx+O72m5T3hlZWBckQhDYx
   8GsMVRBKQfeAaE6kzD7hkpdQehArY+NyiRh/FNnHTq06CMZSiegwt/Eb6
   4TBl3s9+c6OfiLhZXFg+2i8eFOE1wuZIsuU44f4pYlfR4wmClaFdsOIlJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="13624645"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="13624645"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 00:16:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="21861097"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 13 Dec 2023 00:16:11 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDKPX-000KGB-0B;
	Wed, 13 Dec 2023 08:16:07 +0000
Date: Wed, 13 Dec 2023 16:15:12 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 07f830ae4913d0b986c8c0ff88a7d597948b9bd8
Message-ID: <202312131608.aruIrO0V-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 07f830ae4913d0b986c8c0ff88a7d597948b9bd8  RDMA/bnxt_re: Adds MSN table capability for Gen P7 adapters

elapsed time: 2799m

configs tested: 308
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20231211   gcc  
arc                   randconfig-001-20231212   gcc  
arc                   randconfig-001-20231213   gcc  
arc                   randconfig-002-20231211   gcc  
arc                   randconfig-002-20231212   gcc  
arc                   randconfig-002-20231213   gcc  
arc                           tb10x_defconfig   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          gemini_defconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                       imx_v4_v5_defconfig   clang
arm                            mps2_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                   randconfig-001-20231212   gcc  
arm                   randconfig-002-20231212   gcc  
arm                   randconfig-003-20231212   gcc  
arm                   randconfig-004-20231212   gcc  
arm                        realview_defconfig   gcc  
arm                           sama5_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231212   gcc  
arm64                 randconfig-002-20231212   gcc  
arm64                 randconfig-003-20231212   gcc  
arm64                 randconfig-004-20231212   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231211   gcc  
csky                  randconfig-001-20231212   gcc  
csky                  randconfig-001-20231213   gcc  
csky                  randconfig-002-20231211   gcc  
csky                  randconfig-002-20231212   gcc  
csky                  randconfig-002-20231213   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231212   clang
hexagon               randconfig-002-20231212   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231211   clang
i386         buildonly-randconfig-001-20231212   gcc  
i386         buildonly-randconfig-002-20231211   clang
i386         buildonly-randconfig-002-20231212   gcc  
i386         buildonly-randconfig-003-20231211   clang
i386         buildonly-randconfig-003-20231212   gcc  
i386         buildonly-randconfig-004-20231211   clang
i386         buildonly-randconfig-004-20231212   gcc  
i386         buildonly-randconfig-005-20231211   clang
i386         buildonly-randconfig-005-20231212   gcc  
i386         buildonly-randconfig-006-20231211   clang
i386         buildonly-randconfig-006-20231212   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231211   clang
i386                  randconfig-001-20231212   gcc  
i386                  randconfig-002-20231211   clang
i386                  randconfig-002-20231212   gcc  
i386                  randconfig-003-20231211   clang
i386                  randconfig-003-20231212   gcc  
i386                  randconfig-004-20231211   clang
i386                  randconfig-004-20231212   gcc  
i386                  randconfig-005-20231211   clang
i386                  randconfig-005-20231212   gcc  
i386                  randconfig-006-20231211   clang
i386                  randconfig-006-20231212   gcc  
i386                  randconfig-011-20231211   gcc  
i386                  randconfig-011-20231212   clang
i386                  randconfig-011-20231213   gcc  
i386                  randconfig-012-20231211   gcc  
i386                  randconfig-012-20231212   clang
i386                  randconfig-012-20231213   gcc  
i386                  randconfig-013-20231211   gcc  
i386                  randconfig-013-20231212   clang
i386                  randconfig-013-20231213   gcc  
i386                  randconfig-014-20231211   gcc  
i386                  randconfig-014-20231212   clang
i386                  randconfig-014-20231213   gcc  
i386                  randconfig-015-20231211   gcc  
i386                  randconfig-015-20231212   clang
i386                  randconfig-015-20231213   gcc  
i386                  randconfig-016-20231211   gcc  
i386                  randconfig-016-20231212   clang
i386                  randconfig-016-20231213   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231211   gcc  
loongarch             randconfig-001-20231212   gcc  
loongarch             randconfig-001-20231213   gcc  
loongarch             randconfig-002-20231211   gcc  
loongarch             randconfig-002-20231212   gcc  
loongarch             randconfig-002-20231213   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                            gpr_defconfig   gcc  
mips                           ip32_defconfig   gcc  
mips                           jazz_defconfig   gcc  
mips                     loongson2k_defconfig   gcc  
mips                        maltaup_defconfig   clang
mips                      pic32mzda_defconfig   clang
mips                         rt305x_defconfig   gcc  
nios2                         10m50_defconfig   gcc  
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231211   gcc  
nios2                 randconfig-001-20231212   gcc  
nios2                 randconfig-001-20231213   gcc  
nios2                 randconfig-002-20231211   gcc  
nios2                 randconfig-002-20231212   gcc  
nios2                 randconfig-002-20231213   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20231211   gcc  
parisc                randconfig-001-20231212   gcc  
parisc                randconfig-001-20231213   gcc  
parisc                randconfig-002-20231211   gcc  
parisc                randconfig-002-20231212   gcc  
parisc                randconfig-002-20231213   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                 linkstation_defconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc                  mpc866_ads_defconfig   clang
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20231212   gcc  
powerpc               randconfig-002-20231212   gcc  
powerpc               randconfig-003-20231212   gcc  
powerpc                     tqm8541_defconfig   gcc  
powerpc                     tqm8560_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
powerpc64                        alldefconfig   gcc  
powerpc64             randconfig-001-20231212   gcc  
powerpc64             randconfig-002-20231212   gcc  
powerpc64             randconfig-003-20231212   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20231212   gcc  
riscv                 randconfig-002-20231212   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231211   gcc  
s390                  randconfig-001-20231212   clang
s390                  randconfig-001-20231213   gcc  
s390                  randconfig-002-20231211   gcc  
s390                  randconfig-002-20231212   clang
s390                  randconfig-002-20231213   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20231211   gcc  
sh                    randconfig-001-20231212   gcc  
sh                    randconfig-001-20231213   gcc  
sh                    randconfig-002-20231211   gcc  
sh                    randconfig-002-20231212   gcc  
sh                    randconfig-002-20231213   gcc  
sh                          rsk7269_defconfig   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231211   gcc  
sparc64               randconfig-001-20231212   gcc  
sparc64               randconfig-001-20231213   gcc  
sparc64               randconfig-002-20231211   gcc  
sparc64               randconfig-002-20231212   gcc  
sparc64               randconfig-002-20231213   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231212   gcc  
um                    randconfig-002-20231212   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231211   clang
x86_64       buildonly-randconfig-001-20231212   gcc  
x86_64       buildonly-randconfig-002-20231211   clang
x86_64       buildonly-randconfig-002-20231212   gcc  
x86_64       buildonly-randconfig-003-20231211   clang
x86_64       buildonly-randconfig-003-20231212   gcc  
x86_64       buildonly-randconfig-004-20231211   clang
x86_64       buildonly-randconfig-004-20231212   gcc  
x86_64       buildonly-randconfig-005-20231211   clang
x86_64       buildonly-randconfig-005-20231212   gcc  
x86_64       buildonly-randconfig-006-20231211   clang
x86_64       buildonly-randconfig-006-20231212   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231212   clang
x86_64                randconfig-002-20231212   clang
x86_64                randconfig-003-20231212   clang
x86_64                randconfig-004-20231212   clang
x86_64                randconfig-005-20231212   clang
x86_64                randconfig-006-20231212   clang
x86_64                randconfig-011-20231211   clang
x86_64                randconfig-011-20231212   gcc  
x86_64                randconfig-012-20231211   clang
x86_64                randconfig-012-20231212   gcc  
x86_64                randconfig-013-20231211   clang
x86_64                randconfig-013-20231212   gcc  
x86_64                randconfig-014-20231211   clang
x86_64                randconfig-014-20231212   gcc  
x86_64                randconfig-015-20231211   clang
x86_64                randconfig-015-20231212   gcc  
x86_64                randconfig-016-20231211   clang
x86_64                randconfig-016-20231212   gcc  
x86_64                randconfig-071-20231211   clang
x86_64                randconfig-071-20231212   gcc  
x86_64                randconfig-072-20231211   clang
x86_64                randconfig-072-20231212   gcc  
x86_64                randconfig-073-20231211   clang
x86_64                randconfig-073-20231212   gcc  
x86_64                randconfig-074-20231211   clang
x86_64                randconfig-074-20231212   gcc  
x86_64                randconfig-075-20231211   clang
x86_64                randconfig-075-20231212   gcc  
x86_64                randconfig-076-20231211   clang
x86_64                randconfig-076-20231212   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20231211   gcc  
xtensa                randconfig-001-20231212   gcc  
xtensa                randconfig-001-20231213   gcc  
xtensa                randconfig-002-20231211   gcc  
xtensa                randconfig-002-20231212   gcc  
xtensa                randconfig-002-20231213   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

