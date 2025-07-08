Return-Path: <linux-rdma+bounces-11956-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97601AFC3D7
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 09:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50F39189F8C1
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 07:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A1B256C8D;
	Tue,  8 Jul 2025 07:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MkQe5yxL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60B2188006
	for <linux-rdma@vger.kernel.org>; Tue,  8 Jul 2025 07:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751959051; cv=none; b=GIhimjqsvwMxTkaywLbHFAHqA/Z1obWKkYO1c6pPmbtXq+qw4Q+bw2SDC5cYlbWjCUOkeH2QrlKyzdLA90KTujzF8hYmzXxt3ZQWSPBsvkm9lB+vy0jUcF2o5bXN+W+vOK6h37ywlWWIX8KYx1zb8yva9cR8St/l/W1H1Ycpto8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751959051; c=relaxed/simple;
	bh=v74ALhTgT/SPN3+2U0gK5zPnNV/mSf/xLjJ1b6mbA9E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sNC7jqitoc/Te1lM2Olyj7Mh4AzQmbzQnqirstv2ZwD7uBWW8cuK7CAuZCCzahROGEZXGSNofURhMXCOTqU7UZIafjZC1YoHQgcU0VgHNyNrDYOgicvkBGJWAfA9kFBZXd6QORdbgCE8n4WDIcSNvgc7dh/E7XeadEJJSZlj+8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MkQe5yxL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751959050; x=1783495050;
  h=date:from:to:cc:subject:message-id;
  bh=v74ALhTgT/SPN3+2U0gK5zPnNV/mSf/xLjJ1b6mbA9E=;
  b=MkQe5yxLe/6H4t0RemebxwCDDzkB4mxmFbcu3DiOHiQKGPFu6EmGH6K4
   bZ1Hvpk9amYXh3jys5LYZyro0xxocmUz2uKKKBCQT92kjTyz68E94feU+
   a3sIa6tVwJxrzXd24g0vBurPdUi855yxr8hJeWMj7/DqLWtdmpuBFuskr
   iL6OIrcSTk6c0vKRxEPzh39sM9WGbo3uJ8vaEgy7AcLU6ll4luaEm5Qwt
   5a0ZLo6C69+IhBBD2qgZeDNZ0Uj8vPCKQ7zFnfJZmMhmWPkxMohzrzuIb
   wxcHClyJpTvBJYXdcraGzpTbU45Ri5Lv/r73KVLQEVXz+ZHHcw31QXAm/
   w==;
X-CSE-ConnectionGUID: V8fPeMxPSJ+GNbKO0yNppg==
X-CSE-MsgGUID: s1LonWbcQLy+BLitYS99sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54073147"
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="54073147"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 00:17:29 -0700
X-CSE-ConnectionGUID: m+wKMNwBR76jNtmSL9seog==
X-CSE-MsgGUID: spL8D4Z8TOqvoCMMTyWE4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="179092869"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 08 Jul 2025 00:17:27 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZ2Zx-00016p-1a;
	Tue, 08 Jul 2025 07:17:25 +0000
Date: Tue, 08 Jul 2025 15:16:27 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD REGRESSION
 f3b7a65ce551ee7800f759ec7e198ee5030243dc
Message-ID: <202507081512.KSQQpwWU-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: f3b7a65ce551ee7800f759ec7e198ee5030243dc  Merge branch 'mlx5-next' into wip/leon-for-next

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202507080725.bh7xrhpg-lkp@intel.com

    ERROR: modpost: "rdma_uattrs_has_raw_cap" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!

Error/Warning ids grouped by kconfigs:

recent_errors
`-- x86_64-buildonly-randconfig-004-20250708
    `-- ERROR:rdma_uattrs_has_raw_cap-drivers-infiniband-hw-mlx5-mlx5_ib.ko-undefined

elapsed time: 1209m

