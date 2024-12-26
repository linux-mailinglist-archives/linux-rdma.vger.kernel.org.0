Return-Path: <linux-rdma+bounces-6752-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D49C69FCD20
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Dec 2024 19:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240E8163ABF
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Dec 2024 18:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32ED4437;
	Thu, 26 Dec 2024 18:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M0W4kt0H"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2E44437C
	for <linux-rdma@vger.kernel.org>; Thu, 26 Dec 2024 18:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735237926; cv=none; b=WJh6QglUJt4Ge1QEB7xlylqgTh8fKUojB8oVdfueFdUy4sWRq9Ke90m9Zia8OHy6wYK151SkpgbXdxBiYxyXR88HUkq5I+j5zFWg3ZZksW/3A1oQm5JP2T+nss+AAAJCtKVGYCKww83aqfxBTPmo3yp+EJO+PIFgf/p3q/VKrq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735237926; c=relaxed/simple;
	bh=OvM92zIu8/2aKdlcmezoI0ok2UeuY0t78YfMnSORjj4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=eOeNRoSLzdzrsCJVyYTQBDY9EGk9a6kPIXuWvd8wDWmiCtTdzbATNy5E/ZUkmDvmhDSFPRWUGA882VjZhLcaUXtMcXdUrUSo04veNJE6mQVlq+8SU3qWR6TAorrxc0HwZz6EUahKpoNkt7dlQUR+O+kz0IFt2zWg/OFunFjhZjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M0W4kt0H; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735237924; x=1766773924;
  h=date:from:to:cc:subject:message-id;
  bh=OvM92zIu8/2aKdlcmezoI0ok2UeuY0t78YfMnSORjj4=;
  b=M0W4kt0HEhVogn5OkkJ3ETrG1pLnplLXo1Ez151yi2+x8yQ+TZ+kDm3b
   Ce9qb1G13Qt/j8bYQXc4FIcoaJcZqY1Yx+F02V7XD7zSXtfojQd6z6DJE
   UgujJd/Io0pixeZWaLyH48mt7UQl2NqxZ7gBDX79xbZJi+RuQh2dCaOEx
   Y2dV/tJxX0aXojekIytNcO8dZdjsgAPZ0nNRBiKR387mLvDmF4GImdv/K
   /RRAS0avPa23asZGDH/IGvNstnXAFBk1bbYd5pa/aJLMkZGe1lNgS2SHX
   f6Nh9V8oNq3E63YDalC8cSzHhRk9fEWfsA8/QQNgBNzs8sRxHbP/9XHJZ
   A==;
X-CSE-ConnectionGUID: OvPbpPkuQ2Csz9XFWdAGeg==
X-CSE-MsgGUID: 0iW8ay9lRzWZEiyxrHx3lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="61037350"
X-IronPort-AV: E=Sophos;i="6.12,267,1728975600"; 
   d="scan'208";a="61037350"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 10:32:03 -0800
X-CSE-ConnectionGUID: Ejw4nz9OSdGsU86DxEpIXA==
X-CSE-MsgGUID: iLyCpxhnQraXt8BUh0GbtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="99833605"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 26 Dec 2024 10:32:02 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tQseN-0002k0-2k;
	Thu, 26 Dec 2024 18:31:59 +0000
Date: Fri, 27 Dec 2024 02:31:51 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 20b6d8a7b9bdced0c5f9a4887dbf123dd8e334c0
Message-ID: <202412270245.BLQSj7m7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 20b6d8a7b9bdced0c5f9a4887dbf123dd8e334c0  RDMA/hns: Support fast path for link-down events dispatching

elapsed time: 809m

configs tested: 147
configs skipped: 8

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
arc                   randconfig-001-20241226    gcc-13.2.0
arc                   randconfig-002-20241226    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-20
arm                          gemini_defconfig    clang-20
arm                        keystone_defconfig    gcc-14.2.0
arm                   randconfig-001-20241226    clang-20
arm                   randconfig-002-20241226    gcc-14.2.0
arm                   randconfig-003-20241226    clang-20
arm                   randconfig-004-20241226    gcc-14.2.0
arm                           u8500_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241226    clang-15
arm64                 randconfig-002-20241226    clang-17
arm64                 randconfig-003-20241226    clang-19
arm64                 randconfig-004-20241226    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241226    gcc-14.2.0
csky                  randconfig-002-20241226    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-18
hexagon                             defconfig    clang-20
hexagon               randconfig-001-20241226    clang-20
hexagon               randconfig-002-20241226    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241226    clang-19
i386        buildonly-randconfig-002-20241226    clang-19
i386        buildonly-randconfig-003-20241226    gcc-12
i386        buildonly-randconfig-004-20241226    clang-19
i386        buildonly-randconfig-005-20241226    gcc-12
i386        buildonly-randconfig-006-20241226    gcc-11
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    gcc-14.2.0
loongarch             randconfig-001-20241226    gcc-14.2.0
loongarch             randconfig-002-20241226    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                          hp300_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    clang-20
mips                            gpr_defconfig    clang-20
mips                           ip22_defconfig    gcc-14.2.0
mips                          rb532_defconfig    clang-17
mips                       rbtx49xx_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241226    gcc-14.2.0
nios2                 randconfig-002-20241226    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241226    gcc-14.2.0
parisc                randconfig-002-20241226    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                    gamecube_defconfig    clang-16
powerpc                     kmeter1_defconfig    gcc-14.2.0
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc                     rainier_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241226    gcc-14.2.0
powerpc               randconfig-002-20241226    clang-15
powerpc               randconfig-003-20241226    clang-20
powerpc                 xes_mpc85xx_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20241226    gcc-14.2.0
powerpc64             randconfig-002-20241226    clang-20
powerpc64             randconfig-003-20241226    clang-19
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                 randconfig-001-20241226    gcc-14.2.0
riscv                 randconfig-002-20241226    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20241226    gcc-14.2.0
s390                  randconfig-002-20241226    clang-18
sh                               alldefconfig    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                            migor_defconfig    gcc-14.2.0
sh                    randconfig-001-20241226    gcc-14.2.0
sh                    randconfig-002-20241226    gcc-14.2.0
sh                           se7705_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241226    gcc-14.2.0
sparc                 randconfig-002-20241226    gcc-14.2.0
sparc                       sparc64_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241226    gcc-14.2.0
sparc64               randconfig-002-20241226    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241226    gcc-12
um                    randconfig-002-20241226    clang-20
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241226    clang-19
x86_64      buildonly-randconfig-002-20241226    clang-19
x86_64      buildonly-randconfig-003-20241226    clang-19
x86_64      buildonly-randconfig-004-20241226    clang-19
x86_64      buildonly-randconfig-005-20241226    clang-19
x86_64      buildonly-randconfig-006-20241226    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241226    gcc-14.2.0
xtensa                randconfig-002-20241226    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

