Return-Path: <linux-rdma+bounces-5466-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB399A9C41
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2024 10:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C441C21DE6
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2024 08:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C4E15665E;
	Tue, 22 Oct 2024 08:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZ+HQDdG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37717155326
	for <linux-rdma@vger.kernel.org>; Tue, 22 Oct 2024 08:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729585289; cv=none; b=OG1uWTaxyJGCHR3kKaAbvbja8mos1EzqnbAlQCvKSAYmaZ3uum7F8Q/14FEb8z7AONUwcMLG2JAeWIil2Z3dTVv5pUNTdlsZ5bXpQHzKc62GYr8HO9EzCY/DdIeHZSOY5IyjPAoS9gDp/NVfB8kPd8+JuKs6s7u/ODx1+fvJITQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729585289; c=relaxed/simple;
	bh=4fjOM4ujcOLEzILr3xIcGsZ9y3Lf5SchfjoTEXBJL+k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rKNCc9iSCTT9aFWudzNovXhu5BLp3YNl3XVg0iAqqmckwa153TsDDirM8KmgjwCjE61dAalQgIMqW5IPDOPLrHVjdzqjDcN8Z/RJfqQ5aTxACr3igsXrkLVlT3IHPNZvZ6thHH5endUn0+4GodCV4vaf38kFhs6OuQ7iuIQgZZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZ+HQDdG; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729585288; x=1761121288;
  h=date:from:to:cc:subject:message-id;
  bh=4fjOM4ujcOLEzILr3xIcGsZ9y3Lf5SchfjoTEXBJL+k=;
  b=QZ+HQDdGp5GNxZnysS5THTV4c7wgX83ywDEol53CRY44pdJ74q2AcC1o
   AFVCZ727+17KkzZblnDbic33r4YQJC0w25XgB6kKPqV4tekdVHIR3ucjm
   Rp1Naon60Ahtqy04DBSoq355xcpqPiKQBJK0DDUoNxQUghq8gYcYPnr/V
   ETiIapWiq1HkohJutedHr4Grq8G4Z9HBV7cGPaoPX3Cr/27Lr6AdgXY7N
   5nT6Eip+FVpezcG32KKOppxChKi98uxyy1clMfdxtsUBN/0nQvPQoh+5z
   UTjGP4bECwsI91YpEhpLoS3VrCpTGUoX5CDXlzBl064jJoKEYUvqmVHOx
   g==;
X-CSE-ConnectionGUID: bSsRTiLkThiuzaaucZhMHA==
X-CSE-MsgGUID: QVmX6YK0RtuavFBFVHbdzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="29307312"
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="29307312"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 01:21:26 -0700
X-CSE-ConnectionGUID: 9fdGS6bBQO6kXqh6SqYiwA==
X-CSE-MsgGUID: LD8lgDxhSMiYBvhRijqG9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="79426849"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 22 Oct 2024 01:21:25 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3A8p-000TIk-1B;
	Tue, 22 Oct 2024 08:21:23 +0000
Date: Tue, 22 Oct 2024 16:20:27 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 76d3ddff7153cc0bcc14a63798d19f5d0693ea71
Message-ID: <202410221619.g89YtT0H-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: 76d3ddff7153cc0bcc14a63798d19f5d0693ea71  RDMA/bnxt_re: synchronize the qp-handle table array

elapsed time: 873m

