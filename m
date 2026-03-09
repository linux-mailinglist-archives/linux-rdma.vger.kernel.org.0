Return-Path: <linux-rdma+bounces-17741-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ME4VCHAmrmkdAAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17741-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 02:46:24 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC601233145
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 02:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B9FEA30066BC
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 01:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6DA1E9919;
	Mon,  9 Mar 2026 01:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KVvneMyx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661FAF9C0
	for <linux-rdma@vger.kernel.org>; Mon,  9 Mar 2026 01:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773020780; cv=none; b=jUsuTrEsO0ApGu1nDQFAtdlGvBtEorB9Xu1lTIJYp2HoJwNnUV0/EoAtDoZvt+ivop9rkwWRAVYQSDMIUnZTHqLqdrGauAlS/LIf2h055KTGr36Mu4fWGB8DwR7uxHSbW4O54yV8DvxO/N6XQoDIdM7jzsFdrUGVWOhJv7expX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773020780; c=relaxed/simple;
	bh=eXBBhhwTaJa70rk8BLeZKyWHQma+TnoYLcIBQNsHNCk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Iii81ccHP8nzPNeGtRL83UaeDMdArXfwATizxVrbJEUfC8uyh6mkvx0xRXmUHGchQmtXvXWjbo7KmjcMjfG99MyabLWyxgtMexLEiqxQV8MFnt4Yfdo/A3J0vpup3lR64AgxqvXvdL26Nze7xqIy4auyDRtaISWW0lEAqWDCxIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KVvneMyx; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773020778; x=1804556778;
  h=date:from:to:cc:subject:message-id;
  bh=eXBBhhwTaJa70rk8BLeZKyWHQma+TnoYLcIBQNsHNCk=;
  b=KVvneMyxiZUZ3urXmHPIA++3yY8+s/U/J1r3j44YyZEiMXNiESElv6EL
   3igXfKJ+N3IPjeDlR4IBl7N21vQgXEISqDHHo0MUY1wMUUOvv92UbWXJ8
   MiXgV+KPjCsSyAYXYXDW06cwJ8czRfvs5ZD1qet8jHuG6eNeDp3WCFhxc
   Do+uuVeF3LJWQQz2BmxKGlHd/tfMchM64HYp//e5VMnM1inWk9TrOPlsQ
   gaKKia5upNeXcvuJzNYc4ol5H7Vs1xTaJF/ZdGjploiI5dnqwW3aK17r5
   BVZOWdBjGYJoeQMIB5OV1ufut3sqN60lt4CxrcVT30+E+ACjsT+FEAcZo
   Q==;
X-CSE-ConnectionGUID: gXyUes/3S3y66i3dk4FsHw==
X-CSE-MsgGUID: z5ONOMFKRp+IyPXsMWgIPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="74152259"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="74152259"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 18:46:17 -0700
X-CSE-ConnectionGUID: vtNgHQN7Ss6wMT6nwriK5w==
X-CSE-MsgGUID: Lx5jGxnITIiguYjhlYY5zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="216589159"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 08 Mar 2026 18:46:16 -0700
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vzPhF-000000003Xo-1Swm;
	Mon, 09 Mar 2026 01:46:13 +0000
Date: Mon, 09 Mar 2026 09:46:03 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 5c3f6de46d6a556e0e6c060b7fed812b5fd4f951
Message-ID: <202603090956.39PDGMO5-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: AC601233145
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17741-lists,linux-rdma=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 5c3f6de46d6a556e0e6c060b7fed812b5fd4f951  RDMA/irdma: Add support for revocable pinned dmabuf import

elapsed time: 770m

configs tested: 222
configs skipped: 5

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
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260308    clang-23
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
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260309    gcc-14
i386                  randconfig-002-20260309    gcc-14
i386                  randconfig-003-20260309    gcc-14
i386                  randconfig-004-20260309    gcc-14
i386                  randconfig-005-20260309    gcc-14
i386                  randconfig-006-20260309    gcc-14
i386                  randconfig-007-20260309    gcc-14
i386                  randconfig-011-20260308    clang-20
i386                  randconfig-012-20260308    clang-20
i386                  randconfig-013-20260308    clang-20
i386                  randconfig-014-20260308    clang-20
i386                  randconfig-015-20260308    clang-20
i386                  randconfig-016-20260308    clang-20
i386                  randconfig-017-20260308    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260308    clang-23
loongarch             randconfig-002-20260308    clang-23
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
nios2                 randconfig-001-20260308    clang-23
nios2                 randconfig-002-20260308    clang-23
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
parisc                randconfig-001-20260308    gcc-8.5.0
parisc                randconfig-002-20260308    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260308    clang-23
powerpc               randconfig-001-20260308    gcc-8.5.0
powerpc               randconfig-002-20260308    gcc-8.5.0
powerpc64             randconfig-001-20260308    clang-23
powerpc64             randconfig-001-20260308    gcc-8.5.0
powerpc64             randconfig-002-20260308    clang-23
powerpc64             randconfig-002-20260308    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260308    gcc-12.5.0
riscv                 randconfig-002-20260308    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260308    gcc-12.5.0
s390                  randconfig-002-20260308    gcc-12.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260308    gcc-12.5.0
sh                    randconfig-002-20260308    gcc-12.5.0
sh                            titan_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260308    gcc-15.2.0
sparc                 randconfig-001-20260308    gcc-8.5.0
sparc                 randconfig-002-20260308    gcc-11.5.0
sparc                 randconfig-002-20260308    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260308    clang-20
sparc64               randconfig-001-20260308    gcc-15.2.0
sparc64               randconfig-002-20260308    gcc-15.2.0
sparc64               randconfig-002-20260308    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260308    gcc-14
um                    randconfig-001-20260308    gcc-15.2.0
um                    randconfig-002-20260308    gcc-14
um                    randconfig-002-20260308    gcc-15.2.0
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260308    clang-20
x86_64      buildonly-randconfig-002-20260308    clang-20
x86_64      buildonly-randconfig-003-20260308    clang-20
x86_64      buildonly-randconfig-004-20260308    clang-20
x86_64      buildonly-randconfig-005-20260308    clang-20
x86_64      buildonly-randconfig-006-20260308    clang-20
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
x86_64                randconfig-012-20260308    clang-20
x86_64                randconfig-013-20260308    clang-20
x86_64                randconfig-014-20260308    clang-20
x86_64                randconfig-015-20260308    clang-20
x86_64                randconfig-016-20260308    clang-20
x86_64                randconfig-071-20260308    clang-20
x86_64                randconfig-071-20260309    gcc-14
x86_64                randconfig-072-20260308    clang-20
x86_64                randconfig-072-20260309    gcc-14
x86_64                randconfig-073-20260308    clang-20
x86_64                randconfig-073-20260309    gcc-14
x86_64                randconfig-074-20260308    gcc-14
x86_64                randconfig-075-20260308    clang-20
x86_64                randconfig-075-20260309    gcc-14
x86_64                randconfig-076-20260308    gcc-14
x86_64                randconfig-076-20260309    gcc-14
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

