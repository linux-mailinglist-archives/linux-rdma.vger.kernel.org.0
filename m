Return-Path: <linux-rdma+bounces-13943-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55010BEF57F
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Oct 2025 07:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF90189778E
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Oct 2025 05:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501342820A4;
	Mon, 20 Oct 2025 05:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N8/zuhzX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198642AD3C
	for <linux-rdma@vger.kernel.org>; Mon, 20 Oct 2025 05:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760936786; cv=none; b=iWtnYZOKvZzTsJVfYW8HMTrujw7ttju+ZXHLT3tmAJlHNhomBcDThUehnyUnIy0eB6Z1DJo4Gsj5fLgmcYGXWyLwtV6ZBdp3p6YPuNhChp85n722SWwWzAlRmQaJhZ09i4TO0OSjCH+8Fj9Ngq2QVPOw/ElJgsqtNLCy6zCPMzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760936786; c=relaxed/simple;
	bh=A/ga8mXjgrnqs7BYb0uldnewDrnu5tHrL7+4bYxl93c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AhVJMp0D0L8Uno4TRvIc1xxgMnt46PZMnYcp1tj/LWewch0mbNLmnqry3RInskB5Vqlyj9UFFUgtBy2K4fi/NK7UOC/9clvv9ZVQVk8dgXx9dkRSfS2YhHLWH7pOZkWtOn6xj9u8NYTBbll6kQr4vXDCfnDjYRWf1nUAu81StQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N8/zuhzX; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760936784; x=1792472784;
  h=date:from:to:cc:subject:message-id;
  bh=A/ga8mXjgrnqs7BYb0uldnewDrnu5tHrL7+4bYxl93c=;
  b=N8/zuhzXTcc2v4jxzJSwnAofN/eX7r5EMDfp2tv3AvkOd6x9xVEvRJfS
   e8GTpF3KCm1semUrJvqu8It+mcfnRhVn76GWpfNptj8OXkI6D3FG2RmnQ
   ML4/imnk4pL2p0x1g/6E9dG7Sec6SQC8IUlWugt/v+IyUJdzxc4j2Z2FW
   OXmu249kMixfzZE1ezqwuypfxtUTalB3cjcXbuZXvcr1sQ5pQLmONtPIK
   TnKS9RvBTjTm7GF3Pj+k0mCcU/lPpz3VXgt0BF6c0/KiqIIPlboq5pru2
   Qt8bQwO3RQwXYgDQWcDcts2RpZOWp/7bS79Qd5u0FP8ScYGcoTE57csfI
   g==;
X-CSE-ConnectionGUID: NZqm3ew4QASzRAZK8XXRGw==
X-CSE-MsgGUID: +88WWDp3S1+DBj4vIQm38w==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="80677580"
X-IronPort-AV: E=Sophos;i="6.19,241,1754982000"; 
   d="scan'208";a="80677580"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 22:06:23 -0700
X-CSE-ConnectionGUID: /qvqwRX3TcCayZUNUArvgw==
X-CSE-MsgGUID: lkCCD5oCTLicqgKlofbJlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,241,1754982000"; 
   d="scan'208";a="182384929"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 19 Oct 2025 22:06:21 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vAi60-0009Ub-2R;
	Mon, 20 Oct 2025 05:06:15 +0000
Date: Mon, 20 Oct 2025 13:05:17 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 1511efaca032ed209c04b2af67915a613673865c
Message-ID: <202510201311.eqPTwump-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 1511efaca032ed209c04b2af67915a613673865c  RDMA/rxe: Remove redundant assignment to variable page_offset

elapsed time: 999m

