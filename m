Return-Path: <linux-rdma+bounces-3656-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D04EC92813D
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2024 06:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31CD3B25017
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2024 04:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8335916B;
	Fri,  5 Jul 2024 04:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LhgMujoL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E995FEE5
	for <linux-rdma@vger.kernel.org>; Fri,  5 Jul 2024 04:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720154003; cv=none; b=Ha++C8R0pikNGVD7ju2vv6YFfLsXDkBX7zusCsdBRzt5fx48RdMn4aNjlWechtSmieXyMCoWtmGIncNdj+3f87VWbAzIrOQbG/HxDQs0/M26UpxK1f0iFcFoEwQtIkuQsQgK7AZJNUNEpVqtqtMjJhcpVArCMSfodfOEbaZ5jx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720154003; c=relaxed/simple;
	bh=0wN/cTMwLUUEFm7A+l6Q5/QyQt7+FzO5uJp+nviyjbE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bF3ahXtyaMfxrTC9hS/Y6BSchWMbH2aX9dxp25EaUs7F4np6yV2CTmY9rVMAjwY4GKK8rwZY1puh0GAI60nQtsViNioIP7BoEf32jisXE3Sq5YKhe+1lWH3DPI7A87SC/ScEpQZN7Lg8ajYRnlh9Wa2hWYsInTN8DdIjcDGo9TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LhgMujoL; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720154002; x=1751690002;
  h=date:from:to:cc:subject:message-id;
  bh=0wN/cTMwLUUEFm7A+l6Q5/QyQt7+FzO5uJp+nviyjbE=;
  b=LhgMujoLI5fIoyY8TKusGDXEPJoKu0oGcX5jkDf79oZl89aqNsDWyTmG
   F9HRAuowLcinAiYTwubq4RDhzlYhpEpbC8UetYpBl/Dr77uavGYDWr8XW
   TzRaLowOtYyBN/LFcHvyP+Ojc5SQHJ66a48AJg23fZmdonsTIFL6dWxYo
   kzRPzqvEfDfC+IWUMXn6wE2aiPzzKc1GHJG7MkAo2fm77A3bpCO23Fgos
   iKHd3iduqUgSpNPcd2nGhPCcNAhJ9bnMPuCiNwCz7jks2hE/O2q/vNvM4
   kQqvaPLz5+vG7CPWTBvFkpLUjqjHF4aQo5A0M2OXf3ZyfEiFctaMrMh5K
   A==;
X-CSE-ConnectionGUID: xtmZbTVDSD+T5pZ3nxQnow==
X-CSE-MsgGUID: 1BkEtkNUTMG518qdaNQ5VQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="28835250"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="28835250"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 21:33:22 -0700
X-CSE-ConnectionGUID: YECM6/IqTqmWd0UIj8OFkw==
X-CSE-MsgGUID: B0/1boBHTbee+MkZXIpgJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="51100570"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 04 Jul 2024 21:33:19 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPadJ-000RuV-1e;
	Fri, 05 Jul 2024 04:33:17 +0000
Date: Fri, 05 Jul 2024 12:32:48 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 af48f95492dc1af36d9636a750ec492035c0ed7d
Message-ID: <202407051246.D6qzBVWv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: af48f95492dc1af36d9636a750ec492035c0ed7d  RDMA/core: Introduce "name_assign_type" for an IB device

elapsed time: 1372m

