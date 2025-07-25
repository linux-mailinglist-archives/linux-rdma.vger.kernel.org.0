Return-Path: <linux-rdma+bounces-12473-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EA8B116BA
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jul 2025 04:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2113AC2C41
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jul 2025 02:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8CB238C11;
	Fri, 25 Jul 2025 02:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ExADKbqP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB5E23817A
	for <linux-rdma@vger.kernel.org>; Fri, 25 Jul 2025 02:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753411958; cv=none; b=MXOx136KabnI6mnsgjgNSsAQx1MJPXx7GMlJ+UXlm4xaVuATPsMhWlVT5RJfbpfpWnFv6cmDXGst+VGgQ3wSu2PgkFf9Gr+0jQrf1Dyzzxz3WOz2+nE2WyyhmUtmn6FxxSP8YL7/bw6S5gxNE1JKBdNcRyzDTlBATZHFxHo5K18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753411958; c=relaxed/simple;
	bh=LliX1SBl2NIGJHs/+glxWtArVNs9jaqm0R5a4ykoIhQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FWM0sRhLE2EEZ2ujKHJi8knIuAehyZDIt0U+0uc9HW90o1DkWS6uiAEo6tZuUQ+JYsNaBYhzCURvSeF+ua9OQEx0/yiUkDhIxqDo5K/Kx46I1VhDtSxu0mv+43/zm1uQUxqPTjc3MMmx08Lao6ghBMUpzLILmt7t9/PT7j3K6TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ExADKbqP; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753411957; x=1784947957;
  h=date:from:to:cc:subject:message-id;
  bh=LliX1SBl2NIGJHs/+glxWtArVNs9jaqm0R5a4ykoIhQ=;
  b=ExADKbqPwfW0jGvGNh7s/Cv09wn8wqAEq9F6qnFcI/iSx/OESUGKprtm
   F/ouAJS97OX6sX1CIOUxry3z7C4aLqMdazqX4SDCAQ/NTbWjcpx2QZySL
   WZ1KuycGEMFlT4PG3/3Xghl7RQhShK2Jvpwd3DBctH4cR8LaFendmz2xH
   JOqGILeIiCHQWkR4NolBfdAHecG/gjti3Wvydt2hsB0oe24cAUeLH5sxP
   5YNoWhb5bwxdKM+myh7zFPL0U3Wppfav4iAMjpC35tFx0/7hTxDmGOphu
   wZThpFCMnDmtKEVNO4jDSuMDz5qcoyZ/3lWrvmBrjxFCg4OiwlI39pB0H
   A==;
X-CSE-ConnectionGUID: VeQFoMeNTEOELrJB/glaCQ==
X-CSE-MsgGUID: Zbzj0faeRXGBtl5kuB66lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55894064"
X-IronPort-AV: E=Sophos;i="6.16,338,1744095600"; 
   d="scan'208";a="55894064"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 19:52:35 -0700
X-CSE-ConnectionGUID: IQ2ElyptTZKTigTdtXwfvw==
X-CSE-MsgGUID: MW+z4znUSSyjuBhPeUKYqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,338,1744095600"; 
   d="scan'208";a="160348343"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 24 Jul 2025 19:52:34 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uf8Xv-000KzT-29;
	Fri, 25 Jul 2025 02:52:31 +0000
Date: Fri, 25 Jul 2025 10:51:44 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 ee235923d205c6de73bf5035f3cdcaee22f3291c
Message-ID: <202507251032.ji52KPfw-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: ee235923d205c6de73bf5035f3cdcaee22f3291c  RDMA/siw: Change maintainer email address

elapsed time: 1101m

configs tested: 121
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250724    gcc-13.4.0
arc                   randconfig-002-20250724    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250724    gcc-10.5.0
arm                   randconfig-002-20250724    clang-22
arm                   randconfig-003-20250724    gcc-8.5.0
arm                   randconfig-004-20250724    gcc-12.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250724    gcc-8.5.0
arm64                 randconfig-002-20250724    clang-22
arm64                 randconfig-003-20250724    gcc-13.4.0
arm64                 randconfig-004-20250724    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250724    gcc-13.4.0
csky                  randconfig-002-20250724    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250724    clang-22
hexagon               randconfig-002-20250724    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250724    gcc-12
i386        buildonly-randconfig-002-20250724    clang-20
i386        buildonly-randconfig-003-20250724    clang-20
i386        buildonly-randconfig-004-20250724    clang-20
i386        buildonly-randconfig-005-20250724    clang-20
i386        buildonly-randconfig-006-20250724    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250724    clang-22
loongarch             randconfig-002-20250724    gcc-13.4.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                       m5208evb_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        omega2p_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250724    gcc-11.5.0
nios2                 randconfig-002-20250724    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250724    gcc-14.3.0
parisc                randconfig-002-20250724    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                 mpc8313_rdb_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250724    clang-22
powerpc               randconfig-002-20250724    gcc-8.5.0
powerpc               randconfig-003-20250724    clang-22
powerpc64             randconfig-001-20250724    clang-22
powerpc64             randconfig-002-20250724    gcc-13.4.0
powerpc64             randconfig-003-20250724    gcc-15.1.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250724    gcc-13.4.0
riscv                 randconfig-002-20250724    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250724    clang-22
s390                  randconfig-002-20250724    gcc-10.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250724    gcc-13.4.0
sh                    randconfig-002-20250724    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250724    gcc-15.1.0
sparc                 randconfig-002-20250724    gcc-8.5.0
sparc64               randconfig-001-20250724    gcc-8.5.0
sparc64               randconfig-002-20250724    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250724    clang-22
um                    randconfig-002-20250724    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250724    gcc-12
x86_64      buildonly-randconfig-001-20250725    clang-20
x86_64      buildonly-randconfig-002-20250724    clang-20
x86_64      buildonly-randconfig-002-20250725    clang-20
x86_64      buildonly-randconfig-003-20250724    gcc-12
x86_64      buildonly-randconfig-003-20250725    clang-20
x86_64      buildonly-randconfig-004-20250724    gcc-12
x86_64      buildonly-randconfig-004-20250725    clang-20
x86_64      buildonly-randconfig-005-20250724    clang-20
x86_64      buildonly-randconfig-005-20250725    gcc-12
x86_64      buildonly-randconfig-006-20250724    gcc-12
x86_64      buildonly-randconfig-006-20250725    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250724    gcc-12.5.0
xtensa                randconfig-002-20250724    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

