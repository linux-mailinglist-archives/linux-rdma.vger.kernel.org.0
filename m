Return-Path: <linux-rdma+bounces-15537-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCBED1C281
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 03:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E02203011982
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 02:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251B12F3C1F;
	Wed, 14 Jan 2026 02:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hMOcWRi2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECEE14A8E
	for <linux-rdma@vger.kernel.org>; Wed, 14 Jan 2026 02:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768358647; cv=none; b=MJ7mZN//kHaaViwm8NC+GeRdtrSwjguV6HV/2KVTePyA1AHpzssUqEwofFTlbYRo2oMgUjUFO1va2kCodwUGYsHOapA0NxdDCRchK7ZusLWURW3GWCcjwGeykJrqrXuuP46U3Sh0fSDWHxsC8oHmjo57PI7BIZBgubPagRjZ3wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768358647; c=relaxed/simple;
	bh=kifyBVULk4a0YXCwx5+0kJSLn7wOFDZLkZZ8A6CeTto=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KWfGiSqSGW0EoqX82uV+y9BYFnrLI5bEus8JdxZWOC7xkLePtkLGqOLvLvrf+6ZIA35HS8iSPmx4rHGaAg5Xo5LE9vGCh8XniN2dfWw5/0ABxB6jCYoam0TjWNCY6KKm5IxPK+6L4rtjo39UsQ8s3PW9outceBRFGOur5oJJB4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hMOcWRi2; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768358646; x=1799894646;
  h=date:from:to:cc:subject:message-id;
  bh=kifyBVULk4a0YXCwx5+0kJSLn7wOFDZLkZZ8A6CeTto=;
  b=hMOcWRi2QSKAtPegn2H1uvr6THhT+PYpL53uxx97mdIaj+sv7eux2Sgb
   YSGIPKwNBoGuFD551vcQXNKBj9RGVE0Xc/XqxarWYV4w5SpZKVrGp7wO3
   V+fxQBuVEDewjf1BlcFeQhb5ntDpbR4+Cv5hMTns/D6kY78/5AzQKJvEK
   bP99AzNZvaUC4fomtZKI2b/4Myn2C0zIJNZkAukwqjeeM2UkdYgDzN5nI
   uI5XZl0yliF499g0G+Hy7hatNviU4p/EaN/kvNxI8h5u4ezYqwbbdqcWw
   dRjp5J+f30UzFdoxIFlEFcg+P8jgmIGfGJtT+a2SrJ2qsJYrJ7v/xui6w
   Q==;
X-CSE-ConnectionGUID: xPAEkAWfTOy4E+Llp/p7sA==
X-CSE-MsgGUID: XDPvVwm/RsiHyZH6B725sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69635859"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="69635859"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 18:44:05 -0800
X-CSE-ConnectionGUID: sPEXaX1kTi+LRw0vNy4JWQ==
X-CSE-MsgGUID: 6JUAqp+lSrm4a4WgtEoqZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="204572617"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 13 Jan 2026 18:44:03 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vfqrZ-00000000Fge-0wNI;
	Wed, 14 Jan 2026 02:44:01 +0000
Date: Wed, 14 Jan 2026 10:43:45 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 c6b61cad07189d4556a968a305056263b73025f4
Message-ID: <202601141039.I1Pr1a2q-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: c6b61cad07189d4556a968a305056263b73025f4  RDMA/iwcm: Fix workqueue list corruption by removing work_list

elapsed time: 764m

