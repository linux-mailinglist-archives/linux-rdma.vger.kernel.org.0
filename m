Return-Path: <linux-rdma+bounces-17-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9557F32AA
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Nov 2023 16:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9E08B21E4A
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Nov 2023 15:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C57258124;
	Tue, 21 Nov 2023 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QKeNLqeJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8044597
	for <linux-rdma@vger.kernel.org>; Tue, 21 Nov 2023 07:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700581672; x=1732117672;
  h=date:from:to:cc:subject:message-id;
  bh=kX8BaYH64yptxm/5eA/jiFpj1bQUJz/DZJ4s8jsdDVM=;
  b=QKeNLqeJJnR0SB89GZU+fX6AIBdTDI1g0RGtc69W43209ATh1yMgAq+g
   aMdlIs/8oQnbJe8w2epiMjCcmn6Tym5g26hEI84c5DWcgNZejavMUExzc
   8e24YzsNuHuPFdMh8o6uREWF6cl/1+2lcFGu++LY1UblCgqkTHod6+nrs
   cD+sSnoY7iysiDlvfkW4MASWcZvombPMRNYnH4NjWP22bfO6fFPvvNu8c
   Mk3d0U+P9RS21C2PLvLKkWv79KyW+94JK+a6tjAI4JAV2igOKbtLo0tuD
   LrsbVxc8h4UhUbLkcKd9dNsvA0VoeGgO/m7OrPYwolEZ/rhG/3JgaK27+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="382259851"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="382259851"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 07:47:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="1013942410"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="1013942410"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 21 Nov 2023 07:47:45 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5SyU-0007yU-0T;
	Tue, 21 Nov 2023 15:47:42 +0000
Date: Tue, 21 Nov 2023 23:47:21 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 0529e26d8b7b51da99c9d7234700f4041d20c0e4
Message-ID: <202311212319.jmyqh5DR-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 0529e26d8b7b51da99c9d7234700f4041d20c0e4  RDMA/rtrs-clt: Add warning logs for RDMA events

elapsed time: 3031m

