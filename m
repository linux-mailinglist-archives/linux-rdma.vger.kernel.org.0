Return-Path: <linux-rdma+bounces-5333-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89189961F1
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 10:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC56F1C2399F
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 08:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76950188012;
	Wed,  9 Oct 2024 08:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b9nVBksE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66650187FF2
	for <linux-rdma@vger.kernel.org>; Wed,  9 Oct 2024 08:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728461445; cv=none; b=BZohCuaPVLAPtE8wX0dlGBg+Hft62q57aIFYTcTr1VjIk/GVFvPTHF1xDQ72vX02OMR2T9KlmYt4UHOjbqJyyPJ07faNFFvXmUVc6Q7xb/rXu1EnbS37a79Z8eFekACZlB5xSqAv0kQIDbzZp5M61H5Nv7gKxvgwXdSXPODKosE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728461445; c=relaxed/simple;
	bh=eLfrh8lnv2bUJ+o2NEzeGcnXd1ZRVjgNGyEnmQTr9KM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QylBwKrwMIKTyJD1nAF534gQy/CSTLNKcs+G3kS2CZ3wECNxEbPBkluaYyhnVUmBXhs2b6vsZxt1J/V2MHBCE9WSg4q7BAJdKPzy60sUtWTs/4gw7vGnGV73hZrekWUtH8m8coGDyAlEpGHv9IFjmV+eMka5924M/EiTg6ZYYvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b9nVBksE; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728461443; x=1759997443;
  h=date:from:to:cc:subject:message-id;
  bh=eLfrh8lnv2bUJ+o2NEzeGcnXd1ZRVjgNGyEnmQTr9KM=;
  b=b9nVBksEpPAyhM71HQAF6hiwNgjoGYbXvQ9AE39/XJiG35EdTyvoNWmS
   nFNrQy4wBXVaEI2kGtqyy8o3XR69d8F3Vv+joYK6vLqLZufX1pqRFPDm5
   NB7T5Ow7dEKWCzUmehJwZbQUUKmklvT06+lTh2SzxM7IJhrWnVTmNI3D9
   3+X7mZMsqgVkNU/7VRpd8zyrqwvf4o1afTT9+Bm2Dxs4f4JUFTf7u2vwc
   d/WaiRXA2e5gK2tCu4gIHyRkZMuSDETfpQtuL7SsWyxxvu8PhWxWyn+Qx
   JxzaXENGAkJjgXfDai33KdFq+AMuLRpCsoiVMQvY6ZyI88ymP3WP0A8IC
   w==;
X-CSE-ConnectionGUID: o6FqkVoIQg2L1ppJnDwMXw==
X-CSE-MsgGUID: gbEKC09jRKKKvJFMT8PH8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="31528977"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="31528977"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 01:10:43 -0700
X-CSE-ConnectionGUID: gSzYnwG2SUKUFVqsVsFvlg==
X-CSE-MsgGUID: M4YV0vtmTniyHvSJcu2ldA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="80150066"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 09 Oct 2024 01:10:41 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syRmJ-0008z6-0i;
	Wed, 09 Oct 2024 08:10:39 +0000
Date: Wed, 09 Oct 2024 16:10:36 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 5069d7e202f640a36cf213a432296c85113a52f7
Message-ID: <202410091627.UM46SiBb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: 5069d7e202f640a36cf213a432296c85113a52f7  RDMA/core: Fix ENODEV error for iWARP test over vlan

elapsed time: 1116m

