Return-Path: <linux-rdma+bounces-20875-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLqcCGeGCmpg2gQAu9opvQ
	(envelope-from <linux-rdma+bounces-20875-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 05:24:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C14A565688
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 05:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B21D23010399
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 03:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7493803D1;
	Mon, 18 May 2026 03:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iXKaTKHK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B8735E937
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 03:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779074659; cv=none; b=UBnMvFUAp2TBovbLcSrk5haqJ60HutO6znWyBRIVD51tyE4btapXsRH/DQ5aGPb6o2vDh9ufHhE7eeW41KOHhAm7PhSWNRZH58u1eN/XZSyfDAQOx24PUJkFqik9LsENptflKehB99QPQYd46ZjDkNjZlwEZEebOvoJvSSkM7v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779074659; c=relaxed/simple;
	bh=9ln9075rvaxNhBEs9QRmd6VsBjKMNNGkZXrrJC+wD0M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=L40LLMK6AEH7fKB+TbVAHk19twJC5bGSadinaLlDn+Y0s+FTtY8Hm6flDD+uzk07hB4ZVN1DazC5KBggqNMItF1JHVC74QZiJSGQJ5tac60/oOCt4S5hn+K8gENA7I3K2ESHqJFSkcPFgZvpI6OfrElmPBv7MyCkUJ6bVT6+Drg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iXKaTKHK; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779074658; x=1810610658;
  h=date:from:to:cc:subject:message-id;
  bh=9ln9075rvaxNhBEs9QRmd6VsBjKMNNGkZXrrJC+wD0M=;
  b=iXKaTKHKqP9wQegpV+D97S9AnLP1g4c/1GJB4/P5qhupowyp0lK9lAhN
   Bjm6FsXqSWAKP+dniLkjMDykYEiJ+oczMJZepHFxjSWodlRTzcozuEJSQ
   vALGQILd6yPeEEWxVnpP/6laesyM9Bf9e+wmzd3RuGRj4R9EEID4K51fB
   QJ4P4wBIQ8twFi98MfEw5S1qrz5quW+k2tCRawSs1Bnz2PEhlO8yO9maV
   mMertpheFP1hrFuca/ZrcmPBATD09c252zif3W51sp1/Z5hLNJdwygfmj
   KjF8rzkj+hQJraHnUWOwQ3HMgMJTackDSYov9/AuhirZnLXwXji3m8Gno
   g==;
X-CSE-ConnectionGUID: WUKJ8AbBQ4aVCXn7VutU1w==
X-CSE-MsgGUID: zQN0dRPmS7KhmiCvku/NYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="83777214"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="83777214"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 20:24:17 -0700
X-CSE-ConnectionGUID: GgAVJsJ7QeC2jpaYkDyAcw==
X-CSE-MsgGUID: rzmaRr1+Qnm3nPyUoCFbCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="236268500"
Received: from lkp-server01.sh.intel.com (HELO d94e5e629b2d) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 17 May 2026 20:24:15 -0700
Received: from kbuild by d94e5e629b2d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wOoaT-000000002J0-1TvA;
	Mon, 18 May 2026 03:24:13 +0000
Date: Mon, 18 May 2026 11:23:20 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 df07e2abe7e8a1e1b3ee1a9b7df561c93fe25877
Message-ID: <202605181109.2eVgPf2q-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 2C14A565688
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20875-lists,linux-rdma=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,lists];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: df07e2abe7e8a1e1b3ee1a9b7df561c93fe25877  RDMA/rtrs: Fix use-after-free in path file creation cleanup

elapsed time: 760m