configs tested: 236
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    clang-22
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                          axs101_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260114    gcc-10.5.0
arc                   randconfig-002-20260114    gcc-10.5.0
arc                           tb10x_defconfig    gcc-15.2.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                        clps711x_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                          gemini_defconfig    clang-22
arm                       multi_v4t_defconfig    clang-22
arm                             pxa_defconfig    gcc-15.2.0
arm                   randconfig-001-20260114    gcc-10.5.0
arm                   randconfig-002-20260114    gcc-10.5.0
arm                   randconfig-003-20260114    gcc-10.5.0
arm                   randconfig-004-20260114    gcc-10.5.0
arm                        shmobile_defconfig    clang-22
arm                        spear3xx_defconfig    gcc-15.2.0
arm                           stm32_defconfig    clang-22
arm                    vt8500_v6_v7_defconfig    clang-22
arm                         wpcm450_defconfig    clang-22
arm                         wpcm450_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260114    clang-22
arm64                 randconfig-002-20260114    clang-22
arm64                 randconfig-003-20260114    clang-22
arm64                 randconfig-004-20260114    clang-22
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260114    clang-22
csky                  randconfig-002-20260114    clang-22
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260114    clang-22
hexagon               randconfig-002-20260114    clang-22
i386                             alldefconfig    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260113    clang-20
i386        buildonly-randconfig-001-20260114    gcc-14
i386        buildonly-randconfig-002-20260113    clang-20
i386        buildonly-randconfig-002-20260114    gcc-14
i386        buildonly-randconfig-003-20260113    clang-20
i386        buildonly-randconfig-003-20260114    gcc-14
i386        buildonly-randconfig-004-20260113    clang-20
i386        buildonly-randconfig-004-20260114    gcc-14
i386        buildonly-randconfig-005-20260113    clang-20
i386        buildonly-randconfig-005-20260114    gcc-14
i386        buildonly-randconfig-006-20260113    clang-20
i386        buildonly-randconfig-006-20260114    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260114    gcc-14
i386                  randconfig-002-20260114    gcc-14
i386                  randconfig-003-20260114    gcc-14
i386                  randconfig-004-20260114    gcc-14
i386                  randconfig-005-20260114    gcc-14
i386                  randconfig-006-20260114    gcc-14
i386                  randconfig-007-20260114    gcc-14
i386                  randconfig-011-20260114    gcc-14
i386                  randconfig-012-20260114    gcc-14
i386                  randconfig-013-20260114    gcc-14
i386                  randconfig-014-20260114    gcc-14
i386                  randconfig-015-20260114    gcc-14
i386                  randconfig-016-20260114    gcc-14
i386                  randconfig-017-20260114    gcc-14
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260114    clang-22
loongarch             randconfig-002-20260114    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                         apollo_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                       alldefconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                           gcw0_defconfig    gcc-15.2.0
mips                    maltaup_xpa_defconfig    gcc-15.2.0
mips                        vocore2_defconfig    clang-22
nios2                         10m50_defconfig    gcc-15.2.0
nios2                         3c120_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260114    clang-22
nios2                 randconfig-002-20260114    clang-22
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260114    gcc-14.3.0
parisc                randconfig-002-20260114    gcc-14.3.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                      chrp32_defconfig    gcc-15.2.0
powerpc                     ep8248e_defconfig    gcc-15.2.0
powerpc                  mpc866_ads_defconfig    clang-22
powerpc                  mpc885_ads_defconfig    gcc-15.2.0
powerpc                     powernv_defconfig    clang-22
powerpc               randconfig-001-20260114    gcc-14.3.0
powerpc               randconfig-002-20260114    gcc-14.3.0
powerpc                    sam440ep_defconfig    clang-22
powerpc                     tqm8555_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260114    gcc-14.3.0
powerpc64             randconfig-002-20260114    gcc-14.3.0
riscv                            alldefconfig    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv             nommu_k210_sdcard_defconfig    clang-22
riscv                    nommu_virt_defconfig    gcc-15.2.0
riscv                 randconfig-001-20260114    gcc-15.2.0
riscv                 randconfig-002-20260114    gcc-15.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                          debug_defconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260114    gcc-15.2.0
s390                  randconfig-002-20260114    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                        edosk7760_defconfig    clang-22
sh                             espt_defconfig    gcc-15.2.0
sh                          kfr2r09_defconfig    gcc-15.2.0
sh                          lboxre2_defconfig    gcc-15.2.0
sh                    randconfig-001-20260114    gcc-15.2.0
sh                    randconfig-002-20260114    gcc-15.2.0
sh                      rts7751r2d1_defconfig    gcc-15.2.0
sh                           se7619_defconfig    clang-22
sh                     sh7710voipgw_defconfig    gcc-15.2.0
sparc                            alldefconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260113    gcc-14.3.0
sparc                 randconfig-001-20260114    clang-20
sparc                 randconfig-002-20260113    gcc-14.3.0
sparc                 randconfig-002-20260114    clang-20
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260113    gcc-14.3.0
sparc64               randconfig-001-20260114    clang-20
sparc64               randconfig-002-20260113    gcc-14.3.0
sparc64               randconfig-002-20260114    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260113    gcc-14.3.0
um                    randconfig-001-20260114    clang-20
um                    randconfig-002-20260113    gcc-14.3.0
um                    randconfig-002-20260114    clang-20
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260114    clang-20
x86_64      buildonly-randconfig-002-20260114    clang-20
x86_64      buildonly-randconfig-003-20260114    clang-20
x86_64      buildonly-randconfig-004-20260114    clang-20
x86_64      buildonly-randconfig-005-20260114    clang-20
x86_64      buildonly-randconfig-006-20260114    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260114    gcc-14
x86_64                randconfig-002-20260114    gcc-14
x86_64                randconfig-003-20260114    gcc-14
x86_64                randconfig-004-20260114    gcc-14
x86_64                randconfig-005-20260114    gcc-14
x86_64                randconfig-006-20260114    gcc-14
x86_64                randconfig-011-20260113    clang-20
x86_64                randconfig-011-20260114    gcc-14
x86_64                randconfig-012-20260113    clang-20
x86_64                randconfig-012-20260114    gcc-14
x86_64                randconfig-013-20260113    clang-20
x86_64                randconfig-013-20260114    gcc-14
x86_64                randconfig-014-20260113    clang-20
x86_64                randconfig-014-20260114    gcc-14
x86_64                randconfig-015-20260113    clang-20
x86_64                randconfig-015-20260114    gcc-14
x86_64                randconfig-016-20260113    clang-20
x86_64                randconfig-016-20260114    gcc-14
x86_64                randconfig-071-20260113    clang-20
x86_64                randconfig-071-20260114    clang-20
x86_64                randconfig-072-20260113    clang-20
x86_64                randconfig-072-20260114    clang-20
x86_64                randconfig-073-20260113    clang-20
x86_64                randconfig-073-20260114    clang-20
x86_64                randconfig-074-20260113    clang-20
x86_64                randconfig-074-20260114    clang-20
x86_64                randconfig-075-20260113    clang-20
x86_64                randconfig-075-20260114    clang-20
x86_64                randconfig-076-20260113    clang-20
x86_64                randconfig-076-20260114    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                  audio_kc705_defconfig    clang-22
xtensa                  audio_kc705_defconfig    gcc-15.2.0
xtensa                  nommu_kc705_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260113    gcc-14.3.0
xtensa                randconfig-001-20260114    clang-20
xtensa                randconfig-002-20260113    gcc-14.3.0
xtensa                randconfig-002-20260114    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

