Return-Path: <linux-rdma+bounces-4985-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D43C497BAC5
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Sep 2024 12:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052CF1C2146A
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Sep 2024 10:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EB3179654;
	Wed, 18 Sep 2024 10:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zz32IFLb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4326B14F121
	for <linux-rdma@vger.kernel.org>; Wed, 18 Sep 2024 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726654938; cv=none; b=Rx7EyDUBlUOTdJLNB6IVXw5vuUPso5DhdFI1e1QCcF7J9yQuzPMEaoiwR6/pcgjpzFdyw7Rgopj7ANYCcKzlFA9Z77t187Ed3X+OI7kxCnU6xIvNe+bNZhuAqJ+GjKycsnO/4DL512Jd/q92Gi1wj+EUwBsHMsL7OPETNVCB6lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726654938; c=relaxed/simple;
	bh=14zNitBuOOHflNWklyyrmTu/SFMITyM2IOPGcCSzmvQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KPJwfkQcD520TEvf5r13b0rkprLkon8IRr4S+khNu9++gJv06t8cE7PNw0Sgn9ARE0ZXvIdtOgCae1F5MRCj8jT10aXFOPZ3Z77iQNnZZ/C2JH+4PzUym8pae+s+IDrxx+bfSpnSL0NBwb+AmMCszrV3Wn2pkCsGnPLQmaayxuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zz32IFLb; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726654936; x=1758190936;
  h=date:from:to:cc:subject:message-id;
  bh=14zNitBuOOHflNWklyyrmTu/SFMITyM2IOPGcCSzmvQ=;
  b=Zz32IFLbzdq4e/p10zGQf1jOMblb1wAdK5VyMTUlQ+iyzM22xvDwzW32
   wMvTO5tcARwaNRbV/aKwObiEeMMgw0BXGC3BxiUVmYPhskGLFlr6jFKKD
   31NXqqCE4h1giod4e7i2M0pbzlLcu9046Df9DgeEcux30ECeCJ6nkUVDI
   fZl0+JNBQPyBroHzPz0GcVCtu7Ucu2yPIEDpIxgZRJMroEoNm14NbF6ec
   08Wt/9NiWUhRbpLBEMhAaext2c+S0hqrU7U7Iv2lJt1oobKzULBbYWzTu
   JbtwWt9Lo93p11ED+GLmqOqw+TyTB/vHlNCQ0BI1ZWFGxs3/wIyfixYvm
   A==;
X-CSE-ConnectionGUID: MlrQnydiSC2WNsWbRicqsA==
X-CSE-MsgGUID: E1q+m1dlQG2UWIjych5m0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="36224271"
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="36224271"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 03:22:15 -0700
X-CSE-ConnectionGUID: gRRoGK8JR9+KZMsavRVW0A==
X-CSE-MsgGUID: KvMUcwZdRpWrGObJKZqbQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="69826577"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 18 Sep 2024 03:22:14 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sqrp5-000CAY-03;
	Wed, 18 Sep 2024 10:22:11 +0000
Date: Wed, 18 Sep 2024 18:21:18 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 7acad3c442df6d5158c5b732a7a0ccf3a01d9b30
Message-ID: <202409181810.sJIKbmCq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 7acad3c442df6d5158c5b732a7a0ccf3a01d9b30  RDMA/nldev: Add missing break in rdma_nl_notify_err_msg()

elapsed time: 2446m

configs tested: 106
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                            allyesconfig    gcc-13.3.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20240918    gcc-13.2.0
arc                   randconfig-002-20240918    gcc-13.2.0
arm                              allmodconfig    gcc-14.1.0
arm                               allnoconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                   randconfig-001-20240918    clang-14
arm                   randconfig-002-20240918    clang-20
arm                   randconfig-003-20240918    gcc-14.1.0
arm                   randconfig-004-20240918    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                 randconfig-001-20240918    gcc-14.1.0
arm64                 randconfig-002-20240918    gcc-14.1.0
arm64                 randconfig-003-20240918    gcc-14.1.0
arm64                 randconfig-004-20240918    clang-16
csky                              allnoconfig    gcc-14.1.0
csky                  randconfig-001-20240918    gcc-14.1.0
csky                  randconfig-002-20240918    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20240918    clang-20
hexagon               randconfig-002-20240918    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240917    clang-18
i386        buildonly-randconfig-002-20240917    gcc-12
i386        buildonly-randconfig-003-20240917    clang-18
i386        buildonly-randconfig-004-20240917    clang-18
i386        buildonly-randconfig-005-20240917    clang-18
i386        buildonly-randconfig-006-20240917    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20240917    gcc-12
i386                  randconfig-002-20240917    gcc-12
i386                  randconfig-003-20240917    clang-18
i386                  randconfig-004-20240917    gcc-12
i386                  randconfig-005-20240917    gcc-12
i386                  randconfig-006-20240917    clang-18
i386                  randconfig-011-20240917    gcc-12
i386                  randconfig-012-20240917    clang-18
i386                  randconfig-013-20240917    clang-18
i386                  randconfig-014-20240917    clang-18
i386                  randconfig-015-20240917    gcc-12
i386                  randconfig-016-20240917    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch             randconfig-001-20240918    gcc-14.1.0
loongarch             randconfig-002-20240918    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                 randconfig-001-20240918    gcc-14.1.0
nios2                 randconfig-002-20240918    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                randconfig-001-20240918    gcc-14.1.0
parisc                randconfig-002-20240918    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc               randconfig-001-20240918    gcc-14.1.0
powerpc               randconfig-002-20240918    gcc-14.1.0
powerpc               randconfig-003-20240918    gcc-14.1.0
powerpc64             randconfig-001-20240918    clang-20
powerpc64             randconfig-002-20240918    clang-16
powerpc64             randconfig-003-20240918    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
riscv                 randconfig-001-20240918    gcc-14.1.0
riscv                 randconfig-002-20240918    clang-20
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                  randconfig-001-20240918    clang-20
s390                  randconfig-002-20240918    clang-20
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                    randconfig-001-20240918    gcc-14.1.0
sh                    randconfig-002-20240918    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64               randconfig-001-20240918    gcc-14.1.0
sparc64               randconfig-002-20240918    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-12
um                    randconfig-001-20240918    gcc-12
um                    randconfig-002-20240918    gcc-11
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                           rhel-8.3-bpf    gcc-12
x86_64                         rhel-8.3-kunit    gcc-12
x86_64                           rhel-8.3-ltp    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20240918    gcc-14.1.0
xtensa                randconfig-002-20240918    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

