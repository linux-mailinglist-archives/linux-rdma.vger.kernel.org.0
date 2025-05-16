Return-Path: <linux-rdma+bounces-10375-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 937FDAB9A98
	for <lists+linux-rdma@lfdr.de>; Fri, 16 May 2025 12:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98FD51BA7AFB
	for <lists+linux-rdma@lfdr.de>; Fri, 16 May 2025 10:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB12F236445;
	Fri, 16 May 2025 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ha1Q3BWR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28098442C
	for <linux-rdma@vger.kernel.org>; Fri, 16 May 2025 10:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747392936; cv=none; b=PuJYILLGa8M6wHQVaKUQDA31VzQUisg5FTUyzEZpEb8bWEjRDO4483Bn8nViQqrccX3h5o6Xb9AZjKzJiXuhUJs6YMWmGYrKDFnMh2uHeIJm/3m8LCNlu7V3cN2ms93USAE2Bw13ySPe5ZKz/pJRtRnwFalF9gz9lXshY3B8Qo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747392936; c=relaxed/simple;
	bh=IKSqmvhfOVXASN60FO5mxsFo5S3i1QwVIIemA288FUk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YIOwht9a6A+bpi2dRKN3Ma10/wqqUlisBzdKBOkEZ94AeJ3tuPnymp8a55UzgUsutzbPuo25c399KCAYMf6wXkvnR8Y7btN/xg7JVBA2NjpG/r876FNtjQ7UpxngY4uZ0iPvA8RAkbyx7ORHOA9+jUuTXBmNPiAHKjzbjVDq4Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ha1Q3BWR; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747392934; x=1778928934;
  h=date:from:to:cc:subject:message-id;
  bh=IKSqmvhfOVXASN60FO5mxsFo5S3i1QwVIIemA288FUk=;
  b=ha1Q3BWRxPlUFR/dw9ntrRKQBFIakgaHnlEvOo2afXGNNRWATkYOe8gK
   l8jhjq0IeWWxiH+mn6dn4C/6Jjijd4hl7JEAW9vWhb5xFuRWY11Nuh4FI
   YQOSbqgXS9oMdQZC813Pc+TmsHMD8cG29jAu6sDP5rt5GoNTUQkvYOCOA
   fWed57m8v92txMAWL0go88ynZfsIR7cIWYo7ylpb0dcTFULKAUxYQ1MKS
   KUvdh/QwUMGaSsIMwEIT4X+DAym5XSZkJfoCZCXsqDV+6hNMrDmK1iUc1
   HFRz+F7SsJ6FgQ6MqTnRGkbVvt1XDC8+plX7B1TL+8OMzHcis3m9nt1EB
   w==;
X-CSE-ConnectionGUID: epLsbjOgR7eEWnGl9D87XQ==
X-CSE-MsgGUID: frXouJqESs2c9vjWpBbhLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="49429247"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="49429247"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 03:55:34 -0700
X-CSE-ConnectionGUID: tBHcKGW8RgaPsdEoV5X/Xw==
X-CSE-MsgGUID: +T9DCX+sQ5WxtGcyfyXqPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="139197224"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 16 May 2025 03:55:32 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uFsiw-000JGn-0M;
	Fri, 16 May 2025 10:55:30 +0000
Date: Fri, 16 May 2025 18:55:12 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/for-testing] BUILD SUCCESS
 7ae9a3715567b456210ec4f2b6ec0563f8847b66
Message-ID: <202505161802.ZZFQvk9D-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/for-testing
branch HEAD: 7ae9a3715567b456210ec4f2b6ec0563f8847b66  Merge tag 'v6.15-rc6' into k.o/wip/for-testing

elapsed time: 1236m

