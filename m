Return-Path: <linux-rdma+bounces-9389-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962F3A8704D
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Apr 2025 02:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE4A07B02A3
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Apr 2025 00:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A29EEBB;
	Sun, 13 Apr 2025 00:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U8rkm2ba"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CE217578
	for <linux-rdma@vger.kernel.org>; Sun, 13 Apr 2025 00:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744505246; cv=none; b=B9WByaPdKUnmn3MGDhaPsMsciNtzjfKh3b0rLZsP/abTz55aMx34yu+O1xw0WhB1DmHJltdHmvn5m6+RImi0tHQ81gMf1W+Ymx3wM0vz5K9nIGBFTHoTRwgYn3FtRFj5o3rZWeycgSZIQQAWXwJ21K9wiMkdnqQ1slnggEy89Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744505246; c=relaxed/simple;
	bh=ZLECLcjcS6OTK7YGWr2XX7dk2cmp0PHxxvZjWgCNJrI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gIlstDl49yrrfv1a29+anZtfD6U9RCfzWpdkync5TFjYZplyuJw8oEUh84+j2ibHZIkxHkbnVdXQmm6+pVBvsYOrIIgTOddWg2PAkWb+Rkdg5Tq8MNM2T04fTGrowMs9TGi6MgRW80JKiH6YSntdPchAQsrW4CL54DcV4V+Yeko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U8rkm2ba; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744505244; x=1776041244;
  h=date:from:to:cc:subject:message-id;
  bh=ZLECLcjcS6OTK7YGWr2XX7dk2cmp0PHxxvZjWgCNJrI=;
  b=U8rkm2baKSDDc6ZKqe0Y6rl3zOvZAV7oGONHc5LJKw2KN4fqbNkn8zqg
   mHc8q0uKVDCDWx8NXaksrSnoj5bWLLjT+s+ohrnYupZYXrtEQRXJZb2xs
   Q/IFU997CL/grnKEjr+wMaXfGf3Y1ElI4V/VZD5+SV8UCqO0MiDjaLBn+
   qMdUlPMRiogTFYLgrBl43XICPxpYeD1pZ17kxcMp04nxTkkl6C6iA3bk5
   QmkpkYDstOYBpk/kdB4xBA6XGVW6KY1Tv7lcOQmsP9pvxNOLBYROvf+R8
   VznPCsrox/fch1IDCKq/mKqInRYTnQHVDL8+fjW7gXRwLm9p+G2SYAVEh
   A==;
X-CSE-ConnectionGUID: xBGZs8YdRumkVsdrjw5bmg==
X-CSE-MsgGUID: 4waV/j61QDa7RvwxTRdmcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="56196924"
X-IronPort-AV: E=Sophos;i="6.15,209,1739865600"; 
   d="scan'208";a="56196924"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2025 17:47:23 -0700
X-CSE-ConnectionGUID: b8NjJMkoQbqujWMVM91Crw==
X-CSE-MsgGUID: 6XArcWI8SDGr9518RC5qEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,209,1739865600"; 
   d="scan'208";a="160485237"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 12 Apr 2025 17:47:22 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u3lVH-000CGm-2T;
	Sun, 13 Apr 2025 00:47:19 +0000
Date: Sun, 13 Apr 2025 08:46:48 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:hmm] BUILD SUCCESS
 c92ae5d4f53ebf9c32ace69c1f89a47e8714d18b
Message-ID: <202504130840.uDbzLjgJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git hmm
branch HEAD: c92ae5d4f53ebf9c32ace69c1f89a47e8714d18b  fwctl: Fix repeated device word in log message

elapsed time: 1441m

configs tested: 134
configs skipped: 3

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
arc                   randconfig-001-20250412    gcc-14.2.0
arc                   randconfig-002-20250412    gcc-14.2.0
arc                    vdk_hs38_smp_defconfig    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                        mvebu_v5_defconfig    gcc-14.2.0
arm                   randconfig-001-20250412    clang-21
arm                   randconfig-002-20250412    gcc-7.5.0
arm                   randconfig-003-20250412    clang-21
arm                   randconfig-004-20250412    clang-21
arm                        realview_defconfig    clang-16
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250412    clang-21
arm64                 randconfig-002-20250412    clang-21
arm64                 randconfig-003-20250412    gcc-8.5.0
arm64                 randconfig-004-20250412    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250412    gcc-14.2.0
csky                  randconfig-002-20250412    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250412    clang-21
hexagon               randconfig-002-20250412    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250412    clang-20
i386        buildonly-randconfig-002-20250412    clang-20
i386        buildonly-randconfig-003-20250412    clang-20
i386        buildonly-randconfig-004-20250412    clang-20
i386        buildonly-randconfig-005-20250412    clang-20
i386        buildonly-randconfig-006-20250412    gcc-11
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250412    gcc-14.2.0
loongarch             randconfig-002-20250412    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          multi_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm63xx_defconfig    clang-21
mips                   sb1250_swarm_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250412    gcc-8.5.0
nios2                 randconfig-002-20250412    gcc-10.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250412    gcc-7.5.0
parisc                randconfig-002-20250412    gcc-9.3.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                     ksi8560_defconfig    gcc-14.2.0
powerpc                 linkstation_defconfig    clang-20
powerpc               randconfig-001-20250412    clang-18
powerpc               randconfig-002-20250412    clang-21
powerpc               randconfig-003-20250412    clang-18
powerpc64             randconfig-001-20250412    clang-21
powerpc64             randconfig-002-20250412    clang-21
powerpc64             randconfig-003-20250412    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250412    clang-20
riscv                 randconfig-001-20250413    gcc-14.2.0
riscv                 randconfig-002-20250412    gcc-8.5.0
riscv                 randconfig-002-20250413    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250412    clang-18
s390                  randconfig-001-20250413    gcc-8.5.0
s390                  randconfig-002-20250412    gcc-9.3.0
s390                  randconfig-002-20250413    gcc-8.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                             espt_defconfig    gcc-14.2.0
sh                               j2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250412    gcc-14.2.0
sh                    randconfig-001-20250413    gcc-11.5.0
sh                    randconfig-002-20250412    gcc-14.2.0
sh                    randconfig-002-20250413    gcc-9.3.0
sh                           se7712_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250412    gcc-10.3.0
sparc                 randconfig-001-20250413    gcc-6.5.0
sparc                 randconfig-002-20250412    gcc-13.3.0
sparc                 randconfig-002-20250413    gcc-14.2.0
sparc64               randconfig-001-20250412    gcc-13.3.0
sparc64               randconfig-001-20250413    gcc-14.2.0
sparc64               randconfig-002-20250412    gcc-5.5.0
sparc64               randconfig-002-20250413    gcc-14.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250412    gcc-12
um                    randconfig-001-20250413    gcc-11
um                    randconfig-002-20250412    gcc-12
um                    randconfig-002-20250413    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250412    gcc-12
x86_64      buildonly-randconfig-002-20250412    clang-20
x86_64      buildonly-randconfig-003-20250412    gcc-11
x86_64      buildonly-randconfig-004-20250412    clang-20
x86_64      buildonly-randconfig-005-20250412    clang-20
x86_64      buildonly-randconfig-006-20250412    clang-20
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250412    gcc-14.2.0
xtensa                randconfig-001-20250413    gcc-6.5.0
xtensa                randconfig-002-20250412    gcc-13.3.0
xtensa                randconfig-002-20250413    gcc-6.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

