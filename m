Return-Path: <linux-rdma+bounces-22149-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id brqRG0lbK2px7wMAu9opvQ
	(envelope-from <linux-rdma+bounces-22149-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 03:05:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8992D6760AC
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 03:05:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=ISe7UxVK;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22149-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22149-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2509830C59C0
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 01:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682D730568B;
	Fri, 12 Jun 2026 01:05:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D3F3043CE
	for <linux-rdma@vger.kernel.org>; Fri, 12 Jun 2026 01:05:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781226310; cv=none; b=SX/ARuHc2FZk657Br50ZrGtX4nGoXS3DWHIz5CPnxM02vO+TXUqkB6opJbGrWO0JWlOCmMZMo3xOo5g9//bUHo69FFbEcvEajYeDmnqeWpU0yvsOy7Oz3EHJVWYwERHR2TDn4eqLR+sv6u/nAq3+bEpffy4y2qU9G6MKMoUjBCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781226310; c=relaxed/simple;
	bh=HfLhOYi0Y5/C462Me+yoIV5nHu397JEyN08apjWQbYw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VOhFtf5G2XmMShqMikDncjY1xUsvHo8gqyswXhCHz2i7KsnufnzdJ4d4+s7h9cDWiGQ8wwX4EdD+y+Bh3qBPMgX5EHH4N+eQ6Rv01/LLle/XZs1mQvKsk/nk7fwl0jDGJ15GTSLOJFFmkwfEaBJhKQYujuAiZKdzAHzX2YlZafU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ISe7UxVK; arc=none smtp.client-ip=198.175.65.13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781226308; x=1812762308;
  h=date:from:to:cc:subject:message-id;
  bh=HfLhOYi0Y5/C462Me+yoIV5nHu397JEyN08apjWQbYw=;
  b=ISe7UxVKeTFyXFNP7z/NBOylL/k0hxfkzFPKZ7X2nizvsETUHLLTTXRP
   niqyuHhVffjIkoMCWeKdQPxBthv5Ih6ayL6sP66YdrtNS2nnDeBJJm87S
   lXyYQf6avjHPAhaFAxag86o7ZE75SglsSwsjI7pJfEQlKJ4QZtO7vQe/H
   pFBTd1Eqlmum51KHVpDsFcBAtF5AEZW0U77J8Xq6yK1yzwoYfRE9sVRlg
   AWMtMEy0u6KikYKG2cygdg+gkR6v8PF2zHgoaOPbkMOHbl3GkcQyVEdQ9
   hivxbTWWLQI79IKCBOwvbnneT9jNvNXKaknqPgmMsjXS6PYLv5wlWn0E5
   g==;
X-CSE-ConnectionGUID: Fg1VbLtbQ5eeQrofLFS49w==
X-CSE-MsgGUID: jooqhbNFSOK0j2XMp+UQ1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="93164164"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="93164164"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 18:05:08 -0700
X-CSE-ConnectionGUID: miJ5DFIySRa7mpF+Q8IAdg==
X-CSE-MsgGUID: x3EwHkRCTm6jG4HEgBlPlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="284772760"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 11 Jun 2026 18:05:06 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wXqKU-00000000O5o-3R1k;
	Fri, 12 Jun 2026 01:05:02 +0000
Date: Fri, 12 Jun 2026 09:04:12 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 8b0c66fa058b34015fcc7cafc9dea86dd91d8db9
Message-ID: <202606120902.GrbPiyqv-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22149-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:dledford@redhat.com,m:jgg+lists@ziepe.ca,m:linux-rdma@vger.kernel.org,m:jgg@ziepe.ca,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,lists];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:mid,intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8992D6760AC

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 8b0c66fa058b34015fcc7cafc9dea86dd91d8db9  IB/core: Delegate IB_QP_RATE_LIMIT validation to drivers

elapsed time: 816m

