Return-Path: <linux-rdma+bounces-12597-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733CEB1C383
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 11:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90D47207DF
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 09:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9217728A3FA;
	Wed,  6 Aug 2025 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ekCcW5XY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DD4289E3D
	for <linux-rdma@vger.kernel.org>; Wed,  6 Aug 2025 09:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754473197; cv=none; b=KitZvABt/PVXeP84b+JvRZdQe4+FwLW1/GHQx4eJkrXOiCYyTv/dcEiqsw0iy0b5II0a0sIuEPvl7jAo9ldkhL/8irU+jhlVQVqnUJoN6uWV1Cj208EItzMsZXHCWWtov72P7/x538NS6ZUyOvu0FlOAwU9dht0LhbD9Yl235yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754473197; c=relaxed/simple;
	bh=EwuyJ2Vd9HdXkcRFyD91rfvMJSaooGrbKVeKf+m0cFg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=lwgamxa4GBN4SUyV8PlyplKtwyGcsF8zQaw+X960P3fipaTJr84IdD7pZChHNDgxFriMlSDKbGFtZ0JTJVxb4q0Nue9ARht6pupIsGrI3hGsiCRFbpQu9FQR72PeJz31wKiRx+G0QV4+jLOPS/4qj9Brikp9YcyupaV8O66quko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ekCcW5XY; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754473195; x=1786009195;
  h=date:from:to:cc:subject:message-id;
  bh=EwuyJ2Vd9HdXkcRFyD91rfvMJSaooGrbKVeKf+m0cFg=;
  b=ekCcW5XY8i/QUzX1TTthLnao/rcAT7aOSMxvofkxoIOr9GQYPJOl4/Wb
   s/p6lrzIN28QwpQGchiGiOB0OUZVawKgluwvNoDMYTyPjVtpheKpjlHaq
   Md2XgdlN6SpztukF0z1BaJAEFaNsCTFuY3k5I5gzO4vZOLWuHWmlVgMix
   dWRm1PcJR+1t9p2kHedxWTTCGki2D7qBYWo2FcsnTCoKpqkdCvXWyjJQE
   61MtCf5F1lfkqAlULTUWLGjQgGRsrP7leUERjUkxqPkTNNd923k79krN8
   pgWyRnAnT72zAvngiAvQP0Sq4fdS7ozTt8VUp4CybhJr9Hs0qwRAeDjIG
   g==;
X-CSE-ConnectionGUID: DKOSch9QThG7F9DEbOoRCA==
X-CSE-MsgGUID: /f305g2SRDeb/BfW194L7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="44377124"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="44377124"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 02:39:54 -0700
X-CSE-ConnectionGUID: VRqd8JvCRmCP9pfTb5nIsQ==
X-CSE-MsgGUID: WA3R+wbeQWauICW/xzvoWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="168854205"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 06 Aug 2025 02:39:53 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujach-0001Tw-0H;
	Wed, 06 Aug 2025 09:39:51 +0000
Date: Wed, 06 Aug 2025 17:39:26 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 c18646248fed07683d4cee8a8af933fc4fe83c0d
Message-ID: <202508061716.lvQmsHn6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: c18646248fed07683d4cee8a8af933fc4fe83c0d  RDMA/siw: Fix the sendmsg byte count in siw_tcp_sendpages

elapsed time: 1142m

