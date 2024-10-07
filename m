Return-Path: <linux-rdma+bounces-5259-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 382DE9923F7
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 07:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58CAA1C21BE8
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 05:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79D382485;
	Mon,  7 Oct 2024 05:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bmM/iblD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5D6745F2
	for <linux-rdma@vger.kernel.org>; Mon,  7 Oct 2024 05:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728280054; cv=none; b=hVxrvYvunQZTinzUlCQn0lmGeHZRCXqe5q+atPLy/w+ektmEeNl6H9iAJnwCZpXchLx8kZQLs1Gj3WfJFp7wJ+Yzhv42WcaXbhfqhi1uaB//igInPUYa28IN0isYOQSbWDQqG2PlfDGRDF6TAR9+S+dlVyV0D0C2GltEIvAoUq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728280054; c=relaxed/simple;
	bh=edWKupAr3zlBW7tLj6vHGWcc49ZjCRmKciq5BDoNF8E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pIIvuGow5KfzBVZFDBWSxnHjs59POHMKUHmsyMpkBqUNSnIUBPCYVJTbhAK2IaLPlKdmJX70EobawRWE9Ez/jNvZeybyLtOYsR1mATQ+ipWvJjmyOIhvaBf2MjMXPj+IrtVn2cdzlxyuUZM4huA7ryy9HOyHEzKkCR13ay5u+l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bmM/iblD; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728280053; x=1759816053;
  h=date:from:to:cc:subject:message-id;
  bh=edWKupAr3zlBW7tLj6vHGWcc49ZjCRmKciq5BDoNF8E=;
  b=bmM/iblDuQlGX2sFunFvwUFdir7UbSnp+FKfbfBC3ysgPYu7R3Q1rGQM
   b1nfDBT1RFN9INW+GjUdSaEEJNwg4eBj5O19BciCyUq2ch+3UDh+OewVb
   iTHJ9VDkfhRqlXZXBUjjrhI7LMBipBgeAz4/2ttiiW9ux7qWPLROb8ioE
   Gzc+3tTLUR+JyTksxQqs/IPLzJp0zx/Xd/Gw6sXrk4Dlw0hIPhS1fCvAB
   0pFoL/bVdKefvETLz5jvDcKXj+F7NVxAaBW6RpQ/J0O7M1HFwoNkvrFP4
   1ssEbVUVF2A6ky740jtKHJVBHR24u28BzwXvc/HWW6ZnebI9o0mZ1tUGC
   A==;
X-CSE-ConnectionGUID: PfuJCpVfQn+QXUBkmZyjZQ==
X-CSE-MsgGUID: f/ykvDfOQ8a9fkD+YxsHuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="27543433"
X-IronPort-AV: E=Sophos;i="6.11,183,1725346800"; 
   d="scan'208";a="27543433"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2024 22:47:33 -0700
X-CSE-ConnectionGUID: ZszqJviCQvOvmnQtklk6bg==
X-CSE-MsgGUID: 3SmluzQOSlO1ygSrP0ANAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,183,1725346800"; 
   d="scan'208";a="75202717"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 06 Oct 2024 22:47:32 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sxgae-0004dr-2g;
	Mon, 07 Oct 2024 05:47:28 +0000
Date: Mon, 07 Oct 2024 13:46:58 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 23ab1cdca331e10da25a5d1fac0884c9651106a7
Message-ID: <202410071345.zgb7FfrP-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 23ab1cdca331e10da25a5d1fac0884c9651106a7  RDMA/hns: Disassociate mmap pages for all uctx when HW is being reset

elapsed time: 1052m

configs tested: 133
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                          ep93xx_defconfig    gcc-14.1.0
arm                          moxart_defconfig    gcc-14.1.0
arm                         orion5x_defconfig    gcc-14.1.0
arm                          pxa910_defconfig    gcc-14.1.0
arm                        realview_defconfig    gcc-14.1.0
arm                        spear6xx_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
i386                             allmodconfig    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-18
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-18
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241007    clang-18
i386        buildonly-randconfig-002-20241007    clang-18
i386        buildonly-randconfig-003-20241007    clang-18
i386        buildonly-randconfig-004-20241007    clang-18
i386        buildonly-randconfig-005-20241007    clang-18
i386        buildonly-randconfig-006-20241007    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20241007    clang-18
i386                  randconfig-001-20241007    gcc-12
i386                  randconfig-002-20241007    clang-18
i386                  randconfig-002-20241007    gcc-12
i386                  randconfig-003-20241007    clang-18
i386                  randconfig-003-20241007    gcc-12
i386                  randconfig-004-20241007    clang-18
i386                  randconfig-005-20241007    clang-18
i386                  randconfig-006-20241007    clang-18
i386                  randconfig-011-20241007    clang-18
i386                  randconfig-011-20241007    gcc-12
i386                  randconfig-012-20241007    clang-18
i386                  randconfig-013-20241007    clang-18
i386                  randconfig-014-20241007    clang-18
i386                  randconfig-014-20241007    gcc-12
i386                  randconfig-015-20241007    clang-18
i386                  randconfig-016-20241007    clang-18
i386                  randconfig-016-20241007    gcc-11
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                       m5475evb_defconfig    gcc-14.1.0
m68k                            mac_defconfig    gcc-14.1.0
m68k                        stmark2_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                         bigsur_defconfig    gcc-14.1.0
mips                           gcw0_defconfig    gcc-14.1.0
mips                     loongson1c_defconfig    gcc-14.1.0
mips                      loongson3_defconfig    gcc-14.1.0
mips                           mtx1_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           alldefconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
powerpc                 canyonlands_defconfig    gcc-14.1.0
powerpc                        cell_defconfig    gcc-14.1.0
powerpc                     ep8248e_defconfig    gcc-14.1.0
powerpc                     mpc512x_defconfig    gcc-14.1.0
powerpc                 mpc832x_rdb_defconfig    gcc-14.1.0
powerpc                    mvme5100_defconfig    gcc-14.1.0
powerpc                     tqm5200_defconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                             espt_defconfig    gcc-14.1.0
sh                          rsk7269_defconfig    gcc-14.1.0
sh                      rts7751r2d1_defconfig    gcc-14.1.0
sh                          sdk7786_defconfig    gcc-14.1.0
sh                           se7724_defconfig    gcc-14.1.0
sh                              ul2_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                             i386_defconfig    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                generic_kc705_defconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

