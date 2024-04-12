Return-Path: <linux-rdma+bounces-1922-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0068A2568
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Apr 2024 07:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA0E42816D0
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Apr 2024 05:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D779AD528;
	Fri, 12 Apr 2024 05:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eWdwK7xn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B292F52
	for <linux-rdma@vger.kernel.org>; Fri, 12 Apr 2024 05:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712898094; cv=none; b=M7yi5QW+Rv3gsaz8rmqadCIV451sbe6ZZVvSluSCuBJ19f5NR969mRkpVVWTIMqzumkvHvLHE9rRLR66zVjKpcaBgjTPbo0hvEqUrkjM6hmrbbM1xkeW21v3mqnXb8SUFSFUssLWywDBNUMR7m9YS36FXKH3ePuz8Hy+7cTzNo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712898094; c=relaxed/simple;
	bh=gjA6N1gvLPON3h45meS4tKCllPCp0vRedys19bbAle0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ae4w1FxHQeIFTlJHzJg0nrXSdKLbdXGm9UkOCnJCs7vfnbVmNgzyUDECNWont8RK2NoWha8eXsoB1BKkDW3VH6uNHCWXXMImIb1rjXo6AyB5YxVQdVykXHzRbrt5EA/c1xYkdhI2gaYxFqQq6/ZreqruwWhG5upFhMxzj8/1wRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eWdwK7xn; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712898093; x=1744434093;
  h=date:from:to:cc:subject:message-id;
  bh=gjA6N1gvLPON3h45meS4tKCllPCp0vRedys19bbAle0=;
  b=eWdwK7xn4+u3VdI6yfUh+GWTR5XnBXKC2u0rNQmH7ncBCccvSrSXDkvt
   7t4squ+f5OyPP7yL8app4pzySAwgP0QZm2xtC/kTXJFdlX6Ss/JwxOzp1
   TDvXkQPevFZK4rzZ/AUimAMWg3tyi969snGFw1nok63Fp6nIoTVnYml5m
   BtrSujJNL/i6g2wBtFN95SZjpz0nK9RMzxbzXjCD/f75MjCpZi4GYHw+J
   koKBjYMCCxg0JAz9UjsLDBIMvoBGnkk3DYtDoTH/vunrwJ5LYnLkkcSlq
   ioHiOsCO/JM4xIv3X1WbtZL7uTiVwLIZXnGuMRMehA80t1VM/5okgRCRz
   Q==;
X-CSE-ConnectionGUID: YXXbcgrjTKCAUGryJaW8Rw==
X-CSE-MsgGUID: oI19w0R6RiquYECTXAek+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8201427"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="8201427"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 22:01:32 -0700
X-CSE-ConnectionGUID: AWtWLCdAR1qr6mIjEoEMNg==
X-CSE-MsgGUID: 7VWffbpFQE25zpwKcLBKWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="21554298"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 11 Apr 2024 22:01:30 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rv92V-0009O9-2j;
	Fri, 12 Apr 2024 05:01:27 +0000
Date: Fri, 12 Apr 2024 13:00:40 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 dfcdb38b21e4fb92a49acdbdf6afa82c07c8eba0
Message-ID: <202404121337.YtwtU5yI-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: dfcdb38b21e4fb92a49acdbdf6afa82c07c8eba0  RDMA/rxe: Return the correct errno

elapsed time: 1001m

configs tested: 106
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240412   gcc  
i386         buildonly-randconfig-002-20240412   clang
i386         buildonly-randconfig-003-20240412   gcc  
i386         buildonly-randconfig-004-20240412   gcc  
i386         buildonly-randconfig-005-20240412   gcc  
i386         buildonly-randconfig-006-20240412   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240412   clang
i386                  randconfig-002-20240412   gcc  
i386                  randconfig-003-20240412   clang
i386                  randconfig-004-20240412   clang
i386                  randconfig-005-20240412   clang
i386                  randconfig-006-20240412   gcc  
i386                  randconfig-011-20240412   clang
i386                  randconfig-012-20240412   gcc  
i386                  randconfig-013-20240412   clang
i386                  randconfig-014-20240412   gcc  
i386                  randconfig-015-20240412   gcc  
i386                  randconfig-016-20240412   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240412   gcc  
x86_64       buildonly-randconfig-002-20240412   gcc  
x86_64       buildonly-randconfig-003-20240412   gcc  
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

