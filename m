Return-Path: <linux-rdma+bounces-22742-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mungCIWER2rlZwAAu9opvQ
	(envelope-from <linux-rdma+bounces-22742-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Jul 2026 11:44:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F0C700C5A
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Jul 2026 11:44:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=JPOXTtGi;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22742-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22742-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B4C63015879
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jul 2026 09:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21073B3BF1;
	Fri,  3 Jul 2026 09:44:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34703B27DE
	for <linux-rdma@vger.kernel.org>; Fri,  3 Jul 2026 09:44:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783071862; cv=none; b=Q8uBpQcrNKhnRSqC6pkpK1fgVj0txpTW4phS3QvcHgVhvVHwpXcDp6SwnHdMOAmru4qvrHWEYKWR+k01rsseqgSsxElSVn+ZQNBFA9GKj5xIDIJjsXzsMZ7gITxQLaJjuYyYb7wSdHuPR8Aew1IEBya5UFF3GikQbCMAYhs/kpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783071862; c=relaxed/simple;
	bh=ZOZo+/bxhTiaKB4pGlbvfh3EGcIfcppVRAUT7nHNew4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=a+ZVWn9q0xu1+Pva0OxJEDJAck+dW9UCcBbdFbsxKvRpUBnOZkdH1XYJOBWRohnjTUGE20IFtdK1lERO1Zl9CxNAH/h43lFB+qi5wZSSgkX1ytzdIEGnFIx7kY88UCcPdGyn6/EuUBdMkK/hctCQTBzJ1N+qkh7UhoMlQZ5x6YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JPOXTtGi; arc=none smtp.client-ip=192.198.163.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783071859; x=1814607859;
  h=date:from:to:cc:subject:message-id;
  bh=ZOZo+/bxhTiaKB4pGlbvfh3EGcIfcppVRAUT7nHNew4=;
  b=JPOXTtGiKNpY3S2aFhmobacFyCbOFBfS5xIe+h27mfzPNOSmfFcCQiR+
   cCc2fITqCWxQovGYPDjo4EfqDkU8Ejx7W1WZjx0AtWBnerncIY5dB/eAm
   +hbgBd9h20vpSotppxrkNQW96XVY69gmVrSRtCytYVzlQLKhG44JenBS4
   yrY3I2WUmYTrGf4yei25CXcm9AdtNV1ChlMeTQ2uDT9/jBJyVLYlZwaOS
   37mcnvi8WNIRdolOaH94TjsRPXO0kjj7tgsIdU20IgY5bN5lsJqYdFG35
   q23AH1Q4Mzbj9twqfTpuYpLGSmpxE2JRY1CznO4ciWqOZHNLfT7ARcC/z
   A==;
X-CSE-ConnectionGUID: TX/cZ0LtTdaPUWv6Ryrchg==
X-CSE-MsgGUID: GHJzSMgySBmoxpjZADPAPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83690589"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="83690589"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 02:44:15 -0700
X-CSE-ConnectionGUID: NzQUIlJKQKavsMjDhNL9ow==
X-CSE-MsgGUID: sZfLo78+RvyWDMzpvkJrdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="256653940"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 03 Jul 2026 02:44:15 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wfaRQ-00000000Bw9-1M4v;
	Fri, 03 Jul 2026 09:44:12 +0000
Date: Fri, 03 Jul 2026 17:43:53 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 a846aecb931b4d65d5eafa92a0623545af46d4f2
Message-ID: <202607031742.P2up2CTT-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22742-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,lists];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:dkim,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D9F0C700C5A

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: a846aecb931b4d65d5eafa92a0623545af46d4f2  RDMA/irdma: Prevent rereg_mr for non-mem regions

elapsed time: 729m

