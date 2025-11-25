Return-Path: <linux-rdma+bounces-14756-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE9AC84224
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 10:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 444FE34CA35
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 09:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29604261B6D;
	Tue, 25 Nov 2025 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LOLQTE1s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C6B29DB61
	for <linux-rdma@vger.kernel.org>; Tue, 25 Nov 2025 09:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764061522; cv=none; b=s+i4L4go0khDIRLxquub0Nd1rKuZLhASBgszC24a6zfzwNqYoPkFbTDsXT9Z90ZGy7Dpx3uEE4EOVhacpLi6e+Nhe9eLoFFOajHnCoqKwg27320SrpaequqJa7cke1PSHml5CRFdW9P2LYMQmRGbf8+wdFDhmoA+g+zbJcsO+cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764061522; c=relaxed/simple;
	bh=HB5labggphvroUkUldMRqxDlwvTOMvvKZr9brzpQ5Ec=;
	h=Date:From:To:Cc:Subject:Message-ID; b=V26sbS6UTXTfrasAns+sQ5Oqioz2NCIEwJH19qaLGGe3nh6uPIGUY0q0Okai8orFaqiwnKIa/lYtqKyLoKlmE7V26R6BwmydXBv+sUeJFWM1b5dPkR6FuZO4qBvVLVWCeVRKI9Eaw+cDjxuUiWLH3jApO67hOqeeEyh7rh0qk/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LOLQTE1s; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764061521; x=1795597521;
  h=date:from:to:cc:subject:message-id;
  bh=HB5labggphvroUkUldMRqxDlwvTOMvvKZr9brzpQ5Ec=;
  b=LOLQTE1sYCRLPGLuZUdtX1dxvjeTOAnQXWzi6J0G/L/xXkUjcS7ZhPDp
   pc2o7QpmkvM88YO59bFWPWRwTj2HDE7wg4y3YkY3Yt69AZmg60xtUJOvI
   K9BfYPjaokcK0soN7GvWNhQ+KbaLTKAx+ayVVbEAMXR1vg52bqU45/b+z
   6zCGDAB6BliGuAtJ3+oNSIJCvC458ayMmz8Z2Jx2zxNCvdbjYqs4IKYt4
   L8l33DY0uzPetyGTndt2zXRwKBQGBHVK7wByxnbrdNodRJhU0qebpKsnC
   9BffbJRJAJXmWABOdsBwD6tJBKJNUWN7KVqE9XWB3tRty8rR1lKeqHPDY
   Q==;
X-CSE-ConnectionGUID: wpp1WJ5cTLqd35VezW4AsA==
X-CSE-MsgGUID: EkU0EPq2R9usKakJ8q/7uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="66234689"
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="66234689"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 01:05:21 -0800
X-CSE-ConnectionGUID: +8FU2+i0RqqpQ9JbHIkttQ==
X-CSE-MsgGUID: /ngZvIo4TKKbl4Q8kknB+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="192221204"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 25 Nov 2025 01:05:19 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vNoz7-000000001YV-1Zkx;
	Tue, 25 Nov 2025 09:05:17 +0000
Date: Tue, 25 Nov 2025 17:05:12 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD REGRESSION
 4022c7b6342a4d9a97e1e974e27efca95e79ed20
Message-ID: <202511251705.WCZZXVE3-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 4022c7b6342a4d9a97e1e974e27efca95e79ed20  RDMA/mlx5: Add support for 1600_8x lane speed

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202511250215.VMVtdDPm-lkp@intel.com

    drivers/infiniband/hw/bng_re/bng_fw.c:278:2: error: call to undeclared function 'prefetch'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]

Error/Warning ids grouped by kconfigs:

recent_errors
`-- s390-allmodconfig
    `-- drivers-infiniband-hw-bng_re-bng_fw.c:error:call-to-undeclared-function-prefetch-ISO-C99-and-later-do-not-support-implicit-function-declarations

elapsed time: 1468m

