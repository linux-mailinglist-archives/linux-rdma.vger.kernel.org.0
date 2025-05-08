Return-Path: <linux-rdma+bounces-10128-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2860AAF0B7
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 03:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B6A3A8C0A
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 01:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DC8433B3;
	Thu,  8 May 2025 01:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="akWhowp0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDFC34CDD
	for <linux-rdma@vger.kernel.org>; Thu,  8 May 2025 01:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746668730; cv=none; b=lZNuhMIz1QeWVqU5FLDvOqyENicoBRzkjNAp7GykFdBQ6O+H4XkFHaQr06Dn1DhRgAW2fVTxbwcR60EvfoULFAdtbavChdE2ZW8Rp99I0TsmPNcYE7SaTgGhKk8s4sMBfhkGepRsMWiT5g9ttzCIjY00iC2US4TZAPrcfXBkepQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746668730; c=relaxed/simple;
	bh=HDFCpGfJEFhRtKEyLpAji5/tWtplYidN5viT8Cf8eWU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=c2OzrgO6eksq/hI1sQ/132g6aHRHFNCza/R4nFLI23QBCGm0XTu4yaIPDnctja1wimqFoqaTDkZSlnOg9RNW0mJlSrrByA0pkZVhiMo3H4BcSPyJVSQY4hAmc68q6n9AMzlTbOeGzw4nFNmacr5PH1LpZgABwlrSbGcZ+MBn/yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=akWhowp0; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746668729; x=1778204729;
  h=date:from:to:cc:subject:message-id;
  bh=HDFCpGfJEFhRtKEyLpAji5/tWtplYidN5viT8Cf8eWU=;
  b=akWhowp0eJhFnG8JlsZ315pUuYr4Zk/y9lU4CiaAFUWIxpEcE6QdXlOL
   2W0Wkfq4tEm+W215sEtZpg31hLYvUzwTEcO8fMqa9T1Aa91o99Y06j925
   1qa3a9TQV5ZER0QwXb+gwzhbQNaHMkHVIf2kr4C7og7b5FCpoIK8yZkCd
   CuW2mw2WnJahBp0XacThiBNX3twJuzcIn7wBFva+pKguwBZ1xYXmnEnyA
   b/ZynDLKzm8InyRW3dRhBSjpXYvJF0BGC9+Dxo3chLt58iewS+Aox+Dzl
   P4AhIpT3nhHQCd/HVAkdf/KuzImQRKIBflKNzwCgXWtdWh8siOXRPhXlC
   A==;
X-CSE-ConnectionGUID: lQH90TbARJG8yYOBNVdmIg==
X-CSE-MsgGUID: EXy3qi6tT3uX4DaN5vevLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="59420497"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="59420497"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 18:45:28 -0700
X-CSE-ConnectionGUID: huu7doTuRWu3ikItjFphLA==
X-CSE-MsgGUID: xa5n6tS2Qfi9ztm/3RD6yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="141015073"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 May 2025 18:44:47 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCqJZ-0009Bg-1C;
	Thu, 08 May 2025 01:44:45 +0000
Date: Thu, 08 May 2025 09:44:16 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 3db60cf9b7da4ae35646c00d9241c44d2dd6caf8
Message-ID: <202505080909.ftOFambJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 3db60cf9b7da4ae35646c00d9241c44d2dd6caf8  IB/hfi1: Adjust fd->entry_to_rb allocation type

elapsed time: 13530m