configs tested: 202
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20251019    gcc-8.5.0
arc                   randconfig-002-20251019    gcc-13.4.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                         at91_dt_defconfig    clang-22
arm                         bcm2835_defconfig    clang-22
arm                                 defconfig    clang-19
arm                          ixp4xx_defconfig    gcc-15.1.0
arm                          pxa3xx_defconfig    gcc-11.5.0
arm                   randconfig-001-20251019    clang-22
arm                   randconfig-002-20251019    gcc-11.5.0
arm                   randconfig-003-20251019    clang-22
arm                   randconfig-004-20251019    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251019    gcc-13.4.0
arm64                 randconfig-002-20251019    clang-18
arm64                 randconfig-003-20251019    gcc-13.4.0
arm64                 randconfig-004-20251019    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20251019    gcc-13.4.0
csky                  randconfig-002-20251019    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251019    clang-20
hexagon               randconfig-002-20251019    clang-17
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251019    clang-20
i386        buildonly-randconfig-002-20251019    gcc-14
i386        buildonly-randconfig-003-20251019    gcc-14
i386        buildonly-randconfig-004-20251019    clang-20
i386        buildonly-randconfig-005-20251019    gcc-13
i386        buildonly-randconfig-006-20251019    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251020    gcc-14
i386                  randconfig-002-20251020    gcc-14
i386                  randconfig-003-20251020    gcc-14
i386                  randconfig-004-20251020    gcc-14
i386                  randconfig-005-20251020    gcc-14
i386                  randconfig-006-20251020    gcc-14
i386                  randconfig-007-20251020    gcc-14
i386                  randconfig-011-20251020    clang-20
i386                  randconfig-012-20251020    clang-20
i386                  randconfig-013-20251020    clang-20
i386                  randconfig-014-20251020    clang-20
i386                  randconfig-015-20251020    clang-20
i386                  randconfig-016-20251020    clang-20
i386                  randconfig-017-20251020    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251019    clang-18
loongarch             randconfig-002-20251019    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                        m5407c3_defconfig    gcc-11.5.0
m68k                          sun3x_defconfig    gcc-11.5.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          ath25_defconfig    clang-22
mips                       bmips_be_defconfig    gcc-15.1.0
nios2                         3c120_defconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251019    gcc-8.5.0
nios2                 randconfig-002-20251019    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-32bit_defconfig    gcc-15.1.0
parisc                randconfig-001-20251019    gcc-15.1.0
parisc                randconfig-002-20251019    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                 canyonlands_defconfig    clang-22
powerpc                     kmeter1_defconfig    gcc-11.5.0
powerpc                   lite5200b_defconfig    clang-22
powerpc                 mpc832x_rdb_defconfig    gcc-11.5.0
powerpc                      pcm030_defconfig    clang-22
powerpc               randconfig-001-20251019    clang-17
powerpc               randconfig-002-20251019    gcc-10.5.0
powerpc               randconfig-003-20251019    gcc-11.5.0
powerpc64             randconfig-001-20251019    gcc-8.5.0
powerpc64             randconfig-002-20251019    clang-16
powerpc64             randconfig-003-20251019    gcc-15.1.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20251019    clang-19
riscv                 randconfig-002-20251019    gcc-11.5.0
s390                             alldefconfig    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251019    gcc-8.5.0
s390                  randconfig-002-20251019    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                ecovec24-romimage_defconfig    clang-22
sh                          kfr2r09_defconfig    gcc-11.5.0
sh                          r7785rp_defconfig    gcc-11.5.0
sh                    randconfig-001-20251019    gcc-15.1.0
sh                    randconfig-002-20251019    gcc-15.1.0
sh                        sh7763rdp_defconfig    clang-22
sh                   sh7770_generic_defconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251019    gcc-11.5.0
sparc                 randconfig-002-20251019    gcc-13.4.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251019    gcc-8.5.0
sparc64               randconfig-002-20251019    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251019    gcc-13
um                    randconfig-002-20251019    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251019    clang-20
x86_64      buildonly-randconfig-002-20251019    gcc-13
x86_64      buildonly-randconfig-003-20251019    clang-20
x86_64      buildonly-randconfig-004-20251019    gcc-14
x86_64      buildonly-randconfig-005-20251019    clang-20
x86_64      buildonly-randconfig-006-20251019    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251020    clang-20
x86_64                randconfig-002-20251020    clang-20
x86_64                randconfig-003-20251020    clang-20
x86_64                randconfig-004-20251020    clang-20
x86_64                randconfig-005-20251020    clang-20
x86_64                randconfig-006-20251020    clang-20
x86_64                randconfig-007-20251020    clang-20
x86_64                randconfig-008-20251020    clang-20
x86_64                randconfig-071-20251020    clang-20
x86_64                randconfig-072-20251020    clang-20
x86_64                randconfig-073-20251020    clang-20
x86_64                randconfig-074-20251020    clang-20
x86_64                randconfig-075-20251020    clang-20
x86_64                randconfig-076-20251020    clang-20
x86_64                randconfig-077-20251020    clang-20
x86_64                randconfig-078-20251020    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251019    gcc-14.3.0
xtensa                randconfig-002-20251019    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

