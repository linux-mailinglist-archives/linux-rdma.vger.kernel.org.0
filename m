Return-Path: <linux-rdma+bounces-13772-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE40BB7FA3
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Oct 2025 21:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2963BC3E3
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Oct 2025 19:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD64223DDA;
	Fri,  3 Oct 2025 19:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vm+9tw5V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1962C1F4C8E
	for <linux-rdma@vger.kernel.org>; Fri,  3 Oct 2025 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759519614; cv=none; b=twFrMXu3eDunZ0Wymn0eTtkr/OEO9admIXgpLcDrOxRTJhpgp3HVGubUt1HnczMdgCBBCNGQA4tbkApHjRAVXPsn5XSqP69OfC30z5Azjcj2Q+rUMKorbj0TUhG7/6aaiQLRU2sVNhSNHX1aED17aoSlVWRth/n2vaxWkkOb7ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759519614; c=relaxed/simple;
	bh=DVtRuAHZr7rGweolT0vPwP5/F+MAaEf98YafD2ePI5c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EpRO/ZM26pvHbptxBWjCwVBHu8TFck1whmSf5D2Bm1TBFq0d+3M9b6PVQ+2dvDnZ6rAgNiQMR/H/P21Y1YxE3xNYZ6V5qjMc1CPDEh0wts076hS7nqkhx2JNBy+PvWSmlVZbjPYoSeq6bQPnyZHpEro6zxUWuV7Z/X2ldnSoGUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vm+9tw5V; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759519614; x=1791055614;
  h=date:from:to:cc:subject:message-id;
  bh=DVtRuAHZr7rGweolT0vPwP5/F+MAaEf98YafD2ePI5c=;
  b=Vm+9tw5VeDj3rv50XlL4Ywc/YnPihjqWKQGn8ByPUmb/y09IMfuVppnU
   mPwrRGbSM+ydrMQwl3NZUru6IRNlD6AyymR6D6VIVrFXvl/EftPtp9J8g
   ZsMtoyy88SWNpvCCZx305Slof+behfFpqvzREWXGlsaiFIUWp7DJWsOzi
   XcBcNFKszo3f8bQKvcBk61cFtwpGDcjbDpuI72aV2beJhWzmRn4ZzsVRJ
   SamUBXhAUOfSKjiM1HMfqFqBXV62uJGDcEu3FfHT1ZnKWYZ6dCPxugS6k
   tJxFddC00PHZurYgAkJh/AvwO8J/mwKLG6MFhqshFQslDwTj+91lQKeGv
   A==;
X-CSE-ConnectionGUID: HxjYN22dTJCbVz2nsNChVA==
X-CSE-MsgGUID: uoKex4iJQy68blP0X2ObUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11571"; a="72905880"
X-IronPort-AV: E=Sophos;i="6.18,313,1751266800"; 
   d="scan'208";a="72905880"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 12:26:53 -0700
X-CSE-ConnectionGUID: xgYA6mqHS0Szd/VI5+Rhcw==
X-CSE-MsgGUID: qUEDlTdGRh2UmBbfV+CqJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,313,1751266800"; 
   d="scan'208";a="184646074"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 03 Oct 2025 12:26:51 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v4lQX-0004q7-1E;
	Fri, 03 Oct 2025 19:26:49 +0000
Date: Sat, 04 Oct 2025 03:26:36 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/for-testing] BUILD SUCCESS
 2d9d2f24649e7f651ac7b9dff5a580f924a19eb4
Message-ID: <202510040326.oF1it9KU-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/for-testing
branch HEAD: 2d9d2f24649e7f651ac7b9dff5a580f924a19eb4  Merge tag 'v6.17' into rdma.git for-next

elapsed time: 1451m

configs tested: 114
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
arc                      axs103_smp_defconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251003    gcc-11.5.0
arc                   randconfig-002-20251003    gcc-13.4.0
arm                               allnoconfig    clang-22
arm                          exynos_defconfig    clang-22
arm                   randconfig-001-20251003    gcc-12.5.0
arm                   randconfig-002-20251003    clang-22
arm                   randconfig-003-20251003    gcc-13.4.0
arm                   randconfig-004-20251003    gcc-13.4.0
arm                           sunxi_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251003    gcc-13.4.0
arm64                 randconfig-002-20251003    clang-22
arm64                 randconfig-003-20251003    gcc-10.5.0
arm64                 randconfig-004-20251003    gcc-13.4.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251003    gcc-15.1.0
csky                  randconfig-002-20251003    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251003    clang-22
hexagon               randconfig-002-20251003    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251003    gcc-14
i386        buildonly-randconfig-002-20251003    gcc-12
i386        buildonly-randconfig-003-20251003    clang-20
i386        buildonly-randconfig-004-20251003    gcc-12
i386        buildonly-randconfig-005-20251003    clang-20
i386        buildonly-randconfig-006-20251003    gcc-14
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251003    gcc-15.1.0
loongarch             randconfig-002-20251003    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251003    gcc-8.5.0
nios2                 randconfig-002-20251003    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251003    gcc-9.5.0
parisc                randconfig-002-20251003    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          g5_defconfig    gcc-15.1.0
powerpc                    ge_imp3a_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251003    clang-22
powerpc               randconfig-002-20251003    gcc-8.5.0
powerpc               randconfig-003-20251003    clang-22
powerpc                     tqm5200_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251003    gcc-12.5.0
powerpc64             randconfig-002-20251003    gcc-10.5.0
powerpc64             randconfig-003-20251003    clang-18
riscv                             allnoconfig    gcc-15.1.0
riscv                    nommu_k210_defconfig    clang-22
riscv                 randconfig-001-20251003    gcc-11.5.0
riscv                 randconfig-002-20251003    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20251003    clang-22
s390                  randconfig-002-20251003    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251003    gcc-10.5.0
sh                    randconfig-002-20251003    gcc-14.3.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251003    gcc-14.3.0
sparc                 randconfig-002-20251003    gcc-13.4.0
sparc64               randconfig-001-20251003    clang-20
sparc64               randconfig-002-20251003    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20251003    clang-22
um                    randconfig-002-20251003    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251003    clang-20
x86_64      buildonly-randconfig-002-20251003    gcc-14
x86_64      buildonly-randconfig-003-20251003    gcc-14
x86_64      buildonly-randconfig-004-20251003    gcc-14
x86_64      buildonly-randconfig-005-20251003    clang-20
x86_64      buildonly-randconfig-006-20251003    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251003    gcc-13.4.0
xtensa                randconfig-002-20251003    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

