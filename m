Return-Path: <linux-rdma+bounces-6783-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DCEA00231
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2025 02:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23D147A1A90
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2025 01:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AC9339A8;
	Fri,  3 Jan 2025 01:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e56/UQcm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94DDD528
	for <linux-rdma@vger.kernel.org>; Fri,  3 Jan 2025 01:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735866405; cv=none; b=Z0eV+6PL2w0BZbbKh5GZ4yKO6w02rthu83lx0RmZIELWnUqMuuuch02yhMbV4OM5bvUy3Mhmpde3X4D8hncr3wQcwYe7BiegnQZTNhuAUZq2h9s49b5SpAxdPG+EUWf11WztaXa0q+prpgYcN+mKM4mD5xEOEb3c8GpVxTret48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735866405; c=relaxed/simple;
	bh=34/bwUpItPJAxj9fGH7jsVsFs6XQCpSvExGTQ4+BOR8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=B55VxmvWdcKqxeUEIRush4B5I6tHck0ui1Z92S0eFN07EWSY53wzUW+r8Jk7+l+w4BAY7Xvv787D4QsajJ/qaukoHdu7LCAfGAFROE6poB09RBEIhRVdOg97Bicx2uUHwicNsFxaJXg0NtttIbkM8KtENuEl7VoSRJgJvXL1Kms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e56/UQcm; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735866403; x=1767402403;
  h=date:from:to:cc:subject:message-id;
  bh=34/bwUpItPJAxj9fGH7jsVsFs6XQCpSvExGTQ4+BOR8=;
  b=e56/UQcm5wWjaYQdINXL83vq8Dbcw6ncvBnwwiFBeac68BnB3qc59myD
   /M/sfNgRxw8nNJJRhGrhSK5qFqIYOW9Mj8wZ22UwhWaawnDKIlltGFDMn
   x7dwiM8/L0oTvADNEKNCMgncPaSHfQqkKQ3L6w9imRJatcHaRim415jLS
   QbZinUlv953QN2u9bsT+BfpV7/tgqgd6I4eeabJaLyP8MyrTuIqOfofvW
   b/tS7CbKUgRXy4mt2PYDYlR5ExMKwXoJyPqp8C/QESy9/Jd6ucHhPnrjW
   Arr73l/OhB6irQncnYYHs++gaFnlCyusN5SEbC/L2tsy3ij7shG8fH3bi
   Q==;
X-CSE-ConnectionGUID: OivEpl/zSnW/wguUf4taQA==
X-CSE-MsgGUID: 2+cowkvsToyIT8rqNnicog==
X-IronPort-AV: E=McAfee;i="6700,10204,11303"; a="36019909"
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="36019909"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 17:06:42 -0800
X-CSE-ConnectionGUID: Ib074vTqR+OC/DAk4ckALw==
X-CSE-MsgGUID: qLaCy5x/RG+ZMD7WY/rdcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102150592"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 02 Jan 2025 17:06:40 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tTW98-00091L-0p;
	Fri, 03 Jan 2025 01:06:38 +0000
Date: Fri, 03 Jan 2025 09:05:49 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 220043b06fded9909bdf62e3355396eff0bb8a52
Message-ID: <202501030943.JcHC6jb8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 220043b06fded9909bdf62e3355396eff0bb8a52  RDMA/mlx5: Fix link status down event for MPV

elapsed time: 848m

