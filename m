Return-Path: <linux-rdma+bounces-7613-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E879A2E136
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Feb 2025 23:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1766C1648A8
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Feb 2025 22:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CB11A254C;
	Sun,  9 Feb 2025 22:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FEuj7e5Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D977A143888
	for <linux-rdma@vger.kernel.org>; Sun,  9 Feb 2025 22:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739140551; cv=none; b=IeUAGaY4K6OkkxhRf4Ht8h+Qu6udO43HBp82kNGn0Z7uM0EBo2QFs7vsHMBsPpAL2m8tSa080FwThXICxqcb0phb5gl/6+Yv1AMCVduRsgR4FyZxOXSh9FZEkqip82Zhx2OvQFyVKughjDfGUiP7X6efLJe5HO7qu4pJcBcemx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739140551; c=relaxed/simple;
	bh=IadECG76prWQxhGONqW0HoVsWGO0OD1BB8QhSYqS8bg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=T6oegLP8GbumVabaUlxoP0FmQuS71xtWKIDDM14YilcBfDa0CSbFO5vNUYCKh4zdxqrnmgbpwHcX7uLZJaTmX4c3ObYXkCn2CTAcZQSsOHn/WbZv1sVCIMTFg3q56LrZbgOJGbgexAM1JXasJ1LEgynNeYy6GazAyr6CBXczLgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FEuj7e5Y; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739140550; x=1770676550;
  h=date:from:to:cc:subject:message-id;
  bh=IadECG76prWQxhGONqW0HoVsWGO0OD1BB8QhSYqS8bg=;
  b=FEuj7e5Y7/34EeQnlb4UiSxtPToEQb9Lj5rXPW6yrO86FaB3Y6iMwgj1
   OVVdW5jrLe/VVUeVPyy4ziRcXm8jQbbl2aQ15ykgCvaAkXcOzpWgCBPcW
   IN1ceVayEp2rUNQRQiw0qCcLXBoGcPgFo1aQfN9G+FjQ8E6w1gdbn10l1
   UaVOo/sEMXj/Yf+ZONh0E4HqlaPVv4uF0Xk7ZBLSD1048NpA2HJtn7OV8
   /KdJwohTNBrQn0tJYzmOIerx+vE5HXhaSzIgpJYnWtE0rR3ielVspdTFg
   Gd49Jww73ifSNI6UgntlCHjWCn+WhkAoGCjG5mP6bGGpVViijyDoBYGxD
   g==;
X-CSE-ConnectionGUID: TBfJVcTVSHKg/HU6piaJ7g==
X-CSE-MsgGUID: bMGGh7vlTB+aV5yawm/mxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="51105788"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="51105788"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 14:35:50 -0800
X-CSE-ConnectionGUID: BYsJbBQ+TsyaAUFhUemNHw==
X-CSE-MsgGUID: jRDT+RtATXuHi4EwISqrsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149217692"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 09 Feb 2025 14:35:48 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1thFtx-0011zU-1W;
	Sun, 09 Feb 2025 22:35:45 +0000
Date: Mon, 10 Feb 2025 06:35:23 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 f26e648a978ae7958e0958095768363c851a736d
Message-ID: <202502100617.IQciEazN-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: f26e648a978ae7958e0958095768363c851a736d  RDMA/bnxt_re: Fix the condition check while programming congestion control

elapsed time: 725m

configs tested: 132
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                     haps_hs_smp_defconfig    gcc-13.2.0
arc                   randconfig-001-20250209    gcc-13.2.0
arc                   randconfig-002-20250209    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                           h3600_defconfig    gcc-14.2.0
arm                   randconfig-001-20250209    gcc-14.2.0
arm                   randconfig-002-20250209    clang-21
arm                   randconfig-003-20250209    clang-21
arm                   randconfig-004-20250209    gcc-14.2.0
arm                          sp7021_defconfig    gcc-14.2.0
arm                           sunxi_defconfig    gcc-14.2.0
arm                           tegra_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250209    clang-18
arm64                 randconfig-002-20250209    gcc-14.2.0
arm64                 randconfig-003-20250209    gcc-14.2.0
arm64                 randconfig-004-20250209    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250209    gcc-14.2.0
csky                  randconfig-002-20250209    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250209    clang-21
hexagon               randconfig-002-20250209    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250209    gcc-12
i386        buildonly-randconfig-002-20250209    clang-19
i386        buildonly-randconfig-003-20250209    clang-19
i386        buildonly-randconfig-004-20250209    gcc-12
i386        buildonly-randconfig-005-20250209    clang-19
i386        buildonly-randconfig-006-20250209    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250209    gcc-14.2.0
loongarch             randconfig-002-20250209    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                         10m50_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250209    gcc-14.2.0
nios2                 randconfig-002-20250209    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
openrisc                       virt_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250209    gcc-14.2.0
parisc                randconfig-002-20250209    gcc-14.2.0
powerpc                     akebono_defconfig    clang-21
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                       eiger_defconfig    clang-17
powerpc                   lite5200b_defconfig    clang-21
powerpc                       ppc64_defconfig    clang-19
powerpc                      ppc6xx_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250209    gcc-14.2.0
powerpc               randconfig-002-20250209    clang-21
powerpc               randconfig-003-20250209    gcc-14.2.0
powerpc64             randconfig-001-20250209    gcc-14.2.0
powerpc64             randconfig-002-20250209    gcc-14.2.0
powerpc64             randconfig-003-20250209    gcc-14.2.0
riscv                            alldefconfig    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv             nommu_k210_sdcard_defconfig    gcc-14.2.0
riscv                 randconfig-001-20250209    clang-18
riscv                 randconfig-002-20250209    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250209    clang-21
s390                  randconfig-002-20250209    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                     magicpanelr2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250209    gcc-14.2.0
sh                    randconfig-002-20250209    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250209    gcc-14.2.0
sparc                 randconfig-002-20250209    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250209    gcc-14.2.0
sparc64               randconfig-002-20250209    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250209    gcc-11
um                    randconfig-002-20250209    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250209    gcc-12
x86_64      buildonly-randconfig-002-20250209    gcc-12
x86_64      buildonly-randconfig-003-20250209    gcc-12
x86_64      buildonly-randconfig-004-20250209    gcc-12
x86_64      buildonly-randconfig-005-20250209    gcc-11
x86_64      buildonly-randconfig-006-20250209    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250209    gcc-14.2.0
xtensa                randconfig-002-20250209    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

