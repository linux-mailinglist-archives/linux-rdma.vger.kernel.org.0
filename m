Return-Path: <linux-rdma+bounces-2044-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C6B8B02B7
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 08:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C5C1C22803
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 06:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A4F15A498;
	Wed, 24 Apr 2024 06:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="njkL6/zD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63186158A07
	for <linux-rdma@vger.kernel.org>; Wed, 24 Apr 2024 06:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941763; cv=none; b=UlYnhjpswXYTfrBha70AV0vqGIlDT9DqnOF6DcPoMibkTv81R9+P1mmB1jsVw4VETOsPAf32lFf2rgHnWc8P4ZJ8WGSgwwQ+6DYomZu2SNYf7mmZ9hmLiioUXdCYApS9ae9rP0yC4GaJqAFrviboL7keSQzU+bfXgIfN8jhdhOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941763; c=relaxed/simple;
	bh=IpyMeoDAVBU3LzPnyvAqCIJK7/Wl3zjd+w4nx9oFFm0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ak3+EnVzLZtwL1ztND90LkFMWLIBbarX/rWSaW3Q9e8B4tWGMpgeQPuwuCG9rovhncRsbrNN2sMLRmCR0Ml8NNvPm9aObg1Ycq4ryLFFk4Mtp+HGAYO+xcVeThPuhTdBe3z/Me7p1+IecE3yWRWi+kebDmTssNJU/EJkeck2mhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=njkL6/zD; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713941763; x=1745477763;
  h=date:from:to:cc:subject:message-id;
  bh=IpyMeoDAVBU3LzPnyvAqCIJK7/Wl3zjd+w4nx9oFFm0=;
  b=njkL6/zDBPIC0t1CdA2gg3uWoqqatBI70veDVUMDTwF7QdLlg6kOsBJg
   AAz1/lGuVFhbeoJUrfJsvukLlXyuwwNnJ5OPJxZ6ifEmEt9lxbHgybl/U
   2D1eJKmWrJVw+ebcU+XroqCumiq83LA5z5LpHh6k4xA9DAt7I64LcadZC
   Nw0nGLvJBhyAUb0OmO33qukQ6g9jZaR4aU4wYsWA8nPPNNmrjGIxA+MnK
   xSTSjR3grmteyCjnVkbp40w0HKwaq69GKh8oxswg9bQeSoWSh958xEHwg
   D5auWlwnB7MdUzX0xE59I9ogTYO909BDjPkJ6lmkHZHf6lZxcLDsREAjx
   A==;
X-CSE-ConnectionGUID: fXmNFN4oTu2zE8bCElkVcQ==
X-CSE-MsgGUID: +gEbUVIiSTqcW5h4rqU1Sg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9718234"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="9718234"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 23:56:02 -0700
X-CSE-ConnectionGUID: nwl5XWFkRAe+k9VXhvK90w==
X-CSE-MsgGUID: yCn5K+HYR62QMKN/IGKtPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24504008"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 23 Apr 2024 23:56:01 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rzWXu-0000xe-0j;
	Wed, 24 Apr 2024 06:55:58 +0000
Date: Wed, 24 Apr 2024 14:55:49 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 f88320b698ad099a2f742adfb9f87177bfffe0c5
Message-ID: <202404241446.pmuMdIIZ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: f88320b698ad099a2f742adfb9f87177bfffe0c5  RDMA/mana_ib: Fix missing ret value

elapsed time: 935m

configs tested: 162
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc  
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240424   gcc  
arc                   randconfig-002-20240424   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          gemini_defconfig   clang
arm                       imx_v6_v7_defconfig   clang
arm                   milbeaut_m10v_defconfig   clang
arm                   randconfig-001-20240424   gcc  
arm                   randconfig-002-20240424   gcc  
arm                   randconfig-003-20240424   gcc  
arm                           tegra_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-002-20240424   gcc  
arm64                 randconfig-003-20240424   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240424   gcc  
csky                  randconfig-002-20240424   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240424   gcc  
i386         buildonly-randconfig-002-20240424   gcc  
i386         buildonly-randconfig-003-20240424   gcc  
i386         buildonly-randconfig-004-20240424   gcc  
i386         buildonly-randconfig-005-20240424   gcc  
i386         buildonly-randconfig-006-20240424   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240424   gcc  
i386                  randconfig-002-20240424   gcc  
i386                  randconfig-003-20240424   gcc  
i386                  randconfig-004-20240424   clang
i386                  randconfig-005-20240424   gcc  
i386                  randconfig-006-20240424   gcc  
i386                  randconfig-011-20240424   clang
i386                  randconfig-012-20240424   gcc  
i386                  randconfig-013-20240424   clang
i386                  randconfig-014-20240424   clang
i386                  randconfig-015-20240424   clang
i386                  randconfig-016-20240424   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240424   gcc  
loongarch             randconfig-002-20240424   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                       lemote2f_defconfig   gcc  
mips                          malta_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240424   gcc  
nios2                 randconfig-002-20240424   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240424   gcc  
parisc                randconfig-002-20240424   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                 canyonlands_defconfig   clang
powerpc                    ge_imp3a_defconfig   gcc  
powerpc                       holly_defconfig   clang
powerpc                     powernv_defconfig   gcc  
powerpc               randconfig-002-20240424   gcc  
powerpc               randconfig-003-20240424   gcc  
powerpc                        warp_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20240424   gcc  
powerpc64             randconfig-002-20240424   gcc  
powerpc64             randconfig-003-20240424   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240424   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240424   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240424   gcc  
sh                    randconfig-002-20240424   gcc  
sh                           se7705_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240424   gcc  
sparc64               randconfig-002-20240424   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240424   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240424   clang
x86_64       buildonly-randconfig-002-20240424   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   clang
x86_64                randconfig-001-20240424   clang
x86_64                randconfig-002-20240424   clang
x86_64                randconfig-005-20240424   clang
x86_64                randconfig-006-20240424   clang
x86_64                randconfig-011-20240424   clang
x86_64                randconfig-015-20240424   clang
x86_64                randconfig-071-20240424   clang
x86_64                randconfig-072-20240424   clang
x86_64                randconfig-074-20240424   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240424   gcc  
xtensa                randconfig-002-20240424   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

