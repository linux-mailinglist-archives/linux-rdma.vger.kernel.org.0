Return-Path: <linux-rdma+bounces-21824-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5exYC7R5ImpVYAEAu9opvQ
	(envelope-from <linux-rdma+bounces-21824-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 09:24:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75959645EE9
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 09:24:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=m6pETFf9;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21824-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21824-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABF4A3152FFC
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 07:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE284657DD;
	Fri,  5 Jun 2026 07:11:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE75D4508EB
	for <linux-rdma@vger.kernel.org>; Fri,  5 Jun 2026 07:11:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780643488; cv=none; b=Iu9LvwM4dhvANLQElfPDsIoQsCEMgoWOlAPkR4nbsdugLhlNHGSS6KGjKacA6Ty2+F6bMr+JnpL/egZmYxX/j6ZC7SHWHqeYEid5zOwAxP7piYwPqVeAmOWDBa8bIV5TeBrRuAJCjl0HztLX1Q67viFEgMR6bvQinWWLADCCm0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780643488; c=relaxed/simple;
	bh=qNN3CD+kJNfKIHFAHrF1GSKd9nRBZMFpgl7gfxcN+ok=;
	h=Date:From:To:Cc:Subject:Message-ID; b=haimFHVgeSDzAW8KTSeZnBe/uHursXAFwvwZxELVzxORHdFx47Bm8f7fSrFIh1X8gOomyFTUnFIea5VMlUHu29Z6kqul1XykRgku5rvZPUT8NcRuIB8k1InzojHZuswl2n6M7aaqOvq5hNCiKe+3UlbeeVgZ6Kft8Iwu784KhSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m6pETFf9; arc=none smtp.client-ip=198.175.65.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780643488; x=1812179488;
  h=date:from:to:cc:subject:message-id;
  bh=qNN3CD+kJNfKIHFAHrF1GSKd9nRBZMFpgl7gfxcN+ok=;
  b=m6pETFf9xW4P30+/Jv3PGHbxCEIfRlJ5dG84UUXEVYIf1CmL6XBlXrzX
   mB05L6aZmsHLb4sj0PwhOQSgmoDPPuELz4O/akcw4yLJN++ReH9hykHUO
   7ylkqZCQAygsjFpn+rN64/1x8ATShHzWAiDFpxmMwkA/F9727Gmleg7IQ
   ncXZ/8zcP+LimL3J869xXL3D04pb4VZpP+T5OaBo+e3uCZDBMxwlLu9cu
   /wxttNq7R4pcCYBKWAAbxTVtZBFSyGY8onD3UZP7bd4GVCXRc60ASb5+I
   sphfMJrrEmDHNnTSLPJnLfWTZ5cj9WSVyBCekaNY8cQrFBdClwBpkUsda
   g==;
X-CSE-ConnectionGUID: 28GQCTa7RiiObAhXIgYfEQ==
X-CSE-MsgGUID: pCuF26vtSDejddOnCxwvQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81536361"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="81536361"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 00:11:21 -0700
X-CSE-ConnectionGUID: RJay+ybrRVuPk/Ub3cKrBg==
X-CSE-MsgGUID: Vs7/R42tRWW9dxSYnYcBlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="243940156"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 05 Jun 2026 00:11:19 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wVOi4-00000000FeW-070z;
	Fri, 05 Jun 2026 07:11:16 +0000
Date: Fri, 05 Jun 2026 15:10:36 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:for-rc] BUILD SUCCESS
 323c98a4ff06aa28114f2bf658fb43eb3b536bbc
Message-ID: <202606051527.lJwZtp1k-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21824-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:dledford@redhat.com,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:from_mime,intel.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75959645EE9

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: 323c98a4ff06aa28114f2bf658fb43eb3b536bbc  RDMA/core: Validate cpu_id against nr_cpu_ids in DMAH alloc

elapsed time: 2063m

