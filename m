Return-Path: <linux-rdma+bounces-2766-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1F28D7BD4
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 08:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B50C1F2264E
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 06:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A5B2C1BA;
	Mon,  3 Jun 2024 06:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eg/cNWOa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4C72C859
	for <linux-rdma@vger.kernel.org>; Mon,  3 Jun 2024 06:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717397106; cv=none; b=Nnhs+L8v9t2W37z4JZQh+Woh/q5p9cdDQCGX1lhMws856RKVjuMUW+0YDbj0aenQr+eArEuIh8FlZP02GwYvtHj+/cDBB9+Fz8IYWxOkNtGqpnUZsbhqfg0TNsyI8qjyoB+v/OXgM+R7llDWFXj38cIPZV5m5HCgsX+k+pT5oIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717397106; c=relaxed/simple;
	bh=hSBtNH1AKq84uLGm0ZV3vuHGycxMNrNfzNk+/8HFjBc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OSxQDDPTzcxRGZ8hxWCkJ0yPC/x3t5GjjOndzEQP0XwOCy0TZg9jK12keynmWlOfTwAW5JmvRb4sn4uv6ruZqVEb+1PP1pe2XGJTFsuGvGoqt8m/rERdu49xedfXGod1LriVWinDovNPW7pnpiDbpl7Re3TJ8XbCU4niBT2LEa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eg/cNWOa; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717397105; x=1748933105;
  h=date:from:to:cc:subject:message-id;
  bh=hSBtNH1AKq84uLGm0ZV3vuHGycxMNrNfzNk+/8HFjBc=;
  b=Eg/cNWOaS1STVIqdmi0K0Xn7E883kdVoVoVm1Vj+4KRBxrIgQk/THqnK
   hBFkC9YfD1ZudRcgGrnKW1lmpODi1if8/Wt9FWhBrIZOQYPvW9omFJEPA
   FJLAxFhI7y+YNTB/VDY6RCDgR4xdMW1l+y3ILPKyw6qBP4lPsrKSy90DJ
   3vrXVKU2RgdPHPVRtThuav/EzGoYjDCchm3VZSlCNPCVa2102t+sBKk5C
   BYSMR8zdNHW8tMpK9KmQvD2O+IxgJLGdhiXiaZCFR9yArwO6PgI5KR5fx
   vNP6/d5pSoA+8cC7yYllR3rncL31ZFicwDcQ2vNfgrL7hKYJ3tltzABxF
   A==;
X-CSE-ConnectionGUID: lo9epZp+TueLgsK7T4VnZA==
X-CSE-MsgGUID: SZvuRaajRLyVXBEMTG+rTA==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="13999267"
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="13999267"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 23:45:04 -0700
X-CSE-ConnectionGUID: 9gG3dxJ8Tsit8FRqkpXoPQ==
X-CSE-MsgGUID: JU1Fi/P8RYyHgXLEma12IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="36861064"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 02 Jun 2024 23:45:02 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sE1R1-000L7a-35;
	Mon, 03 Jun 2024 06:44:50 +0000
Date: Mon, 03 Jun 2024 14:43:49 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 c8683b995d8aba9d5b4e2368fedad83508882d84
Message-ID: <202406031445.6ZMLVzBv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: c8683b995d8aba9d5b4e2368fedad83508882d84  RDMA/mana_ib: extend query device

elapsed time: 1292m

