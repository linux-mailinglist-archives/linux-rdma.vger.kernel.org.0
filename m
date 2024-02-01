Return-Path: <linux-rdma+bounces-851-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE48844D9C
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Feb 2024 01:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49851C24B0B
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Feb 2024 00:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38292374;
	Thu,  1 Feb 2024 00:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PWSTj4fx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127FC37A
	for <linux-rdma@vger.kernel.org>; Thu,  1 Feb 2024 00:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706746184; cv=none; b=XES9wIsdlU1dDVxCVlNj3fKTnnxuApyFdtZ1NM0JHQ6rulrq/V4pQrSuK5ZnKd1rsQyVtqdnO/o7Mv3yJb17bsVLDRJZZZE/fXdpQCeDRL8x3QClPEhPnwIcr70GobL1eiqthTBXlsqvJGYA1OujsCSoGs+cKHaaYMvpbXjkbFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706746184; c=relaxed/simple;
	bh=epTqTUZ4kX47S29ETRRSAPW/LIcqPUdKzJ93lZFUavs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Fguw09TzZe3AAZQOzxB5lNxQGFWTU+5V7vtFtQYw5Bh3PDXI7hvJGNJL8K3GgQ7QqCwFGIqtgicW6WAUN2ux+UtGGgpN/3Z34daoj+dzypbu6D9LNZjcHLbR1bhzVKBmEeyq+/pAPY3ISBF2vSa0BoQmQ8SEzRtDF9ZAgeaaSnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PWSTj4fx; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706746182; x=1738282182;
  h=date:from:to:cc:subject:message-id;
  bh=epTqTUZ4kX47S29ETRRSAPW/LIcqPUdKzJ93lZFUavs=;
  b=PWSTj4fxc3R95ni8voKDoKZlBUymvbVVsZ8FkYVLwAZP7sbNxxO+2BWR
   Tc6SYMYslaLBnHdvw17cvLNXY7AMCHQ+aCYwvroaie13yxAtwXUbTRDFO
   Ki7DjaHGi0m5Zv7eYIJXMl2Ku/FPJZAcrNM+eUDuZnknNk85soe5FQFw8
   M/zVKzjsRNOqt00xKV4Hz89vCaUBhpOlYCTxNzOTmgfDWe0RMmXkTAPTv
   NQXb+Z+qagbG9mfFF9WoEhUTecnuxxsb1LjcfjTXq/iBXPb3Shr/FK3Zi
   RvPtpMyqtxjuFJSTKLgoB6n4rap5olqBOFXNuaokQvsVgZaEegkEjU2gy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3600939"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="3600939"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 16:09:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="858979631"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="858979631"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 31 Jan 2024 16:09:39 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rVKe1-0002BG-0N;
	Thu, 01 Feb 2024 00:09:33 +0000
Date: Thu, 01 Feb 2024 08:08:40 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 be551ee1574280ef8afbf7c271212ac3e38933ef
Message-ID: <202402010837.rrs4iqL7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: be551ee1574280ef8afbf7c271212ac3e38933ef  RDMA/mlx5: Relax DEVX access upon modify commands

elapsed time: 876m

configs tested: 206
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240131   gcc  
arc                   randconfig-001-20240201   gcc  
arc                   randconfig-002-20240131   gcc  
arc                   randconfig-002-20240201   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   clang
arm                          gemini_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                   randconfig-001-20240201   gcc  
arm                   randconfig-002-20240201   gcc  
arm                   randconfig-003-20240201   gcc  
arm                   randconfig-004-20240201   gcc  
arm                        spear6xx_defconfig   gcc  
arm                           stm32_defconfig   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            alldefconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240201   gcc  
arm64                 randconfig-002-20240201   gcc  
arm64                 randconfig-003-20240201   gcc  
arm64                 randconfig-004-20240201   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240131   gcc  
csky                  randconfig-001-20240201   gcc  
csky                  randconfig-002-20240131   gcc  
csky                  randconfig-002-20240201   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240201   gcc  
i386         buildonly-randconfig-002-20240201   gcc  
i386         buildonly-randconfig-003-20240201   gcc  
i386         buildonly-randconfig-004-20240201   gcc  
i386         buildonly-randconfig-005-20240201   gcc  
i386         buildonly-randconfig-006-20240201   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20240201   gcc  
i386                  randconfig-002-20240201   gcc  
i386                  randconfig-003-20240201   gcc  
i386                  randconfig-004-20240201   gcc  
i386                  randconfig-005-20240201   gcc  
i386                  randconfig-006-20240201   gcc  
i386                  randconfig-011-20240131   gcc  
i386                  randconfig-011-20240201   clang
i386                  randconfig-012-20240131   gcc  
i386                  randconfig-012-20240201   clang
i386                  randconfig-013-20240131   gcc  
i386                  randconfig-013-20240201   clang
i386                  randconfig-014-20240131   gcc  
i386                  randconfig-014-20240201   clang
i386                  randconfig-015-20240131   gcc  
i386                  randconfig-015-20240201   clang
i386                  randconfig-016-20240131   gcc  
i386                  randconfig-016-20240201   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240131   gcc  
loongarch             randconfig-001-20240201   gcc  
loongarch             randconfig-002-20240131   gcc  
loongarch             randconfig-002-20240201   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                           ip27_defconfig   gcc  
mips                     loongson1b_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240131   gcc  
nios2                 randconfig-001-20240201   gcc  
nios2                 randconfig-002-20240131   gcc  
nios2                 randconfig-002-20240201   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240131   gcc  
parisc                randconfig-001-20240201   gcc  
parisc                randconfig-002-20240131   gcc  
parisc                randconfig-002-20240201   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc               randconfig-001-20240201   gcc  
powerpc               randconfig-002-20240201   gcc  
powerpc               randconfig-003-20240201   gcc  
powerpc                    socrates_defconfig   gcc  
powerpc64             randconfig-001-20240201   gcc  
powerpc64             randconfig-002-20240201   gcc  
powerpc64             randconfig-003-20240201   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240201   gcc  
riscv                 randconfig-002-20240201   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240131   gcc  
s390                  randconfig-002-20240131   gcc  
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                    randconfig-001-20240131   gcc  
sh                    randconfig-001-20240201   gcc  
sh                    randconfig-002-20240131   gcc  
sh                    randconfig-002-20240201   gcc  
sh                           se7721_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240131   gcc  
sparc64               randconfig-001-20240201   gcc  
sparc64               randconfig-002-20240131   gcc  
sparc64               randconfig-002-20240201   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240201   gcc  
um                    randconfig-002-20240201   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240131   clang
x86_64       buildonly-randconfig-002-20240131   clang
x86_64       buildonly-randconfig-003-20240131   clang
x86_64       buildonly-randconfig-004-20240131   clang
x86_64       buildonly-randconfig-005-20240131   clang
x86_64       buildonly-randconfig-006-20240131   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20240131   clang
x86_64                randconfig-012-20240131   clang
x86_64                randconfig-013-20240131   clang
x86_64                randconfig-014-20240131   clang
x86_64                randconfig-015-20240131   clang
x86_64                randconfig-016-20240131   clang
x86_64                randconfig-071-20240131   clang
x86_64                randconfig-072-20240131   clang
x86_64                randconfig-073-20240131   clang
x86_64                randconfig-074-20240131   clang
x86_64                randconfig-075-20240131   clang
x86_64                randconfig-076-20240131   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                randconfig-001-20240131   gcc  
xtensa                randconfig-001-20240201   gcc  
xtensa                randconfig-002-20240131   gcc  
xtensa                randconfig-002-20240201   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

