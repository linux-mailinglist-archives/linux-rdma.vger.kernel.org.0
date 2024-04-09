Return-Path: <linux-rdma+bounces-1859-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71BB89CF30
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Apr 2024 02:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C97051C2104F
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Apr 2024 00:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02809370;
	Tue,  9 Apr 2024 00:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E61hXCUe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF1419A
	for <linux-rdma@vger.kernel.org>; Tue,  9 Apr 2024 00:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712621350; cv=none; b=jCo6DonC+dOJtHmN3Obq1kXEpvCSd7HjUWE5P5dR/zFVgwbODYTjNkwzlB7dgYhF8JxgH21MXDakOuFXhrFyci5tMWk+DR1A5fwdQd+gpcw2Dylu2lqj5iNYHE+hEUDYB8qMYzqBuGgT+CMA0s6adzQubXNOgqfDpWlPzbTlb2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712621350; c=relaxed/simple;
	bh=uTPdRPguuq1Q+0iFDSVESFGV/oYIqx3+m9jFle4Y3L8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CWHRApgTwTJ48mrv2x6ZXWUvwUjmcLp3Kme+6RJEOkkAM13e/LyWVzWAW0kzvLpKqHt+URQ8zraXnO34o/S2q1zkAufQz+h+wGSiK7BtzGWMhBnr2K5mtrT4XTAaKLLRyccCrqDyky1uz5pNxHlfeBoWCnTZ+W+s+rCsgDrlfZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E61hXCUe; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712621349; x=1744157349;
  h=date:from:to:cc:subject:message-id;
  bh=uTPdRPguuq1Q+0iFDSVESFGV/oYIqx3+m9jFle4Y3L8=;
  b=E61hXCUegv7PX5Ozsr06a5pRrNmZdOcr9cAYvKflvPDI9LO/jPnP8nk+
   jtPZGCfGglxG0clEyYmygECGo9eOgpgy0XB2BQRUPpLJQZRzKjxlKtFCJ
   60hQoRhgxGGcZKqAhGxigHxd6wgFI01onVHTEDy/L70HrDV983PAQ6STv
   g4ZQeDI7P8ydNR2YMG4rSyyy7k7gaCgUKBpc96MZh9O24Lj6yTx6VPADL
   PswDjzkKpOCPe6FYdfWJi7t27E5ZJJm+0tVHLegsKQXuSh6OHIRd3ES2x
   jXVXLQU2Ajw68/ITvlmjbfJSTO7+ua4TTIxLrjIzFNJnQC3Nh1VAfq3eB
   A==;
X-CSE-ConnectionGUID: kw9w8Gh1Q6iANZs3Y9gJeA==
X-CSE-MsgGUID: L9zVIRsRSfaRYpAbQDqtIg==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="10897756"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="10897756"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 17:09:08 -0700
X-CSE-ConnectionGUID: eJ70B7GiR0iT9Uhiz1A44g==
X-CSE-MsgGUID: KjK3mkVKQXKuOphodqyaEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="24536769"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 08 Apr 2024 17:09:06 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rtz2u-0005ZS-1h;
	Tue, 09 Apr 2024 00:09:04 +0000
Date: Tue, 09 Apr 2024 08:08:48 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS WITH WARNING
 c3236d538646c8e333370d71cb1d1e37e8996eaf
Message-ID: <202404090846.K3NBrnkh-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: c3236d538646c8e333370d71cb1d1e37e8996eaf  RDMA/hns: Support DSCP

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202404090005.YRqvDvXD-lkp@intel.com

Warning: (recently discovered and may have been fixed)

