Return-Path: <linux-rdma+bounces-4945-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07772978E29
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Sep 2024 08:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7FD1C22469
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Sep 2024 06:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06E2BE40;
	Sat, 14 Sep 2024 06:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BNMWiUDC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047E38BE5
	for <linux-rdma@vger.kernel.org>; Sat, 14 Sep 2024 06:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726293767; cv=none; b=UJJ8xKEpCk08z9+2aC8A3FgWDnBt1m8wHgCg5wIeZKZFFJQtMoNgotyHMdb6tXleH6gRD3ZuEgUNKG0NXEGi+iOxw+gZeHJHH5C2SgO0dVlDCepNfu0eVdJcSUzGRMW9KjFMV5g4Qj+K6u0IOj99CoolIuqqRTw549PSszsxYCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726293767; c=relaxed/simple;
	bh=qRLYv0atfSuVY+ygx6EyCsszJQIFuzH4WsUCE/SM7JQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qNko2fArBEX+dSths29ZdIqXdEjCEqpn+i8hqL6fwWasCLtub9/8ZVvOuvhd3DcyC+oLutp5BHlP7waqOoWWBdZahvm+5HqJJnRUk8uAirCZTT02lgYcSv4SuUKMO/RIJyYYlUADwLBJq0l2DI2VI+wYmAUR4nwslmjKoUoqJVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BNMWiUDC; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726293766; x=1757829766;
  h=date:from:to:cc:subject:message-id;
  bh=qRLYv0atfSuVY+ygx6EyCsszJQIFuzH4WsUCE/SM7JQ=;
  b=BNMWiUDCaZDkvni0fIm2bKB4FESpZ2/riRMjlHNdPkXLhv4tTBxOfm0d
   vwaTqS5rkLaZzIgPssFzqz/tT/ThFs7LAYOHQHyMwrbDqbdQmfHa07Rz2
   7G1CPDsIyVsaVV1JGTiFS1Eux1FPT21bNdd6XIZDSQBRyeL8YntUKDQCe
   /M3z/A4flJeJpTJoTIeX9Q2WWso2dx6XqUdcifRaHhv+kJl/3SjCkH3Dl
   aE7sDj0fSvpFhGn8mneq5Q/jupGE1vgO7SEcmhtLtoAZ5HOT435XSt0Q1
   ErK+1Z07elNUzWPNrK7pxwYJUgKYKgQ49AYXTzCcHxzafBl3O3gZzjmJV
   A==;
X-CSE-ConnectionGUID: mfquNQqBSl6QWlIZId9Pxw==
X-CSE-MsgGUID: //C06obiSnC2VmS5hyFHew==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="36336192"
X-IronPort-AV: E=Sophos;i="6.10,228,1719903600"; 
   d="scan'208";a="36336192"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 23:02:45 -0700
X-CSE-ConnectionGUID: agHztfJpRGi/PweHEtQkZA==
X-CSE-MsgGUID: Dzd72CpRRHOO1huGnzQcmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,228,1719903600"; 
   d="scan'208";a="99174103"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 13 Sep 2024 23:02:43 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spLrl-0007RC-2W;
	Sat, 14 Sep 2024 06:02:41 +0000
Date: Sat, 14 Sep 2024 14:01:57 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 cc5b9b48d44756a87170f3901c6c2fd99e6b89b2
Message-ID: <202409141449.IYFKTyJ8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: cc5b9b48d44756a87170f3901c6c2fd99e6b89b2  RDMA/bnxt_re: Recover the device when FW error is detected

elapsed time: 1460m

