Return-Path: <linux-rdma+bounces-20873-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IohFg+ECmqv2AQAu9opvQ
	(envelope-from <linux-rdma+bounces-20873-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 05:14:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B16DB56559C
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 05:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 767CF300DF5A
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 03:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F7834D3BE;
	Mon, 18 May 2026 03:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kdEmqrPv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5533726B973
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 03:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779074059; cv=none; b=HADc5ca/X24TyGtlXrZGzEvM1qL/96ucOB6BwyaNtWuhO3RAv6mlh/hbBaQYh/ARD3GXWmWMTcO0VLkwJy408j/7JgexDoHo89q8ngjaB89ZZBoyGREWtToHwKJuGzQuC2HiVjPvDob4mcC2AYJjy3T3z9SCYjDFZ6Pe5iWd0jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779074059; c=relaxed/simple;
	bh=0jK1ZOoR8XXVo7+7ZvEf12IhCsGgcOvuMa7xU2rmZb8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=em8RAhpyjzvisBE9ZyddkmJphwoie8myzKPsWxLNV2C3O1F7qvo5ZaEYm+RISERb4+BAabJEmbjHwJwUyYh2CtcYPkndXZ7PLjrpXPNYDb7ewbjh0wqorKsJeZmDeZsdLg2OSMp4Zt5pmO0FY1vvckufYWlQehZXgh55ewVexAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kdEmqrPv; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779074058; x=1810610058;
  h=date:from:to:cc:subject:message-id;
  bh=0jK1ZOoR8XXVo7+7ZvEf12IhCsGgcOvuMa7xU2rmZb8=;
  b=kdEmqrPvapv6Zg9IiwN38aOyvwDffqFiXJzTmHDYZIKWUoi++f7WY7Mh
   69LkpGFGDtJaQP5OlHJnKCdMw5+lCaIDfiWy7q+cVKUyL67F4ZV/MtYml
   K11IYQfhH1lrmtNVb57pMWEmS87OcRdcpvTNxq9mWAJQESBOsmYbxQjhD
   xB4d6t443zpQwzpNPJuHV/1qzZujQKaku/nDzHg40g/LIH8iDhFZPaeaH
   Y4uyajAp1/IGByLZAOcCtpS11o9+kxVmJrrtk8D4q+jTVmVovr/4O8378
   fQfhdCxYSSrFcuG2s9S5XVxxwWRW4q+qcY3/3wKqKboVClA9YFqWZM3Gg
   Q==;
X-CSE-ConnectionGUID: QA+4aLUnTa6MnYZMXNKjVg==
X-CSE-MsgGUID: 5Qg32t5hQRaHILDev6uDSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="82485428"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="82485428"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 20:14:17 -0700
X-CSE-ConnectionGUID: cSV0NU99Th2xFtbZU2PQiw==
X-CSE-MsgGUID: k7DlwepASrSg5quglgn/TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="243286530"
Received: from lkp-server01.sh.intel.com (HELO d94e5e629b2d) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 17 May 2026 20:14:16 -0700
Received: from kbuild by d94e5e629b2d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wOoQn-000000002IY-0629;
	Mon, 18 May 2026 03:14:13 +0000
Date: Mon, 18 May 2026 11:14:03 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 f5cb0630444b7353c8c471b52e006b90fa6d5aa1
Message-ID: <202605181152.sELelCjW-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: B16DB56559C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20873-lists,linux-rdma=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,lists];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: f5cb0630444b7353c8c471b52e006b90fa6d5aa1  RDMA: Replace memset with = {} pattern for ib_respond_udata()

elapsed time: 726m

