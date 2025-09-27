Return-Path: <linux-rdma+bounces-13680-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC3EBA6206
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Sep 2025 19:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38833AB21B
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Sep 2025 17:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00C9225403;
	Sat, 27 Sep 2025 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eyc37pbL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067B21632C8
	for <linux-rdma@vger.kernel.org>; Sat, 27 Sep 2025 17:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758993516; cv=none; b=Z+xAuff1DPAOC2mXA9gyyNuwnxM0iOSkHrgo+HNE6Q083SSRRr1V8xz7dnHG4KPiK9f2FdV4NQG7OflucAMFr70hNhNiC4lInnMMUuOu5JTgAA9ANWbYDuNa6k1FGZ6Bwh+naSZUxe6eSZW9bFmFoxNbRro+in5MU7qihJU1xzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758993516; c=relaxed/simple;
	bh=8mhwQKE8ttGfsaEonbnSyD8/ON4f3F3OL0P6FrCuVzc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pEPayPzbVdfnEurT51LbZN7QXkeBk0oFkQB2u24shhYf20j3hnmxEwJhWZPQuTi+ZWVaTMPXZbi+P5yDA4/eNj7jNSD4A3fr+bkbmFbWUFlO47rG445L3/AIWrvMWamF2EDXSsxFLiRKuMcGpf4t36NVwY2dotekHL6GlA5UrXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eyc37pbL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758993515; x=1790529515;
  h=date:from:to:cc:subject:message-id;
  bh=8mhwQKE8ttGfsaEonbnSyD8/ON4f3F3OL0P6FrCuVzc=;
  b=eyc37pbLC3r4s5Y5b8UOH2TuUWbYF0XccbEyQ3K1wmW9g3ny7uGAWRWs
   DNAZT+IltSAdaCkRLNdsitJMogN7xOnmvkVbqWmlXGZQKuRxyAKjZlg1i
   T0dKez61IGdV9jbTjlzVHDYCa+NUy23ESUyXNf9fDIDXZ9LetlHesTz68
   shiU4pFqJt5S/nehd70191vfO2mqM2Vfh3x/uYifnUJdQ29orv79pi6BC
   uP1dLEDbz7ZUvnCIAqz5W1iSfI76IH4Kdj3jObnkAb+Csc0iKhRZOBaQW
   MaIx0YtLNU0leO1yggNZ39FkcsttFYxIw7O5ux4Crt9SBO/Tnwfv5gVtV
   g==;
X-CSE-ConnectionGUID: Fy426+UqT7S4bNyteI19Fw==
X-CSE-MsgGUID: r1F186UhTdqffvw7xempbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61208355"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61208355"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2025 10:18:34 -0700
X-CSE-ConnectionGUID: LACSePA/SkyXRfWaKnC2ug==
X-CSE-MsgGUID: 29OZE68WS7ikDHX2ehVWeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,298,1751266800"; 
   d="scan'208";a="177447863"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 27 Sep 2025 10:18:33 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v2YZ0-0007EZ-0G;
	Sat, 27 Sep 2025 17:18:27 +0000
Date: Sun, 28 Sep 2025 01:17:37 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 e6d736bd08902ba53460df1b62ee4218bbd17d9b
Message-ID: <202509280130.Urn0P7RZ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: e6d736bd08902ba53460df1b62ee4218bbd17d9b  RDMA/ionic: Fix memory leak of admin q_wr

elapsed time: 1457m

configs tested: 112
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250927    gcc-10.5.0
arc                   randconfig-002-20250927    gcc-13.4.0
arm                               allnoconfig    clang-22
arm                          ixp4xx_defconfig    gcc-15.1.0
arm                            mps2_defconfig    clang-22
arm                             mxs_defconfig    clang-22
arm                   randconfig-001-20250927    clang-18
arm                   randconfig-002-20250927    clang-16
arm                   randconfig-003-20250927    gcc-8.5.0
arm                   randconfig-004-20250927    gcc-10.5.0
arm                        vexpress_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250927    gcc-8.5.0
arm64                 randconfig-002-20250927    gcc-11.5.0
arm64                 randconfig-003-20250927    clang-22
arm64                 randconfig-004-20250927    gcc-9.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250927    gcc-15.1.0
csky                  randconfig-002-20250927    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250927    clang-22
hexagon               randconfig-002-20250927    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20250927    clang-20
i386        buildonly-randconfig-002-20250927    gcc-14
i386        buildonly-randconfig-003-20250927    clang-20
i386        buildonly-randconfig-004-20250927    clang-20
i386        buildonly-randconfig-005-20250927    gcc-12
i386        buildonly-randconfig-006-20250927    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250927    gcc-15.1.0
loongarch             randconfig-002-20250927    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250927    gcc-9.5.0
nios2                 randconfig-002-20250927    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250927    gcc-9.5.0
parisc                randconfig-002-20250927    gcc-11.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      ep88xc_defconfig    gcc-15.1.0
powerpc                 mpc834x_itx_defconfig    clang-16
powerpc               randconfig-001-20250927    gcc-13.4.0
powerpc               randconfig-002-20250927    clang-22
powerpc               randconfig-003-20250927    gcc-8.5.0
powerpc                     tqm8555_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250927    clang-22
powerpc64             randconfig-002-20250927    gcc-15.1.0
powerpc64             randconfig-003-20250927    gcc-12.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv             nommu_k210_sdcard_defconfig    gcc-15.1.0
riscv                 randconfig-001-20250927    clang-22
riscv                 randconfig-002-20250927    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250927    clang-22
s390                  randconfig-002-20250927    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250927    gcc-15.1.0
sh                    randconfig-002-20250927    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250927    gcc-11.5.0
sparc                 randconfig-002-20250927    gcc-11.5.0
sparc64               randconfig-001-20250927    gcc-15.1.0
sparc64               randconfig-002-20250927    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20250927    gcc-14
um                    randconfig-002-20250927    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250927    gcc-14
x86_64      buildonly-randconfig-002-20250927    clang-20
x86_64      buildonly-randconfig-003-20250927    clang-20
x86_64      buildonly-randconfig-004-20250927    gcc-14
x86_64      buildonly-randconfig-005-20250927    gcc-14
x86_64      buildonly-randconfig-006-20250927    clang-20
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250927    gcc-8.5.0
xtensa                randconfig-002-20250927    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

