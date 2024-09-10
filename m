Return-Path: <linux-rdma+bounces-4866-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57374973D2A
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 18:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 144A8287A14
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 16:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC4019E81F;
	Tue, 10 Sep 2024 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KD8lm8iJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED1E192B61
	for <linux-rdma@vger.kernel.org>; Tue, 10 Sep 2024 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985437; cv=none; b=CgTXNzkNVJ8tglIQsmy6uzvIhHBUpdvr8RE7XfRGEZFE4AHWF02dwNhuXiSKfXG8743hJKpHh+1Ebmu3/PER4Qbsc2qimo4hMwxZxAKHKv63srfTD0azJp4gX88uRWzN3pJMJVHbeO+Mnks/0WBCI18vs2xxt2oXzUdXGj4H1b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985437; c=relaxed/simple;
	bh=h3SPMQxeJ1YesMYlUkNZAkotSrGRjECkWmhzI5eHoAw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=C9vWlbSgoCVl9P5EhOcyXiGYDRqvW1z7fYzkZMM/SOM4PfY7/Xg1vaFQnfAT+uMhTW/G55cpDIOOADdJXZMvdLg6fyRrO3NfSiUpjZSL4kpMcnneINfOek5YCWdsOtBp4p7Hx15Cc5rWihlcYYI6MFUUzxMgWGE+5ArRQbBg3RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KD8lm8iJ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725985436; x=1757521436;
  h=date:from:to:cc:subject:message-id;
  bh=h3SPMQxeJ1YesMYlUkNZAkotSrGRjECkWmhzI5eHoAw=;
  b=KD8lm8iJgiMkDso1Er6K9bYOffqb3gDpm0mV5t1j3tuk2oisJXxVooZ2
   /LLSRs5FmQnD/P9WqB5NWakBWtjKBAHeZAZnZa9CdJj6YPjGnXYFF3YC3
   ZzSOMKbIYtoDyspjS21XcjDZ/dcOUCnygVW9SNLpFQFKwPGRUOONujX+L
   PG4UYNmQLi+a5e168KlMWAJgnNVT3n2vIch58aEwnZPEE8qtBvgj4B4d7
   T9Z1/xUAG+RgGxUZk/siHTAu81kNfqRdolSuFq+4TC3quFsJzQtaY+eCC
   ONccsU+TuphZY1Q9+KVCfzQkncitJcEIkEprru7acpc4xpE2HX3KhLE4G
   Q==;
X-CSE-ConnectionGUID: E0bAf9FVQyitWzBeVG9xog==
X-CSE-MsgGUID: yKncHgjPR+2ToZJfjDY93Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35340715"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="35340715"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 09:23:55 -0700
X-CSE-ConnectionGUID: L1C4pcvKTemmnZ3jhIiv/Q==
X-CSE-MsgGUID: LK2HNoXwQZ6m+RK6YUXkYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="72057127"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 10 Sep 2024 09:23:53 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1so3eg-0002MQ-2T;
	Tue, 10 Sep 2024 16:23:50 +0000
Date: Wed, 11 Sep 2024 00:23:05 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 227f51743b61fe3f6fc481f0fb8086bf8c49b8c9
Message-ID: <202409110003.8hu0SBy6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 227f51743b61fe3f6fc481f0fb8086bf8c49b8c9  RDMA/bnxt_re: Fix the max WQE size for static WQE support

elapsed time: 1295m

