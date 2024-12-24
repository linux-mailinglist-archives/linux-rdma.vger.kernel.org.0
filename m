Return-Path: <linux-rdma+bounces-6716-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3ABA9FBA3C
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 08:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B90161067
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 07:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F5F1865E2;
	Tue, 24 Dec 2024 07:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RGYj0YdT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBA3156F54
	for <linux-rdma@vger.kernel.org>; Tue, 24 Dec 2024 07:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735025332; cv=none; b=Xih9vDz2yfbbMhNfTkJPYYqAE2cly4cTjf6zpbNurIKteeid1yv1mmUfwa0/SSA+SJTmyTagDxEZL3S7jPi/pjp1/xJasZ407KrdioB+qR5xHBrenoXjVTlNGyBPOZK+I7xrUiC2PmVIpiDlKN7tcDFVtSjIq/34kSe6LqgxvMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735025332; c=relaxed/simple;
	bh=dw6UnRGG7o/itLYQOleLb7Qlj9/laGXx+JpNutkZHts=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IZWwaLUi0QOkKVuxh0h+WHm9QoFlXVFeInhnyBZ4a/HOfhktAtZfe0mec4kjTNY95+ixNUD/B+iV5vN1+gh12JIfJ1xPNvimwP79oD9bbIKXWhvIRHpnCTGNKI3XGsD9fzPbtG783/klBPhI/o4EElMjSH3t6GR4CvtRHoxo7Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RGYj0YdT; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735025330; x=1766561330;
  h=date:from:to:cc:subject:message-id;
  bh=dw6UnRGG7o/itLYQOleLb7Qlj9/laGXx+JpNutkZHts=;
  b=RGYj0YdTUe93UlVrg+yhgL9Jk7RC8/sogpMieN7guOM+N1jliDV+/pXb
   gbIgm0D2rosCLIHSuKs1eYI1WzKKTbbcqIgSgeBtHsQo/EclYB5UKFOdd
   EOTjsK43gwqcUX6JbUPUxidG/+D0VwLLZPz2C5g2/hJhaz6L1Hv3pVHRd
   oN1rHUVwxQ5PrWaNseYCQTux/c2UJu5ixqh8Sqpp76fi8E0J+1Oa1rFLd
   2PvXFyAsId+RvjqwZ3xurclUhHo+9NRXhveFqcd5kdIXXUxAujzjB9SjI
   71lKAv8dVJmdTQedGvqGUb9WxGtRT6of7BoNVD9Xc+94+imyUQ+okB3Nf
   A==;
X-CSE-ConnectionGUID: M6z54KXjRKaEvYEWseewDg==
X-CSE-MsgGUID: pcX+gIT4QPi0ms7PclaqnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="35398316"
X-IronPort-AV: E=Sophos;i="6.12,259,1728975600"; 
   d="scan'208";a="35398316"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 23:28:49 -0800
X-CSE-ConnectionGUID: 7xDaenQdQUSOlLnQbQR8Ig==
X-CSE-MsgGUID: UXrEYMAYS/aUjZXt/5HmhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="130391624"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 23 Dec 2024 23:28:48 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tPzLS-0000wh-10;
	Tue, 24 Dec 2024 07:28:46 +0000
Date: Tue, 24 Dec 2024 15:28:22 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 e3debdd48423d3d75b9d366399228d7225d902cd
Message-ID: <202412241516.9OXGqD2L-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: e3debdd48423d3d75b9d366399228d7225d902cd  RDMA/hns: Fix missing flush CQE for DWQE

elapsed time: 981m

configs tested: 145
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20241223    gcc-13.2.0
arc                   randconfig-001-20241224    gcc-13.2.0
arc                   randconfig-002-20241223    gcc-13.2.0
arc                   randconfig-002-20241224    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-20
arm                        mvebu_v7_defconfig    clang-15
arm                             pxa_defconfig    gcc-14.2.0
arm                   randconfig-001-20241223    gcc-14.2.0
arm                   randconfig-001-20241224    gcc-14.2.0
arm                   randconfig-002-20241224    gcc-14.2.0
arm                   randconfig-003-20241223    clang-20
arm                   randconfig-003-20241224    clang-19
arm                   randconfig-004-20241223    gcc-14.2.0
arm                   randconfig-004-20241224    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241223    gcc-14.2.0
arm64                 randconfig-001-20241224    gcc-14.2.0
arm64                 randconfig-002-20241223    clang-18
arm64                 randconfig-002-20241224    clang-20
arm64                 randconfig-003-20241223    gcc-14.2.0
arm64                 randconfig-003-20241224    gcc-14.2.0
arm64                 randconfig-004-20241223    gcc-14.2.0
arm64                 randconfig-004-20241224    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241224    gcc-14.2.0
csky                  randconfig-002-20241224    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                             defconfig    clang-20
hexagon               randconfig-001-20241224    clang-20
hexagon               randconfig-002-20241224    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241223    clang-19
i386        buildonly-randconfig-001-20241224    clang-19
i386        buildonly-randconfig-002-20241223    clang-19
i386        buildonly-randconfig-002-20241224    gcc-12
i386        buildonly-randconfig-003-20241223    clang-19
i386        buildonly-randconfig-003-20241224    clang-19
i386        buildonly-randconfig-004-20241223    gcc-12
i386        buildonly-randconfig-004-20241224    clang-19
i386        buildonly-randconfig-005-20241223    clang-19
i386        buildonly-randconfig-005-20241224    clang-19
i386        buildonly-randconfig-006-20241223    gcc-12
i386        buildonly-randconfig-006-20241224    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241224    gcc-14.2.0
loongarch             randconfig-002-20241224    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         apollo_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        mvme147_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm63xx_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241224    gcc-14.2.0
nios2                 randconfig-002-20241224    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241224    gcc-14.2.0
parisc                randconfig-002-20241224    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                     kmeter1_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241224    clang-15
powerpc               randconfig-002-20241224    clang-20
powerpc               randconfig-003-20241224    gcc-14.2.0
powerpc                  storcenter_defconfig    gcc-14.2.0
powerpc                     tqm8540_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20241224    clang-20
powerpc64             randconfig-002-20241224    clang-20
powerpc64             randconfig-003-20241224    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                 randconfig-001-20241224    clang-17
riscv                 randconfig-002-20241224    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20241224    gcc-14.2.0
s390                  randconfig-002-20241224    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                          polaris_defconfig    gcc-14.2.0
sh                          r7780mp_defconfig    gcc-14.2.0
sh                    randconfig-001-20241224    gcc-14.2.0
sh                    randconfig-002-20241224    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241224    gcc-14.2.0
sparc                 randconfig-002-20241224    gcc-14.2.0
sparc64               randconfig-001-20241224    gcc-14.2.0
sparc64               randconfig-002-20241224    gcc-14.2.0
um                               alldefconfig    clang-19
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20241224    gcc-12
um                    randconfig-002-20241224    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241224    clang-19
x86_64      buildonly-randconfig-002-20241224    gcc-12
x86_64      buildonly-randconfig-003-20241224    gcc-12
x86_64      buildonly-randconfig-004-20241224    clang-19
x86_64      buildonly-randconfig-005-20241224    gcc-11
x86_64      buildonly-randconfig-006-20241224    gcc-11
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241224    gcc-14.2.0
xtensa                randconfig-002-20241224    gcc-14.2.0
xtensa                         virt_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

