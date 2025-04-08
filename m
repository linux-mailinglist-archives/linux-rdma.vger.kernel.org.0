Return-Path: <linux-rdma+bounces-9275-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B5DA81605
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 21:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B90FD882DA9
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 19:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28F422171B;
	Tue,  8 Apr 2025 19:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eLRblEpz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942FE2C9A
	for <linux-rdma@vger.kernel.org>; Tue,  8 Apr 2025 19:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744141792; cv=none; b=KI/mbaD9SrqvJUUlkQOnypDpcJDkVtilP6G1ZPi2EJ0gqMCiMnUw4VVbvj7fpcm+oGYE66MfkDi+3tDNK7F3cFEyw2a6abyNjTWCYVn90Fm7bQtK+UvzNaWaxIfLCu1+Bik2wFvmqxk+QhOJl2+8oPgR7JcI3vst7jNjZ3RgeXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744141792; c=relaxed/simple;
	bh=496m1c4XXP2s9z1rrdHu6kGYIFyGiw3mOcvPTv7DJMA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SePReMMB5x2YOXxa5QaPP64xHfFQjrya7S2tggTkhE7tooi8TnFOB64CPc0T0pUOuVZQhdY6w2ahloB8dU4Q4PeG4PslEZiHN/k2aww30DyhKZyOeUTLOMe/VVjWtTEcV65lR64otvtq3bGVtwxTZE8WJkoSoO+i7dA6PLa2698=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eLRblEpz; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744141791; x=1775677791;
  h=date:from:to:cc:subject:message-id;
  bh=496m1c4XXP2s9z1rrdHu6kGYIFyGiw3mOcvPTv7DJMA=;
  b=eLRblEpzdF2mxVM5m+Kf+bWhHYSV7+TKq3qwZ2QyBe2wgK9J5zrJSxeB
   OgdMATelkF8HFJRwOxhr/4dzRjZq/xXRiQTfksOCUq7BG9ppwB+yLDnPV
   HLTwpLRoICkp3ykAXfmQfLLSaAb7nqG6b9S80xq202xr+bQZ1n8+gV/0p
   KlfeaJ3QMXAqpJGcPbLbJO+D4PNZ8jyfaWVuTmDHHqE3WXA6FLDg3fPhD
   CPCstezBUKJ2IqjFwuTzRN0A0AojIuixYyo7fETIgebdcmd8hZtxqyV4i
   2j7BUgoVnw9pl/n2tbru4y/KXErgwXZSCNWwr+58GX2WnM6ZYEPMNL7g/
   Q==;
X-CSE-ConnectionGUID: imQl5F+kRSKCIxg7RyrYWg==
X-CSE-MsgGUID: WDn4sebFQxmi9OGmUmh6PA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56575230"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="56575230"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 12:49:50 -0700
X-CSE-ConnectionGUID: rfHsgK/GS6uX4YNLzDXheg==
X-CSE-MsgGUID: H26PByQkSTmyYs3gjas+YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="128903200"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 08 Apr 2025 12:49:49 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u2Ex8-0007vf-0u;
	Tue, 08 Apr 2025 19:49:46 +0000
Date: Wed, 09 Apr 2025 03:48:57 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 9beb2c91fb86e0be70a5833c6730441fa3c9efa8
Message-ID: <202504090341.c5ZysSYb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-rc
branch HEAD: 9beb2c91fb86e0be70a5833c6730441fa3c9efa8  RDMA/hns: Fix wrong maximum DMA segment size

elapsed time: 1456m