configs tested: 166
configs skipped: 19

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-16.1.0
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260604    gcc-13.4.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260604    gcc-11.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260604    gcc-11.5.0
arm                            randconfig-002    gcc-11.5.0
arm                   randconfig-002-20260604    gcc-8.5.0
arm                            randconfig-003    clang-20
arm                   randconfig-003-20260604    clang-23
arm                            randconfig-004    gcc-14.3.0
arm                   randconfig-004-20260604    clang-23
arm64                            alldefconfig    gcc-16.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260604    clang-23
arm64                 randconfig-002-20260604    clang-23
arm64                 randconfig-003-20260604    clang-20
arm64                 randconfig-004-20260604    clang-23
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260604    gcc-16.1.0
csky                  randconfig-002-20260604    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260604    clang-23
hexagon               randconfig-002-20260604    clang-16
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260604    clang-22
i386        buildonly-randconfig-002-20260604    gcc-14
i386        buildonly-randconfig-003-20260604    gcc-14
i386        buildonly-randconfig-004-20260604    clang-22
i386        buildonly-randconfig-005-20260604    gcc-14
i386        buildonly-randconfig-006-20260604    clang-22
i386                                defconfig    clang-22
i386                  randconfig-001-20260604    clang-20
i386                  randconfig-002-20260604    clang-20
i386                  randconfig-003-20260604    gcc-13
i386                  randconfig-004-20260604    clang-20
i386                  randconfig-005-20260604    clang-20
i386                  randconfig-006-20260604    clang-20
i386                  randconfig-007-20260604    clang-20
i386                           randconfig-011    clang-22
i386                  randconfig-011-20260604    gcc-14
i386                           randconfig-012    clang-22
i386                  randconfig-012-20260604    gcc-14
i386                           randconfig-013    gcc-14
i386                  randconfig-013-20260604    gcc-14
i386                           randconfig-014    clang-22
i386                  randconfig-014-20260604    gcc-12
i386                           randconfig-015    gcc-14
i386                  randconfig-015-20260604    clang-22
i386                           randconfig-016    gcc-14
i386                  randconfig-016-20260604    clang-22
i386                           randconfig-017    gcc-14
i386                  randconfig-017-20260604    clang-22
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260604    clang-23
loongarch             randconfig-002-20260604    gcc-12.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-16.1.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260604    gcc-11.5.0
nios2                 randconfig-002-20260604    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260604    gcc-11.5.0
parisc                randconfig-002-20260604    gcc-13.4.0
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260604    clang-23
powerpc               randconfig-002-20260604    clang-23
powerpc64             randconfig-001-20260604    clang-23
powerpc64             randconfig-002-20260604    clang-18
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260604    clang-23
riscv                 randconfig-002-20260604    clang-16
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-18
s390                  randconfig-001-20260604    clang-23
s390                  randconfig-002-20260604    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-16.1.0
sh                    randconfig-001-20260604    gcc-16.1.0
sh                    randconfig-002-20260604    gcc-16.1.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260604    gcc-13.4.0
sparc                 randconfig-002-20260604    gcc-11.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-23
sparc64               randconfig-001-20260604    gcc-9.5.0
sparc64               randconfig-002-20260604    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260604    clang-23
um                    randconfig-002-20260604    clang-23
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260604    gcc-14
x86_64      buildonly-randconfig-002-20260604    clang-20
x86_64      buildonly-randconfig-003-20260604    gcc-14
x86_64      buildonly-randconfig-004-20260604    clang-20
x86_64      buildonly-randconfig-005-20260604    gcc-13
x86_64      buildonly-randconfig-006-20260604    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260604    clang-22
x86_64                randconfig-002-20260604    gcc-14
x86_64                randconfig-003-20260604    clang-22
x86_64                randconfig-004-20260604    clang-22
x86_64                randconfig-005-20260604    clang-22
x86_64                randconfig-006-20260604    gcc-14
x86_64                randconfig-071-20260604    clang-22
x86_64                randconfig-072-20260604    clang-22
x86_64                randconfig-073-20260604    clang-22
x86_64                randconfig-074-20260604    clang-22
x86_64                randconfig-075-20260604    clang-22
x86_64                randconfig-076-20260604    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260604    gcc-13.4.0
xtensa                randconfig-002-20260604    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

