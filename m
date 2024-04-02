Return-Path: <linux-rdma+bounces-1721-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52685894866
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 02:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1CC2B23363
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 00:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E93DDA6;
	Tue,  2 Apr 2024 00:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NFVrmbJV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB3E440C
	for <linux-rdma@vger.kernel.org>; Tue,  2 Apr 2024 00:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712017008; cv=none; b=b6Sjmip6HtxzlCdZwlAlfmMzcnCYaGFDXAgFLEqzee5r81ImHH+tDkYHG8Sv53NfhMCGSLpiW0RxVub0iWuCChphnIarrQir6+V+PEtSVGDP6EBzRCQo3n9vg9h+GWd/OQotB3w26bNIzG0M7gkFuPJglF0F5XD160w7KvLjUAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712017008; c=relaxed/simple;
	bh=OAOTxnH/we+2g+o6PNdwDJ7rlW5xCxvbdHPPAlBHx1Y=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NBp7bXpplATeYOzU48rps9Q2m1k+gN7zRCrHgLPWeSqWWiLBeQC2PrJZaaM8+PH2409NsK2xS3MWT0tgJOLny+XZ2QyEiNnCf4iSIlNtdhzEhyuQ2qhxwG1ChbKl9XtJBfwssQAP3xz48RslEXweH7sPc3ZvpEyPR2TpIvYGxaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NFVrmbJV; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712017007; x=1743553007;
  h=date:from:to:cc:subject:message-id;
  bh=OAOTxnH/we+2g+o6PNdwDJ7rlW5xCxvbdHPPAlBHx1Y=;
  b=NFVrmbJVwJRhN0W2dy7Lz4gAMVZgfwVH/qwP+gH7axaaIZidiVnaVTPd
   E8ZgJyIGsIPhCQkqGIA0fnT356RneQEUZTdN3IToUlFBf9snjOHJPM5iP
   pUPc+1hJ3tdKWgi6a8KQo6cYwOEk+rh78p7hXDy32rFl4shCqqaZSj5WQ
   6CJgkqf5TvQ0Lq5UT96GiEAPGlcl089T8lyIciFx2ScMDg9mDzgn0kvZD
   6lkrg6OLyIV+LSS07nCPQGXUnTGWy1uY4/N6lttXy0sZe1j1NZ8eZOGyy
   AZ/UQu5bLByI5WzNoEvwDNYgXPSOPhQ0JvlXrqNAHjx7Rbgk0l1UWlk7q
   A==;
X-CSE-ConnectionGUID: s2/Gq6RXS+2GgAn+3CfawA==
X-CSE-MsgGUID: Zoo5py5GSeqzD+3GK44J2w==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="17737206"
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="17737206"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 17:16:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="18338569"
Received: from lkp-server02.sh.intel.com (HELO 90ee3aa53dbd) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 01 Apr 2024 17:16:44 -0700
Received: from kbuild by 90ee3aa53dbd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rrRpR-0000gB-1D;
	Tue, 02 Apr 2024 00:16:41 +0000
Date: Tue, 02 Apr 2024 08:14:57 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:remove-dummy-netdev] BUILD SUCCESS
 c965b039a750c45e7b3baefefb97ec7d89469cfd
Message-ID: <202404020855.KWkUjdmw-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git remove-dummy-netdev
branch HEAD: c965b039a750c45e7b3baefefb97ec7d89469cfd  IB/hfi1: Allocate dummy net_device dynamically

elapsed time: 721m

