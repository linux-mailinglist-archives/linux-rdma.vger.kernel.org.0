Return-Path: <linux-rdma+bounces-4922-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF4D9768F1
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2024 14:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D8B1C23742
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2024 12:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B037A19992A;
	Thu, 12 Sep 2024 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YXagqLUW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1131A2638
	for <linux-rdma@vger.kernel.org>; Thu, 12 Sep 2024 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726143489; cv=none; b=ey6pA9iC7pUQPOok1SP8hi6VaqbzU4FJTThj0KEwQWnBIJphN5vwrE8OlWWOGG7N2+ktYf+kWn5hu6eaXDJuxzAFrA+/L97H9//ZMV3gZ4eGufqyDQ6zZGnjFml7qcPlaJr7wvvr0pewXHkSYU7+Hrh2Jq6qKglPy2t1w89eXmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726143489; c=relaxed/simple;
	bh=VYs8TMckoCAdfNEmg5qqbJkcblMqna7ri/uvqYtL9ZU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EL0VE8C5VF42iqhbrL5qXzfdZEVa/oA9pKpYRWqgRo/yPmIuZs0U5cBghKjyhTkRNcGj9TtrCD09H1xlQ17oGXV/si5k1WQ7kqubpEqOTZ57uKOgaDlTbC1ovMx/99tk5FsjvC3j+all4QBtZVrqlOt+SIEr4OfwjDXRpbZbtlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YXagqLUW; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726143487; x=1757679487;
  h=date:from:to:cc:subject:message-id;
  bh=VYs8TMckoCAdfNEmg5qqbJkcblMqna7ri/uvqYtL9ZU=;
  b=YXagqLUWcnkLtQp6gcEuLCKjkMl/hTJX/qdQFbgRj8F9OVbwWCb3ABMz
   bt4PjCwYObRHhYpEa+txGPqvnPOMmx0IZZXLFBY5tVq3wO7C9vmtU2J+x
   HwXsKjSlrrZl2MZs3SCDFTRvDsmW1ac7bJ5bddTxxUxk8/NZ+libniwy0
   4YKXntfHkfu/cY+pdG6k7HeBhoRIx4LQUY4LughkC5vzyNxMZ/QhKJ5Xd
   8nQnY1cp+ngCLnPT5jbK+TlI0Socd1FoFH/MlV1k8FmeHbd8uwB8TJn1a
   Z5m9NTEdlPjYjChNfV/ORF6zLNMfBNYPPhYh+58z1iXVr4cdQIPBTi+to
   g==;
X-CSE-ConnectionGUID: FUCUayqvRziB54ZvjeW9FA==
X-CSE-MsgGUID: uPgX2XyCSL6JakP1JfCBig==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="25093189"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="25093189"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 05:17:57 -0700
X-CSE-ConnectionGUID: A4gRe3PtRcKeDhXEF7vozQ==
X-CSE-MsgGUID: sKh0nccnS9OZNpVz/Zq0gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67927365"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 12 Sep 2024 05:17:55 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soill-000582-0u;
	Thu, 12 Sep 2024 12:17:53 +0000
Date: Thu, 12 Sep 2024 20:17:46 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 f4ccc0a2a0c5977540f519588636b5bc81aae2db
Message-ID: <202409122037.iTrtVnJ2-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: f4ccc0a2a0c5977540f519588636b5bc81aae2db  RDMA/hns: Fix restricted __le16 degrades to integer issue

elapsed time: 2748m

