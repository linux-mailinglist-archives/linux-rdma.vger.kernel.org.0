Return-Path: <linux-rdma+bounces-15213-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6316CDD7BA
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Dec 2025 09:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B5C63016718
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Dec 2025 08:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9C5307AD5;
	Thu, 25 Dec 2025 08:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VxThtT9R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CCB26F289
	for <linux-rdma@vger.kernel.org>; Thu, 25 Dec 2025 08:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766650452; cv=none; b=qlCks363ejhtuAl3kWKW7N4J7WaUdRcOXxR/mksd/R96sHlkCmq5Y+RLAv5jJ8yNnvMuMoOxJqlTEDxy8ClTPiU/Uckd4ZxH7Q+KoWramQhw0XSA9iuEaO/hdQiH0HI/dywAFAv0xEvabF++epIKbAYyUEJcvKrz4KPEiEuFDoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766650452; c=relaxed/simple;
	bh=gU2p6PqBKBY9imjD5B39YXsVva2DKMOUIS9bFMoKbLA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GkTOs3jiHgBZwDbkpyWcGuTqqj0S3qzYGI7pm5Qc8Kdv27ufLX0vNDWpMot6HgxTTgrxXYtGkgkuzz8bwjvBTxBvDZpIKUx12yEsAxmYX1etJnQCLxPzNvC7qYl+B2nU/Gc1qmkXrandURYFU13rlKQQ6PJmE3s9pA4AIOq3GJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VxThtT9R; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766650450; x=1798186450;
  h=date:from:to:cc:subject:message-id;
  bh=gU2p6PqBKBY9imjD5B39YXsVva2DKMOUIS9bFMoKbLA=;
  b=VxThtT9R/XNerDCDf/leqoK0IOXBAPzxrNcCyQR2qMd1qs7kMc4bvDKV
   tC6nQa8O0RHd/Z+OsRam7bWY/SCTXGwBvTiZiSBUn6zH/K/+yDXHP9DwW
   pok+TM1rSDeznXmwb1yeAtP0VF9byx6Ltlya9bxLFNYqskq98qF6JSXje
   lsVzsyQsRh8+utkklyjs8DFoBxRT0ThB5VVpFa+6/r9RrtqoRqYaVYLr9
   JNUfibYYqeBWncfV8KypqjUYR3cW4j1cqPug1/uOJ7TQe6hZXIkEuVNsR
   6mDIN/WOILCBMtbRERzYVihmAkgge7cV84iIFQCbRZbL5nloLYE8kBAZ5
   w==;
X-CSE-ConnectionGUID: HmLGKJgKS6estpZ/4GZB2Q==
X-CSE-MsgGUID: 0PyE+R6iSg24e0Ydwi8ucg==
X-IronPort-AV: E=McAfee;i="6800,10657,11652"; a="68343608"
X-IronPort-AV: E=Sophos;i="6.21,175,1763452800"; 
   d="scan'208";a="68343608"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2025 00:13:43 -0800
X-CSE-ConnectionGUID: qFUm/cxhQjes4/CYR7OV2w==
X-CSE-MsgGUID: gXeb5FotTnqa010J/JpiZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,175,1763452800"; 
   d="scan'208";a="231239623"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 25 Dec 2025 00:13:40 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vYgTS-000000003tN-3UFD;
	Thu, 25 Dec 2025 08:13:31 +0000
Date: Thu, 25 Dec 2025 16:12:59 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 a3572bdc3a028ca47f77d7166ac95b719cf77d50
Message-ID: <202512251653.WNuWuvEL-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: a3572bdc3a028ca47f77d7166ac95b719cf77d50  RDMA/rtrs: server: remove dead code

elapsed time: 1353m