drivers/infiniband/hw/hns/hns_roce_ah.c:65:13: warning: unused variable 'max_sl' [-Wunused-variable]
drivers/infiniband/hw/hns/hns_roce_hw_v2.c:4864:13: warning: unused variable 'sl_num' [-Wunused-variable]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- loongarch-allmodconfig
|   |-- drivers-infiniband-hw-hns-hns_roce_ah.c:warning:unused-variable-max_sl
|   `-- drivers-infiniband-hw-hns-hns_roce_hw_v2.c:warning:unused-variable-sl_num
|-- powerpc-allmodconfig
|   |-- drivers-infiniband-hw-hns-hns_roce_ah.c:warning:unused-variable-max_sl
|   `-- drivers-infiniband-hw-hns-hns_roce_hw_v2.c:warning:unused-variable-sl_num
|-- s390-allyesconfig
|   |-- drivers-infiniband-hw-hns-hns_roce_ah.c:warning:unused-variable-max_sl
|   `-- drivers-infiniband-hw-hns-hns_roce_hw_v2.c:warning:unused-variable-sl_num
|-- sparc-allmodconfig
|   |-- drivers-infiniband-hw-hns-hns_roce_ah.c:warning:unused-variable-max_sl
|   `-- drivers-infiniband-hw-hns-hns_roce_hw_v2.c:warning:unused-variable-sl_num
|-- sparc64-allmodconfig
|   |-- drivers-infiniband-hw-hns-hns_roce_ah.c:warning:unused-variable-max_sl
|   `-- drivers-infiniband-hw-hns-hns_roce_hw_v2.c:warning:unused-variable-sl_num
`-- sparc64-allyesconfig
    |-- drivers-infiniband-hw-hns-hns_roce_ah.c:warning:unused-variable-max_sl
    `-- drivers-infiniband-hw-hns-hns_roce_hw_v2.c:warning:unused-variable-sl_num
clang_recent_errors
|-- arm64-allmodconfig
|   |-- drivers-infiniband-hw-hns-hns_roce_ah.c:warning:unused-variable-max_sl
|   `-- drivers-infiniband-hw-hns-hns_roce_hw_v2.c:warning:unused-variable-sl_num
|-- powerpc-allyesconfig
|   |-- drivers-infiniband-hw-hns-hns_roce_ah.c:warning:unused-variable-max_sl
|   `-- drivers-infiniband-hw-hns-hns_roce_hw_v2.c:warning:unused-variable-sl_num
|-- riscv-allmodconfig
|   |-- drivers-infiniband-hw-hns-hns_roce_ah.c:warning:unused-variable-max_sl
|   `-- drivers-infiniband-hw-hns-hns_roce_hw_v2.c:warning:unused-variable-sl_num
|-- riscv-allyesconfig
|   |-- drivers-infiniband-hw-hns-hns_roce_ah.c:warning:unused-variable-max_sl
|   `-- drivers-infiniband-hw-hns-hns_roce_hw_v2.c:warning:unused-variable-sl_num
`-- s390-allmodconfig
    |-- drivers-infiniband-hw-hns-hns_roce_ah.c:warning:unused-variable-max_sl
    `-- drivers-infiniband-hw-hns-hns_roce_hw_v2.c:warning:unused-variable-sl_num

elapsed time: 721m

configs tested: 139
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240409   gcc  
arc                   randconfig-002-20240409   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240409   gcc  
arm                   randconfig-002-20240409   clang
arm                   randconfig-003-20240409   clang
arm                   randconfig-004-20240409   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240409   gcc  
arm64                 randconfig-002-20240409   gcc  
arm64                 randconfig-003-20240409   clang
arm64                 randconfig-004-20240409   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240409   gcc  
csky                  randconfig-002-20240409   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240409   clang
hexagon               randconfig-002-20240409   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240409   clang
i386         buildonly-randconfig-002-20240409   clang
i386         buildonly-randconfig-003-20240409   gcc  
i386         buildonly-randconfig-004-20240409   clang
i386         buildonly-randconfig-005-20240409   gcc  
i386         buildonly-randconfig-006-20240409   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240409   clang
i386                  randconfig-002-20240409   gcc  
i386                  randconfig-003-20240409   clang
i386                  randconfig-004-20240409   gcc  
i386                  randconfig-005-20240409   gcc  
i386                  randconfig-006-20240409   clang
i386                  randconfig-011-20240409   gcc  
i386                  randconfig-012-20240409   clang
i386                  randconfig-013-20240409   clang
i386                  randconfig-014-20240409   clang
i386                  randconfig-015-20240409   gcc  
i386                  randconfig-016-20240409   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240409   gcc  
loongarch             randconfig-002-20240409   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240409   gcc  
nios2                 randconfig-002-20240409   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240409   gcc  
parisc                randconfig-002-20240409   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240409   clang
powerpc               randconfig-002-20240409   gcc  
powerpc               randconfig-003-20240409   clang
powerpc64             randconfig-001-20240409   gcc  
powerpc64             randconfig-002-20240409   clang
powerpc64             randconfig-003-20240409   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240409   clang
riscv                 randconfig-002-20240409   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240409   gcc  
s390                  randconfig-002-20240409   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240409   gcc  
sh                    randconfig-002-20240409   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240409   gcc  
sparc64               randconfig-002-20240409   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240409   clang
um                    randconfig-002-20240409   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240409   gcc  
xtensa                randconfig-002-20240409   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

