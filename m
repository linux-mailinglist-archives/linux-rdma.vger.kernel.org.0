Return-Path: <linux-rdma+bounces-12933-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CFFB35A38
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 12:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6BB3A61F8
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 10:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2E22FE58A;
	Tue, 26 Aug 2025 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BTJJ1dV0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794E427CB04
	for <linux-rdma@vger.kernel.org>; Tue, 26 Aug 2025 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756204935; cv=none; b=FiwI86a/qFVhtIti8iZHWzKPwio53XFoF3/LWKJ1feD0Z7a4yj7Ls+OnQb6uXc0IZVmdNpqX+jWOMx2UCvsliWchI45DAjt72yffGj8MKkRW4XVUo1NrcM3Zm6dQIB5NKB3pZ/KA2FeSW+mDCThMQJvLxK8K18ICI1u3hcM6HAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756204935; c=relaxed/simple;
	bh=5dbTSQew3Yuz2Up+53AwvP5nLeAuU1UGNoBFjoUO7H4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=N/d+jKobjIbYgg2NTt2ppjZuIRzT8iR024mmCJ86Hs8Vrng8dx/cbnlbjwqyvcDIGfeGYh43AgvpzeT3pU4Z+4U9m44xsmVSC4lBSvebu/lF+GpoZhu1MWjcWDjmsQz6QBRAonLoO9A9BEy4XcYd5N8jO1/grCjoeeYRvMTNCb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BTJJ1dV0; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756204933; x=1787740933;
  h=date:from:to:cc:subject:message-id;
  bh=5dbTSQew3Yuz2Up+53AwvP5nLeAuU1UGNoBFjoUO7H4=;
  b=BTJJ1dV0xKj8CdrPm9zCU5z4aBOtTVkuoDK0uwHKvfK9FPxZPhV8JJHB
   hFhoN/fEvXYtWxGM6gmjNiaFaV/kouiDXdhcuEm77vBtDZ1FaWdhFQKxJ
   k/Q6F88VCuHfz/0cQH1rHd/U41Rav5zQEMSKSs5wLNPJbY2bOuu9JmH7K
   5Q4jbrvBndz43GNhM9Nr1yRFZ+LyikdUxM0vVant0YsF7nUJQC2Bf4Y3+
   PJ3KdJ9pDh3+cVOrxwDwvHq3/1/HWMjx8Z0Njba73OHccPkz0vewlmZy4
   nSCbXDyFqO9m1jUtWMcuxzHSgjchK5m9hd+WwLr/pMxFp7BUt8Uetd6ar
   A==;
X-CSE-ConnectionGUID: s4uguzHESMeE4Z3GjpeP2A==
X-CSE-MsgGUID: UiLhwpTdT6iAvd3EH74RHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="69870838"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="69870838"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 03:42:13 -0700
X-CSE-ConnectionGUID: cmIQKUUNSxCvxrOHzyMjsQ==
X-CSE-MsgGUID: 0+1ShY5/TnOMvLMDygh1Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169471913"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 26 Aug 2025 03:42:12 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uqr7x-000OQ3-1u;
	Tue, 26 Aug 2025 10:42:09 +0000
Date: Tue, 26 Aug 2025 18:41:51 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 85fe9f565d2d5af95ac2bbaa5082b8ce62b039f5
Message-ID: <202508261836.mckMBfAo-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-rc
branch HEAD: 85fe9f565d2d5af95ac2bbaa5082b8ce62b039f5  IB/mlx5: Fix obj_type mismatch for SRQ event subscriptions

elapsed time: 961m

configs tested: 128
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250826    gcc-11.5.0
arc                   randconfig-002-20250826    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250826    gcc-12.5.0
arm                   randconfig-002-20250826    gcc-13.4.0
arm                   randconfig-003-20250826    gcc-8.5.0
arm                   randconfig-004-20250826    gcc-10.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250826    clang-22
arm64                 randconfig-002-20250826    gcc-8.5.0
arm64                 randconfig-003-20250826    clang-22
arm64                 randconfig-004-20250826    gcc-8.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250826    gcc-15.1.0
csky                  randconfig-002-20250826    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250826    clang-19
hexagon               randconfig-002-20250826    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250826    gcc-12
i386        buildonly-randconfig-002-20250826    gcc-12
i386        buildonly-randconfig-003-20250826    clang-20
i386        buildonly-randconfig-004-20250826    gcc-12
i386        buildonly-randconfig-005-20250826    clang-20
i386        buildonly-randconfig-006-20250826    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250826    gcc-11
i386                  randconfig-002-20250826    gcc-11
i386                  randconfig-003-20250826    gcc-11
i386                  randconfig-004-20250826    gcc-11
i386                  randconfig-005-20250826    gcc-11
i386                  randconfig-006-20250826    gcc-11
i386                  randconfig-007-20250826    gcc-11
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250826    gcc-14.3.0
loongarch             randconfig-002-20250826    gcc-14.3.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250826    gcc-8.5.0
nios2                 randconfig-002-20250826    gcc-10.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250826    gcc-8.5.0
parisc                randconfig-002-20250826    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250826    gcc-8.5.0
powerpc               randconfig-002-20250826    clang-22
powerpc               randconfig-003-20250826    gcc-13.4.0
powerpc64             randconfig-001-20250826    gcc-10.5.0
powerpc64             randconfig-002-20250826    gcc-11.5.0
powerpc64             randconfig-003-20250826    gcc-14.3.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250826    gcc-8.5.0
riscv                 randconfig-002-20250826    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250826    clang-22
s390                  randconfig-002-20250826    clang-18
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250826    gcc-11.5.0
sh                    randconfig-002-20250826    gcc-9.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250826    gcc-13.4.0
sparc                 randconfig-002-20250826    gcc-8.5.0
sparc64               randconfig-001-20250826    gcc-8.5.0
sparc64               randconfig-002-20250826    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250826    gcc-12
um                    randconfig-002-20250826    clang-17
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250826    clang-20
x86_64      buildonly-randconfig-002-20250826    clang-20
x86_64      buildonly-randconfig-003-20250826    gcc-12
x86_64      buildonly-randconfig-004-20250826    clang-20
x86_64      buildonly-randconfig-005-20250826    gcc-12
x86_64      buildonly-randconfig-006-20250826    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250826    gcc-11.5.0
xtensa                randconfig-002-20250826    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

