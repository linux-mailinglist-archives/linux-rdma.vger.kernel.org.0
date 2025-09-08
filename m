Return-Path: <linux-rdma+bounces-13167-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A66FBB49D90
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 01:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FAC7179024
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 23:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354992F9991;
	Mon,  8 Sep 2025 23:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SDvmGypa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186EF125B2
	for <linux-rdma@vger.kernel.org>; Mon,  8 Sep 2025 23:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757374895; cv=none; b=Cg9LDjk/V342gzI9A77lP3enDvT7fI+uRrc2hUNm6hTl2TfeaFVPfw+Px6zxNc4y92DLiYmOR4Kl/EcDJRovad+8ednv4vlxtOxwkBexHVPOkQZ/dsdRLvrXyu4liqiH56PDH1tdZM0DE1+R9yIcurCC2T2n6Mvoj8SLfeVPc70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757374895; c=relaxed/simple;
	bh=GcTp3beoqQKfzFcOGw6bGnnVS14B8/iE9vDcM+jvQ+A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=eCI4O29Fko6O+agr8/TtEegXyTeDq9uBdVsgiYlzJNkIor04XwCvh8+bWndHHj2MHEncOvaNUgeehLpdyJ+5rof45bLRonZkyOAf3bM10pJZMOtyElXe31OVNGZhjaHL/Aw08r6aFO0n9Xi4suzLJRpx9b85GZXFV+ELIFzJElY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SDvmGypa; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757374894; x=1788910894;
  h=date:from:to:cc:subject:message-id;
  bh=GcTp3beoqQKfzFcOGw6bGnnVS14B8/iE9vDcM+jvQ+A=;
  b=SDvmGypaFw1ZzXTBRqHtbW1Am50uip5ZYVaKi/S6O0E42tflXHfhGEc/
   DB8jOfjnttW/a6gQAzQjQvVL3DgoeYZ9FDbSsgXxWr5nJ+Ge+NSGI08Mm
   HnAOm10v31hl9H3e0/VtR75/4zDzUBEiPMGmqooMPbF/PydZ5tsHR4Psl
   iomtMb+HXtsb+ff/F5NV6GIRy0aErTsvvQ8Wsg9o44J6jywbyeDa6RVEP
   DJl2vR1jkvuJRrUTcA9sYTkqZR71Z1iRX7PqyZpGK/JMcz15ke6p0yzP1
   x20ebCjVmzVtKHqtTNYYeojFoj32I5Y14+Ec4YkCX1lLEmqVe8lIcioR5
   Q==;
X-CSE-ConnectionGUID: uFyzJ68TQXSwGSklkvlyzQ==
X-CSE-MsgGUID: XkvRqEvoS5ahf1OLgLd1ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="47221438"
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="47221438"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 16:41:33 -0700
X-CSE-ConnectionGUID: Xo9SmgV7Qg+dME52ogspyA==
X-CSE-MsgGUID: w/AZFl9uTk+jdc+erhFXOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="173729326"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 08 Sep 2025 16:41:32 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uvlUH-0004Fu-2h;
	Mon, 08 Sep 2025 23:41:29 +0000
Date: Tue, 09 Sep 2025 07:41:29 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 c9e60a3162139d3bc8b00bd4a2c387a7a1baada9
Message-ID: <202509090714.kiaU44yR-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: c9e60a3162139d3bc8b00bd4a2c387a7a1baada9  RDMA/bnxt_re: Enhance a log message when bnxt_re_register_netdev fails

elapsed time: 990m

