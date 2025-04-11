Return-Path: <linux-rdma+bounces-9385-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0DAA86958
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Apr 2025 01:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D841C1B62254
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 23:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE0D2BEC3E;
	Fri, 11 Apr 2025 23:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ArWIqE4t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D002322126B
	for <linux-rdma@vger.kernel.org>; Fri, 11 Apr 2025 23:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744414930; cv=none; b=WOdGS4f1PufoG8j0nZXq+1ERyGoFaeaIyqj/nEbmbCuRWNygbzfS0PItuys3N9uiabGMC57tfZpq3ZhXqXwY7VHPucsfKX4olvc6mMhlAeBarJpYCdvEM6zuzH1vDUk+XuTxjzCZpcirbXCzMmP1+aR7PQ1Mlzat4f7rbGcDUWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744414930; c=relaxed/simple;
	bh=wpKaLQnOsb/56SH5kqLyv399e18AUCCg8En7aTM5ik4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=F3AsKgJGj358FMkqQq4S6206oe3mCrj5I6kBclFhDrH/aiKTRDwMClS62jxkmPWlH7WkmSl9Ew9P7+4XjOyjzoocCn6GfN5YgjWmHpBOyNwXcr1PETZEsabh7blaepMawkI2lI/w1yjIW5Lq3AqwoTYK68yUnLy61MCLfFcTPGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ArWIqE4t; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744414929; x=1775950929;
  h=date:from:to:cc:subject:message-id;
  bh=wpKaLQnOsb/56SH5kqLyv399e18AUCCg8En7aTM5ik4=;
  b=ArWIqE4tM41IUkAj7nPkz4if67uTrbNL7wlDq77js0fDqtAqbpoMV8HM
   FtSbs0uA/chLP+/82uyPBvCjHKakcIhFxgIV3BFCDbh5+4wwJ1qKZF3ll
   RuZ7P6tV6SgwEaL6VzSwQfjAhCZFol72hqw2J+V/SewgGTuRLr5LsBzNf
   +nC78LYI9w2NGK+bASJYIPbxBXxQLsfnc+1E5wz6/O/r9ikoQ1r73B9UU
   7ffVYIcpjpalOBZvCBdtxQ/ee0NBmMPo0DN14UBeTE+Bwt/QkWVaWklaw
   v3Z5zrHFTj5iE7C1WnK1OCkhT19okuplhlcy8NrkB/fWoF5a7qqPFb0hU
   Q==;
X-CSE-ConnectionGUID: sPGvhjMsRz6XhmUQgye9Pw==
X-CSE-MsgGUID: vTgEPU+1TVipWnApZVwNTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="63518096"
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="63518096"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 16:42:08 -0700
X-CSE-ConnectionGUID: AB5Y74zQThiUHO3Mt2V9sA==
X-CSE-MsgGUID: p+/eOu1FTPu0EK4JGw9zQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="134303719"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 11 Apr 2025 16:42:07 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u3O0a-000BRb-1Y;
	Fri, 11 Apr 2025 23:42:04 +0000
Date: Sat, 12 Apr 2025 07:41:09 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:for-rc] BUILD SUCCESS
 ffc59e32c67e599cc473d6427a4aa584399d5b3c
Message-ID: <202504120703.fQjwesnN-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: ffc59e32c67e599cc473d6427a4aa584399d5b3c  RDMA/bnxt_re: Remove unusable nq variable

elapsed time: 1446m