configs tested: 171
configs skipped: 11

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
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260518    gcc-9.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260518    gcc-8.5.0
arm                              alldefconfig    gcc-15.2.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260518    clang-23
arm                            randconfig-002    gcc-11.5.0
arm                   randconfig-002-20260518    gcc-8.5.0
arm                            randconfig-003    clang-20
arm                   randconfig-003-20260518    gcc-8.5.0
arm                            randconfig-004    gcc-14.3.0
arm                   randconfig-004-20260518    gcc-10.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260518    clang-17
arm64                 randconfig-002-20260518    gcc-8.5.0
arm64                 randconfig-003-20260518    gcc-15.2.0
arm64                 randconfig-004-20260518    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260518    gcc-15.2.0
csky                  randconfig-002-20260518    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260518    clang-16
hexagon               randconfig-002-20260518    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260518    clang-20
i386        buildonly-randconfig-002-20260518    clang-20
i386        buildonly-randconfig-003-20260518    gcc-14
i386        buildonly-randconfig-004-20260518    gcc-14
i386        buildonly-randconfig-005-20260518    gcc-14
i386        buildonly-randconfig-006-20260518    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260518    clang-20
i386                  randconfig-002-20260518    gcc-14
i386                  randconfig-003-20260518    gcc-14
i386                  randconfig-004-20260518    clang-20
i386                  randconfig-005-20260518    clang-20
i386                  randconfig-006-20260518    gcc-13
i386                  randconfig-007-20260518    clang-20
i386                  randconfig-011-20260518    gcc-14
i386                  randconfig-012-20260518    clang-20
i386                  randconfig-013-20260518    gcc-14
i386                  randconfig-014-20260518    gcc-14
i386                  randconfig-015-20260518    clang-20
i386                  randconfig-016-20260518    gcc-14
i386                  randconfig-017-20260518    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260518    gcc-15.2.0
loongarch             randconfig-002-20260518    clang-23
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
mips                           ip30_defconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260518    gcc-11.5.0
nios2                 randconfig-002-20260518    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260518    gcc-15.2.0
parisc                randconfig-002-20260518    gcc-12.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260518    clang-23
powerpc               randconfig-002-20260518    clang-23
powerpc64             randconfig-001-20260518    gcc-11.5.0
powerpc64             randconfig-002-20260518    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260518    clang-23
riscv                 randconfig-002-20260518    clang-23
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                           randconfig-001    gcc-11.5.0
s390                  randconfig-001-20260518    gcc-12.5.0
s390                  randconfig-002-20260518    gcc-12.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                             randconfig-001    gcc-15.2.0
sh                    randconfig-001-20260518    gcc-14.3.0
sh                             randconfig-002    gcc-14.3.0
sh                    randconfig-002-20260518    gcc-11.5.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260518    gcc-15.2.0
sparc                 randconfig-002-20260518    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260518    clang-23
sparc64               randconfig-002-20260518    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260518    clang-16
um                    randconfig-002-20260518    clang-23
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260518    clang-20
x86_64      buildonly-randconfig-002-20260518    clang-20
x86_64      buildonly-randconfig-003-20260518    clang-20
x86_64      buildonly-randconfig-004-20260518    gcc-14
x86_64      buildonly-randconfig-005-20260518    gcc-14
x86_64      buildonly-randconfig-006-20260518    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260518    gcc-14
x86_64                randconfig-002-20260518    clang-20
x86_64                randconfig-003-20260518    gcc-14
x86_64                randconfig-004-20260518    gcc-14
x86_64                randconfig-005-20260518    gcc-14
x86_64                randconfig-006-20260518    gcc-14
x86_64                randconfig-011-20260518    clang-20
x86_64                randconfig-012-20260518    clang-20
x86_64                randconfig-013-20260518    gcc-14
x86_64                randconfig-014-20260518    clang-20
x86_64                randconfig-015-20260518    clang-20
x86_64                randconfig-016-20260518    gcc-14
x86_64                randconfig-071-20260518    gcc-14
x86_64                randconfig-072-20260518    gcc-14
x86_64                randconfig-073-20260518    clang-20
x86_64                randconfig-074-20260518    clang-20
x86_64                randconfig-075-20260518    clang-20
x86_64                randconfig-076-20260518    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260518    gcc-12.5.0
xtensa                randconfig-002-20260518    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

