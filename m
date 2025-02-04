Return-Path: <linux-rdma+bounces-7396-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B943FA26E98
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 10:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44EED3A482D
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 09:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB91207A37;
	Tue,  4 Feb 2025 09:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d81EMyuU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21973206F18
	for <linux-rdma@vger.kernel.org>; Tue,  4 Feb 2025 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738661805; cv=none; b=VZ34LK8A9FCfTWcqGqdrfRvMb8Yo6LjtS2m5zhkWD2oU1kgMCvYAAdc1G+StRjJixUrT2Su7YnJxGoo6Za6zzQTxRh1VLJjOp+m0KvCer4I0S8xx6QoorP3RQkDJ4Ni4ndMGqXh8LiBGBl/xelerDgYm3wT12WD8brHsWGSX7js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738661805; c=relaxed/simple;
	bh=CiY7ee07rQYZ6mpaiYryj7FYv7XKCFbXTtEpuHPCFu8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mKz9BzgobI5hlBblhVlzajTZipuBc8knrhiPb33TrRwqypHKBDwTEt/G6OowOrkWSnxg845ZD7sGGhyU2iy61G0ztnPPBQaIXlZqoc4Ftx0A/3LJPWY97spMo3+Tu8Ez9LbxoEEC7fJbZPMM54ZuVY21fQcVR36inadS3jC0JI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d81EMyuU; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738661803; x=1770197803;
  h=date:from:to:cc:subject:message-id;
  bh=CiY7ee07rQYZ6mpaiYryj7FYv7XKCFbXTtEpuHPCFu8=;
  b=d81EMyuU0VJnx+oDDLihz02whdD/E50WA9kqf2p1+6l8SuMcTL8Pmyec
   o6k7uM8Ne0W8QiXwXqAb7ISAyhyh0EYHA66wKdz/UTN3Y9xpKU3M/8bt0
   RBIXcx24MGdPTDDUiZngbIiVqo7nhFmqH4Zr+qRl59OTRsh5LP+mQmek5
   9yW+12S0FCUnbmeOnSfEfJwy+ir2LE1O4L9yBbQCAlGg/m47lahS6p5MX
   b9G4H9bXZSkeSoX/9A/faiH95eXe1FuutNuUQDELhZLiy6qyhSB6YQjqQ
   l0+vV3Ugwcu2TsR0oGZ+gNE1HukTQBACmMniqpTogE9vdCPyosms6tm2C
   g==;
X-CSE-ConnectionGUID: JwQOZE3jSzuUX8A8Yj9VUg==
X-CSE-MsgGUID: v+iEFIpPTC21yugGQVupaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="39317673"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="39317673"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 01:36:42 -0800
X-CSE-ConnectionGUID: 29DiutPaR/K3ch2keLrtlA==
X-CSE-MsgGUID: jKZ5TTnSRKC1e2NlMky4nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="115559441"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 04 Feb 2025 01:36:40 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tfFME-000sHL-1c;
	Tue, 04 Feb 2025 09:36:38 +0000
Date: Tue, 04 Feb 2025 17:35:51 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 12d044770e12c4205fa69535b4fa8a9981fea98f
Message-ID: <202502041744.nGGoTEse-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: 12d044770e12c4205fa69535b4fa8a9981fea98f  IB/mlx5: Set and get correct qp_num for a DCT QP

elapsed time: 1302m

