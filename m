Return-Path: <linux-rdma+bounces-2440-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCA78C3914
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 01:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7AB1F21713
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2024 23:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764EA58AA1;
	Sun, 12 May 2024 23:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OEzJMNOV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4076C53E30
	for <linux-rdma@vger.kernel.org>; Sun, 12 May 2024 23:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715554857; cv=none; b=gJTq5fPq8RCFgi2NIFK2d1jAAA+XRH6+g2050P6jXfNY42vMnYttNxNmy0KhzJYTwaMRV1KRiJVvVSOy4olaVVCTBYXKR50iGtPibKz9+wBKI3WRCZakB659FZblnK7q3+ZHASfZ3q4OEsXGrBtP8P6VJEkRbG6LxEb6WGvUOeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715554857; c=relaxed/simple;
	bh=HzgktSaVAANA2EdjW4tuIiDzueLpfHap9xOHGCMRdrc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QDF88VYQqJ+b68A6Rc8OP3EAX3xkKUfGZ3C9/cw0hWl7MzOC4LVPaQMsaxvrQpFUoegnlneQN6THYzKmWs3MniYg50tRT9c1adELEsMChhR/FUXT31mMPjtrtw5Ir+73rM5RF8+mDNrNVna0fSntrnX0bB5zoPX6+sIIfhLsmj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OEzJMNOV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715554855; x=1747090855;
  h=date:from:to:cc:subject:message-id;
  bh=HzgktSaVAANA2EdjW4tuIiDzueLpfHap9xOHGCMRdrc=;
  b=OEzJMNOVxxKLULHfIyPd+UBYzUZjAReaOmFokVVg9kpcKvoSkIaDOTq6
   URSEUylAYGvS62u6E/ETgfIai0tdls3YJ5M5o+BsJdSpGrpjEZVqyEHTn
   +ym065jUAj5BUx1oDZXjAJuzJsKHwgWaoC3LouF3zc+Ygk6QE2N7IorYE
   NDgPxOSaibk7HCeKTMIfUb+3UEEy8fzuISGF468XcfTzZI2y9E1f7sZSC
   G0hJrKh0B1IMyvqAMkXcGmdqBtggfh8GmjR3MZsEGX45Jhw3nExPAZbao
   +lvmXQeorZuA2VXIARqJ6WdrUzT4EWRSYfVKbo/CbqbJQy0UOoR7vv8uP
   A==;
X-CSE-ConnectionGUID: 3bZfZ85NS/uaFF+sdD5gFw==
X-CSE-MsgGUID: jdSn3sjQSHKOrxWKdDeBzg==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="28966839"
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="28966839"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 16:00:55 -0700
X-CSE-ConnectionGUID: tuiZrQhzTQ6unW1hHDYgyg==
X-CSE-MsgGUID: bV8If8/ARF2ifwFYZJmtKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="30726388"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 12 May 2024 16:00:54 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s6IBW-0009Gl-2j;
	Sun, 12 May 2024 23:00:50 +0000
Date: Mon, 13 May 2024 07:00:39 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 9c0731832d3b7420cbadba6a7f334363bc8dfb15
Message-ID: <202405130736.nQ90IWie-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 9c0731832d3b7420cbadba6a7f334363bc8dfb15  RDMA/cma: Fix kmemleak in rdma_core observed during blktests nvme/rdma use siw

elapsed time: 729m

configs tested: 160
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
arc                        nsimosci_defconfig   gcc  
arc                   randconfig-001-20240513   gcc  
arc                   randconfig-002-20240513   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            dove_defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                   randconfig-001-20240513   clang
arm                   randconfig-002-20240513   gcc  
arm                   randconfig-003-20240513   clang
arm                   randconfig-004-20240513   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240513   gcc  
arm64                 randconfig-002-20240513   gcc  
arm64                 randconfig-003-20240513   clang
arm64                 randconfig-004-20240513   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240513   gcc  
csky                  randconfig-002-20240513   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240513   clang
hexagon               randconfig-002-20240513   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240512   gcc  
i386         buildonly-randconfig-002-20240512   clang
i386         buildonly-randconfig-003-20240512   gcc  
i386         buildonly-randconfig-004-20240512   gcc  
i386         buildonly-randconfig-005-20240512   gcc  
i386         buildonly-randconfig-006-20240512   clang
i386                                defconfig   clang
i386                  randconfig-001-20240512   clang
i386                  randconfig-002-20240512   clang
i386                  randconfig-003-20240512   clang
i386                  randconfig-004-20240512   gcc  
i386                  randconfig-005-20240512   clang
i386                  randconfig-006-20240512   clang
i386                  randconfig-011-20240512   gcc  
i386                  randconfig-012-20240512   clang
i386                  randconfig-013-20240512   gcc  
i386                  randconfig-014-20240512   clang
i386                  randconfig-015-20240512   gcc  
i386                  randconfig-016-20240512   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20240513   gcc  
loongarch             randconfig-002-20240513   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   gcc  
mips                           ci20_defconfig   clang
mips                          rm200_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240513   gcc  
nios2                 randconfig-002-20240513   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                 linkstation_defconfig   clang
powerpc                 mpc832x_rdb_defconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv             nommu_k210_sdcard_defconfig   gcc  
s390                             alldefconfig   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240512   clang
x86_64       buildonly-randconfig-002-20240512   clang
x86_64       buildonly-randconfig-003-20240512   clang
x86_64       buildonly-randconfig-004-20240512   gcc  
x86_64       buildonly-randconfig-005-20240512   clang
x86_64       buildonly-randconfig-006-20240512   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240512   gcc  
x86_64                randconfig-002-20240512   gcc  
x86_64                randconfig-003-20240512   clang
x86_64                randconfig-004-20240512   gcc  
x86_64                randconfig-005-20240512   gcc  
x86_64                randconfig-006-20240512   gcc  
x86_64                randconfig-011-20240512   gcc  
x86_64                randconfig-012-20240512   gcc  
x86_64                randconfig-013-20240512   clang
x86_64                randconfig-014-20240512   gcc  
x86_64                randconfig-015-20240512   clang
x86_64                randconfig-016-20240512   clang
x86_64                randconfig-071-20240512   clang
x86_64                randconfig-072-20240512   gcc  
x86_64                randconfig-073-20240512   gcc  
x86_64                randconfig-074-20240512   clang
x86_64                randconfig-075-20240512   clang
x86_64                randconfig-076-20240512   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                       common_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

