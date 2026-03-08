Return-Path: <linux-rdma+bounces-17732-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uK9/CaP5rWl2+QEAu9opvQ
	(envelope-from <linux-rdma+bounces-17732-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 23:35:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA36232756
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 23:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C9E730058ED
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 22:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C4C311946;
	Sun,  8 Mar 2026 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KyoLRVD/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D88F349B17
	for <linux-rdma@vger.kernel.org>; Sun,  8 Mar 2026 22:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773009311; cv=none; b=MMTrCxGlNijPodk3NFZ4FZDFEOBrhBuwNoSm22PJDMwXbsdszkJg8tUv+CEaloxi4AMJLlMI2neEKGGjC1UEeRafPf2RIdZqSQzL88uXgkhhBcXqQhzOiRadeZ3HQnyutfqMwBLYWwoSAONkm81/PEvRTPg3LJrI87GExDpgvvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773009311; c=relaxed/simple;
	bh=mLZ6PtMGQlvhbIinlv3adMn5YbhNdsfX6rXb6cokP50=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ih9gkCGKdTjwJFvmGBo9kQ+pzcFkoL/JjV+YMC+bA+OC9gt+iYRS2jq5Cq+21LWxAtpGn8GdWDEAYioDfR8+z75XlQ857a6gNl0iSPCSijRP09uOFILQTnWEO+dmEWNuh0sbuUA1q/SUQQD7QnE2ZAs074KVPy2BE6KVz2WvwJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KyoLRVD/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773009307; x=1804545307;
  h=date:from:to:cc:subject:message-id;
  bh=mLZ6PtMGQlvhbIinlv3adMn5YbhNdsfX6rXb6cokP50=;
  b=KyoLRVD/+uxVr8dBnDrJpdvf7Fc/KyYlrRyuZ5c7zm2mN9bhgS1zjvEe
   iJ4xD8BVykl5ipFIzG7D7qolesiJWaZYanncLAGUYXQBT0okn4+Viaobr
   5gqr3pAXN41bXccCQAr+g1T+hgVXbWkVLACcG2wsu9Gi5Sm2V25igW4nB
   PAM97b6ejoz0iE0qgW38qFLDmU8+dfKC/0dlOEX6J8rXCi3eLnkx3LGcq
   MjQdmyRMc1gf41PbemriEJuWRXhV6JZrXzmRHLNrsnxjLHZE/IF/hzIEQ
   bJRNYHBn/Wk+u+Q+H83bihkq5YqbH3Hueh64UcjyPsp3sy6iPqWHViPNz
   Q==;
X-CSE-ConnectionGUID: qkDEKvJRQCyzy2IXYPZrRw==
X-CSE-MsgGUID: gQybgMCpSdOBH/vme5JQ0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="74003160"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="74003160"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 15:35:07 -0700
X-CSE-ConnectionGUID: 5v0E/WERTpWK3oHrWvJNAw==
X-CSE-MsgGUID: VVtV/gW/SluAIInT2PdGXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="217662613"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 08 Mar 2026 15:35:04 -0700
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vzMiE-000000003R6-0yDe;
	Sun, 08 Mar 2026 22:35:02 +0000
Date: Mon, 09 Mar 2026 06:34:23 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 eb15cffa15201bd53d1ac296645aa2bc5f726841
Message-ID: <202603090608.NP5BdkK1-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: BEA36232756
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17732-lists,linux-rdma=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,lists];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:dkim,intel.com:mid]
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: eb15cffa15201bd53d1ac296645aa2bc5f726841  RDMA/bnxt_re: Support application specific CQs

elapsed time: 729m

