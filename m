Return-Path: <linux-rdma+bounces-13304-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 833B9B54306
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 08:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4BDE7A6DDF
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 06:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BE7283153;
	Fri, 12 Sep 2025 06:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VsLeY7sp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF64518859B
	for <linux-rdma@vger.kernel.org>; Fri, 12 Sep 2025 06:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757659021; cv=none; b=pIUiKXJt5gGJvqOmWQbxgFYwotqvBuqhrJO8uF2lJOEG4spk+bNeMfEfmyjjl8+W8dHRjTTig5/Bh5is0bA5mV0rsUzNif2+ckAkFQ1AQaRqZqzGk6yEFpcrI+763nqm2JOSuA49yDj3zZWrbQP8Dn+K6jOd9C0Qg0Blk9Sj/AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757659021; c=relaxed/simple;
	bh=UooRYxD4I5m8h/ot33bV0QYcKCESWTTQrmvVvWYeMcw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Tf0lZ2ABcdC9W3R2HlTBF+lQOHyw2I0re99DZNEW0fGNp/NyuafTwuIuV4gL4ZFYUxNKs+gtnl8AqZjMzPV/gJnS/hDUbVu7nnH7iCo1SYnrU9LkTvmZvotEf7ZdUd5OvG8pT/6dlW5HmP/e93unGynT6qG+MpRFUoj+c9c+NSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VsLeY7sp; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757659020; x=1789195020;
  h=date:from:to:cc:subject:message-id;
  bh=UooRYxD4I5m8h/ot33bV0QYcKCESWTTQrmvVvWYeMcw=;
  b=VsLeY7spK+YDluro5rdRSvMl3biqu/RPeuCg8+SuZReu5kGKoNKPjBhf
   AJtdi/Td3rx+VmGnD66CB6KbyeWybUWYxlVHlhFUuwGTVDofiBoQ4rjaK
   ChgmTu++b+H+55uqtFcjPo9T4nrLoueNsbx8wjey3mnuK+UfbGaVOqyXA
   E+jpHsXmZKvNHKQp0G6Rw/fUhp+Z/4SCIpu7W/20bm5d+PIVQMRLcjlyT
   aRhrl+fPCXfPGCHw6Io5QtcqFWCOeiV0i7gHMnr+lZEvbTaNtYWWYcoDY
   Ht0Q7jvqbIjNx4MUBZSgdwJ/RjszzPuJpMr4War0PkJwxeuZjKPsNHPff
   Q==;
X-CSE-ConnectionGUID: CZKzlg7CT/icYImWUOhKpA==
X-CSE-MsgGUID: Fovs2GgORo+btoEugdso6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="60074943"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="60074943"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 23:36:59 -0700
X-CSE-ConnectionGUID: ly6g862vSoC6B9w3rqBsMQ==
X-CSE-MsgGUID: 5mcLy8C+QUK7H0B4B5bAiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="173064043"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 11 Sep 2025 23:36:58 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwxOx-0000sq-03;
	Fri, 12 Sep 2025 06:36:55 +0000
Date: Fri, 12 Sep 2025 14:36:48 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 eba165b2909716c690351d21d9b6b6d95b9e1f59
Message-ID: <202509121438.kjllf6nf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: eba165b2909716c690351d21d9b6b6d95b9e1f59  RDMA/bnxt_re: Avoid GID level QoS update from the driver

elapsed time: 1419m

configs tested: 147
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250911    gcc-8.5.0
arc                   randconfig-002-20250911    gcc-12.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                          gemini_defconfig    clang-20
arm                   randconfig-001-20250911    clang-22
arm                   randconfig-002-20250911    gcc-14.3.0
arm                   randconfig-003-20250911    clang-22
arm                   randconfig-004-20250911    clang-16
arm                    vt8500_v6_v7_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250911    gcc-13.4.0
arm64                 randconfig-002-20250911    gcc-8.5.0
arm64                 randconfig-003-20250911    gcc-8.5.0
arm64                 randconfig-004-20250911    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250911    gcc-15.1.0
csky                  randconfig-002-20250911    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250911    clang-20
hexagon               randconfig-002-20250911    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250911    clang-20
i386        buildonly-randconfig-001-20250912    gcc-14
i386        buildonly-randconfig-002-20250911    clang-20
i386        buildonly-randconfig-002-20250912    clang-20
i386        buildonly-randconfig-003-20250911    clang-20
i386        buildonly-randconfig-003-20250912    gcc-13
i386        buildonly-randconfig-004-20250911    clang-20
i386        buildonly-randconfig-004-20250912    clang-20
i386        buildonly-randconfig-005-20250911    clang-20
i386        buildonly-randconfig-005-20250912    gcc-14
i386        buildonly-randconfig-006-20250911    clang-20
i386        buildonly-randconfig-006-20250912    clang-20
i386                                defconfig    clang-20
loongarch                        alldefconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250911    gcc-15.1.0
loongarch             randconfig-002-20250911    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                        mvme16x_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                       bmips_be_defconfig    gcc-15.1.0
mips                         rt305x_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250911    gcc-11.5.0
nios2                 randconfig-002-20250911    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250911    gcc-8.5.0
parisc                randconfig-002-20250911    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                        cell_defconfig    gcc-15.1.0
powerpc                     kmeter1_defconfig    gcc-15.1.0
powerpc                  mpc885_ads_defconfig    clang-22
powerpc               randconfig-001-20250911    gcc-8.5.0
powerpc               randconfig-002-20250911    gcc-15.1.0
powerpc               randconfig-003-20250911    gcc-8.5.0
powerpc                    sam440ep_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250911    clang-22
powerpc64             randconfig-002-20250911    gcc-11.5.0
powerpc64             randconfig-003-20250911    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250911    clang-20
riscv                 randconfig-002-20250911    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250911    gcc-11.5.0
s390                  randconfig-002-20250911    clang-16
s390                       zfcpdump_defconfig    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                            hp6xx_defconfig    gcc-15.1.0
sh                          lboxre2_defconfig    gcc-15.1.0
sh                    randconfig-001-20250911    gcc-9.5.0
sh                    randconfig-002-20250911    gcc-15.1.0
sh                           se7619_defconfig    gcc-15.1.0
sh                           se7712_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250911    gcc-15.1.0
sparc                 randconfig-002-20250911    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250911    gcc-8.5.0
sparc64               randconfig-002-20250911    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250911    clang-22
um                    randconfig-002-20250911    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250911    gcc-14
x86_64      buildonly-randconfig-001-20250912    gcc-14
x86_64      buildonly-randconfig-002-20250911    gcc-14
x86_64      buildonly-randconfig-002-20250912    gcc-14
x86_64      buildonly-randconfig-003-20250911    clang-20
x86_64      buildonly-randconfig-003-20250912    clang-20
x86_64      buildonly-randconfig-004-20250911    clang-20
x86_64      buildonly-randconfig-004-20250912    clang-20
x86_64      buildonly-randconfig-005-20250911    clang-20
x86_64      buildonly-randconfig-005-20250912    clang-20
x86_64      buildonly-randconfig-006-20250911    gcc-14
x86_64      buildonly-randconfig-006-20250912    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250911    gcc-12.5.0
xtensa                randconfig-002-20250911    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

