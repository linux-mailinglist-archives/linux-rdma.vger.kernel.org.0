Return-Path: <linux-rdma+bounces-17103-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJnpKR9qnWnYPwQAu9opvQ
	(envelope-from <linux-rdma+bounces-17103-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 10:06:39 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5751843D2
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 10:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB1F7302FAA6
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 09:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B735B369969;
	Tue, 24 Feb 2026 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ceux9beb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECA634D915
	for <linux-rdma@vger.kernel.org>; Tue, 24 Feb 2026 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771923855; cv=none; b=jWQZF10+U9/h3Ic6b31/DprMr5nygfAUpm5zfody8VKjQey+PP/2D8waUA+r5FjB89BmM9g+iRZ8jYXXaYJYEZQEgcW5P55KSzYPjif5pZ+jJjVRY5Tb/QMvynNu3wCEzCzIDs9S3OjbX8sHMBssR4HZFBRodu8b5n/4C4y9TmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771923855; c=relaxed/simple;
	bh=UxT0jGcYt5qR9io/gE0cRa7wnX67gyQk6ki0DD7HWJU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GLmI3CyNl40q/qOds466A4xi7rpeZo9pty0z8ga8E6FFMHW+xn2KlusA/rpJjl5/pW155lwrOvToBwXKiFMWNVDM27pAT+QPA9J6mahbFgn2DbbEZek28O6RGKTJgH3YI8X94QxRNnLqnDfEuGxtrhiZ5v93zDNvr6CeXx2LOPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ceux9beb; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771923854; x=1803459854;
  h=date:from:to:cc:subject:message-id;
  bh=UxT0jGcYt5qR9io/gE0cRa7wnX67gyQk6ki0DD7HWJU=;
  b=Ceux9bebySnmXLbgBjrME5hZKbbNmbm9wHQoOemtszzriHFH4Z5Wii7y
   7B5DFPVJeamJ6gQTex8yayhA1zKdiSZT+ilYHFIoH73W44ubbutYYiWFq
   +Cva6Dj2fS9UE3Dh6NxnC3ZWDqKU3RogNIhyNY2+dRZBa4K0uqXohAReE
   QayM6P3t2JUHQN8KVMn1YuweqgjESunHLf7/lX6nRkwUb512L8Yey1Y87
   PEdpy8OkkUNpE5M+gQKicEywW/FaPD3QsleqhLov3k96rYp2deKgxLbLB
   0a/6dDR8nZefT6CTkHmbWFsoRP0oodEbySE4BaFeEhmvxRwHleq/o+YmL
   A==;
X-CSE-ConnectionGUID: PYrHWg6yQYWebpsqFcffjA==
X-CSE-MsgGUID: iqufB5FOQh+KedetzoJ1XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="90341028"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="90341028"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 01:04:13 -0800
X-CSE-ConnectionGUID: GWlUlQTUTfCV8Xst1kKBWQ==
X-CSE-MsgGUID: +idk/nxvQ0yOnze+AAHOLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="220362366"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 24 Feb 2026 01:04:11 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vuoKj-000000001ip-34pa;
	Tue, 24 Feb 2026 09:03:59 +0000
Date: Tue, 24 Feb 2026 17:02:34 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 16cb1a64dce56708a1684bf755ad52fb52c41f87
Message-ID: <202602241726.2NgDPSUz-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17103-lists,linux-rdma=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,lists];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB5751843D2
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: 16cb1a64dce56708a1684bf755ad52fb52c41f87  RDMA/uverbs: select CONFIG_DMA_SHARED_BUFFER

elapsed time: 768m

