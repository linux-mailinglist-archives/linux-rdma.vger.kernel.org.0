Return-Path: <linux-rdma+bounces-22578-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XdH9MbV6Q2qHZAoAu9opvQ
	(envelope-from <linux-rdma+bounces-22578-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 10:13:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4B26E1928
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 10:13:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=CT9d4f0M;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22578-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22578-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D281C3001A64
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 08:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7A83B42ED;
	Tue, 30 Jun 2026 08:13:36 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2B23659FB
	for <linux-rdma@vger.kernel.org>; Tue, 30 Jun 2026 08:13:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782807216; cv=none; b=pbogzR41u1CPdYI4z9rK3STQcDI9tQxbCD/TOLCp9y6dgTjVQ2O6ykxu+qP1KdOC37mu7XMywYmW4apTt4tNcf2KXEOFLeDlPs+sGawf5lfErAxJMF5mMmYX0w/jBk3zlGXWOGL5QQp7PEdLKIGnFnRAXj6q/MkIHX8JzgOdovw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782807216; c=relaxed/simple;
	bh=TB5FeDiPTL+/HS/dWP88bwq7e6hb4InduOhejtmqYwE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kNxNjQsWznhH/iKv8Uc5hC59YAs2qNbfZcwTjPWu4mhPmMC5qS09CmxJ0Jdth6XMus6ZFqCMB+AVVZiyWj2t8oVUCFKR1SyBBFBN4y1K8Byq3O0rHf8BgZB2S286kigtsBN5QKZyfy32uQscop4NdPufg10OKW8KYjR1ZMq21J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CT9d4f0M; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782807214; x=1814343214;
  h=date:from:to:cc:subject:message-id;
  bh=TB5FeDiPTL+/HS/dWP88bwq7e6hb4InduOhejtmqYwE=;
  b=CT9d4f0M8y2n4qms/Ty3MOyGT8LbVARV/27TW02nr33/Mgb/jkaCLXa6
   io5SqEh/dsWypoc5/YnVU6BXEhUd83huMNHduflOw/M+7Zok3Y8kWSBVp
   8lR2t/HJzxYeS5/NJlTDWRQj5z9Iw/1odinbeWZQtFYb3L6/a5ixaMktB
   Nx5qIMHSc+eR0MzMLCGgVBBmm2Rk7PMJvI5vG5DS66BQghoU+JWLqgSyZ
   KzAIzlx4PT35hKOHvEL788vOGgHljvpgOwWmp/OYAa9plTcLi/ovfX0RA
   KOgovtLM3Lf+6yu3mKQZNe1eYxxfAmN37XdfWl3qX9afSbD+DL9l9XH21
   w==;
X-CSE-ConnectionGUID: eA0HjO3hT5iwn1ReTkRDKQ==
X-CSE-MsgGUID: Gphazor4Qqy76XgI0ci+lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="101057827"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="101057827"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 01:13:33 -0700
X-CSE-ConnectionGUID: ibo5y6N+SC+oxMRHJI7ilA==
X-CSE-MsgGUID: /2KwvDNJTKKTebH9IGYETg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="249556785"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 30 Jun 2026 01:13:32 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1weTaz-0000000086u-14NX;
	Tue, 30 Jun 2026 08:13:29 +0000
Date: Tue, 30 Jun 2026 16:12:23 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 d2e52d610b9b09694261632340b801a421e0b0c5
Message-ID: <202606301612.XBQTFWXL-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22578-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,lists];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:dkim,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD4B26E1928

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: d2e52d610b9b09694261632340b801a421e0b0c5  IB/mad: Drop unmatched RMPP responses before reassembly

elapsed time: 725m