configs tested: 207
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
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20240401   gcc  
arc                   randconfig-001-20240402   gcc  
arc                   randconfig-002-20240401   gcc  
arc                   randconfig-002-20240402   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                       multi_v4t_defconfig   clang
arm                        mvebu_v5_defconfig   gcc  
arm                        mvebu_v7_defconfig   clang
arm                   randconfig-001-20240401   clang
arm                   randconfig-001-20240402   gcc  
arm                   randconfig-002-20240401   clang
arm                   randconfig-003-20240401   gcc  
arm                   randconfig-004-20240401   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240401   gcc  
arm64                 randconfig-002-20240401   gcc  
arm64                 randconfig-003-20240401   gcc  
arm64                 randconfig-004-20240401   gcc  
arm64                 randconfig-004-20240402   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240401   gcc  
csky                  randconfig-001-20240402   gcc  
csky                  randconfig-002-20240401   gcc  
csky                  randconfig-002-20240402   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240401   clang
hexagon               randconfig-002-20240401   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240401   gcc  
i386         buildonly-randconfig-002-20240401   clang
i386         buildonly-randconfig-003-20240401   clang
i386         buildonly-randconfig-004-20240401   gcc  
i386         buildonly-randconfig-005-20240401   gcc  
i386         buildonly-randconfig-006-20240401   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240401   gcc  
i386                  randconfig-002-20240401   gcc  
i386                  randconfig-003-20240401   clang
i386                  randconfig-004-20240401   clang
i386                  randconfig-005-20240401   gcc  
i386                  randconfig-006-20240401   gcc  
i386                  randconfig-011-20240401   clang
i386                  randconfig-012-20240401   clang
i386                  randconfig-013-20240401   gcc  
i386                  randconfig-014-20240401   gcc  
i386                  randconfig-015-20240401   gcc  
i386                  randconfig-016-20240401   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240401   gcc  
loongarch             randconfig-001-20240402   gcc  
loongarch             randconfig-002-20240401   gcc  
loongarch             randconfig-002-20240402   gcc  
m68k                             alldefconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                        qi_lb60_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240401   gcc  
nios2                 randconfig-001-20240402   gcc  
nios2                 randconfig-002-20240401   gcc  
nios2                 randconfig-002-20240402   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240401   gcc  
parisc                randconfig-001-20240402   gcc  
parisc                randconfig-002-20240401   gcc  
parisc                randconfig-002-20240402   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                        cell_defconfig   gcc  
powerpc                      ppc6xx_defconfig   gcc  
powerpc               randconfig-001-20240401   gcc  
powerpc               randconfig-002-20240401   gcc  
powerpc               randconfig-002-20240402   gcc  
powerpc               randconfig-003-20240401   gcc  
powerpc                     tqm8540_defconfig   gcc  
powerpc64             randconfig-001-20240401   gcc  
powerpc64             randconfig-001-20240402   gcc  
powerpc64             randconfig-002-20240401   clang
powerpc64             randconfig-002-20240402   gcc  
powerpc64             randconfig-003-20240401   gcc  
powerpc64             randconfig-003-20240402   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240401   clang
riscv                 randconfig-002-20240401   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240401   gcc  
s390                  randconfig-001-20240402   gcc  
s390                  randconfig-002-20240401   gcc  
s390                  randconfig-002-20240402   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240401   gcc  
sh                    randconfig-001-20240402   gcc  
sh                    randconfig-002-20240401   gcc  
sh                    randconfig-002-20240402   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240401   gcc  
sparc64               randconfig-001-20240402   gcc  
sparc64               randconfig-002-20240401   gcc  
sparc64               randconfig-002-20240402   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240401   gcc  
um                    randconfig-001-20240402   gcc  
um                    randconfig-002-20240401   clang
um                    randconfig-002-20240402   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240402   clang
x86_64       buildonly-randconfig-002-20240402   clang
x86_64       buildonly-randconfig-003-20240402   clang
x86_64       buildonly-randconfig-004-20240402   clang
x86_64       buildonly-randconfig-005-20240402   clang
x86_64       buildonly-randconfig-006-20240402   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240402   clang
x86_64                randconfig-002-20240402   clang
x86_64                randconfig-003-20240402   gcc  
x86_64                randconfig-004-20240402   clang
x86_64                randconfig-005-20240402   gcc  
x86_64                randconfig-006-20240402   gcc  
x86_64                randconfig-011-20240402   gcc  
x86_64                randconfig-012-20240402   gcc  
x86_64                randconfig-013-20240402   clang
x86_64                randconfig-014-20240402   gcc  
x86_64                randconfig-015-20240402   clang
x86_64                randconfig-016-20240402   gcc  
x86_64                randconfig-071-20240402   clang
x86_64                randconfig-072-20240402   clang
x86_64                randconfig-073-20240402   clang
x86_64                randconfig-074-20240402   gcc  
x86_64                randconfig-075-20240402   clang
x86_64                randconfig-076-20240402   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240401   gcc  
xtensa                randconfig-001-20240402   gcc  
xtensa                randconfig-002-20240401   gcc  
xtensa                randconfig-002-20240402   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

