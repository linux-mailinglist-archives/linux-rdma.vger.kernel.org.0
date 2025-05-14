Return-Path: <linux-rdma+bounces-10344-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3CBAB6A18
	for <lists+linux-rdma@lfdr.de>; Wed, 14 May 2025 13:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B56EC179753
	for <lists+linux-rdma@lfdr.de>; Wed, 14 May 2025 11:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1497125E461;
	Wed, 14 May 2025 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BVZi8TWd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1655B1A0BE1
	for <linux-rdma@vger.kernel.org>; Wed, 14 May 2025 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747222460; cv=none; b=DIojQXqkBttvrDdy1pUTCEUaRsXcnKUtq1sWLp0dmZr3lExSa3K3L8G5GOqguYDbphFtewpvm9njEd6o6+u36jlCbwa4PXSOQrIBTgFYiuaZ8uk24v1snOI1aL8zczaIjs2d8DL83pM6xL+idMEdqavsV1KlCg+N5rYtsAy1VEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747222460; c=relaxed/simple;
	bh=zc8Kw/zaJEpqQ6MlekBZLUfHEztTKupOPba7g9yajRk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cx21bWgLm9+bD48wgE/zFef87839NDt+JikvnUidqHO05OV5f4JlEZqqL4Ar0UIyEa0FLOxnlHETd/ylctNpMjFtdMPHLbHr4QNXibC/gJJJbbhFDTPU5M011yt+WWLwMSOuvs5ZXOTbauBNH/Es0Yj3vAMMAaot6REoybe/TW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BVZi8TWd; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747222459; x=1778758459;
  h=date:from:to:cc:subject:message-id;
  bh=zc8Kw/zaJEpqQ6MlekBZLUfHEztTKupOPba7g9yajRk=;
  b=BVZi8TWda42+6OJKyCG9dOsMzw7Zi7Q9+faHed4SvU7n37cT64LbXroW
   +p0HyYNkpD1r1G7IuwO4/d58hScBapKeW2/szJkqAL+pdRVdOZBO/YQJU
   p6Zu1TGfRh2dTZs7YPB4IyJBOy0mUruwBCJIuUHny8X13ASXW1pTMjGuc
   bTlAcGjO/87toppVQ7Fa9rVWi8j3cpdWUnleZKKffBItQCUsUqspo96Hc
   clo0OcFdw1KEwPhIkMNmxOLXtFxad3nFdMC2AfDB3rZn1FTdjrY953FNK
   gzqlpG7HmrlON97zg358FeLddmMzvDFTA2MQtd0euZHfGNvBRFTX7zBag
   g==;
X-CSE-ConnectionGUID: AJpjrdSOT0+xt8tKIqslHw==
X-CSE-MsgGUID: T8ZbTybZRp2UkHNMFHk4EQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="52918547"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="52918547"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 04:34:18 -0700
X-CSE-ConnectionGUID: VWFUnuG6SBSnCD28lhFpSw==
X-CSE-MsgGUID: BHANakv5SmKRosMmqUZSKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="138936790"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 14 May 2025 04:34:16 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uFANJ-000H3J-2k;
	Wed, 14 May 2025 11:34:13 +0000
Date: Wed, 14 May 2025 19:33:13 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 21508c8c972ca0ff06b07af37adb4021ab527de2
Message-ID: <202505141903.BI6JS0nc-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 21508c8c972ca0ff06b07af37adb4021ab527de2  Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/linux into wip/leon-for-next

elapsed time: 1444m