configs tested: 105
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250408    gcc-14.2.0
arc                   randconfig-001-20250409    gcc-12.4.0
arc                   randconfig-002-20250408    gcc-14.2.0
arc                   randconfig-002-20250409    gcc-10.5.0
arm                              allmodconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250408    clang-21
arm                   randconfig-001-20250409    gcc-7.5.0
arm                   randconfig-002-20250408    gcc-10.5.0
arm                   randconfig-002-20250409    gcc-7.5.0
arm                   randconfig-003-20250408    clang-17
arm                   randconfig-003-20250409    gcc-7.5.0
arm                   randconfig-004-20250408    gcc-6.5.0
arm                   randconfig-004-20250409    clang-14
arm64                            allmodconfig    clang-19
arm64                 randconfig-001-20250408    clang-21
arm64                 randconfig-001-20250409    clang-21
arm64                 randconfig-002-20250408    gcc-9.5.0
arm64                 randconfig-003-20250408    gcc-9.5.0
arm64                 randconfig-004-20250408    clang-20
arm64                 randconfig-004-20250409    gcc-6.5.0
csky                  randconfig-001-20250408    gcc-14.2.0
csky                  randconfig-001-20250409    gcc-14.2.0
csky                  randconfig-002-20250408    gcc-9.3.0
csky                  randconfig-002-20250409    gcc-14.2.0
hexagon               randconfig-001-20250408    clang-21
hexagon               randconfig-001-20250409    clang-21
hexagon               randconfig-002-20250408    clang-21
hexagon               randconfig-002-20250409    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250408    clang-20
i386        buildonly-randconfig-002-20250408    clang-20
i386        buildonly-randconfig-003-20250408    gcc-12
i386        buildonly-randconfig-004-20250408    gcc-12
i386        buildonly-randconfig-005-20250408    gcc-12
i386        buildonly-randconfig-006-20250408    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch             randconfig-001-20250408    gcc-14.2.0
loongarch             randconfig-001-20250409    gcc-14.2.0
loongarch             randconfig-002-20250408    gcc-13.3.0
loongarch             randconfig-002-20250409    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
nios2                 randconfig-001-20250408    gcc-13.3.0
nios2                 randconfig-001-20250409    gcc-10.5.0
nios2                 randconfig-002-20250408    gcc-7.5.0
nios2                 randconfig-002-20250409    gcc-8.5.0
openrisc                          allnoconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250408    gcc-6.5.0
parisc                randconfig-002-20250408    gcc-8.5.0
parisc                randconfig-002-20250409    gcc-13.3.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250408    gcc-5.5.0
powerpc               randconfig-001-20250409    gcc-6.5.0
powerpc               randconfig-002-20250408    gcc-9.3.0
powerpc               randconfig-003-20250408    gcc-5.5.0
powerpc64             randconfig-001-20250408    clang-21
powerpc64             randconfig-002-20250408    gcc-5.5.0
powerpc64             randconfig-003-20250408    gcc-7.5.0
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250408    gcc-9.3.0
riscv                 randconfig-001-20250409    clang-21
riscv                 randconfig-002-20250408    clang-21
riscv                 randconfig-002-20250409    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250408    gcc-8.5.0
s390                  randconfig-001-20250409    gcc-9.3.0
s390                  randconfig-002-20250408    clang-15
s390                  randconfig-002-20250409    gcc-9.3.0
sh                               allmodconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250408    gcc-13.3.0
sh                    randconfig-001-20250409    gcc-12.4.0
sh                    randconfig-002-20250408    gcc-13.3.0
sh                    randconfig-002-20250409    gcc-12.4.0
sparc                            allmodconfig    gcc-14.2.0
sparc                 randconfig-001-20250408    gcc-10.3.0
sparc                 randconfig-002-20250408    gcc-6.5.0
sparc64               randconfig-001-20250408    gcc-6.5.0
sparc64               randconfig-002-20250408    gcc-14.2.0
um                                allnoconfig    clang-21
um                    randconfig-001-20250408    clang-21
um                    randconfig-002-20250408    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250408    clang-20
x86_64      buildonly-randconfig-002-20250408    clang-20
x86_64      buildonly-randconfig-003-20250408    clang-20
x86_64      buildonly-randconfig-004-20250408    gcc-12
x86_64      buildonly-randconfig-005-20250408    clang-20
x86_64      buildonly-randconfig-006-20250408    clang-20
x86_64                              defconfig    gcc-11
xtensa                randconfig-001-20250408    gcc-6.5.0
xtensa                randconfig-002-20250408    gcc-6.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

