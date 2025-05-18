Return-Path: <linux-rdma+bounces-10401-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7B4ABB1C5
	for <lists+linux-rdma@lfdr.de>; Sun, 18 May 2025 23:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B166E189498F
	for <lists+linux-rdma@lfdr.de>; Sun, 18 May 2025 21:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2091FDA61;
	Sun, 18 May 2025 21:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JtGh4mZo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638342CCC1
	for <linux-rdma@vger.kernel.org>; Sun, 18 May 2025 21:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747604594; cv=none; b=SHlZt1obeTvBFbbl/i2/GLZS1ZQERmdLaVxoxBa796LEeyPguxJyDoVqJZ1rmrONxuUUe7wrJTWFSnHbXBxYXzWcAWuhSWmmVwo0O96u+Xwo2YBwS0PF+W/kcPj6Z3u0x3T5MKjUaWS2lPSctOD+YcGf5TWibHGXSWW/dKypG2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747604594; c=relaxed/simple;
	bh=1YMkEvOG8S3nkypOc8rIxDysu6h1RkTdeTt3+2fw25s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cnLcaEmUEq61GEYixt2Een6Ge0LDcjbGvDmSp7lJR95c7Fide6HzhUTv/rYjJiIeLB7qxlGghmirGBwmgRudTC11RvTyROHqytGalzTG22IwDAUMZxcnFlRCc+dw9HrL4ZDkZuc35AI1kc3j5ZlM6Jde1XZ3UTVMClZwmAOtwYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JtGh4mZo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747604592; x=1779140592;
  h=date:from:to:cc:subject:message-id;
  bh=1YMkEvOG8S3nkypOc8rIxDysu6h1RkTdeTt3+2fw25s=;
  b=JtGh4mZolW7Tk5hEG5XZR5eZMZYt5qMdOiRhjIMHtO/5F9BgfqZI3TJ5
   wxi3wksdFwbwxwPIhpLd4h8nW/QJqFNv/5/GRDgeQXyfNEoPQUpP/9WMc
   zcJhsq6/kmZvPuIbJKMerDwU9/GeO5d/ocHkJOC+uiWMlK6nGHd7MpVSc
   wQiqx612lUQcqG8DSxzWycC0o16kX+BSHie46NHICM4sqv6fkwGjwlVPE
   nBxV85QdL68P8PorxtRYZvTKeBiAGMXv2v462s6yuHkfShDEA4+Sd7gfW
   0pkFpMrI+WrkyJaWwsAg+nuznWpot3U19u/Kd2wMTtgn79OXV9Af43VO2
   w==;
X-CSE-ConnectionGUID: U4fthgvJRwKb1FVkfJ7M9g==
X-CSE-MsgGUID: NZ3WxArzQI25XHvMt9mQyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="53301755"
X-IronPort-AV: E=Sophos;i="6.15,299,1739865600"; 
   d="scan'208";a="53301755"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 14:43:12 -0700
X-CSE-ConnectionGUID: v5wGmLT6Rqu6ePryZ4O7Kg==
X-CSE-MsgGUID: R8uI+LuwQGC4pnG7ZFwS6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,299,1739865600"; 
   d="scan'208";a="139694519"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 18 May 2025 14:43:10 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uGlmm-000L1n-0T;
	Sun, 18 May 2025 21:43:08 +0000
Date: Mon, 19 May 2025 05:42:54 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 d00d16bcbc2553a3ac9acccf2d6444cda5502adf
Message-ID: <202505190544.B9Do4JdO-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: d00d16bcbc2553a3ac9acccf2d6444cda5502adf  RDMA/mlx5: Add support for 200Gbps per lane speeds

elapsed time: 788m

configs tested: 129
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250518    gcc-14.2.0
arc                   randconfig-002-20250518    gcc-11.5.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                     am200epdkit_defconfig    gcc-14.2.0
arm                       aspeed_g4_defconfig    clang-21
arm                       imx_v6_v7_defconfig    clang-16
arm                   randconfig-001-20250518    gcc-10.5.0
arm                   randconfig-002-20250518    clang-21
arm                   randconfig-003-20250518    gcc-7.5.0
arm                   randconfig-004-20250518    clang-16
arm                         s5pv210_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250518    gcc-7.5.0
arm64                 randconfig-002-20250518    clang-21
arm64                 randconfig-003-20250518    clang-21
arm64                 randconfig-004-20250518    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250518    gcc-14.2.0
csky                  randconfig-002-20250518    gcc-9.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250518    clang-21
hexagon               randconfig-002-20250518    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250518    gcc-12
i386        buildonly-randconfig-002-20250518    clang-20
i386        buildonly-randconfig-003-20250518    gcc-12
i386        buildonly-randconfig-004-20250518    gcc-12
i386        buildonly-randconfig-005-20250518    gcc-12
i386        buildonly-randconfig-006-20250518    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250518    gcc-13.3.0
loongarch             randconfig-002-20250518    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                         db1xxx_defconfig    clang-21
mips                           ip27_defconfig    gcc-14.2.0
mips                           mtx1_defconfig    clang-21
mips                   sb1250_swarm_defconfig    gcc-14.2.0
nios2                         3c120_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250518    gcc-5.5.0
nios2                 randconfig-002-20250518    gcc-13.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250518    gcc-8.5.0
parisc                randconfig-002-20250518    gcc-8.5.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                      chrp32_defconfig    clang-19
powerpc               randconfig-001-20250518    gcc-7.5.0
powerpc               randconfig-002-20250518    gcc-5.5.0
powerpc               randconfig-003-20250518    clang-21
powerpc                      tqm8xx_defconfig    clang-19
powerpc64             randconfig-001-20250518    gcc-10.5.0
powerpc64             randconfig-002-20250518    gcc-7.5.0
powerpc64             randconfig-003-20250518    gcc-7.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv             nommu_k210_sdcard_defconfig    gcc-14.2.0
riscv                 randconfig-001-20250518    clang-21
riscv                 randconfig-002-20250518    clang-20
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250518    gcc-7.5.0
s390                  randconfig-002-20250518    gcc-7.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250518    gcc-13.3.0
sh                    randconfig-002-20250518    gcc-7.5.0
sh                        sh7763rdp_defconfig    gcc-14.2.0
sh                        sh7785lcr_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250518    gcc-12.4.0
sparc                 randconfig-002-20250518    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250518    gcc-6.5.0
sparc64               randconfig-002-20250518    gcc-6.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250518    clang-19
um                    randconfig-002-20250518    clang-21
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250518    gcc-12
x86_64      buildonly-randconfig-002-20250518    clang-20
x86_64      buildonly-randconfig-003-20250518    gcc-12
x86_64      buildonly-randconfig-004-20250518    gcc-12
x86_64      buildonly-randconfig-005-20250518    gcc-12
x86_64      buildonly-randconfig-006-20250518    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250518    gcc-12.4.0
xtensa                randconfig-002-20250518    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