configs tested: 199
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                 nsimosci_hs_smp_defconfig    gcc-14.2.0
arc                   randconfig-001-20250513    gcc-14.2.0
arc                   randconfig-001-20250514    gcc-13.3.0
arc                   randconfig-002-20250513    gcc-14.2.0
arc                   randconfig-002-20250514    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                     davinci_all_defconfig    clang-19
arm                          pxa910_defconfig    gcc-14.2.0
arm                   randconfig-001-20250513    gcc-7.5.0
arm                   randconfig-001-20250514    clang-21
arm                   randconfig-002-20250513    gcc-8.5.0
arm                   randconfig-002-20250514    clang-21
arm                   randconfig-003-20250513    gcc-8.5.0
arm                   randconfig-003-20250514    gcc-7.5.0
arm                   randconfig-004-20250513    clang-16
arm                   randconfig-004-20250514    gcc-7.5.0
arm                           tegra_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250513    clang-21
arm64                 randconfig-001-20250514    clang-17
arm64                 randconfig-002-20250513    clang-21
arm64                 randconfig-002-20250514    gcc-5.5.0
arm64                 randconfig-003-20250513    gcc-6.5.0
arm64                 randconfig-003-20250514    gcc-5.5.0
arm64                 randconfig-004-20250513    clang-21
arm64                 randconfig-004-20250514    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250513    gcc-14.2.0
csky                  randconfig-001-20250514    gcc-13.3.0
csky                  randconfig-002-20250513    gcc-12.4.0
csky                  randconfig-002-20250514    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250513    clang-21
hexagon               randconfig-001-20250514    clang-21
hexagon               randconfig-002-20250513    clang-21
hexagon               randconfig-002-20250514    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250513    clang-20
i386        buildonly-randconfig-001-20250514    clang-20
i386        buildonly-randconfig-002-20250513    clang-20
i386        buildonly-randconfig-002-20250514    gcc-12
i386        buildonly-randconfig-003-20250513    clang-20
i386        buildonly-randconfig-003-20250514    clang-20
i386        buildonly-randconfig-004-20250513    clang-20
i386        buildonly-randconfig-004-20250514    clang-20
i386        buildonly-randconfig-005-20250513    gcc-12
i386        buildonly-randconfig-005-20250514    gcc-12
i386        buildonly-randconfig-006-20250513    gcc-12
i386        buildonly-randconfig-006-20250514    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250513    gcc-14.2.0
loongarch             randconfig-001-20250514    gcc-14.2.0
loongarch             randconfig-002-20250513    gcc-14.2.0
loongarch             randconfig-002-20250514    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          amiga_defconfig    gcc-14.2.0
m68k                          hp300_defconfig    gcc-14.2.0
m68k                       m5208evb_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                         bigsur_defconfig    gcc-14.2.0
mips                          eyeq6_defconfig    clang-21
mips                           gcw0_defconfig    clang-21
mips                        qi_lb60_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250513    gcc-10.5.0
nios2                 randconfig-001-20250514    gcc-7.5.0
nios2                 randconfig-002-20250513    gcc-12.4.0
nios2                 randconfig-002-20250514    gcc-11.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
openrisc                    or1ksim_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250513    gcc-11.5.0
parisc                randconfig-001-20250514    gcc-12.4.0
parisc                randconfig-002-20250513    gcc-11.5.0
parisc                randconfig-002-20250514    gcc-10.5.0
powerpc                     akebono_defconfig    clang-21
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                     ep8248e_defconfig    gcc-14.2.0
powerpc                      ep88xc_defconfig    gcc-14.2.0
powerpc                    gamecube_defconfig    clang-21
powerpc                 mpc8315_rdb_defconfig    clang-21
powerpc                     mpc83xx_defconfig    clang-21
powerpc               randconfig-001-20250513    clang-21
powerpc               randconfig-001-20250514    clang-17
powerpc               randconfig-002-20250513    gcc-8.5.0
powerpc               randconfig-002-20250514    gcc-5.5.0
powerpc               randconfig-003-20250513    clang-21
powerpc               randconfig-003-20250514    gcc-7.5.0
powerpc                     tqm8560_defconfig    gcc-14.2.0
powerpc                      tqm8xx_defconfig    clang-19
powerpc64             randconfig-001-20250513    clang-21
powerpc64             randconfig-001-20250514    gcc-10.5.0
powerpc64             randconfig-002-20250513    gcc-8.5.0
powerpc64             randconfig-002-20250514    clang-19
powerpc64             randconfig-003-20250513    clang-21
powerpc64             randconfig-003-20250514    gcc-5.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250513    gcc-14.2.0
riscv                 randconfig-001-20250514    gcc-7.5.0
riscv                 randconfig-002-20250513    gcc-14.2.0
riscv                 randconfig-002-20250514    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250513    clang-21
s390                  randconfig-001-20250514    clang-21
s390                  randconfig-002-20250513    gcc-9.3.0
s390                  randconfig-002-20250514    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                        edosk7705_defconfig    gcc-14.2.0
sh                            hp6xx_defconfig    gcc-14.2.0
sh                          kfr2r09_defconfig    gcc-14.2.0
sh                    randconfig-001-20250513    gcc-12.4.0
sh                    randconfig-001-20250514    gcc-11.5.0
sh                    randconfig-002-20250513    gcc-14.2.0
sh                    randconfig-002-20250514    gcc-9.3.0
sh                          rsk7264_defconfig    gcc-14.2.0
sh                          sdk7786_defconfig    gcc-14.2.0
sh                           se7705_defconfig    gcc-14.2.0
sh                             sh03_defconfig    gcc-14.2.0
sh                   sh7770_generic_defconfig    gcc-14.2.0
sh                              ul2_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250513    gcc-11.5.0
sparc                 randconfig-001-20250514    gcc-8.5.0
sparc                 randconfig-002-20250513    gcc-13.3.0
sparc                 randconfig-002-20250514    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250513    gcc-11.5.0
sparc64               randconfig-001-20250514    gcc-14.2.0
sparc64               randconfig-002-20250513    gcc-13.3.0
sparc64               randconfig-002-20250514    gcc-14.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250513    clang-19
um                    randconfig-001-20250514    gcc-12
um                    randconfig-002-20250513    gcc-12
um                    randconfig-002-20250514    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250513    gcc-12
x86_64      buildonly-randconfig-001-20250514    clang-20
x86_64      buildonly-randconfig-002-20250513    gcc-12
x86_64      buildonly-randconfig-002-20250514    gcc-12
x86_64      buildonly-randconfig-003-20250513    clang-20
x86_64      buildonly-randconfig-003-20250514    gcc-12
x86_64      buildonly-randconfig-004-20250513    gcc-12
x86_64      buildonly-randconfig-004-20250514    gcc-12
x86_64      buildonly-randconfig-005-20250513    clang-20
x86_64      buildonly-randconfig-005-20250514    clang-20
x86_64      buildonly-randconfig-006-20250513    gcc-12
x86_64      buildonly-randconfig-006-20250514    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250513    gcc-7.5.0
xtensa                randconfig-001-20250514    gcc-10.5.0
xtensa                randconfig-002-20250513    gcc-14.2.0
xtensa                randconfig-002-20250514    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

