Return-Path: <linux-rdma+bounces-11428-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D2DADEDEA
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jun 2025 15:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54B6317CBEF
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jun 2025 13:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626FE2DFF18;
	Wed, 18 Jun 2025 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eInTmTXQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA532E8DE1
	for <linux-rdma@vger.kernel.org>; Wed, 18 Jun 2025 13:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750253693; cv=none; b=l7AT82+K99MS2IkKgkcG0UW9FOmdRswC76GC/ayD6FyLhHv/j3EFMg+nkq3IVrYxB5URGKb96Ud3UuB3QRhZlIAsj4I5I9cEuVdMdIhXcFNMpcPsX6kxFoNtq4WgPVlZ+FlleVq/XWw5ZgYkqldnp2eyVz9ZoiWy8AGi5Xr+JN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750253693; c=relaxed/simple;
	bh=FQLp3Fx7YzIh6XBBgazY46lGRP1mK7mdIbCEGqIEUhQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UCNb98FZETu9UMr2qhuGdxHYoVsDoOff2uW1m7tsqmT/GEnLFziyNCNzLMh87OOWwEGF2cBt3LClIK/N3KUzLB+idr8XYjtOF48I8m36xtFZxB9IOAcemEfoSfMjI/5EGGlMvHWVB9Egq/5b5O2e+E6SfxKTW7kzcVWUn7axx0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eInTmTXQ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750253691; x=1781789691;
  h=date:from:to:cc:subject:message-id;
  bh=FQLp3Fx7YzIh6XBBgazY46lGRP1mK7mdIbCEGqIEUhQ=;
  b=eInTmTXQNZPj2fNUaEQCT2gJnRZV9e2WfYiid4gHp78INqBiygFAbejf
   ypPIs9PsPLWKXtB1aKwE2eOwyY+3xURZWaWUsy1Bo2hp8yDpnUIvijOgE
   gs+h5iOfmHogk4OWiKZezaaPay8iyIkM0H7JSBsTcqA8tg34ywQn0QVwq
   CdoSO6bcWzHMkwfO/RwFAqzmz3RoVXai7L9yrHd+eHE16QJGMm8BbQ0qz
   2qZhNK/qWRXhSQ5jT8KzbFf30xEhvcZnKb6vLVioIqK9awCNw4BAuP2NC
   rovq53uLmH0i1wIkSW31sT21vaMJZQeeRrZW5Kz3kwc0FZDB8GECyt8Md
   w==;
X-CSE-ConnectionGUID: HxbLgNFDQ6O7S6/56OUYLA==
X-CSE-MsgGUID: HV/I3OapTA+phHSRxbOVSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="56274021"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="56274021"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 06:34:50 -0700
X-CSE-ConnectionGUID: Pl7+qV6aR/iOREmr8KksHw==
X-CSE-MsgGUID: PLaxcs7wQoaERp0G4S8NEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="155372059"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 18 Jun 2025 06:34:48 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uRsw9-000JpG-31;
	Wed, 18 Jun 2025 13:34:45 +0000
Date: Wed, 18 Jun 2025 21:34:29 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 c036993721a3773f918d9a34bd706f72dc1628bf
Message-ID: <202506182118.G4h0IwJe-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: c036993721a3773f918d9a34bd706f72dc1628bf  Maintainers: Remove QIB

elapsed time: 1169m