configs tested: 327
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20231119   gcc  
arc                   randconfig-001-20231120   gcc  
arc                   randconfig-001-20231121   gcc  
arc                   randconfig-002-20231119   gcc  
arc                   randconfig-002-20231120   gcc  
arc                   randconfig-002-20231121   gcc  
arc                           tb10x_defconfig   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          gemini_defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                       multi_v4t_defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                   randconfig-001-20231119   gcc  
arm                   randconfig-001-20231120   clang
arm                   randconfig-001-20231121   gcc  
arm                   randconfig-002-20231119   gcc  
arm                   randconfig-002-20231120   clang
arm                   randconfig-002-20231121   gcc  
arm                   randconfig-003-20231119   gcc  
arm                   randconfig-003-20231120   clang
arm                   randconfig-003-20231121   gcc  
arm                   randconfig-004-20231119   gcc  
arm                   randconfig-004-20231120   clang
arm                   randconfig-004-20231121   gcc  
arm                        spear6xx_defconfig   gcc  
arm                           stm32_defconfig   gcc  
arm                           sunxi_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231119   gcc  
arm64                 randconfig-001-20231120   clang
arm64                 randconfig-001-20231121   gcc  
arm64                 randconfig-002-20231119   gcc  
arm64                 randconfig-002-20231120   clang
arm64                 randconfig-002-20231121   gcc  
arm64                 randconfig-003-20231119   gcc  
arm64                 randconfig-003-20231120   clang
arm64                 randconfig-003-20231121   gcc  
arm64                 randconfig-004-20231119   gcc  
arm64                 randconfig-004-20231120   clang
arm64                 randconfig-004-20231121   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231119   gcc  
csky                  randconfig-001-20231120   gcc  
csky                  randconfig-001-20231121   gcc  
csky                  randconfig-002-20231119   gcc  
csky                  randconfig-002-20231120   gcc  
csky                  randconfig-002-20231121   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231120   clang
hexagon               randconfig-002-20231120   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231119   gcc  
i386         buildonly-randconfig-002-20231119   gcc  
i386         buildonly-randconfig-003-20231119   gcc  
i386         buildonly-randconfig-004-20231119   gcc  
i386         buildonly-randconfig-005-20231119   gcc  
i386         buildonly-randconfig-006-20231119   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231119   gcc  
i386                  randconfig-002-20231119   gcc  
i386                  randconfig-003-20231119   gcc  
i386                  randconfig-004-20231119   gcc  
i386                  randconfig-005-20231119   gcc  
i386                  randconfig-006-20231119   gcc  
i386                  randconfig-011-20231119   clang
i386                  randconfig-011-20231120   gcc  
i386                  randconfig-011-20231121   clang
i386                  randconfig-012-20231119   clang
i386                  randconfig-012-20231120   gcc  
i386                  randconfig-012-20231121   clang
i386                  randconfig-013-20231119   clang
i386                  randconfig-013-20231120   gcc  
i386                  randconfig-013-20231121   clang
i386                  randconfig-014-20231119   clang
i386                  randconfig-014-20231120   gcc  
i386                  randconfig-014-20231121   clang
i386                  randconfig-015-20231119   clang
i386                  randconfig-015-20231120   gcc  
i386                  randconfig-015-20231121   clang
i386                  randconfig-016-20231119   clang
i386                  randconfig-016-20231120   gcc  
i386                  randconfig-016-20231121   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231119   gcc  
loongarch             randconfig-001-20231120   gcc  
loongarch             randconfig-001-20231121   gcc  
loongarch             randconfig-002-20231119   gcc  
loongarch             randconfig-002-20231120   gcc  
loongarch             randconfig-002-20231121   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                           jazz_defconfig   gcc  
mips                     loongson1b_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231119   gcc  
nios2                 randconfig-001-20231120   gcc  
nios2                 randconfig-001-20231121   gcc  
nios2                 randconfig-002-20231119   gcc  
nios2                 randconfig-002-20231120   gcc  
nios2                 randconfig-002-20231121   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231119   gcc  
parisc                randconfig-001-20231120   gcc  
parisc                randconfig-001-20231121   gcc  
parisc                randconfig-002-20231119   gcc  
parisc                randconfig-002-20231120   gcc  
parisc                randconfig-002-20231121   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      chrp32_defconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                   motionpro_defconfig   gcc  
powerpc                      ppc40x_defconfig   gcc  
powerpc               randconfig-001-20231119   gcc  
powerpc               randconfig-001-20231120   clang
powerpc               randconfig-001-20231121   gcc  
powerpc               randconfig-002-20231119   gcc  
powerpc               randconfig-002-20231120   clang
powerpc               randconfig-002-20231121   gcc  
powerpc               randconfig-003-20231119   gcc  
powerpc               randconfig-003-20231120   clang
powerpc               randconfig-003-20231121   gcc  
powerpc                     sequoia_defconfig   gcc  
powerpc64             randconfig-001-20231119   gcc  
powerpc64             randconfig-001-20231120   clang
powerpc64             randconfig-001-20231121   gcc  
powerpc64             randconfig-002-20231119   gcc  
powerpc64             randconfig-002-20231120   clang
powerpc64             randconfig-002-20231121   gcc  
powerpc64             randconfig-003-20231119   gcc  
powerpc64             randconfig-003-20231120   clang
powerpc64             randconfig-003-20231121   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                 randconfig-001-20231119   gcc  
riscv                 randconfig-001-20231120   clang
riscv                 randconfig-001-20231121   gcc  
riscv                 randconfig-002-20231119   gcc  
riscv                 randconfig-002-20231120   clang
riscv                 randconfig-002-20231121   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231120   gcc  
s390                  randconfig-002-20231120   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                    randconfig-001-20231119   gcc  
sh                    randconfig-001-20231120   gcc  
sh                    randconfig-001-20231121   gcc  
sh                    randconfig-002-20231119   gcc  
sh                    randconfig-002-20231120   gcc  
sh                    randconfig-002-20231121   gcc  
sh                          rsk7264_defconfig   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                           se7705_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231119   gcc  
sparc64               randconfig-001-20231120   gcc  
sparc64               randconfig-001-20231121   gcc  
sparc64               randconfig-002-20231119   gcc  
sparc64               randconfig-002-20231120   gcc  
sparc64               randconfig-002-20231121   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231119   gcc  
um                    randconfig-001-20231120   clang
um                    randconfig-001-20231121   gcc  
um                    randconfig-002-20231119   gcc  
um                    randconfig-002-20231120   clang
um                    randconfig-002-20231121   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231119   gcc  
x86_64       buildonly-randconfig-001-20231120   clang
x86_64       buildonly-randconfig-001-20231121   gcc  
x86_64       buildonly-randconfig-002-20231119   gcc  
x86_64       buildonly-randconfig-002-20231120   clang
x86_64       buildonly-randconfig-002-20231121   gcc  
x86_64       buildonly-randconfig-003-20231119   gcc  
x86_64       buildonly-randconfig-003-20231120   clang
x86_64       buildonly-randconfig-003-20231121   gcc  
x86_64       buildonly-randconfig-004-20231119   gcc  
x86_64       buildonly-randconfig-004-20231120   clang
x86_64       buildonly-randconfig-004-20231121   gcc  
x86_64       buildonly-randconfig-005-20231119   gcc  
x86_64       buildonly-randconfig-005-20231120   clang
x86_64       buildonly-randconfig-005-20231121   gcc  
x86_64       buildonly-randconfig-006-20231119   gcc  
x86_64       buildonly-randconfig-006-20231120   clang
x86_64       buildonly-randconfig-006-20231121   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231119   gcc  
x86_64                randconfig-011-20231120   clang
x86_64                randconfig-011-20231121   gcc  
x86_64                randconfig-012-20231119   gcc  
x86_64                randconfig-012-20231120   clang
x86_64                randconfig-012-20231121   gcc  
x86_64                randconfig-013-20231119   gcc  
x86_64                randconfig-013-20231120   clang
x86_64                randconfig-013-20231121   gcc  
x86_64                randconfig-014-20231119   gcc  
x86_64                randconfig-014-20231120   clang
x86_64                randconfig-014-20231121   gcc  
x86_64                randconfig-015-20231119   gcc  
x86_64                randconfig-015-20231120   clang
x86_64                randconfig-015-20231121   gcc  
x86_64                randconfig-016-20231119   gcc  
x86_64                randconfig-016-20231120   clang
x86_64                randconfig-016-20231121   gcc  
x86_64                randconfig-071-20231119   gcc  
x86_64                randconfig-071-20231120   clang
x86_64                randconfig-071-20231121   gcc  
x86_64                randconfig-072-20231119   gcc  
x86_64                randconfig-072-20231120   clang
x86_64                randconfig-072-20231121   gcc  
x86_64                randconfig-073-20231119   gcc  
x86_64                randconfig-073-20231120   clang
x86_64                randconfig-073-20231121   gcc  
x86_64                randconfig-074-20231119   gcc  
x86_64                randconfig-074-20231120   clang
x86_64                randconfig-074-20231121   gcc  
x86_64                randconfig-075-20231119   gcc  
x86_64                randconfig-075-20231120   clang
x86_64                randconfig-075-20231121   gcc  
x86_64                randconfig-076-20231119   gcc  
x86_64                randconfig-076-20231120   clang
x86_64                randconfig-076-20231121   gcc  
x86_64                           rhel-8.3-bpf   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                randconfig-001-20231119   gcc  
xtensa                randconfig-001-20231120   gcc  
xtensa                randconfig-001-20231121   gcc  
xtensa                randconfig-002-20231119   gcc  
xtensa                randconfig-002-20231120   gcc  
xtensa                randconfig-002-20231121   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

