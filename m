Return-Path: <linux-rdma+bounces-11719-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E31AEB3F3
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 12:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05CAC1889075
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 10:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3822D8777;
	Fri, 27 Jun 2025 10:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D7cq/55B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87332D321D
	for <linux-rdma@vger.kernel.org>; Fri, 27 Jun 2025 10:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019045; cv=none; b=bPVEnx4VOQROdi63gXWOjaORAgknQM46oWatnUeZx+g9fyboNLdlmDkuHr8YDgcbw07AYz5Buk3djr/qdFSi92rSch+z+LGSBFwb2c2al9ozcAvgDdCET+RRz9PpT86v1RI98+DlI9gM2TQi3KzTh+Vr7eOiz7iRrYz6nx2Ctjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019045; c=relaxed/simple;
	bh=wJz6DSKXS+ShgL1baqlJSiOhCjNQey08/Vq3WmwNJsk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FYP7Ej+VZlzkdAMB+XUNF1DPt2jt2qZSbViVU0pSVAJq6CawJkx2yshT0aiM8Aqyjv7rTdp5wkWe/jIOY4mbppUzkpjFdfJU4hAoM4PRrCkV/awmfJogP0aGrPt7haTUdJJMCUbe4GdJ7as6Fk03uFWRqCvYVsz+1r9CnAjA2x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D7cq/55B; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751019043; x=1782555043;
  h=date:from:to:cc:subject:message-id;
  bh=wJz6DSKXS+ShgL1baqlJSiOhCjNQey08/Vq3WmwNJsk=;
  b=D7cq/55B/bP3NobBSNKI93j6xtQhkc2c4ptzklHa0ORACaBlCAq44UtU
   ic8uWl5+KU4eT2DhnozOfP6ScP59nl1zB5iisiKomEL6YrMjbRV0ZyyxP
   XViWk06K6ok0nypCQgDQaaV00lI9zM4oqse0RdY/IzPW5OJjrKEYqE+on
   ng6mhTCYYOnBk4IIT2IZ/X3rFNKykX88deKxs9GCWU8cq7Pq715EdKtRN
   K5I/umA/huTSwfDXby6ajrKXDQJRKmo4bEbB2SxWMXCu5mWaShju6zuT3
   Zr0DbkrTEAJ3DkNXR2F+q9j667QjBa3cwS7S0wmOU4an/K9l8CbnQNzB8
   w==;
X-CSE-ConnectionGUID: 0WHrf4CmTf2eelrXUf39hw==
X-CSE-MsgGUID: GdqrJa3wToCen//31gUyAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="64683599"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="64683599"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 03:10:43 -0700
X-CSE-ConnectionGUID: 1A03TU+AQXuitPU0NHkcrQ==
X-CSE-MsgGUID: AnbWIBiNShSeGrWWS9zJbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="152383470"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 27 Jun 2025 03:10:42 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uV62Z-000W3L-2Z;
	Fri, 27 Jun 2025 10:10:39 +0000
Date: Fri, 27 Jun 2025 18:09:56 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 19564a8576ac847ec981207292b500efbbbfaf7b
Message-ID: <202506271846.PzN3qexI-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 19564a8576ac847ec981207292b500efbbbfaf7b  RDMA/rxe: Fix a couple IS_ERR() vs NULL bugs

elapsed time: 1446m

