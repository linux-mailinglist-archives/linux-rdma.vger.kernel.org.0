Return-Path: <linux-rdma+bounces-10525-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C86E9AC095B
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 12:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 757B3179B96
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 10:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E117D13C918;
	Thu, 22 May 2025 10:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iP8GWQ8s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D0F288C22
	for <linux-rdma@vger.kernel.org>; Thu, 22 May 2025 10:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747908334; cv=none; b=SiC1GY1vgwaPuHbUvAmjftsJ2txTX+n3v1XTgawpnjXEV++b1E1tQXsMGSY42NP7V3iKQmz6G0BlV10OAl7cJUs50Xs6Txf/UfBTLlOXnUaLMuhqWL/jc5zbrLjzlC/6gRL3rl5rLf3Qeh69UZSl83bkTEUVqXEuRfc6rJbxwck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747908334; c=relaxed/simple;
	bh=XXlU/6xEO9L9Q/LWMq+qpy4bcEzYWWlPPqnm5wXSlDM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nTgLtNNkB7r8dNvphBqPvwvM4a64/lAw6K2x9KRatYSS0062VlB1v+N439b+VdE4YrMI1qx3xrNBSEpvKbWKKMYye05M5k+EnKrxvoHuEYmPonXXg9jMCz19i8xIFQKIOUxTSuRxLOz2iHJ7x0uFRtRUUGwKm/uCWI0D9iCYXAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iP8GWQ8s; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747908332; x=1779444332;
  h=date:from:to:cc:subject:message-id;
  bh=XXlU/6xEO9L9Q/LWMq+qpy4bcEzYWWlPPqnm5wXSlDM=;
  b=iP8GWQ8sXiJOszv5ftlULRel40YAjiPxqInE/1LTeqkgKuTNrlEz69fX
   PT0+YSUo/JTcs5w8arQ9q7/yks+2W41nJl0D9KMDf9t8PFFrISmm/jaqD
   aRX2gCOWg3NPLYpHtdW41wywmwK4LVSE+U9c327b4ibf8K5hfc839jVr8
   SlkddJAz7EVmUGaBRB59A6+h7zGiDmgz6D8JtLpbtsteDoFWTPO3ykpHe
   BaeSelPlsK//3fArM2kl5W3E81xoVrCZ2r9sl9mzwE1ZNw9ojcepVater
   N2R0GwBM/CEbuOsd9KH1yLIpsfMgAo383HHwuWxymK/ZY34qROZ9n6gvW
   w==;
X-CSE-ConnectionGUID: PjKMkA9OQ0u+XDHyrAcDUg==
X-CSE-MsgGUID: DcUKnumCQCOzTi/JRVqkyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="49799813"
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="49799813"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 03:05:31 -0700
X-CSE-ConnectionGUID: a4yiWgF0TKGmdI/zKn1Hog==
X-CSE-MsgGUID: peBlYWnASNyHicmutwhOUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="140394276"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 22 May 2025 03:05:31 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uI2nn-000PCm-2k;
	Thu, 22 May 2025 10:05:27 +0000
Date: Thu, 22 May 2025 18:05:01 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 990b5c07f677a0b633b41130a70771337c18343e
Message-ID: <202505221851.V9LukFIA-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 990b5c07f677a0b633b41130a70771337c18343e  RDMA/bnxt_re: Fix return code of bnxt_re_configure_cc

elapsed time: 1431m