configs tested: 247
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250908    gcc-8.5.0
arc                   randconfig-001-20250909    clang-16
arc                   randconfig-002-20250908    gcc-13.4.0
arc                   randconfig-002-20250909    clang-16
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                            dove_defconfig    gcc-15.1.0
arm                         lpc32xx_defconfig    gcc-15.1.0
arm                        multi_v7_defconfig    gcc-15.1.0
arm                             mxs_defconfig    clang-22
arm                       netwinder_defconfig    gcc-15.1.0
arm                   randconfig-001-20250908    clang-22
arm                   randconfig-001-20250909    clang-16
arm                   randconfig-002-20250908    clang-22
arm                   randconfig-002-20250909    clang-16
arm                   randconfig-003-20250908    gcc-12.5.0
arm                   randconfig-003-20250909    clang-16
arm                   randconfig-004-20250908    gcc-14.3.0
arm                   randconfig-004-20250909    clang-16
arm                       versatile_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250908    clang-20
arm64                 randconfig-001-20250909    clang-16
arm64                 randconfig-002-20250908    clang-16
arm64                 randconfig-002-20250909    clang-16
arm64                 randconfig-003-20250908    gcc-9.5.0
arm64                 randconfig-003-20250909    clang-16
arm64                 randconfig-004-20250908    gcc-8.5.0
arm64                 randconfig-004-20250909    clang-16
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250908    gcc-14.3.0
csky                  randconfig-001-20250909    gcc-8.5.0
csky                  randconfig-002-20250908    gcc-15.1.0
csky                  randconfig-002-20250909    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250908    clang-17
hexagon               randconfig-001-20250909    gcc-8.5.0
hexagon               randconfig-002-20250908    clang-20
hexagon               randconfig-002-20250909    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-13
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-13
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250908    gcc-13
i386        buildonly-randconfig-001-20250909    clang-20
i386        buildonly-randconfig-002-20250908    gcc-13
i386        buildonly-randconfig-002-20250909    clang-20
i386        buildonly-randconfig-003-20250908    gcc-13
i386        buildonly-randconfig-003-20250909    clang-20
i386        buildonly-randconfig-004-20250908    gcc-13
i386        buildonly-randconfig-004-20250909    clang-20
i386        buildonly-randconfig-005-20250908    clang-20
i386        buildonly-randconfig-005-20250909    clang-20
i386        buildonly-randconfig-006-20250908    clang-20
i386        buildonly-randconfig-006-20250909    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250909    clang-20
i386                  randconfig-002-20250909    clang-20
i386                  randconfig-003-20250909    clang-20
i386                  randconfig-004-20250909    clang-20
i386                  randconfig-005-20250909    clang-20
i386                  randconfig-006-20250909    clang-20
i386                  randconfig-007-20250909    clang-20
i386                  randconfig-011-20250909    gcc-14
i386                  randconfig-012-20250909    gcc-14
i386                  randconfig-013-20250909    gcc-14
i386                  randconfig-014-20250909    gcc-14
i386                  randconfig-015-20250909    gcc-14
i386                  randconfig-016-20250909    gcc-14
i386                  randconfig-017-20250909    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250908    gcc-15.1.0
loongarch             randconfig-001-20250909    gcc-8.5.0
loongarch             randconfig-002-20250908    clang-18
loongarch             randconfig-002-20250909    gcc-8.5.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
microblaze                      mmu_defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                     loongson1b_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250908    gcc-8.5.0
nios2                 randconfig-001-20250909    gcc-8.5.0
nios2                 randconfig-002-20250908    gcc-11.5.0
nios2                 randconfig-002-20250909    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250908    gcc-13.4.0
parisc                randconfig-001-20250909    gcc-8.5.0
parisc                randconfig-002-20250908    gcc-8.5.0
parisc                randconfig-002-20250909    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                  mpc885_ads_defconfig    clang-22
powerpc                      pasemi_defconfig    clang-22
powerpc               randconfig-001-20250908    gcc-15.1.0
powerpc               randconfig-001-20250909    gcc-8.5.0
powerpc               randconfig-002-20250908    clang-19
powerpc               randconfig-002-20250909    gcc-8.5.0
powerpc               randconfig-003-20250908    gcc-9.5.0
powerpc               randconfig-003-20250909    gcc-8.5.0
powerpc64             randconfig-001-20250908    gcc-8.5.0
powerpc64             randconfig-001-20250909    gcc-8.5.0
powerpc64             randconfig-002-20250908    gcc-10.5.0
powerpc64             randconfig-002-20250909    gcc-8.5.0
powerpc64             randconfig-003-20250908    clang-22
powerpc64             randconfig-003-20250909    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250908    gcc-11.5.0
riscv                 randconfig-001-20250909    gcc-15.1.0
riscv                 randconfig-002-20250908    gcc-13.4.0
riscv                 randconfig-002-20250909    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250908    clang-22
s390                  randconfig-001-20250909    gcc-15.1.0
s390                  randconfig-002-20250908    gcc-12.5.0
s390                  randconfig-002-20250909    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20250908    gcc-14.3.0
sh                    randconfig-001-20250909    gcc-15.1.0
sh                    randconfig-002-20250908    gcc-14.3.0
sh                    randconfig-002-20250909    gcc-15.1.0
sh                           se7343_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250908    gcc-8.5.0
sparc                 randconfig-001-20250909    gcc-15.1.0
sparc                 randconfig-002-20250908    gcc-12.5.0
sparc                 randconfig-002-20250909    gcc-15.1.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250908    gcc-13.4.0
sparc64               randconfig-001-20250909    gcc-15.1.0
sparc64               randconfig-002-20250908    gcc-8.5.0
sparc64               randconfig-002-20250909    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-13
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250908    gcc-13
um                    randconfig-001-20250909    gcc-15.1.0
um                    randconfig-002-20250908    clang-22
um                    randconfig-002-20250909    gcc-15.1.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250908    clang-20
x86_64      buildonly-randconfig-001-20250909    gcc-14
x86_64      buildonly-randconfig-002-20250908    gcc-13
x86_64      buildonly-randconfig-002-20250909    gcc-14
x86_64      buildonly-randconfig-003-20250908    gcc-13
x86_64      buildonly-randconfig-003-20250909    gcc-14
x86_64      buildonly-randconfig-004-20250908    gcc-11
x86_64      buildonly-randconfig-004-20250909    gcc-14
x86_64      buildonly-randconfig-005-20250908    gcc-13
x86_64      buildonly-randconfig-005-20250909    gcc-14
x86_64      buildonly-randconfig-006-20250908    clang-20
x86_64      buildonly-randconfig-006-20250909    gcc-14
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-071-20250909    gcc-14
x86_64                randconfig-072-20250909    gcc-14
x86_64                randconfig-073-20250909    gcc-14
x86_64                randconfig-074-20250909    gcc-14
x86_64                randconfig-075-20250909    gcc-14
x86_64                randconfig-076-20250909    gcc-14
x86_64                randconfig-077-20250909    gcc-14
x86_64                randconfig-078-20250909    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                           alldefconfig    gcc-15.1.0
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  nommu_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250908    gcc-9.5.0
xtensa                randconfig-001-20250909    gcc-15.1.0
xtensa                randconfig-002-20250908    gcc-11.5.0
xtensa                randconfig-002-20250909    gcc-15.1.0
xtensa                         virt_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

