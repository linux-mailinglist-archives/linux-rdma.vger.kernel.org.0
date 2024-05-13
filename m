Return-Path: <linux-rdma+bounces-2446-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0368C3CD0
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 10:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6679281E91
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 08:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9370C146D56;
	Mon, 13 May 2024 08:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZiI2BsI5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5060A7E777
	for <linux-rdma@vger.kernel.org>; Mon, 13 May 2024 08:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715587277; cv=none; b=MtXsHDMi8lymDYx4rhOIwi2Xwz8OPD3x+4RWqtsmTMTdH1aLNgKFUMqQGrxcXw6cKqDS27pv60gbEN4CH7X/5ewbyF0pd/yZ2UZtzkBLC+HTOg69RHK0Nj5GXXbJ8TO8u64znHO1g4HrUtyW5aiunFmXPK0gZXHy4lS0ob4g1OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715587277; c=relaxed/simple;
	bh=e2oOTjoQiuwLIeHZtE5s9XVUL1uh13aGIZe2lLk0lf4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IBjzCuxs5+BuxHtw3NyL8nwzVzZd7xdfIefC3KEsllhknwuW2dzyvqUVbFiKW1pUvTirVfSS1vgAESZPJ54a2Px6Mg7NsOChJf5ghi+a6vmcwVTssm1df6y9YrSMxdrucdSVCfSvxWzO3Fo7JFivECm+s3MBxmuBuIC1z7NcNlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZiI2BsI5; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715587275; x=1747123275;
  h=date:from:to:cc:subject:message-id;
  bh=e2oOTjoQiuwLIeHZtE5s9XVUL1uh13aGIZe2lLk0lf4=;
  b=ZiI2BsI5IRpTiW8RAntp5FesBIsja6RUOVC6wpWj4MccdWrtpoE1P4b1
   +bYuWg0FEKcahh2lwEs9BSViO9c40cQvq2kUVKTxIc28sIyDMhgP78W9J
   OP73jgi7JA599ngl+s6fsCTonHRbteIfW5omuCiLOupMUDFd01xLF38dV
   3+0rO1POaksE3pXY5XLUSUYtzFEeXrCnpPiMO9+IufUBLg4u8Ha+TeX5x
   tdIz1K8sbcmhWvYZh0APIVNiYrhwTMmXjsQ6FhWGvcspC+zo6B2OanF/6
   WVSgg6nYELBgPyCNExa+sKbnIEdrf4AGteUx6jDVjeqTw+2WDdS6bMhnJ
   A==;
X-CSE-ConnectionGUID: PshiCkYySdCxalsdo0Wqqg==
X-CSE-MsgGUID: JuXp/k4oRpGnZ/4E+KxTog==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="22655301"
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="22655301"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 01:01:14 -0700
X-CSE-ConnectionGUID: kIlExHtRQ0es5CG95w736Q==
X-CSE-MsgGUID: X3WSa005TISNZ2H1p99a8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="30339124"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 13 May 2024 01:01:12 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s6QcQ-0009ln-2S;
	Mon, 13 May 2024 08:01:10 +0000
Date: Mon, 13 May 2024 16:00:13 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 49ca2b2ef3d003402584c68ae7b3055ba72e750a
Message-ID: <202405131611.1S5CJQbt-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 49ca2b2ef3d003402584c68ae7b3055ba72e750a  RDMA/IPoIB: Fix format truncation compilation errors

elapsed time: 1268m

