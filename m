Return-Path: <linux-rdma+bounces-15249-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B61DCEB011
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Dec 2025 02:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5DCC3019BBC
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Dec 2025 01:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435052D6E53;
	Wed, 31 Dec 2025 01:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WGaOBJ5v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660E52D46D0
	for <linux-rdma@vger.kernel.org>; Wed, 31 Dec 2025 01:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767145203; cv=none; b=kHusOEVeUhLImgsFa/rLiFEPUwgb0XAwTNrRMiXtcySHS08c8pH6l1RaIdXZOo0+/7/k56QH52haAY2TgkYi2H8/kFXts6R3bqPhNjwod6nOmlPunfXwtvca9t1R5CW48V3p6Me7j/3nj2uBvVB/cbmmmg5TLDOdlTw7DrsoHUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767145203; c=relaxed/simple;
	bh=+GT66QDhM8s9igiuzvJ1Puok+MukiAnT2zlHAqLIUUg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=G1jHWNM+ZZCYRhdRTaqWNUS99OJaQ7S1tnNa/oBAlSLg5mdQa1wICfvl4f3ycKiaGfyJZM0tu5PqvQPHivWKkqgnS7/kp99jQZHw5xA2J5flobhjDmcjp7yE0HmYNINW9of+jXQj6WTj6GjbhCixOU4hwgjdGH0n6F4gqtTAjNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WGaOBJ5v; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767145201; x=1798681201;
  h=date:from:to:cc:subject:message-id;
  bh=+GT66QDhM8s9igiuzvJ1Puok+MukiAnT2zlHAqLIUUg=;
  b=WGaOBJ5vCr5oPRVx2eCR9hTpXBzFy20JegsRYsT885In6aiO9aZraMYo
   kUAsZD0uqY1IkE6UFFuIGnxNAXJqM2Pqqv/fzwwZFf85vJB79FUZE43vP
   BBkOiCa7g5HGjbz0PvynGfzBwxslSeyAJrEU/m2BEhaTnC6Vln+iv4tnM
   13sdbSSJnuJNrE2vHJqvMmTzpQIGFTq6N9PVgk2d5g2uTzYy/xjlSRb11
   Olda7GL4fkFj+n01tNXayJx/0+AhBCfbbdrJ3XC4lFBxTatpfTs6cSacQ
   91NgIbuTMyS4k3lPCndD+jN0F00MWtDRqn5UFwfQ5QxYIjOBX/rj20Y3r
   g==;
X-CSE-ConnectionGUID: iMgBFWH+R1iJIRunFdmaHA==
X-CSE-MsgGUID: 1iydXMYGRByCmBDsne9b4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11657"; a="68760636"
X-IronPort-AV: E=Sophos;i="6.21,190,1763452800"; 
   d="scan'208";a="68760636"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 17:40:01 -0800
X-CSE-ConnectionGUID: WU2pB0X2TIikkDte/gT5jQ==
X-CSE-MsgGUID: TvaJpt7RSJuZQ8A4dreYkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,190,1763452800"; 
   d="scan'208";a="200545093"
Received: from lkp-server01.sh.intel.com (HELO c9aa31daaa89) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 30 Dec 2025 17:39:59 -0800
Received: from kbuild by c9aa31daaa89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1valBs-000000000pz-1fjy;
	Wed, 31 Dec 2025 01:39:56 +0000
Date: Wed, 31 Dec 2025 09:39:55 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 fcd431a9627f272b4c0bec445eba365fe2232a94
Message-ID: <202512310949.nM9EEBQF-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: fcd431a9627f272b4c0bec445eba365fe2232a94  RDMA/bnxt_re: fix dma_free_coherent() pointer

elapsed time: 822m

configs tested: 160
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
arc                   randconfig-001-20251230    gcc-12.5.0
arc                   randconfig-002-20251230    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                        clps711x_defconfig    clang-22
arm                                 defconfig    clang-22
arm                   randconfig-001-20251230    gcc-8.5.0
arm                   randconfig-002-20251230    gcc-8.5.0
arm                   randconfig-003-20251230    gcc-10.5.0
arm                   randconfig-004-20251230    gcc-8.5.0
arm                    vt8500_v6_v7_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251230    gcc-15.1.0
arm64                 randconfig-002-20251230    gcc-14.3.0
arm64                 randconfig-003-20251230    clang-22
arm64                 randconfig-004-20251230    clang-20
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251230    gcc-15.1.0
csky                  randconfig-002-20251230    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251230    clang-22
hexagon               randconfig-002-20251230    clang-18
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251230    gcc-14
i386        buildonly-randconfig-002-20251230    clang-20
i386        buildonly-randconfig-003-20251230    clang-20
i386        buildonly-randconfig-004-20251230    clang-20
i386        buildonly-randconfig-005-20251230    clang-20
i386        buildonly-randconfig-006-20251230    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251230    gcc-14
i386                  randconfig-002-20251230    clang-20
i386                  randconfig-003-20251230    clang-20
i386                  randconfig-004-20251230    clang-20
i386                  randconfig-005-20251230    clang-20
i386                  randconfig-006-20251230    clang-20
i386                  randconfig-007-20251230    clang-20
i386                  randconfig-011-20251230    gcc-14
i386                  randconfig-012-20251230    gcc-14
i386                  randconfig-013-20251230    clang-20
i386                  randconfig-014-20251230    gcc-12
i386                  randconfig-015-20251230    gcc-14
i386                  randconfig-016-20251230    gcc-14
i386                  randconfig-017-20251230    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251230    gcc-15.1.0
loongarch             randconfig-002-20251230    clang-22
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
mips                      fuloong2e_defconfig    gcc-15.1.0
mips                          rb532_defconfig    clang-18
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251230    gcc-8.5.0
nios2                 randconfig-002-20251230    gcc-9.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251230    gcc-15.1.0
parisc                randconfig-002-20251230    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                    mvme5100_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251230    gcc-10.5.0
powerpc               randconfig-002-20251230    gcc-12.5.0
powerpc64             randconfig-001-20251230    gcc-14.3.0
powerpc64             randconfig-002-20251230    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251230    gcc-15.1.0
riscv                 randconfig-002-20251230    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251230    gcc-14.3.0
s390                  randconfig-002-20251230    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251230    gcc-13.4.0
sh                    randconfig-002-20251230    gcc-12.5.0
sh                             sh03_defconfig    gcc-15.1.0
sh                            titan_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251230    gcc-8.5.0
sparc                 randconfig-002-20251230    gcc-11.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251230    clang-22
sparc64               randconfig-002-20251230    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251230    gcc-13
um                    randconfig-002-20251230    clang-18
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251230    gcc-14
x86_64      buildonly-randconfig-002-20251230    gcc-14
x86_64      buildonly-randconfig-003-20251230    clang-20
x86_64      buildonly-randconfig-004-20251230    clang-20
x86_64      buildonly-randconfig-005-20251230    clang-20
x86_64      buildonly-randconfig-006-20251230    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251230    gcc-14
x86_64                randconfig-002-20251230    clang-20
x86_64                randconfig-003-20251230    clang-20
x86_64                randconfig-004-20251230    clang-20
x86_64                randconfig-005-20251230    clang-20
x86_64                randconfig-006-20251230    gcc-14
x86_64                randconfig-071-20251230    clang-20
x86_64                randconfig-072-20251230    clang-20
x86_64                randconfig-073-20251230    gcc-14
x86_64                randconfig-074-20251230    clang-20
x86_64                randconfig-075-20251230    clang-20
x86_64                randconfig-076-20251230    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251230    gcc-8.5.0
xtensa                randconfig-002-20251230    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

