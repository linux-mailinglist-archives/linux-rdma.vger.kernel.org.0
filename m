Return-Path: <linux-rdma+bounces-5752-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBF29BC425
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 04:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB55928331E
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 03:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA82918C34C;
	Tue,  5 Nov 2024 03:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CCv9nScP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3C2187325
	for <linux-rdma@vger.kernel.org>; Tue,  5 Nov 2024 03:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730779086; cv=none; b=I86QjAorohpMc/PDhl6FHAL56q9cRjiW5mERsV7C/gnl/NmL9UGlj35oSlZHiNvHdHdBr/64FRf1VmZ4RrnxPkaUaxaeVxcJfcKST40uVa+p38CELEygymX3PZeMjSVfYUeUDk+lD7IAcX2M9Od81Z7LiFIRAwMve6Fq+MP4VMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730779086; c=relaxed/simple;
	bh=YVkcH70ST+94MeXnTF59MEyMNwzRbLh4dMbiMnFjKp4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jAiCAjLcO2aCiYjeXPdI7wt7+apEJ7g8vO59tSADo2d5TUgzeqTsGGRiFH1Whpaa/SmjnmDx11bIf+eFn+2iFe5XBu6Vzj/gf5tAHy6qQaaD5BHXcEy8JkehLtp3Kf4iYBrgyeSkwfG/cwzEViKpSaHhgLH1GA6f/yTo++MgA5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CCv9nScP; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730779085; x=1762315085;
  h=date:from:to:cc:subject:message-id;
  bh=YVkcH70ST+94MeXnTF59MEyMNwzRbLh4dMbiMnFjKp4=;
  b=CCv9nScPm/JqVWrD70SpZaxC1Gjjq4XgeILyHH1TZwb/yCj8VMPq1BxN
   qg42LXCed7O7Lx+5SHCJxYB0m/4uNWs//lCCOu5GUVns2kNv+1ErlFmkb
   BaZR/Jv1lxHStU35yMHX1QwVBGSMh38M4JA+QPyxEtBRxPXjvyhG63Dmq
   i97mcdCuulAUhGXI+xn2+CDnRxR7FCViQ1d6YPeo1GB7q0lc5Rz6h7Z/p
   50oVAdszADF23mIWbP40NJ+vb5KkTT60gfd16v8Lz6ip/K4ijjYQMN745
   DTqoaxeHW8pkeprlbgtPhYT38a5oTHdAq67HintxTkmUXCi48k/+xtMII
   w==;
X-CSE-ConnectionGUID: EpUlK/9mSs+goYSraV11Iw==
X-CSE-MsgGUID: M3q12qkZQR+5cVZF4KUnJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="29933173"
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="29933173"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 19:58:04 -0800
X-CSE-ConnectionGUID: /d5pfw16RSaAL23pFfbWZg==
X-CSE-MsgGUID: F9k2MSDYQXOy+tCkx7vIdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="88614966"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 04 Nov 2024 19:58:03 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8Ahc-000laZ-0b;
	Tue, 05 Nov 2024 03:58:00 +0000
Date: Tue, 05 Nov 2024 11:57:33 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 7566752e4d7d7fc0186531aa800068a7243f95c1
Message-ID: <202411051124.KnNon6k5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 7566752e4d7d7fc0186531aa800068a7243f95c1  RDMA/nldev: Add IB device and net device rename events

elapsed time: 950m