configs tested: 186
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
arc                     nsimosci_hs_defconfig    gcc-14.2.0
arc                   randconfig-001-20250429    gcc-13.3.0
arc                   randconfig-001-20250430    gcc-14.2.0
arc                   randconfig-002-20250429    gcc-14.2.0
arc                   randconfig-002-20250430    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                     am200epdkit_defconfig    gcc-14.2.0
arm                                 defconfig    clang-21
arm                          ixp4xx_defconfig    gcc-14.2.0
arm                   milbeaut_m10v_defconfig    clang-19
arm                   randconfig-001-20250429    gcc-7.5.0
arm                   randconfig-001-20250430    gcc-10.5.0
arm                   randconfig-002-20250429    clang-20
arm                   randconfig-002-20250430    gcc-7.5.0
arm                   randconfig-003-20250429    gcc-10.5.0
arm                   randconfig-003-20250430    clang-21
arm                   randconfig-004-20250429    clang-21
arm                   randconfig-004-20250430    gcc-7.5.0
arm                           sama5_defconfig    gcc-14.2.0
arm                           sama7_defconfig    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250429    gcc-7.5.0
arm64                 randconfig-001-20250430    gcc-5.5.0
arm64                 randconfig-002-20250429    clang-21
arm64                 randconfig-002-20250430    clang-21
arm64                 randconfig-003-20250429    gcc-9.5.0
arm64                 randconfig-003-20250430    gcc-5.5.0
arm64                 randconfig-004-20250429    gcc-9.5.0
arm64                 randconfig-004-20250430    gcc-5.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250429    gcc-14.2.0
csky                  randconfig-001-20250430    gcc-14.2.0
csky                  randconfig-002-20250429    gcc-14.2.0
csky                  randconfig-002-20250430    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250429    clang-21
hexagon               randconfig-001-20250430    clang-21
hexagon               randconfig-002-20250429    clang-21
hexagon               randconfig-002-20250430    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250429    gcc-12
i386        buildonly-randconfig-001-20250430    gcc-12
i386        buildonly-randconfig-002-20250429    gcc-11
i386        buildonly-randconfig-002-20250430    gcc-12
i386        buildonly-randconfig-003-20250429    gcc-12
i386        buildonly-randconfig-003-20250430    gcc-12
i386        buildonly-randconfig-004-20250429    gcc-12
i386        buildonly-randconfig-004-20250430    gcc-12
i386        buildonly-randconfig-005-20250429    clang-20
i386        buildonly-randconfig-005-20250430    clang-20
i386        buildonly-randconfig-006-20250429    gcc-12
i386        buildonly-randconfig-006-20250430    clang-20
i386                                defconfig    clang-20
loongarch                        alldefconfig    gcc-14.2.0
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250429    gcc-14.2.0
loongarch             randconfig-001-20250430    gcc-14.2.0
loongarch             randconfig-002-20250429    gcc-13.3.0
loongarch             randconfig-002-20250430    gcc-13.3.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          amiga_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                       m5208evb_defconfig    gcc-14.2.0
m68k                        stmark2_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ip27_defconfig    gcc-14.2.0
mips                        maltaup_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250429    gcc-11.5.0
nios2                 randconfig-001-20250430    gcc-11.5.0
nios2                 randconfig-002-20250429    gcc-7.5.0
nios2                 randconfig-002-20250430    gcc-9.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           alldefconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250429    gcc-14.2.0
parisc                randconfig-001-20250430    gcc-14.2.0
parisc                randconfig-002-20250429    gcc-10.5.0
parisc                randconfig-002-20250430    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                        fsp2_defconfig    gcc-14.2.0
powerpc                   lite5200b_defconfig    clang-21
powerpc                   motionpro_defconfig    clang-21
powerpc                     mpc512x_defconfig    clang-21
powerpc                 mpc832x_rdb_defconfig    gcc-14.2.0
powerpc                 mpc834x_itx_defconfig    clang-16
powerpc                      ppc6xx_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250429    clang-21
powerpc               randconfig-001-20250430    clang-21
powerpc               randconfig-002-20250429    clang-21
powerpc               randconfig-002-20250430    gcc-9.3.0
powerpc               randconfig-003-20250429    clang-21
powerpc               randconfig-003-20250430    gcc-7.5.0
powerpc                     tqm8560_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250429    clang-21
powerpc64             randconfig-001-20250430    gcc-10.5.0
powerpc64             randconfig-002-20250429    clang-21
powerpc64             randconfig-002-20250430    gcc-10.5.0
powerpc64             randconfig-003-20250429    gcc-7.5.0
powerpc64             randconfig-003-20250430    gcc-5.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250429    gcc-14.2.0
riscv                 randconfig-002-20250429    clang-18
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250429    clang-21
s390                  randconfig-002-20250429    clang-17
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                ecovec24-romimage_defconfig    gcc-14.2.0
sh                          kfr2r09_defconfig    gcc-14.2.0
sh                    randconfig-001-20250429    gcc-5.5.0
sh                    randconfig-002-20250429    gcc-13.3.0
sh                          rsk7203_defconfig    gcc-14.2.0
sh                   rts7751r2dplus_defconfig    gcc-14.2.0
sh                           se7751_defconfig    gcc-14.2.0
sh                             sh03_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250429    gcc-12.4.0
sparc                 randconfig-002-20250429    gcc-10.3.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250429    gcc-12.4.0
sparc64               randconfig-002-20250429    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250429    clang-18
um                    randconfig-002-20250429    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250429    gcc-12
x86_64      buildonly-randconfig-002-20250429    gcc-12
x86_64      buildonly-randconfig-003-20250429    clang-20
x86_64      buildonly-randconfig-004-20250429    gcc-12
x86_64      buildonly-randconfig-005-20250429    clang-20
x86_64      buildonly-randconfig-006-20250429    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250429    gcc-14.2.0
xtensa                randconfig-002-20250429    gcc-8.5.0
xtensa                    xip_kc705_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

