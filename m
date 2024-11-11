Return-Path: <linux-rdma+bounces-5911-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016919C36D1
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Nov 2024 04:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D33DB20A8A
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Nov 2024 03:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222AF4A3E;
	Mon, 11 Nov 2024 03:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fyy41v3g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED9813BAF1
	for <linux-rdma@vger.kernel.org>; Mon, 11 Nov 2024 03:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731294147; cv=none; b=EihEgrNUNG8Qfnngl/ajKnRFmGqQYKmVNXVUuN6RQRvIdyrL4BsuiSbrxz9mOHk7goQY7kkbegbT9+C3ZAzMLcW33aAeHHaLLmWs169wn4QpTGSN+KiWxkS8tscq5ih5bg/yOKB1jnAsg3bxLpNzUIcaIi8XUvRGiI1ID1mLvMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731294147; c=relaxed/simple;
	bh=a4MP395fiGRv7aiUub0kmwB6PhYsPU7lpljY35o8Da0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QCdOtgfhn39bE7qGjwcjXflTnjNMfJhymk2Am7wZyglAO2jurje2SICFpgjXyAQlB1aRfGu/QP4evvMNJXuKedPuSzvK4raffGdf2aNaugUF7xJkW24u+9q0vc0GMq0k0O4PUtjTVErAiVWyIW/ITAtcnODJIv5LvijyS88r1ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fyy41v3g; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731294146; x=1762830146;
  h=date:from:to:cc:subject:message-id;
  bh=a4MP395fiGRv7aiUub0kmwB6PhYsPU7lpljY35o8Da0=;
  b=fyy41v3gLDJPTY7rtFdu3UAmlnmlia0JjeHwFJCKFKqWm8PesUoQoRZQ
   RBUQ65FBBtbU75pyV+VXnrvAtOb7AYlLrkUTn9pq3PIQbLP/rYRYvgQ0c
   /UNpHpWj7UvT1k1SSM+y0TLkeEIuCRsrS7MkEI7qzo2lg6Bgdvq9Yug4q
   ozET6240BIt/BUDPCjb2yrzn8MJ7uqi2Y7c8nzje+ycMzZueNzryv1ZCL
   TwLV8PkvzrBx04LUnfwCF9L3Vijjn5C+duTOLG7Jd/jZbyBw/utLCV4Im
   C8m4vFOOn+EalWZCPDkS+NQgzYiSMpSoyumR4VJc1REh56rwxzCEy7BIe
   g==;
X-CSE-ConnectionGUID: xa+nsRfhRcSCzgYS+jSURQ==
X-CSE-MsgGUID: seoohE7lRpWuMLrDOQt+LQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="41718748"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="41718748"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 19:02:26 -0800
X-CSE-ConnectionGUID: oJ7V8aCEQuSVZFWv9oMyuA==
X-CSE-MsgGUID: fhZrgq2EQiWKXExKN769Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="91591814"
Received: from lkp-server01.sh.intel.com (HELO 7b17a4138caf) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 10 Nov 2024 19:02:24 -0800
Received: from kbuild by 7b17a4138caf with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tAKh3-0000bX-0u;
	Mon, 11 Nov 2024 03:02:21 +0000
Date: Mon, 11 Nov 2024 11:01:41 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 6b526d17eed850352d880b93b9bf20b93006bd92
Message-ID: <202411111136.QZVMNV44-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 6b526d17eed850352d880b93b9bf20b93006bd92  RDMA/hns: Fix NULL pointer derefernce in hns_roce_map_mr_sg()

elapsed time: 724m

