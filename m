Return-Path: <linux-rdma+bounces-6775-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3B19FF34F
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jan 2025 08:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89F38161D94
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jan 2025 07:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2C718027;
	Wed,  1 Jan 2025 07:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZzhYBo/W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605BB15E90
	for <linux-rdma@vger.kernel.org>; Wed,  1 Jan 2025 07:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735716859; cv=none; b=di7UGT8ssxIVi9t2UN6HDQu9Aud1xUDysChgRhcCxPqTp2TJjcJw7FkIXpomLKkq4KzQHliSMbJ0OnjrdbWz/0UN0JBsp5StIQXN6LSIwQx9xTGOxEN2VqSDx1gR4W1v1fWvTAEDkIaxqD46/pDMK6T+c6bLxtNyzFoNoIZYl3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735716859; c=relaxed/simple;
	bh=fUHBjZFlZGxZZgVk3P/EvzK040t9BPjdeD2dq+0BDbw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oJSD3fhgzir0ehsoY7/S3l2m4gDho2mdN4sgB2tAQt2K9k9KWvZ8rU+Bq31j+YruN+1axBaXY9Hah7qdKjXCbIISXck1bHr0PodYDeEW3i4hE1ssmTukUpPz/lPOAdJDHuQihVa91Y/cNRgpLyJzK6ANWqMP8mc0hg2SnSmCy6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZzhYBo/W; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735716857; x=1767252857;
  h=date:from:to:cc:subject:message-id;
  bh=fUHBjZFlZGxZZgVk3P/EvzK040t9BPjdeD2dq+0BDbw=;
  b=ZzhYBo/Wibkx35P/yDowKA1QAnaGftXRWKew9oBGcNpUdJxU3Wxrzur1
   Nrwfhho5hqT2f/bbzpTAtcfzCTfQNi9GJgShQo8H2jDP+AneFKILFooIr
   +xfQrUszUsddgrg68kkxKkbh+RQCwgYZ5UrGtLyxB726YftYu3tmhhfZU
   dnVYEuIIHeRRrRxczJOt7Pk+TI7ZY0lar8zNKRQFjDpiYqdEz9ICtrKzV
   TvpKOj8OYCHpiyujBi4b2OU/yeiMh9G0GdCQCT8NDH3nAqFKqCYq2G7il
   QCn5/G6HcRAbVsIzeb6AUvSoK2womVESWG2L9ecQApZo6CYq9cfcXSAYC
   w==;
X-CSE-ConnectionGUID: 6Yt9czIpS3WwUBHIkeShow==
X-CSE-MsgGUID: LEROO5L8SXSbAdIk0XFbDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="53527274"
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="53527274"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 23:34:17 -0800
X-CSE-ConnectionGUID: 0mR41l6PQneWvEVzYgG79A==
X-CSE-MsgGUID: 051675g+TT6fnZfxaI7OeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105842506"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 31 Dec 2024 23:34:15 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tStF7-0007hT-06;
	Wed, 01 Jan 2025 07:34:13 +0000
Date: Wed, 01 Jan 2025 15:33:35 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 e6178bf78d0378c2d397a6aafaf4882d0af643fa
Message-ID: <202501011529.ymDxN4xM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: e6178bf78d0378c2d397a6aafaf4882d0af643fa  RDMA/bnxt_re: Fix error recovery sequence

elapsed time: 1057m

