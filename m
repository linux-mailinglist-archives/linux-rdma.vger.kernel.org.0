Return-Path: <linux-rdma+bounces-6772-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5269FEECD
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Dec 2024 11:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03B151623CB
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Dec 2024 10:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0121C192B85;
	Tue, 31 Dec 2024 10:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HlzmCyly"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D0C18FC90
	for <linux-rdma@vger.kernel.org>; Tue, 31 Dec 2024 10:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735641574; cv=none; b=r597ekngEuokQlcKzoDzrjFgPtVFpRRC6yik24aVbxkfgVFx6rDV0w0Q36N+rXVURtKV5jz7qucxhfxId4ldhuvZYa500vHv5S720AlaknQ6c8S8X220Ya7KH0Hty5Ms485FAr3A1DCwX15ijIyqOYCIh7h34vZu3FvPSj3vU7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735641574; c=relaxed/simple;
	bh=O6MMqvCmxSf6+sN6Mayar82EF4e1heX+qCqAf+lVVXU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BEyGxaPAWI2Z9rUEuoJ1bSz9/azAd96zHRh9DqcFJvHNECbqJETzps6yGIcuujK9bOuQR6k4zx6FSg7UPHJyj2Bozz8BLevfEEqwTvVSL+C4MX068TSY3ZDsiPG5EpxFyxPUph7e3WA7MCbyJgPEk0IFI+XyrExQjTwPgXZW5Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HlzmCyly; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735641573; x=1767177573;
  h=date:from:to:cc:subject:message-id;
  bh=O6MMqvCmxSf6+sN6Mayar82EF4e1heX+qCqAf+lVVXU=;
  b=HlzmCylyneGYcD+Y1Hd8B9ZYkpzyaHJChxun6r40qiHq516AVHK9Qfaj
   Y/Xp1TGCie4Y3xuo9nQLgxf+RmC8ehH2MiEUIiTrDl2ZOsvQhOBn/FisK
   B35GaQPW+tcXkZD70JHz4BWiWU0D8dY7yRW5j4i0djylsid/LMaZC0YSp
   Xl+9glVxMNsmjUXot3eMKA14JizoDff+qmKEYw/ZCfHMBkhyxvX65oTkv
   x+qTQM1U9iWKTyIjffzpMFAJ9szCAwiMrIUA09D9iEGtkqWsfZazPetSS
   OSkXpHBllAG31CWTptDy+a2pX9z7K+sWkfVLsmgzYc2WUaMZSKVQJAKwr
   Q==;
X-CSE-ConnectionGUID: KPhxWWfFQ4yUvtFxJs4hlw==
X-CSE-MsgGUID: Js0OZEPMSpiEp0LtFFpr9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11301"; a="38754398"
X-IronPort-AV: E=Sophos;i="6.12,279,1728975600"; 
   d="scan'208";a="38754398"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 02:39:32 -0800
X-CSE-ConnectionGUID: r52IRXQ+SzKgZjF9GscEnQ==
X-CSE-MsgGUID: E1NJ/1J6StSVb4x7W3Beig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,279,1728975600"; 
   d="scan'208";a="106001696"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 31 Dec 2024 02:39:30 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tSZeq-00074F-1F;
	Tue, 31 Dec 2024 10:39:28 +0000
Date: Tue, 31 Dec 2024 18:39:00 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 a6c346760a52afaf7d75991c16ee4d70d6270d06
Message-ID: <202412311854.EfLnTMys-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: a6c346760a52afaf7d75991c16ee4d70d6270d06  RDMA/erdma: Support create_ah/destroy_ah in non-sleepable contexts

elapsed time: 913m

configs tested: 140
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20241231    gcc-13.2.0
arc                   randconfig-002-20241231    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-20
arm                          gemini_defconfig    clang-20
arm                            qcom_defconfig    clang-17
arm                   randconfig-001-20241231    clang-19
arm                   randconfig-002-20241231    clang-17
arm                   randconfig-003-20241231    gcc-14.2.0
arm                   randconfig-004-20241231    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241231    clang-20
arm64                 randconfig-002-20241231    clang-20
arm64                 randconfig-003-20241231    gcc-14.2.0
arm64                 randconfig-004-20241231    clang-19
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241231    gcc-14.2.0
csky                  randconfig-002-20241231    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                             defconfig    clang-20
hexagon               randconfig-001-20241231    clang-20
hexagon               randconfig-002-20241231    clang-16
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241231    gcc-11
i386        buildonly-randconfig-002-20241231    clang-19
i386        buildonly-randconfig-003-20241231    clang-19
i386        buildonly-randconfig-004-20241231    clang-19
i386        buildonly-randconfig-005-20241231    gcc-12
i386        buildonly-randconfig-006-20241231    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    gcc-14.2.0
loongarch             randconfig-001-20241231    gcc-14.2.0
loongarch             randconfig-002-20241231    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                       m5475evb_defconfig    gcc-14.2.0
microblaze                       alldefconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
microblaze                      mmu_defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ip27_defconfig    gcc-14.2.0
mips                           ip30_defconfig    gcc-14.2.0
mips                      maltaaprp_defconfig    clang-20
mips                          rb532_defconfig    clang-17
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241231    gcc-14.2.0
nios2                 randconfig-002-20241231    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241231    gcc-14.2.0
parisc                randconfig-002-20241231    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                       ebony_defconfig    clang-18
powerpc                       holly_defconfig    clang-20
powerpc                      ppc6xx_defconfig    gcc-14.2.0
powerpc                         ps3_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241231    clang-15
powerpc               randconfig-002-20241231    clang-20
powerpc               randconfig-003-20241231    clang-15
powerpc64             randconfig-001-20241231    clang-20
powerpc64             randconfig-002-20241231    clang-19
powerpc64             randconfig-003-20241231    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                 randconfig-001-20241231    clang-20
riscv                 randconfig-002-20241231    clang-15
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20241231    gcc-14.2.0
s390                  randconfig-002-20241231    clang-16
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20241231    gcc-14.2.0
sh                    randconfig-002-20241231    gcc-14.2.0
sh                           sh2007_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241231    gcc-14.2.0
sparc                 randconfig-002-20241231    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241231    gcc-14.2.0
sparc64               randconfig-002-20241231    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241231    clang-20
um                    randconfig-002-20241231    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241231    clang-19
x86_64      buildonly-randconfig-002-20241231    gcc-12
x86_64      buildonly-randconfig-003-20241231    clang-19
x86_64      buildonly-randconfig-004-20241231    gcc-12
x86_64      buildonly-randconfig-005-20241231    clang-19
x86_64      buildonly-randconfig-006-20241231    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241231    gcc-14.2.0
xtensa                randconfig-002-20241231    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