configs tested: 153
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                      axs103_smp_defconfig    gcc-14.2.0
arc                   randconfig-001-20250411    gcc-14.2.0
arc                   randconfig-001-20250412    gcc-14.2.0
arc                   randconfig-002-20250411    gcc-14.2.0
arc                   randconfig-002-20250412    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                      jornada720_defconfig    clang-21
arm                        multi_v5_defconfig    gcc-14.2.0
arm                   randconfig-001-20250411    clang-21
arm                   randconfig-001-20250412    clang-21
arm                   randconfig-002-20250411    clang-21
arm                   randconfig-002-20250412    gcc-7.5.0
arm                   randconfig-003-20250411    gcc-6.5.0
arm                   randconfig-003-20250412    clang-21
arm                   randconfig-004-20250411    gcc-6.5.0
arm                   randconfig-004-20250412    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250411    gcc-9.5.0
arm64                 randconfig-001-20250412    clang-21
arm64                 randconfig-002-20250411    gcc-9.5.0
arm64                 randconfig-002-20250412    clang-21
arm64                 randconfig-003-20250411    clang-21
arm64                 randconfig-003-20250412    gcc-8.5.0
arm64                 randconfig-004-20250411    clang-21
arm64                 randconfig-004-20250412    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250411    gcc-14.2.0
csky                  randconfig-001-20250412    gcc-14.2.0
csky                  randconfig-002-20250411    gcc-9.3.0
csky                  randconfig-002-20250412    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250411    clang-21
hexagon               randconfig-001-20250412    clang-21
hexagon               randconfig-002-20250411    clang-21
hexagon               randconfig-002-20250412    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250411    gcc-12
i386        buildonly-randconfig-001-20250412    clang-20
i386        buildonly-randconfig-002-20250411    gcc-12
i386        buildonly-randconfig-002-20250412    clang-20
i386        buildonly-randconfig-003-20250411    gcc-12
i386        buildonly-randconfig-003-20250412    clang-20
i386        buildonly-randconfig-004-20250411    clang-20
i386        buildonly-randconfig-004-20250412    clang-20
i386        buildonly-randconfig-005-20250411    gcc-11
i386        buildonly-randconfig-005-20250412    clang-20
i386        buildonly-randconfig-006-20250411    gcc-12
i386        buildonly-randconfig-006-20250412    gcc-11
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250411    gcc-14.2.0
loongarch             randconfig-001-20250412    gcc-14.2.0
loongarch             randconfig-002-20250411    gcc-14.2.0
loongarch             randconfig-002-20250412    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         amcore_defconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    gcc-14.2.0
m68k                        m5307c3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250411    gcc-9.3.0
nios2                 randconfig-001-20250412    gcc-8.5.0
nios2                 randconfig-002-20250411    gcc-7.5.0
nios2                 randconfig-002-20250412    gcc-10.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250411    gcc-14.2.0
parisc                randconfig-001-20250412    gcc-7.5.0
parisc                randconfig-002-20250411    gcc-8.5.0
parisc                randconfig-002-20250412    gcc-9.3.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                      ep88xc_defconfig    gcc-14.2.0
powerpc                    ge_imp3a_defconfig    gcc-14.2.0
powerpc                        icon_defconfig    gcc-14.2.0
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250411    gcc-9.3.0
powerpc               randconfig-001-20250412    clang-18
powerpc               randconfig-002-20250411    clang-21
powerpc               randconfig-002-20250412    clang-21
powerpc               randconfig-003-20250411    clang-21
powerpc               randconfig-003-20250412    clang-18
powerpc64             randconfig-001-20250411    gcc-5.5.0
powerpc64             randconfig-001-20250412    clang-21
powerpc64             randconfig-002-20250411    gcc-5.5.0
powerpc64             randconfig-002-20250412    clang-21
powerpc64             randconfig-003-20250411    clang-21
powerpc64             randconfig-003-20250412    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250411    gcc-9.3.0
riscv                 randconfig-002-20250411    gcc-9.3.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250411    clang-19
s390                  randconfig-002-20250411    gcc-8.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250411    gcc-11.5.0
sh                    randconfig-002-20250411    gcc-5.5.0
sh                           se7721_defconfig    gcc-14.2.0
sh                            titan_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250411    gcc-10.3.0
sparc                 randconfig-002-20250411    gcc-14.2.0
sparc64               randconfig-001-20250411    gcc-8.5.0
sparc64               randconfig-002-20250411    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250411    clang-17
um                    randconfig-002-20250411    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250411    gcc-11
x86_64      buildonly-randconfig-001-20250412    gcc-12
x86_64      buildonly-randconfig-002-20250411    gcc-11
x86_64      buildonly-randconfig-002-20250412    clang-20
x86_64      buildonly-randconfig-003-20250411    clang-20
x86_64      buildonly-randconfig-003-20250412    gcc-11
x86_64      buildonly-randconfig-004-20250411    gcc-12
x86_64      buildonly-randconfig-004-20250412    clang-20
x86_64      buildonly-randconfig-005-20250411    clang-20
x86_64      buildonly-randconfig-005-20250412    clang-20
x86_64      buildonly-randconfig-006-20250411    gcc-12
x86_64      buildonly-randconfig-006-20250412    clang-20
x86_64                              defconfig    gcc-11
xtensa                           alldefconfig    gcc-14.2.0
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-002-20250411    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

