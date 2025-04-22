Return-Path: <linux-rdma+bounces-9668-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B49A9650D
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Apr 2025 11:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A90189CBD1
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Apr 2025 09:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0C0202F79;
	Tue, 22 Apr 2025 09:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ia75z+no"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357E2200BBC
	for <linux-rdma@vger.kernel.org>; Tue, 22 Apr 2025 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745315534; cv=none; b=YRzcyawIUAyYjrZnaqjcz6auu/gNlSw/XcifNbe6dW1DI0qY8iDuckISZrRAsMYTBOkqYXjaGjJUBm6lsgpiQeL2TnTwCwy+tyXYHChnZQQ+f1qyw57IcHOmGX0tkfeM7RK5iYHqf2mHtpYTkGZFv4UjqmyZuTT+atzqtv4DR+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745315534; c=relaxed/simple;
	bh=7HhsKQg2HiE//8y1pKYHdUfPA6bCwpZ3sNupScceYCY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pMcQHfISh0Yyyniyk8YSFyRzenudEvNnr1UDVT2V7VGT8E7QO7bJPeXmYohmFurbSGC4EgNj0gZCRdR4F87ii1/H8cqsyvymPbCKNMwzEDJi0m3aIRHa5SIahqfFBZbAUbarj04rSq0U7UQ2ji4CtwFXs5Ikz1K1PZxGDplzBZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ia75z+no; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745315533; x=1776851533;
  h=date:from:to:cc:subject:message-id;
  bh=7HhsKQg2HiE//8y1pKYHdUfPA6bCwpZ3sNupScceYCY=;
  b=Ia75z+nozHNNA0Ef1NGI8TWveN+yibbbEVDr1HUAyn7WtE2K1ocLNnLY
   m61TM03Q3ln9zZQcYQo2otJZZvjXFhTjXOjAgaR0/RtS2N5PWUZ5BevG1
   PnfIVE05Ey3EEPZ/es81V99rlYr8YMMfR23wc9HuEWP59dlEfTPYIVJw1
   Zl7oj8/pkcwGJp8GMbq28GOJAKt4+2L0VehHiG4jykW4/axzxGkSCE1tn
   1vcFdkCEcMsi92vBqob4ZMwVuH407SMQrvlzwBqCKYFymjkTfVm5DGA+Y
   GNIHIdHZPiR6nOds5xe1q5E6wf+rr43IeILqXs9j5bxUgFL82zTAGlQpq
   w==;
X-CSE-ConnectionGUID: iciWm0bHSiOrUtKy+LRiPQ==
X-CSE-MsgGUID: +sXLxOy3TGuVOmZ4SM0Dqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="72259503"
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="72259503"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 02:52:12 -0700
X-CSE-ConnectionGUID: Um8Tn4QFQCaS5Gpk5vTobQ==
X-CSE-MsgGUID: 7c4R0nw5Sfer6ay29k5KvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="131718357"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 22 Apr 2025 02:52:11 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u7AIS-0000on-0Q;
	Tue, 22 Apr 2025 09:52:08 +0000
Date: Tue, 22 Apr 2025 17:51:12 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 d85080df12f33ad42a452a9998b21813b29daf35
Message-ID: <202504221701.wUuCqHWE-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: d85080df12f33ad42a452a9998b21813b29daf35  RDMA/rxe: Remove unused rxe_run_task

elapsed time: 2487m

