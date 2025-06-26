Return-Path: <linux-rdma+bounces-11649-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C233EAE935E
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 02:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C50D1887066
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 00:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4563778F52;
	Thu, 26 Jun 2025 00:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OS77Vn+J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D14B2AD13
	for <linux-rdma@vger.kernel.org>; Thu, 26 Jun 2025 00:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750897431; cv=none; b=jft9p8HwW3HQu4GtCx/cGF7L6HSDmtUkqFx4facd0qzWPz7vNbRtpa/crCkbDMCj0xwoDrVOVAlWtFTpy7yPR45VT+TFsN9gfB8O6WNxJjXX5kZmZpys2MMWxHiNpj61pJfh6hvR7KePIOZrtFQQGXi1oPSPzEkhvb4usx6eWac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750897431; c=relaxed/simple;
	bh=ws3OWlIAY5IXh725G54JxRpxDXUmdJ8xloK2UVYOaK0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=e/lkQ8jvvJoJzXfJX6SQCzTWh4JHBROH9JAc4Hhh4UEG0y4vYhjE5MZgYN19+zFiC6nFssim7rlMp/IZC8l7oQijcerJhrU5R+gR5GPQjoc0ly/Ee/XS3WbuMp+u4VelemvJBGj9T5uMD5Kb2vCS3Z1w76X6NwDSnW3t849bTQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OS77Vn+J; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750897429; x=1782433429;
  h=date:from:to:cc:subject:message-id;
  bh=ws3OWlIAY5IXh725G54JxRpxDXUmdJ8xloK2UVYOaK0=;
  b=OS77Vn+JIl+Rnn/suim1UkQLTWz7nm4QR8mC2Q/3eN7MVZBG6eBsyEYr
   JpTnz7w4GJq40ngmh5JFOINvFaqj4n7zWz6qULLtR8cOMUU+co7uK2wH4
   x/T25VL029Gl3LCAWEThZ44cQ+CoGAZfqFuzjbI/cGy9HYoknNDVrgKu5
   9gxAsJnm3jk+HDNEyv1yaBudm3eTR3ZqBmFBGEIc4BZ9ixn0xbBUMb03w
   Qcrg9FULmtc75tVehnRcmo9IxOkQflKFS+vn9d9tRqKyX8aCwWP9BpvmU
   itUam9oLRZNL72vYsKCDtjmDeh+Vw8EYm118ogh0/nsjrD/VkPIJt5wx5
   Q==;
X-CSE-ConnectionGUID: ++XUVfDsRj2piYfl7ged/w==
X-CSE-MsgGUID: eUY8teUvT+a7FsH10b3Q+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="52410289"
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="52410289"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 17:23:49 -0700
X-CSE-ConnectionGUID: N3TYaiSdRTmpPycAdpcA8A==
X-CSE-MsgGUID: Zkf2XCn2QS6JOD0FK/QisQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="153084358"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 25 Jun 2025 17:23:47 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUaP3-000TZI-1B;
	Thu, 26 Jun 2025 00:23:45 +0000
Date: Thu, 26 Jun 2025 08:23:41 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 a9a9e68954f29b1e197663f76289db4879fd51bb
Message-ID: <202506260831.2gzkjeN4-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: a9a9e68954f29b1e197663f76289db4879fd51bb  RDMA/mlx5: Fix vport loopback for MPV device

elapsed time: 940m

configs tested: 106
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                   randconfig-001-20250625    gcc-11.5.0
arc                   randconfig-001-20250626    clang-20
arc                   randconfig-002-20250625    gcc-12.4.0
arc                   randconfig-002-20250626    clang-20
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                   randconfig-001-20250625    clang-21
arm                   randconfig-001-20250626    clang-20
arm                   randconfig-002-20250625    gcc-11.5.0
arm                   randconfig-002-20250626    clang-20
arm                   randconfig-003-20250625    gcc-13.3.0
arm                   randconfig-003-20250626    clang-20
arm                   randconfig-004-20250625    gcc-15.1.0
arm                   randconfig-004-20250626    clang-20
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250625    gcc-11.5.0
arm64                 randconfig-001-20250626    clang-20
arm64                 randconfig-002-20250625    clang-20
arm64                 randconfig-002-20250626    clang-20
arm64                 randconfig-003-20250625    gcc-12.3.0
arm64                 randconfig-003-20250626    clang-20
arm64                 randconfig-004-20250625    clang-20
arm64                 randconfig-004-20250626    clang-20
csky                              allnoconfig    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-21
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250625    clang-20
i386        buildonly-randconfig-002-20250625    gcc-12
i386        buildonly-randconfig-003-20250625    gcc-12
i386        buildonly-randconfig-004-20250625    gcc-12
i386        buildonly-randconfig-005-20250625    clang-20
i386        buildonly-randconfig-006-20250625    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250625    gcc-12
x86_64      buildonly-randconfig-001-20250626    clang-20
x86_64      buildonly-randconfig-002-20250625    clang-20
x86_64      buildonly-randconfig-002-20250626    clang-20
x86_64      buildonly-randconfig-003-20250625    clang-20
x86_64      buildonly-randconfig-003-20250626    clang-20
x86_64      buildonly-randconfig-004-20250625    clang-20
x86_64      buildonly-randconfig-004-20250626    clang-20
x86_64      buildonly-randconfig-005-20250625    clang-20
x86_64      buildonly-randconfig-005-20250626    clang-20
x86_64      buildonly-randconfig-006-20250625    clang-20
x86_64      buildonly-randconfig-006-20250626    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

