Return-Path: <linux-rdma+bounces-7185-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4E1A19A3E
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2025 22:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A01D07A2C56
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2025 21:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBC01C5D4A;
	Wed, 22 Jan 2025 21:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZFOHGJ2j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F69B1C4A17
	for <linux-rdma@vger.kernel.org>; Wed, 22 Jan 2025 21:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737580639; cv=none; b=L1arOf9IbXKE38B/PhXbukmVnUnokoKxKZCNw8juqrIXT4GQuTdFhtjtp1+iE5cMmG4siVOxM3DzNtdUhJZTs2H/iTyc7k0Mdxy2a1XgtwBe8rIqQf/UVI2WFTDgZgza7i8C4S7Jy6Id3/V/evCUpvCm637q+McIR+UYQbk239w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737580639; c=relaxed/simple;
	bh=J5NUUeVdnRnHCtXRpWj2Twp+ySiOQjasOs8vU/gpJQ0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mlfF2uMlrmteHo5THXSu+vBR7t2GmEo+cqygAZfCoq9zRVQ9aJTkgZCFpngycmmzmHP0V31kLXukwK34THXNCQE/vvLNxBUs5AqgddW7X1JA0SLcbEgm7SQ8JyLLwdX7sMSlfBE0u2Bo7zlGjgIzRAzCjirFZ3x/bQwonKl7Oso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZFOHGJ2j; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737580638; x=1769116638;
  h=date:from:to:cc:subject:message-id;
  bh=J5NUUeVdnRnHCtXRpWj2Twp+ySiOQjasOs8vU/gpJQ0=;
  b=ZFOHGJ2j8wKnDJgCrdA9eo6JczmQ5q6t63SSfBkJM/CU0R+71YfHYn1I
   eKJT8b7dEoONOEFSlJYQYf6IVFoQu74UqXEhcr9x5Cz3Yp8B4I5gO2N8i
   PtMT5PEo6XXb8OdLDZfdog5VljBlYthfLQ+paGNSmrw+wArK156g5aAkc
   050o1vm1mrWxW3THeJLyOPICwwPhXyJsFdnjzmvf1JudLjXMt8Of5eomL
   nGBcOtr+JOcpweV0CdcsTqJM9lQbATKO/17nh0HKnJMmuw7XM/dDKZ396
   bJ+/paYGO4dKbDt9T2MOkh9VaZMpYwh2FRSLtI/8gPvNQT7tR8LjzHWG0
   A==;
X-CSE-ConnectionGUID: TmTEViRgT/e2kmOplTrZFw==
X-CSE-MsgGUID: PywgkXjNSDODtgBBn0jlHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="38224160"
X-IronPort-AV: E=Sophos;i="6.13,226,1732608000"; 
   d="scan'208";a="38224160"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 13:17:17 -0800
X-CSE-ConnectionGUID: rumbyQDySP+MWPPk4uGGSg==
X-CSE-MsgGUID: 6CeGJ/M2SCqfDLv7kYZ6GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="130557192"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 22 Jan 2025 13:17:05 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tai5u-000aJt-3C;
	Wed, 22 Jan 2025 21:17:02 +0000
Date: Thu, 23 Jan 2025 05:16:06 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 d3d930411ce390e532470194296658a960887773
Message-ID: <202501230500.qYMkBVtu-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: d3d930411ce390e532470194296658a960887773  RDMA/mlx5: Fix implicit ODP use after free

elapsed time: 1445m

configs tested: 111
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-14.2.0
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                        nsimosci_defconfig    gcc-13.2.0
arc                   randconfig-001-20250122    gcc-13.2.0
arc                   randconfig-002-20250122    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                        clps711x_defconfig    clang-19
arm                   randconfig-001-20250122    clang-19
arm                   randconfig-002-20250122    clang-20
arm                   randconfig-003-20250122    gcc-14.2.0
arm                   randconfig-004-20250122    gcc-14.2.0
arm                         socfpga_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250122    clang-20
arm64                 randconfig-002-20250122    clang-15
arm64                 randconfig-003-20250122    clang-20
arm64                 randconfig-004-20250122    clang-19
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250122    gcc-14.2.0
csky                  randconfig-001-20250123    gcc-14.2.0
csky                  randconfig-002-20250122    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20250122    clang-20
hexagon               randconfig-002-20250122    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250122    clang-19
i386        buildonly-randconfig-001-20250123    gcc-12
i386        buildonly-randconfig-002-20250122    gcc-12
i386        buildonly-randconfig-002-20250123    clang-19
i386        buildonly-randconfig-003-20250122    gcc-12
i386        buildonly-randconfig-003-20250123    gcc-12
i386        buildonly-randconfig-004-20250122    clang-19
i386        buildonly-randconfig-004-20250123    clang-19
i386        buildonly-randconfig-005-20250122    clang-19
i386        buildonly-randconfig-005-20250123    gcc-12
i386        buildonly-randconfig-006-20250122    clang-19
i386        buildonly-randconfig-006-20250123    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250122    gcc-14.2.0
loongarch             randconfig-002-20250122    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
mips                           ip32_defconfig    clang-20
nios2                 randconfig-001-20250122    gcc-14.2.0
nios2                 randconfig-002-20250122    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                generic-32bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20250122    gcc-14.2.0
parisc                randconfig-002-20250122    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc               randconfig-001-20250122    gcc-14.2.0
powerpc               randconfig-002-20250122    clang-17
powerpc               randconfig-003-20250122    clang-15
powerpc64             randconfig-001-20250122    clang-20
powerpc64             randconfig-002-20250122    clang-19
powerpc64             randconfig-003-20250122    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                    nommu_k210_defconfig    clang-15
riscv                 randconfig-001-20250122    clang-20
riscv                 randconfig-002-20250122    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250122    clang-18
s390                  randconfig-002-20250122    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250122    gcc-14.2.0
sh                    randconfig-002-20250122    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                 randconfig-001-20250122    gcc-14.2.0
sparc                 randconfig-002-20250122    gcc-14.2.0
sparc64               randconfig-001-20250122    gcc-14.2.0
sparc64               randconfig-002-20250122    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250122    gcc-12
um                    randconfig-002-20250122    clang-20
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250122    gcc-12
x86_64      buildonly-randconfig-002-20250122    clang-19
x86_64      buildonly-randconfig-003-20250122    gcc-12
x86_64      buildonly-randconfig-004-20250122    gcc-12
x86_64      buildonly-randconfig-005-20250122    gcc-12
x86_64      buildonly-randconfig-006-20250122    clang-19
x86_64                              defconfig    gcc-11
xtensa                randconfig-001-20250122    gcc-14.2.0
xtensa                randconfig-002-20250122    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

