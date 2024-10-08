Return-Path: <linux-rdma+bounces-5320-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A93995BB6
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 01:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9AA61C2104B
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 23:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4C1217906;
	Tue,  8 Oct 2024 23:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N8tGPL2E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C29F21790A
	for <linux-rdma@vger.kernel.org>; Tue,  8 Oct 2024 23:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728430457; cv=none; b=s5pEcJPeB+PxWRWVnB8WKLGpXEZNGQfHgb+gdDesy4MO9pYSvXCdOhj1ROgT3bfR6Xju3qWRuUV5AJy+Q2WVJPuG8OwD5jm/gH/na7EOyYvL8MuOsVusxZ5NGAMKjvQ1f7ypNM2EAZVjWjPQ3Y4bNwgiB2b+9TrL3RubEPIxpTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728430457; c=relaxed/simple;
	bh=l5lNVMrcvq+BUL7syczFTJbO/mqRD7A6/NobfbF5PcU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ukIYN/Empaub9InD6DH7azByKjEDt5dinzuwwyOJ6cj6+KDjD6NOpRUtOH+G/mbHAXdaRJyqqHnbHPX9DyFTWzK2s/xXTOImuLux/Ad5fDDH0uzjnleh7aUYClTuEWafH1lw/YqOHa+0nkp0Qxk9KqW9Zcb+UFy6rP7HiYrZGTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N8tGPL2E; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728430456; x=1759966456;
  h=date:from:to:cc:subject:message-id;
  bh=l5lNVMrcvq+BUL7syczFTJbO/mqRD7A6/NobfbF5PcU=;
  b=N8tGPL2EVasfHbWf/63nrOKlAH4/YX6ukE+lOaTndDCvAtZly72htL2I
   30m3OWwHQcSJ+qZ1rNdDl5lTZm45OKmKe9cuxEalJGyVyt9VXzDQUyNEp
   4Rh5PUyY/w1iPHtLXBzn4B8tb7hJ+QUNVV2j1qjp4YLAgNbjZ+X6hVemn
   nKALZJdtDGhSh71mP+w5NvB6SMzYH2oK3h8yxXWfS9tuoRY7eQ8faGpVF
   o9EoCpDCcXfuQBShGU8xHwFQKRTlNnt95lGBmVXBKd1F9YfhW0vGI46jz
   tHu9xJIaTc8bJikI0kmqBHvWQ3EVIYz0xqLhi6b3V53/ZyoZ2ftL1NMUX
   g==;
X-CSE-ConnectionGUID: 9yLZm5bNSrKvMj6EPiPBbA==
X-CSE-MsgGUID: iivA3zMNR8Wu6KswqkFPrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27171520"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="27171520"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 16:34:15 -0700
X-CSE-ConnectionGUID: m3vJRIDkROKIpmXdFcTWzQ==
X-CSE-MsgGUID: sOPOYweISDSHFBeuVo+yjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="80019338"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 08 Oct 2024 16:34:14 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syJiV-0008UO-3B;
	Tue, 08 Oct 2024 23:34:11 +0000
Date: Wed, 09 Oct 2024 07:33:17 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-rc] BUILD SUCCESS
 6ff57a2ea7c2911f80457a5a3a5b4370756ad475
Message-ID: <202410090703.bNTmZl7B-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: 6ff57a2ea7c2911f80457a5a3a5b4370756ad475  RDMA/nldev: Fix NULL pointer dereferences issue in rdma_nl_notify_event

elapsed time: 938m

configs tested: 148
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                          axs103_defconfig    gcc-14.1.0
arc                                 defconfig    gcc-14.1.0
arc                   randconfig-001-20241009    gcc-14.1.0
arc                   randconfig-002-20241009    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                   randconfig-001-20241009    gcc-14.1.0
arm                   randconfig-002-20241009    gcc-14.1.0
arm                   randconfig-003-20241009    gcc-14.1.0
arm                   randconfig-004-20241009    gcc-14.1.0
arm                         s3c6400_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241009    gcc-14.1.0
arm64                 randconfig-002-20241009    gcc-14.1.0
arm64                 randconfig-003-20241009    gcc-14.1.0
arm64                 randconfig-004-20241009    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241009    gcc-14.1.0
csky                  randconfig-002-20241009    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241009    gcc-14.1.0
hexagon               randconfig-002-20241009    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241009    clang-18
i386        buildonly-randconfig-002-20241009    clang-18
i386        buildonly-randconfig-003-20241009    clang-18
i386        buildonly-randconfig-004-20241009    clang-18
i386        buildonly-randconfig-005-20241009    clang-18
i386        buildonly-randconfig-006-20241009    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20241009    clang-18
i386                  randconfig-002-20241009    clang-18
i386                  randconfig-003-20241009    clang-18
i386                  randconfig-004-20241009    clang-18
i386                  randconfig-005-20241009    clang-18
i386                  randconfig-006-20241009    clang-18
i386                  randconfig-011-20241009    clang-18
i386                  randconfig-012-20241009    clang-18
i386                  randconfig-013-20241009    clang-18
i386                  randconfig-014-20241009    clang-18
i386                  randconfig-015-20241009    clang-18
i386                  randconfig-016-20241009    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241009    gcc-14.1.0
loongarch             randconfig-002-20241009    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                            q40_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          ath25_defconfig    gcc-14.1.0
mips                     decstation_defconfig    gcc-14.1.0
mips                           ip22_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241009    gcc-14.1.0
nios2                 randconfig-002-20241009    gcc-14.1.0
openrisc                         alldefconfig    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241009    gcc-14.1.0
parisc                randconfig-002-20241009    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
powerpc                       maple_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241009    gcc-14.1.0
powerpc               randconfig-002-20241009    gcc-14.1.0
powerpc               randconfig-003-20241009    gcc-14.1.0
powerpc                     tqm8555_defconfig    gcc-14.1.0
powerpc64             randconfig-001-20241009    gcc-14.1.0
powerpc64             randconfig-002-20241009    gcc-14.1.0
powerpc64             randconfig-003-20241009    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241009    gcc-14.1.0
riscv                 randconfig-002-20241009    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241009    gcc-14.1.0
s390                  randconfig-002-20241009    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                         ap325rxa_defconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20241009    gcc-14.1.0
sh                    randconfig-002-20241009    gcc-14.1.0
sh                          rsk7201_defconfig    gcc-14.1.0
sh                          sdk7780_defconfig    gcc-14.1.0
sh                           se7705_defconfig    gcc-14.1.0
sh                           se7712_defconfig    gcc-14.1.0
sh                             sh03_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241009    gcc-14.1.0
sparc64               randconfig-002-20241009    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241009    gcc-14.1.0
um                    randconfig-002-20241009    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                       common_defconfig    gcc-14.1.0
xtensa                randconfig-001-20241009    gcc-14.1.0
xtensa                randconfig-002-20241009    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

