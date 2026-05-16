Return-Path: <linux-rdma+bounces-20803-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HhwPKS7dCGqr8wMAu9opvQ
	(envelope-from <linux-rdma+bounces-20803-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 23:10:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA93255DCAF
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 23:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44F0D3010176
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 21:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7894337A4AB;
	Sat, 16 May 2026 21:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hJYzCd3E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B3A37475E
	for <linux-rdma@vger.kernel.org>; Sat, 16 May 2026 21:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778965802; cv=none; b=JhMAjnSpkMAHi9ZvViqHrD4HzLpSb8YWYkgp7n4hDGpHmowFjgunUu2FIq5qBw4qmBH8TvSVvEQAtqy4tz+kvqTGIgdGdMurUvoQQLvQ5TnWIVV4iDt7YDzjGSRgZEhfuxBfUiYo6O3VYZF06NJYckrZLRemyTycXmPcz22UE1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778965802; c=relaxed/simple;
	bh=016MVcTIjvop5eLS7uxxvPpUZd0AI4bpNJ8tAwH403o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MmTgLVzAUFNoRIeZPTIhpKudRpI+SOR7sY/5bF8cWS5o2/FmZkoS0NY8RDVEILk96bSvWTbttczsAQCVdyil4Uvo5QbDVvJrAcUGkojOt0QGQCVGOKH3mZLb91gmCkV/b2D5dfuZXoCJMpyqg7+aZYW8C1ZSq1H9Cp7pd1wgG9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hJYzCd3E; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778965800; x=1810501800;
  h=date:from:to:cc:subject:message-id;
  bh=016MVcTIjvop5eLS7uxxvPpUZd0AI4bpNJ8tAwH403o=;
  b=hJYzCd3ESPXt2Des9L1oGS25aeeUssC0KJA7kj2LS7Xo+BfYz+DlpZVq
   reJ5tRKUxa0kY5cWJBaa3vVNk0gpWCdQ+NjUCnTLmNfASMMb7mfh5yG8H
   mxZXv7mwByEWdafa6ZWA6fkjdFiKY8o1lUM/qUzw5dGQrC/78JUlcknmL
   uXaWUXnoDzC9Nl4TjMUQupPrTB6DTlPoxRV0GhP0rWBTD/RkMBaw1WiJ9
   bryUGyiQu/LZBeTxetZRg0A+brl1Ap7Q97WkS7AVV/YD/ATQnLXKH0q9U
   BVGn8KuIeqB/8JNQUwwG8XXd2nQmo1NxMOX66MRIk6CfklFF0BQKpQm9Q
   g==;
X-CSE-ConnectionGUID: Vw2CfcMcSpqPW0oWo7eRmg==
X-CSE-MsgGUID: WPwbwtZhQ4idU+OJSw1N8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="90983180"
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="90983180"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 14:09:59 -0700
X-CSE-ConnectionGUID: b615R8YNTEaID0T8d5+mng==
X-CSE-MsgGUID: HFHILfqUS0uJxXP2r/xncA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="244000803"
Received: from lkp-server01.sh.intel.com (HELO d94e5e629b2d) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 16 May 2026 14:09:58 -0700
Received: from kbuild by d94e5e629b2d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wOMGh-0000000017q-3IbI;
	Sat, 16 May 2026 21:09:55 +0000
Date: Sun, 17 May 2026 05:09:07 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:for-rc] BUILD SUCCESS
 65b044cee9fb117144f11ab68a318d0055cfbc1b
Message-ID: <202605170556.jPgHmY0V-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: CA93255DCAF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20803-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: 65b044cee9fb117144f11ab68a318d0055cfbc1b  RDMA/core: Move the _ib_copy_validate_udata* functions to ib_core_uverbs

elapsed time: 727m

