Return-Path: <linux-rdma+bounces-4709-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBDF96931A
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 07:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71F1FB222DB
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 05:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B718B1CDFCB;
	Tue,  3 Sep 2024 05:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YeyBnCVS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B0A19C562
	for <linux-rdma@vger.kernel.org>; Tue,  3 Sep 2024 05:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725340365; cv=none; b=NMogT5ZAUlO8dsNe15pLC6a7s+quAfowMtnboOlTr+1KxlDKC7/t+gxi1gmaO7Ljr4eQ6DRIGxBaaCq1lhOWrU0osN7SmyF4ECRqeBsBnFbpzEe9toCBmV4qbcCsT9VpFlLZGkeRhkiE97/hUJn9CYJUx/D52S+xVqUqvbWhGLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725340365; c=relaxed/simple;
	bh=UNjbDJfUuzrPUFv1GH2X+ofWWwoDovShctqB7pAceXA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=aGEdLMi16+aBrLkYQkkwRk8ZXAihWGncbzpsr6mt3aBt1291K3Irrqpvwtc9iR9M5O/LAkxlix85usDFdvUKBAGOtYWVUIeZfa2bza2Ssp4bRpPOjiZbwJ+GOrvifBg3UTk/5UhxkWu7NDX36DXbu5mZyawVfwPapYaAsL4sP2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YeyBnCVS; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725340364; x=1756876364;
  h=date:from:to:cc:subject:message-id;
  bh=UNjbDJfUuzrPUFv1GH2X+ofWWwoDovShctqB7pAceXA=;
  b=YeyBnCVS7HgGEZLKI7Z4nuSHi6Z/3OYnzcH66JMpXnyLFNrWyVRMtXTv
   K05I8Htjr2EBEZGjczfldYey8fcpG1tswLwGMyiFz/FGu9kxdFWol7ErG
   72/R7ggL4YH85+iHKXC4Kr15FAcBY7YT/FCHSiBx61m1oWDqFjq1lCd2z
   //nvpSUI7MJ0Www1R0XWLA7utHjGYQDLLZrebtRfbPwddUKN0DQ6jgY9f
   Y8F5DvXKFh/lWwUG9+5ue/e3vpza0pnV8/l6xeQKMnON3ZipV321J+wu0
   twSFcsk7K6R4RiZ3LrrDDCIatG9JvHP0u8FKfRrkEFBVfNsgkujpuqTRO
   Q==;
X-CSE-ConnectionGUID: DcdDB38vQdmFCfzfn28Zew==
X-CSE-MsgGUID: DryU9AlXQAeKu4xBOVcgHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="23791968"
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="23791968"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 22:12:43 -0700
X-CSE-ConnectionGUID: OaUb3OFoT/CAa+ik1Eeo/A==
X-CSE-MsgGUID: 6zMU+mukT9uiiM/rYDpmbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="64414854"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 02 Sep 2024 22:12:41 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slLqJ-0006FC-0n;
	Tue, 03 Sep 2024 05:12:39 +0000
Date: Tue, 03 Sep 2024 13:11:59 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 dc116b7fddbdad000b6f2a8ca41d1fe5371b403c
Message-ID: <202409031356.LtHmoNzX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: dc116b7fddbdad000b6f2a8ca41d1fe5371b403c  RDMA/bnxt_re: Add support for MR Relaxed Ordering

elapsed time: 1121m