configs tested: 216
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250618    gcc-11.5.0
arc                   randconfig-002-20250618    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                                 defconfig    gcc-15.1.0
arm                            hisi_defconfig    gcc-15.1.0
arm                         lpc32xx_defconfig    gcc-14.2.0
arm                        neponset_defconfig    gcc-15.1.0
arm                          pxa3xx_defconfig    gcc-15.1.0
arm                   randconfig-001-20250618    gcc-15.1.0
arm                   randconfig-002-20250618    gcc-10.5.0
arm                   randconfig-003-20250618    clang-21
arm                   randconfig-004-20250618    gcc-11.5.0
arm                       spear13xx_defconfig    gcc-15.1.0
arm                        vexpress_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250618    clang-21
arm64                 randconfig-002-20250618    clang-21
arm64                 randconfig-003-20250618    gcc-14.3.0
arm64                 randconfig-004-20250618    clang-16
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250618    gcc-13.3.0
csky                  randconfig-001-20250618    gcc-8.5.0
csky                  randconfig-002-20250618    gcc-15.1.0
csky                  randconfig-002-20250618    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20250618    clang-19
hexagon               randconfig-001-20250618    gcc-8.5.0
hexagon               randconfig-002-20250618    clang-16
hexagon               randconfig-002-20250618    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250618    clang-20
i386        buildonly-randconfig-002-20250618    clang-20
i386        buildonly-randconfig-002-20250618    gcc-12
i386        buildonly-randconfig-003-20250618    clang-20
i386        buildonly-randconfig-004-20250618    clang-20
i386        buildonly-randconfig-005-20250618    clang-20
i386        buildonly-randconfig-006-20250618    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250618    gcc-12
i386                  randconfig-002-20250618    gcc-12
i386                  randconfig-003-20250618    gcc-12
i386                  randconfig-004-20250618    gcc-12
i386                  randconfig-005-20250618    gcc-12
i386                  randconfig-006-20250618    gcc-12
i386                  randconfig-007-20250618    gcc-12
i386                  randconfig-011-20250618    gcc-12
i386                  randconfig-012-20250618    gcc-12
i386                  randconfig-013-20250618    gcc-12
i386                  randconfig-014-20250618    gcc-12
i386                  randconfig-015-20250618    gcc-12
i386                  randconfig-016-20250618    gcc-12
i386                  randconfig-017-20250618    gcc-12
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250618    gcc-15.1.0
loongarch             randconfig-001-20250618    gcc-8.5.0
loongarch             randconfig-002-20250618    gcc-15.1.0
loongarch             randconfig-002-20250618    gcc-8.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                       m5208evb_defconfig    gcc-15.1.0
m68k                          sun3x_defconfig    gcc-15.1.0
microblaze                       alldefconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                         db1xxx_defconfig    gcc-15.1.0
mips                           ip30_defconfig    gcc-14.2.0
nios2                            alldefconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250618    gcc-11.5.0
nios2                 randconfig-001-20250618    gcc-8.5.0
nios2                 randconfig-002-20250618    gcc-8.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
openrisc                       virt_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250618    gcc-10.5.0
parisc                randconfig-001-20250618    gcc-8.5.0
parisc                randconfig-002-20250618    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      arches_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250618    gcc-8.5.0
powerpc               randconfig-002-20250618    clang-19
powerpc               randconfig-002-20250618    gcc-8.5.0
powerpc               randconfig-003-20250618    clang-21
powerpc               randconfig-003-20250618    gcc-8.5.0
powerpc                     tqm8560_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250618    gcc-8.5.0
powerpc64             randconfig-002-20250618    clang-21
powerpc64             randconfig-002-20250618    gcc-8.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    gcc-14.2.0
riscv                 randconfig-001-20250618    clang-20
riscv                 randconfig-001-20250618    gcc-15.1.0
riscv                 randconfig-002-20250618    clang-21
riscv                 randconfig-002-20250618    gcc-15.1.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250618    gcc-15.1.0
s390                  randconfig-001-20250618    gcc-8.5.0
s390                  randconfig-002-20250618    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250618    gcc-15.1.0
sh                    randconfig-002-20250618    gcc-15.1.0
sh                          sdk7780_defconfig    gcc-15.1.0
sh                           se7724_defconfig    gcc-15.1.0
sh                           sh2007_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250618    gcc-15.1.0
sparc                 randconfig-001-20250618    gcc-8.5.0
sparc                 randconfig-002-20250618    gcc-13.3.0
sparc                 randconfig-002-20250618    gcc-15.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250618    gcc-13.3.0
sparc64               randconfig-001-20250618    gcc-15.1.0
sparc64               randconfig-002-20250618    gcc-15.1.0
sparc64               randconfig-002-20250618    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250618    clang-21
um                    randconfig-001-20250618    gcc-15.1.0
um                    randconfig-002-20250618    clang-21
um                    randconfig-002-20250618    gcc-15.1.0
um                           x86_64_defconfig    gcc-12
um                           x86_64_defconfig    gcc-14.2.0
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250618    clang-20
x86_64      buildonly-randconfig-001-20250618    gcc-12
x86_64      buildonly-randconfig-002-20250618    clang-20
x86_64      buildonly-randconfig-002-20250618    gcc-12
x86_64      buildonly-randconfig-003-20250618    gcc-12
x86_64      buildonly-randconfig-004-20250618    clang-20
x86_64      buildonly-randconfig-004-20250618    gcc-12
x86_64      buildonly-randconfig-005-20250618    clang-20
x86_64      buildonly-randconfig-005-20250618    gcc-12
x86_64      buildonly-randconfig-006-20250618    gcc-12
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250618    gcc-12
x86_64                randconfig-002-20250618    gcc-12
x86_64                randconfig-003-20250618    gcc-12
x86_64                randconfig-004-20250618    gcc-12
x86_64                randconfig-005-20250618    gcc-12
x86_64                randconfig-006-20250618    gcc-12
x86_64                randconfig-007-20250618    gcc-12
x86_64                randconfig-008-20250618    gcc-12
x86_64                randconfig-071-20250618    clang-20
x86_64                randconfig-072-20250618    clang-20
x86_64                randconfig-073-20250618    clang-20
x86_64                randconfig-074-20250618    clang-20
x86_64                randconfig-075-20250618    clang-20
x86_64                randconfig-076-20250618    clang-20
x86_64                randconfig-077-20250618    clang-20
x86_64                randconfig-078-20250618    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250618    gcc-13.3.0
xtensa                randconfig-001-20250618    gcc-15.1.0
xtensa                randconfig-002-20250618    gcc-11.5.0
xtensa                randconfig-002-20250618    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