configs tested: 182
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
arc                   randconfig-001-20250805    gcc-8.5.0
arc                   randconfig-001-20250806    gcc-12.5.0
arc                   randconfig-002-20250805    gcc-10.5.0
arc                   randconfig-002-20250806    gcc-11.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250805    gcc-11.5.0
arm                   randconfig-001-20250806    gcc-10.5.0
arm                   randconfig-002-20250805    clang-22
arm                   randconfig-002-20250806    gcc-13.4.0
arm                   randconfig-003-20250805    gcc-12.5.0
arm                   randconfig-003-20250806    gcc-10.5.0
arm                   randconfig-004-20250805    clang-18
arm                   randconfig-004-20250806    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250805    gcc-12.5.0
arm64                 randconfig-001-20250806    clang-20
arm64                 randconfig-002-20250805    clang-20
arm64                 randconfig-002-20250806    clang-22
arm64                 randconfig-003-20250805    gcc-11.5.0
arm64                 randconfig-003-20250806    gcc-9.5.0
arm64                 randconfig-004-20250805    gcc-13.4.0
arm64                 randconfig-004-20250806    clang-17
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250805    gcc-12.5.0
csky                  randconfig-001-20250806    gcc-10.5.0
csky                  randconfig-002-20250805    gcc-10.5.0
csky                  randconfig-002-20250806    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250805    clang-20
hexagon               randconfig-001-20250806    clang-18
hexagon               randconfig-002-20250805    clang-22
hexagon               randconfig-002-20250806    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250805    clang-20
i386        buildonly-randconfig-001-20250806    clang-20
i386        buildonly-randconfig-002-20250805    gcc-12
i386        buildonly-randconfig-002-20250806    gcc-11
i386        buildonly-randconfig-003-20250805    gcc-12
i386        buildonly-randconfig-003-20250806    clang-20
i386        buildonly-randconfig-004-20250805    gcc-12
i386        buildonly-randconfig-004-20250806    gcc-12
i386        buildonly-randconfig-005-20250805    gcc-12
i386        buildonly-randconfig-005-20250806    gcc-12
i386        buildonly-randconfig-006-20250805    gcc-12
i386        buildonly-randconfig-006-20250806    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250805    gcc-15.1.0
loongarch             randconfig-001-20250806    clang-18
loongarch             randconfig-002-20250805    gcc-12.5.0
loongarch             randconfig-002-20250806    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                         apollo_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                   sb1250_swarm_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250805    gcc-11.5.0
nios2                 randconfig-001-20250806    gcc-10.5.0
nios2                 randconfig-002-20250805    gcc-8.5.0
nios2                 randconfig-002-20250806    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                    or1ksim_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250805    gcc-10.5.0
parisc                randconfig-001-20250806    gcc-15.1.0
parisc                randconfig-002-20250805    gcc-15.1.0
parisc                randconfig-002-20250806    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                         ps3_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250805    clang-22
powerpc               randconfig-001-20250806    clang-22
powerpc               randconfig-002-20250805    clang-22
powerpc               randconfig-002-20250806    gcc-14.3.0
powerpc               randconfig-003-20250805    gcc-9.5.0
powerpc               randconfig-003-20250806    clang-22
powerpc                     stx_gp3_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250805    clang-22
powerpc64             randconfig-001-20250806    gcc-15.1.0
powerpc64             randconfig-002-20250805    clang-19
powerpc64             randconfig-002-20250806    gcc-10.5.0
powerpc64             randconfig-003-20250805    clang-22
powerpc64             randconfig-003-20250806    clang-18
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250805    clang-18
riscv                 randconfig-001-20250806    clang-20
riscv                 randconfig-002-20250805    gcc-9.5.0
riscv                 randconfig-002-20250806    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250805    clang-22
s390                  randconfig-001-20250806    gcc-14.3.0
s390                  randconfig-002-20250805    clang-22
s390                  randconfig-002-20250806    gcc-14.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         apsh4a3a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250805    gcc-9.5.0
sh                    randconfig-001-20250806    gcc-15.1.0
sh                    randconfig-002-20250805    gcc-14.3.0
sh                    randconfig-002-20250806    gcc-10.5.0
sh                            titan_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250805    gcc-8.5.0
sparc                 randconfig-001-20250806    gcc-11.5.0
sparc                 randconfig-002-20250805    gcc-15.1.0
sparc                 randconfig-002-20250806    gcc-13.4.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250805    gcc-9.5.0
sparc64               randconfig-001-20250806    gcc-8.5.0
sparc64               randconfig-002-20250805    clang-22
sparc64               randconfig-002-20250806    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250805    gcc-12
um                    randconfig-001-20250806    clang-16
um                    randconfig-002-20250805    gcc-12
um                    randconfig-002-20250806    gcc-12
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250805    gcc-12
x86_64      buildonly-randconfig-001-20250806    gcc-12
x86_64      buildonly-randconfig-002-20250805    gcc-12
x86_64      buildonly-randconfig-002-20250806    clang-20
x86_64      buildonly-randconfig-003-20250805    clang-20
x86_64      buildonly-randconfig-003-20250806    gcc-12
x86_64      buildonly-randconfig-004-20250805    gcc-12
x86_64      buildonly-randconfig-004-20250806    gcc-12
x86_64      buildonly-randconfig-005-20250805    clang-20
x86_64      buildonly-randconfig-005-20250806    clang-20
x86_64      buildonly-randconfig-006-20250805    gcc-12
x86_64      buildonly-randconfig-006-20250806    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250805    gcc-14.3.0
xtensa                randconfig-001-20250806    gcc-13.4.0
xtensa                randconfig-002-20250805    gcc-15.1.0
xtensa                randconfig-002-20250806    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