configs tested: 166
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251225    gcc-11.5.0
arc                   randconfig-002-20251225    gcc-11.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                   randconfig-001-20251225    clang-22
arm                   randconfig-002-20251225    gcc-12.5.0
arm                   randconfig-003-20251225    clang-22
arm                   randconfig-004-20251225    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251224    gcc-8.5.0
arm64                 randconfig-002-20251224    gcc-14.3.0
arm64                 randconfig-003-20251224    clang-17
arm64                 randconfig-004-20251224    gcc-10.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251224    gcc-15.1.0
csky                  randconfig-002-20251224    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251225    clang-22
hexagon               randconfig-002-20251225    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251225    clang-20
i386        buildonly-randconfig-002-20251225    clang-20
i386        buildonly-randconfig-003-20251225    gcc-14
i386        buildonly-randconfig-004-20251225    clang-20
i386        buildonly-randconfig-005-20251225    clang-20
i386        buildonly-randconfig-006-20251225    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251225    gcc-14
i386                  randconfig-002-20251225    clang-20
i386                  randconfig-003-20251225    clang-20
i386                  randconfig-004-20251225    clang-20
i386                  randconfig-005-20251225    clang-20
i386                  randconfig-006-20251225    clang-20
i386                  randconfig-007-20251225    clang-20
i386                  randconfig-011-20251225    clang-20
i386                  randconfig-012-20251225    gcc-14
i386                  randconfig-013-20251225    gcc-14
i386                  randconfig-014-20251225    clang-20
i386                  randconfig-015-20251225    gcc-14
i386                  randconfig-016-20251225    clang-20
i386                  randconfig-017-20251225    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251225    clang-22
loongarch             randconfig-002-20251225    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                          sun3x_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                           ip28_defconfig    gcc-15.1.0
mips                         rt305x_defconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251225    gcc-9.5.0
nios2                 randconfig-002-20251225    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251225    gcc-12.5.0
parisc                randconfig-002-20251225    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      ppc44x_defconfig    clang-22
powerpc               randconfig-001-20251225    clang-22
powerpc               randconfig-002-20251225    clang-22
powerpc                     redwood_defconfig    clang-22
powerpc64             randconfig-001-20251225    gcc-8.5.0
powerpc64             randconfig-002-20251225    gcc-13.4.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251225    clang-22
riscv                 randconfig-002-20251225    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251225    gcc-14.3.0
s390                  randconfig-002-20251225    clang-19
s390                       zfcpdump_defconfig    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                            hp6xx_defconfig    gcc-15.1.0
sh                    randconfig-001-20251225    gcc-15.1.0
sh                    randconfig-002-20251225    gcc-9.5.0
sh                           se7721_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251225    gcc-8.5.0
sparc                 randconfig-002-20251225    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251225    gcc-9.5.0
sparc64               randconfig-002-20251225    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251225    gcc-13
um                    randconfig-002-20251225    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251225    clang-20
x86_64      buildonly-randconfig-002-20251225    clang-20
x86_64      buildonly-randconfig-003-20251225    gcc-14
x86_64      buildonly-randconfig-004-20251225    clang-20
x86_64      buildonly-randconfig-005-20251225    gcc-14
x86_64      buildonly-randconfig-006-20251225    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251225    gcc-12
x86_64                randconfig-002-20251225    clang-20
x86_64                randconfig-003-20251225    gcc-12
x86_64                randconfig-004-20251225    clang-20
x86_64                randconfig-005-20251225    gcc-14
x86_64                randconfig-006-20251225    gcc-14
x86_64                randconfig-011-20251225    gcc-13
x86_64                randconfig-012-20251225    gcc-14
x86_64                randconfig-013-20251225    clang-20
x86_64                randconfig-014-20251225    clang-20
x86_64                randconfig-015-20251225    gcc-14
x86_64                randconfig-016-20251225    clang-20
x86_64                randconfig-071-20251225    clang-20
x86_64                randconfig-072-20251225    clang-20
x86_64                randconfig-073-20251225    gcc-14
x86_64                randconfig-074-20251225    clang-20
x86_64                randconfig-075-20251225    gcc-14
x86_64                randconfig-076-20251225    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251225    gcc-8.5.0
xtensa                randconfig-002-20251225    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