configs tested: 234
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              alldefconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                          axs101_defconfig    gcc-14.2.0
arc                          axs103_defconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                     haps_hs_smp_defconfig    gcc-13.2.0
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20250102    gcc-13.2.0
arc                   randconfig-001-20250103    clang-20
arc                   randconfig-002-20250102    gcc-13.2.0
arc                   randconfig-002-20250103    clang-20
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                     davinci_all_defconfig    clang-20
arm                                 defconfig    gcc-14.2.0
arm                            dove_defconfig    gcc-13.2.0
arm                       multi_v4t_defconfig    clang-20
arm                       omap2plus_defconfig    gcc-14.2.0
arm                   randconfig-001-20250102    gcc-14.2.0
arm                   randconfig-001-20250103    clang-20
arm                   randconfig-002-20250102    gcc-14.2.0
arm                   randconfig-002-20250103    clang-20
arm                   randconfig-003-20250102    gcc-14.2.0
arm                   randconfig-003-20250103    clang-20
arm                   randconfig-004-20250102    gcc-14.2.0
arm                   randconfig-004-20250103    clang-20
arm                           stm32_defconfig    gcc-14.2.0
arm                           u8500_defconfig    clang-20
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250102    clang-20
arm64                 randconfig-001-20250103    clang-20
arm64                 randconfig-002-20250102    gcc-14.2.0
arm64                 randconfig-002-20250103    clang-20
arm64                 randconfig-003-20250102    clang-20
arm64                 randconfig-003-20250103    clang-20
arm64                 randconfig-004-20250102    gcc-14.2.0
arm64                 randconfig-004-20250103    clang-20
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250102    gcc-14.2.0
csky                  randconfig-002-20250102    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250102    clang-19
hexagon               randconfig-002-20250102    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250102    gcc-12
i386        buildonly-randconfig-002-20250102    gcc-12
i386        buildonly-randconfig-003-20250102    clang-19
i386        buildonly-randconfig-004-20250102    clang-19
i386        buildonly-randconfig-005-20250102    clang-19
i386        buildonly-randconfig-006-20250102    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250103    clang-19
i386                  randconfig-002-20250103    clang-19
i386                  randconfig-003-20250103    clang-19
i386                  randconfig-004-20250103    clang-19
i386                  randconfig-005-20250103    clang-19
i386                  randconfig-006-20250103    clang-19
i386                  randconfig-007-20250103    clang-19
i386                  randconfig-011-20250103    gcc-12
i386                  randconfig-012-20250103    gcc-12
i386                  randconfig-013-20250103    gcc-12
i386                  randconfig-014-20250103    gcc-12
i386                  randconfig-015-20250103    gcc-12
i386                  randconfig-016-20250103    gcc-12
i386                  randconfig-017-20250103    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250102    gcc-14.2.0
loongarch             randconfig-002-20250102    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                          sun3x_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    clang-20
mips                           ip22_defconfig    clang-20
mips                           ip27_defconfig    gcc-14.2.0
mips                     loongson1b_defconfig    clang-20
mips                      maltaaprp_defconfig    clang-20
mips                        maltaup_defconfig    gcc-13.2.0
mips                       rbtx49xx_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250102    gcc-14.2.0
nios2                 randconfig-002-20250102    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                generic-32bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20250102    gcc-14.2.0
parisc                randconfig-002-20250102    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                          allyesconfig    gcc-14.2.0
powerpc                        cell_defconfig    gcc-13.2.0
powerpc                     ksi8560_defconfig    gcc-14.2.0
powerpc                 linkstation_defconfig    gcc-13.2.0
powerpc                     mpc512x_defconfig    clang-20
powerpc                      ppc6xx_defconfig    clang-20
powerpc               randconfig-001-20250102    clang-20
powerpc               randconfig-002-20250102    gcc-14.2.0
powerpc               randconfig-003-20250102    gcc-14.2.0
powerpc                    socrates_defconfig    gcc-14.2.0
powerpc                     stx_gp3_defconfig    gcc-14.2.0
powerpc                     taishan_defconfig    clang-20
powerpc                     tqm8560_defconfig    gcc-13.2.0
powerpc                        warp_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250102    gcc-14.2.0
powerpc64             randconfig-002-20250102    gcc-14.2.0
powerpc64             randconfig-003-20250102    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-19
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250102    clang-16
riscv                 randconfig-002-20250102    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                                defconfig    gcc-12
s390                  randconfig-001-20250102    clang-20
s390                  randconfig-002-20250102    clang-20
s390                       zfcpdump_defconfig    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                            hp6xx_defconfig    gcc-14.2.0
sh                          kfr2r09_defconfig    gcc-14.2.0
sh                    randconfig-001-20250102    gcc-14.2.0
sh                    randconfig-002-20250102    gcc-14.2.0
sh                              ul2_defconfig    gcc-13.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250102    gcc-14.2.0
sparc                 randconfig-002-20250102    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250102    gcc-14.2.0
sparc64               randconfig-002-20250102    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250102    clang-16
um                    randconfig-002-20250102    clang-18
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250102    gcc-12
x86_64      buildonly-randconfig-002-20250102    gcc-12
x86_64      buildonly-randconfig-003-20250102    gcc-12
x86_64      buildonly-randconfig-004-20250102    clang-19
x86_64      buildonly-randconfig-005-20250102    gcc-12
x86_64      buildonly-randconfig-006-20250102    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250103    gcc-12
x86_64                randconfig-002-20250103    gcc-12
x86_64                randconfig-003-20250103    gcc-12
x86_64                randconfig-004-20250103    gcc-12
x86_64                randconfig-005-20250103    gcc-12
x86_64                randconfig-006-20250103    gcc-12
x86_64                randconfig-007-20250103    gcc-12
x86_64                randconfig-008-20250103    gcc-12
x86_64                randconfig-071-20250103    clang-19
x86_64                randconfig-072-20250103    clang-19
x86_64                randconfig-073-20250103    clang-19
x86_64                randconfig-074-20250103    clang-19
x86_64                randconfig-075-20250103    clang-19
x86_64                randconfig-076-20250103    clang-19
x86_64                randconfig-077-20250103    clang-19
x86_64                randconfig-078-20250103    clang-19
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                generic_kc705_defconfig    gcc-13.2.0
xtensa                randconfig-001-20250102    gcc-14.2.0
xtensa                randconfig-002-20250102    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

