Return-Path: <linux-rdma+bounces-1996-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD8B8AC239
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Apr 2024 02:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E4A1F214B8
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Apr 2024 00:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9E2184;
	Mon, 22 Apr 2024 00:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nCuUK1t6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B264B163
	for <linux-rdma@vger.kernel.org>; Mon, 22 Apr 2024 00:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713744527; cv=none; b=Wf40fOC33EjRhlH2xLNA2WALQek+RRz+31k00TjJE36zfYqcgU9/O85SANJbhS+17pnchW8Z4gV1I8UZKl1PbAYo10wkgVdkgdxq0EcRzXX35/m2DHTd8TIbdeEUS9nazsC/6lbuTRtBupaCFX9SBHS/+RSUPjppp7hBDlx3TQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713744527; c=relaxed/simple;
	bh=4BI2vUY6pY2UEYyg0InmwyAzw3sE/ZjLasiK5GjYGtI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=G+xE3FRf8GOoLkF4NCaQQJc38GrsnKOKoGqVHuSCmSg00CHhts1KFhV2msDmYIxMK+JYqtPSVCkY8506FKeZRQBIXhgPjddklwaL3ehVR7WSHf4zvcmcg/Ke7ym0Eh8WwXPuhQsuVUmQ4utW/wXdj/hKAdot0HP0u4LaBnT8XIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nCuUK1t6; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713744525; x=1745280525;
  h=date:from:to:cc:subject:message-id;
  bh=4BI2vUY6pY2UEYyg0InmwyAzw3sE/ZjLasiK5GjYGtI=;
  b=nCuUK1t6jsU2ltX8CgKpvegQGmPH6aPPmN0wwa4bYAhm+BR6vrSZPFeq
   sYEa0+mpy3rF+ZmLT63sKZPTD0XjY2RWwP2JUBpVxYrhGT++xczap8vZI
   ChT2aOaVsyoYm++izaennzo4RFKz2WNPQfKtjPf7kqpyQzf6ubM0g2KhA
   vbLzvbKbK0R1ArsjvL/l8DSMrsLqHDFZ0rJd+qauOTsgTY+P5yoQYg1+h
   J81grHQmQojPQTZBwdWumdzknR/1pUOSPMULovmL31D/3oObsCZgZ4vWJ
   ZQ7FYJr00ldRxzNSais8dg7TLEvo4Gp9w0h6HoLWjNIGTdLZWtriVcNaX
   Q==;
X-CSE-ConnectionGUID: TizcoRmASdO3QO7jOtc25w==
X-CSE-MsgGUID: AuloYOUtSH69t47IMfqgKg==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="9488533"
X-IronPort-AV: E=Sophos;i="6.07,219,1708416000"; 
   d="scan'208";a="9488533"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2024 17:08:44 -0700
X-CSE-ConnectionGUID: Yj+IKekKRDiQuUMNn+Hy1w==
X-CSE-MsgGUID: AzIoofSWQ9Ch46ZV87QqCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,219,1708416000"; 
   d="scan'208";a="24294158"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 21 Apr 2024 17:08:42 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ryhEd-000CEO-1x;
	Mon, 22 Apr 2024 00:08:39 +0000
Date: Mon, 22 Apr 2024 08:08:07 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 ca0b44e20a6f3032224599f02e7c8fb49525c894
Message-ID: <202404220804.Sy3Lf5Wr-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: ca0b44e20a6f3032224599f02e7c8fb49525c894  IB/core: Implement a limit on UMAD receive List

elapsed time: 726m

configs tested: 180
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
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20240421   gcc  
arc                   randconfig-002-20240421   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         bcm2835_defconfig   clang
arm                                 defconfig   clang
arm                           h3600_defconfig   gcc  
arm                         mv78xx0_defconfig   clang
arm                   randconfig-001-20240421   clang
arm                   randconfig-002-20240421   clang
arm                   randconfig-003-20240421   clang
arm                   randconfig-004-20240421   clang
arm                        shmobile_defconfig   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240421   gcc  
arm64                 randconfig-002-20240421   clang
arm64                 randconfig-003-20240421   gcc  
arm64                 randconfig-004-20240421   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240421   gcc  
csky                  randconfig-002-20240421   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240421   clang
hexagon               randconfig-002-20240421   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240421   clang
i386         buildonly-randconfig-002-20240421   clang
i386         buildonly-randconfig-003-20240421   clang
i386         buildonly-randconfig-004-20240421   gcc  
i386         buildonly-randconfig-005-20240421   clang
i386         buildonly-randconfig-006-20240421   clang
i386                                defconfig   clang
i386                  randconfig-001-20240421   clang
i386                  randconfig-002-20240421   clang
i386                  randconfig-003-20240421   gcc  
i386                  randconfig-004-20240421   clang
i386                  randconfig-005-20240421   clang
i386                  randconfig-006-20240421   clang
i386                  randconfig-011-20240421   clang
i386                  randconfig-012-20240421   gcc  
i386                  randconfig-013-20240421   gcc  
i386                  randconfig-014-20240421   clang
i386                  randconfig-015-20240421   gcc  
i386                  randconfig-016-20240421   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240421   gcc  
loongarch             randconfig-002-20240421   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        vocore2_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240421   gcc  
nios2                 randconfig-002-20240421   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240421   gcc  
parisc                randconfig-002-20240421   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc                     mpc512x_defconfig   clang
powerpc                 mpc8313_rdb_defconfig   gcc  
powerpc                 mpc8315_rdb_defconfig   clang
powerpc               randconfig-001-20240421   clang
powerpc               randconfig-002-20240421   clang
powerpc               randconfig-003-20240421   clang
powerpc                     stx_gp3_defconfig   clang
powerpc64             randconfig-001-20240421   clang
powerpc64             randconfig-002-20240421   gcc  
powerpc64             randconfig-003-20240421   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240421   clang
riscv                 randconfig-002-20240421   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240421   clang
s390                  randconfig-002-20240421   gcc  
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240421   gcc  
sh                    randconfig-002-20240421   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240421   gcc  
sparc64               randconfig-002-20240421   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240421   gcc  
um                    randconfig-002-20240421   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240421   clang
x86_64       buildonly-randconfig-002-20240421   clang
x86_64       buildonly-randconfig-003-20240421   gcc  
x86_64       buildonly-randconfig-004-20240421   clang
x86_64       buildonly-randconfig-005-20240421   clang
x86_64       buildonly-randconfig-006-20240421   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240421   gcc  
x86_64                randconfig-002-20240421   clang
x86_64                randconfig-003-20240421   gcc  
x86_64                randconfig-004-20240421   clang
x86_64                randconfig-005-20240421   gcc  
x86_64                randconfig-006-20240421   gcc  
x86_64                randconfig-011-20240421   clang
x86_64                randconfig-012-20240421   clang
x86_64                randconfig-013-20240421   clang
x86_64                randconfig-014-20240421   gcc  
x86_64                randconfig-015-20240421   clang
x86_64                randconfig-016-20240421   clang
x86_64                randconfig-071-20240421   clang
x86_64                randconfig-072-20240421   clang
x86_64                randconfig-073-20240421   clang
x86_64                randconfig-074-20240421   clang
x86_64                randconfig-075-20240421   gcc  
x86_64                randconfig-076-20240421   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                randconfig-001-20240421   gcc  
xtensa                randconfig-002-20240421   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