configs tested: 198
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
arc                   randconfig-001-20260630    clang-23
arc                   randconfig-002-20260630    clang-23
arc                    vdk_hs38_smp_defconfig    gcc-16.1.0
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260630    clang-23
arm                   randconfig-002-20260630    clang-23
arm                   randconfig-003-20260630    clang-23
arm                   randconfig-004-20260630    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260630    clang-23
arm64                 randconfig-002-20260630    clang-23
arm64                 randconfig-003-20260630    clang-23
arm64                 randconfig-004-20260630    clang-23
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260630    clang-23
csky                  randconfig-002-20260630    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260630    clang-18
hexagon               randconfig-002-20260630    clang-18
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260630    clang-22
i386        buildonly-randconfig-002-20260630    clang-22
i386        buildonly-randconfig-003-20260630    clang-22
i386        buildonly-randconfig-004-20260630    clang-22
i386        buildonly-randconfig-005-20260630    clang-22
i386        buildonly-randconfig-006-20260630    clang-22
i386                                defconfig    gcc-16.1.0
i386                           randconfig-001    clang-22
i386                  randconfig-001-20260630    clang-22
i386                           randconfig-002    clang-22
i386                  randconfig-002-20260630    clang-22
i386                           randconfig-003    clang-22
i386                  randconfig-003-20260630    clang-22
i386                           randconfig-004    clang-22
i386                  randconfig-004-20260630    clang-22
i386                           randconfig-005    clang-22
i386                  randconfig-005-20260630    clang-22
i386                           randconfig-006    clang-22
i386                  randconfig-006-20260630    clang-22
i386                           randconfig-007    clang-22
i386                  randconfig-007-20260630    clang-22
i386                  randconfig-011-20260630    gcc-12
i386                  randconfig-012-20260630    gcc-12
i386                  randconfig-013-20260630    gcc-12
i386                  randconfig-014-20260630    gcc-12
i386                  randconfig-015-20260630    gcc-12
i386                  randconfig-016-20260630    gcc-12
i386                  randconfig-017-20260630    gcc-12
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260630    clang-18
loongarch             randconfig-002-20260630    clang-18
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
mips                        qi_lb60_defconfig    clang-17
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-23
nios2                 randconfig-001-20260630    clang-18
nios2                 randconfig-002-20260630    clang-18
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    clang-22
parisc                randconfig-001-20260630    clang-22
parisc                         randconfig-002    clang-22
parisc                randconfig-002-20260630    clang-22
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                        randconfig-001    clang-22
powerpc               randconfig-001-20260630    clang-22
powerpc                        randconfig-002    clang-22
powerpc               randconfig-002-20260630    clang-22
powerpc                        warp_defconfig    gcc-16.1.0
powerpc64                      randconfig-001    clang-22
powerpc64             randconfig-001-20260630    clang-22
powerpc64                      randconfig-002    clang-22
powerpc64             randconfig-002-20260630    clang-22
riscv                            alldefconfig    gcc-16.1.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260630    gcc-9.5.0
riscv                 randconfig-002-20260630    gcc-9.5.0
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260630    gcc-9.5.0
s390                  randconfig-002-20260630    gcc-9.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260630    gcc-9.5.0
sh                    randconfig-002-20260630    gcc-9.5.0
sh                          rsk7201_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260630    clang-17
sparc                 randconfig-002-20260630    clang-17
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260630    clang-17
sparc64               randconfig-002-20260630    clang-17
um                               allmodconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260630    clang-17
um                    randconfig-002-20260630    clang-17
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    clang-22
x86_64      buildonly-randconfig-001-20260630    clang-22
x86_64               buildonly-randconfig-002    clang-22
x86_64      buildonly-randconfig-002-20260630    clang-22
x86_64               buildonly-randconfig-003    clang-22
x86_64      buildonly-randconfig-003-20260630    clang-22
x86_64               buildonly-randconfig-004    clang-22
x86_64      buildonly-randconfig-004-20260630    clang-22
x86_64               buildonly-randconfig-005    clang-22
x86_64      buildonly-randconfig-005-20260630    clang-22
x86_64               buildonly-randconfig-006    clang-22
x86_64      buildonly-randconfig-006-20260630    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                         randconfig-001    gcc-14
x86_64                randconfig-001-20260630    gcc-14
x86_64                         randconfig-002    gcc-14
x86_64                randconfig-002-20260630    gcc-14
x86_64                         randconfig-003    gcc-14
x86_64                randconfig-003-20260630    gcc-14
x86_64                         randconfig-004    gcc-14
x86_64                randconfig-004-20260630    gcc-14
x86_64                         randconfig-005    gcc-14
x86_64                randconfig-005-20260630    gcc-14
x86_64                         randconfig-006    gcc-14
x86_64                randconfig-006-20260630    gcc-14
x86_64                randconfig-011-20260630    gcc-14
x86_64                randconfig-012-20260630    gcc-14
x86_64                randconfig-013-20260630    gcc-14
x86_64                randconfig-014-20260630    gcc-14
x86_64                randconfig-015-20260630    gcc-14
x86_64                randconfig-016-20260630    gcc-14
x86_64                randconfig-071-20260630    clang-22
x86_64                randconfig-072-20260630    clang-22
x86_64                randconfig-073-20260630    clang-22
x86_64                randconfig-074-20260630    clang-22
x86_64                randconfig-075-20260630    clang-22
x86_64                randconfig-076-20260630    clang-22
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260630    clang-17
xtensa                randconfig-002-20260630    clang-17

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

