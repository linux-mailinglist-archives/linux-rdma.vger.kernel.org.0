Return-Path: <linux-rdma+bounces-15264-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 242C5CECAB5
	for <lists+linux-rdma@lfdr.de>; Thu, 01 Jan 2026 00:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 193C0300F58C
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Dec 2025 23:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA1F2E9ED6;
	Wed, 31 Dec 2025 23:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZti0UgD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F4F2BF3DF
	for <linux-rdma@vger.kernel.org>; Wed, 31 Dec 2025 23:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767223404; cv=none; b=Cr5j98VJIB/SThWO9YBpLmoP2fNixiyfJrg4qakIPXjgxGTfvmIE7o94YE5QKga3esuSn0iJ6O2LOcJGsaCSlOC1URgMuvv5RRYKLufiCciG7cyVMZA32IYF3afmuGXhW0BbZ04Ab4zz+s/jSPqduBNxlSqHt5wWrr/vFGtEOoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767223404; c=relaxed/simple;
	bh=BbZk7m/a7lpLo8vU5U5r+9TGL6cvnRJibQeyIrbP1t0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ho6im9+KxzMLYTCdU6+O+Myr6x8zoDZ/PQKRSGgdzSJcRoL6zE3GrUi1uufWxbUJdY/OmAibwbyX4fN36nPwoelxqH4YuIK+HbtHK/1ulnj3COJUVYD6utYeKBmSGmZwEOHHz+7EVsAPNmjO49TRRh/OoZEwPbJk1lMrZbES8Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kZti0UgD; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767223402; x=1798759402;
  h=date:from:to:cc:subject:message-id;
  bh=BbZk7m/a7lpLo8vU5U5r+9TGL6cvnRJibQeyIrbP1t0=;
  b=kZti0UgDdQP/KXt91k86vUW9qhLniouH2je4/fSZAiUrk2lwQKuKP9/w
   Prjih80dNz0U6m4r80Ft8JTFa8xyyLpdiUFrMXs1oiu+qchjMpuxfIsMz
   Y+FJg4oTRfVTKryEwWYkGmimnxIb2cQAU5p12ORuBzqstMxg92u4Ajs4T
   O6noOvRKj6T6zc5ujHLn/mqOlJzM7N+5h5nlRoqrOIRVoptVgybCe02ct
   qrn3eyUbTHNCeTM7Jn6BHVi9NSqe2C83FP+16twkW23OzlStE6i0AE9Qs
   x0XY2ZuoZneEjmtuvBeJEB4HUyB8LGrhTe09pQ+gxiTneM6yDawh8r8FM
   Q==;
X-CSE-ConnectionGUID: tMt/xQM7T4S8ogSBz7ARSA==
X-CSE-MsgGUID: Y3K1baykT9OSmmOy2G0MXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11658"; a="67979819"
X-IronPort-AV: E=Sophos;i="6.21,193,1763452800"; 
   d="scan'208";a="67979819"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 15:23:21 -0800
X-CSE-ConnectionGUID: 0VFL1XH6Sded8ty9QntYbQ==
X-CSE-MsgGUID: 59f1W5joQIyEawJV4JdJNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,193,1763452800"; 
   d="scan'208";a="232215578"
Received: from lkp-server01.sh.intel.com (HELO c9aa31daaa89) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 31 Dec 2025 15:23:20 -0800
Received: from kbuild by c9aa31daaa89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vb5XA-000000001Xh-45VC;
	Wed, 31 Dec 2025 23:23:16 +0000
Date: Thu, 01 Jan 2026 07:22:47 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 8818ffb04bfa168dfe5056cd24cee5211dcc4b3c
Message-ID: <202601010741.MYWSHLZh-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 8818ffb04bfa168dfe5056cd24cee5211dcc4b3c  RDMA/hns: Introduce limit_bank mode with better performance

elapsed time: 735m