configs tested: 235
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                          axs101_defconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                         haps_hs_defconfig    gcc-14.2.0
arc                     haps_hs_smp_defconfig    gcc-14.2.0
arc                   randconfig-001-20250515    gcc-12.4.0
arc                   randconfig-001-20250516    gcc-13.3.0
arc                   randconfig-001-20250516    gcc-9.5.0
arc                   randconfig-002-20250515    gcc-14.2.0
arc                   randconfig-002-20250516    gcc-13.3.0
arc                   randconfig-002-20250516    gcc-9.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                                 defconfig    gcc-14.2.0
arm                       imx_v6_v7_defconfig    gcc-14.2.0
arm                           imxrt_defconfig    gcc-14.2.0
arm                      integrator_defconfig    clang-21
arm                         mv78xx0_defconfig    clang-19
arm                         orion5x_defconfig    clang-21
arm                   randconfig-001-20250515    clang-21
arm                   randconfig-001-20250516    gcc-7.5.0
arm                   randconfig-001-20250516    gcc-9.5.0
arm                   randconfig-002-20250515    gcc-8.5.0
arm                   randconfig-002-20250516    clang-21
arm                   randconfig-002-20250516    gcc-9.5.0
arm                   randconfig-003-20250515    gcc-8.5.0
arm                   randconfig-003-20250516    clang-21
arm                   randconfig-003-20250516    gcc-9.5.0
arm                   randconfig-004-20250515    clang-21
arm                   randconfig-004-20250516    clang-21
arm                   randconfig-004-20250516    gcc-9.5.0
arm                           sama5_defconfig    gcc-14.2.0
arm                           sama7_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250515    clang-21
arm64                 randconfig-001-20250516    gcc-9.5.0
arm64                 randconfig-002-20250515    clang-21
arm64                 randconfig-002-20250516    gcc-9.5.0
arm64                 randconfig-003-20250515    clang-20
arm64                 randconfig-003-20250516    gcc-5.5.0
arm64                 randconfig-003-20250516    gcc-9.5.0
arm64                 randconfig-004-20250515    gcc-6.5.0
arm64                 randconfig-004-20250516    gcc-9.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250516    gcc-14.2.0
csky                  randconfig-002-20250516    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250516    clang-19
hexagon               randconfig-002-20250516    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250515    gcc-11
i386        buildonly-randconfig-001-20250516    clang-20
i386        buildonly-randconfig-002-20250515    gcc-12
i386        buildonly-randconfig-002-20250516    gcc-12
i386        buildonly-randconfig-003-20250515    clang-20
i386        buildonly-randconfig-003-20250516    clang-20
i386        buildonly-randconfig-004-20250515    clang-20
i386        buildonly-randconfig-004-20250516    clang-20
i386        buildonly-randconfig-005-20250515    gcc-12
i386        buildonly-randconfig-005-20250516    clang-20
i386        buildonly-randconfig-006-20250515    gcc-11
i386        buildonly-randconfig-006-20250516    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250516    gcc-12
i386                  randconfig-002-20250516    gcc-12
i386                  randconfig-003-20250516    gcc-12
i386                  randconfig-004-20250516    gcc-12
i386                  randconfig-005-20250516    gcc-12
i386                  randconfig-006-20250516    gcc-12
i386                  randconfig-007-20250516    gcc-12
i386                  randconfig-011-20250516    gcc-12
i386                  randconfig-012-20250516    gcc-12
i386                  randconfig-013-20250516    gcc-12
i386                  randconfig-014-20250516    gcc-12
i386                  randconfig-015-20250516    gcc-12
i386                  randconfig-016-20250516    gcc-12
i386                  randconfig-017-20250516    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250516    gcc-14.2.0
loongarch             randconfig-002-20250516    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
microblaze                      mmu_defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm63xx_defconfig    gcc-14.2.0
mips                         bigsur_defconfig    gcc-14.2.0
mips                          eyeq5_defconfig    gcc-14.2.0
mips                   sb1250_swarm_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250516    gcc-13.3.0
nios2                 randconfig-002-20250516    gcc-13.3.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250516    gcc-10.5.0
parisc                randconfig-002-20250516    gcc-12.4.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    gcc-14.2.0
powerpc                   currituck_defconfig    gcc-14.2.0
powerpc                 mpc8313_rdb_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250516    gcc-5.5.0
powerpc               randconfig-002-20250516    gcc-5.5.0
powerpc               randconfig-003-20250516    clang-17
powerpc                     tqm8541_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250516    clang-21
powerpc64             randconfig-002-20250516    clang-21
powerpc64             randconfig-003-20250516    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    gcc-14.2.0
riscv                 randconfig-001-20250515    gcc-8.5.0
riscv                 randconfig-001-20250516    gcc-7.5.0
riscv                 randconfig-001-20250516    gcc-8.5.0
riscv                 randconfig-002-20250515    gcc-14.2.0
riscv                 randconfig-002-20250516    gcc-14.2.0
riscv                 randconfig-002-20250516    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250515    clang-21
s390                  randconfig-001-20250516    gcc-7.5.0
s390                  randconfig-001-20250516    gcc-8.5.0
s390                  randconfig-002-20250515    gcc-9.3.0
s390                  randconfig-002-20250516    gcc-7.5.0
s390                  randconfig-002-20250516    gcc-8.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                          polaris_defconfig    gcc-14.2.0
sh                    randconfig-001-20250515    gcc-14.2.0
sh                    randconfig-001-20250516    gcc-7.5.0
sh                    randconfig-001-20250516    gcc-8.5.0
sh                    randconfig-002-20250515    gcc-10.5.0
sh                    randconfig-002-20250516    gcc-8.5.0
sh                    randconfig-002-20250516    gcc-9.3.0
sh                           se7724_defconfig    gcc-14.2.0
sh                           se7780_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250515    gcc-6.5.0
sparc                 randconfig-001-20250516    gcc-8.5.0
sparc                 randconfig-002-20250515    gcc-10.3.0
sparc                 randconfig-002-20250516    gcc-8.5.0
sparc64               randconfig-001-20250515    gcc-9.3.0
sparc64               randconfig-001-20250516    gcc-12.4.0
sparc64               randconfig-001-20250516    gcc-8.5.0
sparc64               randconfig-002-20250515    gcc-9.3.0
sparc64               randconfig-002-20250516    gcc-14.2.0
sparc64               randconfig-002-20250516    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250515    gcc-12
um                    randconfig-001-20250516    clang-21
um                    randconfig-001-20250516    gcc-8.5.0
um                    randconfig-002-20250515    clang-21
um                    randconfig-002-20250516    gcc-12
um                    randconfig-002-20250516    gcc-8.5.0
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250516    clang-20
x86_64      buildonly-randconfig-001-20250516    gcc-12
x86_64      buildonly-randconfig-002-20250516    gcc-12
x86_64      buildonly-randconfig-003-20250516    clang-20
x86_64      buildonly-randconfig-003-20250516    gcc-12
x86_64      buildonly-randconfig-004-20250516    clang-20
x86_64      buildonly-randconfig-004-20250516    gcc-12
x86_64      buildonly-randconfig-005-20250516    gcc-12
x86_64      buildonly-randconfig-006-20250516    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250516    gcc-12
x86_64                randconfig-002-20250516    gcc-12
x86_64                randconfig-003-20250516    gcc-12
x86_64                randconfig-004-20250516    gcc-12
x86_64                randconfig-005-20250516    gcc-12
x86_64                randconfig-006-20250516    gcc-12
x86_64                randconfig-007-20250516    gcc-12
x86_64                randconfig-008-20250516    gcc-12
x86_64                randconfig-071-20250516    clang-20
x86_64                randconfig-072-20250516    clang-20
x86_64                randconfig-073-20250516    clang-20
x86_64                randconfig-074-20250516    clang-20
x86_64                randconfig-075-20250516    clang-20
x86_64                randconfig-076-20250516    clang-20
x86_64                randconfig-077-20250516    clang-20
x86_64                randconfig-078-20250516    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250515    gcc-14.2.0
xtensa                randconfig-001-20250516    gcc-10.5.0
xtensa                randconfig-001-20250516    gcc-8.5.0
xtensa                randconfig-002-20250515    gcc-13.3.0
xtensa                randconfig-002-20250516    gcc-10.5.0
xtensa                randconfig-002-20250516    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