configs tested: 286
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              alldefconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                     haps_hs_smp_defconfig   gcc-13.2.0
arc                        nsim_700_defconfig   gcc-13.2.0
arc                 nsimosci_hs_smp_defconfig   gcc-13.2.0
arc                   randconfig-001-20240704   gcc-13.2.0
arc                   randconfig-001-20240705   gcc-13.2.0
arc                   randconfig-002-20240704   gcc-13.2.0
arc                   randconfig-002-20240705   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                     am200epdkit_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                            hisi_defconfig   gcc-13.2.0
arm                         lpc18xx_defconfig   gcc-13.2.0
arm                            mps2_defconfig   gcc-13.2.0
arm                         mv78xx0_defconfig   gcc-13.2.0
arm                             mxs_defconfig   gcc-13.2.0
arm                   randconfig-001-20240704   gcc-13.2.0
arm                   randconfig-001-20240705   gcc-13.2.0
arm                   randconfig-002-20240704   gcc-13.2.0
arm                   randconfig-002-20240705   gcc-13.2.0
arm                   randconfig-003-20240704   gcc-13.2.0
arm                   randconfig-003-20240705   gcc-13.2.0
arm                   randconfig-004-20240704   gcc-13.2.0
arm                   randconfig-004-20240705   gcc-13.2.0
arm                             rpc_defconfig   gcc-13.2.0
arm                         s5pv210_defconfig   gcc-13.2.0
arm                           sama7_defconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240704   gcc-13.2.0
arm64                 randconfig-001-20240705   gcc-13.2.0
arm64                 randconfig-002-20240704   gcc-13.2.0
arm64                 randconfig-002-20240705   gcc-13.2.0
arm64                 randconfig-003-20240704   gcc-13.2.0
arm64                 randconfig-003-20240705   gcc-13.2.0
arm64                 randconfig-004-20240704   gcc-13.2.0
arm64                 randconfig-004-20240705   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240704   gcc-13.2.0
csky                  randconfig-001-20240705   gcc-13.2.0
csky                  randconfig-002-20240704   gcc-13.2.0
csky                  randconfig-002-20240705   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240704   clang-18
i386         buildonly-randconfig-001-20240705   gcc-13
i386         buildonly-randconfig-002-20240704   clang-18
i386         buildonly-randconfig-002-20240704   gcc-13
i386         buildonly-randconfig-002-20240705   gcc-13
i386         buildonly-randconfig-003-20240704   clang-18
i386         buildonly-randconfig-003-20240704   gcc-13
i386         buildonly-randconfig-003-20240705   gcc-13
i386         buildonly-randconfig-004-20240704   clang-18
i386         buildonly-randconfig-004-20240704   gcc-12
i386         buildonly-randconfig-004-20240705   gcc-13
i386         buildonly-randconfig-005-20240704   clang-18
i386         buildonly-randconfig-005-20240704   gcc-12
i386         buildonly-randconfig-005-20240705   gcc-13
i386         buildonly-randconfig-006-20240704   clang-18
i386         buildonly-randconfig-006-20240704   gcc-12
i386         buildonly-randconfig-006-20240705   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240704   clang-18
i386                  randconfig-001-20240705   gcc-13
i386                  randconfig-002-20240704   clang-18
i386                  randconfig-002-20240704   gcc-13
i386                  randconfig-002-20240705   gcc-13
i386                  randconfig-003-20240704   clang-18
i386                  randconfig-003-20240705   gcc-13
i386                  randconfig-004-20240704   clang-18
i386                  randconfig-004-20240704   gcc-13
i386                  randconfig-004-20240705   gcc-13
i386                  randconfig-005-20240704   clang-18
i386                  randconfig-005-20240705   gcc-13
i386                  randconfig-006-20240704   clang-18
i386                  randconfig-006-20240704   gcc-12
i386                  randconfig-006-20240705   gcc-13
i386                  randconfig-011-20240704   clang-18
i386                  randconfig-011-20240704   gcc-13
i386                  randconfig-011-20240705   gcc-13
i386                  randconfig-012-20240704   clang-18
i386                  randconfig-012-20240705   gcc-13
i386                  randconfig-013-20240704   clang-18
i386                  randconfig-013-20240705   gcc-13
i386                  randconfig-014-20240704   clang-18
i386                  randconfig-014-20240705   gcc-13
i386                  randconfig-015-20240704   clang-18
i386                  randconfig-015-20240705   gcc-13
i386                  randconfig-016-20240704   clang-18
i386                  randconfig-016-20240705   gcc-13
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch                 loongson3_defconfig   gcc-13.2.0
loongarch             randconfig-001-20240704   gcc-13.2.0
loongarch             randconfig-001-20240705   gcc-13.2.0
loongarch             randconfig-002-20240704   gcc-13.2.0
loongarch             randconfig-002-20240705   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                         apollo_defconfig   gcc-13.2.0
m68k                       bvme6000_defconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                        m5307c3_defconfig   gcc-13.2.0
m68k                        mvme16x_defconfig   gcc-13.2.0
microblaze                       alldefconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                         bigsur_defconfig   gcc-13.2.0
mips                      bmips_stb_defconfig   gcc-13.2.0
mips                     cu1830-neo_defconfig   gcc-13.2.0
mips                         db1xxx_defconfig   gcc-13.2.0
mips                 decstation_r4k_defconfig   gcc-13.2.0
mips                            gpr_defconfig   gcc-13.2.0
mips                           ip22_defconfig   gcc-13.2.0
mips                           ip27_defconfig   gcc-13.2.0
mips                  maltasmvp_eva_defconfig   gcc-13.2.0
mips                    maltaup_xpa_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240704   gcc-13.2.0
nios2                 randconfig-001-20240705   gcc-13.2.0
nios2                 randconfig-002-20240704   gcc-13.2.0
nios2                 randconfig-002-20240705   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
openrisc                  or1klitex_defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                generic-32bit_defconfig   gcc-13.2.0
parisc                randconfig-001-20240704   gcc-13.2.0
parisc                randconfig-001-20240705   gcc-13.2.0
parisc                randconfig-002-20240704   gcc-13.2.0
parisc                randconfig-002-20240705   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   gcc-13.2.0
powerpc                      chrp32_defconfig   gcc-13.2.0
powerpc                  iss476-smp_defconfig   gcc-13.2.0
powerpc                    mvme5100_defconfig   gcc-13.2.0
powerpc                         ps3_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240704   gcc-13.2.0
powerpc64             randconfig-001-20240704   gcc-13.2.0
powerpc64             randconfig-001-20240705   gcc-13.2.0
powerpc64             randconfig-002-20240704   gcc-13.2.0
powerpc64             randconfig-002-20240705   gcc-13.2.0
powerpc64             randconfig-003-20240704   gcc-13.2.0
powerpc64             randconfig-003-20240705   gcc-13.2.0
riscv                            allmodconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
riscv                 randconfig-001-20240704   gcc-13.2.0
riscv                 randconfig-001-20240705   gcc-13.2.0
riscv                 randconfig-002-20240704   gcc-13.2.0
riscv                 randconfig-002-20240705   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                          debug_defconfig   gcc-13.2.0
s390                                defconfig   gcc-13.2.0
s390                  randconfig-001-20240704   gcc-13.2.0
s390                  randconfig-001-20240705   gcc-13.2.0
s390                  randconfig-002-20240704   gcc-13.2.0
s390                  randconfig-002-20240705   gcc-13.2.0
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                         ap325rxa_defconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                             espt_defconfig   gcc-13.2.0
sh                     magicpanelr2_defconfig   gcc-13.2.0
sh                            migor_defconfig   gcc-13.2.0
sh                    randconfig-001-20240704   gcc-13.2.0
sh                    randconfig-001-20240705   gcc-13.2.0
sh                    randconfig-002-20240704   gcc-13.2.0
sh                    randconfig-002-20240705   gcc-13.2.0
sh                          sdk7786_defconfig   gcc-13.2.0
sh                           se7206_defconfig   gcc-13.2.0
sh                           se7343_defconfig   gcc-13.2.0
sh                           se7619_defconfig   gcc-13.2.0
sh                           se7712_defconfig   gcc-13.2.0
sh                           se7750_defconfig   gcc-13.2.0
sh                           sh2007_defconfig   gcc-13.2.0
sh                        sh7757lcr_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
sparc                       sparc64_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240704   gcc-13.2.0
sparc64               randconfig-001-20240705   gcc-13.2.0
sparc64               randconfig-002-20240704   gcc-13.2.0
sparc64               randconfig-002-20240705   gcc-13.2.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-13.2.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                    randconfig-001-20240704   gcc-13.2.0
um                    randconfig-001-20240705   gcc-13.2.0
um                    randconfig-002-20240704   gcc-13.2.0
um                    randconfig-002-20240705   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240704   clang-18
x86_64       buildonly-randconfig-001-20240705   gcc-7
x86_64       buildonly-randconfig-002-20240704   clang-18
x86_64       buildonly-randconfig-002-20240705   gcc-7
x86_64       buildonly-randconfig-003-20240704   clang-18
x86_64       buildonly-randconfig-003-20240705   gcc-7
x86_64       buildonly-randconfig-004-20240704   clang-18
x86_64       buildonly-randconfig-004-20240705   gcc-7
x86_64       buildonly-randconfig-005-20240704   clang-18
x86_64       buildonly-randconfig-005-20240705   gcc-7
x86_64       buildonly-randconfig-006-20240704   clang-18
x86_64       buildonly-randconfig-006-20240705   gcc-7
x86_64                              defconfig   clang-18
x86_64                randconfig-001-20240704   clang-18
x86_64                randconfig-001-20240705   gcc-7
x86_64                randconfig-002-20240704   clang-18
x86_64                randconfig-002-20240705   gcc-7
x86_64                randconfig-003-20240704   clang-18
x86_64                randconfig-003-20240705   gcc-7
x86_64                randconfig-004-20240704   clang-18
x86_64                randconfig-004-20240705   gcc-7
x86_64                randconfig-005-20240704   clang-18
x86_64                randconfig-005-20240705   gcc-7
x86_64                randconfig-006-20240704   clang-18
x86_64                randconfig-006-20240705   gcc-7
x86_64                randconfig-011-20240704   clang-18
x86_64                randconfig-011-20240705   gcc-7
x86_64                randconfig-012-20240704   clang-18
x86_64                randconfig-012-20240705   gcc-7
x86_64                randconfig-013-20240704   clang-18
x86_64                randconfig-013-20240705   gcc-7
x86_64                randconfig-014-20240704   clang-18
x86_64                randconfig-014-20240705   gcc-7
x86_64                randconfig-015-20240704   clang-18
x86_64                randconfig-015-20240705   gcc-7
x86_64                randconfig-016-20240704   clang-18
x86_64                randconfig-016-20240705   gcc-7
x86_64                randconfig-071-20240704   clang-18
x86_64                randconfig-071-20240705   gcc-7
x86_64                randconfig-072-20240704   clang-18
x86_64                randconfig-072-20240705   gcc-7
x86_64                randconfig-073-20240704   clang-18
x86_64                randconfig-073-20240705   gcc-7
x86_64                randconfig-074-20240704   clang-18
x86_64                randconfig-074-20240705   gcc-7
x86_64                randconfig-075-20240704   clang-18
x86_64                randconfig-075-20240705   gcc-7
x86_64                randconfig-076-20240704   clang-18
x86_64                randconfig-076-20240705   gcc-7
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240704   gcc-13.2.0
xtensa                randconfig-001-20240705   gcc-13.2.0
xtensa                randconfig-002-20240704   gcc-13.2.0
xtensa                randconfig-002-20240705   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

