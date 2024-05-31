Return-Path: <linux-rdma+bounces-2731-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBB48D634A
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 15:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87FF1F258F0
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 13:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04664158DBD;
	Fri, 31 May 2024 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XrWABjIQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E4B158DB2
	for <linux-rdma@vger.kernel.org>; Fri, 31 May 2024 13:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717162989; cv=none; b=gwKlFTJt2nKhlHW1awpzcoBfK2Pod0h7LhYvQUuexnatJlHzhboS+qZYVOfG9iKCGJcrcSyBRA+DVVigy5PNtGgrLtUYa3qEfJZKd7yThSAjjQI3ffqRz/xihBiCqsi744WToBB0Ty5Mh96P9+a8FRXFaxxpkl4vtAMfEkKyF4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717162989; c=relaxed/simple;
	bh=M5qVzCMz7m7L4N4hApQHsHA8RgwR9iowl4elc2huzdw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BUtUyOrMRHr5YCP8QbU7SQZ8I6DIowXzPBCMvAwALpsHxDkIQTEo16V5/nBbGl0EfCUHGLwCP7SIaPQjyUvHdB2kBcTt0QPrW81AHhvEo3+0h2gwcSZX7xwpIEgJXF8B45vw+2d7cS2SMyf4jjrdsQKrEF0sqWuxJ5nKRB5q8VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XrWABjIQ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717162988; x=1748698988;
  h=date:from:to:cc:subject:message-id;
  bh=M5qVzCMz7m7L4N4hApQHsHA8RgwR9iowl4elc2huzdw=;
  b=XrWABjIQ6TQwZEk2j8EwxoOkdvoJ/7T6NU3lPrCYQ2CMeDg2T1iImf/E
   pZZJrj7FVGHYQW8MLo5NlTMNEvcJzpXeGM5bBO4ieSVqAWgqz7H+S1JmH
   +/vY1NtEjCeAVdLNvdIyoFwfu3V2HmQ4yT3vydc7y6BB2r6C3GKP+pBc9
   EKz+tGOiXLV2RQb85k4JLcH+JIYTh9/kqNs2bMIeKP6//nTBIMEb6H0zz
   IWNPjbKNTJrRJXHReZDQW3dC/QC//mFODQHj23xIFKBBA/p6ksVUcRuOa
   qDOzIzYlvHel78B/jB+pIe5Mbxx+k7NPbu0rFa6RNU5ZPo/Ad70iL+oO0
   A==;
X-CSE-ConnectionGUID: vLCPT8B9RLSB5ugugurzOw==
X-CSE-MsgGUID: RqKz4gB/TEOr8S9A8MhbHg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="17536560"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="17536560"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:43:08 -0700
X-CSE-ConnectionGUID: d3PHyNePRJGOFbc8j1FsmQ==
X-CSE-MsgGUID: wSETeoVAT8Go43dcP06sPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="41241449"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 31 May 2024 06:43:05 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sD2X9-000H9B-1b;
	Fri, 31 May 2024 13:43:03 +0000
Date: Fri, 31 May 2024 21:42:19 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 2d0e7ba468eae365f3c4bc9266679e1f8dd405f0
Message-ID: <202405312116.9ev8AiR6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 2d0e7ba468eae365f3c4bc9266679e1f8dd405f0  RDMA/efa: Properly handle unexpected AQ completions

elapsed time: 1438m