configs tested: 134
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-14.1.0
alpha                  allyesconfig    clang-20
alpha                     defconfig    gcc-14.1.0
arc                    allmodconfig    clang-20
arc                     allnoconfig    gcc-14.1.0
arc                    allyesconfig    clang-20
arc                       defconfig    gcc-14.1.0
arc         randconfig-001-20241022    gcc-14.1.0
arc         randconfig-002-20241022    gcc-14.1.0
arm                    allmodconfig    clang-20
arm                     allnoconfig    gcc-14.1.0
arm                    allyesconfig    clang-20
arm                       defconfig    gcc-14.1.0
arm                ep93xx_defconfig    gcc-14.1.0
arm         milbeaut_m10v_defconfig    gcc-14.1.0
arm                pxa168_defconfig    gcc-14.1.0
arm         randconfig-001-20241022    gcc-14.1.0
arm         randconfig-002-20241022    gcc-14.1.0
arm         randconfig-003-20241022    gcc-14.1.0
arm         randconfig-004-20241022    gcc-14.1.0
arm               s5pv210_defconfig    gcc-14.1.0
arm                 sama5_defconfig    gcc-14.1.0
arm64                  allmodconfig    clang-20
arm64                   allnoconfig    gcc-14.1.0
arm64                     defconfig    gcc-14.1.0
arm64       randconfig-001-20241022    gcc-14.1.0
arm64       randconfig-002-20241022    gcc-14.1.0
arm64       randconfig-003-20241022    gcc-14.1.0
arm64       randconfig-004-20241022    gcc-14.1.0
csky                    allnoconfig    gcc-14.1.0
csky                      defconfig    gcc-14.1.0
csky        randconfig-001-20241022    gcc-14.1.0
csky        randconfig-002-20241022    gcc-14.1.0
hexagon                allmodconfig    clang-20
hexagon                 allnoconfig    gcc-14.1.0
hexagon                allyesconfig    clang-20
hexagon                   defconfig    gcc-14.1.0
hexagon     randconfig-001-20241022    gcc-14.1.0
hexagon     randconfig-002-20241022    gcc-14.1.0
i386                   allmodconfig    clang-18
i386                    allnoconfig    clang-18
i386                   allyesconfig    clang-18
i386                      defconfig    clang-18
loongarch              allmodconfig    gcc-14.1.0
loongarch               allnoconfig    gcc-14.1.0
loongarch                 defconfig    gcc-14.1.0
loongarch   randconfig-001-20241022    gcc-14.1.0
loongarch   randconfig-002-20241022    gcc-14.1.0
m68k                   allmodconfig    gcc-14.1.0
m68k                    allnoconfig    gcc-14.1.0
m68k                   allyesconfig    gcc-14.1.0
m68k                      defconfig    gcc-14.1.0
m68k                  mac_defconfig    gcc-14.1.0
m68k              mvme147_defconfig    gcc-14.1.0
m68k              stmark2_defconfig    gcc-14.1.0
microblaze             allmodconfig    gcc-14.1.0
microblaze              allnoconfig    gcc-14.1.0
microblaze             allyesconfig    gcc-14.1.0
microblaze                defconfig    gcc-14.1.0
mips                    allnoconfig    gcc-14.1.0
mips            bmips_stb_defconfig    gcc-14.1.0
nios2                   allnoconfig    gcc-14.1.0
nios2                     defconfig    gcc-14.1.0
nios2       randconfig-001-20241022    gcc-14.1.0
nios2       randconfig-002-20241022    gcc-14.1.0
openrisc                allnoconfig    clang-20
openrisc               allyesconfig    gcc-14.1.0
openrisc                  defconfig    gcc-12
parisc                 allmodconfig    gcc-14.1.0
parisc                  allnoconfig    clang-20
parisc                 allyesconfig    gcc-14.1.0
parisc                    defconfig    gcc-12
parisc      generic-32bit_defconfig    gcc-14.1.0
parisc      randconfig-001-20241022    gcc-14.1.0
parisc      randconfig-002-20241022    gcc-14.1.0
parisc64                  defconfig    gcc-14.1.0
powerpc                allmodconfig    gcc-14.1.0
powerpc                 allnoconfig    clang-20
powerpc                allyesconfig    gcc-14.1.0
powerpc            cm5200_defconfig    gcc-14.1.0
powerpc     randconfig-001-20241022    gcc-14.1.0
powerpc     randconfig-002-20241022    gcc-14.1.0
powerpc     randconfig-003-20241022    gcc-14.1.0
powerpc       xes_mpc85xx_defconfig    gcc-14.1.0
powerpc64   randconfig-001-20241022    gcc-14.1.0
powerpc64   randconfig-002-20241022    gcc-14.1.0
powerpc64   randconfig-003-20241022    gcc-14.1.0
riscv                  allmodconfig    gcc-14.1.0
riscv                   allnoconfig    clang-20
riscv                  allyesconfig    gcc-14.1.0
riscv                     defconfig    gcc-12
riscv       randconfig-001-20241022    gcc-14.1.0
riscv       randconfig-002-20241022    gcc-14.1.0
s390                   allmodconfig    gcc-14.1.0
s390                    allnoconfig    clang-20
s390                   allyesconfig    gcc-14.1.0
s390                      defconfig    gcc-12
s390        randconfig-001-20241022    gcc-14.1.0
s390        randconfig-002-20241022    gcc-14.1.0
sh                     allmodconfig    gcc-14.1.0
sh                      allnoconfig    gcc-14.1.0
sh                     allyesconfig    gcc-14.1.0
sh                        defconfig    gcc-12
sh          randconfig-001-20241022    gcc-14.1.0
sh          randconfig-002-20241022    gcc-14.1.0
sh              sh7757lcr_defconfig    gcc-14.1.0
sparc                  allmodconfig    gcc-14.1.0
sparc             sparc32_defconfig    gcc-14.1.0
sparc64                   defconfig    gcc-12
sparc64     randconfig-001-20241022    gcc-14.1.0
sparc64     randconfig-002-20241022    gcc-14.1.0
um                     allmodconfig    clang-20
um                      allnoconfig    clang-20
um                     allyesconfig    clang-20
um                        defconfig    gcc-12
um                   i386_defconfig    gcc-12
um          randconfig-001-20241022    gcc-14.1.0
um          randconfig-002-20241022    gcc-14.1.0
um                 x86_64_defconfig    gcc-12
x86_64                  allnoconfig    clang-18
x86_64                 allyesconfig    clang-18
x86_64                    defconfig    clang-18
x86_64                        kexec    clang-18
x86_64                        kexec    gcc-12
x86_64                     rhel-8.3    gcc-12
x86_64                 rhel-8.3-bpf    clang-18
x86_64               rhel-8.3-kunit    clang-18
x86_64                 rhel-8.3-ltp    clang-18
x86_64                rhel-8.3-rust    clang-18
xtensa                 alldefconfig    gcc-14.1.0
xtensa                  allnoconfig    gcc-14.1.0
xtensa        nommu_kc705_defconfig    gcc-14.1.0
xtensa      randconfig-001-20241022    gcc-14.1.0
xtensa      randconfig-002-20241022    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