configs tested: 331
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260517    gcc-13.4.0
arc                   randconfig-001-20260518    gcc-8.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260517    gcc-13.4.0
arc                   randconfig-002-20260518    gcc-8.5.0
arm                              alldefconfig    gcc-15.2.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                           h3600_defconfig    gcc-15.2.0
arm                           imxrt_defconfig    clang-23
arm                        neponset_defconfig    gcc-15.2.0
arm                             pxa_defconfig    gcc-15.2.0
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260517    gcc-13.4.0
arm                   randconfig-001-20260518    gcc-8.5.0
arm                            randconfig-002    gcc-8.5.0
arm                   randconfig-002-20260517    gcc-13.4.0
arm                   randconfig-002-20260518    gcc-8.5.0
arm                            randconfig-003    gcc-8.5.0
arm                   randconfig-003-20260517    gcc-13.4.0
arm                   randconfig-003-20260518    gcc-8.5.0
arm                            randconfig-004    gcc-8.5.0
arm                   randconfig-004-20260517    gcc-13.4.0
arm                   randconfig-004-20260518    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                          randconfig-001    clang-23
arm64                 randconfig-001-20260517    clang-23
arm64                 randconfig-001-20260518    clang-23
arm64                 randconfig-001-20260518    gcc-15.2.0
arm64                          randconfig-002    clang-23
arm64                 randconfig-002-20260517    gcc-14.3.0
arm64                 randconfig-002-20260518    clang-23
arm64                 randconfig-002-20260518    gcc-15.2.0
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260517    clang-23
arm64                 randconfig-003-20260518    clang-23
arm64                 randconfig-003-20260518    gcc-15.2.0
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260517    gcc-10.5.0
arm64                 randconfig-004-20260518    clang-23
arm64                 randconfig-004-20260518    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                           randconfig-001    clang-23
csky                  randconfig-001-20260517    gcc-12.5.0
csky                  randconfig-001-20260518    clang-23
csky                  randconfig-001-20260518    gcc-15.2.0
csky                           randconfig-002    clang-23
csky                  randconfig-002-20260517    gcc-12.5.0
csky                  randconfig-002-20260518    clang-23
csky                  randconfig-002-20260518    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260518    gcc-11.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260518    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    clang-20
i386        buildonly-randconfig-001-20260518    clang-20
i386                 buildonly-randconfig-002    clang-20
i386        buildonly-randconfig-002-20260518    clang-20
i386                 buildonly-randconfig-003    clang-20
i386        buildonly-randconfig-003-20260518    clang-20
i386                 buildonly-randconfig-004    clang-20
i386        buildonly-randconfig-004-20260518    clang-20
i386                 buildonly-randconfig-005    clang-20
i386        buildonly-randconfig-005-20260518    clang-20
i386                 buildonly-randconfig-006    clang-20
i386        buildonly-randconfig-006-20260518    clang-20
i386                                defconfig    gcc-15.2.0
i386                           randconfig-001    gcc-14
i386                  randconfig-001-20260517    gcc-14
i386                  randconfig-001-20260518    gcc-14
i386                           randconfig-002    gcc-14
i386                  randconfig-002-20260517    gcc-14
i386                  randconfig-002-20260518    gcc-14
i386                           randconfig-003    gcc-14
i386                  randconfig-003-20260517    gcc-14
i386                  randconfig-003-20260518    gcc-14
i386                           randconfig-004    gcc-14
i386                  randconfig-004-20260517    gcc-14
i386                  randconfig-004-20260518    gcc-14
i386                           randconfig-005    gcc-14
i386                  randconfig-005-20260517    gcc-14
i386                  randconfig-005-20260518    gcc-14
i386                           randconfig-006    gcc-14
i386                  randconfig-006-20260517    gcc-14
i386                  randconfig-006-20260518    gcc-14
i386                           randconfig-007    gcc-14
i386                  randconfig-007-20260517    gcc-14
i386                  randconfig-007-20260518    gcc-14
i386                  randconfig-011-20260518    gcc-14
i386                  randconfig-012-20260518    gcc-14
i386                  randconfig-013-20260518    gcc-14
i386                  randconfig-014-20260518    gcc-14
i386                  randconfig-015-20260518    gcc-14
i386                  randconfig-016-20260518    gcc-14
i386                  randconfig-017-20260518    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260518    gcc-11.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260518    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                           ip30_defconfig    gcc-15.2.0
mips                          rb532_defconfig    clang-18
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-17
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260518    gcc-11.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260518    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-17
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-17
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260517    gcc-8.5.0
parisc                randconfig-001-20260518    clang-23
parisc                randconfig-002-20260517    gcc-8.5.0
parisc                randconfig-002-20260518    clang-23
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-17
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260517    gcc-12.5.0
powerpc               randconfig-001-20260518    clang-23
powerpc               randconfig-002-20260517    gcc-10.5.0
powerpc               randconfig-002-20260518    clang-23
powerpc64             randconfig-001-20260517    clang-23
powerpc64             randconfig-001-20260518    clang-23
powerpc64             randconfig-002-20260517    clang-23
powerpc64             randconfig-002-20260518    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-17
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-15.2.0
riscv                          randconfig-001    gcc-10.5.0
riscv                          randconfig-001    gcc-11.5.0
riscv                 randconfig-001-20260517    gcc-10.5.0
riscv                 randconfig-001-20260518    gcc-11.5.0
riscv                          randconfig-002    gcc-10.5.0
riscv                          randconfig-002    gcc-11.5.0
riscv                 randconfig-002-20260517    gcc-10.5.0
riscv                 randconfig-002-20260518    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-17
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                           randconfig-001    gcc-10.5.0
s390                           randconfig-001    gcc-11.5.0
s390                  randconfig-001-20260517    gcc-10.5.0
s390                  randconfig-001-20260518    gcc-11.5.0
s390                           randconfig-002    gcc-10.5.0
s390                           randconfig-002    gcc-11.5.0
s390                  randconfig-002-20260517    gcc-10.5.0
s390                  randconfig-002-20260518    gcc-11.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-17
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                             randconfig-001    gcc-10.5.0
sh                             randconfig-001    gcc-11.5.0
sh                    randconfig-001-20260517    gcc-10.5.0
sh                    randconfig-001-20260518    gcc-11.5.0
sh                             randconfig-002    gcc-10.5.0
sh                             randconfig-002    gcc-11.5.0
sh                    randconfig-002-20260517    gcc-10.5.0
sh                    randconfig-002-20260518    gcc-11.5.0
sparc                             allnoconfig    clang-17
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260518    gcc-15.2.0
sparc                 randconfig-002-20260518    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260518    gcc-15.2.0
sparc64               randconfig-002-20260518    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260518    gcc-15.2.0
um                    randconfig-002-20260518    gcc-15.2.0
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-17
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260517    gcc-14
x86_64      buildonly-randconfig-001-20260518    gcc-14
x86_64      buildonly-randconfig-002-20260517    gcc-14
x86_64      buildonly-randconfig-002-20260518    gcc-14
x86_64      buildonly-randconfig-003-20260517    gcc-14
x86_64      buildonly-randconfig-003-20260518    gcc-14
x86_64      buildonly-randconfig-004-20260517    gcc-14
x86_64      buildonly-randconfig-004-20260518    gcc-14
x86_64      buildonly-randconfig-005-20260517    gcc-14
x86_64      buildonly-randconfig-005-20260518    gcc-14
x86_64      buildonly-randconfig-006-20260517    gcc-14
x86_64      buildonly-randconfig-006-20260518    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                         randconfig-001    gcc-14
x86_64                randconfig-001-20260517    gcc-14
x86_64                randconfig-001-20260518    gcc-14
x86_64                         randconfig-002    gcc-14
x86_64                randconfig-002-20260517    clang-20
x86_64                randconfig-002-20260518    gcc-14
x86_64                         randconfig-003    clang-20
x86_64                randconfig-003-20260517    gcc-14
x86_64                randconfig-003-20260518    gcc-14
x86_64                         randconfig-004    clang-20
x86_64                randconfig-004-20260517    clang-20
x86_64                randconfig-004-20260518    gcc-14
x86_64                         randconfig-005    gcc-14
x86_64                randconfig-005-20260517    gcc-14
x86_64                randconfig-005-20260518    gcc-14
x86_64                         randconfig-006    clang-20
x86_64                randconfig-006-20260517    clang-20
x86_64                randconfig-006-20260518    gcc-14
x86_64                randconfig-011-20260517    gcc-14
x86_64                randconfig-011-20260518    gcc-14
x86_64                randconfig-012-20260517    gcc-12
x86_64                randconfig-012-20260518    gcc-14
x86_64                randconfig-013-20260517    gcc-14
x86_64                randconfig-013-20260518    gcc-14
x86_64                randconfig-014-20260517    gcc-14
x86_64                randconfig-014-20260518    gcc-14
x86_64                randconfig-015-20260517    clang-20
x86_64                randconfig-015-20260518    gcc-14
x86_64                randconfig-016-20260517    gcc-14
x86_64                randconfig-016-20260518    gcc-14
x86_64                         randconfig-071    gcc-14
x86_64                randconfig-071-20260517    clang-20
x86_64                randconfig-071-20260517    gcc-14
x86_64                randconfig-071-20260518    clang-20
x86_64                         randconfig-072    gcc-14
x86_64                randconfig-072-20260517    clang-20
x86_64                randconfig-072-20260518    clang-20
x86_64                         randconfig-073    clang-20
x86_64                randconfig-073-20260517    clang-20
x86_64                randconfig-073-20260517    gcc-14
x86_64                randconfig-073-20260518    clang-20
x86_64                         randconfig-074    gcc-14
x86_64                randconfig-074-20260517    clang-20
x86_64                randconfig-074-20260518    clang-20
x86_64                         randconfig-075    gcc-13
x86_64                randconfig-075-20260517    clang-20
x86_64                randconfig-075-20260518    clang-20
x86_64                         randconfig-076    clang-20
x86_64                randconfig-076-20260517    clang-20
x86_64                randconfig-076-20260517    gcc-14
x86_64                randconfig-076-20260518    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-17
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260518    gcc-15.2.0
xtensa                randconfig-002-20260518    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

