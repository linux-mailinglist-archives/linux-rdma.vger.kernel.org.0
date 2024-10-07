Return-Path: <linux-rdma+bounces-5288-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB749938F7
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 23:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE2B41F2459A
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 21:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077A91DE88C;
	Mon,  7 Oct 2024 21:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q4l0c2Z4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101441DE4D8
	for <linux-rdma@vger.kernel.org>; Mon,  7 Oct 2024 21:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728336019; cv=none; b=XZfRJfHMe8j38QUacxP2ittQrmoK/5pM2SIguLl9bo78EmatPBXj9AgT5TiyLHjT+VGsVwojWqu08W82/WBCVWcJsLX/H4J80soG11v3GkLL1a7CQ/aQglnNtRFQHuCjQwVVOtwnJFu1UyUiluZ1ajk+pbKv9EWasN7SU2zaYe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728336019; c=relaxed/simple;
	bh=Vk2ylFHlbe3OcbOkm9asUcwCuK6jQJ67MQrP7X+RcDY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Fsv0x9ikm0vDqZaf+UF0Xpbc8qaNTEIj+mAKyizO37cye0IfKOLcsMCJcyEP3WZ4R8qHPHh4WeEXzFiWlUHagJKjtenaiVFchWKVq4tTSB8fEPyI3GIt+N57DOyKc6FpzeHMzFmJZqwCqEJohNTYmshxezHySf2EDEqfCjnUOkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q4l0c2Z4; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728336018; x=1759872018;
  h=date:from:to:cc:subject:message-id;
  bh=Vk2ylFHlbe3OcbOkm9asUcwCuK6jQJ67MQrP7X+RcDY=;
  b=Q4l0c2Z4k1pSiDtNbff1CYvnIArUtWfy/qU4qIqCqCuDrQaGHmue5Yxi
   NLy4fNMaKDBwE9Ut1tEgwi7B0uNW2FswJZgy3/3n0RQVVRZQbJCrE+NLC
   rhTgg153wn4ooo4Fovl2Zucqxwnzqf6PodYi+Buds24gfqzsS2hoV58VY
   0Hfi/cbUeX6dvZeOlLvCbPQjmSKbI+PjP2dFBfOHgNqJfFzvT4t+bLPi8
   m8kwqsWzlXIgjrXDWoLYNJys8NJLI6oQop1THTtYoTScVo4CXkUPTMjby
   RkLDCqW3AsVjdgSkXHbFh9aNjUeav6H0X89yrcZNBzOsQkOO1rjHBxowA
   A==;
X-CSE-ConnectionGUID: 7P8pzYrER2mGeGpZQjNrRQ==
X-CSE-MsgGUID: /+r0vbJ3SxWIAecjRAEYnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27635852"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="27635852"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 14:20:17 -0700
X-CSE-ConnectionGUID: Harwr1koS16NK3HmTG3VeA==
X-CSE-MsgGUID: 0eqdlvtbT8CZHPvVYZiSLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="98932950"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 07 Oct 2024 14:20:15 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sxv9J-0005XI-0l;
	Mon, 07 Oct 2024 21:20:13 +0000
Date: Tue, 08 Oct 2024 05:19:37 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-rc] BUILD SUCCESS
 3630aae47658eaef3c5b31dd738ab97cb395411b
Message-ID: <202410080522.iNrgU6Bi-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: 3630aae47658eaef3c5b31dd738ab97cb395411b  RDMA/nldev: Fix NULL pointer dereferences issue in rdma_nl_notify_event

elapsed time: 895m

configs tested: 111
configs skipped: 4

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
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                    vdk_hs38_smp_defconfig    gcc-13.2.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                       aspeed_g4_defconfig    gcc-13.2.0
arm                                 defconfig    gcc-14.1.0
arm                          ixp4xx_defconfig    gcc-13.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          alldefconfig    gcc-13.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241008    clang-18
i386        buildonly-randconfig-002-20241008    clang-18
i386        buildonly-randconfig-003-20241008    clang-18
i386        buildonly-randconfig-004-20241008    clang-18
i386        buildonly-randconfig-005-20241008    clang-18
i386        buildonly-randconfig-006-20241008    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20241008    clang-18
i386                  randconfig-002-20241008    clang-18
i386                  randconfig-003-20241008    clang-18
i386                  randconfig-004-20241008    clang-18
i386                  randconfig-005-20241008    clang-18
i386                  randconfig-006-20241008    clang-18
i386                  randconfig-011-20241008    clang-18
i386                  randconfig-012-20241008    clang-18
i386                  randconfig-013-20241008    clang-18
i386                  randconfig-014-20241008    clang-18
i386                  randconfig-015-20241008    clang-18
i386                  randconfig-016-20241008    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                          atari_defconfig    gcc-13.2.0
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                           xway_defconfig    gcc-13.2.0
nios2                         10m50_defconfig    gcc-13.2.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                generic-32bit_defconfig    gcc-13.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
powerpc                      cm5200_defconfig    gcc-13.2.0
powerpc                         ps3_defconfig    gcc-13.2.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                 kfr2r09-romimage_defconfig    gcc-13.2.0
sh                          rsk7203_defconfig    gcc-13.2.0
sh                           se7722_defconfig    gcc-13.2.0
sh                          urquell_defconfig    gcc-13.2.0
sparc                            allmodconfig    gcc-14.1.0
sparc                       sparc32_defconfig    gcc-13.2.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

