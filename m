Return-Path: <linux-rdma+bounces-14295-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D76C3F668
	for <lists+linux-rdma@lfdr.de>; Fri, 07 Nov 2025 11:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250B51885F7F
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Nov 2025 10:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92450303C8B;
	Fri,  7 Nov 2025 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DdCU5DBC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03261E51EE
	for <linux-rdma@vger.kernel.org>; Fri,  7 Nov 2025 10:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762510979; cv=none; b=qVldpcQNepHxWhwLnOQDFNEanaDhy+0ZsQ4ZObx9EuWUtYKX4v87yPGCS017XT+cwuRYoDzF7F5Cw5Xw6IzldSuFEi+6Ol35W0JGW4hJmtwkjyxbL67J+zYfOONAcS8/eTJ7AtepX7SjkhbJDbqs2kngVvW+bJcpC+nVbvem9bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762510979; c=relaxed/simple;
	bh=VJnjPSvKV4wxlw6pgm+rMc2DOOe7SKHKUt5pOBrhCsU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FfY53FKcCAVgLM2keOIfR4nd54Ye9J8rgLYQ5uQJfmWWX23H5k9dJqaoCuxudXKV0sJximOi7ULjIn+QPcGchjvJEIwxn06BrCkFLBr5gkEA7ikdWse/1aVPXv9ElOaULvMCP8Vh7ahTGszvPSPrKzwOjY4fTyQpBVLQCGoo8tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DdCU5DBC; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762510978; x=1794046978;
  h=date:from:to:cc:subject:message-id;
  bh=VJnjPSvKV4wxlw6pgm+rMc2DOOe7SKHKUt5pOBrhCsU=;
  b=DdCU5DBCrNANfj7WbLi+t5zGlB3ymbGHxXHFiZ7ssyDqE0p7wYIgTcjq
   U9SgsUQ+489Fklcl1uU5kRG5wsW9SJ2LKTEKEs4hZDQHmVfDBl8OzRyRO
   Y2eY8xQA5mWMoNxG3QajK/5YgCpXTZc2i8eYxdJ1py5gLO2d5Y+ECVFTa
   Zo6VPuyUK27MOLJUmgbW/y9H9clnMXGb1OI0SydcM+TlcQXEkc4KZ+veL
   Ap8quOQFuaD9ts336rPyHD2YwRY5bOzm6zNW30YO8jm0Sd7vyzJZwMz3n
   7gE9i+9wXbN8Zf5M87W5A2ae5+AeJ6ZeiLYoVfGUMpSpO+fcTcisk72jx
   g==;
X-CSE-ConnectionGUID: qgRc29Q4T+SRYNqgeOVZDg==
X-CSE-MsgGUID: dySmb+bETN+H899pdsDApw==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="64358849"
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="64358849"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 02:22:57 -0800
X-CSE-ConnectionGUID: wtIeo1PxTwWn13DB5hEQsw==
X-CSE-MsgGUID: rtO8nD8BQUuc+wqY0O9hGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="193038577"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 07 Nov 2025 02:22:56 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHJcM-000Uz6-01;
	Fri, 07 Nov 2025 10:22:54 +0000
Date: Fri, 07 Nov 2025 18:22:03 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 512c83265796d613f21255c766839eaed1c1cc79
Message-ID: <202511071857.4TqaAbBb-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 512c83265796d613f21255c766839eaed1c1cc79  IB/rdmavt: rdmavt_qp.h: clean up kernel-doc comments

elapsed time: 1588m

configs tested: 111
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251107    gcc-8.5.0
arc                   randconfig-002-20251107    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                     davinci_all_defconfig    clang-19
arm                                 defconfig    clang-22
arm                         lpc32xx_defconfig    clang-17
arm                        multi_v7_defconfig    gcc-15.1.0
arm                   randconfig-001-20251107    clang-17
arm                   randconfig-002-20251107    gcc-13.4.0
arm                   randconfig-003-20251107    clang-22
arm                   randconfig-004-20251107    gcc-8.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251107    gcc-8.5.0
arm64                 randconfig-002-20251107    clang-22
arm64                 randconfig-003-20251107    gcc-8.5.0
arm64                 randconfig-004-20251107    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251107    gcc-12.5.0
csky                  randconfig-002-20251107    gcc-13.4.0
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251107    clang-22
hexagon               randconfig-002-20251107    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251107    clang-20
i386        buildonly-randconfig-002-20251107    clang-20
i386        buildonly-randconfig-003-20251107    gcc-13
i386        buildonly-randconfig-004-20251107    gcc-14
i386        buildonly-randconfig-005-20251107    clang-20
i386        buildonly-randconfig-006-20251107    clang-20
i386                                defconfig    clang-20
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251107    gcc-15.1.0
loongarch             randconfig-002-20251107    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                          sun3x_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip22_defconfig    gcc-15.1.0
mips                   sb1250_swarm_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251107    gcc-11.5.0
nios2                 randconfig-002-20251107    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251107    gcc-8.5.0
parisc                randconfig-002-20251107    gcc-12.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                     mpc5200_defconfig    clang-22
powerpc               randconfig-001-20251107    clang-22
powerpc               randconfig-002-20251107    clang-22
powerpc64             randconfig-001-20251107    gcc-14.3.0
powerpc64             randconfig-002-20251107    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20251106    clang-22
riscv                 randconfig-002-20251106    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20251106    gcc-8.5.0
s390                  randconfig-002-20251106    gcc-14.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251106    gcc-11.5.0
sh                    randconfig-002-20251106    gcc-13.4.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251107    gcc-11.5.0
sparc                 randconfig-002-20251107    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251107    gcc-8.5.0
sparc64               randconfig-002-20251107    gcc-9.5.0
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251107    clang-22
um                    randconfig-002-20251107    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251107    gcc-14
x86_64      buildonly-randconfig-002-20251107    clang-20
x86_64      buildonly-randconfig-003-20251107    gcc-14
x86_64      buildonly-randconfig-004-20251107    clang-20
x86_64      buildonly-randconfig-005-20251107    gcc-14
x86_64      buildonly-randconfig-006-20251107    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20251107    gcc-14
x86_64                randconfig-012-20251107    gcc-14
x86_64                randconfig-013-20251107    clang-20
x86_64                randconfig-014-20251107    clang-20
x86_64                randconfig-015-20251107    gcc-14
x86_64                randconfig-016-20251107    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251107    gcc-10.5.0
xtensa                randconfig-002-20251107    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

