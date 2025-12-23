Return-Path: <linux-rdma+bounces-15170-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5F4CD8159
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 05:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 357243015E37
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 04:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D822D9499;
	Tue, 23 Dec 2025 04:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jxQ6MStX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675F02C0F70
	for <linux-rdma@vger.kernel.org>; Tue, 23 Dec 2025 04:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766465905; cv=none; b=EWgYpBqtDLEtS95CqdM5O8ZIBMTkXske1OvGG0YSprgmfpS6tIRcO34awc2Qo2aDdKugNPLjuVdGBvFaU/RprTtxP2zYSzU4vHUSI4b+jFTUIGCH5rBuGOlZ4EXcb2shwaxq7eRUD46SSa+A7CXTQQBRXrRxCoAf5XQMPoqJI0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766465905; c=relaxed/simple;
	bh=FK9U2N/WNJU7BiA2e6P4YzDYoJFNNzbfZMr+GH8+Orc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=a73IJeeiY2UcAZ5WA3ES+g0zOxzgnGRXvw2DORRri12HhRyGJAWSoBuwL8D29XOsuAifLRNp4NO6QtpJHxnnJsZL3ch0LVuNelihVrVKaj83uhecVxSk3AK8k5CBfvZgWnmjHGhwOzVD7fSHXyRju243BcHWpSoCuPUujF5A3C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jxQ6MStX; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766465904; x=1798001904;
  h=date:from:to:cc:subject:message-id;
  bh=FK9U2N/WNJU7BiA2e6P4YzDYoJFNNzbfZMr+GH8+Orc=;
  b=jxQ6MStXruBKZvmqwdxr1ylJGKiGD2mCF8ut1vqbgKKhi1GvpyR4YfB6
   VD9eSSwIqWjaFY8ru5p1ibbwx79YvpXFfhM12aSdx4V7r6AfD/92Vlzkf
   k3YXle4Z3XxVfFd8NXwDjyZcPvQ436B4PbvbTiaB9xoCDdBQxiNhW8Z87
   iuemJ+1KhqIEyCom4qmmrYT7NcmP9id8pw5eGcYeEpYuSYIWo+3/4/RwL
   4Tu8sqrw6yd5ukogVQvU3/KXDkTqpMqctLoZgwj03N/ZbsZSM8U7z5wGK
   FwvNmbqM9GNwVS6T7PCn/32AbJmqQgPLNi2P1wWWf4WrEJZdWf3/HVgjd
   g==;
X-CSE-ConnectionGUID: On60qDSuQ76fHVgghXYqUQ==
X-CSE-MsgGUID: H+b6Ln57T/uo/dd/GBd12w==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="67312771"
X-IronPort-AV: E=Sophos;i="6.21,170,1763452800"; 
   d="scan'208";a="67312771"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 20:58:23 -0800
X-CSE-ConnectionGUID: thbKAQbCRk+I/P+VVs1Pzg==
X-CSE-MsgGUID: 9L41K7svSOWxQw/w19biiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,170,1763452800"; 
   d="scan'208";a="200603431"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 22 Dec 2025 20:58:21 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXuTF-000000001Tp-35OR;
	Tue, 23 Dec 2025 04:58:14 +0000
Date: Tue, 23 Dec 2025 12:58:02 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 9b68a1cc966bc947d00e4c0df7722d118125aa37
Message-ID: <202512231256.qh98zaNP-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: 9b68a1cc966bc947d00e4c0df7722d118125aa37  RDMA/bnxt_re: Fix OOB write in bnxt_re_copy_err_stats()

elapsed time: 1190m

configs tested: 151
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                     nsimosci_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20251223    gcc-8.5.0
arc                   randconfig-002-20251223    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                     am200epdkit_defconfig    gcc-15.1.0
arm                   randconfig-001-20251223    clang-22
arm                   randconfig-002-20251223    gcc-10.5.0
arm                   randconfig-003-20251223    clang-20
arm                   randconfig-004-20251223    gcc-8.5.0
arm                        spear3xx_defconfig    clang-17
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251223    clang-17
arm64                 randconfig-002-20251223    clang-22
arm64                 randconfig-003-20251223    clang-18
arm64                 randconfig-004-20251223    gcc-9.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251223    gcc-11.5.0
csky                  randconfig-002-20251223    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251223    clang-22
hexagon               randconfig-002-20251223    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251223    clang-20
i386        buildonly-randconfig-002-20251223    gcc-14
i386        buildonly-randconfig-003-20251223    clang-20
i386        buildonly-randconfig-004-20251223    clang-20
i386        buildonly-randconfig-005-20251223    gcc-14
i386        buildonly-randconfig-006-20251223    clang-20
i386                  randconfig-001-20251223    clang-20
i386                  randconfig-002-20251223    gcc-14
i386                  randconfig-003-20251223    clang-20
i386                  randconfig-004-20251223    gcc-14
i386                  randconfig-005-20251223    gcc-13
i386                  randconfig-006-20251223    gcc-14
i386                  randconfig-007-20251223    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251223    gcc-15.1.0
loongarch             randconfig-002-20251223    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                        vocore2_defconfig    clang-22
nios2                         10m50_defconfig    gcc-11.5.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20251223    gcc-11.5.0
nios2                 randconfig-002-20251223    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251223    gcc-8.5.0
parisc                randconfig-002-20251223    gcc-8.5.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                     mpc512x_defconfig    clang-22
powerpc               randconfig-001-20251223    clang-22
powerpc               randconfig-002-20251223    clang-22
powerpc64             randconfig-001-20251223    clang-17
powerpc64             randconfig-002-20251223    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251223    gcc-8.5.0
riscv                 randconfig-002-20251223    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251223    gcc-14.3.0
s390                  randconfig-002-20251223    gcc-14.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251223    gcc-10.5.0
sh                    randconfig-002-20251223    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251223    gcc-15.1.0
sparc                 randconfig-002-20251223    gcc-12.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251223    gcc-8.5.0
sparc64               randconfig-002-20251223    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251223    clang-22
um                    randconfig-002-20251223    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251223    clang-20
x86_64      buildonly-randconfig-002-20251223    clang-20
x86_64      buildonly-randconfig-003-20251223    gcc-14
x86_64      buildonly-randconfig-004-20251223    gcc-14
x86_64      buildonly-randconfig-005-20251223    clang-20
x86_64      buildonly-randconfig-006-20251223    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251223    gcc-14
x86_64                randconfig-002-20251223    clang-20
x86_64                randconfig-003-20251223    gcc-14
x86_64                randconfig-004-20251223    clang-20
x86_64                randconfig-005-20251223    gcc-14
x86_64                randconfig-006-20251223    clang-20
x86_64                randconfig-011-20251223    gcc-14
x86_64                randconfig-012-20251223    clang-20
x86_64                randconfig-013-20251223    clang-20
x86_64                randconfig-014-20251223    clang-20
x86_64                randconfig-015-20251223    gcc-14
x86_64                randconfig-016-20251223    gcc-14
x86_64                randconfig-071-20251223    gcc-14
x86_64                randconfig-072-20251223    clang-20
x86_64                randconfig-073-20251223    clang-20
x86_64                randconfig-074-20251223    gcc-14
x86_64                randconfig-075-20251223    gcc-14
x86_64                randconfig-076-20251223    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    gcc-15.1.0
xtensa                randconfig-001-20251223    gcc-8.5.0
xtensa                randconfig-002-20251223    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