configs tested: 252
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                          axs101_defconfig    gcc-13.2.0
arc                          axs103_defconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                         haps_hs_defconfig    gcc-14.2.0
arc                   randconfig-001-20241111    gcc-14.2.0
arc                   randconfig-002-20241111    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                          ep93xx_defconfig    gcc-14.2.0
arm                      integrator_defconfig    clang-20
arm                        keystone_defconfig    clang-20
arm                         lpc18xx_defconfig    gcc-14.2.0
arm                         lpc32xx_defconfig    clang-20
arm                        multi_v5_defconfig    gcc-14.2.0
arm                        neponset_defconfig    gcc-14.2.0
arm                   randconfig-001-20241111    gcc-14.2.0
arm                   randconfig-002-20241111    gcc-14.2.0
arm                   randconfig-003-20241111    gcc-14.2.0
arm                   randconfig-004-20241111    gcc-14.2.0
arm                         socfpga_defconfig    clang-20
arm                          sp7021_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241111    gcc-14.2.0
arm64                 randconfig-002-20241111    gcc-14.2.0
arm64                 randconfig-003-20241111    gcc-14.2.0
arm64                 randconfig-004-20241111    gcc-14.2.0
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241111    gcc-14.2.0
csky                  randconfig-002-20241111    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241111    gcc-14.2.0
hexagon               randconfig-002-20241111    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241111    gcc-11
i386        buildonly-randconfig-002-20241111    gcc-11
i386        buildonly-randconfig-003-20241111    gcc-11
i386        buildonly-randconfig-004-20241111    gcc-11
i386        buildonly-randconfig-005-20241111    gcc-11
i386        buildonly-randconfig-006-20241111    gcc-11
i386                                defconfig    clang-19
i386                  randconfig-001-20241111    gcc-11
i386                  randconfig-002-20241111    gcc-11
i386                  randconfig-003-20241111    gcc-11
i386                  randconfig-004-20241111    gcc-11
i386                  randconfig-005-20241111    gcc-11
i386                  randconfig-006-20241111    gcc-11
i386                  randconfig-011-20241111    gcc-11
i386                  randconfig-012-20241111    gcc-11
i386                  randconfig-013-20241111    gcc-11
i386                  randconfig-014-20241111    gcc-11
i386                  randconfig-015-20241111    gcc-11
i386                  randconfig-016-20241111    gcc-11
loongarch                        alldefconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241111    gcc-14.2.0
loongarch             randconfig-002-20241111    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         amcore_defconfig    clang-20
m68k                                defconfig    gcc-14.2.0
m68k                       m5208evb_defconfig    clang-20
m68k                          sun3x_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    clang-15
mips                        bcm63xx_defconfig    gcc-14.2.0
mips                       bmips_be_defconfig    gcc-14.2.0
mips                      bmips_stb_defconfig    gcc-14.2.0
mips                         db1xxx_defconfig    clang-20
mips                      maltaaprp_defconfig    clang-14
mips                      maltaaprp_defconfig    gcc-14.2.0
mips                       rbtx49xx_defconfig    clang-20
mips                        vocore2_defconfig    clang-15
mips                           xway_defconfig    clang-20
nios2                         3c120_defconfig    gcc-14.2.0
nios2                            alldefconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241111    gcc-14.2.0
nios2                 randconfig-002-20241111    gcc-14.2.0
openrisc                         alldefconfig    gcc-14.2.0
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
parisc                randconfig-001-20241111    gcc-14.2.0
parisc                randconfig-002-20241111    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    gcc-14.2.0
powerpc                    amigaone_defconfig    clang-20
powerpc                     asp8347_defconfig    gcc-14.2.0
powerpc                   bluestone_defconfig    clang-20
powerpc                       ebony_defconfig    clang-20
powerpc                     ksi8560_defconfig    gcc-14.2.0
powerpc                 mpc834x_itx_defconfig    gcc-14.2.0
powerpc                 mpc837x_rdb_defconfig    clang-20
powerpc                      pcm030_defconfig    clang-20
powerpc                      ppc6xx_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241111    gcc-14.2.0
powerpc               randconfig-002-20241111    gcc-14.2.0
powerpc               randconfig-003-20241111    gcc-14.2.0
powerpc                     sequoia_defconfig    gcc-14.2.0
powerpc                     tqm5200_defconfig    gcc-14.2.0
powerpc                     tqm8540_defconfig    gcc-14.2.0
powerpc                 xes_mpc85xx_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20241111    gcc-14.2.0
powerpc64             randconfig-002-20241111    gcc-14.2.0
powerpc64             randconfig-003-20241111    gcc-14.2.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-20
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    clang-20
riscv                 randconfig-001-20241111    gcc-14.2.0
riscv                 randconfig-002-20241111    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-20
s390                                defconfig    gcc-12
s390                  randconfig-001-20241111    gcc-14.2.0
s390                  randconfig-002-20241111    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         ap325rxa_defconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                ecovec24-romimage_defconfig    gcc-14.2.0
sh                          lboxre2_defconfig    gcc-14.2.0
sh                    randconfig-001-20241111    gcc-14.2.0
sh                    randconfig-002-20241111    gcc-14.2.0
sh                          sdk7780_defconfig    gcc-14.2.0
sh                           se7705_defconfig    clang-20
sh                  sh7785lcr_32bit_defconfig    clang-20
sh                            shmin_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241111    gcc-14.2.0
sparc64               randconfig-002-20241111    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241111    gcc-14.2.0
um                    randconfig-002-20241111    gcc-14.2.0
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241111    gcc-12
x86_64      buildonly-randconfig-002-20241111    gcc-12
x86_64      buildonly-randconfig-003-20241111    gcc-12
x86_64      buildonly-randconfig-004-20241111    gcc-12
x86_64      buildonly-randconfig-005-20241111    gcc-12
x86_64      buildonly-randconfig-006-20241111    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241111    clang-19
x86_64                randconfig-001-20241111    gcc-12
x86_64                randconfig-002-20241111    clang-19
x86_64                randconfig-002-20241111    gcc-12
x86_64                randconfig-003-20241111    clang-19
x86_64                randconfig-003-20241111    gcc-12
x86_64                randconfig-004-20241111    gcc-12
x86_64                randconfig-005-20241111    gcc-12
x86_64                randconfig-006-20241111    clang-19
x86_64                randconfig-006-20241111    gcc-12
x86_64                randconfig-011-20241111    clang-19
x86_64                randconfig-011-20241111    gcc-12
x86_64                randconfig-012-20241111    gcc-12
x86_64                randconfig-013-20241111    clang-19
x86_64                randconfig-013-20241111    gcc-12
x86_64                randconfig-014-20241111    clang-19
x86_64                randconfig-014-20241111    gcc-12
x86_64                randconfig-015-20241111    clang-19
x86_64                randconfig-015-20241111    gcc-12
x86_64                randconfig-016-20241111    gcc-12
x86_64                randconfig-071-20241111    gcc-12
x86_64                randconfig-072-20241111    gcc-12
x86_64                randconfig-073-20241111    clang-19
x86_64                randconfig-073-20241111    gcc-12
x86_64                randconfig-074-20241111    clang-19
x86_64                randconfig-074-20241111    gcc-12
x86_64                randconfig-075-20241111    clang-19
x86_64                randconfig-075-20241111    gcc-12
x86_64                randconfig-076-20241111    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  audio_kc705_defconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                randconfig-001-20241111    gcc-14.2.0
xtensa                randconfig-002-20241111    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