configs tested: 197
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240513   gcc  
arc                   randconfig-002-20240513   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                                 defconfig   clang
arm                      footbridge_defconfig   clang
arm                            hisi_defconfig   gcc  
arm                         lpc18xx_defconfig   clang
arm                   randconfig-001-20240513   clang
arm                   randconfig-002-20240513   gcc  
arm                   randconfig-003-20240513   clang
arm                   randconfig-004-20240513   gcc  
arm                         socfpga_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240513   gcc  
arm64                 randconfig-002-20240513   gcc  
arm64                 randconfig-003-20240513   clang
arm64                 randconfig-004-20240513   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240513   gcc  
csky                  randconfig-002-20240513   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240513   clang
hexagon               randconfig-002-20240513   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240512   gcc  
i386         buildonly-randconfig-001-20240513   clang
i386         buildonly-randconfig-002-20240512   clang
i386         buildonly-randconfig-002-20240513   clang
i386         buildonly-randconfig-003-20240512   gcc  
i386         buildonly-randconfig-003-20240513   gcc  
i386         buildonly-randconfig-004-20240512   gcc  
i386         buildonly-randconfig-004-20240513   clang
i386         buildonly-randconfig-005-20240512   gcc  
i386         buildonly-randconfig-005-20240513   gcc  
i386         buildonly-randconfig-006-20240512   clang
i386         buildonly-randconfig-006-20240513   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240512   clang
i386                  randconfig-001-20240513   gcc  
i386                  randconfig-002-20240512   clang
i386                  randconfig-002-20240513   clang
i386                  randconfig-003-20240512   clang
i386                  randconfig-003-20240513   gcc  
i386                  randconfig-004-20240512   gcc  
i386                  randconfig-004-20240513   clang
i386                  randconfig-005-20240512   clang
i386                  randconfig-005-20240513   gcc  
i386                  randconfig-006-20240512   clang
i386                  randconfig-006-20240513   gcc  
i386                  randconfig-011-20240512   gcc  
i386                  randconfig-011-20240513   gcc  
i386                  randconfig-012-20240512   clang
i386                  randconfig-012-20240513   clang
i386                  randconfig-013-20240512   gcc  
i386                  randconfig-013-20240513   clang
i386                  randconfig-014-20240512   clang
i386                  randconfig-014-20240513   gcc  
i386                  randconfig-015-20240512   gcc  
i386                  randconfig-015-20240513   gcc  
i386                  randconfig-016-20240512   gcc  
i386                  randconfig-016-20240513   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240513   gcc  
loongarch             randconfig-002-20240513   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm63xx_defconfig   clang
mips                     loongson1b_defconfig   clang
mips                    maltaup_xpa_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240513   gcc  
nios2                 randconfig-002-20240513   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           alldefconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240513   gcc  
parisc                randconfig-002-20240513   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     powernv_defconfig   gcc  
powerpc               randconfig-001-20240513   gcc  
powerpc               randconfig-002-20240513   gcc  
powerpc               randconfig-003-20240513   gcc  
powerpc64             randconfig-001-20240513   gcc  
powerpc64             randconfig-002-20240513   clang
powerpc64             randconfig-003-20240513   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240513   gcc  
riscv                 randconfig-002-20240513   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240513   gcc  
s390                  randconfig-002-20240513   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                    randconfig-001-20240513   gcc  
sh                    randconfig-002-20240513   gcc  
sh                           se7206_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240513   gcc  
sparc64               randconfig-002-20240513   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240513   clang
um                    randconfig-002-20240513   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240512   clang
x86_64       buildonly-randconfig-002-20240512   clang
x86_64       buildonly-randconfig-003-20240512   clang
x86_64       buildonly-randconfig-004-20240512   gcc  
x86_64       buildonly-randconfig-005-20240512   clang
x86_64       buildonly-randconfig-006-20240512   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240512   gcc  
x86_64                randconfig-002-20240512   gcc  
x86_64                randconfig-003-20240512   clang
x86_64                randconfig-004-20240512   gcc  
x86_64                randconfig-005-20240512   gcc  
x86_64                randconfig-006-20240512   gcc  
x86_64                randconfig-011-20240512   gcc  
x86_64                randconfig-012-20240512   gcc  
x86_64                randconfig-013-20240512   clang
x86_64                randconfig-014-20240512   gcc  
x86_64                randconfig-015-20240512   clang
x86_64                randconfig-016-20240512   clang
x86_64                randconfig-071-20240512   clang
x86_64                randconfig-072-20240512   gcc  
x86_64                randconfig-073-20240512   gcc  
x86_64                randconfig-074-20240512   clang
x86_64                randconfig-075-20240512   clang
x86_64                randconfig-076-20240512   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240513   gcc  
xtensa                randconfig-002-20240513   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

