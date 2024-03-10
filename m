Return-Path: <linux-rdma+bounces-1370-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC1A877937
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 00:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C0AB1F218E0
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Mar 2024 23:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A673BB22;
	Sun, 10 Mar 2024 23:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eenqKpQA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9705C3A8C1
	for <linux-rdma@vger.kernel.org>; Sun, 10 Mar 2024 23:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710114319; cv=none; b=e/B46Rmcyiu+nsXbtQvnRzON5qE+MhYpCYvD6WVjrFhMcdddFNxfyYJjehGtAqvSX6V1fjZ2KnAzF9lj41aezykqOpg+d7+mv6GDGux8gyTjyEE2Uu/7xZSd8tW7OmrdDh25yCA/L6XXDW/9jIg97h/ZgiQ9nj6gKeMCavub1cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710114319; c=relaxed/simple;
	bh=vDxSEAtILVtF2Ukqgt0MLaX+rzFYWOpzQpcItVQv1wM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DlgdHySW4AjfyJxSB5C8VlBQUzVTMl2A8ge2AflMlprDnte/RREOW9Y3znns9qoEpHi3x0MTLdiPjItw/9WcmHEFrHTfzJxrn8ncHUFzRl6PKgk3Y6RiXyVk+/Wmo/4k4SPlY2Tl2pj7o9VHiVb+X0wkPsZlLKM6I2sFylP/bQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eenqKpQA; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710114317; x=1741650317;
  h=date:from:to:cc:subject:message-id;
  bh=vDxSEAtILVtF2Ukqgt0MLaX+rzFYWOpzQpcItVQv1wM=;
  b=eenqKpQA+/PRD0EMtUdBK84DfCVbDJbox1niiPMFePToEc6r3sCehAZ4
   q4pHtMjqVKxdG5PTc/PAs0EXcpLfnP2jJd7pB9CdRTBe0Pi2M48z0syHD
   YcfSWIdtLM2qAoxHKecKA5kH6Ln/mnScwupZ71wKyB3pE5BdeCD6jJLp6
   4u/r6urcHLTAt/zoZYFZVTqakteTdrhmG2VRZRx9WVYz7jUc9isVbTFF9
   cSeiAnRwkPWJtNZe5RYwrVS9LN52zQz7GBHnO8dKHq2Uc28dLIgvg9Sw9
   p579r/ChWibvLN5fpkguttsOj0FhiEXNU6awGBgJVEErSqWNP4qGfahaZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4624367"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="4624367"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 16:45:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="11560880"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 10 Mar 2024 16:45:14 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rjSqt-0008iP-38;
	Sun, 10 Mar 2024 23:45:11 +0000
Date: Mon, 11 Mar 2024 07:44:23 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 96d9cbe2f2ff7abde021bac75eafaceabe9a51fa
Message-ID: <202403110718.LZGPiGfP-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 96d9cbe2f2ff7abde021bac75eafaceabe9a51fa  RDMA/cm: add timeout to cm_destroy_id wait

elapsed time: 726m

