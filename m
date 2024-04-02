Return-Path: <linux-rdma+bounces-1726-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 922C9894B3D
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 08:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4F3B1C2195C
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 06:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0620717C72;
	Tue,  2 Apr 2024 06:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DxAuUdez"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA291C683
	for <linux-rdma@vger.kernel.org>; Tue,  2 Apr 2024 06:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712038846; cv=none; b=sBegz/O2YplouqXPuEMzImrijNP+//bd2fdSG6O5XIfhvy5N195SjA8CktyKRs/gsMV32+XQuytTCXTVLZ3RGoQWh8mzxSEiOIAByRVLXq5H5Ev0fLBcDnljlZhcnhGc7HW1tkvUPC+vz/23PTdaNiMhcFY+Ec2181zSFuxPXB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712038846; c=relaxed/simple;
	bh=IgsZhGJfjBfEichK3/uAG134+ULWzhhgr5mZ2Wa+wFE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EwLzUGRYZ9Wx3KMc0inVrXe9XFin2YWA2r8FWcvatfXnaN1gdGxBI5hfKkVKacnyGbcr0uShDga2TYF4I88mbJpo/RHZhEEZ8+E1Dx/4FvP7YCcZFclwVuyj4p+D5e0kZD8GGOKg5Sd2HXDQfbb6jLRQJeRtjsWbuB9GJxZlDCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DxAuUdez; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712038846; x=1743574846;
  h=date:from:to:cc:subject:message-id;
  bh=IgsZhGJfjBfEichK3/uAG134+ULWzhhgr5mZ2Wa+wFE=;
  b=DxAuUdeznImYWJq0iyUvPY1bczLx+qUoTCve97zlY9g7OVe2fiR3w+y7
   GiHf8DkLJhg5upn4TvRuFrzturOvJtUqxPTrG+eM024hfIprXXToZpiN0
   QrtPnLI3Ok7KHg/lKSN7aVkX9mOnRQmYQNLH9N0sURsTehbnfpWQyVwDV
   gDBB0O25Cse18qomxwwQrmGsU3p9I6gQOgdiE7YYoG3RrynjLTIqdqVRJ
   nCgP1sAUaJOgycBMHWvbt7CpLs1A3UG1a/gNo+yZ6J4y0dBFlrBet94Q/
   TJQGqkLOKJYlOZUtMecKRZQ/5nxX/HI0jpTUuVX3U67vVFziCTwoT/7PM
   A==;
X-CSE-ConnectionGUID: zlGoZfKXRKWPt61rttIZAA==
X-CSE-MsgGUID: fgBr7N1tRE2C49RZ06gSrQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="17760738"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="17760738"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 23:20:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="49175808"
Received: from lkp-server02.sh.intel.com (HELO 90ee3aa53dbd) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 01 Apr 2024 23:20:42 -0700
Received: from kbuild by 90ee3aa53dbd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rrXVg-0000ve-1n;
	Tue, 02 Apr 2024 06:20:40 +0000
Date: Tue, 02 Apr 2024 14:20:26 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 ca537a34775c103f7b14d7bbd976403f1d1525d8
Message-ID: <202404021424.opgOwIzz-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: ca537a34775c103f7b14d7bbd976403f1d1525d8  RDMA/restrack: Fix potential invalid address access

elapsed time: 724m

configs tested: 171
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
arc                        nsimosci_defconfig   gcc  
arc                   randconfig-001-20240402   gcc  
arc                   randconfig-002-20240402   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   gcc  
arm                                 defconfig   clang
arm                       netwinder_defconfig   gcc  
arm                   randconfig-001-20240402   gcc  
arm                   randconfig-002-20240402   clang
arm                   randconfig-003-20240402   clang
arm                   randconfig-004-20240402   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240402   clang
arm64                 randconfig-002-20240402   clang
arm64                 randconfig-003-20240402   clang
arm64                 randconfig-004-20240402   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240402   gcc  
csky                  randconfig-002-20240402   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240402   clang
hexagon               randconfig-002-20240402   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240402   gcc  
i386         buildonly-randconfig-002-20240402   gcc  
i386         buildonly-randconfig-003-20240402   clang
i386         buildonly-randconfig-004-20240402   clang
i386         buildonly-randconfig-005-20240402   clang
i386         buildonly-randconfig-006-20240402   clang
i386                                defconfig   clang
i386                  randconfig-001-20240402   gcc  
i386                  randconfig-002-20240402   clang
i386                  randconfig-003-20240402   clang
i386                  randconfig-004-20240402   clang
i386                  randconfig-005-20240402   clang
i386                  randconfig-006-20240402   clang
i386                  randconfig-011-20240402   gcc  
i386                  randconfig-012-20240402   clang
i386                  randconfig-013-20240402   clang
i386                  randconfig-014-20240402   clang
i386                  randconfig-015-20240402   gcc  
i386                  randconfig-016-20240402   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240402   gcc  
loongarch             randconfig-002-20240402   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   gcc  
mips                      malta_kvm_defconfig   gcc  
mips                          rm200_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240402   gcc  
nios2                 randconfig-002-20240402   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240402   gcc  
parisc                randconfig-002-20240402   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc                        fsp2_defconfig   gcc  
powerpc               randconfig-001-20240402   clang
powerpc               randconfig-002-20240402   gcc  
powerpc               randconfig-003-20240402   clang
powerpc                  storcenter_defconfig   gcc  
powerpc64             randconfig-001-20240402   gcc  
powerpc64             randconfig-002-20240402   gcc  
powerpc64             randconfig-003-20240402   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240402   clang
riscv                 randconfig-002-20240402   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240402   gcc  
s390                  randconfig-002-20240402   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                    randconfig-001-20240402   gcc  
sh                    randconfig-002-20240402   gcc  
sh                           se7750_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240402   gcc  
sparc64               randconfig-002-20240402   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240402   gcc  
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
x86_64                randconfig-004-20240402   clang
x86_64                randconfig-013-20240402   clang
x86_64                randconfig-015-20240402   clang
x86_64                randconfig-071-20240402   clang
x86_64                randconfig-072-20240402   clang
x86_64                randconfig-073-20240402   clang
x86_64                randconfig-075-20240402   clang
x86_64                randconfig-076-20240402   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240402   gcc  
xtensa                randconfig-002-20240402   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

