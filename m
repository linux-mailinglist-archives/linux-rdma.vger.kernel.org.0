Return-Path: <linux-rdma+bounces-22810-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yfyMDKM8TGpViAEAu9opvQ
	(envelope-from <linux-rdma+bounces-22810-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 01:39:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C10D71654D
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 01:39:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=AFP+BaAc;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22810-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22810-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 409C1303C636
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2026 23:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82EA3C5833;
	Mon,  6 Jul 2026 23:39:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F22C3C455F
	for <linux-rdma@vger.kernel.org>; Mon,  6 Jul 2026 23:39:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783381152; cv=none; b=QnLVm9M+hik9dzhb/TT2jUSobt27x5TVvmduweCaBkfRYh5DfVVJ/AkM7UNU8gc0B4+qX6PAiVQzwK7cTdxQdn5ixpoL+GrUyrZAKf635pUoNbrU/7gbK/grlGydn9mgIuxZOpkSxD9rZe0msQPuBCtcmdvNzrWO+wCmUsMiEZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783381152; c=relaxed/simple;
	bh=FuEYljb+u1ryzD5xAyQjjtoKCNAb5GY0d2QtqT4Ejno=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TUr9LfHiRg2wKi5kBzn9ftdorpmLYoiQzRRa+WR4iEbQryFVdAfukhZ5/UkC3/kQUAWis788zxp/t6Xgv0jcAHAhKEguvJf/bai0nlmhwBejgdrW5clyCU93fE7n0/sm4QTdNkPJM38k9da1DZIqtv9fqs1VWgTVMVzaBkmGNhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AFP+BaAc; arc=none smtp.client-ip=192.198.163.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783381151; x=1814917151;
  h=date:from:to:cc:subject:message-id;
  bh=FuEYljb+u1ryzD5xAyQjjtoKCNAb5GY0d2QtqT4Ejno=;
  b=AFP+BaAcHz85DxudSm0LJ0ew+HdroGvEtbGANp3iBFyJa2O3ijxhvUSV
   YFER5j4ZSqsbJxjvdP6av5qkF6Ynts4j8J8/zOvER62kYwt4GLN323PgX
   FgSVAyPiRNDCjUdYPnlav8oPLMQPShHa1cS16c+dEP7oeiL6S7Vf6iHfq
   AJRzwsruc+VI76dq87TGqxonSDDkojbYPrDw6oDWEgxUAqC7X2mC+/BSs
   FauQIHWqp7FHFoE4sblXDVlbubwficsIpqWP+LstKSgfvinBnjJcUH5XZ
   zNjSU4LuEKmmMsBeVevVyVFZHwmgFyvjfsI+VaoWGhBAVFlJtiC6A7rUT
   Q==;
X-CSE-ConnectionGUID: 1NQIBRmARiyIh8su1/qL/g==
X-CSE-MsgGUID: Ka3mEpaQSbW10lB1tHuVnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="83001680"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="83001680"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 16:39:10 -0700
X-CSE-ConnectionGUID: yKZSZPNBRryMGRfr7OXkig==
X-CSE-MsgGUID: IA/PU7XVRHS0pLQxvHm7gA==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 06 Jul 2026 16:39:09 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wgsu0-00000000Eqt-2FPv;
	Mon, 06 Jul 2026 23:39:05 +0000
Date: Tue, 07 Jul 2026 07:39:02 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 5f9576c6734abca88a02db72c466e09d2eddf160
Message-ID: <202607070748.NGBo4u01-lkp@intel.com>
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
	TAGGED_FROM(0.00)[bounces-22810-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C10D71654D

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 5f9576c6734abca88a02db72c466e09d2eddf160  RDMA/bng_re: return a timeout when firmware responses stall

elapsed time: 883m

configs tested: 281
configs skipped: 13

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
arc                   randconfig-001-20260706    gcc-15.2.0
arc                   randconfig-002-20260706    gcc-15.2.0
arc                   randconfig-002-20260706    gcc-9.5.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260706    clang-23
arm                   randconfig-001-20260706    gcc-15.2.0
arm                   randconfig-002-20260706    gcc-15.2.0
arm                   randconfig-003-20260706    gcc-13.4.0
arm                   randconfig-003-20260706    gcc-15.2.0
arm                   randconfig-004-20260706    clang-23
arm                   randconfig-004-20260706    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260706    clang-17
arm64                 randconfig-001-20260706    gcc-11.5.0
arm64                 randconfig-002-20260706    clang-17
arm64                 randconfig-002-20260706    gcc-11.5.0
arm64                 randconfig-003-20260706    gcc-11.5.0
arm64                 randconfig-003-20260706    gcc-15.2.0
arm64                 randconfig-004-20260706    clang-17
arm64                 randconfig-004-20260706    gcc-11.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260706    gcc-11.5.0
csky                  randconfig-001-20260706    gcc-9.5.0
csky                  randconfig-002-20260706    gcc-11.5.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260706    clang-17
hexagon               randconfig-001-20260706    gcc-16.1.0
hexagon               randconfig-002-20260706    clang-23
hexagon               randconfig-002-20260706    gcc-16.1.0
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260706    clang-22
i386        buildonly-randconfig-001-20260706    gcc-12
i386        buildonly-randconfig-002-20260706    gcc-12
i386        buildonly-randconfig-003-20260706    clang-22
i386        buildonly-randconfig-003-20260706    gcc-12
i386        buildonly-randconfig-004-20260706    clang-22
i386        buildonly-randconfig-004-20260706    gcc-12
i386        buildonly-randconfig-005-20260706    clang-22
i386        buildonly-randconfig-005-20260706    gcc-12
i386        buildonly-randconfig-006-20260706    gcc-12
i386        buildonly-randconfig-006-20260706    gcc-14
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260706    clang-22
i386                  randconfig-001-20260706    gcc-14
i386                  randconfig-002-20260706    gcc-14
i386                  randconfig-003-20260706    gcc-14
i386                  randconfig-004-20260706    gcc-14
i386                  randconfig-005-20260706    clang-22
i386                  randconfig-005-20260706    gcc-14
i386                  randconfig-006-20260706    gcc-14
i386                  randconfig-007-20260706    clang-22
i386                  randconfig-007-20260706    gcc-14
i386                  randconfig-011-20260706    clang-22
i386                  randconfig-012-20260706    clang-22
i386                  randconfig-013-20260706    clang-22
i386                  randconfig-014-20260706    clang-22
i386                  randconfig-015-20260706    clang-22
i386                  randconfig-016-20260706    clang-22
i386                  randconfig-017-20260706    clang-22
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260706    gcc-16.1.0
loongarch             randconfig-002-20260706    gcc-16.1.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
m68k                                defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
microblaze                          defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260706    gcc-11.5.0
nios2                 randconfig-001-20260706    gcc-16.1.0
nios2                 randconfig-002-20260706    gcc-11.5.0
nios2                 randconfig-002-20260706    gcc-16.1.0
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
parisc                randconfig-001-20260706    gcc-10.5.0
parisc                randconfig-001-20260706    gcc-14.3.0
parisc                randconfig-002-20260706    gcc-10.5.0
parisc                randconfig-002-20260706    gcc-16.1.0
parisc64                            defconfig    clang-23
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                   lite5200b_defconfig    clang-23
powerpc               randconfig-001-20260706    gcc-10.5.0
powerpc               randconfig-001-20260706    gcc-9.5.0
powerpc               randconfig-002-20260706    gcc-10.5.0
powerpc               randconfig-002-20260706    gcc-15.2.0
powerpc64             randconfig-001-20260706    gcc-10.5.0
powerpc64             randconfig-001-20260706    gcc-11.5.0
powerpc64             randconfig-002-20260706    gcc-10.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    clang-23
riscv                 randconfig-001-20260706    clang-17
riscv                 randconfig-001-20260706    clang-23
riscv                          randconfig-002    clang-23
riscv                 randconfig-002-20260706    clang-23
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    clang-23
s390                  randconfig-001-20260706    clang-23
s390                           randconfig-002    clang-23
s390                  randconfig-002-20260706    clang-23
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-16.1.0
sh                             randconfig-001    clang-23
sh                    randconfig-001-20260706    clang-23
sh                    randconfig-001-20260706    gcc-16.1.0
sh                             randconfig-002    clang-23
sh                    randconfig-002-20260706    clang-23
sh                    randconfig-002-20260706    gcc-16.1.0
sh                           se7206_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                          randconfig-001    gcc-16.1.0
sparc                 randconfig-001-20260706    gcc-12.5.0
sparc                 randconfig-001-20260706    gcc-14.3.0
sparc                          randconfig-002    gcc-11.5.0
sparc                 randconfig-002-20260706    gcc-14.3.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-12.5.0
sparc64               randconfig-001-20260706    gcc-14.3.0
sparc64               randconfig-001-20260706    gcc-16.1.0
sparc64                        randconfig-002    clang-20
sparc64               randconfig-002-20260706    gcc-14.3.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    clang-23
um                    randconfig-001-20260706    gcc-14
um                    randconfig-001-20260706    gcc-14.3.0
um                             randconfig-002    clang-23
um                    randconfig-002-20260706    gcc-14
um                    randconfig-002-20260706    gcc-14.3.0
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260706    clang-22
x86_64      buildonly-randconfig-001-20260706    gcc-14
x86_64      buildonly-randconfig-002-20260706    gcc-14
x86_64      buildonly-randconfig-003-20260706    gcc-14
x86_64      buildonly-randconfig-004-20260706    gcc-14
x86_64      buildonly-randconfig-005-20260706    gcc-14
x86_64      buildonly-randconfig-006-20260706    clang-22
x86_64      buildonly-randconfig-006-20260706    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                         randconfig-001    clang-22
x86_64                         randconfig-001    gcc-14
x86_64                randconfig-001-20260706    clang-22
x86_64                randconfig-001-20260706    gcc-14
x86_64                         randconfig-002    clang-22
x86_64                         randconfig-002    gcc-14
x86_64                randconfig-002-20260706    clang-22
x86_64                         randconfig-003    clang-22
x86_64                randconfig-003-20260706    clang-22
x86_64                         randconfig-004    clang-22
x86_64                randconfig-004-20260706    clang-22
x86_64                randconfig-004-20260706    gcc-14
x86_64                         randconfig-005    clang-22
x86_64                         randconfig-005    gcc-14
x86_64                randconfig-005-20260706    clang-22
x86_64                         randconfig-006    clang-22
x86_64                randconfig-006-20260706    clang-22
x86_64                randconfig-006-20260706    gcc-13
x86_64                         randconfig-011    gcc-14
x86_64                randconfig-011-20260706    clang-22
x86_64                randconfig-011-20260706    gcc-14
x86_64                         randconfig-012    gcc-14
x86_64                randconfig-012-20260706    clang-22
x86_64                randconfig-012-20260706    gcc-14
x86_64                         randconfig-013    clang-22
x86_64                randconfig-013-20260706    gcc-14
x86_64                         randconfig-014    gcc-14
x86_64                randconfig-014-20260706    gcc-12
x86_64                randconfig-014-20260706    gcc-14
x86_64                         randconfig-015    gcc-14
x86_64                randconfig-015-20260706    gcc-14
x86_64                         randconfig-016    clang-22
x86_64                randconfig-016-20260706    gcc-12
x86_64                randconfig-016-20260706    gcc-14
x86_64                randconfig-071-20260706    gcc-14
x86_64                randconfig-072-20260706    gcc-14
x86_64                randconfig-073-20260706    gcc-14
x86_64                randconfig-074-20260706    gcc-14
x86_64                randconfig-075-20260706    gcc-14
x86_64                randconfig-076-20260706    gcc-14
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
xtensa                           allyesconfig    gcc-16.1.0
xtensa                         randconfig-001    gcc-8.5.0
xtensa                randconfig-001-20260706    gcc-14.3.0
xtensa                randconfig-001-20260706    gcc-16.1.0
xtensa                         randconfig-002    gcc-13.4.0
xtensa                randconfig-002-20260706    gcc-14.3.0
xtensa                randconfig-002-20260706    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