configs tested: 188
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                   randconfig-001-20241009    gcc-14.1.0
arc                   randconfig-002-20241009    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                       aspeed_g4_defconfig    clang-14
arm                                 defconfig    gcc-14.1.0
arm                          gemini_defconfig    clang-14
arm                          pxa910_defconfig    clang-14
arm                   randconfig-001-20241009    gcc-14.1.0
arm                   randconfig-002-20241009    gcc-14.1.0
arm                   randconfig-003-20241009    gcc-14.1.0
arm                   randconfig-004-20241009    gcc-14.1.0
arm                         wpcm450_defconfig    clang-14
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241009    gcc-14.1.0
arm64                 randconfig-002-20241009    gcc-14.1.0
arm64                 randconfig-003-20241009    gcc-14.1.0
arm64                 randconfig-004-20241009    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    clang-14
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241009    gcc-14.1.0
csky                  randconfig-002-20241009    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241009    gcc-14.1.0
hexagon               randconfig-002-20241009    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241009    clang-18
i386        buildonly-randconfig-002-20241009    clang-18
i386        buildonly-randconfig-002-20241009    gcc-12
i386        buildonly-randconfig-003-20241009    clang-18
i386        buildonly-randconfig-004-20241009    clang-18
i386        buildonly-randconfig-005-20241009    clang-18
i386        buildonly-randconfig-006-20241009    clang-18
i386        buildonly-randconfig-006-20241009    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20241009    clang-18
i386                  randconfig-002-20241009    clang-18
i386                  randconfig-003-20241009    clang-18
i386                  randconfig-003-20241009    gcc-12
i386                  randconfig-004-20241009    clang-18
i386                  randconfig-005-20241009    clang-18
i386                  randconfig-005-20241009    gcc-12
i386                  randconfig-006-20241009    clang-18
i386                  randconfig-011-20241009    clang-18
i386                  randconfig-012-20241009    clang-18
i386                  randconfig-013-20241009    clang-18
i386                  randconfig-014-20241009    clang-18
i386                  randconfig-014-20241009    gcc-12
i386                  randconfig-015-20241009    clang-18
i386                  randconfig-016-20241009    clang-18
i386                  randconfig-016-20241009    gcc-11
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241009    gcc-14.1.0
loongarch             randconfig-002-20241009    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                            q40_defconfig    clang-14
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                     decstation_defconfig    clang-14
mips                      maltaaprp_defconfig    clang-14
nios2                         10m50_defconfig    clang-14
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241009    gcc-14.1.0
nios2                 randconfig-002-20241009    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241009    gcc-14.1.0
parisc                randconfig-002-20241009    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
powerpc                        fsp2_defconfig    clang-14
powerpc                 mpc832x_rdb_defconfig    clang-14
powerpc                      pcm030_defconfig    clang-14
powerpc                      ppc64e_defconfig    clang-14
powerpc               randconfig-001-20241009    gcc-14.1.0
powerpc               randconfig-002-20241009    gcc-14.1.0
powerpc               randconfig-003-20241009    gcc-14.1.0
powerpc64             randconfig-001-20241009    gcc-14.1.0
powerpc64             randconfig-002-20241009    gcc-14.1.0
powerpc64             randconfig-003-20241009    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241009    gcc-14.1.0
riscv                 randconfig-002-20241009    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241009    gcc-14.1.0
s390                  randconfig-002-20241009    gcc-14.1.0
sh                               alldefconfig    clang-14
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                         ecovec24_defconfig    clang-14
sh                    randconfig-001-20241009    gcc-14.1.0
sh                    randconfig-002-20241009    gcc-14.1.0
sh                             sh03_defconfig    clang-14
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241009    gcc-14.1.0
sparc64               randconfig-002-20241009    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241009    gcc-14.1.0
um                    randconfig-002-20241009    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241009    clang-18
x86_64      buildonly-randconfig-002-20241009    clang-18
x86_64      buildonly-randconfig-003-20241009    clang-18
x86_64      buildonly-randconfig-004-20241009    clang-18
x86_64      buildonly-randconfig-005-20241009    clang-18
x86_64      buildonly-randconfig-006-20241009    clang-18
x86_64                              defconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241009    clang-18
x86_64                randconfig-002-20241009    clang-18
x86_64                randconfig-003-20241009    clang-18
x86_64                randconfig-004-20241009    clang-18
x86_64                randconfig-005-20241009    clang-18
x86_64                randconfig-006-20241009    clang-18
x86_64                randconfig-011-20241009    clang-18
x86_64                randconfig-012-20241009    clang-18
x86_64                randconfig-013-20241009    clang-18
x86_64                randconfig-014-20241009    clang-18
x86_64                randconfig-015-20241009    clang-18
x86_64                randconfig-016-20241009    clang-18
x86_64                randconfig-071-20241009    clang-18
x86_64                randconfig-072-20241009    clang-18
x86_64                randconfig-073-20241009    clang-18
x86_64                randconfig-074-20241009    clang-18
x86_64                randconfig-075-20241009    clang-18
x86_64                randconfig-076-20241009    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20241009    gcc-14.1.0
xtensa                randconfig-002-20241009    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