configs tested: 235
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.1.0
arc                        nsim_700_defconfig    gcc-14.1.0
arc                   randconfig-001-20241105    gcc-14.1.0
arc                   randconfig-002-20241105    gcc-14.1.0
arc                    vdk_hs38_smp_defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.1.0
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                       aspeed_g5_defconfig    gcc-14.1.0
arm                        clps711x_defconfig    gcc-14.1.0
arm                                 defconfig    gcc-14.1.0
arm                      footbridge_defconfig    gcc-14.1.0
arm                       imx_v4_v5_defconfig    gcc-14.1.0
arm                           imxrt_defconfig    gcc-14.1.0
arm                          ixp4xx_defconfig    gcc-14.1.0
arm                        keystone_defconfig    gcc-14.1.0
arm                   randconfig-001-20241105    gcc-14.1.0
arm                   randconfig-002-20241105    gcc-14.1.0
arm                   randconfig-003-20241105    gcc-14.1.0
arm                   randconfig-004-20241105    gcc-14.1.0
arm                        shmobile_defconfig    gcc-14.1.0
arm                         wpcm450_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241105    gcc-14.1.0
arm64                 randconfig-002-20241105    gcc-14.1.0
arm64                 randconfig-003-20241105    gcc-14.1.0
arm64                 randconfig-004-20241105    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241105    gcc-14.1.0
csky                  randconfig-002-20241105    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241105    gcc-14.1.0
hexagon               randconfig-002-20241105    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241105    clang-19
i386        buildonly-randconfig-002-20241105    clang-19
i386        buildonly-randconfig-003-20241105    clang-19
i386        buildonly-randconfig-004-20241105    clang-19
i386        buildonly-randconfig-005-20241105    clang-19
i386        buildonly-randconfig-006-20241105    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241105    clang-19
i386                  randconfig-002-20241105    clang-19
i386                  randconfig-003-20241105    clang-19
i386                  randconfig-004-20241105    clang-19
i386                  randconfig-005-20241105    clang-19
i386                  randconfig-006-20241105    clang-19
i386                  randconfig-011-20241105    clang-19
i386                  randconfig-012-20241105    clang-19
i386                  randconfig-013-20241105    clang-19
i386                  randconfig-014-20241105    clang-19
i386                  randconfig-015-20241105    clang-19
i386                  randconfig-016-20241105    clang-19
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241105    gcc-14.1.0
loongarch             randconfig-002-20241105    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                         apollo_defconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                          sun3x_defconfig    gcc-14.1.0
m68k                           virt_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
microblaze                      mmu_defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          ath79_defconfig    gcc-14.1.0
mips                         bigsur_defconfig    gcc-14.1.0
mips                           ip27_defconfig    gcc-14.1.0
mips                     loongson1b_defconfig    gcc-14.1.0
mips                       rbtx49xx_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241105    gcc-14.1.0
nios2                 randconfig-002-20241105    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241105    gcc-14.1.0
parisc                randconfig-002-20241105    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                      arches_defconfig    gcc-14.1.0
powerpc                    ge_imp3a_defconfig    gcc-14.1.0
powerpc                      mgcoge_defconfig    gcc-14.1.0
powerpc                     mpc512x_defconfig    gcc-14.1.0
powerpc                 mpc834x_itx_defconfig    gcc-14.1.0
powerpc                     ppa8548_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241105    gcc-14.1.0
powerpc               randconfig-002-20241105    gcc-14.1.0
powerpc               randconfig-003-20241105    gcc-14.1.0
powerpc                  storcenter_defconfig    gcc-14.1.0
powerpc                     taishan_defconfig    gcc-14.1.0
powerpc64             randconfig-001-20241105    gcc-14.1.0
powerpc64             randconfig-002-20241105    gcc-14.1.0
powerpc64             randconfig-003-20241105    gcc-14.1.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241105    gcc-14.1.0
riscv                 randconfig-002-20241105    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241105    gcc-14.1.0
s390                  randconfig-002-20241105    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                         ap325rxa_defconfig    gcc-14.1.0
sh                         apsh4a3a_defconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                ecovec24-romimage_defconfig    gcc-14.1.0
sh                             espt_defconfig    gcc-14.1.0
sh                          lboxre2_defconfig    gcc-14.1.0
sh                     magicpanelr2_defconfig    gcc-14.1.0
sh                          r7780mp_defconfig    gcc-14.1.0
sh                    randconfig-001-20241105    gcc-14.1.0
sh                    randconfig-002-20241105    gcc-14.1.0
sh                      rts7751r2d1_defconfig    gcc-14.1.0
sh                          sdk7786_defconfig    gcc-14.1.0
sh                           se7712_defconfig    gcc-14.1.0
sh                           se7722_defconfig    gcc-14.1.0
sh                           se7724_defconfig    gcc-14.1.0
sh                   secureedge5410_defconfig    gcc-14.1.0
sh                           sh2007_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241105    gcc-14.1.0
sparc64               randconfig-002-20241105    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                             i386_defconfig    gcc-14.1.0
um                    randconfig-001-20241105    gcc-14.1.0
um                    randconfig-002-20241105    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241104    gcc-12
x86_64      buildonly-randconfig-001-20241105    gcc-12
x86_64      buildonly-randconfig-002-20241104    gcc-12
x86_64      buildonly-randconfig-002-20241105    gcc-12
x86_64      buildonly-randconfig-003-20241104    gcc-12
x86_64      buildonly-randconfig-003-20241105    gcc-12
x86_64      buildonly-randconfig-004-20241104    gcc-12
x86_64      buildonly-randconfig-004-20241105    gcc-12
x86_64      buildonly-randconfig-005-20241104    gcc-12
x86_64      buildonly-randconfig-005-20241105    gcc-12
x86_64      buildonly-randconfig-006-20241104    gcc-12
x86_64      buildonly-randconfig-006-20241105    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241104    gcc-12
x86_64                randconfig-001-20241105    gcc-12
x86_64                randconfig-002-20241104    gcc-12
x86_64                randconfig-002-20241105    gcc-12
x86_64                randconfig-003-20241104    gcc-12
x86_64                randconfig-003-20241105    gcc-12
x86_64                randconfig-004-20241104    gcc-12
x86_64                randconfig-004-20241105    gcc-12
x86_64                randconfig-005-20241104    gcc-12
x86_64                randconfig-005-20241105    gcc-12
x86_64                randconfig-006-20241104    gcc-12
x86_64                randconfig-006-20241105    gcc-12
x86_64                randconfig-011-20241104    gcc-12
x86_64                randconfig-011-20241105    gcc-12
x86_64                randconfig-012-20241104    gcc-12
x86_64                randconfig-012-20241105    gcc-12
x86_64                randconfig-013-20241104    gcc-12
x86_64                randconfig-013-20241105    gcc-12
x86_64                randconfig-014-20241104    gcc-12
x86_64                randconfig-014-20241105    gcc-12
x86_64                randconfig-015-20241104    gcc-12
x86_64                randconfig-015-20241105    gcc-12
x86_64                randconfig-016-20241104    gcc-12
x86_64                randconfig-016-20241105    gcc-12
x86_64                randconfig-071-20241104    gcc-12
x86_64                randconfig-071-20241105    gcc-12
x86_64                randconfig-072-20241104    gcc-12
x86_64                randconfig-072-20241105    gcc-12
x86_64                randconfig-073-20241104    gcc-12
x86_64                randconfig-073-20241105    gcc-12
x86_64                randconfig-074-20241104    gcc-12
x86_64                randconfig-074-20241105    gcc-12
x86_64                randconfig-075-20241104    gcc-12
x86_64                randconfig-075-20241105    gcc-12
x86_64                randconfig-076-20241104    gcc-12
x86_64                randconfig-076-20241105    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.1.0
xtensa                generic_kc705_defconfig    gcc-14.1.0
xtensa                randconfig-001-20241105    gcc-14.1.0
xtensa                randconfig-002-20241105    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