configs tested: 257
configs skipped: 3

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
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260308    gcc-11.5.0
arc                   randconfig-001-20260308    gcc-8.5.0
arc                   randconfig-002-20260308    gcc-10.5.0
arc                   randconfig-002-20260308    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260308    clang-17
arm                   randconfig-001-20260308    gcc-8.5.0
arm                   randconfig-002-20260308    gcc-8.5.0
arm                   randconfig-003-20260308    clang-18
arm                   randconfig-003-20260308    gcc-8.5.0
arm                   randconfig-004-20260308    clang-23
arm                   randconfig-004-20260308    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260308    clang-23
arm64                 randconfig-002-20260308    clang-23
arm64                 randconfig-003-20260308    clang-23
arm64                 randconfig-004-20260308    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260308    clang-23
csky                  randconfig-002-20260308    clang-23
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260308    clang-23
hexagon               randconfig-002-20260308    clang-16
hexagon               randconfig-002-20260308    clang-23
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260308    clang-20
i386        buildonly-randconfig-002-20260308    clang-20
i386        buildonly-randconfig-003-20260308    clang-20
i386        buildonly-randconfig-004-20260308    clang-20
i386        buildonly-randconfig-005-20260308    clang-20
i386        buildonly-randconfig-006-20260308    clang-20
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260308    gcc-13
i386                  randconfig-001-20260308    gcc-14
i386                  randconfig-001-20260309    gcc-14
i386                  randconfig-002-20260308    gcc-14
i386                  randconfig-002-20260309    gcc-14
i386                  randconfig-003-20260308    gcc-14
i386                  randconfig-003-20260309    gcc-14
i386                  randconfig-004-20260308    clang-20
i386                  randconfig-004-20260308    gcc-14
i386                  randconfig-004-20260309    gcc-14
i386                  randconfig-005-20260308    clang-20
i386                  randconfig-005-20260308    gcc-14
i386                  randconfig-005-20260309    gcc-14
i386                  randconfig-006-20260308    gcc-14
i386                  randconfig-006-20260309    gcc-14
i386                  randconfig-007-20260308    clang-20
i386                  randconfig-007-20260308    gcc-14
i386                  randconfig-007-20260309    gcc-14
i386                  randconfig-011-20260308    clang-20
i386                  randconfig-011-20260308    gcc-14
i386                  randconfig-012-20260308    clang-20
i386                  randconfig-013-20260308    clang-20
i386                  randconfig-013-20260308    gcc-14
i386                  randconfig-014-20260308    clang-20
i386                  randconfig-014-20260308    gcc-14
i386                  randconfig-015-20260308    clang-20
i386                  randconfig-015-20260308    gcc-14
i386                  randconfig-016-20260308    clang-20
i386                  randconfig-017-20260308    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260308    clang-19
loongarch             randconfig-001-20260308    clang-23
loongarch             randconfig-002-20260308    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                         amcore_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260308    clang-23
nios2                 randconfig-001-20260308    gcc-11.5.0
nios2                 randconfig-002-20260308    clang-23
nios2                 randconfig-002-20260308    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260308    gcc-8.5.0
parisc                randconfig-002-20260308    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260308    clang-23
powerpc               randconfig-001-20260308    gcc-8.5.0
powerpc               randconfig-002-20260308    gcc-8.5.0
powerpc                     tqm8555_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260308    clang-23
powerpc64             randconfig-001-20260308    gcc-8.5.0
powerpc64             randconfig-002-20260308    clang-23
powerpc64             randconfig-002-20260308    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260308    gcc-12.5.0
riscv                 randconfig-001-20260308    gcc-14.3.0
riscv                 randconfig-002-20260308    clang-23
riscv                 randconfig-002-20260308    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260308    gcc-12.5.0
s390                  randconfig-002-20260308    gcc-12.5.0
s390                  randconfig-002-20260308    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260308    gcc-12.5.0
sh                    randconfig-001-20260308    gcc-15.2.0
sh                    randconfig-002-20260308    gcc-12.5.0
sh                    randconfig-002-20260308    gcc-15.2.0
sh                            titan_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260308    gcc-15.2.0
sparc                 randconfig-001-20260308    gcc-8.5.0
sparc                 randconfig-002-20260308    gcc-11.5.0
sparc                 randconfig-002-20260308    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260308    clang-20
sparc64               randconfig-001-20260308    gcc-15.2.0
sparc64               randconfig-002-20260308    gcc-15.2.0
sparc64               randconfig-002-20260308    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260308    gcc-14
um                    randconfig-001-20260308    gcc-15.2.0
um                    randconfig-002-20260308    gcc-14
um                    randconfig-002-20260308    gcc-15.2.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260308    clang-20
x86_64      buildonly-randconfig-002-20260308    clang-20
x86_64      buildonly-randconfig-003-20260308    clang-20
x86_64      buildonly-randconfig-003-20260308    gcc-14
x86_64      buildonly-randconfig-004-20260308    clang-20
x86_64      buildonly-randconfig-005-20260308    clang-20
x86_64      buildonly-randconfig-005-20260308    gcc-14
x86_64      buildonly-randconfig-006-20260308    clang-20
x86_64      buildonly-randconfig-006-20260308    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260308    gcc-14
x86_64                randconfig-002-20260308    gcc-14
x86_64                randconfig-003-20260308    clang-20
x86_64                randconfig-003-20260308    gcc-14
x86_64                randconfig-004-20260308    gcc-14
x86_64                randconfig-005-20260308    clang-20
x86_64                randconfig-005-20260308    gcc-14
x86_64                randconfig-006-20260308    gcc-14
x86_64                randconfig-011-20260308    clang-20
x86_64                randconfig-011-20260308    gcc-14
x86_64                randconfig-012-20260308    clang-20
x86_64                randconfig-012-20260308    gcc-14
x86_64                randconfig-013-20260308    clang-20
x86_64                randconfig-013-20260308    gcc-14
x86_64                randconfig-014-20260308    clang-20
x86_64                randconfig-014-20260308    gcc-14
x86_64                randconfig-015-20260308    clang-20
x86_64                randconfig-016-20260308    clang-20
x86_64                randconfig-071-20260308    clang-20
x86_64                randconfig-071-20260308    gcc-14
x86_64                randconfig-072-20260308    clang-20
x86_64                randconfig-072-20260308    gcc-14
x86_64                randconfig-073-20260308    clang-20
x86_64                randconfig-073-20260308    gcc-14
x86_64                randconfig-074-20260308    gcc-14
x86_64                randconfig-075-20260308    clang-20
x86_64                randconfig-075-20260308    gcc-14
x86_64                randconfig-076-20260308    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260308    gcc-11.5.0
xtensa                randconfig-001-20260308    gcc-15.2.0
xtensa                randconfig-002-20260308    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