configs tested: 171
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                                 defconfig   gcc-14.1.0
arc                        nsim_700_defconfig   clang-20
arc                        nsimosci_defconfig   clang-20
arc                   randconfig-001-20240903   clang-20
arc                   randconfig-002-20240903   clang-20
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                     davinci_all_defconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                      jornada720_defconfig   clang-20
arm                   randconfig-001-20240903   clang-20
arm                   randconfig-002-20240903   clang-20
arm                   randconfig-003-20240903   clang-20
arm                   randconfig-004-20240903   clang-20
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240903   clang-20
arm64                 randconfig-002-20240903   clang-20
arm64                 randconfig-003-20240903   clang-20
arm64                 randconfig-004-20240903   clang-20
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240903   clang-20
csky                  randconfig-002-20240903   clang-20
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
hexagon               randconfig-001-20240903   clang-20
hexagon               randconfig-002-20240903   clang-20
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240903   gcc-12
i386         buildonly-randconfig-002-20240903   gcc-12
i386         buildonly-randconfig-003-20240903   gcc-12
i386         buildonly-randconfig-004-20240903   gcc-12
i386         buildonly-randconfig-005-20240903   gcc-12
i386         buildonly-randconfig-006-20240903   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240903   gcc-12
i386                  randconfig-002-20240903   gcc-12
i386                  randconfig-003-20240903   gcc-12
i386                  randconfig-004-20240903   gcc-12
i386                  randconfig-005-20240903   gcc-12
i386                  randconfig-006-20240903   gcc-12
i386                  randconfig-011-20240903   gcc-12
i386                  randconfig-012-20240903   gcc-12
i386                  randconfig-013-20240903   gcc-12
i386                  randconfig-014-20240903   gcc-12
i386                  randconfig-015-20240903   gcc-12
i386                  randconfig-016-20240903   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240903   clang-20
loongarch             randconfig-002-20240903   clang-20
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                         db1xxx_defconfig   clang-20
mips                     loongson1b_defconfig   clang-20
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240903   clang-20
nios2                 randconfig-002-20240903   clang-20
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc                randconfig-001-20240903   clang-20
parisc                randconfig-002-20240903   clang-20
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                        fsp2_defconfig   clang-20
powerpc                       maple_defconfig   clang-20
powerpc                 mpc834x_itx_defconfig   clang-20
powerpc                      pcm030_defconfig   clang-20
powerpc               randconfig-002-20240903   clang-20
powerpc64                        alldefconfig   clang-20
powerpc64             randconfig-001-20240903   clang-20
powerpc64             randconfig-002-20240903   clang-20
powerpc64             randconfig-003-20240903   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
riscv                 randconfig-001-20240903   clang-20
riscv                 randconfig-002-20240903   clang-20
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
s390                  randconfig-001-20240903   clang-20
s390                  randconfig-002-20240903   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                ecovec24-romimage_defconfig   clang-20
sh                        edosk7760_defconfig   clang-20
sh                          r7780mp_defconfig   clang-20
sh                    randconfig-001-20240903   clang-20
sh                    randconfig-002-20240903   clang-20
sh                           se7619_defconfig   clang-20
sh                           se7721_defconfig   clang-20
sh                   sh7724_generic_defconfig   clang-20
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
sparc64               randconfig-001-20240903   clang-20
sparc64               randconfig-002-20240903   clang-20
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240903   clang-20
um                    randconfig-002-20240903   clang-20
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240903   gcc-12
x86_64       buildonly-randconfig-002-20240903   gcc-12
x86_64       buildonly-randconfig-003-20240903   gcc-12
x86_64       buildonly-randconfig-004-20240903   gcc-12
x86_64       buildonly-randconfig-005-20240903   gcc-12
x86_64       buildonly-randconfig-006-20240903   gcc-12
x86_64                              defconfig   clang-18
x86_64                                  kexec   gcc-12
x86_64                randconfig-001-20240903   gcc-12
x86_64                randconfig-002-20240903   gcc-12
x86_64                randconfig-003-20240903   gcc-12
x86_64                randconfig-004-20240903   gcc-12
x86_64                randconfig-005-20240903   gcc-12
x86_64                randconfig-006-20240903   gcc-12
x86_64                randconfig-011-20240903   gcc-12
x86_64                randconfig-012-20240903   gcc-12
x86_64                randconfig-013-20240903   gcc-12
x86_64                randconfig-014-20240903   gcc-12
x86_64                randconfig-015-20240903   gcc-12
x86_64                randconfig-016-20240903   gcc-12
x86_64                randconfig-071-20240903   gcc-12
x86_64                randconfig-072-20240903   gcc-12
x86_64                randconfig-073-20240903   gcc-12
x86_64                randconfig-074-20240903   gcc-12
x86_64                randconfig-075-20240903   gcc-12
x86_64                randconfig-076-20240903   gcc-12
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240903   clang-20
xtensa                randconfig-002-20240903   clang-20

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