configs tested: 158
configs skipped: 3

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250707    gcc-15.1.0
arc                   randconfig-002-20250707    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250707    gcc-10.5.0
arm                   randconfig-002-20250707    gcc-11.5.0
arm                   randconfig-003-20250707    clang-21
arm                   randconfig-004-20250707    clang-21
arm                           sama5_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250707    gcc-8.5.0
arm64                 randconfig-002-20250707    gcc-11.5.0
arm64                 randconfig-003-20250707    gcc-12.3.0
arm64                 randconfig-004-20250707    gcc-14.3.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250707    gcc-15.1.0
csky                  randconfig-001-20250708    gcc-13.4.0
csky                  randconfig-002-20250707    gcc-12.4.0
csky                  randconfig-002-20250708    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250707    clang-21
hexagon               randconfig-001-20250708    clang-21
hexagon               randconfig-002-20250707    clang-21
hexagon               randconfig-002-20250708    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250707    gcc-12
i386        buildonly-randconfig-002-20250707    clang-20
i386        buildonly-randconfig-003-20250707    gcc-12
i386        buildonly-randconfig-004-20250707    gcc-12
i386        buildonly-randconfig-005-20250707    gcc-12
i386        buildonly-randconfig-006-20250707    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch                 loongson3_defconfig    clang-21
loongarch             randconfig-001-20250707    clang-21
loongarch             randconfig-001-20250708    clang-21
loongarch             randconfig-002-20250707    gcc-15.1.0
loongarch             randconfig-002-20250708    clang-21
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250707    gcc-10.5.0
nios2                 randconfig-001-20250708    gcc-8.5.0
nios2                 randconfig-002-20250707    gcc-12.4.0
nios2                 randconfig-002-20250708    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250707    gcc-8.5.0
parisc                randconfig-001-20250708    gcc-9.3.0
parisc                randconfig-002-20250707    gcc-15.1.0
parisc                randconfig-002-20250708    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                     ksi8560_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250707    gcc-8.5.0
powerpc               randconfig-001-20250708    gcc-8.5.0
powerpc               randconfig-002-20250707    clang-21
powerpc               randconfig-002-20250708    clang-19
powerpc               randconfig-003-20250707    gcc-8.5.0
powerpc               randconfig-003-20250708    clang-21
powerpc64             randconfig-001-20250707    gcc-8.5.0
powerpc64             randconfig-001-20250708    clang-21
powerpc64             randconfig-002-20250707    gcc-10.5.0
powerpc64             randconfig-002-20250708    clang-21
powerpc64             randconfig-003-20250707    clang-21
powerpc64             randconfig-003-20250708    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250707    clang-21
riscv                 randconfig-001-20250708    clang-16
riscv                 randconfig-002-20250707    clang-21
riscv                 randconfig-002-20250708    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250707    clang-21
s390                  randconfig-001-20250708    gcc-14.3.0
s390                  randconfig-002-20250707    gcc-11.5.0
s390                  randconfig-002-20250708    gcc-9.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250707    gcc-15.1.0
sh                    randconfig-001-20250708    gcc-11.5.0
sh                    randconfig-002-20250707    gcc-15.1.0
sh                    randconfig-002-20250708    gcc-15.1.0
sh                   rts7751r2dplus_defconfig    gcc-15.1.0
sh                           sh2007_defconfig    gcc-15.1.0
sh                   sh7770_generic_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250707    gcc-12.4.0
sparc                 randconfig-001-20250708    gcc-13.4.0
sparc                 randconfig-002-20250707    gcc-8.5.0
sparc                 randconfig-002-20250708    gcc-13.4.0
sparc                       sparc64_defconfig    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250707    clang-20
sparc64               randconfig-001-20250708    clang-21
sparc64               randconfig-002-20250707    gcc-15.1.0
sparc64               randconfig-002-20250708    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250707    gcc-12
um                    randconfig-001-20250708    clang-21
um                    randconfig-002-20250707    gcc-12
um                    randconfig-002-20250708    clang-17
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250707    gcc-12
x86_64      buildonly-randconfig-002-20250707    gcc-12
x86_64      buildonly-randconfig-003-20250707    gcc-12
x86_64      buildonly-randconfig-004-20250707    clang-20
x86_64      buildonly-randconfig-005-20250707    gcc-12
x86_64      buildonly-randconfig-006-20250707    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250707    gcc-12.4.0
xtensa                randconfig-001-20250708    gcc-8.5.0
xtensa                randconfig-002-20250707    gcc-8.5.0
xtensa                randconfig-002-20250708    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

