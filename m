Return-Path: <linux-rdma+bounces-17135-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLkVJtdDnmmGUQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17135-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 01:35:35 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C128518E637
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 01:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 28A8B301517D
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 00:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B55221F24;
	Wed, 25 Feb 2026 00:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E55hc1QD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D140135975
	for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 00:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771979728; cv=none; b=lQGfWQF5F7Eptok0Ru4X6pRzUqDId175gUK4pOuZZdqQyLVsN9DuCF2CfGT5LSJm+Y49an5Gp2hBtbQVdGLlWxIlIaBYklMw8osLr4LTrY4NOAqdjc2i1Y1NDPd6/qtfAbtmuotUZv/2IHYE28B/IYbOHNt5i/GLHqIjlDkrQJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771979728; c=relaxed/simple;
	bh=DBMHi4pRGaRUVRnOQaXThdtzf6JlmgLfYTgWHZTNQzI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=luVGaefC23p6exqZmuZVax6E7cKg+q0WQZK+xqGMNnB5yanyKBHMu20HzwO94lVlfClzgnpiF0NkZ8/vsca/6MFi9bobVyCTcuTsMcBmNHgsHnchYypTf78FNF0+ZEm9Bghev51Zqwu1zkwAek4zq6wHpGsaecfpJ0KGgb1U80Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E55hc1QD; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771979727; x=1803515727;
  h=date:from:to:cc:subject:message-id;
  bh=DBMHi4pRGaRUVRnOQaXThdtzf6JlmgLfYTgWHZTNQzI=;
  b=E55hc1QDW9QaXLxvFmhri0dbH+a+eBVd9O8H6Vyoa6BEIo+ohBbaMEk4
   53je7d+T0xnBAa9P40ZagKHjac33IXg8vc+U0jsnVz0A7ur4S4IXSt91w
   e04rKPhjzThsPMx8eDvQfzpDc6gtjdawaxoLvdxU+Hsh/d/6mg1qmJqV9
   C07y8E9LgDnCt8bMC8qQhdteYEv53gJNg8W+E8iD0+5gokje1tGSJbo0R
   lb5ejsVvwuNSnITXpJ7q4tZ82MQdipK2rynWqNk8cySgIVVWe1FulFBa8
   u28qFWx2k382vLfFgj86WF5oSn1O+v94pqYY5GmUKJ+L7RuYW3bXznIap
   w==;
X-CSE-ConnectionGUID: sGTxDa2tS4qq9ArG0IVwIw==
X-CSE-MsgGUID: JkQD50FsRRyfmlDFJ+qXDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72982978"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="72982978"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 16:35:27 -0800
X-CSE-ConnectionGUID: rv9D1PfFRnOz5XWMThbpeA==
X-CSE-MsgGUID: ka6uKg0nSr6f0lz3LnUJGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="214243837"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 24 Feb 2026 16:35:24 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vv2s6-000000002ft-1228;
	Wed, 25 Feb 2026 00:35:22 +0000
Date: Wed, 25 Feb 2026 08:34:41 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 2865500db9339bff85a504c7fbad0047ebbf9331
Message-ID: <202602250832.PE5nNCbY-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17135-lists,linux-rdma=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,lists];
	NEURAL_HAM(-0.00)[-0.989];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: C128518E637
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 2865500db9339bff85a504c7fbad0047ebbf9331  RDMA/restrack: fix kernel-doc indicator

elapsed time: 824m