configs tested: 182
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250521    gcc-10.5.0
arc                   randconfig-001-20250522    gcc-15.1.0
arc                   randconfig-002-20250521    gcc-12.4.0
arc                   randconfig-002-20250522    gcc-15.1.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                          moxart_defconfig    gcc-14.2.0
arm                            mps2_defconfig    clang-21
arm                   randconfig-001-20250521    clang-21
arm                   randconfig-001-20250522    clang-21
arm                   randconfig-002-20250521    clang-21
arm                   randconfig-002-20250522    clang-21
arm                   randconfig-003-20250521    clang-16
arm                   randconfig-003-20250522    clang-18
arm                   randconfig-004-20250521    clang-21
arm                   randconfig-004-20250522    gcc-7.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250521    gcc-6.5.0
arm64                 randconfig-001-20250522    clang-21
arm64                 randconfig-002-20250521    gcc-6.5.0
arm64                 randconfig-002-20250522    gcc-7.5.0
arm64                 randconfig-003-20250521    gcc-8.5.0
arm64                 randconfig-003-20250522    clang-21
arm64                 randconfig-004-20250521    gcc-8.5.0
arm64                 randconfig-004-20250522    gcc-5.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250521    gcc-10.5.0
csky                  randconfig-001-20250522    gcc-15.1.0
csky                  randconfig-002-20250521    gcc-12.4.0
csky                  randconfig-002-20250522    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250521    clang-20
hexagon               randconfig-001-20250522    clang-17
hexagon               randconfig-002-20250521    clang-21
hexagon               randconfig-002-20250522    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250521    clang-20
i386        buildonly-randconfig-001-20250522    clang-20
i386        buildonly-randconfig-002-20250521    clang-20
i386        buildonly-randconfig-002-20250522    gcc-12
i386        buildonly-randconfig-003-20250521    gcc-12
i386        buildonly-randconfig-003-20250522    gcc-12
i386        buildonly-randconfig-004-20250521    clang-20
i386        buildonly-randconfig-004-20250522    gcc-12
i386        buildonly-randconfig-005-20250521    gcc-12
i386        buildonly-randconfig-005-20250522    gcc-12
i386        buildonly-randconfig-006-20250521    gcc-12
i386        buildonly-randconfig-006-20250522    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250521    gcc-15.1.0
loongarch             randconfig-001-20250522    gcc-15.1.0
loongarch             randconfig-002-20250521    gcc-14.2.0
loongarch             randconfig-002-20250522    gcc-15.1.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       m5275evb_defconfig    gcc-14.2.0
m68k                        m5307c3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                   sb1250_swarm_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250521    gcc-14.2.0
nios2                 randconfig-001-20250522    gcc-9.3.0
nios2                 randconfig-002-20250521    gcc-14.2.0
nios2                 randconfig-002-20250522    gcc-9.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250521    gcc-13.3.0
parisc                randconfig-001-20250522    gcc-6.5.0
parisc                randconfig-002-20250521    gcc-11.5.0
parisc                randconfig-002-20250522    gcc-12.4.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                 canyonlands_defconfig    clang-21
powerpc                       ebony_defconfig    clang-21
powerpc                        fsp2_defconfig    gcc-14.2.0
powerpc                          g5_defconfig    gcc-14.2.0
powerpc                 linkstation_defconfig    clang-20
powerpc                   motionpro_defconfig    clang-21
powerpc                      ppc64e_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250521    clang-21
powerpc               randconfig-001-20250522    gcc-9.3.0
powerpc               randconfig-002-20250521    gcc-8.5.0
powerpc               randconfig-002-20250522    clang-21
powerpc               randconfig-003-20250521    gcc-6.5.0
powerpc               randconfig-003-20250522    gcc-7.5.0
powerpc                        warp_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250521    gcc-8.5.0
powerpc64             randconfig-001-20250522    clang-21
powerpc64             randconfig-002-20250521    gcc-6.5.0
powerpc64             randconfig-002-20250522    gcc-10.5.0
powerpc64             randconfig-003-20250521    clang-21
powerpc64             randconfig-003-20250522    gcc-7.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250521    gcc-8.5.0
riscv                 randconfig-001-20250522    gcc-9.3.0
riscv                 randconfig-002-20250521    gcc-8.5.0
riscv                 randconfig-002-20250522    clang-18
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250521    clang-20
s390                  randconfig-001-20250522    clang-19
s390                  randconfig-002-20250521    clang-21
s390                  randconfig-002-20250522    clang-18
s390                       zfcpdump_defconfig    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250521    gcc-12.4.0
sh                    randconfig-001-20250522    gcc-13.3.0
sh                    randconfig-002-20250521    gcc-15.1.0
sh                    randconfig-002-20250522    gcc-13.3.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250521    gcc-13.3.0
sparc                 randconfig-001-20250522    gcc-14.2.0
sparc                 randconfig-002-20250521    gcc-13.3.0
sparc                 randconfig-002-20250522    gcc-6.5.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250521    gcc-13.3.0
sparc64               randconfig-001-20250522    gcc-14.2.0
sparc64               randconfig-002-20250521    gcc-13.3.0
sparc64               randconfig-002-20250522    gcc-12.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250521    clang-21
um                    randconfig-001-20250522    gcc-12
um                    randconfig-002-20250521    clang-21
um                    randconfig-002-20250522    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250521    clang-20
x86_64      buildonly-randconfig-001-20250522    clang-20
x86_64      buildonly-randconfig-002-20250521    clang-20
x86_64      buildonly-randconfig-002-20250522    gcc-12
x86_64      buildonly-randconfig-003-20250521    gcc-12
x86_64      buildonly-randconfig-003-20250522    gcc-12
x86_64      buildonly-randconfig-004-20250521    gcc-12
x86_64      buildonly-randconfig-004-20250522    gcc-12
x86_64      buildonly-randconfig-005-20250521    clang-20
x86_64      buildonly-randconfig-005-20250522    gcc-12
x86_64      buildonly-randconfig-006-20250521    clang-20
x86_64      buildonly-randconfig-006-20250522    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250521    gcc-15.1.0
xtensa                randconfig-001-20250522    gcc-14.2.0
xtensa                randconfig-002-20250521    gcc-15.1.0
xtensa                randconfig-002-20250522    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