configs tested: 164
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                          axs103_defconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                 nsimosci_hs_smp_defconfig    gcc-15.1.0
arc                   randconfig-001-20250626    gcc-12.4.0
arc                   randconfig-001-20250627    gcc-8.5.0
arc                   randconfig-002-20250626    gcc-13.3.0
arc                   randconfig-002-20250627    gcc-12.4.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                         at91_dt_defconfig    clang-21
arm                                 defconfig    clang-21
arm                      integrator_defconfig    clang-21
arm                   randconfig-001-20250626    clang-21
arm                   randconfig-001-20250627    gcc-15.1.0
arm                   randconfig-002-20250626    clang-20
arm                   randconfig-002-20250627    gcc-10.5.0
arm                   randconfig-003-20250626    gcc-10.5.0
arm                   randconfig-003-20250627    clang-21
arm                   randconfig-004-20250626    clang-21
arm                   randconfig-004-20250627    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250626    clang-21
arm64                 randconfig-001-20250627    clang-17
arm64                 randconfig-002-20250626    clang-17
arm64                 randconfig-002-20250627    gcc-10.5.0
arm64                 randconfig-003-20250626    gcc-8.5.0
arm64                 randconfig-003-20250627    gcc-12.3.0
arm64                 randconfig-004-20250626    clang-21
arm64                 randconfig-004-20250627    clang-19
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250627    gcc-15.1.0
csky                  randconfig-002-20250627    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250627    clang-21
hexagon               randconfig-002-20250627    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250626    clang-20
i386        buildonly-randconfig-001-20250627    gcc-12
i386        buildonly-randconfig-002-20250626    clang-20
i386        buildonly-randconfig-002-20250627    gcc-12
i386        buildonly-randconfig-003-20250626    clang-20
i386        buildonly-randconfig-003-20250627    gcc-12
i386        buildonly-randconfig-004-20250626    clang-20
i386        buildonly-randconfig-004-20250627    gcc-12
i386        buildonly-randconfig-005-20250626    clang-20
i386        buildonly-randconfig-005-20250627    clang-20
i386        buildonly-randconfig-006-20250626    clang-20
i386        buildonly-randconfig-006-20250627    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250627    gcc-15.1.0
loongarch             randconfig-002-20250627    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                      bmips_stb_defconfig    clang-21
mips                   sb1250_swarm_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250627    gcc-8.5.0
nios2                 randconfig-002-20250627    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-32bit_defconfig    gcc-15.1.0
parisc                randconfig-001-20250627    gcc-9.3.0
parisc                randconfig-002-20250627    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                        cell_defconfig    gcc-15.1.0
powerpc                       eiger_defconfig    clang-21
powerpc                   lite5200b_defconfig    clang-21
powerpc                 mpc834x_itx_defconfig    clang-16
powerpc                 mpc836x_rdk_defconfig    clang-21
powerpc                     ppa8548_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250627    gcc-15.1.0
powerpc               randconfig-002-20250627    clang-21
powerpc               randconfig-003-20250627    gcc-15.1.0
powerpc64             randconfig-001-20250627    gcc-12.4.0
powerpc64             randconfig-002-20250627    gcc-10.5.0
powerpc64             randconfig-003-20250627    gcc-8.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                    nommu_virt_defconfig    clang-21
riscv                 randconfig-001-20250627    gcc-8.5.0
riscv                 randconfig-002-20250627    gcc-13.3.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250627    clang-21
s390                  randconfig-002-20250627    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250627    gcc-9.3.0
sh                    randconfig-002-20250627    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250627    gcc-11.5.0
sparc                 randconfig-002-20250627    gcc-8.5.0
sparc                       sparc32_defconfig    gcc-15.1.0
sparc64                             defconfig    gcc-15.1.0
sparc64               randconfig-001-20250627    gcc-11.5.0
sparc64               randconfig-002-20250627    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250627    gcc-12
um                    randconfig-002-20250627    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250626    clang-20
x86_64      buildonly-randconfig-001-20250627    clang-20
x86_64      buildonly-randconfig-002-20250626    clang-20
x86_64      buildonly-randconfig-002-20250627    clang-20
x86_64      buildonly-randconfig-003-20250626    clang-20
x86_64      buildonly-randconfig-003-20250627    clang-20
x86_64      buildonly-randconfig-004-20250626    clang-20
x86_64      buildonly-randconfig-004-20250627    clang-20
x86_64      buildonly-randconfig-005-20250626    clang-20
x86_64      buildonly-randconfig-005-20250627    gcc-12
x86_64      buildonly-randconfig-006-20250626    clang-20
x86_64      buildonly-randconfig-006-20250627    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250627    gcc-13.3.0
xtensa                randconfig-002-20250627    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