configs tested: 240
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                      axs103_smp_defconfig    clang-20
arc                                 defconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20241231    gcc-13.2.0
arc                   randconfig-001-20250101    gcc-13.2.0
arc                   randconfig-002-20241231    gcc-13.2.0
arc                   randconfig-002-20250101    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-20
arm                                 defconfig    gcc-14.2.0
arm                            dove_defconfig    clang-20
arm                          exynos_defconfig    gcc-14.2.0
arm                      jornada720_defconfig    clang-20
arm                           omap1_defconfig    gcc-14.2.0
arm                             pxa_defconfig    gcc-14.2.0
arm                            qcom_defconfig    clang-17
arm                   randconfig-001-20241231    clang-19
arm                   randconfig-001-20250101    clang-15
arm                   randconfig-002-20241231    clang-17
arm                   randconfig-002-20250101    clang-17
arm                   randconfig-003-20241231    gcc-14.2.0
arm                   randconfig-003-20250101    gcc-14.2.0
arm                   randconfig-004-20241231    gcc-14.2.0
arm                   randconfig-004-20250101    gcc-14.2.0
arm                        shmobile_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                            allyesconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241231    clang-20
arm64                 randconfig-001-20250101    clang-20
arm64                 randconfig-002-20241231    clang-20
arm64                 randconfig-002-20250101    clang-20
arm64                 randconfig-003-20241231    gcc-14.2.0
arm64                 randconfig-003-20250101    gcc-14.2.0
arm64                 randconfig-004-20241231    clang-19
arm64                 randconfig-004-20250101    clang-19
csky                             allmodconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                             allyesconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241231    gcc-14.2.0
csky                  randconfig-002-20241231    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241231    clang-20
hexagon               randconfig-002-20241231    clang-16
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241231    gcc-11
i386        buildonly-randconfig-002-20241231    clang-19
i386        buildonly-randconfig-003-20241231    clang-19
i386        buildonly-randconfig-004-20241231    clang-19
i386        buildonly-randconfig-005-20241231    gcc-12
i386        buildonly-randconfig-006-20241231    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20250101    gcc-12
i386                  randconfig-002-20250101    gcc-12
i386                  randconfig-003-20250101    gcc-12
i386                  randconfig-004-20250101    gcc-12
i386                  randconfig-005-20250101    gcc-12
i386                  randconfig-006-20250101    gcc-12
i386                  randconfig-007-20250101    gcc-12
i386                  randconfig-011-20250101    gcc-12
i386                  randconfig-012-20250101    gcc-12
i386                  randconfig-013-20250101    gcc-12
i386                  randconfig-014-20250101    gcc-12
i386                  randconfig-015-20250101    gcc-12
i386                  randconfig-016-20250101    gcc-12
i386                  randconfig-017-20250101    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                        allyesconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241231    gcc-14.2.0
loongarch             randconfig-002-20241231    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          amiga_defconfig    clang-20
m68k                                defconfig    gcc-14.2.0
m68k                       m5208evb_defconfig    clang-20
m68k                        m5307c3_defconfig    gcc-14.2.0
m68k                       m5475evb_defconfig    gcc-14.2.0
m68k                        mvme16x_defconfig    gcc-14.2.0
m68k                           sun3_defconfig    clang-20
microblaze                       alldefconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
microblaze                      mmu_defconfig    gcc-14.2.0
mips                             allmodconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                             allyesconfig    gcc-14.2.0
nios2                            allmodconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                            allyesconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241231    gcc-14.2.0
nios2                 randconfig-002-20241231    gcc-14.2.0
openrisc                         allmodconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241231    gcc-14.2.0
parisc                randconfig-002-20241231    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
parisc64                            defconfig    gcc-14.2.0
powerpc                     akebono_defconfig    clang-20
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                          allyesconfig    gcc-14.2.0
powerpc                 canyonlands_defconfig    clang-19
powerpc                       ebony_defconfig    clang-18
powerpc                       holly_defconfig    clang-20
powerpc                      mgcoge_defconfig    gcc-14.2.0
powerpc                     ppa8548_defconfig    gcc-14.2.0
powerpc                      ppc6xx_defconfig    gcc-14.2.0
powerpc                         ps3_defconfig    gcc-14.2.0
powerpc                     rainier_defconfig    clang-20
powerpc               randconfig-001-20241231    clang-15
powerpc               randconfig-002-20241231    clang-20
powerpc               randconfig-003-20241231    clang-15
powerpc64             randconfig-001-20241231    clang-20
powerpc64             randconfig-002-20241231    clang-19
powerpc64             randconfig-003-20241231    clang-20
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-19
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241231    clang-20
riscv                 randconfig-002-20241231    clang-15
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                                defconfig    gcc-12
s390                  randconfig-001-20241231    gcc-14.2.0
s390                  randconfig-002-20241231    clang-16
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20241231    gcc-14.2.0
sh                    randconfig-002-20241231    gcc-14.2.0
sh                   sh7770_generic_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                            allyesconfig    gcc-14.2.0
sparc                 randconfig-001-20241231    gcc-14.2.0
sparc                 randconfig-002-20241231    gcc-14.2.0
sparc64                          allmodconfig    gcc-14.2.0
sparc64                          allyesconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241231    gcc-14.2.0
sparc64               randconfig-002-20241231    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241231    clang-20
um                    randconfig-002-20241231    gcc-12
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241231    clang-19
x86_64      buildonly-randconfig-001-20250101    clang-19
x86_64      buildonly-randconfig-002-20241231    gcc-12
x86_64      buildonly-randconfig-002-20250101    clang-19
x86_64      buildonly-randconfig-003-20241231    clang-19
x86_64      buildonly-randconfig-003-20250101    clang-19
x86_64      buildonly-randconfig-004-20241231    gcc-12
x86_64      buildonly-randconfig-004-20250101    gcc-12
x86_64      buildonly-randconfig-005-20241231    clang-19
x86_64      buildonly-randconfig-005-20250101    clang-19
x86_64      buildonly-randconfig-006-20241231    clang-19
x86_64      buildonly-randconfig-006-20250101    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250101    gcc-12
x86_64                randconfig-002-20250101    gcc-12
x86_64                randconfig-003-20250101    gcc-12
x86_64                randconfig-004-20250101    gcc-12
x86_64                randconfig-005-20250101    gcc-12
x86_64                randconfig-006-20250101    gcc-12
x86_64                randconfig-007-20250101    gcc-12
x86_64                randconfig-008-20250101    gcc-12
x86_64                randconfig-071-20250101    gcc-12
x86_64                randconfig-072-20250101    gcc-12
x86_64                randconfig-073-20250101    gcc-12
x86_64                randconfig-074-20250101    gcc-12
x86_64                randconfig-075-20250101    gcc-12
x86_64                randconfig-076-20250101    gcc-12
x86_64                randconfig-077-20250101    gcc-12
x86_64                randconfig-078-20250101    gcc-12
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                           allyesconfig    gcc-14.2.0
xtensa                randconfig-001-20241231    gcc-14.2.0
xtensa                randconfig-002-20241231    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

