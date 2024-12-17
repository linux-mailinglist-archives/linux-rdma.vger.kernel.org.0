Return-Path: <linux-rdma+bounces-6576-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBA29F49BF
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 12:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A04161931
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 11:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411DC1D63F6;
	Tue, 17 Dec 2024 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TeQ9guA6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8C616A959
	for <linux-rdma@vger.kernel.org>; Tue, 17 Dec 2024 11:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734434546; cv=none; b=bsZq4xpQglrSkM96b4OvEGVkfO84M0qOmK53vidqXtVS2H0p8U5edFZVyWh3n7g1VWWJ7gD/RDCdgHxTI7r+q8OD4U4zr1QOl2bZX7drvEky1kqFIFlr9anh+Pp1rCdXJ86hBLca7fg8QD5S4Lo0skfV4tmfXGyM2i8AgGy6vPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734434546; c=relaxed/simple;
	bh=t6RxxZLcPsdvglnS4teJlIkJz9cLGHQ1jwwtzX13Q8A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RQxpen8wJr91xUfTiZcQCQ0RiriWyVuMGzupYYn+3IAhOyQbriJDfxTcXzPX2b/OfkJDKdFsD9huToKShibRb8qhCqvNvu3GldTS6h+zAT7+mj+x1GKzKN6RXQ4uz/XFhF+Qkigyfl8aPsz/aZ2u9AGk0tvj7HhGAaedP883UTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TeQ9guA6; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734434544; x=1765970544;
  h=date:from:to:cc:subject:message-id;
  bh=t6RxxZLcPsdvglnS4teJlIkJz9cLGHQ1jwwtzX13Q8A=;
  b=TeQ9guA6mcebzQcjajh1BpHHYfVr+kCgRcawFnsYYUERYYYi/ycR1YOr
   3obZIeV1lF6j5987gFvhnLompjzS/azrlGfGS6FAVRFfs/IiHFBKDPvYb
   Z6HKLBNINi3F9Gb2hMyzupJOsUqbXlDfeQ/xtkGTuFJXJOt8Ptrtyu+bD
   /+bz9v1yCfAATl4H5mI8xANbphaEtDR9qJdCFRpi37D+7Txsu/skq10l2
   10p87pjluJQJs55RUmthBGLjlPb1Qqzgdng66zA1A1T+HdmHkqH8Mn8pP
   7hxMZBkUMNf4Neo8UyPf0Y8BrZForKr8TsklE+fg9BE4sDPC3cAJI2UK2
   Q==;
X-CSE-ConnectionGUID: aRQsxkNqRm2uvTc691NJoQ==
X-CSE-MsgGUID: 2P+N6jUYTxWdBPr3LWv4Ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34145916"
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; 
   d="scan'208";a="34145916"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 03:22:23 -0800
X-CSE-ConnectionGUID: xQ1t4svmR4GJjwphPCCqbg==
X-CSE-MsgGUID: 1mwCewRsRD67kHtHYc0COw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; 
   d="scan'208";a="128319081"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 17 Dec 2024 03:22:21 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tNVed-000Exk-1v;
	Tue, 17 Dec 2024 11:22:19 +0000
Date: Tue, 17 Dec 2024 19:21:31 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 7179fe0074a3c962e43a9e51169304c4911989ed
Message-ID: <202412171921.3RkYL8WO-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: 7179fe0074a3c962e43a9e51169304c4911989ed  RDMA/bnxt_re: Fix reporting hw_ver in query_device

elapsed time: 1292m

configs tested: 122
configs skipped: 5

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
arc                   randconfig-001-20241216    gcc-13.2.0
arc                   randconfig-001-20241217    gcc-13.2.0
arc                   randconfig-002-20241216    gcc-13.2.0
arc                   randconfig-002-20241217    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20241216    clang-15
arm                   randconfig-001-20241217    clang-16
arm                   randconfig-002-20241216    gcc-14.2.0
arm                   randconfig-002-20241217    gcc-14.2.0
arm                   randconfig-003-20241216    clang-20
arm                   randconfig-003-20241217    gcc-14.2.0
arm                   randconfig-004-20241216    clang-17
arm                   randconfig-004-20241217    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241216    gcc-14.2.0
arm64                 randconfig-001-20241217    clang-20
arm64                 randconfig-002-20241216    clang-20
arm64                 randconfig-002-20241217    clang-16
arm64                 randconfig-003-20241216    gcc-14.2.0
arm64                 randconfig-003-20241217    clang-18
arm64                 randconfig-004-20241216    clang-15
arm64                 randconfig-004-20241217    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241216    gcc-14.2.0
csky                  randconfig-002-20241216    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20241216    clang-20
hexagon               randconfig-002-20241216    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241216    clang-19
i386        buildonly-randconfig-002-20241216    clang-19
i386        buildonly-randconfig-003-20241216    clang-19
i386        buildonly-randconfig-004-20241216    clang-19
i386        buildonly-randconfig-005-20241216    clang-19
i386        buildonly-randconfig-006-20241216    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241216    gcc-14.2.0
loongarch             randconfig-002-20241216    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241216    gcc-14.2.0
nios2                 randconfig-002-20241216    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20241216    gcc-14.2.0
parisc                randconfig-002-20241216    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                          g5_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241216    clang-20
powerpc               randconfig-002-20241216    clang-20
powerpc               randconfig-003-20241216    gcc-14.2.0
powerpc64             randconfig-001-20241216    clang-20
powerpc64             randconfig-002-20241216    clang-15
powerpc64             randconfig-003-20241216    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                 randconfig-001-20241216    clang-20
riscv                 randconfig-002-20241216    clang-15
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20241216    gcc-14.2.0
s390                  randconfig-002-20241216    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         ap325rxa_defconfig    gcc-14.2.0
sh                        edosk7705_defconfig    gcc-14.2.0
sh                    randconfig-001-20241216    gcc-14.2.0
sh                    randconfig-002-20241216    gcc-14.2.0
sh                          urquell_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241216    gcc-14.2.0
sparc                 randconfig-002-20241216    gcc-14.2.0
sparc64               randconfig-001-20241216    gcc-14.2.0
sparc64               randconfig-002-20241216    gcc-14.2.0
um                               alldefconfig    clang-19
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20241216    gcc-12
um                    randconfig-002-20241216    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241216    gcc-12
x86_64      buildonly-randconfig-002-20241216    gcc-12
x86_64      buildonly-randconfig-003-20241216    clang-19
x86_64      buildonly-randconfig-004-20241216    clang-19
x86_64      buildonly-randconfig-005-20241216    clang-19
x86_64      buildonly-randconfig-006-20241216    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241216    gcc-14.2.0
xtensa                randconfig-002-20241216    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