configs tested: 351
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    gcc-14.1.0
arc                              alldefconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                          axs101_defconfig    clang-20
arc                          axs101_defconfig    gcc-14.1.0
arc                                 defconfig    gcc-14.1.0
arc                   randconfig-001-20240911    gcc-13.2.0
arc                   randconfig-001-20240912    gcc-13.2.0
arc                   randconfig-002-20240911    gcc-13.2.0
arc                   randconfig-002-20240912    gcc-13.2.0
arc                           tb10x_defconfig    clang-20
arc                    vdk_hs38_smp_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.1.0
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                         assabet_defconfig    clang-20
arm                         axm55xx_defconfig    gcc-14.1.0
arm                     davinci_all_defconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                          exynos_defconfig    clang-20
arm                      footbridge_defconfig    clang-20
arm                          gemini_defconfig    gcc-14.1.0
arm                            hisi_defconfig    gcc-14.1.0
arm                       imx_v6_v7_defconfig    gcc-14.1.0
arm                      jornada720_defconfig    clang-20
arm                         lpc18xx_defconfig    clang-20
arm                         lpc32xx_defconfig    gcc-14.1.0
arm                          moxart_defconfig    clang-20
arm                            mps2_defconfig    clang-20
arm                        multi_v7_defconfig    clang-20
arm                         mv78xx0_defconfig    clang-20
arm                       netwinder_defconfig    gcc-14.1.0
arm                   randconfig-001-20240911    gcc-13.2.0
arm                   randconfig-001-20240912    gcc-13.2.0
arm                   randconfig-002-20240911    gcc-13.2.0
arm                   randconfig-002-20240912    gcc-13.2.0
arm                   randconfig-003-20240911    gcc-13.2.0
arm                   randconfig-003-20240912    gcc-13.2.0
arm                   randconfig-004-20240911    gcc-13.2.0
arm                   randconfig-004-20240912    gcc-13.2.0
arm                             rpc_defconfig    clang-20
arm                             rpc_defconfig    gcc-14.1.0
arm                         socfpga_defconfig    gcc-14.1.0
arm                           tegra_defconfig    clang-20
arm                        vexpress_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                            allyesconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20240911    gcc-13.2.0
arm64                 randconfig-001-20240912    gcc-13.2.0
arm64                 randconfig-002-20240911    gcc-13.2.0
arm64                 randconfig-002-20240912    gcc-13.2.0
arm64                 randconfig-003-20240911    gcc-13.2.0
arm64                 randconfig-003-20240912    gcc-13.2.0
arm64                 randconfig-004-20240911    gcc-13.2.0
arm64                 randconfig-004-20240912    gcc-13.2.0
csky                             allmodconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                             allyesconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20240911    gcc-13.2.0
csky                  randconfig-001-20240912    gcc-13.2.0
csky                  randconfig-002-20240911    gcc-13.2.0
csky                  randconfig-002-20240912    gcc-13.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20240911    gcc-13.2.0
hexagon               randconfig-001-20240912    gcc-13.2.0
hexagon               randconfig-002-20240911    gcc-13.2.0
hexagon               randconfig-002-20240912    gcc-13.2.0
i386                             allmodconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240911    clang-18
i386        buildonly-randconfig-001-20240911    gcc-12
i386        buildonly-randconfig-001-20240912    gcc-12
i386        buildonly-randconfig-002-20240911    gcc-12
i386        buildonly-randconfig-002-20240912    gcc-11
i386        buildonly-randconfig-002-20240912    gcc-12
i386        buildonly-randconfig-003-20240911    clang-18
i386        buildonly-randconfig-003-20240911    gcc-12
i386        buildonly-randconfig-003-20240912    gcc-12
i386        buildonly-randconfig-004-20240911    gcc-12
i386        buildonly-randconfig-004-20240912    clang-18
i386        buildonly-randconfig-004-20240912    gcc-12
i386        buildonly-randconfig-005-20240911    gcc-12
i386        buildonly-randconfig-005-20240912    gcc-12
i386        buildonly-randconfig-006-20240911    gcc-12
i386        buildonly-randconfig-006-20240912    clang-18
i386        buildonly-randconfig-006-20240912    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20240911    gcc-12
i386                  randconfig-001-20240912    gcc-12
i386                  randconfig-002-20240911    clang-18
i386                  randconfig-002-20240911    gcc-12
i386                  randconfig-002-20240912    gcc-12
i386                  randconfig-003-20240911    clang-18
i386                  randconfig-003-20240911    gcc-12
i386                  randconfig-003-20240912    gcc-11
i386                  randconfig-003-20240912    gcc-12
i386                  randconfig-004-20240911    gcc-12
i386                  randconfig-004-20240912    gcc-12
i386                  randconfig-005-20240911    gcc-12
i386                  randconfig-005-20240912    clang-18
i386                  randconfig-005-20240912    gcc-12
i386                  randconfig-006-20240911    clang-18
i386                  randconfig-006-20240911    gcc-12
i386                  randconfig-006-20240912    clang-18
i386                  randconfig-006-20240912    gcc-12
i386                  randconfig-011-20240911    gcc-12
i386                  randconfig-011-20240912    clang-18
i386                  randconfig-011-20240912    gcc-12
i386                  randconfig-012-20240911    gcc-12
i386                  randconfig-012-20240912    gcc-12
i386                  randconfig-013-20240911    clang-18
i386                  randconfig-013-20240911    gcc-12
i386                  randconfig-013-20240912    gcc-12
i386                  randconfig-014-20240911    clang-18
i386                  randconfig-014-20240911    gcc-12
i386                  randconfig-014-20240912    gcc-12
i386                  randconfig-015-20240911    gcc-12
i386                  randconfig-015-20240912    clang-18
i386                  randconfig-015-20240912    gcc-12
i386                  randconfig-016-20240911    clang-18
i386                  randconfig-016-20240911    gcc-12
i386                  randconfig-016-20240912    clang-18
i386                  randconfig-016-20240912    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                        allyesconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20240911    gcc-13.2.0
loongarch             randconfig-001-20240912    gcc-13.2.0
loongarch             randconfig-002-20240911    gcc-13.2.0
loongarch             randconfig-002-20240912    gcc-13.2.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                         apollo_defconfig    clang-20
m68k                          atari_defconfig    clang-20
m68k                                defconfig    gcc-14.1.0
m68k                       m5249evb_defconfig    gcc-14.1.0
m68k                          sun3x_defconfig    gcc-14.1.0
microblaze                       alldefconfig    clang-20
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                             allmodconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                             allyesconfig    gcc-14.1.0
mips                  cavium_octeon_defconfig    gcc-14.1.0
mips                         db1xxx_defconfig    clang-20
mips                  decstation_64_defconfig    clang-20
mips                 decstation_r4k_defconfig    clang-20
mips                           ip32_defconfig    gcc-14.1.0
mips                     loongson1c_defconfig    clang-20
mips                      loongson3_defconfig    gcc-14.1.0
mips                malta_qemu_32r6_defconfig    gcc-14.1.0
mips                    maltaup_xpa_defconfig    clang-20
mips                           mtx1_defconfig    gcc-14.1.0
mips                        qi_lb60_defconfig    gcc-14.1.0
mips                          rb532_defconfig    clang-20
mips                          rb532_defconfig    gcc-14.1.0
mips                          rm200_defconfig    clang-20
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20240911    gcc-13.2.0
nios2                 randconfig-001-20240912    gcc-13.2.0
nios2                 randconfig-002-20240911    gcc-13.2.0
nios2                 randconfig-002-20240912    gcc-13.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                    or1ksim_defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20240911    gcc-13.2.0
parisc                randconfig-001-20240912    gcc-13.2.0
parisc                randconfig-002-20240911    gcc-13.2.0
parisc                randconfig-002-20240912    gcc-13.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                   bluestone_defconfig    clang-20
powerpc                       ebony_defconfig    clang-20
powerpc                        icon_defconfig    clang-20
powerpc                        icon_defconfig    gcc-14.1.0
powerpc                  iss476-smp_defconfig    clang-20
powerpc                 linkstation_defconfig    clang-20
powerpc                     mpc512x_defconfig    clang-20
powerpc                     mpc512x_defconfig    gcc-14.1.0
powerpc                 mpc8313_rdb_defconfig    clang-20
powerpc                 mpc834x_itx_defconfig    gcc-14.1.0
powerpc                      pcm030_defconfig    clang-20
powerpc                      ppc64e_defconfig    clang-20
powerpc                     rainier_defconfig    gcc-14.1.0
powerpc               randconfig-002-20240912    gcc-13.2.0
powerpc               randconfig-003-20240911    gcc-13.2.0
powerpc                         wii_defconfig    clang-20
powerpc                 xes_mpc85xx_defconfig    clang-20
powerpc64             randconfig-001-20240911    gcc-13.2.0
powerpc64             randconfig-001-20240912    gcc-13.2.0
powerpc64             randconfig-002-20240911    gcc-13.2.0
powerpc64             randconfig-002-20240912    gcc-13.2.0
powerpc64             randconfig-003-20240911    gcc-13.2.0
powerpc64             randconfig-003-20240912    gcc-13.2.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                               defconfig    gcc-14.1.0
riscv             nommu_k210_sdcard_defconfig    clang-20
riscv                 randconfig-001-20240911    gcc-13.2.0
riscv                 randconfig-001-20240912    gcc-13.2.0
riscv                 randconfig-002-20240911    gcc-13.2.0
riscv                 randconfig-002-20240912    gcc-13.2.0
s390                             alldefconfig    clang-20
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                                defconfig    gcc-14.1.0
s390                  randconfig-001-20240911    gcc-13.2.0
s390                  randconfig-001-20240912    gcc-13.2.0
s390                  randconfig-002-20240911    gcc-13.2.0
s390                  randconfig-002-20240912    gcc-13.2.0
s390                       zfcpdump_defconfig    clang-20
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                        edosk7760_defconfig    clang-20
sh                               j2_defconfig    clang-20
sh                     magicpanelr2_defconfig    clang-20
sh                    randconfig-001-20240911    gcc-13.2.0
sh                    randconfig-001-20240912    gcc-13.2.0
sh                    randconfig-002-20240911    gcc-13.2.0
sh                    randconfig-002-20240912    gcc-13.2.0
sh                           se7619_defconfig    gcc-14.1.0
sh                   secureedge5410_defconfig    gcc-14.1.0
sh                   sh7724_generic_defconfig    clang-20
sh                  sh7785lcr_32bit_defconfig    gcc-14.1.0
sh                            titan_defconfig    gcc-14.1.0
sparc                            alldefconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20240911    gcc-13.2.0
sparc64               randconfig-001-20240912    gcc-13.2.0
sparc64               randconfig-002-20240911    gcc-13.2.0
sparc64               randconfig-002-20240912    gcc-13.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20240911    gcc-13.2.0
um                    randconfig-001-20240912    gcc-13.2.0
um                    randconfig-002-20240911    gcc-13.2.0
um                    randconfig-002-20240912    gcc-13.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20240911    clang-18
x86_64      buildonly-randconfig-001-20240912    clang-18
x86_64      buildonly-randconfig-002-20240911    clang-18
x86_64      buildonly-randconfig-002-20240912    clang-18
x86_64      buildonly-randconfig-003-20240911    clang-18
x86_64      buildonly-randconfig-003-20240912    clang-18
x86_64      buildonly-randconfig-004-20240911    clang-18
x86_64      buildonly-randconfig-004-20240912    clang-18
x86_64      buildonly-randconfig-005-20240911    clang-18
x86_64      buildonly-randconfig-005-20240912    clang-18
x86_64      buildonly-randconfig-006-20240911    clang-18
x86_64      buildonly-randconfig-006-20240912    clang-18
x86_64                              defconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20240911    clang-18
x86_64                randconfig-001-20240912    clang-18
x86_64                randconfig-002-20240911    clang-18
x86_64                randconfig-002-20240912    clang-18
x86_64                randconfig-003-20240911    clang-18
x86_64                randconfig-003-20240912    clang-18
x86_64                randconfig-004-20240911    clang-18
x86_64                randconfig-004-20240912    clang-18
x86_64                randconfig-005-20240911    clang-18
x86_64                randconfig-005-20240912    clang-18
x86_64                randconfig-006-20240911    clang-18
x86_64                randconfig-006-20240912    clang-18
x86_64                randconfig-011-20240911    clang-18
x86_64                randconfig-011-20240912    clang-18
x86_64                randconfig-012-20240911    clang-18
x86_64                randconfig-012-20240912    clang-18
x86_64                randconfig-013-20240911    clang-18
x86_64                randconfig-013-20240912    clang-18
x86_64                randconfig-014-20240911    clang-18
x86_64                randconfig-014-20240912    clang-18
x86_64                randconfig-015-20240911    clang-18
x86_64                randconfig-015-20240912    clang-18
x86_64                randconfig-016-20240911    clang-18
x86_64                randconfig-016-20240912    clang-18
x86_64                randconfig-071-20240911    clang-18
x86_64                randconfig-071-20240912    clang-18
x86_64                randconfig-072-20240911    clang-18
x86_64                randconfig-072-20240912    clang-18
x86_64                randconfig-073-20240911    clang-18
x86_64                randconfig-073-20240912    clang-18
x86_64                randconfig-074-20240911    clang-18
x86_64                randconfig-074-20240912    clang-18
x86_64                randconfig-075-20240911    clang-18
x86_64                randconfig-075-20240912    clang-18
x86_64                randconfig-076-20240911    clang-18
x86_64                randconfig-076-20240912    clang-18
x86_64                          rhel-8.3-rust    clang-18
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  cadence_csp_defconfig    clang-20
xtensa                       common_defconfig    gcc-14.1.0
xtensa                randconfig-001-20240911    gcc-13.2.0
xtensa                randconfig-001-20240912    gcc-13.2.0
xtensa                randconfig-002-20240911    gcc-13.2.0
xtensa                randconfig-002-20240912    gcc-13.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

