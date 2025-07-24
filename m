Return-Path: <linux-rdma+bounces-12454-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF8EB10131
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jul 2025 08:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEDD21C26F23
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jul 2025 06:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB9A224AF3;
	Thu, 24 Jul 2025 06:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CS82FNDi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121B2221FD4
	for <linux-rdma@vger.kernel.org>; Thu, 24 Jul 2025 06:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753340274; cv=none; b=eI4gjJOGz9mfF2qoMTjiecOM28shAtIFLMqIj6eNaU/n3TObaMN82+ELHMUaYnT1goAD0axcJJ3KFeL4SLX30UCMarA6nAiytIV3BZmZjq3EJgGIKs/rJt4D53LJl20O4zsh26H93AQF4uXtSCBlL6YVJZNedj9NChkxT4VxOY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753340274; c=relaxed/simple;
	bh=sreSprRAezsuQAno9dCMexuFgluqG3UoUzcfQcEfjJg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qp7S/EvRAiwO5PgrMLOhhfLHOH7nQ7CAo+gytzkzoUhcfCe1IvPuMBgcsUXYLJZwt1gz6CXs/g0H0ragRsC8cNVmDJQyyj5C45YOdmWGLnMjFnk+WSwD3nJBR6iOCm2Wkx6cnfcQ6HBS7gf4ybM6pYUvGKvSvVIcMXKKPKoKNMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CS82FNDi; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753340273; x=1784876273;
  h=date:from:to:cc:subject:message-id;
  bh=sreSprRAezsuQAno9dCMexuFgluqG3UoUzcfQcEfjJg=;
  b=CS82FNDiEUkk5tpRhCUp87gq0NNKP9vEAyvO0JlVQGgp5T0zEmg/Rmlq
   L/S8OZaP3HltRWemFNvnt1J5SjlDY3m3OLMfk83u7Wf0ghR8rsKyIb+IB
   vlhbL4TvU+A1+Yveuv3ttnLkI0aOJZ4xmUS8H7Id67+Il8J4ay3PhVjEF
   osrs6iHGex0NVuxSUxzFlzK3+c7l2IHus3Lv4Fs7EtFs9S83LAlshCdlj
   fx44G5UXrLR5qgp4wxmdUsJaI6etPNyxfgXFpcnUsxvlwfZBio5YxVHIR
   BxwSsLlY5hdaWpJHKqUsy32NjyEpFwlDwkqB+ZmiBms5k0AzlVVO7NbCS
   Q==;
X-CSE-ConnectionGUID: /Un3PlxxRrSFRS9bqYdgvQ==
X-CSE-MsgGUID: ggaGkt60RkmfUNwWewxIew==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="43256181"
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="43256181"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 23:57:52 -0700
X-CSE-ConnectionGUID: H0AcLSKuSb+M3fgpdEIIhQ==
X-CSE-MsgGUID: 5Q1gCNAyQx6LBACfvMnWLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="160538766"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 23 Jul 2025 23:57:51 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ueptk-000K9b-0m;
	Thu, 24 Jul 2025 06:57:48 +0000
Date: Thu, 24 Jul 2025 14:57:17 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 e1bed9a94da86a7c01b985c2e9a030207269cbc7
Message-ID: <202507241404.n1BJ1Dkf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: e1bed9a94da86a7c01b985c2e9a030207269cbc7  RDMA/mlx5: Add DMAH support for reg_user_mr/reg_user_dmabuf_mr

elapsed time: 1454m

