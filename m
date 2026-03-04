Return-Path: <linux-rdma+bounces-17500-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFO4JZmUqGkLvwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17500-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 21:22:49 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AF5207919
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 21:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8F9330158AE
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 20:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62A136C0B4;
	Wed,  4 Mar 2026 20:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="inZVAc4R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA2F34CFB2
	for <linux-rdma@vger.kernel.org>; Wed,  4 Mar 2026 20:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772655692; cv=none; b=SXASERxKWP7s7emzIDDEl4xLvTo4BFyye3nJOM2afbuwy72ZZIu6oagEJKVgc+CY4zU+ycnhQntVi2v6TCzyN8csAFL23YQcvLnVJrIGwRcuLX3RwAwFq1z4c4/nY9bC7S4lxwUM1equVdJ26StDarmHEy/USmVIJB7m6/3Tx2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772655692; c=relaxed/simple;
	bh=kRK/S/V3ynm1LUHEmV91nT5KtXEUtiGtLLq+c3iBFgo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=j/b1lVfklUFO+SZd5Oy/4I/bOwdmGggCH1x+p/T4Ng/rGm1LiWWb7oEY/tSPA9aLfDRT3unTQYG0p1cqnAVm/gyHbwpdUlSZf534rhCmQGuLaH6bjzjAhRuuC5yC302kiW10++LGVOUSe8A2a5PMpa+tImJRTASq0Vi5H4FJO2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=inZVAc4R; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772655692; x=1804191692;
  h=date:from:to:cc:subject:message-id;
  bh=kRK/S/V3ynm1LUHEmV91nT5KtXEUtiGtLLq+c3iBFgo=;
  b=inZVAc4R2TS19uZG3xPgAPWZvqYgP66NURAqG3kw8YMdA/5hkETzNTqW
   iruQbXK7cC1CCJkK2Pw4JbwYiq3dXPmb8LgA0TJ0vsIZLc4C56Vq/aGg6
   4eJ/4AQLVCaZS8UKZPERKstiW0XZVJB4LJaMcdJxrrf/6fjzurUnB0Ydw
   amAIkAyyOSrmZ5d0YVCUWA9mw5LOw6xcRX+Qo9iTtH+QyuxWBa3YjUPY2
   L4X7N8mtGDAF3aPrwNLpMjZLSTUcJyogIGOfuiRQUPCZpt1xN20qWN9Qo
   aILYlYZPdoBq05RcIyM93OklDxIQb9V2DsSDH2BnBLQGJ1WDcJwxy3gDw
   A==;
X-CSE-ConnectionGUID: PyZpXE4+TUOZc76D7YBGMA==
X-CSE-MsgGUID: SYvAFmthTP2yzoqi1nsEzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="73429385"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="73429385"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 12:21:31 -0800
X-CSE-ConnectionGUID: SRqgWCFrS+iYX3JzFqJLtw==
X-CSE-MsgGUID: CkdERtd3RYO0O5ouwqoXsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="222944324"
Received: from lkp-server01.sh.intel.com (HELO f27a57aa7a36) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 04 Mar 2026 12:21:29 -0800
Received: from kbuild by f27a57aa7a36 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxsij-000000004SN-3PFS;
	Wed, 04 Mar 2026 20:21:25 +0000
Date: Thu, 05 Mar 2026 04:20:26 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-rc] BUILD SUCCESS
 a08aaf3968aec5d05cd32c801b8cc0c61da69c41
Message-ID: <202603050417.qXKH0ZPE-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 87AF5207919
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
	TAGGED_FROM(0.00)[bounces-17500-lists,linux-rdma=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,lists];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:mid]
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: a08aaf3968aec5d05cd32c801b8cc0c61da69c41  RDMA/ionic: Preserve and set Ethernet source MAC after ib_ud_header_init()

elapsed time: 755m