configs tested: 301
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
arc                   randconfig-001-20260224    gcc-14.3.0
arc                   randconfig-001-20260225    gcc-8.5.0
arc                   randconfig-002-20260224    gcc-14.3.0
arc                   randconfig-002-20260225    gcc-8.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                     am200epdkit_defconfig    gcc-15.2.0
arm                          collie_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                          ep93xx_defconfig    clang-23
arm                           h3600_defconfig    gcc-15.2.0
arm                          ixp4xx_defconfig    gcc-15.2.0
arm                       omap2plus_defconfig    clang-23
arm                   randconfig-001-20260224    gcc-14.3.0
arm                   randconfig-001-20260225    gcc-8.5.0
arm                   randconfig-002-20260224    gcc-14.3.0
arm                   randconfig-002-20260225    gcc-8.5.0
arm                   randconfig-003-20260224    gcc-14.3.0
arm                   randconfig-003-20260225    gcc-8.5.0
arm                   randconfig-004-20260224    gcc-14.3.0
arm                   randconfig-004-20260225    gcc-8.5.0
arm                        spear6xx_defconfig    clang-23
arm                           spitz_defconfig    gcc-15.2.0
arm                       versatile_defconfig    gcc-15.2.0
arm                    vt8500_v6_v7_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260224    gcc-14.3.0
arm64                 randconfig-001-20260225    gcc-9.5.0
arm64                 randconfig-002-20260224    gcc-14.3.0
arm64                 randconfig-002-20260225    gcc-9.5.0
arm64                 randconfig-003-20260224    gcc-14.3.0
arm64                 randconfig-003-20260225    gcc-9.5.0
arm64                 randconfig-004-20260224    gcc-14.3.0
arm64                 randconfig-004-20260225    gcc-9.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260224    gcc-14.3.0
csky                  randconfig-001-20260225    gcc-9.5.0
csky                  randconfig-002-20260224    gcc-14.3.0
csky                  randconfig-002-20260225    gcc-9.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260224    clang-16
hexagon               randconfig-001-20260225    clang-23
hexagon               randconfig-002-20260224    clang-16
hexagon               randconfig-002-20260225    clang-23
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260224    clang-20
i386        buildonly-randconfig-001-20260225    clang-20
i386        buildonly-randconfig-002-20260224    clang-20
i386        buildonly-randconfig-002-20260225    clang-20
i386        buildonly-randconfig-003-20260224    clang-20
i386        buildonly-randconfig-003-20260225    clang-20
i386        buildonly-randconfig-004-20260224    clang-20
i386        buildonly-randconfig-004-20260225    clang-20
i386        buildonly-randconfig-005-20260224    clang-20
i386        buildonly-randconfig-005-20260225    clang-20
i386        buildonly-randconfig-006-20260224    clang-20
i386        buildonly-randconfig-006-20260225    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260224    gcc-14
i386                  randconfig-001-20260225    gcc-14
i386                  randconfig-002-20260224    gcc-14
i386                  randconfig-002-20260225    gcc-14
i386                  randconfig-003-20260224    gcc-14
i386                  randconfig-003-20260225    gcc-14
i386                  randconfig-004-20260224    gcc-14
i386                  randconfig-004-20260225    gcc-14
i386                  randconfig-005-20260224    gcc-14
i386                  randconfig-005-20260225    gcc-14
i386                  randconfig-006-20260224    gcc-14
i386                  randconfig-006-20260225    gcc-14
i386                  randconfig-007-20260224    gcc-14
i386                  randconfig-007-20260225    gcc-14
i386                  randconfig-011-20260224    gcc-14
i386                  randconfig-011-20260225    gcc-13
i386                  randconfig-012-20260224    gcc-14
i386                  randconfig-012-20260225    gcc-13
i386                  randconfig-013-20260224    gcc-14
i386                  randconfig-013-20260225    gcc-13
i386                  randconfig-014-20260224    gcc-14
i386                  randconfig-014-20260225    gcc-13
i386                  randconfig-015-20260224    gcc-14
i386                  randconfig-015-20260225    gcc-13
i386                  randconfig-016-20260224    gcc-14
i386                  randconfig-016-20260225    gcc-13
i386                  randconfig-017-20260224    gcc-14
i386                  randconfig-017-20260225    gcc-13
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260224    clang-16
loongarch             randconfig-001-20260225    clang-23
loongarch             randconfig-002-20260224    clang-16
loongarch             randconfig-002-20260225    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                        m5307c3_defconfig    gcc-15.2.0
microblaze                       alldefconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                      bmips_stb_defconfig    gcc-15.2.0
mips                  decstation_64_defconfig    gcc-15.2.0
mips                 decstation_r4k_defconfig    gcc-15.2.0
mips                           ip27_defconfig    gcc-15.2.0
mips                       lemote2f_defconfig    gcc-15.2.0
mips                      malta_kvm_defconfig    gcc-15.2.0
mips                      pic32mzda_defconfig    clang-23
mips                   sb1250_swarm_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260224    clang-16
nios2                 randconfig-001-20260225    clang-23
nios2                 randconfig-002-20260224    clang-16
nios2                 randconfig-002-20260225    clang-23
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
openrisc                       virt_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260224    clang-23
parisc                randconfig-001-20260225    clang-19
parisc                randconfig-002-20260224    clang-23
parisc                randconfig-002-20260225    clang-19
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                    amigaone_defconfig    gcc-15.2.0
powerpc                     asp8347_defconfig    gcc-15.2.0
powerpc                      cm5200_defconfig    gcc-15.2.0
powerpc                       ebony_defconfig    clang-23
powerpc                       eiger_defconfig    gcc-15.2.0
powerpc                       holly_defconfig    clang-23
powerpc                 mpc8315_rdb_defconfig    clang-23
powerpc                 mpc8315_rdb_defconfig    gcc-15.2.0
powerpc                 mpc836x_rdk_defconfig    clang-23
powerpc                 mpc837x_rdb_defconfig    gcc-15.2.0
powerpc                      pasemi_defconfig    clang-23
powerpc               randconfig-001-20260224    clang-23
powerpc               randconfig-001-20260225    clang-19
powerpc               randconfig-002-20260224    clang-23
powerpc               randconfig-002-20260225    clang-19
powerpc                     skiroot_defconfig    gcc-15.2.0
powerpc                         wii_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260224    clang-23
powerpc64             randconfig-001-20260225    clang-19
powerpc64             randconfig-002-20260224    clang-23
powerpc64             randconfig-002-20260225    clang-19
riscv                            alldefconfig    gcc-15.2.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_virt_defconfig    gcc-15.2.0
riscv                 randconfig-001-20260224    gcc-10.5.0
riscv                 randconfig-001-20260225    gcc-12.5.0
riscv                 randconfig-002-20260224    gcc-10.5.0
riscv                 randconfig-002-20260225    gcc-12.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260224    gcc-10.5.0
s390                  randconfig-001-20260225    gcc-12.5.0
s390                  randconfig-002-20260224    gcc-10.5.0
s390                  randconfig-002-20260225    gcc-12.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                        apsh4ad0a_defconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                         ecovec24_defconfig    clang-23
sh                          landisk_defconfig    gcc-15.2.0
sh                    randconfig-001-20260224    gcc-10.5.0
sh                    randconfig-001-20260225    gcc-12.5.0
sh                    randconfig-002-20260224    gcc-10.5.0
sh                    randconfig-002-20260225    gcc-12.5.0
sh                      rts7751r2d1_defconfig    clang-23
sh                   rts7751r2dplus_defconfig    gcc-15.2.0
sh                           se7619_defconfig    clang-23
sh                     sh7710voipgw_defconfig    gcc-15.2.0
sh                        sh7763rdp_defconfig    gcc-15.2.0
sh                  sh7785lcr_32bit_defconfig    clang-23
sh                            titan_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260224    gcc-12.5.0
sparc                 randconfig-001-20260225    gcc-11.5.0
sparc                 randconfig-002-20260224    gcc-12.5.0
sparc                 randconfig-002-20260225    gcc-11.5.0
sparc                       sparc32_defconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260224    gcc-12.5.0
sparc64               randconfig-001-20260225    gcc-11.5.0
sparc64               randconfig-002-20260224    gcc-12.5.0
sparc64               randconfig-002-20260225    gcc-11.5.0
um                               alldefconfig    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260224    gcc-12.5.0
um                    randconfig-001-20260225    gcc-11.5.0
um                    randconfig-002-20260224    gcc-12.5.0
um                    randconfig-002-20260225    gcc-11.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260224    gcc-14
x86_64      buildonly-randconfig-001-20260225    clang-20
x86_64      buildonly-randconfig-002-20260224    gcc-14
x86_64      buildonly-randconfig-002-20260225    clang-20
x86_64      buildonly-randconfig-003-20260224    gcc-14
x86_64      buildonly-randconfig-003-20260225    clang-20
x86_64      buildonly-randconfig-004-20260224    gcc-14
x86_64      buildonly-randconfig-004-20260225    clang-20
x86_64      buildonly-randconfig-005-20260224    gcc-14
x86_64      buildonly-randconfig-005-20260225    clang-20
x86_64      buildonly-randconfig-006-20260224    gcc-14
x86_64      buildonly-randconfig-006-20260225    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260224    gcc-14
x86_64                randconfig-001-20260225    gcc-14
x86_64                randconfig-002-20260224    gcc-14
x86_64                randconfig-002-20260225    gcc-14
x86_64                randconfig-003-20260224    gcc-14
x86_64                randconfig-003-20260225    gcc-14
x86_64                randconfig-004-20260224    gcc-14
x86_64                randconfig-004-20260225    gcc-14
x86_64                randconfig-005-20260224    gcc-14
x86_64                randconfig-005-20260225    gcc-14
x86_64                randconfig-006-20260224    gcc-14
x86_64                randconfig-006-20260225    gcc-14
x86_64                randconfig-011-20260224    clang-20
x86_64                randconfig-011-20260225    gcc-14
x86_64                randconfig-012-20260224    clang-20
x86_64                randconfig-012-20260225    gcc-14
x86_64                randconfig-013-20260224    clang-20
x86_64                randconfig-013-20260225    gcc-14
x86_64                randconfig-014-20260224    clang-20
x86_64                randconfig-014-20260225    gcc-14
x86_64                randconfig-015-20260224    clang-20
x86_64                randconfig-015-20260225    gcc-14
x86_64                randconfig-016-20260224    clang-20
x86_64                randconfig-016-20260225    gcc-14
x86_64                randconfig-071-20260224    clang-20
x86_64                randconfig-071-20260225    clang-20
x86_64                randconfig-072-20260224    clang-20
x86_64                randconfig-072-20260225    clang-20
x86_64                randconfig-073-20260224    clang-20
x86_64                randconfig-073-20260225    clang-20
x86_64                randconfig-074-20260224    clang-20
x86_64                randconfig-074-20260225    clang-20
x86_64                randconfig-075-20260224    clang-20
x86_64                randconfig-075-20260225    clang-20
x86_64                randconfig-076-20260224    clang-20
x86_64                randconfig-076-20260225    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                           alldefconfig    clang-23
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                          iss_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260224    gcc-12.5.0
xtensa                randconfig-001-20260225    gcc-11.5.0
xtensa                randconfig-002-20260224    gcc-12.5.0
xtensa                randconfig-002-20260225    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

