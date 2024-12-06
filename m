Return-Path: <linux-rdma+bounces-6313-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C9E9E636A
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Dec 2024 02:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4E51884571
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Dec 2024 01:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2BB25760;
	Fri,  6 Dec 2024 01:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mcBbsBLe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C631D1A269
	for <linux-rdma@vger.kernel.org>; Fri,  6 Dec 2024 01:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733448809; cv=none; b=I/o/FVZ2BBl22VABx4/guwXF/qi+hEWtb9YoIzT5dwqWAXShFtyav5bEE1He9e19Row0yuep2JXjzBCvS/PBeKHXA9PvFuQqMtz8HCx/bespm5USxNSCDXajyRWELlCVRaqkbIYa1rPWPgaTrv8EPmHHQm8Zsi6uSc31bz5lUjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733448809; c=relaxed/simple;
	bh=+Om4fKaG1Jq2hEm8PJTdokAB4LOwXjIiEZdvVy0LtEk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BXY5AQjFLWX+gbzhdelQ5mf5An48QcT18GseF3izoa2TFVmsanw1Q1bK2RWLx00+3+UTJQ7B9dXA5bMUpb+QfoM6gPN/1GMDumD7umsfZ0h0xGZiBHbgLlDViyf5jBhdfqZYdbJxs4oeCpTdYPGDc+5kiKvl6l+ewhRaqUWIbsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mcBbsBLe; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733448808; x=1764984808;
  h=date:from:to:cc:subject:message-id;
  bh=+Om4fKaG1Jq2hEm8PJTdokAB4LOwXjIiEZdvVy0LtEk=;
  b=mcBbsBLeTGhv3kpkG+4DN00O7Vpj02xuFo5cF8ScelLh4SCaSn8RMwPq
   yhpcN9hnHFtxtjSH5aZA9yrvsWk1DUdRJgaBfofVLzd6RAL1SSX1Ree/x
   uDQgsLAhMEqSFNinJII0IBGaDaCqZ0E2vi+PesGowF8ehPIAVLkqwXAPl
   BiYJP8l5+KChs2LrSpWAqjHs+36jEQ6Uw/SwGndVSZjxUB+1CyD/W3lr9
   QwYoiXI3Up+wxGJEd9hTAo3kuFVUQBMYHPY0JpyLjcCgWRoCYC6EJp8Y+
   SmuHwm9wAwrsm+kwCdrDMY3lCPT0okfaGHBH403ScrYBLCDFDklWMwpLB
   g==;
X-CSE-ConnectionGUID: sERTvqSqTTOPW7yOcRG7EA==
X-CSE-MsgGUID: NPYxOHEoSoijwtn0gxbOqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="45182986"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="45182986"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 17:33:26 -0800
X-CSE-ConnectionGUID: rtpwXoPjSWeEMu78LHM4yw==
X-CSE-MsgGUID: 6s8ypHQzTzuFLU0WGiqlDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="131680740"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 05 Dec 2024 17:33:24 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJNDe-0000Zo-0E;
	Fri, 06 Dec 2024 01:33:22 +0000
Date: Fri, 06 Dec 2024 09:29:47 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 d507d29bfde3fee6a74d098a9ac640b8fc1a549b
Message-ID: <202412060936.vatDn7dR-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: d507d29bfde3fee6a74d098a9ac640b8fc1a549b  RDMA/bnxt_re: Don't fail destroy QP and cleanup debugfs earlier

elapsed time: 935m