configs tested: 167
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260304    clang-23
arc                   randconfig-002-20260304    clang-23
arm                              alldefconfig    gcc-15.2.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260304    clang-23
arm                   randconfig-002-20260304    clang-23
arm                   randconfig-003-20260304    clang-23
arm                   randconfig-004-20260304    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260304    gcc-15.2.0
arm64                 randconfig-002-20260304    gcc-15.2.0
arm64                 randconfig-003-20260304    gcc-15.2.0
arm64                 randconfig-004-20260304    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260304    gcc-15.2.0
csky                  randconfig-002-20260304    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260304    gcc-15.2.0
hexagon               randconfig-002-20260304    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260304    gcc-14
i386        buildonly-randconfig-002-20260304    gcc-14
i386        buildonly-randconfig-003-20260304    gcc-14
i386        buildonly-randconfig-004-20260304    gcc-14
i386        buildonly-randconfig-005-20260304    gcc-14
i386        buildonly-randconfig-006-20260304    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260304    clang-20
i386                  randconfig-002-20260304    clang-20
i386                  randconfig-003-20260304    clang-20
i386                  randconfig-004-20260304    clang-20
i386                  randconfig-005-20260304    clang-20
i386                  randconfig-006-20260304    clang-20
i386                  randconfig-007-20260304    clang-20
i386                  randconfig-011-20260304    gcc-14
i386                  randconfig-012-20260304    gcc-14
i386                  randconfig-013-20260304    gcc-14
i386                  randconfig-014-20260304    gcc-14
i386                  randconfig-015-20260304    gcc-14
i386                  randconfig-016-20260304    gcc-14
i386                  randconfig-017-20260304    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260304    gcc-15.2.0
loongarch             randconfig-002-20260304    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260304    gcc-15.2.0
nios2                 randconfig-002-20260304    gcc-15.2.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260304    gcc-8.5.0
parisc                randconfig-002-20260304    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc               randconfig-001-20260304    gcc-8.5.0
powerpc               randconfig-002-20260304    gcc-8.5.0
powerpc64             randconfig-001-20260304    gcc-8.5.0
powerpc64             randconfig-002-20260304    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260304    clang-23
riscv                 randconfig-001-20260305    clang-23
riscv                 randconfig-002-20260304    clang-23
riscv                 randconfig-002-20260305    clang-23
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260304    clang-23
s390                  randconfig-001-20260305    clang-23
s390                  randconfig-002-20260304    clang-23
s390                  randconfig-002-20260305    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260304    clang-23
sh                    randconfig-001-20260305    clang-23
sh                    randconfig-002-20260304    clang-23
sh                    randconfig-002-20260305    clang-23
sh                     sh7710voipgw_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260304    gcc-14
x86_64      buildonly-randconfig-002-20260304    gcc-14
x86_64      buildonly-randconfig-003-20260304    gcc-14
x86_64      buildonly-randconfig-004-20260304    gcc-14
x86_64      buildonly-randconfig-005-20260304    gcc-14
x86_64      buildonly-randconfig-006-20260304    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260304    clang-20
x86_64                randconfig-002-20260304    clang-20
x86_64                randconfig-003-20260304    clang-20
x86_64                randconfig-004-20260304    clang-20
x86_64                randconfig-005-20260304    clang-20
x86_64                randconfig-006-20260304    clang-20
x86_64                randconfig-011-20260304    gcc-14
x86_64                randconfig-012-20260304    gcc-14
x86_64                randconfig-013-20260304    gcc-14
x86_64                randconfig-014-20260304    gcc-14
x86_64                randconfig-015-20260304    gcc-14
x86_64                randconfig-016-20260304    gcc-14
x86_64                randconfig-071-20260304    clang-20
x86_64                randconfig-072-20260304    clang-20
x86_64                randconfig-073-20260304    clang-20
x86_64                randconfig-074-20260304    clang-20
x86_64                randconfig-075-20260304    clang-20
x86_64                randconfig-076-20260304    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

