Return-Path: <linux-rdma+bounces-2762-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC188D78DD
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 00:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0F551C20AEC
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Jun 2024 22:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E12653E15;
	Sun,  2 Jun 2024 22:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WOD/bj3+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195192943F
	for <linux-rdma@vger.kernel.org>; Sun,  2 Jun 2024 22:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717367182; cv=none; b=nGBgFvvwcgu3eGHkKAKQm/yU4TXtUGSJHplwoShoKeYLK6aa+C0HogqETMyBaONjppHKgtYXVxdjmWWz3bn18tHFtErl6E3hv7RzJugZ76ST/O8mBHGrKXB8118UcQYOUYf5079EpBZU07Mu4+r3F3jAbYrR2TjAN3ukh1DyH5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717367182; c=relaxed/simple;
	bh=K5RGzXs3zqYf1OXFhDIwiN642fxUSUcZEKPl7/WrpQY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Xil/Mp0V4Y6h81wqIcQf2v3Wb87aFwPomYmMnWWSiIy0JgwZWhkN0zihXtmgFHrMj/KyFWW+MTo7xV8EIPcWNsnjd6cWZzYLr4xr+xxSnivBGdA8pmg8l9+QhaNx63Tif38ORus7AZBA0KvxQHqSXMPp0WmqvTjUOCp7xMBMWD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WOD/bj3+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717367181; x=1748903181;
  h=date:from:to:cc:subject:message-id;
  bh=K5RGzXs3zqYf1OXFhDIwiN642fxUSUcZEKPl7/WrpQY=;
  b=WOD/bj3+42SS2IGCVt2BGLh5PkfO6TY8/raPcVB87ylEtiGHSNa/ioRR
   5yOVqzCt/9d5KbcGYNgF8JReDX5UanSh3KOGDbURultPlVRSyRzE63zxy
   dkBMH+UxMtLjw1AlN4d6DA6ZJu0JE/OMTRG68osAQCj/D8fDnAJ1IyjJn
   M1bzIcKRGVBPAg6QXYyvceKGpanaRVLSRcVEfj7NrXEugFL3p5CB+/m0C
   m+LWt8Ozyj6lnCuUxjeHPcXh3qRzmMwHjlrwnvYXPbivcXIz1hwTd1xhz
   7eUAPcJdR9m0ZxMf87rwMv8EnnWILqhj9cMyDiXePItD8aSjBn7ie2K6B
   A==;
X-CSE-ConnectionGUID: lKQxBQVvSDyB+LoyD5tw0Q==
X-CSE-MsgGUID: LIbVThczQJ6cx5UPGyykEg==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="17645949"
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="17645949"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 15:26:21 -0700
X-CSE-ConnectionGUID: tBfcBwhgRISEWYjX9Aexug==
X-CSE-MsgGUID: 6n1b0c3zTfup0EZP98pjsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="41624324"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 02 Jun 2024 15:26:19 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sDtea-000KWG-1j;
	Sun, 02 Jun 2024 22:26:16 +0000
Date: Mon, 03 Jun 2024 06:25:41 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 c405e9cac10239f19be9ce461252cae51e4fdc9e
Message-ID: <202406030637.w6aLJv1M-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: c405e9cac10239f19be9ce461252cae51e4fdc9e  RDMA/mlx5: Add check for srq max_sge attribute

elapsed time: 794m