configs tested: 130
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    gcc-13.3.0
arc                               allnoconfig    gcc-14.1.0
arc                   randconfig-001-20240914    gcc-13.2.0
arc                   randconfig-002-20240914    gcc-13.2.0
arm                               allnoconfig    gcc-14.1.0
arm                   randconfig-001-20240914    gcc-14.1.0
arm                   randconfig-002-20240914    gcc-14.1.0
arm                   randconfig-003-20240914    gcc-14.1.0
arm                   randconfig-004-20240914    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                 randconfig-001-20240914    gcc-14.1.0
arm64                 randconfig-002-20240914    gcc-14.1.0
arm64                 randconfig-003-20240914    clang-20
arm64                 randconfig-004-20240914    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                  randconfig-001-20240914    gcc-14.1.0
csky                  randconfig-002-20240914    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20240914    clang-20
hexagon               randconfig-002-20240914    clang-17
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240914    gcc-12
i386        buildonly-randconfig-002-20240914    clang-18
i386        buildonly-randconfig-003-20240914    gcc-12
i386        buildonly-randconfig-004-20240914    gcc-12
i386        buildonly-randconfig-005-20240914    clang-18
i386        buildonly-randconfig-006-20240914    gcc-11
i386                                defconfig    clang-18
i386                  randconfig-001-20240914    gcc-12
i386                  randconfig-002-20240914    clang-18
i386                  randconfig-003-20240914    gcc-12
i386                  randconfig-004-20240914    gcc-12
i386                  randconfig-005-20240914    clang-18
i386                  randconfig-006-20240914    clang-18
i386                  randconfig-011-20240914    gcc-12
i386                  randconfig-012-20240914    gcc-12
i386                  randconfig-013-20240914    clang-18
i386                  randconfig-014-20240914    clang-18
i386                  randconfig-015-20240914    clang-18
i386                  randconfig-016-20240914    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch             randconfig-001-20240914    gcc-14.1.0
loongarch             randconfig-002-20240914    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                 randconfig-001-20240914    gcc-14.1.0
nios2                 randconfig-002-20240914    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                randconfig-001-20240914    gcc-14.1.0
parisc                randconfig-002-20240914    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc               randconfig-001-20240914    gcc-14.1.0
powerpc               randconfig-002-20240914    gcc-14.1.0
powerpc               randconfig-003-20240914    clang-20
powerpc64             randconfig-001-20240914    gcc-14.1.0
powerpc64             randconfig-002-20240914    gcc-14.1.0
powerpc64             randconfig-003-20240914    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                 randconfig-001-20240914    clang-14
riscv                 randconfig-002-20240914    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                  randconfig-001-20240914    gcc-14.1.0
s390                  randconfig-002-20240914    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                    randconfig-001-20240914    gcc-14.1.0
sh                    randconfig-002-20240914    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64               randconfig-001-20240914    gcc-14.1.0
sparc64               randconfig-002-20240914    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    gcc-12
um                    randconfig-001-20240914    gcc-12
um                    randconfig-002-20240914    clang-16
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20240913    clang-18
x86_64      buildonly-randconfig-002-20240913    gcc-12
x86_64      buildonly-randconfig-003-20240913    clang-18
x86_64      buildonly-randconfig-004-20240913    clang-18
x86_64      buildonly-randconfig-005-20240913    gcc-12
x86_64      buildonly-randconfig-006-20240913    clang-18
x86_64                              defconfig    gcc-11
x86_64                randconfig-001-20240913    gcc-12
x86_64                randconfig-002-20240913    clang-18
x86_64                randconfig-003-20240913    gcc-12
x86_64                randconfig-004-20240913    clang-18
x86_64                randconfig-005-20240913    clang-18
x86_64                randconfig-006-20240913    gcc-12
x86_64                randconfig-011-20240913    gcc-12
x86_64                randconfig-012-20240913    clang-18
x86_64                randconfig-013-20240913    clang-18
x86_64                randconfig-014-20240913    clang-18
x86_64                randconfig-015-20240913    gcc-12
x86_64                randconfig-016-20240913    gcc-12
x86_64                randconfig-071-20240913    clang-18
x86_64                randconfig-072-20240913    gcc-12
x86_64                randconfig-073-20240913    gcc-12
x86_64                randconfig-074-20240913    gcc-12
x86_64                randconfig-075-20240913    clang-18
x86_64                randconfig-076-20240913    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20240914    gcc-14.1.0
xtensa                randconfig-002-20240914    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

