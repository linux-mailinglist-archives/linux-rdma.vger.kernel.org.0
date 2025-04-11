Return-Path: <linux-rdma+bounces-9360-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C58AA850BC
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 02:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 533891BA51B2
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 00:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8039C23373B;
	Fri, 11 Apr 2025 00:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GNAi/1f6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5C9232386
	for <linux-rdma@vger.kernel.org>; Fri, 11 Apr 2025 00:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744332241; cv=none; b=l90ewQIKNIfqBtIZOzkGHLhlN9JKFtccJ9Yi9Z81J3momf3IVpW5se04cfiG1KoG/e1GtF5vUE99diUo9CI2hwWJZDQ2jOhKd21ynJlUlh+xeLJMocL3HT/i6K2htVfTrpDlz1Jp54o6DbkToxXYbtB0cqyGz/wh9LpKi8AkhRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744332241; c=relaxed/simple;
	bh=uU+ve+3m+mZbM5xNNXHUbYVEOAvS2EXgoUYlnJSo1pc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ehq9DRnudAyL3GF6/PnFdZIye3q7gNqSZsSqrIIHI3G45RMAUiG55aCCboTE/mLQUeqpnl2i/oA9r9LjZELhLdG8bg6NUhbWCqbuSn2pwIy6BZhB8cSMWkZqHY1iiVj2caWgF1AIYI8A73KBolWmSvVVXvo7h9jjRXoK+FE1UmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GNAi/1f6; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744332238; x=1775868238;
  h=date:from:to:cc:subject:message-id;
  bh=uU+ve+3m+mZbM5xNNXHUbYVEOAvS2EXgoUYlnJSo1pc=;
  b=GNAi/1f6rcQk4A2qw05LlKR0YF6oNxlMb6svg2AK44ssDTQKEbXWYXf+
   gXbhOkprhXc9jEZPjhgO2ldyDR5tdjJykToZkaUTJ7Orv+rYhTNRUUIm0
   hzI7wmUERsFRhXq61Vl7KDEIaMpTWfCOaPJM+wQcrc5LxjjgdBNy4unYz
   NR0hIyT/nr0jqe1SLRW9JezskqVmXTv9vvQa5dVqJYgqXPiq/MyH8TUqw
   p8GxdXYizSJ9sQj/WIlfloaxOiTTj/7+xRvW6o9JWER8iEj4DLmQZsp7G
   R1SsUD9wK7ghswTlBvzz/GE9EhdA/LRDxhHwLc2j5I3rMZFblNDRlYhiN
   w==;
X-CSE-ConnectionGUID: AQEta9r4RYGo6fPoR2XYPQ==
X-CSE-MsgGUID: Otz+c7ZzSFuPKl5A7aRRQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="49675932"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="49675932"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 17:43:58 -0700
X-CSE-ConnectionGUID: A8qzzEnkTyS4wuooxS7IXw==
X-CSE-MsgGUID: Z1ZcyArTQJyldb1ZbAOJpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="128821208"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 10 Apr 2025 17:43:55 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u32Up-000Afb-1G;
	Fri, 11 Apr 2025 00:43:51 +0000
Date: Fri, 11 Apr 2025 08:43:35 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:hmm] BUILD SUCCESS
 174ce1d5a55b9e943a19149eca004be69509573c
Message-ID: <202504110826.9LGbgGy6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git hmm
branch HEAD: 174ce1d5a55b9e943a19149eca004be69509573c  fwctl: Fix repeated device word in log message

elapsed time: 1461m

configs tested: 112
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                   randconfig-001-20250410    gcc-14.2.0
arc                   randconfig-002-20250410    gcc-12.4.0
arm                              alldefconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                   randconfig-001-20250410    clang-21
arm                   randconfig-002-20250410    clang-18
arm                   randconfig-003-20250410    gcc-7.5.0
arm                   randconfig-004-20250410    gcc-8.5.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250410    clang-21
arm64                 randconfig-002-20250410    clang-21
arm64                 randconfig-003-20250410    gcc-6.5.0
arm64                 randconfig-004-20250410    gcc-8.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250410    gcc-14.2.0
csky                  randconfig-001-20250411    gcc-14.2.0
csky                  randconfig-002-20250410    gcc-14.2.0
csky                  randconfig-002-20250411    gcc-9.3.0
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250410    clang-21
hexagon               randconfig-001-20250411    clang-21
hexagon               randconfig-002-20250410    clang-21
hexagon               randconfig-002-20250411    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250410    clang-20
i386        buildonly-randconfig-002-20250410    clang-20
i386        buildonly-randconfig-003-20250410    clang-20
i386        buildonly-randconfig-004-20250410    gcc-11
i386        buildonly-randconfig-005-20250410    clang-20
i386        buildonly-randconfig-006-20250410    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250410    gcc-12.4.0
loongarch             randconfig-001-20250411    gcc-14.2.0
loongarch             randconfig-002-20250410    gcc-12.4.0
loongarch             randconfig-002-20250411    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                       rbtx49xx_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250410    gcc-14.2.0
nios2                 randconfig-001-20250411    gcc-9.3.0
nios2                 randconfig-002-20250410    gcc-10.5.0
nios2                 randconfig-002-20250411    gcc-7.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250410    gcc-5.5.0
parisc                randconfig-001-20250411    gcc-14.2.0
parisc                randconfig-002-20250410    gcc-11.5.0
parisc                randconfig-002-20250411    gcc-8.5.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250410    gcc-6.5.0
powerpc               randconfig-001-20250411    gcc-9.3.0
powerpc               randconfig-002-20250410    gcc-6.5.0
powerpc               randconfig-003-20250410    clang-21
powerpc64             randconfig-001-20250410    clang-21
powerpc64             randconfig-001-20250411    gcc-5.5.0
powerpc64             randconfig-002-20250410    clang-21
powerpc64             randconfig-002-20250411    gcc-5.5.0
powerpc64             randconfig-003-20250410    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250410    clang-21
riscv                 randconfig-002-20250410    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250410    clang-17
s390                  randconfig-002-20250410    gcc-6.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250410    gcc-12.4.0
sh                    randconfig-002-20250410    gcc-10.5.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250410    gcc-10.3.0
sparc                 randconfig-002-20250410    gcc-7.5.0
sparc64               randconfig-001-20250410    gcc-7.5.0
sparc64               randconfig-002-20250410    gcc-5.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250410    clang-19
um                    randconfig-002-20250410    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250410    clang-20
x86_64      buildonly-randconfig-002-20250410    gcc-12
x86_64      buildonly-randconfig-003-20250410    clang-20
x86_64      buildonly-randconfig-004-20250410    clang-20
x86_64      buildonly-randconfig-005-20250410    clang-20
x86_64      buildonly-randconfig-006-20250410    clang-20
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250410    gcc-14.2.0
xtensa                randconfig-002-20250410    gcc-7.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