configs tested: 206
configs skipped: 5

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
arc                   randconfig-001-20240602   gcc  
arc                   randconfig-001-20240603   gcc  
arc                   randconfig-002-20240602   gcc  
arc                   randconfig-002-20240603   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                   randconfig-001-20240602   clang
arm                   randconfig-001-20240603   gcc  
arm                   randconfig-002-20240602   clang
arm                   randconfig-002-20240603   gcc  
arm                   randconfig-003-20240602   gcc  
arm                   randconfig-003-20240603   gcc  
arm                   randconfig-004-20240602   clang
arm                   randconfig-004-20240603   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240602   clang
arm64                 randconfig-001-20240603   gcc  
arm64                 randconfig-002-20240602   gcc  
arm64                 randconfig-002-20240603   gcc  
arm64                 randconfig-003-20240602   clang
arm64                 randconfig-004-20240602   clang
arm64                 randconfig-004-20240603   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240602   gcc  
csky                  randconfig-001-20240603   gcc  
csky                  randconfig-002-20240602   gcc  
csky                  randconfig-002-20240603   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240602   clang
hexagon               randconfig-002-20240602   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240602   clang
i386         buildonly-randconfig-001-20240603   clang
i386         buildonly-randconfig-002-20240602   gcc  
i386         buildonly-randconfig-002-20240603   clang
i386         buildonly-randconfig-003-20240602   clang
i386         buildonly-randconfig-004-20240602   clang
i386         buildonly-randconfig-005-20240602   clang
i386         buildonly-randconfig-006-20240602   clang
i386         buildonly-randconfig-006-20240603   clang
i386                                defconfig   clang
i386                  randconfig-001-20240602   clang
i386                  randconfig-001-20240603   clang
i386                  randconfig-002-20240602   clang
i386                  randconfig-003-20240602   clang
i386                  randconfig-004-20240602   gcc  
i386                  randconfig-004-20240603   clang
i386                  randconfig-005-20240602   clang
i386                  randconfig-005-20240603   clang
i386                  randconfig-006-20240602   clang
i386                  randconfig-011-20240602   clang
i386                  randconfig-011-20240603   clang
i386                  randconfig-012-20240602   clang
i386                  randconfig-012-20240603   clang
i386                  randconfig-013-20240602   clang
i386                  randconfig-013-20240603   clang
i386                  randconfig-014-20240602   gcc  
i386                  randconfig-014-20240603   clang
i386                  randconfig-015-20240602   gcc  
i386                  randconfig-015-20240603   clang
i386                  randconfig-016-20240602   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240602   gcc  
loongarch             randconfig-001-20240603   gcc  
loongarch             randconfig-002-20240602   gcc  
loongarch             randconfig-002-20240603   gcc  
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
nios2                 randconfig-001-20240602   gcc  
nios2                 randconfig-001-20240603   gcc  
nios2                 randconfig-002-20240602   gcc  
nios2                 randconfig-002-20240603   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240602   gcc  
parisc                randconfig-001-20240603   gcc  
parisc                randconfig-002-20240602   gcc  
parisc                randconfig-002-20240603   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240602   clang
powerpc               randconfig-001-20240603   gcc  
powerpc               randconfig-002-20240602   gcc  
powerpc               randconfig-002-20240603   gcc  
powerpc               randconfig-003-20240602   clang
powerpc               randconfig-003-20240603   gcc  
powerpc64             randconfig-001-20240602   clang
powerpc64             randconfig-001-20240603   gcc  
powerpc64             randconfig-002-20240602   gcc  
powerpc64             randconfig-002-20240603   gcc  
powerpc64             randconfig-003-20240602   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240602   clang
riscv                 randconfig-002-20240602   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240602   gcc  
s390                  randconfig-002-20240602   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240602   gcc  
sh                    randconfig-001-20240603   gcc  
sh                    randconfig-002-20240602   gcc  
sh                    randconfig-002-20240603   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240602   gcc  
sparc64               randconfig-001-20240603   gcc  
sparc64               randconfig-002-20240602   gcc  
sparc64               randconfig-002-20240603   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240602   gcc  
um                    randconfig-002-20240602   clang
um                    randconfig-002-20240603   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240603   gcc  
x86_64       buildonly-randconfig-002-20240602   clang
x86_64       buildonly-randconfig-002-20240603   gcc  
x86_64       buildonly-randconfig-003-20240602   clang
x86_64       buildonly-randconfig-003-20240603   gcc  
x86_64       buildonly-randconfig-005-20240602   clang
x86_64       buildonly-randconfig-006-20240602   clang
x86_64       buildonly-randconfig-006-20240603   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240603   gcc  
x86_64                randconfig-002-20240602   clang
x86_64                randconfig-003-20240602   clang
x86_64                randconfig-004-20240603   gcc  
x86_64                randconfig-005-20240602   clang
x86_64                randconfig-005-20240603   gcc  
x86_64                randconfig-006-20240602   clang
x86_64                randconfig-006-20240603   gcc  
x86_64                randconfig-011-20240603   gcc  
x86_64                randconfig-012-20240602   clang
x86_64                randconfig-012-20240603   gcc  
x86_64                randconfig-013-20240602   clang
x86_64                randconfig-014-20240603   gcc  
x86_64                randconfig-015-20240602   clang
x86_64                randconfig-015-20240603   gcc  
x86_64                randconfig-072-20240602   clang
x86_64                randconfig-074-20240602   clang
x86_64                randconfig-075-20240602   clang
x86_64                randconfig-075-20240603   gcc  
x86_64                randconfig-076-20240602   clang
x86_64                randconfig-076-20240603   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240602   gcc  
xtensa                randconfig-001-20240603   gcc  
xtensa                randconfig-002-20240602   gcc  
xtensa                randconfig-002-20240603   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