configs tested: 267
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                            randconfig-001    gcc-13.4.0
arc                   randconfig-001-20260611    gcc-14.3.0
arc                   randconfig-001-20260612    gcc-13.4.0
arc                            randconfig-002    gcc-13.4.0
arc                   randconfig-002-20260611    gcc-14.3.0
arc                   randconfig-002-20260612    gcc-13.4.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                         at91_dt_defconfig    clang-17
arm                                 defconfig    gcc-16.1.0
arm                            randconfig-001    gcc-13.4.0
arm                   randconfig-001-20260611    gcc-14.3.0
arm                   randconfig-001-20260612    gcc-13.4.0
arm                            randconfig-002    gcc-13.4.0
arm                   randconfig-002-20260611    gcc-14.3.0
arm                   randconfig-002-20260612    gcc-13.4.0
arm                            randconfig-003    gcc-13.4.0
arm                   randconfig-003-20260611    gcc-14.3.0
arm                   randconfig-003-20260612    gcc-13.4.0
arm                            randconfig-004    gcc-13.4.0
arm                   randconfig-004-20260611    gcc-14.3.0
arm                   randconfig-004-20260612    gcc-13.4.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260611    gcc-14.3.0
arm64                 randconfig-001-20260612    gcc-13.4.0
arm64                 randconfig-002-20260611    gcc-14.3.0
arm64                 randconfig-002-20260612    gcc-13.4.0
arm64                 randconfig-003-20260611    gcc-14.3.0
arm64                 randconfig-003-20260612    gcc-13.4.0
arm64                 randconfig-004-20260611    gcc-14.3.0
arm64                 randconfig-004-20260612    gcc-13.4.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260611    gcc-14.3.0
csky                  randconfig-001-20260612    gcc-13.4.0
csky                  randconfig-002-20260611    gcc-14.3.0
csky                  randconfig-002-20260612    gcc-13.4.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260611    clang-17
hexagon               randconfig-001-20260612    clang-23
hexagon               randconfig-002-20260611    clang-17
hexagon               randconfig-002-20260612    clang-23
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260612    gcc-14
i386        buildonly-randconfig-002-20260612    gcc-14
i386        buildonly-randconfig-003-20260612    gcc-14
i386        buildonly-randconfig-004-20260612    gcc-14
i386        buildonly-randconfig-005-20260612    gcc-14
i386        buildonly-randconfig-006-20260612    gcc-14
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260612    clang-22
i386                  randconfig-002-20260612    clang-22
i386                  randconfig-003-20260612    clang-22
i386                  randconfig-004-20260612    clang-22
i386                  randconfig-005-20260612    clang-22
i386                  randconfig-006-20260612    clang-22
i386                  randconfig-007-20260612    clang-22
i386                  randconfig-011-20260611    gcc-14
i386                  randconfig-011-20260612    clang-22
i386                  randconfig-012-20260611    gcc-14
i386                  randconfig-012-20260612    clang-22
i386                  randconfig-013-20260611    gcc-14
i386                  randconfig-013-20260612    clang-22
i386                  randconfig-014-20260611    gcc-14
i386                  randconfig-014-20260612    clang-22
i386                  randconfig-015-20260611    gcc-14
i386                  randconfig-015-20260612    clang-22
i386                  randconfig-016-20260611    gcc-14
i386                  randconfig-016-20260612    clang-22
i386                  randconfig-017-20260611    gcc-14
i386                  randconfig-017-20260612    clang-22
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260611    clang-17
loongarch             randconfig-001-20260612    clang-23
loongarch             randconfig-002-20260611    clang-17
loongarch             randconfig-002-20260612    clang-23
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
m68k                        m5272c3_defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                 randconfig-001-20260611    clang-17
nios2                 randconfig-001-20260612    clang-23
nios2                 randconfig-002-20260611    clang-17
nios2                 randconfig-002-20260612    clang-23
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    gcc-13.4.0
parisc                randconfig-001-20260611    gcc-13.4.0
parisc                         randconfig-002    gcc-13.4.0
parisc                randconfig-002-20260611    gcc-13.4.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                        randconfig-001    gcc-13.4.0
powerpc               randconfig-001-20260611    gcc-13.4.0
powerpc                        randconfig-002    gcc-13.4.0
powerpc               randconfig-002-20260611    gcc-13.4.0
powerpc64                      randconfig-001    gcc-13.4.0
powerpc64             randconfig-001-20260611    gcc-13.4.0
powerpc64                      randconfig-002    gcc-13.4.0
powerpc64             randconfig-002-20260611    gcc-13.4.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260611    gcc-12.5.0
riscv                 randconfig-001-20260612    gcc-11.5.0
riscv                 randconfig-002-20260611    gcc-12.5.0
riscv                 randconfig-002-20260612    gcc-11.5.0
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260611    gcc-12.5.0
s390                  randconfig-001-20260612    gcc-11.5.0
s390                  randconfig-002-20260611    gcc-12.5.0
s390                  randconfig-002-20260612    gcc-11.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260611    gcc-12.5.0
sh                    randconfig-001-20260612    gcc-11.5.0
sh                    randconfig-002-20260611    gcc-12.5.0
sh                    randconfig-002-20260612    gcc-11.5.0
sh                             shx3_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260611    gcc-15.2.0
sparc                 randconfig-001-20260612    gcc-8.5.0
sparc                 randconfig-002-20260611    gcc-15.2.0
sparc                 randconfig-002-20260612    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260611    gcc-15.2.0
sparc64               randconfig-001-20260612    gcc-8.5.0
sparc64               randconfig-002-20260611    gcc-15.2.0
sparc64               randconfig-002-20260612    gcc-8.5.0
um                               allmodconfig    clang-17
um                               allmodconfig    clang-23
um                                allnoconfig    clang-16
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260611    gcc-15.2.0
um                    randconfig-001-20260612    gcc-8.5.0
um                    randconfig-002-20260611    gcc-15.2.0
um                    randconfig-002-20260612    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260611    gcc-14
x86_64      buildonly-randconfig-002-20260611    gcc-14
x86_64      buildonly-randconfig-003-20260611    gcc-14
x86_64      buildonly-randconfig-004-20260611    gcc-14
x86_64      buildonly-randconfig-005-20260611    gcc-14
x86_64      buildonly-randconfig-006-20260611    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260611    gcc-14
x86_64                randconfig-001-20260612    clang-22
x86_64                randconfig-002-20260611    gcc-14
x86_64                randconfig-002-20260612    clang-22
x86_64                randconfig-003-20260611    gcc-14
x86_64                randconfig-003-20260612    clang-22
x86_64                randconfig-004-20260611    gcc-14
x86_64                randconfig-004-20260612    clang-22
x86_64                randconfig-005-20260611    gcc-14
x86_64                randconfig-005-20260612    clang-22
x86_64                randconfig-006-20260611    gcc-14
x86_64                randconfig-006-20260612    clang-22
x86_64                         randconfig-011    clang-22
x86_64                randconfig-011-20260611    clang-22
x86_64                         randconfig-012    clang-22
x86_64                randconfig-012-20260611    clang-22
x86_64                         randconfig-013    clang-22
x86_64                randconfig-013-20260611    clang-22
x86_64                         randconfig-014    clang-22
x86_64                randconfig-014-20260611    clang-22
x86_64                         randconfig-015    clang-22
x86_64                randconfig-015-20260611    clang-22
x86_64                         randconfig-016    clang-22
x86_64                randconfig-016-20260611    clang-22
x86_64                randconfig-071-20260611    clang-22
x86_64                randconfig-071-20260612    gcc-14
x86_64                randconfig-072-20260611    clang-22
x86_64                randconfig-072-20260612    gcc-14
x86_64                randconfig-073-20260611    clang-22
x86_64                randconfig-073-20260612    gcc-14
x86_64                randconfig-074-20260611    clang-22
x86_64                randconfig-074-20260612    gcc-14
x86_64                randconfig-075-20260611    clang-22
x86_64                randconfig-075-20260612    gcc-14
x86_64                randconfig-076-20260611    clang-22
x86_64                randconfig-076-20260612    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260611    gcc-15.2.0
xtensa                randconfig-001-20260612    gcc-8.5.0
xtensa                randconfig-002-20260611    gcc-15.2.0
xtensa                randconfig-002-20260612    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