configs tested: 334
configs skipped: 2

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
arc                        nsimosci_defconfig    gcc-15.2.0
arc                   randconfig-001-20260516    gcc-8.5.0
arc                   randconfig-001-20260517    gcc-13.4.0
arc                   randconfig-002-20260516    gcc-8.5.0
arc                   randconfig-002-20260517    gcc-13.4.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                          pxa910_defconfig    gcc-15.2.0
arm                   randconfig-001-20260516    gcc-8.5.0
arm                   randconfig-001-20260517    gcc-13.4.0
arm                   randconfig-002-20260516    gcc-8.5.0
arm                   randconfig-002-20260517    gcc-13.4.0
arm                   randconfig-003-20260516    gcc-8.5.0
arm                   randconfig-003-20260517    gcc-13.4.0
arm                   randconfig-004-20260516    gcc-8.5.0
arm                   randconfig-004-20260517    gcc-13.4.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                          randconfig-001    clang-23
arm64                          randconfig-001    gcc-8.5.0
arm64                 randconfig-001-20260516    clang-23
arm64                 randconfig-001-20260516    gcc-13.4.0
arm64                 randconfig-001-20260516    gcc-9.5.0
arm64                 randconfig-001-20260517    clang-23
arm64                          randconfig-002    clang-23
arm64                          randconfig-002    gcc-14.3.0
arm64                 randconfig-002-20260516    clang-23
arm64                 randconfig-002-20260516    gcc-9.5.0
arm64                 randconfig-002-20260517    clang-23
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260516    clang-23
arm64                 randconfig-003-20260516    gcc-9.5.0
arm64                 randconfig-003-20260517    clang-23
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260516    clang-23
arm64                 randconfig-004-20260516    gcc-9.5.0
arm64                 randconfig-004-20260517    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                           randconfig-001    clang-23
csky                           randconfig-001    gcc-10.5.0
csky                  randconfig-001-20260516    clang-23
csky                  randconfig-001-20260516    gcc-15.2.0
csky                  randconfig-001-20260516    gcc-9.5.0
csky                  randconfig-001-20260517    clang-23
csky                           randconfig-002    clang-23
csky                           randconfig-002    gcc-10.5.0
csky                  randconfig-002-20260516    clang-23
csky                  randconfig-002-20260516    gcc-10.5.0
csky                  randconfig-002-20260516    gcc-9.5.0
csky                  randconfig-002-20260517    clang-23
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260516    clang-23
hexagon               randconfig-001-20260516    gcc-11.5.0
hexagon               randconfig-001-20260517    gcc-9.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260516    clang-16
hexagon               randconfig-002-20260516    gcc-11.5.0
hexagon               randconfig-002-20260517    gcc-9.5.0
i386                             alldefconfig    gcc-14
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                 buildonly-randconfig-001    clang-20
i386        buildonly-randconfig-001-20260516    clang-20
i386        buildonly-randconfig-001-20260517    gcc-14
i386                 buildonly-randconfig-002    clang-20
i386        buildonly-randconfig-002-20260516    clang-20
i386        buildonly-randconfig-002-20260517    gcc-14
i386                 buildonly-randconfig-003    clang-20
i386        buildonly-randconfig-003-20260516    clang-20
i386        buildonly-randconfig-003-20260517    gcc-14
i386                 buildonly-randconfig-004    clang-20
i386        buildonly-randconfig-004-20260516    clang-20
i386        buildonly-randconfig-004-20260517    gcc-14
i386                 buildonly-randconfig-005    clang-20
i386        buildonly-randconfig-005-20260516    clang-20
i386        buildonly-randconfig-005-20260517    gcc-14
i386                 buildonly-randconfig-006    clang-20
i386        buildonly-randconfig-006-20260516    clang-20
i386        buildonly-randconfig-006-20260517    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260516    clang-20
i386                  randconfig-002-20260516    clang-20
i386                  randconfig-003-20260516    clang-20
i386                  randconfig-004-20260516    clang-20
i386                  randconfig-005-20260516    clang-20
i386                  randconfig-006-20260516    clang-20
i386                  randconfig-007-20260516    clang-20
i386                  randconfig-011-20260516    gcc-14
i386                  randconfig-012-20260516    gcc-14
i386                  randconfig-013-20260516    gcc-14
i386                  randconfig-014-20260516    gcc-14
i386                  randconfig-015-20260516    gcc-14
i386                  randconfig-016-20260516    gcc-14
i386                  randconfig-017-20260516    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260516    gcc-11.5.0
loongarch             randconfig-001-20260516    gcc-15.2.0
loongarch             randconfig-001-20260517    gcc-9.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260516    clang-18
loongarch             randconfig-002-20260516    gcc-11.5.0
loongarch             randconfig-002-20260517    gcc-9.5.0
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
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260516    gcc-10.5.0
nios2                 randconfig-001-20260516    gcc-11.5.0
nios2                 randconfig-001-20260517    gcc-9.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260516    gcc-11.5.0
nios2                 randconfig-002-20260517    gcc-9.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                         randconfig-001    gcc-12.5.0
parisc                randconfig-001-20260516    gcc-12.5.0
parisc                randconfig-001-20260517    gcc-10.5.0
parisc                         randconfig-002    gcc-12.5.0
parisc                randconfig-002-20260516    gcc-12.5.0
parisc                randconfig-002-20260517    gcc-10.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      ppc44x_defconfig    clang-23
powerpc                        randconfig-001    gcc-12.5.0
powerpc               randconfig-001-20260516    gcc-12.5.0
powerpc               randconfig-001-20260517    gcc-10.5.0
powerpc                        randconfig-002    gcc-12.5.0
powerpc               randconfig-002-20260516    gcc-12.5.0
powerpc               randconfig-002-20260517    gcc-10.5.0
powerpc64                      randconfig-001    gcc-12.5.0
powerpc64             randconfig-001-20260516    gcc-12.5.0
powerpc64             randconfig-001-20260517    gcc-10.5.0
powerpc64                      randconfig-002    gcc-12.5.0
powerpc64             randconfig-002-20260516    gcc-12.5.0
powerpc64             randconfig-002-20260517    gcc-10.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_k210_defconfig    clang-23
riscv                          randconfig-001    gcc-15.2.0
riscv                 randconfig-001-20260516    gcc-15.2.0
riscv                 randconfig-001-20260517    gcc-10.5.0
riscv                          randconfig-002    gcc-15.2.0
riscv                 randconfig-002-20260516    gcc-15.2.0
riscv                 randconfig-002-20260517    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                           randconfig-001    gcc-15.2.0
s390                  randconfig-001-20260516    gcc-15.2.0
s390                  randconfig-001-20260517    gcc-10.5.0
s390                           randconfig-002    gcc-15.2.0
s390                  randconfig-002-20260516    gcc-15.2.0
s390                  randconfig-002-20260517    gcc-10.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                             randconfig-001    gcc-15.2.0
sh                    randconfig-001-20260516    gcc-15.2.0
sh                    randconfig-001-20260517    gcc-10.5.0
sh                             randconfig-002    gcc-15.2.0
sh                    randconfig-002-20260516    gcc-15.2.0
sh                    randconfig-002-20260517    gcc-10.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                          randconfig-001    gcc-8.5.0
sparc                 randconfig-001-20260516    gcc-8.5.0
sparc                 randconfig-001-20260517    gcc-8.5.0
sparc                          randconfig-002    gcc-8.5.0
sparc                 randconfig-002-20260516    gcc-8.5.0
sparc                 randconfig-002-20260517    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-8.5.0
sparc64               randconfig-001-20260516    gcc-8.5.0
sparc64               randconfig-001-20260517    gcc-8.5.0
sparc64                        randconfig-002    gcc-8.5.0
sparc64               randconfig-002-20260516    gcc-8.5.0
sparc64               randconfig-002-20260517    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-8.5.0
um                    randconfig-001-20260516    gcc-8.5.0
um                    randconfig-001-20260517    gcc-8.5.0
um                             randconfig-002    gcc-8.5.0
um                    randconfig-002-20260516    gcc-8.5.0
um                    randconfig-002-20260517    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64               buildonly-randconfig-001    gcc-14
x86_64      buildonly-randconfig-001-20260516    gcc-14
x86_64      buildonly-randconfig-001-20260517    gcc-14
x86_64               buildonly-randconfig-002    gcc-14
x86_64      buildonly-randconfig-002-20260516    gcc-14
x86_64      buildonly-randconfig-002-20260517    gcc-14
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20260516    gcc-14
x86_64      buildonly-randconfig-003-20260517    gcc-14
x86_64               buildonly-randconfig-004    gcc-14
x86_64      buildonly-randconfig-004-20260516    gcc-14
x86_64      buildonly-randconfig-004-20260517    gcc-14
x86_64               buildonly-randconfig-005    gcc-14
x86_64      buildonly-randconfig-005-20260516    gcc-14
x86_64      buildonly-randconfig-005-20260517    gcc-14
x86_64               buildonly-randconfig-006    gcc-14
x86_64      buildonly-randconfig-006-20260516    gcc-14
x86_64      buildonly-randconfig-006-20260517    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                         randconfig-001    gcc-14
x86_64                randconfig-001-20260516    gcc-14
x86_64                randconfig-001-20260517    clang-20
x86_64                         randconfig-002    gcc-14
x86_64                randconfig-002-20260516    gcc-14
x86_64                randconfig-002-20260517    clang-20
x86_64                         randconfig-003    gcc-14
x86_64                randconfig-003-20260516    gcc-14
x86_64                randconfig-003-20260517    clang-20
x86_64                         randconfig-004    gcc-14
x86_64                randconfig-004-20260516    gcc-14
x86_64                randconfig-004-20260517    clang-20
x86_64                         randconfig-005    gcc-14
x86_64                randconfig-005-20260516    gcc-14
x86_64                randconfig-005-20260517    clang-20
x86_64                         randconfig-006    gcc-14
x86_64                randconfig-006-20260516    gcc-14
x86_64                randconfig-006-20260517    clang-20
x86_64                         randconfig-011    clang-20
x86_64                randconfig-011-20260516    clang-20
x86_64                randconfig-011-20260517    gcc-14
x86_64                         randconfig-012    clang-20
x86_64                randconfig-012-20260516    clang-20
x86_64                randconfig-012-20260517    gcc-14
x86_64                         randconfig-013    clang-20
x86_64                randconfig-013-20260516    clang-20
x86_64                randconfig-013-20260517    gcc-14
x86_64                         randconfig-014    clang-20
x86_64                randconfig-014-20260516    clang-20
x86_64                randconfig-014-20260517    gcc-14
x86_64                         randconfig-015    clang-20
x86_64                randconfig-015-20260516    clang-20
x86_64                randconfig-015-20260517    gcc-14
x86_64                         randconfig-016    clang-20
x86_64                randconfig-016-20260516    clang-20
x86_64                randconfig-016-20260517    gcc-14
x86_64                         randconfig-071    gcc-14
x86_64                randconfig-071-20260516    gcc-14
x86_64                         randconfig-072    gcc-14
x86_64                randconfig-072-20260516    gcc-14
x86_64                         randconfig-073    gcc-14
x86_64                randconfig-073-20260516    gcc-14
x86_64                         randconfig-074    gcc-14
x86_64                randconfig-074-20260516    gcc-14
x86_64                         randconfig-075    gcc-14
x86_64                randconfig-075-20260516    gcc-14
x86_64                         randconfig-076    gcc-14
x86_64                randconfig-076-20260516    gcc-14
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
xtensa                         randconfig-001    gcc-8.5.0
xtensa                randconfig-001-20260516    gcc-8.5.0
xtensa                randconfig-001-20260517    gcc-8.5.0
xtensa                         randconfig-002    gcc-8.5.0
xtensa                randconfig-002-20260516    gcc-8.5.0
xtensa                randconfig-002-20260517    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

