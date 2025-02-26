Return-Path: <linux-rdma+bounces-8119-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFE6A45B8B
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 11:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1DC17203F
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 10:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7293D1A2C0E;
	Wed, 26 Feb 2025 10:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hMk4kOfd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B48258CDE
	for <linux-rdma@vger.kernel.org>; Wed, 26 Feb 2025 10:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740565123; cv=none; b=lZ7o2Nipn4CgkkzQJoxsEq7uU2Yh1hapsHinXm19xtrxGe6Xl9vAqfRoUkZ7YcIcQZmrasthiIjQ7Sdw3Q3+MBr7+I9mP2kh5SCU9LZyv9YEcLalsfZbzRumuW3ITotyxKNPoWBZwURowmIREh8YnXPKnSpxLpoA0fDx1LVZk1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740565123; c=relaxed/simple;
	bh=EHyhmS7wFa6Z+CGsYQ8a2YyZ6q30+DI+UWL6O9iXZ98=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ftnc1iUP0Kv7dRg627ZIh8g51q4wrlofRi1VVnCPPjVfVwDxccVfNgEmh2HzccTVyu+8mCo/UHmUwOVIRqvcxCJfOCDmyNx1AydpQJqm3xSjiJ3qgWrvY10b5+t8+dyyQGiffj5ylDcQ/Ulco9qDqs6cbHoXMPL6+Yyi/4B1xlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hMk4kOfd; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740565121; x=1772101121;
  h=date:from:to:cc:subject:message-id;
  bh=EHyhmS7wFa6Z+CGsYQ8a2YyZ6q30+DI+UWL6O9iXZ98=;
  b=hMk4kOfdeHd/5V++G9aSNmvNqMyYRvzQXsghmBqztyQ2H8D4bi81b0In
   vW/MKIFJDZMruRaCouZshHut6op9ltR79Sdjdg7wiRIgufM15pN/xZMIm
   FRo5MUU3i2ZEomgYL9eudPsmHmrYHC01aWteY93l/nV8Cxumh9aWeL47z
   S48TuFrOvlg72YHcrJQH6RChUdapm0ni9NKKUrsDabJXVAvz2Tx/VIMEs
   F9iA3fO5y5xpJuga25Qxhxr11vT6LMAE1Fbmd4lQuLgqGZj1+fASAJUsk
   /Mx/CsBl88KxWXLbr2pqosnDzANoiqcyNPDiMojh4j9p2gN1g1QBlPiO5
   A==;
X-CSE-ConnectionGUID: eii0S5GQQ2Wd1ZICAEgsTg==
X-CSE-MsgGUID: QJHtzsDpTJGYVYIYSBMerg==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41655975"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="41655975"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 02:18:40 -0800
X-CSE-ConnectionGUID: KdWJi+NBSGy4GzYA+WZDug==
X-CSE-MsgGUID: 90tsxnK6TIGKYriTYwrDzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="121273814"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 26 Feb 2025 02:18:39 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnEUu-000BX2-2r;
	Wed, 26 Feb 2025 10:18:36 +0000
Date: Wed, 26 Feb 2025 18:17:50 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 ba7fbaa6a83e5c68124cc943ba96a95b528bc253
Message-ID: <202502261844.0fPar9Nt-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: ba7fbaa6a83e5c68124cc943ba96a95b528bc253  RDMA/hfi1: Remove unused one_qsfp_write

elapsed time: 2545m

configs tested: 101
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250225    gcc-13.2.0
arc                   randconfig-002-20250225    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250225    gcc-14.2.0
arm                   randconfig-002-20250225    gcc-14.2.0
arm                   randconfig-003-20250225    gcc-14.2.0
arm                   randconfig-004-20250225    clang-15
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250225    clang-19
arm64                 randconfig-002-20250225    clang-17
arm64                 randconfig-003-20250225    clang-15
arm64                 randconfig-004-20250225    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250225    gcc-14.2.0
csky                  randconfig-002-20250225    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250225    clang-21
hexagon               randconfig-002-20250225    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250225    clang-19
i386        buildonly-randconfig-002-20250225    gcc-11
i386        buildonly-randconfig-003-20250225    clang-19
i386        buildonly-randconfig-004-20250225    clang-19
i386        buildonly-randconfig-005-20250225    gcc-12
i386        buildonly-randconfig-006-20250225    clang-19
i386                                defconfig    clang-19
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250225    gcc-14.2.0
loongarch             randconfig-002-20250225    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250225    gcc-14.2.0
nios2                 randconfig-002-20250225    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250225    gcc-14.2.0
parisc                randconfig-002-20250225    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc               randconfig-001-20250225    gcc-14.2.0
powerpc               randconfig-002-20250225    clang-19
powerpc               randconfig-003-20250225    clang-21
powerpc64             randconfig-001-20250225    gcc-14.2.0
powerpc64             randconfig-002-20250225    gcc-14.2.0
powerpc64             randconfig-003-20250225    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                 randconfig-001-20250225    clang-15
riscv                 randconfig-002-20250225    clang-21
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250225    clang-15
s390                  randconfig-002-20250225    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250225    gcc-14.2.0
sh                    randconfig-002-20250225    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250225    gcc-14.2.0
sparc                 randconfig-002-20250225    gcc-14.2.0
sparc64               randconfig-001-20250225    gcc-14.2.0
sparc64               randconfig-002-20250225    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250225    clang-21
um                    randconfig-002-20250225    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250225    gcc-12
x86_64      buildonly-randconfig-002-20250225    clang-19
x86_64      buildonly-randconfig-003-20250225    clang-19
x86_64      buildonly-randconfig-004-20250225    gcc-11
x86_64      buildonly-randconfig-005-20250225    gcc-12
x86_64      buildonly-randconfig-006-20250225    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250225    gcc-14.2.0
xtensa                randconfig-002-20250225    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

