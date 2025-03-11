Return-Path: <linux-rdma+bounces-8559-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 419F8A5B814
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 05:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4113B01E7
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 04:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400101E9B2D;
	Tue, 11 Mar 2025 04:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ksgtKIK0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA861E9B01
	for <linux-rdma@vger.kernel.org>; Tue, 11 Mar 2025 04:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741668594; cv=none; b=ftfY02YJ7pmjIKAYGfizp3gea2c/uHxoX9re/sWQw4KkkYqGru2YE5gdpv2oD+DvltFIN2klLRCq3v8st7cKMIfKzKGZagqfbCyxIfFgG2VXbQDVW/TFfxKtusfPRq68jnktZa4MSDXGMDXFY97iJdKlp7UwAkNSf55+0DE0AyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741668594; c=relaxed/simple;
	bh=rBTYUdjqp15BP8ieW4hmiW+2mGsrJyaQLr/+G3qEjbo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kPEo9H2adJm9aXfnsaLpCkldiuqXaSRtKnmpQQiW/gpAXvKdhevygN88xlVP8z3tveMyfhAfT0dlo0EI1q0/OdyKH3mL89HxVok7Q8F8DLn0aATLQ7ZD2R6YQfwmqwMC1ptXyy4OLOtzMhcuSC9Kmq0KFiBRpmiP070KgyV/G2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ksgtKIK0; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741668592; x=1773204592;
  h=date:from:to:cc:subject:message-id;
  bh=rBTYUdjqp15BP8ieW4hmiW+2mGsrJyaQLr/+G3qEjbo=;
  b=ksgtKIK0tIKFpllAGPW6cURIkSYZ/qSVkEYjHIO6Q4vju+Mz6G7xLnU4
   lYaJXkQcbKYNs/8yKlURB81YUXnHgjewZ7lcTRxIY67xTTXlVxfQRIhX/
   gR8eW2SHYVrlpZTo8yb9JrPGVV7WjhpHVdbSwwyz88PgN+LUW2l+R5gBC
   1k38ZUPxuHdc5/a20i8JzPquz8Dq+fZD5HpcFLCjXNm7PKJqjWKdq/nGw
   cXYJcMqEbXTT+c9AeF+HAg/NDhkFhP5tNonJa8PI40nOD0t+EBdgFeYWo
   eutlBR81mIlKm3ZPj5tReULRP0PnJ8PTgaHqisA918FaAg8BvFHpQ4w9l
   g==;
X-CSE-ConnectionGUID: uaXbMjx9Q/2ZH/7E6nYS5g==
X-CSE-MsgGUID: cuumhaKnT4GkvtYlegt8CA==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="52898197"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="52898197"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 21:49:51 -0700
X-CSE-ConnectionGUID: UbP+wH+KStKqU7Ij3DSU4Q==
X-CSE-MsgGUID: CF/G8RVrSueAJA8V2h7+bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="120416623"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 10 Mar 2025 21:49:49 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trrYp-0006Lo-25;
	Tue, 11 Mar 2025 04:49:47 +0000
Date: Tue, 11 Mar 2025 12:49:16 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 8820965c48528af169beaced13c5458a208185f7
Message-ID: <202503111209.2z9mL1d3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 8820965c48528af169beaced13c5458a208185f7  docs: infiniband: document the UCAP API

elapsed time: 1247m

