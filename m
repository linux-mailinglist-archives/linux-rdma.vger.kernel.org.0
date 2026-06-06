Return-Path: <linux-rdma+bounces-21905-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 141ZBD9tJGry6AEAu9opvQ
	(envelope-from <linux-rdma+bounces-21905-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 20:55:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB9F64E0DA
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 20:55:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=g9r6Opmb;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21905-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21905-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E80A13016EC0
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Jun 2026 18:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313A230C174;
	Sat,  6 Jun 2026 18:55:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8FF3002BB
	for <linux-rdma@vger.kernel.org>; Sat,  6 Jun 2026 18:55:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780772156; cv=none; b=KD42lwdkm+mSj2+6soBSkzngXKsjfgZc7aFKFN3yFBN/YBP1c+1mmhF+nRDSxrTcN2s5QIJpsOOg6oSZezYQWpsMXbK5sGiy/5tRKOmEWEvBogGmaBUdaZp99YlIFzuCXnUxfFvS0n/AiCjZ1ck9vl/nelN7NGp82jtEpKg8V04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780772156; c=relaxed/simple;
	bh=9AfOYJ1OJ6mjaMOqRxbh626KsDys/vLidiQi/zqWcHo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jP3uags5aSYL3Ce1a9+smW7Xnm2ki7GgmrLjHmNYsw94H+Yshq+LlNcwS/VX9bRpmtg6RH6rdOL9V1LGSnKFQVDvch2OcGCAN0xH+L1TC6b2K5SISJJkEHm/P0o/+8yccssBCefgOOhUZl4JM1/gHLfsJQafGpZdKslHLrOHa8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g9r6Opmb; arc=none smtp.client-ip=198.175.65.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780772155; x=1812308155;
  h=date:from:to:cc:subject:message-id;
  bh=9AfOYJ1OJ6mjaMOqRxbh626KsDys/vLidiQi/zqWcHo=;
  b=g9r6OpmbLBajhTrliTMBIv75y0FODCf6/J2+mOMxtEqTutZ0keWPHtpa
   0fXWm2JObadlHWHsUYN2kQj3ACXvHWReVAY61BkQ+r25YTYJWVEpPMnuS
   /PzCbxPEMSt5MytgLrffHnCjfAX3eye4/K2gGSyXHBOj0yEPnggKWAaCs
   mBIsVyIl82su2RTrtV5yq89IqMPVYOrx5F1Wc4UFaehVgqcVH/6yAHoU5
   MJ7v1Yf2L3n9NEc25KQVqp7mSST9tClQrkZVMu5pUA0o25SViW9zFAjFY
   DxTDS5NyK2mBKZIwkAV1ppe6Xxa25WNZbW1SAl2XZcKYZnfNY7UVofJCc
   w==;
X-CSE-ConnectionGUID: PsQpTQQdRnCvqmLCbTXp0A==
X-CSE-MsgGUID: zdhDXTpqTcaS7ak2AAKf7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11809"; a="81545803"
X-IronPort-AV: E=Sophos;i="6.24,191,1774335600"; 
   d="scan'208";a="81545803"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2026 11:55:54 -0700
X-CSE-ConnectionGUID: VGsQ5wbuRRq3DRh9UwFMdg==
X-CSE-MsgGUID: Jxn8VWhmTzyZe1E6O849TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,191,1774335600"; 
   d="scan'208";a="268819290"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 06 Jun 2026 11:55:52 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wVwBR-00000000HEs-3dcI;
	Sat, 06 Jun 2026 18:55:49 +0000
Date: Sun, 07 Jun 2026 02:55:27 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 ea4f6f6c53577fb3f05dbd78b15e586772d49831
Message-ID: <202606070218.46un5Xtz-lkp@intel.com>
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
	TAGGED_FROM(0.00)[bounces-21905-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:from_mime,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3BB9F64E0DA

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: ea4f6f6c53577fb3f05dbd78b15e586772d49831  RDMA/siw: Fix endpoint/socket association handling

elapsed time: 1300m

configs tested: 159
configs skipped: 8

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
arc                   randconfig-001-20260606    gcc-12.5.0
arc                   randconfig-002-20260606    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260606    clang-17
arm                   randconfig-002-20260606    gcc-10.5.0
arm                   randconfig-003-20260606    clang-23
arm                   randconfig-004-20260606    clang-23
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260606    gcc-10.5.0
arm64                 randconfig-002-20260606    gcc-8.5.0
arm64                 randconfig-003-20260606    clang-23
arm64                 randconfig-004-20260606    gcc-14.3.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260606    gcc-10.5.0
csky                  randconfig-002-20260606    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260606    clang-23
hexagon               randconfig-002-20260606    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260606    clang-20
i386        buildonly-randconfig-002-20260606    clang-20
i386        buildonly-randconfig-003-20260606    clang-20
i386        buildonly-randconfig-004-20260606    gcc-14
i386        buildonly-randconfig-005-20260606    clang-20
i386        buildonly-randconfig-006-20260606    gcc-13
i386                                defconfig    clang-22
i386                  randconfig-011-20260606    clang-22
i386                  randconfig-012-20260606    gcc-14
i386                  randconfig-013-20260606    gcc-12
i386                  randconfig-014-20260606    clang-22
i386                  randconfig-015-20260606    clang-22
i386                  randconfig-016-20260606    gcc-14
i386                  randconfig-017-20260606    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260606    clang-23
loongarch             randconfig-002-20260606    clang-23
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                          defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-15.2.0
mips                      malta_kvm_defconfig    gcc-16.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260606    gcc-11.5.0
nios2                 randconfig-002-20260606    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260606    gcc-8.5.0
parisc                randconfig-002-20260606    gcc-10.5.0
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260606    clang-23
powerpc               randconfig-002-20260606    clang-23
powerpc64             randconfig-001-20260606    gcc-15.2.0
powerpc64             randconfig-002-20260606    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260606    gcc-11.5.0
riscv                 randconfig-001-20260606    gcc-12.5.0
riscv                 randconfig-002-20260606    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                  randconfig-001-20260606    gcc-10.5.0
s390                  randconfig-001-20260606    gcc-13.4.0
s390                  randconfig-002-20260606    gcc-13.4.0
s390                  randconfig-002-20260606    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-16.1.0
sh                    randconfig-001-20260606    gcc-10.5.0
sh                    randconfig-002-20260606    gcc-16.1.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-16.1.0
sparc                          randconfig-001    gcc-8.5.0
sparc                 randconfig-001-20260606    gcc-13.4.0
sparc                          randconfig-002    gcc-15.2.0
sparc                 randconfig-002-20260606    gcc-16.1.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-23
sparc64                        randconfig-001    gcc-8.5.0
sparc64               randconfig-001-20260606    gcc-12.5.0
sparc64                        randconfig-002    clang-23
sparc64               randconfig-002-20260606    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                             randconfig-001    clang-23
um                    randconfig-001-20260606    clang-23
um                             randconfig-002    clang-23
um                    randconfig-002-20260606    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260606    clang-20
x86_64      buildonly-randconfig-002-20260606    clang-20
x86_64      buildonly-randconfig-003-20260606    gcc-14
x86_64      buildonly-randconfig-004-20260606    gcc-13
x86_64      buildonly-randconfig-005-20260606    clang-20
x86_64      buildonly-randconfig-006-20260606    gcc-14
x86_64                              defconfig    gcc-14
x86_64                         randconfig-001    gcc-14
x86_64                randconfig-001-20260606    gcc-14
x86_64                         randconfig-002    gcc-14
x86_64                randconfig-002-20260606    gcc-14
x86_64                         randconfig-003    clang-20
x86_64                randconfig-003-20260606    gcc-14
x86_64                         randconfig-004    clang-20
x86_64                randconfig-004-20260606    gcc-14
x86_64                         randconfig-005    gcc-14
x86_64                randconfig-005-20260606    gcc-14
x86_64                         randconfig-006    clang-20
x86_64                randconfig-006-20260606    gcc-14
x86_64                randconfig-011-20260606    clang-20
x86_64                randconfig-012-20260606    clang-20
x86_64                randconfig-013-20260606    gcc-14
x86_64                randconfig-014-20260606    clang-20
x86_64                randconfig-015-20260606    clang-20
x86_64                randconfig-016-20260606    clang-20
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    gcc-15.2.0
xtensa                         randconfig-001    gcc-8.5.0
xtensa                randconfig-001-20260606    gcc-8.5.0
xtensa                         randconfig-002    gcc-8.5.0
xtensa                randconfig-002-20260606    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