configs tested: 212
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
arc                   randconfig-001-20240531   gcc  
arc                   randconfig-002-20240531   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          ep93xx_defconfig   clang
arm                          gemini_defconfig   clang
arm                      integrator_defconfig   clang
arm                      jornada720_defconfig   clang
arm                            mmp2_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                   randconfig-001-20240531   clang
arm                   randconfig-002-20240531   clang
arm                   randconfig-003-20240531   clang
arm                   randconfig-004-20240531   clang
arm                             rpc_defconfig   clang
arm                        vexpress_defconfig   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240531   clang
arm64                 randconfig-002-20240531   clang
arm64                 randconfig-003-20240531   gcc  
arm64                 randconfig-004-20240531   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240531   gcc  
csky                  randconfig-002-20240531   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240531   clang
hexagon               randconfig-002-20240531   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240530   gcc  
i386         buildonly-randconfig-001-20240531   clang
i386         buildonly-randconfig-002-20240530   gcc  
i386         buildonly-randconfig-002-20240531   gcc  
i386         buildonly-randconfig-003-20240530   clang
i386         buildonly-randconfig-003-20240531   gcc  
i386         buildonly-randconfig-004-20240530   clang
i386         buildonly-randconfig-004-20240531   clang
i386         buildonly-randconfig-005-20240530   clang
i386         buildonly-randconfig-005-20240531   gcc  
i386         buildonly-randconfig-006-20240530   clang
i386         buildonly-randconfig-006-20240531   clang
i386                                defconfig   clang
i386                  randconfig-001-20240530   gcc  
i386                  randconfig-001-20240531   gcc  
i386                  randconfig-002-20240530   clang
i386                  randconfig-002-20240531   clang
i386                  randconfig-003-20240530   gcc  
i386                  randconfig-003-20240531   clang
i386                  randconfig-004-20240530   clang
i386                  randconfig-004-20240531   gcc  
i386                  randconfig-005-20240530   gcc  
i386                  randconfig-005-20240531   clang
i386                  randconfig-006-20240530   gcc  
i386                  randconfig-006-20240531   clang
i386                  randconfig-011-20240530   clang
i386                  randconfig-011-20240531   clang
i386                  randconfig-012-20240530   gcc  
i386                  randconfig-012-20240531   gcc  
i386                  randconfig-013-20240530   clang
i386                  randconfig-013-20240531   gcc  
i386                  randconfig-014-20240530   clang
i386                  randconfig-014-20240531   clang
i386                  randconfig-015-20240530   gcc  
i386                  randconfig-015-20240531   gcc  
i386                  randconfig-016-20240530   clang
i386                  randconfig-016-20240531   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240531   gcc  
loongarch             randconfig-002-20240531   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   clang
mips                  decstation_64_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240531   gcc  
nios2                 randconfig-002-20240531   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240531   gcc  
parisc                randconfig-002-20240531   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      cm5200_defconfig   clang
powerpc                       ebony_defconfig   clang
powerpc                   motionpro_defconfig   clang
powerpc                  mpc866_ads_defconfig   clang
powerpc               randconfig-001-20240531   clang
powerpc               randconfig-002-20240531   clang
powerpc               randconfig-003-20240531   gcc  
powerpc                     sequoia_defconfig   clang
powerpc                  storcenter_defconfig   gcc  
powerpc64             randconfig-001-20240531   clang
powerpc64             randconfig-002-20240531   clang
powerpc64             randconfig-003-20240531   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240531   clang
riscv                 randconfig-002-20240531   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240531   gcc  
s390                  randconfig-002-20240531   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240531   gcc  
sh                    randconfig-002-20240531   gcc  
sh                           se7343_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240531   gcc  
sparc64               randconfig-002-20240531   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240531   gcc  
um                    randconfig-002-20240531   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240531   clang
x86_64       buildonly-randconfig-002-20240531   gcc  
x86_64       buildonly-randconfig-003-20240531   clang
x86_64       buildonly-randconfig-004-20240531   clang
x86_64       buildonly-randconfig-005-20240531   gcc  
x86_64       buildonly-randconfig-006-20240531   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240531   gcc  
x86_64                randconfig-002-20240531   clang
x86_64                randconfig-003-20240531   gcc  
x86_64                randconfig-004-20240531   gcc  
x86_64                randconfig-005-20240531   gcc  
x86_64                randconfig-006-20240531   gcc  
x86_64                randconfig-011-20240531   clang
x86_64                randconfig-012-20240531   gcc  
x86_64                randconfig-013-20240531   gcc  
x86_64                randconfig-014-20240531   clang
x86_64                randconfig-015-20240531   gcc  
x86_64                randconfig-016-20240531   gcc  
x86_64                randconfig-071-20240531   clang
x86_64                randconfig-072-20240531   gcc  
x86_64                randconfig-073-20240531   gcc  
x86_64                randconfig-074-20240531   gcc  
x86_64                randconfig-075-20240531   clang
x86_64                randconfig-076-20240531   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20240531   gcc  
xtensa                randconfig-002-20240531   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