configs tested: 168
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                                 defconfig   gcc-14.1.0
arc                   randconfig-001-20240910   gcc-13.2.0
arc                   randconfig-002-20240910   gcc-13.2.0
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                         at91_dt_defconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                      integrator_defconfig   clang-20
arm                      jornada720_defconfig   clang-20
arm                   randconfig-001-20240910   gcc-13.2.0
arm                   randconfig-002-20240910   gcc-13.2.0
arm                   randconfig-003-20240910   gcc-13.2.0
arm                   randconfig-004-20240910   gcc-13.2.0
arm                           sama7_defconfig   clang-20
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240910   gcc-13.2.0
arm64                 randconfig-002-20240910   gcc-13.2.0
arm64                 randconfig-003-20240910   gcc-13.2.0
arm64                 randconfig-004-20240910   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240910   gcc-13.2.0
csky                  randconfig-002-20240910   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
hexagon               randconfig-001-20240910   gcc-13.2.0
hexagon               randconfig-002-20240910   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240910   clang-18
i386         buildonly-randconfig-002-20240910   clang-18
i386         buildonly-randconfig-003-20240910   clang-18
i386         buildonly-randconfig-004-20240910   clang-18
i386         buildonly-randconfig-005-20240910   clang-18
i386         buildonly-randconfig-006-20240910   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240910   clang-18
i386                  randconfig-002-20240910   clang-18
i386                  randconfig-003-20240910   clang-18
i386                  randconfig-004-20240910   clang-18
i386                  randconfig-005-20240910   clang-18
i386                  randconfig-006-20240910   clang-18
i386                  randconfig-011-20240910   clang-18
i386                  randconfig-012-20240910   clang-18
i386                  randconfig-013-20240910   clang-18
i386                  randconfig-014-20240910   clang-18
i386                  randconfig-015-20240910   clang-18
i386                  randconfig-016-20240910   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240910   gcc-13.2.0
loongarch             randconfig-002-20240910   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                          amiga_defconfig   clang-20
m68k                                defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                     loongson2k_defconfig   clang-20
mips                      pic32mzda_defconfig   clang-20
mips                       rbtx49xx_defconfig   clang-20
mips                           xway_defconfig   clang-20
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240910   gcc-13.2.0
nios2                 randconfig-002-20240910   gcc-13.2.0
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc                randconfig-001-20240910   gcc-13.2.0
parisc                randconfig-002-20240910   gcc-13.2.0
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      bamboo_defconfig   clang-20
powerpc                       eiger_defconfig   clang-20
powerpc                  iss476-smp_defconfig   clang-20
powerpc               randconfig-001-20240910   gcc-13.2.0
powerpc               randconfig-002-20240910   gcc-13.2.0
powerpc               randconfig-003-20240910   gcc-13.2.0
powerpc64             randconfig-001-20240910   gcc-13.2.0
powerpc64             randconfig-002-20240910   gcc-13.2.0
powerpc64             randconfig-003-20240910   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
riscv                 randconfig-001-20240910   gcc-13.2.0
riscv                 randconfig-002-20240910   gcc-13.2.0
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
s390                  randconfig-001-20240910   gcc-13.2.0
s390                  randconfig-002-20240910   gcc-13.2.0
s390                       zfcpdump_defconfig   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                    randconfig-001-20240910   gcc-13.2.0
sh                    randconfig-002-20240910   gcc-13.2.0
sh                        sh7785lcr_defconfig   clang-20
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
sparc64               randconfig-001-20240910   gcc-13.2.0
sparc64               randconfig-002-20240910   gcc-13.2.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240910   gcc-13.2.0
um                    randconfig-002-20240910   gcc-13.2.0
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240910   gcc-12
x86_64       buildonly-randconfig-002-20240910   gcc-12
x86_64       buildonly-randconfig-003-20240910   gcc-12
x86_64       buildonly-randconfig-004-20240910   gcc-12
x86_64       buildonly-randconfig-005-20240910   gcc-12
x86_64       buildonly-randconfig-006-20240910   gcc-12
x86_64                              defconfig   clang-18
x86_64                randconfig-001-20240910   gcc-12
x86_64                randconfig-002-20240910   gcc-12
x86_64                randconfig-003-20240910   gcc-12
x86_64                randconfig-004-20240910   gcc-12
x86_64                randconfig-005-20240910   gcc-12
x86_64                randconfig-006-20240910   gcc-12
x86_64                randconfig-011-20240910   gcc-12
x86_64                randconfig-012-20240910   gcc-12
x86_64                randconfig-013-20240910   gcc-12
x86_64                randconfig-014-20240910   gcc-12
x86_64                randconfig-015-20240910   gcc-12
x86_64                randconfig-016-20240910   gcc-12
x86_64                randconfig-071-20240910   gcc-12
x86_64                randconfig-072-20240910   gcc-12
x86_64                randconfig-073-20240910   gcc-12
x86_64                randconfig-074-20240910   gcc-12
x86_64                randconfig-075-20240910   gcc-12
x86_64                randconfig-076-20240910   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240910   gcc-13.2.0
xtensa                randconfig-002-20240910   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