configs tested: 165
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250723    gcc-8.5.0
arc                   randconfig-001-20250724    gcc-13.4.0
arc                   randconfig-002-20250723    gcc-9.5.0
arc                   randconfig-002-20250724    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                           omap1_defconfig    gcc-15.1.0
arm                   randconfig-001-20250723    gcc-13.4.0
arm                   randconfig-001-20250724    gcc-10.5.0
arm                   randconfig-002-20250723    gcc-13.4.0
arm                   randconfig-002-20250724    clang-22
arm                   randconfig-003-20250723    clang-16
arm                   randconfig-003-20250724    gcc-8.5.0
arm                   randconfig-004-20250723    clang-22
arm                   randconfig-004-20250724    gcc-12.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250723    clang-22
arm64                 randconfig-001-20250724    gcc-8.5.0
arm64                 randconfig-002-20250723    clang-16
arm64                 randconfig-002-20250724    clang-22
arm64                 randconfig-003-20250723    clang-16
arm64                 randconfig-003-20250724    gcc-13.4.0
arm64                 randconfig-004-20250723    clang-22
arm64                 randconfig-004-20250724    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250723    gcc-12.5.0
csky                  randconfig-001-20250724    gcc-13.4.0
csky                  randconfig-002-20250723    gcc-14.3.0
csky                  randconfig-002-20250724    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250723    clang-22
hexagon               randconfig-001-20250724    clang-22
hexagon               randconfig-002-20250723    clang-22
hexagon               randconfig-002-20250724    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20250723    clang-20
i386        buildonly-randconfig-001-20250724    gcc-12
i386        buildonly-randconfig-002-20250723    clang-20
i386        buildonly-randconfig-002-20250724    clang-20
i386        buildonly-randconfig-003-20250723    clang-20
i386        buildonly-randconfig-003-20250724    clang-20
i386        buildonly-randconfig-004-20250723    clang-20
i386        buildonly-randconfig-004-20250724    clang-20
i386        buildonly-randconfig-005-20250723    gcc-11
i386        buildonly-randconfig-005-20250724    clang-20
i386        buildonly-randconfig-006-20250723    clang-20
i386        buildonly-randconfig-006-20250724    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250723    gcc-15.1.0
loongarch             randconfig-001-20250724    clang-22
loongarch             randconfig-002-20250723    clang-22
loongarch             randconfig-002-20250724    gcc-13.4.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                        stmark2_defconfig    gcc-15.1.0
m68k                          sun3x_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                         3c120_defconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250723    gcc-8.5.0
nios2                 randconfig-001-20250724    gcc-11.5.0
nios2                 randconfig-002-20250723    gcc-11.5.0
nios2                 randconfig-002-20250724    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                 simple_smp_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250723    gcc-8.5.0
parisc                randconfig-001-20250724    gcc-14.3.0
parisc                randconfig-002-20250723    gcc-15.1.0
parisc                randconfig-002-20250724    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250723    gcc-10.5.0
powerpc               randconfig-001-20250724    clang-22
powerpc               randconfig-002-20250723    gcc-8.5.0
powerpc               randconfig-002-20250724    gcc-8.5.0
powerpc               randconfig-003-20250723    gcc-12.5.0
powerpc               randconfig-003-20250724    clang-22
powerpc                     tqm8541_defconfig    clang-22
powerpc64             randconfig-001-20250723    clang-22
powerpc64             randconfig-001-20250724    clang-22
powerpc64             randconfig-002-20250723    clang-22
powerpc64             randconfig-002-20250724    gcc-13.4.0
powerpc64             randconfig-003-20250723    clang-22
powerpc64             randconfig-003-20250724    gcc-15.1.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250723    gcc-9.5.0
riscv                 randconfig-001-20250724    gcc-13.4.0
riscv                 randconfig-002-20250723    clang-22
riscv                 randconfig-002-20250724    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250723    clang-22
s390                  randconfig-001-20250724    clang-22
s390                  randconfig-002-20250723    clang-20
s390                  randconfig-002-20250724    gcc-10.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250723    gcc-12.5.0
sh                    randconfig-001-20250724    gcc-13.4.0
sh                    randconfig-002-20250723    gcc-9.5.0
sh                    randconfig-002-20250724    gcc-15.1.0
sh                           se7722_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250723    gcc-8.5.0
sparc                 randconfig-001-20250724    gcc-15.1.0
sparc                 randconfig-002-20250723    gcc-8.5.0
sparc                 randconfig-002-20250724    gcc-8.5.0
sparc64               randconfig-001-20250723    gcc-12.5.0
sparc64               randconfig-001-20250724    gcc-8.5.0
sparc64               randconfig-002-20250723    gcc-14.3.0
sparc64               randconfig-002-20250724    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250723    gcc-12
um                    randconfig-001-20250724    clang-22
um                    randconfig-002-20250723    clang-22
um                    randconfig-002-20250724    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250723    gcc-12
x86_64      buildonly-randconfig-002-20250723    gcc-11
x86_64      buildonly-randconfig-003-20250723    gcc-11
x86_64      buildonly-randconfig-004-20250723    clang-20
x86_64      buildonly-randconfig-005-20250723    gcc-12
x86_64      buildonly-randconfig-006-20250723    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250723    gcc-13.4.0
xtensa                randconfig-001-20250724    gcc-12.5.0
xtensa                randconfig-002-20250723    gcc-10.5.0
xtensa                randconfig-002-20250724    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