configs tested: 153
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              alldefconfig    gcc-13.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                          axs101_defconfig    gcc-13.2.0
arc                         haps_hs_defconfig    gcc-13.2.0
arc                        nsimosci_defconfig    gcc-13.2.0
arc                   randconfig-001-20250310    gcc-13.2.0
arc                   randconfig-001-20250311    gcc-13.2.0
arc                   randconfig-002-20250310    gcc-13.2.0
arc                   randconfig-002-20250311    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                          ep93xx_defconfig    clang-21
arm                            hisi_defconfig    gcc-14.2.0
arm                      integrator_defconfig    clang-15
arm                            mmp2_defconfig    gcc-14.2.0
arm                          moxart_defconfig    gcc-14.2.0
arm                   randconfig-001-20250310    clang-21
arm                   randconfig-001-20250311    gcc-14.2.0
arm                   randconfig-002-20250310    gcc-14.2.0
arm                   randconfig-002-20250311    clang-16
arm                   randconfig-003-20250310    gcc-14.2.0
arm                   randconfig-003-20250311    gcc-14.2.0
arm                   randconfig-004-20250310    clang-21
arm                         s3c6400_defconfig    gcc-14.2.0
arm                           sama5_defconfig    gcc-14.2.0
arm                        spear6xx_defconfig    clang-19
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250310    clang-19
arm64                 randconfig-002-20250310    clang-17
arm64                 randconfig-003-20250310    clang-15
arm64                 randconfig-004-20250310    clang-17
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250310    gcc-14.2.0
csky                  randconfig-002-20250310    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250310    clang-21
hexagon               randconfig-002-20250310    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250310    clang-19
i386        buildonly-randconfig-002-20250310    clang-19
i386        buildonly-randconfig-003-20250310    clang-19
i386        buildonly-randconfig-004-20250310    clang-19
i386        buildonly-randconfig-005-20250310    clang-19
i386        buildonly-randconfig-006-20250310    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250310    gcc-14.2.0
loongarch             randconfig-002-20250310    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath25_defconfig    clang-16
nios2                         10m50_defconfig    gcc-14.2.0
nios2                            alldefconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250310    gcc-14.2.0
nios2                 randconfig-002-20250310    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
openrisc                    or1ksim_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250310    gcc-14.2.0
parisc                randconfig-002-20250310    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                        fsp2_defconfig    gcc-14.2.0
powerpc                 mpc837x_rdb_defconfig    gcc-14.2.0
powerpc                      pmac32_defconfig    clang-21
powerpc                      ppc64e_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250310    clang-17
powerpc               randconfig-002-20250310    clang-21
powerpc               randconfig-003-20250310    clang-17
powerpc                    sam440ep_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250310    gcc-14.2.0
powerpc64             randconfig-002-20250310    gcc-14.2.0
powerpc64             randconfig-003-20250310    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                    nommu_virt_defconfig    clang-21
riscv                 randconfig-001-20250310    clang-19
riscv                 randconfig-002-20250310    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250310    gcc-14.2.0
s390                  randconfig-002-20250310    clang-18
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250310    gcc-14.2.0
sh                    randconfig-002-20250310    gcc-14.2.0
sh                          rsk7203_defconfig    gcc-14.2.0
sh                   secureedge5410_defconfig    gcc-14.2.0
sh                   sh7770_generic_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250310    gcc-14.2.0
sparc                 randconfig-002-20250310    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250310    gcc-14.2.0
sparc64               randconfig-002-20250310    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250310    gcc-12
um                    randconfig-002-20250310    clang-17
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250310    gcc-12
x86_64      buildonly-randconfig-001-20250311    gcc-12
x86_64      buildonly-randconfig-002-20250310    clang-19
x86_64      buildonly-randconfig-002-20250311    gcc-12
x86_64      buildonly-randconfig-003-20250310    clang-19
x86_64      buildonly-randconfig-003-20250311    clang-19
x86_64      buildonly-randconfig-004-20250310    clang-19
x86_64      buildonly-randconfig-004-20250311    clang-19
x86_64      buildonly-randconfig-005-20250310    clang-19
x86_64      buildonly-randconfig-005-20250311    gcc-12
x86_64      buildonly-randconfig-006-20250310    gcc-12
x86_64      buildonly-randconfig-006-20250311    gcc-12
x86_64                              defconfig    gcc-11
xtensa                           alldefconfig    gcc-14.2.0
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  audio_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250310    gcc-14.2.0
xtensa                randconfig-002-20250310    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