configs tested: 209
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
arc                   randconfig-001-20260703    gcc-8.5.0
arc                   randconfig-002-20260703    gcc-8.5.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                         mv78xx0_defconfig    clang-23
arm                        mvebu_v7_defconfig    clang-23
arm                   randconfig-001-20260703    gcc-8.5.0
arm                   randconfig-002-20260703    gcc-8.5.0
arm                   randconfig-003-20260703    gcc-8.5.0
arm                   randconfig-004-20260703    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    gcc-10.5.0
arm64                 randconfig-001-20260703    gcc-10.5.0
arm64                          randconfig-002    gcc-10.5.0
arm64                 randconfig-002-20260703    gcc-10.5.0
arm64                          randconfig-003    gcc-10.5.0
arm64                 randconfig-003-20260703    gcc-10.5.0
arm64                          randconfig-004    gcc-10.5.0
arm64                 randconfig-004-20260703    gcc-10.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    gcc-10.5.0
csky                  randconfig-001-20260703    gcc-10.5.0
csky                           randconfig-002    gcc-10.5.0
csky                  randconfig-002-20260703    gcc-10.5.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260703    gcc-16.1.0
hexagon               randconfig-002-20260703    gcc-16.1.0
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                 buildonly-randconfig-001    clang-22
i386        buildonly-randconfig-001-20260703    clang-22
i386                 buildonly-randconfig-002    clang-22
i386        buildonly-randconfig-002-20260703    clang-22
i386                 buildonly-randconfig-003    clang-22
i386        buildonly-randconfig-003-20260703    clang-22
i386                 buildonly-randconfig-004    clang-22
i386        buildonly-randconfig-004-20260703    clang-22
i386                 buildonly-randconfig-005    clang-22
i386        buildonly-randconfig-005-20260703    clang-22
i386                 buildonly-randconfig-006    clang-22
i386        buildonly-randconfig-006-20260703    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260703    clang-22
i386                  randconfig-002-20260703    clang-22
i386                  randconfig-003-20260703    clang-22
i386                  randconfig-004-20260703    clang-22
i386                  randconfig-005-20260703    clang-22
i386                  randconfig-006-20260703    clang-22
i386                  randconfig-007-20260703    clang-22
i386                  randconfig-011-20260703    clang-22
i386                  randconfig-012-20260703    clang-22
i386                  randconfig-013-20260703    clang-22
i386                  randconfig-014-20260703    clang-22
i386                  randconfig-015-20260703    clang-22
i386                  randconfig-016-20260703    clang-22
i386                  randconfig-017-20260703    clang-22
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260703    gcc-16.1.0
loongarch             randconfig-002-20260703    gcc-16.1.0
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
mips                     eyeq6lplus_defconfig    gcc-16.1.0
mips                           ip28_defconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-23
nios2                 randconfig-001-20260703    gcc-16.1.0
nios2                 randconfig-002-20260703    gcc-16.1.0
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260703    clang-23
parisc                randconfig-002-20260703    clang-23
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                     asp8347_defconfig    clang-23
powerpc               randconfig-001-20260703    clang-23
powerpc               randconfig-002-20260703    clang-23
powerpc64             randconfig-001-20260703    clang-23
powerpc64             randconfig-002-20260703    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260703    gcc-9.5.0
riscv                 randconfig-002-20260703    gcc-9.5.0
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260703    gcc-9.5.0
s390                  randconfig-002-20260703    gcc-9.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260703    gcc-9.5.0
sh                    randconfig-002-20260703    gcc-9.5.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260703    gcc-11.5.0
sparc                 randconfig-001-20260703    gcc-13.4.0
sparc                 randconfig-002-20260703    gcc-11.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260703    gcc-11.5.0
sparc64               randconfig-001-20260703    gcc-8.5.0
sparc64               randconfig-002-20260703    gcc-11.5.0
sparc64               randconfig-002-20260703    gcc-15.2.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260703    clang-19
um                    randconfig-001-20260703    gcc-11.5.0
um                    randconfig-002-20260703    clang-17
um                    randconfig-002-20260703    gcc-11.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    gcc-14
x86_64      buildonly-randconfig-001-20260703    gcc-14
x86_64               buildonly-randconfig-002    gcc-14
x86_64      buildonly-randconfig-002-20260703    gcc-14
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20260703    gcc-14
x86_64               buildonly-randconfig-004    gcc-14
x86_64      buildonly-randconfig-004-20260703    gcc-14
x86_64               buildonly-randconfig-005    gcc-14
x86_64      buildonly-randconfig-005-20260703    gcc-14
x86_64               buildonly-randconfig-006    gcc-14
x86_64      buildonly-randconfig-006-20260703    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                         randconfig-001    clang-22
x86_64                randconfig-001-20260703    clang-22
x86_64                randconfig-001-20260703    gcc-14
x86_64                         randconfig-002    clang-22
x86_64                randconfig-002-20260703    clang-22
x86_64                         randconfig-003    clang-22
x86_64                randconfig-003-20260703    clang-22
x86_64                         randconfig-004    clang-22
x86_64                randconfig-004-20260703    clang-22
x86_64                randconfig-004-20260703    gcc-12
x86_64                         randconfig-005    clang-22
x86_64                randconfig-005-20260703    clang-22
x86_64                randconfig-005-20260703    gcc-14
x86_64                         randconfig-006    clang-22
x86_64                randconfig-006-20260703    clang-22
x86_64                randconfig-011-20260703    gcc-14
x86_64                randconfig-012-20260703    gcc-14
x86_64                randconfig-013-20260703    gcc-14
x86_64                randconfig-014-20260703    gcc-14
x86_64                randconfig-015-20260703    gcc-14
x86_64                randconfig-016-20260703    gcc-14
x86_64                randconfig-071-20260703    clang-22
x86_64                randconfig-072-20260703    clang-22
x86_64                randconfig-073-20260703    clang-22
x86_64                randconfig-074-20260703    clang-22
x86_64                randconfig-075-20260703    clang-22
x86_64                randconfig-076-20260703    clang-22
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-20
xtensa                       common_defconfig    gcc-16.1.0
xtensa                randconfig-001-20260703    gcc-11.5.0
xtensa                randconfig-002-20260703    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