configs tested: 298
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              alldefconfig    clang-20
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                         haps_hs_defconfig    clang-19
arc                         haps_hs_defconfig    gcc-13.2.0
arc                        nsimosci_defconfig    clang-20
arc                            randconfig-001    clang-20
arc                   randconfig-001-20241205    clang-20
arc                   randconfig-001-20241206    gcc-13.2.0
arc                   randconfig-001-20241206    gcc-14.2.0
arc                            randconfig-002    clang-20
arc                   randconfig-002-20241205    clang-20
arc                   randconfig-002-20241206    gcc-13.2.0
arc                   randconfig-002-20241206    gcc-14.2.0
arc                           tb10x_defconfig    clang-20
arc                        vdk_hs38_defconfig    gcc-14.2.0
arc                    vdk_hs38_smp_defconfig    clang-19
arc                    vdk_hs38_smp_defconfig    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                         assabet_defconfig    gcc-14.2.0
arm                         at91_dt_defconfig    clang-20
arm                         at91_dt_defconfig    gcc-14.1.0
arm                          collie_defconfig    gcc-14.2.0
arm                          exynos_defconfig    gcc-14.2.0
arm                            hisi_defconfig    clang-20
arm                           imxrt_defconfig    clang-20
arm                          ixp4xx_defconfig    clang-20
arm                        keystone_defconfig    clang-20
arm                            mps2_defconfig    clang-20
arm                        multi_v5_defconfig    gcc-14.2.0
arm                        multi_v7_defconfig    gcc-14.2.0
arm                         mv78xx0_defconfig    clang-17
arm                        mvebu_v5_defconfig    clang-20
arm                        mvebu_v5_defconfig    gcc-14.1.0
arm                           omap1_defconfig    clang-20
arm                           omap1_defconfig    gcc-14.2.0
arm                         orion5x_defconfig    clang-20
arm                          pxa910_defconfig    clang-20
arm                          pxa910_defconfig    gcc-14.2.0
arm                            randconfig-001    clang-20
arm                   randconfig-001-20241205    clang-20
arm                   randconfig-001-20241206    gcc-14.2.0
arm                            randconfig-002    clang-20
arm                   randconfig-002-20241205    clang-20
arm                   randconfig-002-20241206    gcc-14.2.0
arm                            randconfig-003    clang-20
arm                   randconfig-003-20241205    clang-20
arm                   randconfig-003-20241206    gcc-14.2.0
arm                            randconfig-004    clang-20
arm                   randconfig-004-20241205    clang-20
arm                   randconfig-004-20241206    clang-20
arm                   randconfig-004-20241206    gcc-14.2.0
arm                        realview_defconfig    clang-20
arm                             rpc_defconfig    gcc-14.2.0
arm                        shmobile_defconfig    gcc-14.2.0
arm                          sp7021_defconfig    clang-19
arm                          sp7021_defconfig    clang-20
arm                          sp7021_defconfig    gcc-14.2.0
arm                           spitz_defconfig    gcc-14.2.0
arm                           stm32_defconfig    clang-20
arm                           u8500_defconfig    gcc-13.2.0
arm                       versatile_defconfig    clang-20
arm                    vt8500_v6_v7_defconfig    clang-20
arm                         wpcm450_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    clang-20
arm64                          randconfig-001    clang-20
arm64                 randconfig-001-20241205    clang-20
arm64                 randconfig-001-20241206    clang-14
arm64                 randconfig-001-20241206    gcc-14.2.0
arm64                          randconfig-002    clang-20
arm64                 randconfig-002-20241205    clang-20
arm64                 randconfig-002-20241206    gcc-14.2.0
arm64                          randconfig-003    clang-20
arm64                 randconfig-003-20241205    clang-20
arm64                 randconfig-003-20241206    clang-20
arm64                 randconfig-003-20241206    gcc-14.2.0
arm64                          randconfig-004    clang-20
arm64                 randconfig-004-20241205    clang-20
arm64                 randconfig-004-20241206    clang-20
arm64                 randconfig-004-20241206    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
i386                 buildonly-randconfig-001    gcc-12
i386        buildonly-randconfig-001-20241205    clang-19
i386        buildonly-randconfig-001-20241206    clang-19
i386                 buildonly-randconfig-002    clang-19
i386                 buildonly-randconfig-002    gcc-12
i386        buildonly-randconfig-002-20241205    clang-19
i386        buildonly-randconfig-002-20241206    clang-19
i386        buildonly-randconfig-002-20241206    gcc-12
i386                 buildonly-randconfig-003    clang-19
i386                 buildonly-randconfig-003    gcc-12
i386        buildonly-randconfig-003-20241205    clang-19
i386        buildonly-randconfig-003-20241206    clang-19
i386        buildonly-randconfig-003-20241206    gcc-12
i386                 buildonly-randconfig-004    gcc-12
i386        buildonly-randconfig-004-20241205    clang-19
i386        buildonly-randconfig-004-20241206    clang-19
i386        buildonly-randconfig-004-20241206    gcc-12
i386                 buildonly-randconfig-005    gcc-12
i386        buildonly-randconfig-005-20241205    clang-19
i386        buildonly-randconfig-005-20241206    clang-19
i386                 buildonly-randconfig-006    gcc-12
i386        buildonly-randconfig-006-20241205    clang-19
i386        buildonly-randconfig-006-20241206    clang-19
i386        buildonly-randconfig-006-20241206    gcc-12
loongarch                        alldefconfig    gcc-14.2.0
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
m68k                             alldefconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       m5249evb_defconfig    gcc-14.2.0
m68k                        m5307c3_defconfig    gcc-14.1.0
m68k                       m5475evb_defconfig    clang-20
m68k                            mac_defconfig    gcc-14.2.0
m68k                          multi_defconfig    gcc-14.2.0
m68k                        mvme16x_defconfig    clang-20
m68k                        mvme16x_defconfig    gcc-14.2.0
m68k                           virt_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    clang-20
mips                         bigsur_defconfig    clang-17
mips                      bmips_stb_defconfig    clang-20
mips                          eyeq6_defconfig    clang-20
mips                            gpr_defconfig    clang-20
mips                           ip27_defconfig    gcc-14.2.0
mips                        qi_lb60_defconfig    clang-20
mips                          rb532_defconfig    clang-17
nios2                         3c120_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
openrisc                         alldefconfig    clang-20
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                  or1klitex_defconfig    gcc-14.2.0
openrisc                 simple_smp_defconfig    clang-20
openrisc                       virt_defconfig    clang-19
openrisc                       virt_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                generic-64bit_defconfig    gcc-14.2.0
parisc64                         alldefconfig    clang-20
parisc64                         alldefconfig    gcc-14.1.0
powerpc                     akebono_defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                    amigaone_defconfig    gcc-14.1.0
powerpc                      arches_defconfig    gcc-14.2.0
powerpc                   bluestone_defconfig    clang-20
powerpc                   bluestone_defconfig    gcc-13.2.0
powerpc                 canyonlands_defconfig    clang-19
powerpc                   currituck_defconfig    clang-20
powerpc                       ebony_defconfig    clang-18
powerpc                       eiger_defconfig    gcc-14.2.0
powerpc                     ep8248e_defconfig    clang-20
powerpc                        fsp2_defconfig    clang-19
powerpc                          g5_defconfig    gcc-14.2.0
powerpc                    ge_imp3a_defconfig    clang-20
powerpc                    ge_imp3a_defconfig    gcc-13.2.0
powerpc                       holly_defconfig    clang-20
powerpc                        icon_defconfig    clang-20
powerpc                  iss476-smp_defconfig    gcc-14.2.0
powerpc                   lite5200b_defconfig    clang-20
powerpc                      mgcoge_defconfig    gcc-14.2.0
powerpc                 mpc8313_rdb_defconfig    clang-20
powerpc                 mpc8313_rdb_defconfig    gcc-13.2.0
powerpc                 mpc832x_rdb_defconfig    gcc-14.2.0
powerpc                 mpc834x_itx_defconfig    gcc-14.2.0
powerpc                 mpc837x_rdb_defconfig    clang-20
powerpc                    mvme5100_defconfig    clang-20
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc                     ppa8548_defconfig    clang-20
powerpc                      ppc44x_defconfig    clang-20
powerpc                       ppc64_defconfig    clang-18
powerpc                      ppc6xx_defconfig    gcc-14.2.0
powerpc                         ps3_defconfig    gcc-14.2.0
powerpc                     redwood_defconfig    gcc-14.2.0
powerpc                     skiroot_defconfig    gcc-14.2.0
powerpc                    socrates_defconfig    clang-19
powerpc                     tqm8540_defconfig    clang-20
powerpc                     tqm8540_defconfig    gcc-14.2.0
powerpc                     tqm8541_defconfig    gcc-14.2.0
powerpc                     tqm8548_defconfig    clang-20
powerpc                     tqm8555_defconfig    clang-20
powerpc                     tqm8560_defconfig    clang-20
powerpc                        warp_defconfig    clang-17
powerpc64                        alldefconfig    clang-18
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-13.2.0
riscv                    nommu_virt_defconfig    clang-20
riscv                    nommu_virt_defconfig    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        dreamcast_defconfig    clang-17
sh                        dreamcast_defconfig    clang-18
sh                        dreamcast_defconfig    gcc-14.2.0
sh                ecovec24-romimage_defconfig    gcc-13.2.0
sh                         ecovec24_defconfig    clang-20
sh                        edosk7760_defconfig    gcc-14.2.0
sh                             espt_defconfig    gcc-14.2.0
sh                 kfr2r09-romimage_defconfig    gcc-14.1.0
sh                          kfr2r09_defconfig    clang-20
sh                          landisk_defconfig    gcc-14.2.0
sh                          lboxre2_defconfig    gcc-14.2.0
sh                            migor_defconfig    gcc-14.2.0
sh                          polaris_defconfig    gcc-14.2.0
sh                          r7780mp_defconfig    clang-18
sh                          r7780mp_defconfig    clang-20
sh                          rsk7201_defconfig    clang-20
sh                          rsk7269_defconfig    clang-18
sh                   rts7751r2dplus_defconfig    clang-20
sh                          sdk7780_defconfig    clang-20
sh                          sdk7786_defconfig    gcc-14.2.0
sh                           se7206_defconfig    clang-17
sh                           se7206_defconfig    clang-20
sh                           se7343_defconfig    clang-20
sh                           se7721_defconfig    gcc-14.2.0
sh                           se7722_defconfig    clang-17
sh                           se7722_defconfig    gcc-14.2.0
sh                           se7724_defconfig    gcc-14.2.0
sh                   secureedge5410_defconfig    clang-18
sh                   secureedge5410_defconfig    gcc-14.2.0
sh                           sh2007_defconfig    gcc-14.2.0
sh                   sh7724_generic_defconfig    gcc-14.2.0
sh                        sh7757lcr_defconfig    gcc-14.2.0
sh                        sh7763rdp_defconfig    clang-20
sh                             shx3_defconfig    clang-20
sh                             shx3_defconfig    gcc-14.2.0
sh                            titan_defconfig    gcc-14.2.0
sh                          urquell_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                           x86_64_defconfig    clang-20
um                           x86_64_defconfig    gcc-13.2.0
x86_64               buildonly-randconfig-001    gcc-12
x86_64      buildonly-randconfig-001-20241205    clang-19
x86_64      buildonly-randconfig-001-20241206    clang-19
x86_64      buildonly-randconfig-001-20241206    gcc-12
x86_64               buildonly-randconfig-002    gcc-12
x86_64      buildonly-randconfig-002-20241205    clang-19
x86_64      buildonly-randconfig-002-20241206    clang-19
x86_64      buildonly-randconfig-002-20241206    gcc-12
x86_64               buildonly-randconfig-003    gcc-12
x86_64      buildonly-randconfig-003-20241205    clang-19
x86_64      buildonly-randconfig-003-20241206    clang-19
x86_64      buildonly-randconfig-003-20241206    gcc-12
x86_64               buildonly-randconfig-004    gcc-12
x86_64      buildonly-randconfig-004-20241205    clang-19
x86_64      buildonly-randconfig-004-20241206    clang-19
x86_64               buildonly-randconfig-005    gcc-12
x86_64      buildonly-randconfig-005-20241205    clang-19
x86_64      buildonly-randconfig-005-20241206    clang-19
x86_64      buildonly-randconfig-005-20241206    gcc-11
x86_64               buildonly-randconfig-006    gcc-12
x86_64      buildonly-randconfig-006-20241205    clang-19
x86_64      buildonly-randconfig-006-20241206    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  audio_kc705_defconfig    clang-20
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                generic_kc705_defconfig    clang-20
xtensa                          iss_defconfig    gcc-14.2.0
xtensa                    xip_kc705_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

