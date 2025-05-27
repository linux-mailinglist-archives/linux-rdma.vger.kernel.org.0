Return-Path: <linux-rdma+bounces-10768-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1446AC5A3C
	for <lists+linux-rdma@lfdr.de>; Tue, 27 May 2025 20:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B7E165A16
	for <lists+linux-rdma@lfdr.de>; Tue, 27 May 2025 18:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7981F561D;
	Tue, 27 May 2025 18:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BaHuHj4C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725FE1E2847
	for <linux-rdma@vger.kernel.org>; Tue, 27 May 2025 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748371705; cv=none; b=Wf6JlNdlgAkn2LZMKxgtd08U+VQFKMUHjIr/wQQLNnsQBE4OEJcaVrYwTYIZ0YcMdVdHg6Nf5qV5RU7iIs4SM9lVO+zGFSVv4RYoTP1oNiYic5D9HBLW14/cFEwtXtXqbkFaVRbej2XSPfe49mlN7TehXHfwan9w3CSQfOwwatg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748371705; c=relaxed/simple;
	bh=ewQQcswoqPhAikMJvG+HmV/301fVZzdLKrCZxbkv9Rk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TP3AbCTp+IZ6KkviVJy61TPauTWBaO8qfiNPU2zoUOPZXI2JvQ4P2G86Ta8VuAA3MtXOUN9pbTjIS8JAqpojFCZgBZqp4uWldrYvzPMJoWIK268XrlfoL9zd19X0QE/ioy0Eg6FYGteG+3tLxbzjlD1BkALXwZ4yBWLbEqlDDJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BaHuHj4C; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748371704; x=1779907704;
  h=date:from:to:cc:subject:message-id;
  bh=ewQQcswoqPhAikMJvG+HmV/301fVZzdLKrCZxbkv9Rk=;
  b=BaHuHj4CfPEFoRuL1APJM73aFvVWASQHVJ2nHqrLh9gF/8HxiV/4ladf
   0drM0/tgVRucXdedOQ2g87KZFTMx6eZvEoPVf8SnR9gV7irTs81DVnH25
   JXHukUj/jrMvPsVnRAadYLHaPv3yZw3UTYl4olYwQNUb2dKdSeB0U6J9u
   jHa+J0IXn+4XQ79zaefWtWkICOQOZlaUwXeuOx5EeDMiIQiAQNzz0G04q
   FDJDIxB1gsAi+T7tQrFvNQaY5qdwCIC65fLGDB6t8lKt0bOMKja/3lBHn
   kQlEJyU/C2rjSaSUzavOn6TUt6BE+8enHQJtLFbCIaDRZkWQ2UF+RDtsD
   Q==;
X-CSE-ConnectionGUID: xGKPSvK4TraNKH/V57kk9w==
X-CSE-MsgGUID: yYRbxDZeTYaBCsd05cidJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="61783079"
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; 
   d="scan'208";a="61783079"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 11:48:21 -0700
X-CSE-ConnectionGUID: xjrjDlNrQde1M0m8gdpNuQ==
X-CSE-MsgGUID: HipjYJvhQ96G//2H6EgpEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; 
   d="scan'208";a="142849109"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 27 May 2025 11:48:20 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uJzLV-000UuQ-0s;
	Tue, 27 May 2025 18:48:17 +0000
Date: Wed, 28 May 2025 02:47:37 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/for-testing] BUILD SUCCESS
 bbfadc699bfd194a326cc4f84acfe9a34373e0f6
Message-ID: <202505280227.9CScKDSf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/for-testing
branch HEAD: bbfadc699bfd194a326cc4f84acfe9a34373e0f6  Merge tag 'v6.15' into k.o/wip/for-testing

elapsed time: 1443m

configs tested: 141
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                            hsdk_defconfig    gcc-14.2.0
arc                   randconfig-001-20250527    gcc-10.5.0
arc                   randconfig-002-20250527    gcc-10.5.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-21
arm                       imx_v6_v7_defconfig    clang-16
arm                   milbeaut_m10v_defconfig    clang-19
arm                   randconfig-001-20250527    clang-21
arm                   randconfig-002-20250527    gcc-7.5.0
arm                   randconfig-003-20250527    clang-19
arm                   randconfig-004-20250527    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250527    gcc-8.5.0
arm64                 randconfig-002-20250527    gcc-8.5.0
arm64                 randconfig-003-20250527    clang-16
arm64                 randconfig-004-20250527    gcc-6.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250527    gcc-12.4.0
csky                  randconfig-002-20250527    gcc-12.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250527    clang-21
hexagon               randconfig-002-20250527    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250527    gcc-12
i386        buildonly-randconfig-002-20250527    clang-20
i386        buildonly-randconfig-003-20250527    clang-20
i386        buildonly-randconfig-004-20250527    clang-20
i386        buildonly-randconfig-005-20250527    gcc-11
i386        buildonly-randconfig-006-20250527    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250527    gcc-15.1.0
loongarch             randconfig-002-20250527    gcc-15.1.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         apollo_defconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ci20_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250527    gcc-14.2.0
nios2                 randconfig-002-20250527    gcc-10.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250527    gcc-9.3.0
parisc                randconfig-002-20250527    gcc-11.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                       ebony_defconfig    clang-21
powerpc                          g5_defconfig    gcc-14.2.0
powerpc                        icon_defconfig    gcc-14.2.0
powerpc                     mpc83xx_defconfig    clang-21
powerpc               randconfig-001-20250527    gcc-6.5.0
powerpc               randconfig-002-20250527    clang-18
powerpc               randconfig-003-20250527    gcc-8.5.0
powerpc64             randconfig-001-20250527    clang-21
powerpc64             randconfig-002-20250527    clang-21
powerpc64             randconfig-003-20250527    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250527    gcc-8.5.0
riscv                 randconfig-002-20250527    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250527    gcc-6.5.0
s390                  randconfig-002-20250527    gcc-9.3.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                          lboxre2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250527    gcc-10.5.0
sh                    randconfig-002-20250527    gcc-15.1.0
sh                             sh03_defconfig    gcc-14.2.0
sh                        sh7763rdp_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250527    gcc-11.5.0
sparc                 randconfig-002-20250527    gcc-7.5.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250527    gcc-5.5.0
sparc64               randconfig-002-20250527    gcc-7.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250527    clang-21
um                    randconfig-002-20250527    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250527    gcc-12
x86_64      buildonly-randconfig-002-20250527    clang-20
x86_64      buildonly-randconfig-003-20250527    gcc-12
x86_64      buildonly-randconfig-004-20250527    clang-20
x86_64      buildonly-randconfig-005-20250527    clang-20
x86_64      buildonly-randconfig-006-20250527    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                           alldefconfig    gcc-14.2.0
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  audio_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250527    gcc-9.3.0
xtensa                randconfig-002-20250527    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

