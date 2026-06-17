Return-Path: <linux-rdma+bounces-22297-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eO7cJA4RMmopuQUAu9opvQ
	(envelope-from <linux-rdma+bounces-22297-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 05:14:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4C16963FC
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 05:14:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=ObmI3aWl;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22297-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22297-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8BB45301530E
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 03:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814402FC037;
	Wed, 17 Jun 2026 03:14:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B19919DF55
	for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 03:14:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781666058; cv=none; b=lURLJ/vRyQG6Acjp8aEdRxmO2erGFejBpSHVFJTPbQg7mmbi5CQ1Rg4It/XJCoYJ2sOYQkwJXGerkPLI1WslTiO3y/VJKfcL+kOE3Zh1iEguqusm/iPdcG7crHrXMKYKn8ijiBI6EtHk4t8KmdDZn/Fq7sGPuGOLx42qRkvB/AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781666058; c=relaxed/simple;
	bh=TYFpL8nfdcptVBzWkIM1Urr1zpI13wgTpE9KxRlYsEo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=j2n9AlOoHjw9YVMXs9IHtVANafE5+hgeeEEzOoyjZUq73KPecQyj+6VzVkfAEXK+a/AJU7CfsputimJhucGI3DJM70xmKfVcglKUhDov+yFplje+IOQw1aOXKLqKOcPfOjpO5Q51O4d/+sXayUcB9zR3sKem1yhwMWeqarrjpOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ObmI3aWl; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781666057; x=1813202057;
  h=date:from:to:cc:subject:message-id;
  bh=TYFpL8nfdcptVBzWkIM1Urr1zpI13wgTpE9KxRlYsEo=;
  b=ObmI3aWlrp3LnVLwgNB0SmqOiZn2ucPudk+vxdpr1bxmPZAnxq9RB/8Y
   DmzeTGoJtA9Iu+MMaiJkDu14fuiW6WwVHHTc5YHXiPM9uDAnzK/Hh7R2P
   A9xei9cGiyqZPbqPfKBPSAAtXv5jm38fvwpcfGEL91u9nJn8LS3gS0zV1
   PYiBgq2kVXvEtNFTMiZw4ZPpf8nNz11xtMf3NrPnSUI4EjwhdIa6xVOFK
   sT9iYjhVCb8D85N8/QGATJ+NUwg5lwzJI3L7FsxTjOTHYFL+DA6RquJo0
   TGrSC3PH8b+L+TbanryfUq+zd9b2rgRlFKD2ADQBE+NrIE51D8G7X3rud
   A==;
X-CSE-ConnectionGUID: aMbOVFw7Rtah6f0UpWBxUA==
X-CSE-MsgGUID: 5P/+gSgGRA2yf7FHS8mt8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="82648874"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="82648874"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 20:14:08 -0700
X-CSE-ConnectionGUID: rMaxWDOARhKkou+V9SoYZg==
X-CSE-MsgGUID: QsiDLIOnSvSiZzq+lqqI7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="272016334"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 16 Jun 2026 20:14:07 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wZgj6-00000000U3W-232h;
	Wed, 17 Jun 2026 03:14:04 +0000
Date: Wed, 17 Jun 2026 11:13:12 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 c695e969269e33e8030487d1436cafa678928dde
Message-ID: <202606171103.sqSPiIKX-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22297-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:dledford@redhat.com,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:mid,intel.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E4C16963FC

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: c695e969269e33e8030487d1436cafa678928dde  ABI: sysfs-class-infiniband: minor cleanup

elapsed time: 729m

configs tested: 164
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260617    gcc-16.1.0
arc                   randconfig-002-20260617    gcc-16.1.0
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                         lpc18xx_defconfig    clang-23
arm                   randconfig-001-20260617    gcc-16.1.0
arm                   randconfig-002-20260617    gcc-16.1.0
arm                   randconfig-003-20260617    gcc-16.1.0
arm                   randconfig-004-20260617    gcc-16.1.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260617    gcc-12.5.0
arm64                 randconfig-002-20260617    gcc-12.5.0
arm64                 randconfig-003-20260617    gcc-12.5.0
arm64                 randconfig-004-20260617    gcc-12.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260617    gcc-12.5.0
csky                  randconfig-002-20260617    gcc-12.5.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260617    clang-17
hexagon               randconfig-002-20260617    clang-17
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260617    gcc-13
i386                  randconfig-002-20260617    gcc-13
i386                  randconfig-003-20260617    gcc-13
i386                  randconfig-004-20260617    gcc-13
i386                  randconfig-005-20260617    gcc-13
i386                  randconfig-006-20260617    gcc-13
i386                  randconfig-007-20260617    gcc-13
i386                  randconfig-011-20260617    clang-22
i386                  randconfig-012-20260617    clang-22
i386                  randconfig-013-20260617    clang-22
i386                  randconfig-014-20260617    clang-22
i386                  randconfig-015-20260617    clang-22
i386                  randconfig-016-20260617    clang-22
i386                  randconfig-017-20260617    clang-22
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260617    clang-17
loongarch             randconfig-002-20260617    clang-17
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                      malta_kvm_defconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-23
nios2                 randconfig-001-20260617    clang-17
nios2                 randconfig-002-20260617    clang-17
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260617    gcc-15.2.0
parisc                randconfig-002-20260617    gcc-15.2.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc               randconfig-001-20260617    gcc-15.2.0
powerpc               randconfig-002-20260617    gcc-15.2.0
powerpc64             randconfig-001-20260617    gcc-15.2.0
powerpc64             randconfig-002-20260617    gcc-15.2.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260617    gcc-16.1.0
riscv                 randconfig-002-20260617    gcc-16.1.0
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260617    gcc-16.1.0
s390                  randconfig-002-20260617    gcc-16.1.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260617    gcc-16.1.0
sh                    randconfig-002-20260617    gcc-16.1.0
sh                           se7619_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260617    gcc-16.1.0
sparc                 randconfig-002-20260617    gcc-16.1.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260617    gcc-16.1.0
sparc64               randconfig-002-20260617    gcc-16.1.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260617    gcc-16.1.0
um                    randconfig-002-20260617    gcc-16.1.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260617    clang-22
x86_64      buildonly-randconfig-002-20260617    clang-22
x86_64      buildonly-randconfig-003-20260617    clang-22
x86_64      buildonly-randconfig-004-20260617    clang-22
x86_64      buildonly-randconfig-005-20260617    clang-22
x86_64      buildonly-randconfig-006-20260617    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260617    clang-22
x86_64                randconfig-002-20260617    clang-22
x86_64                randconfig-003-20260617    clang-22
x86_64                randconfig-004-20260617    clang-22
x86_64                randconfig-005-20260617    clang-22
x86_64                randconfig-006-20260617    clang-22
x86_64                randconfig-011-20260617    clang-22
x86_64                randconfig-012-20260617    clang-22
x86_64                randconfig-013-20260617    clang-22
x86_64                randconfig-014-20260617    clang-22
x86_64                randconfig-015-20260617    clang-22
x86_64                randconfig-016-20260617    clang-22
x86_64                randconfig-071-20260617    clang-22
x86_64                randconfig-072-20260617    clang-22
x86_64                randconfig-073-20260617    clang-22
x86_64                randconfig-074-20260617    clang-22
x86_64                randconfig-075-20260617    clang-22
x86_64                randconfig-076-20260617    clang-22
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260617    gcc-16.1.0
xtensa                randconfig-002-20260617    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