configs tested: 223
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.2.0
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                 nsimosci_hs_smp_defconfig    gcc-15.2.0
arc                   randconfig-001-20260224    gcc-14.3.0
arc                   randconfig-002-20260224    gcc-14.3.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                         assabet_defconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-15.2.0
arm                       multi_v4t_defconfig    gcc-15.2.0
arm                       netwinder_defconfig    gcc-15.2.0
arm                             pxa_defconfig    gcc-15.2.0
arm                   randconfig-001-20260224    gcc-14.3.0
arm                   randconfig-002-20260224    gcc-14.3.0
arm                   randconfig-003-20260224    gcc-14.3.0
arm                   randconfig-004-20260224    gcc-14.3.0
arm                           spitz_defconfig    gcc-15.2.0
arm                           tegra_defconfig    clang-16
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260224    gcc-14.3.0
arm64                 randconfig-002-20260224    gcc-14.3.0
arm64                 randconfig-003-20260224    gcc-14.3.0
arm64                 randconfig-004-20260224    gcc-14.3.0
csky                             alldefconfig    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260224    gcc-14.3.0
csky                  randconfig-002-20260224    gcc-14.3.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260224    clang-16
hexagon               randconfig-002-20260224    clang-16
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260224    clang-20
i386        buildonly-randconfig-002-20260224    clang-20
i386        buildonly-randconfig-003-20260224    clang-20
i386        buildonly-randconfig-004-20260224    clang-20
i386        buildonly-randconfig-005-20260224    clang-20
i386        buildonly-randconfig-006-20260224    clang-20
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260224    gcc-14
i386                  randconfig-002-20260224    gcc-14
i386                  randconfig-003-20260224    gcc-14
i386                  randconfig-004-20260224    gcc-14
i386                  randconfig-005-20260224    gcc-14
i386                  randconfig-006-20260224    gcc-14
i386                  randconfig-007-20260224    gcc-14
i386                  randconfig-011-20260224    gcc-14
i386                  randconfig-012-20260224    gcc-14
i386                  randconfig-013-20260224    gcc-14
i386                  randconfig-014-20260224    gcc-14
i386                  randconfig-015-20260224    gcc-14
i386                  randconfig-016-20260224    gcc-14
i386                  randconfig-017-20260224    gcc-14
loongarch                        alldefconfig    gcc-15.2.0
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260224    clang-16
loongarch             randconfig-002-20260224    clang-16
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                         apollo_defconfig    clang-16
m68k                                defconfig    clang-19
m68k                       m5475evb_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                       bmips_be_defconfig    gcc-15.2.0
mips                  cavium_octeon_defconfig    clang-16
mips                           ci20_defconfig    gcc-15.2.0
mips                           ip30_defconfig    gcc-15.2.0
mips                       rbtx49xx_defconfig    gcc-15.2.0
mips                   sb1250_swarm_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260224    clang-16
nios2                 randconfig-002-20260224    clang-16
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                  or1klitex_defconfig    gcc-15.2.0
openrisc                 simple_smp_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                generic-32bit_defconfig    clang-16
parisc                generic-64bit_defconfig    gcc-15.2.0
parisc                randconfig-001-20260224    clang-23
parisc                randconfig-002-20260224    clang-23
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      cm5200_defconfig    gcc-15.2.0
powerpc                     mpc5200_defconfig    gcc-15.2.0
powerpc                 mpc834x_itx_defconfig    clang-16
powerpc               randconfig-001-20260224    clang-23
powerpc               randconfig-002-20260224    clang-23
powerpc64             randconfig-001-20260224    clang-23
powerpc64             randconfig-002-20260224    clang-23
riscv                            alldefconfig    clang-16
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260224    gcc-10.5.0
riscv                 randconfig-002-20260224    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260224    gcc-10.5.0
s390                  randconfig-002-20260224    gcc-10.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                        apsh4ad0a_defconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                        dreamcast_defconfig    gcc-15.2.0
sh                          lboxre2_defconfig    gcc-15.2.0
sh                    randconfig-001-20260224    gcc-10.5.0
sh                    randconfig-002-20260224    gcc-10.5.0
sh                             sh03_defconfig    gcc-15.2.0
sh                           sh2007_defconfig    gcc-15.2.0
sh                             shx3_defconfig    gcc-15.2.0
sh                            titan_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260224    gcc-12.5.0
sparc                 randconfig-002-20260224    gcc-12.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260224    gcc-12.5.0
sparc64               randconfig-002-20260224    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260224    gcc-12.5.0
um                    randconfig-002-20260224    gcc-12.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260224    gcc-14
x86_64      buildonly-randconfig-002-20260224    gcc-14
x86_64      buildonly-randconfig-003-20260224    gcc-14
x86_64      buildonly-randconfig-004-20260224    gcc-14
x86_64      buildonly-randconfig-005-20260224    gcc-14
x86_64      buildonly-randconfig-006-20260224    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260224    gcc-14
x86_64                randconfig-002-20260224    gcc-14
x86_64                randconfig-003-20260224    gcc-14
x86_64                randconfig-004-20260224    gcc-14
x86_64                randconfig-005-20260224    gcc-14
x86_64                randconfig-006-20260224    gcc-14
x86_64                randconfig-011-20260224    clang-20
x86_64                randconfig-012-20260224    clang-20
x86_64                randconfig-013-20260224    clang-20
x86_64                randconfig-014-20260224    clang-20
x86_64                randconfig-015-20260224    clang-20
x86_64                randconfig-016-20260224    clang-20
x86_64                randconfig-071-20260224    clang-20
x86_64                randconfig-072-20260224    clang-20
x86_64                randconfig-073-20260224    clang-20
x86_64                randconfig-074-20260224    clang-20
x86_64                randconfig-075-20260224    clang-20
x86_64                randconfig-076-20260224    clang-20
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
xtensa                  cadence_csp_defconfig    gcc-15.2.0
xtensa                          iss_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260224    gcc-12.5.0
xtensa                randconfig-002-20260224    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