configs tested: 164
configs skipped: 5

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
arc                   randconfig-001-20260101    gcc-8.5.0
arc                   randconfig-002-20260101    gcc-12.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                           imxrt_defconfig    clang-22
arm                   randconfig-001-20260101    gcc-15.1.0
arm                   randconfig-002-20260101    gcc-15.1.0
arm                   randconfig-003-20260101    gcc-10.5.0
arm                   randconfig-004-20260101    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251231    clang-22
arm64                 randconfig-001-20260101    clang-20
arm64                 randconfig-002-20251231    clang-19
arm64                 randconfig-002-20260101    clang-22
arm64                 randconfig-003-20251231    gcc-8.5.0
arm64                 randconfig-003-20260101    gcc-8.5.0
arm64                 randconfig-004-20251231    gcc-13.4.0
arm64                 randconfig-004-20260101    gcc-8.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251231    gcc-14.3.0
csky                  randconfig-001-20260101    gcc-14.3.0
csky                  randconfig-002-20260101    gcc-12.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251231    clang-22
hexagon               randconfig-002-20251231    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251231    clang-20
i386        buildonly-randconfig-002-20251231    gcc-14
i386        buildonly-randconfig-003-20251231    gcc-14
i386        buildonly-randconfig-004-20251231    gcc-14
i386        buildonly-randconfig-005-20251231    gcc-14
i386        buildonly-randconfig-006-20251231    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20260101    gcc-12
i386                  randconfig-002-20260101    clang-20
i386                  randconfig-003-20260101    clang-20
i386                  randconfig-004-20260101    clang-20
i386                  randconfig-011-20251231    gcc-14
i386                  randconfig-012-20251231    clang-20
i386                  randconfig-013-20251231    gcc-13
i386                  randconfig-014-20251231    gcc-14
i386                  randconfig-015-20251231    gcc-13
i386                  randconfig-016-20251231    clang-20
i386                  randconfig-017-20251231    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251231    gcc-12.5.0
loongarch             randconfig-002-20251231    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                         apollo_defconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                           jazz_defconfig    clang-17
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251231    gcc-8.5.0
nios2                 randconfig-002-20251231    gcc-10.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251231    gcc-8.5.0
parisc                randconfig-002-20251231    gcc-11.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                    ge_imp3a_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251231    gcc-8.5.0
powerpc               randconfig-002-20251231    clang-22
powerpc                    socrates_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251231    clang-16
powerpc64             randconfig-002-20251231    gcc-14.3.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20260101    clang-22
s390                  randconfig-002-20251231    gcc-10.5.0
s390                  randconfig-002-20260101    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                            hp6xx_defconfig    gcc-15.1.0
sh                    randconfig-001-20260101    gcc-15.1.0
sh                    randconfig-002-20260101    gcc-15.1.0
sh                          rsk7264_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20260101    gcc-11.5.0
sparc                 randconfig-002-20260101    gcc-14.3.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260101    clang-22
sparc64               randconfig-002-20260101    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260101    clang-18
um                    randconfig-002-20260101    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251231    gcc-14
x86_64      buildonly-randconfig-001-20260101    clang-20
x86_64      buildonly-randconfig-002-20251231    gcc-14
x86_64      buildonly-randconfig-002-20260101    clang-20
x86_64      buildonly-randconfig-003-20260101    gcc-14
x86_64      buildonly-randconfig-004-20260101    clang-20
x86_64      buildonly-randconfig-005-20260101    gcc-12
x86_64      buildonly-randconfig-006-20260101    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20251231    clang-20
x86_64                randconfig-012-20251231    gcc-14
x86_64                randconfig-013-20251231    gcc-14
x86_64                randconfig-014-20251231    gcc-12
x86_64                randconfig-015-20251231    gcc-14
x86_64                randconfig-016-20251231    gcc-14
x86_64                randconfig-071-20251231    clang-20
x86_64                randconfig-072-20251231    clang-20
x86_64                randconfig-073-20251231    gcc-12
x86_64                randconfig-074-20251231    gcc-14
x86_64                randconfig-075-20251231    clang-20
x86_64                randconfig-076-20251231    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    gcc-15.1.0
xtensa                randconfig-001-20260101    gcc-12.5.0
xtensa                randconfig-002-20260101    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