configs tested: 225
configs skipped: 7

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
arc                   randconfig-001-20240602   gcc  
arc                   randconfig-001-20240603   gcc  
arc                   randconfig-002-20240602   gcc  
arc                   randconfig-002-20240603   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        neponset_defconfig   gcc  
arm                   randconfig-001-20240602   clang
arm                   randconfig-001-20240603   gcc  
arm                   randconfig-002-20240602   clang
arm                   randconfig-002-20240603   gcc  
arm                   randconfig-003-20240602   gcc  
arm                   randconfig-003-20240603   gcc  
arm                   randconfig-004-20240602   clang
arm                   randconfig-004-20240603   gcc  
arm                           stm32_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240602   clang
arm64                 randconfig-001-20240603   gcc  
arm64                 randconfig-002-20240602   gcc  
arm64                 randconfig-002-20240603   gcc  
arm64                 randconfig-003-20240602   clang
arm64                 randconfig-004-20240602   clang
arm64                 randconfig-004-20240603   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240602   gcc  
csky                  randconfig-001-20240603   gcc  
csky                  randconfig-002-20240602   gcc  
csky                  randconfig-002-20240603   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240602   clang
hexagon               randconfig-002-20240602   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240602   clang
i386         buildonly-randconfig-001-20240603   clang
i386         buildonly-randconfig-002-20240602   gcc  
i386         buildonly-randconfig-002-20240603   clang
i386         buildonly-randconfig-003-20240602   clang
i386         buildonly-randconfig-004-20240602   clang
i386         buildonly-randconfig-005-20240602   clang
i386         buildonly-randconfig-006-20240602   clang
i386         buildonly-randconfig-006-20240603   clang
i386                                defconfig   clang
i386                  randconfig-001-20240602   clang
i386                  randconfig-001-20240603   clang
i386                  randconfig-002-20240602   clang
i386                  randconfig-003-20240602   clang
i386                  randconfig-004-20240602   gcc  
i386                  randconfig-004-20240603   clang
i386                  randconfig-005-20240602   clang
i386                  randconfig-005-20240603   clang
i386                  randconfig-006-20240602   clang
i386                  randconfig-011-20240602   clang
i386                  randconfig-011-20240603   clang
i386                  randconfig-012-20240602   clang
i386                  randconfig-012-20240603   clang
i386                  randconfig-013-20240602   clang
i386                  randconfig-013-20240603   clang
i386                  randconfig-014-20240602   gcc  
i386                  randconfig-014-20240603   clang
i386                  randconfig-015-20240602   gcc  
i386                  randconfig-015-20240603   clang
i386                  randconfig-016-20240602   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240602   gcc  
loongarch             randconfig-001-20240603   gcc  
loongarch             randconfig-002-20240602   gcc  
loongarch             randconfig-002-20240603   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240602   gcc  
nios2                 randconfig-001-20240603   gcc  
nios2                 randconfig-002-20240602   gcc  
nios2                 randconfig-002-20240603   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240602   gcc  
parisc                randconfig-001-20240603   gcc  
parisc                randconfig-002-20240602   gcc  
parisc                randconfig-002-20240603   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc                          g5_defconfig   gcc  
powerpc               randconfig-001-20240602   clang
powerpc               randconfig-001-20240603   gcc  
powerpc               randconfig-002-20240602   gcc  
powerpc               randconfig-002-20240603   gcc  
powerpc               randconfig-003-20240602   clang
powerpc               randconfig-003-20240603   gcc  
powerpc64             randconfig-001-20240602   clang
powerpc64             randconfig-001-20240603   gcc  
powerpc64             randconfig-002-20240602   gcc  
powerpc64             randconfig-002-20240603   gcc  
powerpc64             randconfig-003-20240602   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240602   clang
riscv                 randconfig-002-20240602   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240602   gcc  
s390                  randconfig-002-20240602   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                    randconfig-001-20240602   gcc  
sh                    randconfig-001-20240603   gcc  
sh                    randconfig-002-20240602   gcc  
sh                    randconfig-002-20240603   gcc  
sh                           se7750_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240602   gcc  
sparc64               randconfig-001-20240603   gcc  
sparc64               randconfig-002-20240602   gcc  
sparc64               randconfig-002-20240603   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240602   gcc  
um                    randconfig-002-20240602   clang
um                    randconfig-002-20240603   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240602   gcc  
x86_64       buildonly-randconfig-001-20240603   gcc  
x86_64       buildonly-randconfig-002-20240602   clang
x86_64       buildonly-randconfig-002-20240603   gcc  
x86_64       buildonly-randconfig-003-20240602   clang
x86_64       buildonly-randconfig-003-20240603   gcc  
x86_64       buildonly-randconfig-004-20240602   gcc  
x86_64       buildonly-randconfig-005-20240602   clang
x86_64       buildonly-randconfig-006-20240602   clang
x86_64       buildonly-randconfig-006-20240603   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240602   gcc  
x86_64                randconfig-001-20240603   gcc  
x86_64                randconfig-002-20240602   clang
x86_64                randconfig-003-20240602   clang
x86_64                randconfig-004-20240602   gcc  
x86_64                randconfig-004-20240603   gcc  
x86_64                randconfig-005-20240602   clang
x86_64                randconfig-005-20240603   gcc  
x86_64                randconfig-006-20240602   clang
x86_64                randconfig-006-20240603   gcc  
x86_64                randconfig-011-20240602   gcc  
x86_64                randconfig-011-20240603   gcc  
x86_64                randconfig-012-20240602   clang
x86_64                randconfig-012-20240603   gcc  
x86_64                randconfig-013-20240602   clang
x86_64                randconfig-014-20240602   gcc  
x86_64                randconfig-014-20240603   gcc  
x86_64                randconfig-015-20240602   clang
x86_64                randconfig-015-20240603   gcc  
x86_64                randconfig-016-20240602   gcc  
x86_64                randconfig-071-20240602   gcc  
x86_64                randconfig-072-20240602   clang
x86_64                randconfig-073-20240602   gcc  
x86_64                randconfig-074-20240602   clang
x86_64                randconfig-075-20240602   clang
x86_64                randconfig-075-20240603   gcc  
x86_64                randconfig-076-20240602   clang
x86_64                randconfig-076-20240603   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                randconfig-001-20240602   gcc  
xtensa                randconfig-001-20240603   gcc  
xtensa                randconfig-002-20240602   gcc  
xtensa                randconfig-002-20240603   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

