Return-Path: <linux-rdma+bounces-11434-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBFDADF6B8
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jun 2025 21:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5CFA189CEF3
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jun 2025 19:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C071DFE22;
	Wed, 18 Jun 2025 19:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iEeJK90C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EB31624DF
	for <linux-rdma@vger.kernel.org>; Wed, 18 Jun 2025 19:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750274309; cv=none; b=rD8zFMOKxz7xal1GJdRwOcse/rcXOL/kHuP2wt6BeCcN1yvB45mu43IHKpf1f5BphVbeg/rwogT9BdLZqG1Rwm5vb7BzJEu7y8S012DTfMb6Q+G0HHZOC+IsPrXAnO92AauRu+1B+bR6+/O1pFa7WWYk81jjvGo7VDMMDxittPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750274309; c=relaxed/simple;
	bh=0d7ZXKxkuaFY0QKkkK3eyTNy3iLlSoRjuQW9wsmAHDo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hUoAkBSxHBOjSyUlxqf1pNJc65vX3bw6yPv4nAK+H8uSNwf7eF8Oait98Vx92dOMj+3TqHKH4NpSbMl4gAb0+mPGQaK6i304kFgDej3EpEo6T+WeZ5JuaS0EHcQXBG0I9W9w0b/rk5w5b/BMsZIG4WYs165s3HJ0tKWGjoJ8TBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iEeJK90C; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750274307; x=1781810307;
  h=date:from:to:cc:subject:message-id;
  bh=0d7ZXKxkuaFY0QKkkK3eyTNy3iLlSoRjuQW9wsmAHDo=;
  b=iEeJK90CRxybPc60tgMee6ig74fSlb3BSSfFkrMArDYS0YYL05/ma0Xw
   oV4TYwvqhDJhvaoHIqT0njB0bIBjSPVQ+BjlQBjrWxfbhTESpNv9Ovru1
   P/XY1NHBgziCLHeIPr2Jjl8JQBF1LFvqt3DbTADw+2u5+Eazc5StdEkdJ
   Cc0ia1QS+l8aHHATqv0WwZBjBgFJdafNOgKzWuXHip4ZjPHXbP6Fwv2OP
   BY4RSJDxIDui0HkUciAbKsxVnY98vChtyBTTxPSzSyJuoVDN3v//2tAIf
   LvzrWbdKrJfYwpXCcvb2WgypkJrgf8l17LDAxuHgWkjZcq7tpKyAft3Lv
   g==;
X-CSE-ConnectionGUID: mYH8DwtESj23nOKOYQwPjA==
X-CSE-MsgGUID: jQC1j9ExQ72CyMt4pg/yhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52488344"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="52488344"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 12:18:26 -0700
X-CSE-ConnectionGUID: QZHdW4VKQUuWoXsFkzj/Gw==
X-CSE-MsgGUID: oiV4OaW/Q4ei+29P+v0D3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="154811083"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 18 Jun 2025 12:18:24 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uRyIg-000K50-0T;
	Wed, 18 Jun 2025 19:18:22 +0000
Date: Thu, 19 Jun 2025 03:17:49 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 8edab8a72d67742f87e9dc2e2b0cdfddda5dc29a
Message-ID: <202506190339.XGbEtzEY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-rc
branch HEAD: 8edab8a72d67742f87e9dc2e2b0cdfddda5dc29a  RDMA/mlx5: Initialize obj_event->obj_sub_list before xa_insert

elapsed time: 1457m

