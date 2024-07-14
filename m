Return-Path: <linux-rdma+bounces-3862-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C4F930BB7
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jul 2024 23:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30ED9B20D9D
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jul 2024 21:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EFA39FFB;
	Sun, 14 Jul 2024 21:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HSuLSAA7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D29410A11
	for <linux-rdma@vger.kernel.org>; Sun, 14 Jul 2024 21:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720992093; cv=none; b=Rfzl0NPXT+i7ef/nGuGqwCBW/VUF4iUKkI/ktvfAuMTN1CdcnjG/CLdJeQGGRwe9iQzZCjjovbZzCI8+HNH/daK9f300SGaWMSlxXW3HvM8fAhQIvmWItP124I6ZB3K9CWgFIak28omUV7f1llyburA9geDEeVvHfJkIF7YtWC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720992093; c=relaxed/simple;
	bh=ywGuH+vfHoxNWf61Dtg5Z+l+YJ4Y0hcWOtw3Wbff7ag=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UNdmaB+LiQgb88cVpotpVdKYs5wkbzPfPfZNjBRNTP/3AQFOPjqds4MTKrjOlhxEdeK302DVPJ0TyCS6mRFBdgK6pRVAwAp4imbSXOQMMXPTjdT6wkan3FSK8hZrz3PJCDjK5tvDAZidXpKAMVQmOrJX/PMyou3BHKqLXwzKWZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HSuLSAA7; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720992091; x=1752528091;
  h=date:from:to:cc:subject:message-id;
  bh=ywGuH+vfHoxNWf61Dtg5Z+l+YJ4Y0hcWOtw3Wbff7ag=;
  b=HSuLSAA7jZ7WyR/9k08EiCV9mHZubXETvuiq1TdZfuj+FGc+wwmD80mu
   s2ydWRfjuFYD/7yOrfGHVXRqPMDgsrPCeGQY0yoaCPqzY2qOsF0aQy9F4
   4WvZqHGLK4ezCuRMOrZ3FvpzSBgepLO8HooWlCBkWgR4xCEzRcyhpkfDP
   EisTGDUzmcWB8pHoXUMxS5r2ArBUwCt7pR4WFNKPFP7Dxy9BtVwYAPmbg
   ojQeNycLG5YP/D6KvUyVmUtunWWevS+iKFUFTx47ZMElfJpkowYkQfZua
   HnLqSPPxuE2kBPokt67ZeNJDdsOf1YU3GjYgzHIUtUtUj10fw700gohxh
   A==;
X-CSE-ConnectionGUID: MP+hg1oMQ2yezqMwOgBC5g==
X-CSE-MsgGUID: JEG7X2jbS9GkBJ4Ce2bp7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="18479939"
X-IronPort-AV: E=Sophos;i="6.09,208,1716274800"; 
   d="scan'208";a="18479939"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2024 14:21:30 -0700
X-CSE-ConnectionGUID: q/RXn1zwTQ6sluSaot7aOg==
X-CSE-MsgGUID: mSDIDhsZSoaz6yRbqPU8BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,208,1716274800"; 
   d="scan'208";a="49507308"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 14 Jul 2024 14:21:27 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sT6er-000dk2-1X;
	Sun, 14 Jul 2024 21:21:25 +0000
Date: Mon, 15 Jul 2024 05:21:11 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 1df03a4b44146c4f720d793915747272c7773a3e
Message-ID: <202407150508.Ep8xXWbT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 1df03a4b44146c4f720d793915747272c7773a3e  RDMA/mana_ib: Set correct device into ib

elapsed time: 740m