configs tested: 135
configs skipped: 2

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251124    gcc-10.5.0
arc                   randconfig-002-20251124    gcc-13.4.0
arm                               allnoconfig    clang-22
arm                       aspeed_g4_defconfig    clang-22
arm                                 defconfig    clang-22
arm                      footbridge_defconfig    clang-17
arm                   randconfig-001-20251124    clang-19
arm                   randconfig-002-20251124    gcc-12.5.0
arm                   randconfig-003-20251124    gcc-11.5.0
arm                   randconfig-004-20251124    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251124    clang-22
arm64                 randconfig-002-20251124    clang-19
arm64                 randconfig-003-20251124    gcc-9.5.0
arm64                 randconfig-004-20251124    gcc-11.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251124    gcc-10.5.0
csky                  randconfig-002-20251124    gcc-12.5.0
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251124    clang-17
hexagon               randconfig-002-20251124    clang-18
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251125    gcc-14
i386        buildonly-randconfig-002-20251125    clang-20
i386        buildonly-randconfig-003-20251125    gcc-14
i386        buildonly-randconfig-004-20251125    gcc-14
i386        buildonly-randconfig-005-20251125    gcc-14
i386        buildonly-randconfig-006-20251125    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251125    gcc-12
i386                  randconfig-002-20251125    gcc-14
i386                  randconfig-003-20251125    gcc-14
i386                  randconfig-004-20251125    gcc-14
i386                  randconfig-005-20251125    gcc-14
i386                  randconfig-006-20251125    gcc-14
i386                  randconfig-007-20251125    gcc-14
i386                  randconfig-011-20251125    clang-20
i386                  randconfig-012-20251125    gcc-14
i386                  randconfig-013-20251125    gcc-13
i386                  randconfig-014-20251125    clang-20
i386                  randconfig-015-20251125    gcc-14
i386                  randconfig-016-20251125    clang-20
i386                  randconfig-017-20251125    clang-20
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251124    clang-22
loongarch             randconfig-002-20251124    gcc-14.3.0
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                           virt_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251124    gcc-11.5.0
nios2                 randconfig-002-20251124    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251124    gcc-14.3.0
parisc                randconfig-002-20251124    gcc-13.4.0
parisc64                         alldefconfig    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                        icon_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251124    gcc-12.5.0
powerpc               randconfig-002-20251124    clang-16
powerpc64             randconfig-001-20251124    gcc-8.5.0
powerpc64             randconfig-002-20251124    gcc-14.3.0
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251124    clang-17
riscv                 randconfig-002-20251124    clang-22
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                  randconfig-001-20251124    gcc-8.5.0
s390                  randconfig-002-20251124    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                        dreamcast_defconfig    gcc-15.1.0
sh                          landisk_defconfig    gcc-15.1.0
sh                    randconfig-001-20251124    gcc-15.1.0
sh                    randconfig-002-20251124    gcc-12.5.0
sh                          sdk7780_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251124    gcc-8.5.0
sparc                 randconfig-002-20251124    gcc-13.4.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251124    gcc-15.1.0
sparc64               randconfig-002-20251124    gcc-8.5.0
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251124    gcc-14
um                    randconfig-002-20251124    clang-20
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251125    gcc-12
x86_64      buildonly-randconfig-002-20251125    gcc-14
x86_64      buildonly-randconfig-003-20251125    gcc-14
x86_64      buildonly-randconfig-004-20251125    clang-20
x86_64      buildonly-randconfig-005-20251125    gcc-14
x86_64      buildonly-randconfig-006-20251125    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251125    clang-20
x86_64                randconfig-002-20251125    clang-20
x86_64                randconfig-003-20251125    clang-20
x86_64                randconfig-004-20251125    clang-20
x86_64                randconfig-005-20251125    clang-20
x86_64                randconfig-006-20251125    clang-20
x86_64                randconfig-011-20251125    gcc-12
x86_64                randconfig-012-20251125    clang-20
x86_64                randconfig-013-20251125    gcc-14
x86_64                randconfig-014-20251125    gcc-14
x86_64                randconfig-015-20251125    clang-20
x86_64                randconfig-016-20251125    gcc-14
x86_64                randconfig-071-20251125    clang-20
x86_64                randconfig-072-20251125    clang-20
x86_64                randconfig-073-20251125    clang-20
x86_64                randconfig-074-20251125    clang-20
x86_64                randconfig-075-20251125    gcc-14
x86_64                randconfig-076-20251125    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251124    gcc-10.5.0
xtensa                randconfig-002-20251124    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