configs tested: 166
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                          axs103_defconfig    gcc-14.2.0
arc                      axs103_smp_defconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250421    gcc-11.5.0
arc                   randconfig-002-20250421    gcc-13.3.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                        clps711x_defconfig    clang-21
arm                                 defconfig    clang-21
arm                         lpc32xx_defconfig    clang-17
arm                          moxart_defconfig    gcc-14.2.0
arm                   randconfig-001-20250421    clang-21
arm                   randconfig-002-20250421    gcc-10.5.0
arm                   randconfig-003-20250421    gcc-6.5.0
arm                   randconfig-004-20250421    gcc-6.5.0
arm                           u8500_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250421    gcc-5.5.0
arm64                 randconfig-002-20250421    gcc-7.5.0
arm64                 randconfig-003-20250421    gcc-9.5.0
arm64                 randconfig-004-20250421    clang-16
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250421    gcc-14.2.0
csky                  randconfig-002-20250421    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250421    clang-16
hexagon               randconfig-002-20250421    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250421    clang-20
i386        buildonly-randconfig-002-20250421    clang-20
i386        buildonly-randconfig-003-20250421    clang-20
i386        buildonly-randconfig-004-20250421    gcc-12
i386        buildonly-randconfig-005-20250421    gcc-12
i386        buildonly-randconfig-006-20250421    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250421    gcc-14.2.0
loongarch             randconfig-002-20250421    gcc-14.2.0
m68k                             alldefconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                       m5275evb_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                       bmips_be_defconfig    gcc-14.2.0
mips                  cavium_octeon_defconfig    gcc-14.2.0
mips                           ip30_defconfig    gcc-14.2.0
nios2                            alldefconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250421    gcc-9.3.0
nios2                 randconfig-002-20250421    gcc-13.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
openrisc                 simple_smp_defconfig    gcc-14.2.0
openrisc                       virt_defconfig    gcc-14.2.0
parisc                           alldefconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250421    gcc-6.5.0
parisc                randconfig-002-20250421    gcc-8.5.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                 linkstation_defconfig    clang-20
powerpc                 mpc834x_itx_defconfig    clang-16
powerpc               randconfig-001-20250421    clang-21
powerpc               randconfig-002-20250421    clang-21
powerpc               randconfig-003-20250421    clang-21
powerpc                     taishan_defconfig    clang-17
powerpc                     tqm8548_defconfig    clang-21
powerpc64             randconfig-001-20250421    gcc-10.5.0
powerpc64             randconfig-002-20250421    clang-21
powerpc64             randconfig-003-20250421    gcc-7.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250421    gcc-14.2.0
riscv                 randconfig-001-20250422    clang-21
riscv                 randconfig-002-20250421    gcc-14.2.0
riscv                 randconfig-002-20250422    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250421    clang-21
s390                  randconfig-001-20250422    gcc-7.5.0
s390                  randconfig-002-20250421    gcc-7.5.0
s390                  randconfig-002-20250422    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250421    gcc-11.5.0
sh                    randconfig-001-20250422    gcc-14.2.0
sh                    randconfig-002-20250421    gcc-7.5.0
sh                    randconfig-002-20250422    gcc-6.5.0
sh                      rts7751r2d1_defconfig    gcc-14.2.0
sh                          sdk7786_defconfig    gcc-14.2.0
sh                           se7751_defconfig    gcc-14.2.0
sh                        sh7757lcr_defconfig    gcc-14.2.0
sh                   sh7770_generic_defconfig    gcc-14.2.0
sh                            titan_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250421    gcc-10.3.0
sparc                 randconfig-001-20250422    gcc-10.3.0
sparc                 randconfig-002-20250421    gcc-8.5.0
sparc                 randconfig-002-20250422    gcc-6.5.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250421    gcc-12.4.0
sparc64               randconfig-001-20250422    gcc-7.5.0
sparc64               randconfig-002-20250421    gcc-6.5.0
sparc64               randconfig-002-20250422    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250421    gcc-12
um                    randconfig-001-20250422    gcc-12
um                    randconfig-002-20250421    clang-16
um                    randconfig-002-20250422    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250421    gcc-12
x86_64      buildonly-randconfig-002-20250421    clang-20
x86_64      buildonly-randconfig-003-20250421    gcc-12
x86_64      buildonly-randconfig-004-20250421    gcc-12
x86_64      buildonly-randconfig-005-20250421    gcc-12
x86_64      buildonly-randconfig-006-20250421    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                          iss_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250421    gcc-6.5.0
xtensa                randconfig-001-20250422    gcc-14.2.0
xtensa                randconfig-002-20250421    gcc-6.5.0
xtensa                randconfig-002-20250422    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

