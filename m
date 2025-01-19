Return-Path: <linux-rdma+bounces-7101-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCE9A16481
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jan 2025 00:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99DE21635FC
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 23:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE941DF96A;
	Sun, 19 Jan 2025 23:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GiKfpITU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C729F1779B8
	for <linux-rdma@vger.kernel.org>; Sun, 19 Jan 2025 23:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737327844; cv=none; b=U02Iz2fpz0fRceCnzSugTUYs3WphGMzxD+apcegaqZKEBY03+SOf16yf0UMPoWcZKt/SlNL4iNGV8tqSFhNw9CbqEwiR7sIMqgNcgCyXL0/fdlwa0mf2PIgvqwloz0YiKp75aECodRFKVwgHnIPi3ee5hpdMjTGcp3XpwTre80A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737327844; c=relaxed/simple;
	bh=xT0ghZ/iiXN3yvpyRq20RJnjKdcmRlqsTKdN+pbohaw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cg1Sp2DgAk+ZE5V5lbAg1+ud517AvhUaHv8A2Qa0F4jepEtx/GW2+vvSyCw3yc5Q7XaGLiGRqPt03buPcegJIJuzMWALIqKPaZzLvuPfQfS1GJe9SmP8SiporB0ZISM7Cvd6nkd5mQKGulA9Zd/z8VAaNpt4078K+9OkYtL63RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GiKfpITU; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737327843; x=1768863843;
  h=date:from:to:cc:subject:message-id;
  bh=xT0ghZ/iiXN3yvpyRq20RJnjKdcmRlqsTKdN+pbohaw=;
  b=GiKfpITUZRINkr3fEU61eTL7Odbl3Gm7nTE/bEMtD63cm2gO4uagdyLb
   7J6astqDDLy/Ns7S7+QHHCbPgVJu/CLV5VkW4USWk/Aib7brSvYa1pC4F
   jO05fzCb1WwyRMcSyBt2k4TJQDWSkQwIvTt0UONPdHWV6RSAIR3Z79bDj
   z07KgmPHRbUWA19Ph2gwybgrgv3ojOOzM86x9YQ+OOajwtmjgfHtu0iLz
   zrpUGFDgQAf3bmeujFAh9Q8PixntFqU5OvF8U3IrMaQyCEibxIjU6+7CH
   3YQZkSbicquktgkOGrSk65Wb/W8KOizHJpuTZYDQrekE595qgFR1FCT1h
   A==;
X-CSE-ConnectionGUID: slpdyPJ5Q8qdkQoM9F2e2A==
X-CSE-MsgGUID: lexBkfi2S+mR30qbDH84Kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="60153513"
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="60153513"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 15:04:02 -0800
X-CSE-ConnectionGUID: GWXA4AVHSsqzR0t0BdJuWw==
X-CSE-MsgGUID: QeTm0RTYTYK7hBBrhenj2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="129576179"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 19 Jan 2025 15:04:01 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tZeKk-000VvX-2m;
	Sun, 19 Jan 2025 23:03:58 +0000
Date: Mon, 20 Jan 2025 07:03:05 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 f5f01c5c409e697c6ae7091ca578bfbd3825e87c
Message-ID: <202501200759.3UJRsF3r-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: f5f01c5c409e697c6ae7091ca578bfbd3825e87c  RDMA/qib: Constify 'struct bin_attribute'

elapsed time: 812m

configs tested: 137
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                         haps_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20250119    gcc-13.2.0
arc                   randconfig-002-20250119    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                       aspeed_g4_defconfig    clang-20
arm                           h3600_defconfig    gcc-14.2.0
arm                       imx_v4_v5_defconfig    clang-16
arm                   randconfig-001-20250119    gcc-14.2.0
arm                   randconfig-002-20250119    clang-20
arm                   randconfig-003-20250119    clang-16
arm                   randconfig-004-20250119    gcc-14.2.0
arm                         s3c6400_defconfig    gcc-14.2.0
arm                           spitz_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250119    clang-20
arm64                 randconfig-002-20250119    clang-20
arm64                 randconfig-003-20250119    gcc-14.2.0
arm64                 randconfig-004-20250119    clang-20
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250119    gcc-14.2.0
csky                  randconfig-002-20250119    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250119    clang-20
hexagon               randconfig-002-20250119    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250119    clang-19
i386        buildonly-randconfig-002-20250119    gcc-12
i386        buildonly-randconfig-003-20250119    gcc-12
i386        buildonly-randconfig-004-20250119    gcc-12
i386        buildonly-randconfig-005-20250119    clang-19
i386        buildonly-randconfig-006-20250119    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250119    gcc-14.2.0
loongarch             randconfig-002-20250119    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                        m5407c3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ip22_defconfig    gcc-14.2.0
mips                           ip30_defconfig    gcc-14.2.0
nios2                         10m50_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250119    gcc-14.2.0
nios2                 randconfig-002-20250119    gcc-14.2.0
openrisc                         alldefconfig    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
openrisc                 simple_smp_defconfig    gcc-14.2.0
openrisc                       virt_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                generic-32bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20250119    gcc-14.2.0
parisc                randconfig-002-20250119    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                 mpc834x_itx_defconfig    clang-20
powerpc                 mpc837x_rdb_defconfig    gcc-14.2.0
powerpc                      pasemi_defconfig    clang-20
powerpc               randconfig-001-20250119    clang-20
powerpc               randconfig-002-20250119    clang-20
powerpc               randconfig-003-20250119    clang-16
powerpc64                        alldefconfig    clang-20
powerpc64             randconfig-001-20250119    clang-18
powerpc64             randconfig-002-20250119    clang-16
powerpc64             randconfig-003-20250119    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250119    gcc-14.2.0
riscv                 randconfig-002-20250119    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250119    clang-20
s390                  randconfig-002-20250119    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                          kfr2r09_defconfig    gcc-14.2.0
sh                          lboxre2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250119    gcc-14.2.0
sh                    randconfig-002-20250119    gcc-14.2.0
sh                     sh7710voipgw_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250119    gcc-14.2.0
sparc                 randconfig-002-20250119    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250119    gcc-14.2.0
sparc64               randconfig-002-20250119    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250119    clang-18
um                    randconfig-002-20250119    clang-16
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250119    clang-19
x86_64      buildonly-randconfig-002-20250119    gcc-12
x86_64      buildonly-randconfig-003-20250119    gcc-12
x86_64      buildonly-randconfig-004-20250119    clang-19
x86_64      buildonly-randconfig-005-20250119    gcc-12
x86_64      buildonly-randconfig-006-20250119    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250119    gcc-14.2.0
xtensa                randconfig-002-20250119    gcc-14.2.0
xtensa                    smp_lx200_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

