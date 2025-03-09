Return-Path: <linux-rdma+bounces-8502-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BA0A57FEC
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Mar 2025 01:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2208716DC22
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Mar 2025 00:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A7836C;
	Sun,  9 Mar 2025 00:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jcpeZiV7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB4E182
	for <linux-rdma@vger.kernel.org>; Sun,  9 Mar 2025 00:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741478748; cv=none; b=aVntqSPazXylVDRL2vaCVhCBeaaKWyZHd25L3o6TRsx8v4kpSzr4k7mSk/sM9cwWiQHSk3JTXdic6HkFei7VLOF9AJtBdz46J27HqqJwlMECPwQxpGSwMGxeaTF8vIsAu56VWMduVrI6nbNAEq1wNcPfrAeg0w4P68uFNl/vakc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741478748; c=relaxed/simple;
	bh=4LZUgJ1SfQvyLIk1jLW+qQP/LX3v24hSqIDJCh1XjEY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kIMFNT1jpz2mzucZCBKumauCBs9RZr8k0rZxduwv7imMNm9I7nfgFN5goAr3sIc6q+YeCuIiPn0zp4bww3mfbJ++OT+j/oQ+9KOkIYhnKszfsxOmCZ31wrSqcbn32fuatK9je+OnhmdU8rYyeB623xoZ8jXrs1aMFvjJN5UTtXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jcpeZiV7; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741478747; x=1773014747;
  h=date:from:to:cc:subject:message-id;
  bh=4LZUgJ1SfQvyLIk1jLW+qQP/LX3v24hSqIDJCh1XjEY=;
  b=jcpeZiV7ZfQiUM+NeTxB62ygjoMMlFKMRUM+XocS4iH1qgMbYzO/YO7f
   S0ayMccdB7c8MA9aFLOu//e3s2GI4J6n40ydGirLHizW3vzLT4n7F3d9e
   A5F1gPFOoOpWak3VbnImFOSlbClZIkCOCZegXDhxW6M/Cdt3R55J4Ymzy
   /XUFS1XVwV5p5VeZASqgjnWNAu+CEIJI5uqM9/ZOgwfb6d4ujq4zHBNVo
   LIvwcMOqBfakJB8+T/h8rML5nM0vZMLGlYGpNugLl1fBF4JwqzXJyHT6r
   jNg5c0vDf2sYh0JirYzMPa8J4WbX6THnS32NQiOiJGVh16sgIGsNlmy3i
   w==;
X-CSE-ConnectionGUID: W837MCbbRueGCzJ6EESROQ==
X-CSE-MsgGUID: hn70e0C8QJeai/R3e1UENg==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="30084733"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="30084733"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 16:05:46 -0800
X-CSE-ConnectionGUID: mogOG88QRL+zacJvojO6Ig==
X-CSE-MsgGUID: 4qLY+64ITCee9UhikY64sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119599232"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 08 Mar 2025 16:05:44 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tr4Ao-0002TK-1T;
	Sun, 09 Mar 2025 00:05:42 +0000
Date: Sun, 09 Mar 2025 08:05:39 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:hmm] BUILD SUCCESS
 d05c69b64a3a1cbf83afa45a35af87d11eee13cc
Message-ID: <202503090833.sDR9tZ71-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git hmm
branch HEAD: d05c69b64a3a1cbf83afa45a35af87d11eee13cc  debug

elapsed time: 1444m

configs tested: 92
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                               allnoconfig    gcc-13.2.0
arc                   randconfig-001-20250308    gcc-13.2.0
arc                   randconfig-001-20250309    gcc-13.2.0
arc                   randconfig-002-20250308    gcc-13.2.0
arc                   randconfig-002-20250309    gcc-13.2.0
arm                               allnoconfig    clang-17
arm                   randconfig-001-20250308    gcc-14.2.0
arm                   randconfig-001-20250309    clang-21
arm                   randconfig-002-20250308    gcc-14.2.0
arm                   randconfig-003-20250308    gcc-14.2.0
arm                   randconfig-004-20250308    gcc-14.2.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250308    gcc-14.2.0
arm64                 randconfig-002-20250308    gcc-14.2.0
arm64                 randconfig-003-20250308    clang-16
arm64                 randconfig-004-20250308    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250308    gcc-14.2.0
csky                  randconfig-002-20250308    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250308    clang-19
hexagon               randconfig-002-20250308    clang-21
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20250308    gcc-12
i386        buildonly-randconfig-001-20250309    clang-19
i386        buildonly-randconfig-002-20250308    gcc-11
i386        buildonly-randconfig-002-20250309    clang-19
i386        buildonly-randconfig-003-20250308    clang-19
i386        buildonly-randconfig-003-20250309    gcc-11
i386        buildonly-randconfig-004-20250308    clang-19
i386        buildonly-randconfig-004-20250309    gcc-12
i386        buildonly-randconfig-005-20250308    clang-19
i386        buildonly-randconfig-005-20250309    clang-19
i386        buildonly-randconfig-006-20250308    gcc-12
i386        buildonly-randconfig-006-20250309    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250308    gcc-14.2.0
loongarch             randconfig-002-20250308    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250308    gcc-14.2.0
nios2                 randconfig-002-20250308    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250308    gcc-14.2.0
parisc                randconfig-002-20250308    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250308    clang-18
powerpc               randconfig-002-20250308    gcc-14.2.0
powerpc               randconfig-003-20250308    gcc-14.2.0
powerpc64             randconfig-001-20250308    gcc-14.2.0
powerpc64             randconfig-003-20250308    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250308    clang-21
riscv                 randconfig-002-20250308    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250308    clang-19
s390                  randconfig-002-20250308    clang-17
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250308    gcc-14.2.0
sh                    randconfig-002-20250308    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250308    gcc-14.2.0
sparc                 randconfig-002-20250308    gcc-14.2.0
sparc64               randconfig-001-20250308    gcc-14.2.0
sparc64               randconfig-002-20250308    gcc-14.2.0
um                                allnoconfig    clang-18
um                    randconfig-001-20250308    gcc-12
um                    randconfig-002-20250308    gcc-12
x86_64                            allnoconfig    clang-19
x86_64      buildonly-randconfig-001-20250308    gcc-12
x86_64      buildonly-randconfig-002-20250308    clang-19
x86_64      buildonly-randconfig-003-20250308    gcc-12
x86_64      buildonly-randconfig-004-20250308    clang-19
x86_64      buildonly-randconfig-005-20250308    clang-19
x86_64      buildonly-randconfig-006-20250308    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250308    gcc-14.2.0
xtensa                randconfig-002-20250308    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

