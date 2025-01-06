Return-Path: <linux-rdma+bounces-6826-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66043A01DC0
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 03:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AADE11883F38
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 02:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EC83595E;
	Mon,  6 Jan 2025 02:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UaCApN5m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFBB29A5
	for <linux-rdma@vger.kernel.org>; Mon,  6 Jan 2025 02:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736131416; cv=none; b=bXbr/lXowTJwRawProuPjYFSF2uth1WSVbKWpB+BKWdn4pJK8SRy6m0mvV/rPZvMZGbTejtK2682uvFaRtE76zF0ZIDf22jZ18M0umPt7Y8GW37TOg5jvVuRPbzH1t9Cj4fx66yePrSwUW2DyVU/x9b5nt05+QhjdrXJEVaTwW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736131416; c=relaxed/simple;
	bh=ZJ/iznLDNPIwyuhLByb+a3jCRHp8blogO6gwg3pc0Bs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Tiz30CXlN2pPAie6q4jMyJO9yP/4Jwd0teycI1ECh3ZD1mbrbfxnr/24kxOWGhy/mWz8sVHmuH52FDUq0sBSbFAC34UwjseUQmAYdRQrtK0LlVHw6POiqjxxmqGgpdPba09+DqyKAOvSjlGy7kYI1kaYhVzg88rrTo7sbe2BdlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UaCApN5m; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736131415; x=1767667415;
  h=date:from:to:cc:subject:message-id;
  bh=ZJ/iznLDNPIwyuhLByb+a3jCRHp8blogO6gwg3pc0Bs=;
  b=UaCApN5m4RHRuKNj7z9F66eoGPfn/E1cp4EdYCgri+Y+5FOZO1ghLPMB
   +G/cj9vpMS7rem8cmJbc6k2J1FkK5PJRI91vriHCo4mIAUrhGQzwZLP8z
   jk/AZCv5DdskF23c9d32oe8d4k4CkpkDBw50rqfbtjEuMjLvlXvXapXrW
   9ravnEoY2dMGYzzRQluqGwXTt/JgNItGfxKmrnfiPXjTHu2i6uzRAZcdD
   CXRq8Fh5bxRXpVsN+a3jVSjiaIRX/4gNH+cdk1Lfczdf+sQNM1ikUSXyZ
   xBjePOrWF1nszYNhiModj1dJz5LbaiJ6H31YzQgkhbdCPPoeN68/4VGsq
   A==;
X-CSE-ConnectionGUID: FSm1Q72rQ36wRwbJVX9Dgg==
X-CSE-MsgGUID: hB1Gkex5SAW+SqOkQ+vBAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11306"; a="53690168"
X-IronPort-AV: E=Sophos;i="6.12,292,1728975600"; 
   d="scan'208";a="53690168"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2025 18:43:33 -0800
X-CSE-ConnectionGUID: HQ9hxRN4Rz62ol7LIOJsLg==
X-CSE-MsgGUID: 7Bx1fINSQ3uQJKnhopy4JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,292,1728975600"; 
   d="scan'208";a="102114178"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 05 Jan 2025 18:43:32 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tUd5V-000CBb-1e;
	Mon, 06 Jan 2025 02:43:29 +0000
Date: Mon, 06 Jan 2025 10:42:52 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 c84f0f4f49d81645f49c3269fdcc3b84ce61e795
Message-ID: <202501061043.YFAkCAap-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: c84f0f4f49d81645f49c3269fdcc3b84ce61e795  RDMA/bnxt_re: Fix to drop reference to the mmap entry in case of error

elapsed time: 870m

configs tested: 138
configs skipped: 6

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
arc                        nsim_700_defconfig    gcc-13.2.0
arc                   randconfig-001-20250105    gcc-13.2.0
arc                   randconfig-002-20250105    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-20
arm                   randconfig-001-20250105    gcc-14.2.0
arm                   randconfig-002-20250105    clang-20
arm                   randconfig-003-20250105    clang-20
arm                   randconfig-004-20250105    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250105    clang-20
arm64                 randconfig-002-20250105    clang-19
arm64                 randconfig-003-20250105    clang-20
arm64                 randconfig-004-20250105    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250105    gcc-14.2.0
csky                  randconfig-002-20250105    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                             defconfig    clang-20
hexagon               randconfig-001-20250105    clang-20
hexagon               randconfig-002-20250105    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250105    clang-19
i386        buildonly-randconfig-002-20250105    clang-19
i386        buildonly-randconfig-003-20250105    gcc-12
i386        buildonly-randconfig-004-20250105    clang-19
i386        buildonly-randconfig-005-20250105    clang-19
i386        buildonly-randconfig-006-20250105    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250105    gcc-14.2.0
loongarch             randconfig-002-20250105    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                          hp300_defconfig    gcc-14.2.0
microblaze                       alldefconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                         rt305x_defconfig    clang-19
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250105    gcc-14.2.0
nios2                 randconfig-002-20250105    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250105    gcc-14.2.0
parisc                randconfig-002-20250105    gcc-14.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                 canyonlands_defconfig    clang-19
powerpc                 mpc8313_rdb_defconfig    gcc-14.2.0
powerpc                     mpc83xx_defconfig    clang-20
powerpc               randconfig-001-20250105    clang-15
powerpc               randconfig-002-20250105    clang-20
powerpc               randconfig-003-20250105    clang-20
powerpc                    socrates_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250105    clang-20
powerpc64             randconfig-002-20250105    clang-20
powerpc64             randconfig-003-20250105    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv             nommu_k210_sdcard_defconfig    gcc-14.2.0
riscv                 randconfig-001-20250105    gcc-14.2.0
riscv                 randconfig-002-20250105    clang-20
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250105    gcc-14.2.0
s390                  randconfig-002-20250105    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250105    gcc-14.2.0
sh                    randconfig-002-20250105    gcc-14.2.0
sh                   rts7751r2dplus_defconfig    gcc-14.2.0
sh                           se7712_defconfig    gcc-14.2.0
sh                   secureedge5410_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250105    gcc-14.2.0
sparc                 randconfig-002-20250105    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250105    gcc-14.2.0
sparc64               randconfig-002-20250105    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250105    gcc-12
um                    randconfig-002-20250105    clang-19
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250105    gcc-12
x86_64      buildonly-randconfig-002-20250105    clang-19
x86_64      buildonly-randconfig-003-20250105    clang-19
x86_64      buildonly-randconfig-004-20250105    clang-19
x86_64      buildonly-randconfig-005-20250105    clang-19
x86_64      buildonly-randconfig-006-20250105    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250105    gcc-14.2.0
xtensa                randconfig-002-20250105    gcc-14.2.0
xtensa                         virt_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