configs tested: 196
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240714   gcc-13.2.0
arc                   randconfig-002-20240714   gcc-13.2.0
arc                           tb10x_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                   randconfig-001-20240714   clang-19
arm                   randconfig-002-20240714   clang-15
arm                   randconfig-003-20240714   clang-17
arm                   randconfig-004-20240714   clang-15
arm                           spitz_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240714   clang-15
arm64                 randconfig-002-20240714   clang-19
arm64                 randconfig-003-20240714   clang-19
arm64                 randconfig-004-20240714   gcc-14.1.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240714   gcc-14.1.0
csky                  randconfig-002-20240714   gcc-14.1.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240714   clang-19
hexagon               randconfig-002-20240714   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240714   gcc-13
i386         buildonly-randconfig-002-20240714   clang-18
i386         buildonly-randconfig-003-20240714   gcc-11
i386         buildonly-randconfig-004-20240714   clang-18
i386         buildonly-randconfig-005-20240714   gcc-9
i386         buildonly-randconfig-006-20240714   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240714   clang-18
i386                  randconfig-002-20240714   clang-18
i386                  randconfig-003-20240714   clang-18
i386                  randconfig-004-20240714   clang-18
i386                  randconfig-005-20240714   clang-18
i386                  randconfig-006-20240714   gcc-7
i386                  randconfig-011-20240714   clang-18
i386                  randconfig-012-20240714   gcc-13
i386                  randconfig-013-20240714   clang-18
i386                  randconfig-014-20240714   gcc-10
i386                  randconfig-015-20240714   gcc-13
i386                  randconfig-016-20240714   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240714   gcc-14.1.0
loongarch             randconfig-002-20240714   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                        m5407c3_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                           ci20_defconfig   gcc-13.2.0
mips                           gcw0_defconfig   gcc-13.2.0
mips                           ip27_defconfig   gcc-13.2.0
mips                         rt305x_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240714   gcc-14.1.0
nios2                 randconfig-002-20240714   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240714   gcc-14.1.0
parisc                randconfig-002-20240714   gcc-14.1.0
parisc64                         alldefconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc                     asp8347_defconfig   gcc-13.2.0
powerpc                      chrp32_defconfig   gcc-13.2.0
powerpc                  mpc866_ads_defconfig   gcc-13.2.0
powerpc                       ppc64_defconfig   gcc-13.2.0
powerpc                      ppc6xx_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240714   clang-19
powerpc               randconfig-002-20240714   clang-19
powerpc               randconfig-003-20240714   gcc-14.1.0
powerpc                    socrates_defconfig   gcc-13.2.0
powerpc                        warp_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240714   gcc-14.1.0
powerpc64             randconfig-002-20240714   gcc-14.1.0
powerpc64             randconfig-003-20240714   gcc-14.1.0
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                               defconfig   clang-19
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240714   clang-19
riscv                 randconfig-002-20240714   clang-15
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-19
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240714   clang-19
s390                  randconfig-002-20240714   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                         ecovec24_defconfig   gcc-13.2.0
sh                    randconfig-001-20240714   gcc-14.1.0
sh                    randconfig-002-20240714   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc32_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240714   gcc-14.1.0
sparc64               randconfig-002-20240714   gcc-14.1.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   clang-19
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-13
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240714   clang-19
um                    randconfig-002-20240714   clang-19
um                           x86_64_defconfig   clang-15
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240714   clang-18
x86_64       buildonly-randconfig-002-20240714   gcc-13
x86_64       buildonly-randconfig-003-20240714   gcc-13
x86_64       buildonly-randconfig-004-20240714   clang-18
x86_64       buildonly-randconfig-005-20240714   clang-18
x86_64       buildonly-randconfig-006-20240714   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240714   gcc-13
x86_64                randconfig-002-20240714   clang-18
x86_64                randconfig-003-20240714   gcc-13
x86_64                randconfig-004-20240714   clang-18
x86_64                randconfig-005-20240714   gcc-10
x86_64                randconfig-006-20240714   gcc-10
x86_64                randconfig-011-20240714   clang-18
x86_64                randconfig-012-20240714   gcc-7
x86_64                randconfig-013-20240714   clang-18
x86_64                randconfig-014-20240714   clang-18
x86_64                randconfig-015-20240714   gcc-13
x86_64                randconfig-016-20240714   clang-18
x86_64                randconfig-071-20240714   clang-18
x86_64                randconfig-072-20240714   gcc-13
x86_64                randconfig-073-20240714   clang-18
x86_64                randconfig-074-20240714   clang-18
x86_64                randconfig-075-20240714   clang-18
x86_64                randconfig-076-20240714   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240714   gcc-14.1.0
xtensa                randconfig-002-20240714   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

