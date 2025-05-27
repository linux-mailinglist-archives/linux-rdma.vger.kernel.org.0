Return-Path: <linux-rdma+bounces-10767-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8595FAC5A3B
	for <lists+linux-rdma@lfdr.de>; Tue, 27 May 2025 20:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2163C1BA6209
	for <lists+linux-rdma@lfdr.de>; Tue, 27 May 2025 18:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580F71E261F;
	Tue, 27 May 2025 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Az0jjhvV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB7636D
	for <linux-rdma@vger.kernel.org>; Tue, 27 May 2025 18:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748371703; cv=none; b=Gsgda8eUDXKThIz2PxNZvGMLq+gELnmXXrmTz4WqNw812EnIToIyHn4pxIzfCKvr8p4Hmu8IvoTbZRibmNJx6gOuayWsQRCKDqwaSVw7cMisGSELdCrfXpHsKs2NyDZOO3rVxgPpVBbp+/sribBnPKghO2D6zzp8X4hIeQdXGhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748371703; c=relaxed/simple;
	bh=vo2j+Kh2ugC4KUgC6wsXpNvmm2MZzZvI55byXKKTjT0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=anRQFwh6n7Caj+4xX+l1KKYJ4B+MOLxAtdF+jKqGjFdmI3jzQZR9zoAA6iXKSXXtVyAejfupndW+ppCLwZUwQGZvnTCwE4bbd7qWWjJnNMEjLGJK52ZJ9I7VR8q8AXnZuHP/DsA23mZSMrasKGg2kobPnOBSkSKcS5/hOz1sIGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Az0jjhvV; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748371702; x=1779907702;
  h=date:from:to:cc:subject:message-id;
  bh=vo2j+Kh2ugC4KUgC6wsXpNvmm2MZzZvI55byXKKTjT0=;
  b=Az0jjhvVDJLOtCvzuV4fFUn3j6Rl7FR1LBi+15cM2dnXcxuwbrGCkQkS
   Mqgc89l0rID4WyciOJ8+718ryWxD6uoiB0iJahOiMuvnYKhtXFCpj0y1/
   4HnRwdPwZHd86yDqditbdoWRF2qxM65+aUWgjQU6papxFKs2nNAoJ/WY3
   nv0KuUL8U2ZWLKVYqtzUWcQ7rghfGmgJ5bqE7jXgGOlbi/Abbp1zZA3tv
   78N5y12cQx/YFp/hxr/SJzmMuFglrJcExT9o2Qij9hzW1Cp4AFbm3bDoA
   kHDVKRjgBfX6FoiuxPq3a34+3nyH1XmCA+YEmuA4XNn2Y4qbnYW6bSvKr
   A==;
X-CSE-ConnectionGUID: Z0drr7drTE2sLKRq3m0G2Q==
X-CSE-MsgGUID: 8D9tlx7qTBu+FGHJXJE/sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="72915514"
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; 
   d="scan'208";a="72915514"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 11:48:21 -0700
X-CSE-ConnectionGUID: 1QiTsyXwRcCti8Q4YvK6DA==
X-CSE-MsgGUID: t39DXlRpTPWSmUGLFcHEVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; 
   d="scan'208";a="173828786"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 27 May 2025 11:48:19 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uJzLV-000UuO-0p;
	Tue, 27 May 2025 18:48:17 +0000
Date: Wed, 28 May 2025 02:47:26 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 92a251c3df8ea1991cd9fe00f1ab0cfce18d7711
Message-ID: <202505280215.IrCwaJaT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 92a251c3df8ea1991cd9fe00f1ab0cfce18d7711  RDMA/cma: Fix hang when cma_netevent_callback fails to queue_work

elapsed time: 1443m

configs tested: 142
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              alldefconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                            hsdk_defconfig    gcc-14.2.0
arc                   randconfig-001-20250527    gcc-10.5.0
arc                   randconfig-002-20250527    gcc-10.5.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-21
arm                       imx_v4_v5_defconfig    clang-21
arm                             mxs_defconfig    clang-21
arm                   randconfig-001-20250527    clang-21
arm                   randconfig-002-20250527    gcc-7.5.0
arm                   randconfig-003-20250527    clang-19
arm                   randconfig-004-20250527    clang-21
arm                        realview_defconfig    clang-16
arm                        spear6xx_defconfig    clang-21
arm                           stm32_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250527    gcc-8.5.0
arm64                 randconfig-002-20250527    gcc-8.5.0
arm64                 randconfig-003-20250527    clang-16
arm64                 randconfig-004-20250527    gcc-6.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250527    gcc-12.4.0
csky                  randconfig-002-20250527    gcc-12.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250527    clang-21
hexagon               randconfig-002-20250527    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250527    gcc-12
i386        buildonly-randconfig-002-20250527    clang-20
i386        buildonly-randconfig-003-20250527    clang-20
i386        buildonly-randconfig-004-20250527    clang-20
i386        buildonly-randconfig-005-20250527    gcc-11
i386        buildonly-randconfig-006-20250527    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250527    gcc-15.1.0
loongarch             randconfig-002-20250527    gcc-15.1.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                         rt305x_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250527    gcc-14.2.0
nios2                 randconfig-002-20250527    gcc-10.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250527    gcc-9.3.0
parisc                randconfig-002-20250527    gcc-11.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                     ep8248e_defconfig    gcc-14.2.0
powerpc                   motionpro_defconfig    clang-21
powerpc                     ppa8548_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250527    gcc-6.5.0
powerpc               randconfig-002-20250527    clang-18
powerpc               randconfig-003-20250527    gcc-8.5.0
powerpc                     redwood_defconfig    clang-21
powerpc64             randconfig-001-20250527    clang-21
powerpc64             randconfig-002-20250527    clang-21
powerpc64             randconfig-003-20250527    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250527    gcc-8.5.0
riscv                 randconfig-002-20250527    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250527    gcc-6.5.0
s390                  randconfig-002-20250527    gcc-9.3.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                        dreamcast_defconfig    gcc-14.2.0
sh                    randconfig-001-20250527    gcc-10.5.0
sh                    randconfig-002-20250527    gcc-15.1.0
sh                          rsk7264_defconfig    gcc-14.2.0
sh                           se7705_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250527    gcc-11.5.0
sparc                 randconfig-002-20250527    gcc-7.5.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250527    gcc-5.5.0
sparc64               randconfig-002-20250527    gcc-7.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250527    clang-21
um                    randconfig-002-20250527    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250527    gcc-12
x86_64      buildonly-randconfig-002-20250527    clang-20
x86_64      buildonly-randconfig-003-20250527    gcc-12
x86_64      buildonly-randconfig-004-20250527    clang-20
x86_64      buildonly-randconfig-005-20250527    clang-20
x86_64      buildonly-randconfig-006-20250527    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250527    gcc-9.3.0
xtensa                randconfig-002-20250527    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

