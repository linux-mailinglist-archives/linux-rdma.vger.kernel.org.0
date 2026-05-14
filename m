Return-Path: <linux-rdma+bounces-20739-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJiTNAJgBmoMjQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20739-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 01:51:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EB1547D80
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 01:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B00B9302571B
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 23:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392573955D9;
	Thu, 14 May 2026 23:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RhBXA1dM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF23D531
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 23:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778802682; cv=none; b=AdU5soZ2goYS+6NZ2zX2e7+c2SBwDJzHmwAdf7OYLA8Vdl/ke5BhUaZJ7pjTd46Kd2tk98VNKrkwGTMR/oFtzLW90bNmwbbTRl+evVkUczrBpR2qsqRvU+F/YFHSigjITIfMJuxxh8AJ70JrybUyMGWKhOyEI3TgtWhuNV0YQXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778802682; c=relaxed/simple;
	bh=r7ws6NWQkaqVgc5PHZvEv+0g34MgP1lUmuQ7XATPyWs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=thXAOLcmqP/TUaB0HQ3m4pi6sql3y6umY0fEZxnx8IwQTn6Kjj1goo+tIt8yRMa8G8lUAPQJqYQf9kvSJsQ9xtI/MCwtbvYAKQnpCMNbeJL4glIXaK3SuggfFaYrkaGNmbF00OZYg/l5LEVHNCA6h6u3tvL9XE6f6m9jP9z6ZWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RhBXA1dM; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778802681; x=1810338681;
  h=date:from:to:cc:subject:message-id;
  bh=r7ws6NWQkaqVgc5PHZvEv+0g34MgP1lUmuQ7XATPyWs=;
  b=RhBXA1dMQGHz35W54IBLMMnrOJ2Vefu3HgCm6R/bXZPY/AldzfBXef+X
   0QmbSpVDzIgeKXgQf7Z1AJa2NnXEbznBIirDTS/PP2yNr/lquvQKJy3gE
   FGmkJu/9n9f3tklt168SSGF7R+OyqOn/aCqYDB1Jm9xVOG3kUtFI+yUzl
   5ZLvWkiv/blEhapJaHCr0xC6sgYgCdtc7zk7fbO4nuVBf2clFHenOkFp9
   B+Jv8yhDWss7K150Yupdv+SEY3SdU7QD9IpfriqtQ1+AvJ0+416Kxy1Xs
   QGWmZzTxN+6gk3454AQw9bEBghaqAQWd0NSSLrLrinbRQ3+FiTRZ5icA1
   w==;
X-CSE-ConnectionGUID: eeBzlFxYSsuBbcHc2x4ftw==
X-CSE-MsgGUID: Nub6eFh+R5mBjEhYokNgqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79876424"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="79876424"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 16:51:20 -0700
X-CSE-ConnectionGUID: E/qPNP29RfiGVfdFDk9qcQ==
X-CSE-MsgGUID: gwyo3xWsRD6cdR/w0aJI0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="232131548"
Received: from lkp-server02.sh.intel.com (HELO 7a33ad3e7d27) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 14 May 2026 16:51:18 -0700
Received: from kbuild by 7a33ad3e7d27 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNfpj-000000000My-3Xtt;
	Thu, 14 May 2026 23:51:15 +0000
Date: Fri, 15 May 2026 07:34:05 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 be4bca92cb86a6f26556c72906a2a2286862b249
Message-ID: <202605150745.CYay6K9u-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 37EB1547D80
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20739-lists,linux-rdma=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,lists];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: be4bca92cb86a6f26556c72906a2a2286862b249  RDMA: Replace memset with = {} pattern for ib_respond_udata()

elapsed time: 887m

configs tested: 130
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260514    gcc-8.5.0
arc                   randconfig-002-20260514    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260514    gcc-8.5.0
arm                   randconfig-002-20260514    clang-23
arm                   randconfig-003-20260514    gcc-8.5.0
arm                   randconfig-004-20260514    gcc-10.5.0
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260515    clang-16
arm64                 randconfig-002-20260515    gcc-10.5.0
arm64                 randconfig-003-20260515    gcc-11.5.0
arm64                 randconfig-004-20260515    gcc-11.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260515    gcc-10.5.0
csky                  randconfig-002-20260515    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260514    clang-16
hexagon               randconfig-002-20260514    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20260515    gcc-14
i386        buildonly-randconfig-002-20260515    gcc-14
i386        buildonly-randconfig-003-20260515    gcc-12
i386        buildonly-randconfig-004-20260515    gcc-12
i386        buildonly-randconfig-005-20260515    gcc-14
i386        buildonly-randconfig-006-20260515    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260515    clang-20
i386                  randconfig-002-20260515    clang-20
i386                  randconfig-003-20260515    clang-20
i386                  randconfig-004-20260515    clang-20
i386                  randconfig-005-20260515    clang-20
i386                  randconfig-006-20260515    gcc-14
i386                  randconfig-007-20260515    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260514    gcc-14.3.0
loongarch             randconfig-002-20260514    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260514    gcc-11.5.0
nios2                 randconfig-002-20260514    gcc-10.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260515    gcc-10.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc                 mpc836x_rdk_defconfig    clang-23
powerpc               randconfig-002-20260515    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260514    gcc-12.5.0
riscv                 randconfig-002-20260514    clang-20
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260514    gcc-11.5.0
s390                  randconfig-002-20260514    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260514    gcc-10.5.0
sh                    randconfig-002-20260514    gcc-14.3.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260515    gcc-8.5.0
sparc                 randconfig-002-20260515    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260515    clang-20
sparc64               randconfig-002-20260515    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260515    gcc-14
um                    randconfig-002-20260515    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260514    gcc-14
x86_64      buildonly-randconfig-002-20260514    clang-20
x86_64      buildonly-randconfig-003-20260514    gcc-14
x86_64      buildonly-randconfig-004-20260514    clang-20
x86_64      buildonly-randconfig-005-20260514    clang-20
x86_64      buildonly-randconfig-006-20260514    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260515    gcc-9.5.0
xtensa                randconfig-002-20260515    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