configs tested: 221
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
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240310   gcc  
arc                   randconfig-002-20240310   gcc  
arm                              alldefconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                                 defconfig   clang
arm                            qcom_defconfig   clang
arm                   randconfig-001-20240310   gcc  
arm                   randconfig-002-20240310   gcc  
arm                   randconfig-003-20240310   gcc  
arm                   randconfig-004-20240310   gcc  
arm                        shmobile_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240310   clang
arm64                 randconfig-002-20240310   gcc  
arm64                 randconfig-003-20240310   clang
arm64                 randconfig-004-20240310   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240310   gcc  
csky                  randconfig-002-20240310   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240310   clang
hexagon               randconfig-002-20240310   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240310   clang
i386         buildonly-randconfig-002-20240310   clang
i386         buildonly-randconfig-003-20240310   clang
i386         buildonly-randconfig-004-20240310   clang
i386         buildonly-randconfig-005-20240310   gcc  
i386         buildonly-randconfig-006-20240310   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240310   gcc  
i386                  randconfig-002-20240310   gcc  
i386                  randconfig-003-20240310   clang
i386                  randconfig-004-20240310   gcc  
i386                  randconfig-005-20240310   gcc  
i386                  randconfig-006-20240310   gcc  
i386                  randconfig-011-20240310   clang
i386                  randconfig-012-20240310   clang
i386                  randconfig-013-20240310   clang
i386                  randconfig-014-20240310   clang
i386                  randconfig-015-20240310   clang
i386                  randconfig-016-20240310   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240310   gcc  
loongarch             randconfig-002-20240310   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                            q40_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm63xx_defconfig   clang
mips                           gcw0_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240310   gcc  
nios2                 randconfig-002-20240310   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240310   gcc  
parisc                randconfig-002-20240310   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     ep8248e_defconfig   gcc  
powerpc                     ksi8560_defconfig   gcc  
powerpc                 mpc8315_rdb_defconfig   clang
powerpc               mpc834x_itxgp_defconfig   clang
powerpc                      pcm030_defconfig   clang
powerpc                     ppa8548_defconfig   gcc  
powerpc               randconfig-001-20240310   gcc  
powerpc               randconfig-002-20240310   clang
powerpc               randconfig-003-20240310   clang
powerpc                    socrates_defconfig   gcc  
powerpc                     tqm5200_defconfig   gcc  
powerpc64             randconfig-001-20240310   gcc  
powerpc64             randconfig-002-20240310   gcc  
powerpc64             randconfig-003-20240310   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20240310   gcc  
riscv                 randconfig-002-20240310   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240310   clang
s390                  randconfig-002-20240310   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                    randconfig-001-20240310   gcc  
sh                    randconfig-002-20240310   gcc  
sh                          urquell_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240310   gcc  
sparc64               randconfig-002-20240310   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240310   gcc  
um                    randconfig-002-20240310   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240310   clang
x86_64       buildonly-randconfig-001-20240311   clang
x86_64       buildonly-randconfig-002-20240310   gcc  
x86_64       buildonly-randconfig-002-20240311   clang
x86_64       buildonly-randconfig-003-20240310   clang
x86_64       buildonly-randconfig-003-20240311   clang
x86_64       buildonly-randconfig-004-20240310   gcc  
x86_64       buildonly-randconfig-004-20240311   gcc  
x86_64       buildonly-randconfig-005-20240310   clang
x86_64       buildonly-randconfig-005-20240311   clang
x86_64       buildonly-randconfig-006-20240310   gcc  
x86_64       buildonly-randconfig-006-20240311   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240310   clang
x86_64                randconfig-001-20240311   clang
x86_64                randconfig-002-20240310   gcc  
x86_64                randconfig-002-20240311   clang
x86_64                randconfig-003-20240310   gcc  
x86_64                randconfig-003-20240311   gcc  
x86_64                randconfig-004-20240310   gcc  
x86_64                randconfig-004-20240311   gcc  
x86_64                randconfig-005-20240310   clang
x86_64                randconfig-005-20240311   gcc  
x86_64                randconfig-006-20240310   gcc  
x86_64                randconfig-006-20240311   clang
x86_64                randconfig-011-20240310   gcc  
x86_64                randconfig-011-20240311   clang
x86_64                randconfig-012-20240310   clang
x86_64                randconfig-012-20240311   clang
x86_64                randconfig-013-20240310   clang
x86_64                randconfig-013-20240311   clang
x86_64                randconfig-014-20240310   gcc  
x86_64                randconfig-014-20240311   gcc  
x86_64                randconfig-015-20240310   clang
x86_64                randconfig-015-20240311   clang
x86_64                randconfig-016-20240310   gcc  
x86_64                randconfig-016-20240311   gcc  
x86_64                randconfig-071-20240310   gcc  
x86_64                randconfig-071-20240311   gcc  
x86_64                randconfig-072-20240310   gcc  
x86_64                randconfig-072-20240311   clang
x86_64                randconfig-073-20240310   gcc  
x86_64                randconfig-073-20240311   clang
x86_64                randconfig-074-20240310   gcc  
x86_64                randconfig-074-20240311   gcc  
x86_64                randconfig-075-20240310   clang
x86_64                randconfig-075-20240311   clang
x86_64                randconfig-076-20240310   gcc  
x86_64                randconfig-076-20240311   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                randconfig-001-20240310   gcc  
xtensa                randconfig-002-20240310   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