configs tested: 243
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250203    gcc-13.2.0
arc                   randconfig-001-20250204    gcc-13.2.0
arc                   randconfig-002-20250203    gcc-13.2.0
arc                   randconfig-002-20250204    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                       aspeed_g5_defconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                   milbeaut_m10v_defconfig    clang-21
arm                       netwinder_defconfig    clang-21
arm                         nhk8815_defconfig    clang-21
arm                   randconfig-001-20250203    clang-18
arm                   randconfig-001-20250204    gcc-13.2.0
arm                   randconfig-002-20250203    gcc-14.2.0
arm                   randconfig-002-20250204    gcc-13.2.0
arm                   randconfig-003-20250203    clang-18
arm                   randconfig-003-20250204    gcc-13.2.0
arm                   randconfig-004-20250203    gcc-14.2.0
arm                   randconfig-004-20250204    gcc-13.2.0
arm                         vf610m4_defconfig    clang-21
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250203    gcc-14.2.0
arm64                 randconfig-001-20250204    gcc-13.2.0
arm64                 randconfig-002-20250203    gcc-14.2.0
arm64                 randconfig-002-20250204    gcc-13.2.0
arm64                 randconfig-003-20250203    gcc-14.2.0
arm64                 randconfig-003-20250204    gcc-13.2.0
arm64                 randconfig-004-20250203    gcc-14.2.0
arm64                 randconfig-004-20250204    gcc-13.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250203    gcc-14.2.0
csky                  randconfig-001-20250204    gcc-14.2.0
csky                  randconfig-002-20250203    gcc-14.2.0
csky                  randconfig-002-20250204    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250203    clang-21
hexagon               randconfig-001-20250204    gcc-14.2.0
hexagon               randconfig-002-20250203    clang-21
hexagon               randconfig-002-20250204    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250203    gcc-12
i386        buildonly-randconfig-001-20250204    gcc-12
i386        buildonly-randconfig-002-20250203    gcc-12
i386        buildonly-randconfig-002-20250204    gcc-12
i386        buildonly-randconfig-003-20250203    clang-19
i386        buildonly-randconfig-003-20250204    gcc-12
i386        buildonly-randconfig-004-20250203    gcc-12
i386        buildonly-randconfig-004-20250204    gcc-12
i386        buildonly-randconfig-005-20250203    clang-19
i386        buildonly-randconfig-005-20250204    gcc-12
i386        buildonly-randconfig-006-20250203    gcc-12
i386        buildonly-randconfig-006-20250204    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250204    clang-19
i386                  randconfig-002-20250204    clang-19
i386                  randconfig-003-20250204    clang-19
i386                  randconfig-004-20250204    clang-19
i386                  randconfig-005-20250204    clang-19
i386                  randconfig-006-20250204    clang-19
i386                  randconfig-007-20250204    clang-19
i386                  randconfig-011-20250204    clang-19
i386                  randconfig-012-20250204    clang-19
i386                  randconfig-013-20250204    clang-19
i386                  randconfig-014-20250204    clang-19
i386                  randconfig-015-20250204    clang-19
i386                  randconfig-016-20250204    clang-19
i386                  randconfig-017-20250204    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250203    gcc-14.2.0
loongarch             randconfig-001-20250204    gcc-14.2.0
loongarch             randconfig-002-20250203    gcc-14.2.0
loongarch             randconfig-002-20250204    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                          multi_defconfig    clang-21
m68k                        mvme16x_defconfig    clang-21
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ip32_defconfig    gcc-14.2.0
mips                        omega2p_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250203    gcc-14.2.0
nios2                 randconfig-001-20250204    gcc-14.2.0
nios2                 randconfig-002-20250203    gcc-14.2.0
nios2                 randconfig-002-20250204    gcc-14.2.0
openrisc                          allnoconfig    clang-21
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250203    gcc-14.2.0
parisc                randconfig-001-20250204    gcc-14.2.0
parisc                randconfig-002-20250203    gcc-14.2.0
parisc                randconfig-002-20250204    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                          allyesconfig    clang-16
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      cm5200_defconfig    clang-21
powerpc                     kmeter1_defconfig    clang-21
powerpc               mpc834x_itxgp_defconfig    clang-21
powerpc                 mpc837x_rdb_defconfig    clang-21
powerpc                      pasemi_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250203    clang-21
powerpc               randconfig-001-20250204    gcc-14.2.0
powerpc               randconfig-002-20250203    clang-16
powerpc               randconfig-002-20250204    gcc-14.2.0
powerpc               randconfig-003-20250203    gcc-14.2.0
powerpc               randconfig-003-20250204    gcc-14.2.0
powerpc64             randconfig-001-20250203    gcc-14.2.0
powerpc64             randconfig-002-20250203    clang-18
powerpc64             randconfig-002-20250204    gcc-14.2.0
powerpc64             randconfig-003-20250203    gcc-14.2.0
powerpc64             randconfig-003-20250204    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                            allyesconfig    clang-21
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    gcc-14.2.0
riscv                 randconfig-001-20250203    clang-16
riscv                 randconfig-001-20250204    gcc-14.2.0
riscv                 randconfig-002-20250203    gcc-14.2.0
riscv                 randconfig-002-20250204    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250203    clang-19
s390                  randconfig-001-20250204    gcc-14.2.0
s390                  randconfig-002-20250203    clang-21
s390                  randconfig-002-20250204    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250203    gcc-14.2.0
sh                    randconfig-001-20250204    gcc-14.2.0
sh                    randconfig-002-20250203    gcc-14.2.0
sh                    randconfig-002-20250204    gcc-14.2.0
sh                           se7750_defconfig    clang-21
sh                        sh7785lcr_defconfig    gcc-14.2.0
sh                          urquell_defconfig    clang-21
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250203    gcc-14.2.0
sparc                 randconfig-001-20250204    gcc-14.2.0
sparc                 randconfig-002-20250203    gcc-14.2.0
sparc                 randconfig-002-20250204    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250203    gcc-14.2.0
sparc64               randconfig-001-20250204    gcc-14.2.0
sparc64               randconfig-002-20250203    gcc-14.2.0
sparc64               randconfig-002-20250204    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250203    gcc-12
um                    randconfig-001-20250204    gcc-14.2.0
um                    randconfig-002-20250203    clang-18
um                    randconfig-002-20250204    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250203    clang-19
x86_64      buildonly-randconfig-001-20250204    clang-19
x86_64      buildonly-randconfig-002-20250203    gcc-12
x86_64      buildonly-randconfig-002-20250204    clang-19
x86_64      buildonly-randconfig-003-20250203    gcc-12
x86_64      buildonly-randconfig-003-20250204    clang-19
x86_64      buildonly-randconfig-004-20250203    clang-19
x86_64      buildonly-randconfig-004-20250204    clang-19
x86_64      buildonly-randconfig-005-20250203    gcc-12
x86_64      buildonly-randconfig-005-20250204    clang-19
x86_64      buildonly-randconfig-006-20250203    gcc-12
x86_64      buildonly-randconfig-006-20250204    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250204    clang-19
x86_64                randconfig-002-20250204    clang-19
x86_64                randconfig-003-20250204    clang-19
x86_64                randconfig-004-20250204    clang-19
x86_64                randconfig-005-20250204    clang-19
x86_64                randconfig-006-20250204    clang-19
x86_64                randconfig-007-20250204    clang-19
x86_64                randconfig-008-20250204    clang-19
x86_64                randconfig-071-20250204    gcc-12
x86_64                randconfig-072-20250204    gcc-12
x86_64                randconfig-073-20250204    gcc-12
x86_64                randconfig-074-20250204    gcc-12
x86_64                randconfig-075-20250204    gcc-12
x86_64                randconfig-076-20250204    gcc-12
x86_64                randconfig-077-20250204    gcc-12
x86_64                randconfig-078-20250204    gcc-12
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                       common_defconfig    clang-21
xtensa                randconfig-001-20250203    gcc-14.2.0
xtensa                randconfig-001-20250204    gcc-14.2.0
xtensa                randconfig-002-20250203    gcc-14.2.0
xtensa                randconfig-002-20250204    gcc-14.2.0
xtensa                    xip_kc705_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

