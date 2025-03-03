Return-Path: <linux-rdma+bounces-8244-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FD0A4B822
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 08:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F483A731C
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 07:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD701E5B72;
	Mon,  3 Mar 2025 07:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MsoOHFec"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C664C85
	for <linux-rdma@vger.kernel.org>; Mon,  3 Mar 2025 07:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740985907; cv=none; b=Mq4MKgy3wXDWbfDhjaCmcTgphQQCpqwfy0wSzDt1Rl50S5u6GOZBM2a5jb3LTy76I0ruCdY8+gXPfBKevX8+ukBjGVVhHW2ESZePhcqAVIQnz3OlXop5+jKxUrAW7JF4/6NNQ4+B55zBOnwIXbEE2R4hzGa9HajbU6Us9+ar1wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740985907; c=relaxed/simple;
	bh=vZN+6gdgVyFJLk5ZtMJpu9CCEzB+fMtXjQiBDCSUdyc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GXp+kBvK9R1WRsFNxZviGezVIC/kVxAvzjYtbEHe6/c6IG7/GQmVCBAHcyikiqglUnUyUMOIGON2S/YZU59W4JFQSQpjZZ2Gi6REFjRXg112d0ZCwleZO109/8P3uIz9LaYry0JJfn+pgiofpwCdm9Hv/n9G5GnLtTZ25Pi6gzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MsoOHFec; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740985905; x=1772521905;
  h=date:from:to:cc:subject:message-id;
  bh=vZN+6gdgVyFJLk5ZtMJpu9CCEzB+fMtXjQiBDCSUdyc=;
  b=MsoOHFecFtWLkfXSXtVnxMnx/MsS2u3aGHCcqH9iFHjL3CFBQMaoxKB0
   FIYHHkthAWb2amSnBFXHbVdTgNQTzWqh/bRZOkX+CARRUq5mpesG0hDCI
   hp8TIFkGhYhEE640gRLhAdei7/KUmwTjI5Qzx49PHzWKz9p5ycKBV8IKD
   C72s280k+GVBLK2VtPvu7uvQ1kMy7/PpuQHqA1ZR6S+dhSsBJvUw5hREJ
   ir0YpAczqQ9/U80KUHv/iAsW0Yg5dASskNo33S5ycMvExvmGYuksYtcHy
   oHnPCRo8XhT5Xc4vBp7sl6gA0F7a1ynH3uq1i0MZtkmH1TMwOjF9pOyxO
   A==;
X-CSE-ConnectionGUID: jbgKZxmuRIq1ydME5OQajA==
X-CSE-MsgGUID: +mF3RCIwT6S9dq1IyI/L/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="41551264"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="41551264"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 23:11:44 -0800
X-CSE-ConnectionGUID: GVSZPb2QQFeLr58heC0Vhw==
X-CSE-MsgGUID: O29Qi+D9TsyZPUOYcNhaHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117773858"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 02 Mar 2025 23:11:42 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tozxk-000I8p-1s;
	Mon, 03 Mar 2025 07:11:40 +0000
Date: Mon, 03 Mar 2025 15:11:09 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 57b9340c0728b060a795180d2dbb823ebd87d787
Message-ID: <202503031559.WSuv8h0a-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 57b9340c0728b060a795180d2dbb823ebd87d787  RDMA/core: Don't expose hw_counters outside of init net namespace

elapsed time: 1131m

configs tested: 126
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250302    gcc-13.2.0
arc                   randconfig-002-20250302    gcc-13.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                            mps2_defconfig    clang-15
arm                        multi_v7_defconfig    gcc-14.2.0
arm                        mvebu_v7_defconfig    clang-15
arm                            qcom_defconfig    clang-17
arm                   randconfig-001-20250302    gcc-14.2.0
arm                   randconfig-002-20250302    clang-21
arm                   randconfig-003-20250302    gcc-14.2.0
arm                   randconfig-004-20250302    clang-21
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250302    clang-18
arm64                 randconfig-002-20250302    gcc-14.2.0
arm64                 randconfig-003-20250302    gcc-14.2.0
arm64                 randconfig-004-20250302    clang-16
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250302    gcc-14.2.0
csky                  randconfig-002-20250302    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250302    clang-21
hexagon               randconfig-002-20250302    clang-21
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250302    gcc-12
i386        buildonly-randconfig-002-20250302    clang-19
i386        buildonly-randconfig-003-20250302    gcc-12
i386        buildonly-randconfig-004-20250302    gcc-12
i386        buildonly-randconfig-005-20250302    gcc-12
i386        buildonly-randconfig-006-20250302    gcc-12
i386                                defconfig    clang-19
loongarch                        alldefconfig    gcc-14.2.0
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250302    gcc-14.2.0
loongarch             randconfig-002-20250302    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          hp300_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          eyeq6_defconfig    clang-21
mips                           ip30_defconfig    gcc-14.2.0
mips                       rbtx49xx_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250302    gcc-14.2.0
nios2                 randconfig-002-20250302    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                generic-32bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20250302    gcc-14.2.0
parisc                randconfig-002-20250302    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                 mpc832x_rdb_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250302    gcc-14.2.0
powerpc               randconfig-002-20250302    gcc-14.2.0
powerpc               randconfig-003-20250302    clang-16
powerpc                     redwood_defconfig    clang-21
powerpc64             randconfig-001-20250302    gcc-14.2.0
powerpc64             randconfig-002-20250302    gcc-14.2.0
powerpc64             randconfig-003-20250302    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250302    clang-21
riscv                 randconfig-002-20250302    clang-16
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250302    clang-17
s390                  randconfig-002-20250302    clang-19
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250302    gcc-14.2.0
sh                    randconfig-002-20250302    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250302    gcc-14.2.0
sparc                 randconfig-002-20250302    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250302    gcc-14.2.0
sparc64               randconfig-002-20250302    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250302    gcc-12
um                    randconfig-002-20250302    clang-16
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250302    clang-19
x86_64      buildonly-randconfig-002-20250302    clang-19
x86_64      buildonly-randconfig-003-20250302    gcc-12
x86_64      buildonly-randconfig-004-20250302    gcc-12
x86_64      buildonly-randconfig-005-20250302    gcc-12
x86_64      buildonly-randconfig-006-20250302    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                          iss_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250302    gcc-14.2.0
xtensa                randconfig-002-20250302    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