configs tested: 241
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250618    gcc-11.5.0
arc                   randconfig-002-20250618    gcc-11.5.0
arc                   randconfig-002-20250618    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    gcc-15.1.0
arm                            hisi_defconfig    gcc-15.1.0
arm                        neponset_defconfig    gcc-15.1.0
arm                          pxa3xx_defconfig    gcc-15.1.0
arm                   randconfig-001-20250618    gcc-11.5.0
arm                   randconfig-001-20250618    gcc-15.1.0
arm                   randconfig-002-20250618    gcc-10.5.0
arm                   randconfig-002-20250618    gcc-11.5.0
arm                   randconfig-003-20250618    clang-21
arm                   randconfig-003-20250618    gcc-11.5.0
arm                   randconfig-004-20250618    gcc-11.5.0
arm                       spear13xx_defconfig    gcc-15.1.0
arm                        vexpress_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250618    clang-21
arm64                 randconfig-001-20250618    gcc-11.5.0
arm64                 randconfig-002-20250618    clang-21
arm64                 randconfig-002-20250618    gcc-11.5.0
arm64                 randconfig-003-20250618    gcc-11.5.0
arm64                 randconfig-003-20250618    gcc-14.3.0
arm64                 randconfig-004-20250618    clang-16
arm64                 randconfig-004-20250618    gcc-11.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250618    gcc-13.3.0
csky                  randconfig-001-20250618    gcc-8.5.0
csky                  randconfig-002-20250618    gcc-15.1.0
csky                  randconfig-002-20250618    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20250618    clang-19
hexagon               randconfig-001-20250618    gcc-8.5.0
hexagon               randconfig-002-20250618    clang-16
hexagon               randconfig-002-20250618    gcc-8.5.0
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20250618    clang-20
i386        buildonly-randconfig-002-20250618    clang-20
i386        buildonly-randconfig-002-20250618    gcc-12
i386        buildonly-randconfig-003-20250618    clang-20
i386        buildonly-randconfig-004-20250618    clang-20
i386        buildonly-randconfig-005-20250618    clang-20
i386        buildonly-randconfig-006-20250618    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250618    gcc-12
i386                  randconfig-002-20250618    gcc-12
i386                  randconfig-003-20250618    gcc-12
i386                  randconfig-004-20250618    gcc-12
i386                  randconfig-005-20250618    gcc-12
i386                  randconfig-006-20250618    gcc-12
i386                  randconfig-007-20250618    gcc-12
i386                  randconfig-011-20250618    gcc-12
i386                  randconfig-012-20250618    gcc-12
i386                  randconfig-013-20250618    gcc-12
i386                  randconfig-014-20250618    gcc-12
i386                  randconfig-015-20250618    gcc-12
i386                  randconfig-016-20250618    gcc-12
i386                  randconfig-017-20250618    gcc-12
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250618    gcc-15.1.0
loongarch             randconfig-001-20250618    gcc-8.5.0
loongarch             randconfig-002-20250618    gcc-15.1.0
loongarch             randconfig-002-20250618    gcc-8.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                       m5208evb_defconfig    gcc-15.1.0
m68k                          sun3x_defconfig    gcc-15.1.0
microblaze                       alldefconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                         db1xxx_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250618    gcc-11.5.0
nios2                 randconfig-001-20250618    gcc-8.5.0
nios2                 randconfig-002-20250618    gcc-8.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
openrisc                       virt_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250618    gcc-10.5.0
parisc                randconfig-001-20250618    gcc-8.5.0
parisc                randconfig-002-20250618    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20250618    gcc-8.5.0
powerpc               randconfig-002-20250618    clang-19
powerpc               randconfig-002-20250618    gcc-8.5.0
powerpc               randconfig-003-20250618    clang-21
powerpc               randconfig-003-20250618    gcc-8.5.0
powerpc                     tqm8560_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250618    gcc-8.5.0
powerpc64             randconfig-002-20250618    clang-21
powerpc64             randconfig-002-20250618    gcc-8.5.0
powerpc64             randconfig-003-20250618    gcc-15.1.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250618    clang-20
riscv                 randconfig-001-20250618    gcc-15.1.0
riscv                 randconfig-001-20250619    gcc-9.3.0
riscv                 randconfig-002-20250618    clang-21
riscv                 randconfig-002-20250618    gcc-15.1.0
riscv                 randconfig-002-20250619    gcc-9.3.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250618    gcc-15.1.0
s390                  randconfig-001-20250618    gcc-8.5.0
s390                  randconfig-001-20250619    gcc-9.3.0
s390                  randconfig-002-20250618    gcc-15.1.0
s390                  randconfig-002-20250619    gcc-9.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250618    gcc-15.1.0
sh                    randconfig-001-20250619    gcc-9.3.0
sh                    randconfig-002-20250618    gcc-15.1.0
sh                    randconfig-002-20250619    gcc-9.3.0
sh                          sdk7780_defconfig    gcc-15.1.0
sh                           se7724_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250618    gcc-15.1.0
sparc                 randconfig-001-20250618    gcc-8.5.0
sparc                 randconfig-001-20250619    gcc-9.3.0
sparc                 randconfig-002-20250618    gcc-13.3.0
sparc                 randconfig-002-20250618    gcc-15.1.0
sparc                 randconfig-002-20250619    gcc-9.3.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250618    gcc-13.3.0
sparc64               randconfig-001-20250618    gcc-15.1.0
sparc64               randconfig-001-20250619    gcc-9.3.0
sparc64               randconfig-002-20250618    gcc-15.1.0
sparc64               randconfig-002-20250618    gcc-8.5.0
sparc64               randconfig-002-20250619    gcc-9.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250618    clang-21
um                    randconfig-001-20250618    gcc-15.1.0
um                    randconfig-001-20250619    gcc-9.3.0
um                    randconfig-002-20250618    clang-21
um                    randconfig-002-20250618    gcc-15.1.0
um                    randconfig-002-20250619    gcc-9.3.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250618    clang-20
x86_64      buildonly-randconfig-001-20250618    gcc-12
x86_64      buildonly-randconfig-001-20250619    gcc-12
x86_64      buildonly-randconfig-002-20250618    clang-20
x86_64      buildonly-randconfig-002-20250618    gcc-12
x86_64      buildonly-randconfig-002-20250619    gcc-12
x86_64      buildonly-randconfig-003-20250618    gcc-12
x86_64      buildonly-randconfig-003-20250619    gcc-12
x86_64      buildonly-randconfig-004-20250618    clang-20
x86_64      buildonly-randconfig-004-20250618    gcc-12
x86_64      buildonly-randconfig-004-20250619    gcc-12
x86_64      buildonly-randconfig-005-20250618    clang-20
x86_64      buildonly-randconfig-005-20250618    gcc-12
x86_64      buildonly-randconfig-005-20250619    gcc-12
x86_64      buildonly-randconfig-006-20250618    gcc-12
x86_64      buildonly-randconfig-006-20250619    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250618    gcc-12
x86_64                randconfig-002-20250618    gcc-12
x86_64                randconfig-003-20250618    gcc-12
x86_64                randconfig-004-20250618    gcc-12
x86_64                randconfig-005-20250618    gcc-12
x86_64                randconfig-006-20250618    gcc-12
x86_64                randconfig-007-20250618    gcc-12
x86_64                randconfig-008-20250618    gcc-12
x86_64                randconfig-071-20250618    clang-20
x86_64                randconfig-072-20250618    clang-20
x86_64                randconfig-073-20250618    clang-20
x86_64                randconfig-074-20250618    clang-20
x86_64                randconfig-075-20250618    clang-20
x86_64                randconfig-076-20250618    clang-20
x86_64                randconfig-077-20250618    clang-20
x86_64                randconfig-078-20250618    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250618    gcc-13.3.0
xtensa                randconfig-001-20250618    gcc-15.1.0
xtensa                randconfig-001-20250619    gcc-9.3.0
xtensa                randconfig-002-20250618    gcc-11.5.0
xtensa                randconfig-002-20250618    gcc-15.1.0
xtensa                randconfig-002-20250619    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

