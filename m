Return-Path: <linux-rdma+bounces-275-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFCF806436
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Dec 2023 02:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E802820B0
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Dec 2023 01:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D56B10EC;
	Wed,  6 Dec 2023 01:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YBRPyUTH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815521AA
	for <linux-rdma@vger.kernel.org>; Tue,  5 Dec 2023 17:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701826905; x=1733362905;
  h=date:from:to:cc:subject:message-id;
  bh=uEiirNpGBBTVtDZL6qpvavsHMAQYr+Y5CF9RH7dx29s=;
  b=YBRPyUTHShQ1ROP7/q3gvkALOPboy38qIJxPC/qD67/OczQ7GlEhvINB
   AUur9GlqZXQxLc6U27+HybEKv6P6CbjKgW2ykCbdbgxf2EWQ5WcuYl+vt
   kznA6fcHdPMv+doVZmqcAhQp9lUA+JN14plPS5XufXFgFcEdP+ILkr6F3
   ErGFJR1NgV+JhOOeJKhlR2VAiPKhyobmbbX7Ji8d25HZm4coWc+BY9Uc6
   A9FBlgQHyhhE7jKhmoTNmXsmjKebMhbqOqO221DY7KmoDhgFleK/xyS+g
   PXsgjbGbo7HSDn4cFh/oQ712x9wLXnI90GMAiq/JlBB0lEHWCZpPjxa1/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="374171466"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="374171466"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 17:41:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="841662425"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="841662425"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 05 Dec 2023 17:41:43 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rAguz-000A2a-09;
	Wed, 06 Dec 2023 01:41:41 +0000
Date: Wed, 06 Dec 2023 09:40:48 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 e3e82fcb79eeb3f1a88a89f676831773caff514a
Message-ID: <202312060946.j8zEjnIT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-rc
branch HEAD: e3e82fcb79eeb3f1a88a89f676831773caff514a  RDMA/irdma: Avoid free the non-cqp_request scratch

elapsed time: 1461m

configs tested: 236
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20231205   gcc  
arc                   randconfig-001-20231206   gcc  
arc                   randconfig-002-20231205   gcc  
arc                   randconfig-002-20231206   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   clang
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20231205   gcc  
arm                   randconfig-002-20231205   gcc  
arm                   randconfig-003-20231205   gcc  
arm                   randconfig-004-20231205   gcc  
arm                           sunxi_defconfig   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231205   gcc  
arm64                 randconfig-002-20231205   gcc  
arm64                 randconfig-003-20231205   gcc  
arm64                 randconfig-004-20231205   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231205   gcc  
csky                  randconfig-001-20231206   gcc  
csky                  randconfig-002-20231205   gcc  
csky                  randconfig-002-20231206   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231205   gcc  
i386         buildonly-randconfig-002-20231205   gcc  
i386         buildonly-randconfig-003-20231205   gcc  
i386         buildonly-randconfig-004-20231205   gcc  
i386         buildonly-randconfig-005-20231205   gcc  
i386         buildonly-randconfig-006-20231205   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231205   gcc  
i386                  randconfig-002-20231205   gcc  
i386                  randconfig-003-20231205   gcc  
i386                  randconfig-004-20231205   gcc  
i386                  randconfig-005-20231205   gcc  
i386                  randconfig-006-20231205   gcc  
i386                  randconfig-011-20231205   clang
i386                  randconfig-011-20231206   gcc  
i386                  randconfig-012-20231205   clang
i386                  randconfig-012-20231206   gcc  
i386                  randconfig-013-20231205   clang
i386                  randconfig-013-20231206   gcc  
i386                  randconfig-014-20231205   clang
i386                  randconfig-014-20231206   gcc  
i386                  randconfig-015-20231205   clang
i386                  randconfig-015-20231206   gcc  
i386                  randconfig-016-20231205   clang
i386                  randconfig-016-20231206   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231205   gcc  
loongarch             randconfig-001-20231206   gcc  
loongarch             randconfig-002-20231205   gcc  
loongarch             randconfig-002-20231206   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                          multi_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                           xway_defconfig   gcc  
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231205   gcc  
nios2                 randconfig-001-20231206   gcc  
nios2                 randconfig-002-20231205   gcc  
nios2                 randconfig-002-20231206   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20231205   gcc  
parisc                randconfig-001-20231206   gcc  
parisc                randconfig-002-20231205   gcc  
parisc                randconfig-002-20231206   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                 canyonlands_defconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                       maple_defconfig   gcc  
powerpc               randconfig-001-20231205   gcc  
powerpc               randconfig-002-20231205   gcc  
powerpc               randconfig-003-20231205   gcc  
powerpc                     tqm8548_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20231205   gcc  
powerpc64             randconfig-002-20231205   gcc  
powerpc64             randconfig-003-20231205   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231205   gcc  
riscv                 randconfig-002-20231205   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231206   gcc  
s390                  randconfig-002-20231206   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                    randconfig-001-20231205   gcc  
sh                    randconfig-001-20231206   gcc  
sh                    randconfig-002-20231205   gcc  
sh                    randconfig-002-20231206   gcc  
sh                          rsk7269_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231205   gcc  
sparc64               randconfig-001-20231206   gcc  
sparc64               randconfig-002-20231205   gcc  
sparc64               randconfig-002-20231206   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231205   gcc  
um                    randconfig-002-20231205   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           alldefconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231205   gcc  
x86_64       buildonly-randconfig-001-20231206   clang
x86_64       buildonly-randconfig-002-20231205   gcc  
x86_64       buildonly-randconfig-002-20231206   clang
x86_64       buildonly-randconfig-003-20231205   gcc  
x86_64       buildonly-randconfig-003-20231206   clang
x86_64       buildonly-randconfig-004-20231205   gcc  
x86_64       buildonly-randconfig-004-20231206   clang
x86_64       buildonly-randconfig-005-20231205   gcc  
x86_64       buildonly-randconfig-005-20231206   clang
x86_64       buildonly-randconfig-006-20231205   gcc  
x86_64       buildonly-randconfig-006-20231206   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231205   gcc  
x86_64                randconfig-011-20231206   clang
x86_64                randconfig-012-20231205   gcc  
x86_64                randconfig-012-20231206   clang
x86_64                randconfig-013-20231205   gcc  
x86_64                randconfig-013-20231206   clang
x86_64                randconfig-014-20231205   gcc  
x86_64                randconfig-014-20231206   clang
x86_64                randconfig-015-20231205   gcc  
x86_64                randconfig-015-20231206   clang
x86_64                randconfig-016-20231205   gcc  
x86_64                randconfig-016-20231206   clang
x86_64                randconfig-071-20231205   gcc  
x86_64                randconfig-071-20231206   clang
x86_64                randconfig-072-20231205   gcc  
x86_64                randconfig-072-20231206   clang
x86_64                randconfig-073-20231205   gcc  
x86_64                randconfig-073-20231206   clang
x86_64                randconfig-074-20231205   gcc  
x86_64                randconfig-074-20231206   clang
x86_64                randconfig-075-20231205   gcc  
x86_64                randconfig-075-20231206   clang
x86_64                randconfig-076-20231205   gcc  
x86_64                randconfig-076-20231206   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20231205   gcc  
xtensa                randconfig-001-20231206   gcc  
xtensa                randconfig-002-20231205   gcc  
xtensa                randconfig-002-20231206   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

