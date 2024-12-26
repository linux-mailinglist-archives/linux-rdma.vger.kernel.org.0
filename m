Return-Path: <linux-rdma+bounces-6744-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6336D9FC802
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Dec 2024 05:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82E4D7A00B2
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Dec 2024 04:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6E91487DD;
	Thu, 26 Dec 2024 04:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kw0GETFa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E29117E0
	for <linux-rdma@vger.kernel.org>; Thu, 26 Dec 2024 04:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735189032; cv=none; b=MF9oa2JrfPoBtb+sz+n0OBkdRJcGhwKAU2TJXDcnjG1Eh3calRrYlSLMoZkJEzzaNKdWuPzSUdA2jrUdN+61I/tfcKu1YDD7+ZrenCz8FcyP7OVo18WWGq7mdF3Rd1njy1T0+UU+euFzAvePrALkbC+HTfwO8BeOJJ0oQWh7WcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735189032; c=relaxed/simple;
	bh=7/wyehbBp4h1hq6HoNXYHu2vryXe8PnRqWHTvJCKZeI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=d3r4IM22lbIgyr9Jo8B4mNLECVn6691Cv3IkNSayPLM3ExmJ2INnZfBaPyyM4elrTvep8Qj5jiUD6Fddwa4gNnjYWCwPNfPv081LCBr2v4w7AXo25XQsS5SD8UYCo3RMGdnY3cNHzzRSMiQolUO/YX4H9i7pH9AvOA00fLE9jd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kw0GETFa; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735189031; x=1766725031;
  h=date:from:to:cc:subject:message-id;
  bh=7/wyehbBp4h1hq6HoNXYHu2vryXe8PnRqWHTvJCKZeI=;
  b=Kw0GETFaBvEoz6B8Gj0By93byVBsa/GrVzrM9eek2nAO140UTI3FI7kO
   saaE/tq5t0wzKKOcbsAUl1EPa1PjaaOdQRpW4gSIYnLZqv8/xwT018XIC
   qScmrdu8Lr9aB7PGii0Ril8NABCen6auaNi6BxCO+cyOsr9i21B44Ul8f
   9LKYQxY7Oxe5roAY/FY1uaKURGFMGnEz5t6Koy2H+3KBZlWQ7hqhlx4KY
   22Zx6eCcQQ8seeoy1VFo9+aQYgwHXeNUMM1THE2LCoP4HHmHPL4RKBAU7
   6REmKp4WkMmzvNdZ3BML6F1bGQxORurofXQpWOPDJBt3Ll8ier7QCMJD1
   Q==;
X-CSE-ConnectionGUID: eTvhnC3kR9qaesxqkQBXFw==
X-CSE-MsgGUID: pj/S8PgqQnW+fE+ijXPYuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35318611"
X-IronPort-AV: E=Sophos;i="6.12,265,1728975600"; 
   d="scan'208";a="35318611"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2024 20:57:10 -0800
X-CSE-ConnectionGUID: MNjboM0oQkGd6L6yQDyJpA==
X-CSE-MsgGUID: MWTRrQDtSx+R5Lq7kZ+P/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,265,1728975600"; 
   d="scan'208";a="130689247"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 25 Dec 2024 20:57:09 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tQfvm-0002LW-0x;
	Thu, 26 Dec 2024 04:57:06 +0000
Date: Thu, 26 Dec 2024 12:56:23 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 26b592d29e118fcc9a64eb3647b4d7f97eb21bbc
Message-ID: <202412261217.muhyIJDH-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 26b592d29e118fcc9a64eb3647b4d7f97eb21bbc  RDMA/hns: Support fast path for link-down events dispatching

elapsed time: 900m

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
arc                   randconfig-001-20241225    gcc-13.2.0
arc                   randconfig-002-20241225    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                         at91_dt_defconfig    clang-20
arm                          collie_defconfig    gcc-14.2.0
arm                                 defconfig    clang-20
arm                         mv78xx0_defconfig    clang-20
arm                          pxa3xx_defconfig    clang-20
arm                   randconfig-001-20241225    gcc-14.2.0
arm                   randconfig-002-20241225    gcc-14.2.0
arm                   randconfig-003-20241225    gcc-14.2.0
arm                   randconfig-004-20241225    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241225    gcc-14.2.0
arm64                 randconfig-002-20241225    clang-16
arm64                 randconfig-003-20241225    gcc-14.2.0
arm64                 randconfig-004-20241225    clang-16
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241225    gcc-14.2.0
csky                  randconfig-002-20241225    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                             defconfig    clang-20
hexagon               randconfig-001-20241225    clang-20
hexagon               randconfig-002-20241225    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241225    gcc-12
i386        buildonly-randconfig-002-20241225    gcc-12
i386        buildonly-randconfig-003-20241225    clang-19
i386        buildonly-randconfig-004-20241225    gcc-12
i386        buildonly-randconfig-005-20241225    gcc-11
i386        buildonly-randconfig-006-20241225    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241225    gcc-14.2.0
loongarch             randconfig-002-20241225    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         apollo_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                       m5208evb_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           gcw0_defconfig    clang-15
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241225    gcc-14.2.0
nios2                 randconfig-002-20241225    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241225    gcc-14.2.0
parisc                randconfig-002-20241225    gcc-14.2.0
parisc64                         alldefconfig    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                       ppc64_defconfig    clang-19
powerpc               randconfig-001-20241225    gcc-14.2.0
powerpc               randconfig-002-20241225    clang-20
powerpc               randconfig-003-20241225    gcc-14.2.0
powerpc                     skiroot_defconfig    clang-20
powerpc                 xes_mpc85xx_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20241225    gcc-14.2.0
powerpc64             randconfig-002-20241225    clang-16
powerpc64             randconfig-003-20241225    clang-18
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                 randconfig-001-20241226    gcc-14.2.0
riscv                 randconfig-002-20241226    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20241226    gcc-14.2.0
s390                  randconfig-002-20241226    clang-18
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                               j2_defconfig    gcc-14.2.0
sh                    randconfig-001-20241226    gcc-14.2.0
sh                    randconfig-002-20241226    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241226    gcc-14.2.0
sparc                 randconfig-002-20241226    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241226    gcc-14.2.0
sparc64               randconfig-002-20241226    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241226    gcc-12
um                    randconfig-002-20241226    clang-20
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241225    gcc-12
x86_64      buildonly-randconfig-002-20241225    gcc-12
x86_64      buildonly-randconfig-003-20241225    clang-19
x86_64      buildonly-randconfig-004-20241225    clang-19
x86_64      buildonly-randconfig-005-20241225    clang-19
x86_64      buildonly-randconfig-006-20241225    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                       common_defconfig    gcc-14.2.0
xtensa                randconfig-001-20241226    gcc-14.2.0
xtensa                randconfig-002-20241226    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

