Return-Path: <linux-rdma+bounces-17199-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAW8JBrHn2k8dwQAu9opvQ
	(envelope-from <linux-rdma+bounces-17199-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 05:07:54 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F325B1A0C4A
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 05:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35FA23069ADC
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 04:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24482389E16;
	Thu, 26 Feb 2026 04:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uz/K256J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAC828507E
	for <linux-rdma@vger.kernel.org>; Thu, 26 Feb 2026 04:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772078807; cv=none; b=kZYBtwS/0Cd9nllI5gGT0KFsZ7tT2aSowg/hgYwNJZGFoWfdeUl2NQflyfd0cP3pEfiTibIBt9J2zAbvZ3veXCbVjxRlQebqtvbnYC+5O8mfea2m7NYlBwTtpQOtyO7g0zKJV04/555cFqn4M9a5KNzkkOKpTW50ouiVtYoIOCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772078807; c=relaxed/simple;
	bh=BTszvlmbLXpwi3b11mS3CX5YMRrAHZZhvuIqno8kJtU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qHX0y9a9PB1C3DsJTR9bWNrcgBeNAfNzJIa8whsb83L7XFcrwwmW+otMW/sEvmcoAxdSj44La+u+BKMht493m0SzUPoSEDR/eDBNwMTv664Mxr2PwlRjbBJEI3ISiGp3+dmumRidLfv3MNe5jkdMo8J8XpKJr2+aQMH4kgN6ETU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uz/K256J; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772078806; x=1803614806;
  h=date:from:to:cc:subject:message-id;
  bh=BTszvlmbLXpwi3b11mS3CX5YMRrAHZZhvuIqno8kJtU=;
  b=Uz/K256J/SV0+Xwegkgo+RY7qLJP+AuqFrXTQUPxoJJeigmelbCmqlt/
   r+u7BT1xSTWXM0C5R4Y1p0t5TYTvYRVdVwFG/olyWCUx3yQ8ZXpmLtEWF
   k3CKFeWi6MFfZ1d4mcIrR0U4rU7VnxB8BqO73oWwkQO+TuB3xoFFglEnf
   pADjiHsYcTF+q+fuWyJiq0fxiQEyTQFgDUSCxlKQAgDICM9lRpws1nKKe
   pgrmM5GuQY3fJMRR7iQDn3GKnmImqKVusyzUf3IJdVjOQ1pJSC9zMac/0
   6Il5ruLyTSnhWJSVRWOL/wbtYemuBrUOWQHDUesSj7wkdgwtx2NH6zIwO
   A==;
X-CSE-ConnectionGUID: 1zD1CTytQ3ecCQhsJtdNzg==
X-CSE-MsgGUID: FQ/XC3+DTNOdelwKg6YZzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73002893"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="73002893"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 20:06:46 -0800
X-CSE-ConnectionGUID: pWECz71dTNWe17L1OeXmFw==
X-CSE-MsgGUID: XeyWl2JWQAiTHJZEDsmWXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="220573413"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 25 Feb 2026 20:06:43 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vvSe9-0000000084n-0lqr;
	Thu, 26 Feb 2026 04:06:41 +0000
Date: Thu, 26 Feb 2026 12:06:19 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leonro@nvidia.com>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 104016eb671e19709721c1b0048dd912dc2e96be
Message-ID: <202602261211.FV41uVEw-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17199-lists,linux-rdma=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,lists];
	NEURAL_HAM(-0.00)[-0.989];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F325B1A0C4A
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: 104016eb671e19709721c1b0048dd912dc2e96be  RDMA/umem: Fix double dma_buf_unpin in failure path

elapsed time: 914m

configs tested: 318
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                      axs103_smp_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                         haps_hs_defconfig    gcc-15.2.0
arc                   randconfig-001-20260225    gcc-8.5.0
arc                   randconfig-001-20260226    gcc-15.2.0
arc                   randconfig-002-20260225    gcc-8.5.0
arc                   randconfig-002-20260226    gcc-15.2.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                       aspeed_g4_defconfig    gcc-15.2.0
arm                       aspeed_g5_defconfig    gcc-15.2.0
arm                         axm55xx_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                            dove_defconfig    gcc-15.2.0
arm                          gemini_defconfig    gcc-15.2.0
arm                            mmp2_defconfig    gcc-15.2.0
arm                        multi_v5_defconfig    gcc-15.2.0
arm                       omap2plus_defconfig    gcc-15.2.0
arm                          pxa3xx_defconfig    gcc-15.2.0
arm                   randconfig-001-20260225    gcc-8.5.0
arm                   randconfig-001-20260226    gcc-15.2.0
arm                   randconfig-002-20260225    gcc-8.5.0
arm                   randconfig-002-20260226    gcc-15.2.0
arm                   randconfig-003-20260225    gcc-8.5.0
arm                   randconfig-003-20260226    gcc-15.2.0
arm                   randconfig-004-20260225    gcc-8.5.0
arm                   randconfig-004-20260226    gcc-15.2.0
arm                        shmobile_defconfig    gcc-15.2.0
arm                         socfpga_defconfig    gcc-15.2.0
arm                           spitz_defconfig    gcc-15.2.0
arm                           sunxi_defconfig    gcc-15.2.0
arm                    vt8500_v6_v7_defconfig    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260225    gcc-9.5.0
arm64                 randconfig-001-20260226    gcc-14.3.0
arm64                 randconfig-002-20260225    gcc-9.5.0
arm64                 randconfig-002-20260226    gcc-14.3.0
arm64                 randconfig-003-20260225    gcc-9.5.0
arm64                 randconfig-003-20260226    gcc-14.3.0
arm64                 randconfig-004-20260225    gcc-9.5.0
arm64                 randconfig-004-20260226    gcc-14.3.0
csky                             alldefconfig    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260225    gcc-9.5.0
csky                  randconfig-001-20260226    gcc-14.3.0
csky                  randconfig-002-20260225    gcc-9.5.0
csky                  randconfig-002-20260226    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260225    clang-23
hexagon               randconfig-001-20260226    clang-23
hexagon               randconfig-002-20260225    clang-23
hexagon               randconfig-002-20260226    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260225    clang-20
i386        buildonly-randconfig-001-20260226    gcc-14
i386        buildonly-randconfig-002-20260225    clang-20
i386        buildonly-randconfig-002-20260226    gcc-14
i386        buildonly-randconfig-003-20260225    clang-20
i386        buildonly-randconfig-003-20260226    gcc-14
i386        buildonly-randconfig-004-20260225    clang-20
i386        buildonly-randconfig-004-20260226    gcc-14
i386        buildonly-randconfig-005-20260225    clang-20
i386        buildonly-randconfig-005-20260226    gcc-14
i386        buildonly-randconfig-006-20260225    clang-20
i386        buildonly-randconfig-006-20260226    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260225    gcc-14
i386                  randconfig-001-20260226    clang-20
i386                  randconfig-002-20260225    gcc-14
i386                  randconfig-002-20260226    clang-20
i386                  randconfig-003-20260225    gcc-14
i386                  randconfig-003-20260226    clang-20
i386                  randconfig-004-20260225    gcc-14
i386                  randconfig-004-20260226    clang-20
i386                  randconfig-005-20260225    gcc-14
i386                  randconfig-005-20260226    clang-20
i386                  randconfig-006-20260225    gcc-14
i386                  randconfig-006-20260226    clang-20
i386                  randconfig-007-20260225    gcc-14
i386                  randconfig-007-20260226    clang-20
i386                  randconfig-011-20260225    gcc-13
i386                  randconfig-011-20260226    gcc-14
i386                  randconfig-012-20260225    gcc-13
i386                  randconfig-012-20260226    gcc-14
i386                  randconfig-013-20260225    gcc-13
i386                  randconfig-013-20260226    gcc-14
i386                  randconfig-014-20260225    gcc-13
i386                  randconfig-014-20260226    gcc-14
i386                  randconfig-015-20260225    gcc-13
i386                  randconfig-015-20260226    gcc-14
i386                  randconfig-016-20260225    gcc-13
i386                  randconfig-016-20260226    gcc-14
i386                  randconfig-017-20260225    gcc-13
i386                  randconfig-017-20260226    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                loongson32_defconfig    clang-23
loongarch             randconfig-001-20260225    clang-23
loongarch             randconfig-001-20260226    clang-23
loongarch             randconfig-002-20260225    clang-23
loongarch             randconfig-002-20260226    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                         amcore_defconfig    clang-23
m68k                         amcore_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                       m5249evb_defconfig    gcc-15.2.0
m68k                        m5272c3_defconfig    gcc-15.2.0
m68k                        m5407c3_defconfig    gcc-15.2.0
m68k                            mac_defconfig    clang-23
m68k                          multi_defconfig    gcc-15.2.0
m68k                        mvme16x_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                        bcm47xx_defconfig    gcc-15.2.0
mips                     cu1830-neo_defconfig    gcc-15.2.0
mips                          eyeq6_defconfig    gcc-15.2.0
mips                           ip22_defconfig    gcc-15.2.0
mips                      maltaaprp_defconfig    clang-23
mips                      maltasmvp_defconfig    clang-23
mips                        maltaup_defconfig    gcc-15.2.0
mips                   sb1250_swarm_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260225    clang-23
nios2                 randconfig-001-20260226    clang-23
nios2                 randconfig-002-20260225    clang-23
nios2                 randconfig-002-20260226    clang-23
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260225    clang-19
parisc                randconfig-001-20260226    clang-16
parisc                randconfig-002-20260225    clang-19
parisc                randconfig-002-20260226    clang-16
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      chrp32_defconfig    gcc-15.2.0
powerpc                        icon_defconfig    gcc-15.2.0
powerpc                      katmai_defconfig    gcc-15.2.0
powerpc                   lite5200b_defconfig    clang-23
powerpc                 mpc8313_rdb_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260225    clang-19
powerpc               randconfig-001-20260226    clang-16
powerpc               randconfig-002-20260225    clang-19
powerpc               randconfig-002-20260226    clang-16
powerpc                     tqm8560_defconfig    gcc-15.2.0
powerpc                        warp_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260225    clang-19
powerpc64             randconfig-001-20260226    clang-16
powerpc64             randconfig-002-20260225    clang-19
powerpc64             randconfig-002-20260226    clang-16
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_virt_defconfig    gcc-15.2.0
riscv                 randconfig-001-20260225    gcc-12.5.0
riscv                 randconfig-002-20260225    gcc-12.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260225    gcc-12.5.0
s390                  randconfig-002-20260225    gcc-12.5.0
s390                       zfcpdump_defconfig    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                         ap325rxa_defconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                            hp6xx_defconfig    gcc-15.2.0
sh                          kfr2r09_defconfig    gcc-15.2.0
sh                          landisk_defconfig    clang-23
sh                    randconfig-001-20260225    gcc-12.5.0
sh                    randconfig-002-20260225    gcc-12.5.0
sh                          sdk7780_defconfig    gcc-15.2.0
sh                           se7724_defconfig    gcc-15.2.0
sh                   sh7724_generic_defconfig    gcc-15.2.0
sh                        sh7763rdp_defconfig    gcc-15.2.0
sh                        sh7785lcr_defconfig    gcc-15.2.0
sh                             shx3_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260225    gcc-11.5.0
sparc                 randconfig-001-20260226    gcc-8.5.0
sparc                 randconfig-002-20260225    gcc-11.5.0
sparc                 randconfig-002-20260226    gcc-8.5.0
sparc                       sparc64_defconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260225    gcc-11.5.0
sparc64               randconfig-001-20260226    gcc-8.5.0
sparc64               randconfig-002-20260225    gcc-11.5.0
sparc64               randconfig-002-20260226    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260225    gcc-11.5.0
um                    randconfig-001-20260226    gcc-8.5.0
um                    randconfig-002-20260225    gcc-11.5.0
um                    randconfig-002-20260226    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
um                           x86_64_defconfig    gcc-15.2.0
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260225    clang-20
x86_64      buildonly-randconfig-001-20260226    gcc-14
x86_64      buildonly-randconfig-002-20260225    clang-20
x86_64      buildonly-randconfig-002-20260226    gcc-14
x86_64      buildonly-randconfig-003-20260225    clang-20
x86_64      buildonly-randconfig-003-20260226    gcc-14
x86_64      buildonly-randconfig-004-20260225    clang-20
x86_64      buildonly-randconfig-004-20260226    gcc-14
x86_64      buildonly-randconfig-005-20260225    clang-20
x86_64      buildonly-randconfig-005-20260226    gcc-14
x86_64      buildonly-randconfig-006-20260225    clang-20
x86_64      buildonly-randconfig-006-20260226    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260225    gcc-14
x86_64                randconfig-001-20260226    gcc-14
x86_64                randconfig-002-20260225    gcc-14
x86_64                randconfig-002-20260226    gcc-14
x86_64                randconfig-003-20260225    gcc-14
x86_64                randconfig-003-20260226    gcc-14
x86_64                randconfig-004-20260225    gcc-14
x86_64                randconfig-004-20260226    gcc-14
x86_64                randconfig-005-20260225    gcc-14
x86_64                randconfig-005-20260226    gcc-14
x86_64                randconfig-006-20260225    gcc-14
x86_64                randconfig-006-20260226    gcc-14
x86_64                randconfig-011-20260225    gcc-14
x86_64                randconfig-011-20260226    gcc-14
x86_64                randconfig-012-20260225    clang-20
x86_64                randconfig-012-20260225    gcc-14
x86_64                randconfig-012-20260226    gcc-14
x86_64                randconfig-013-20260225    clang-20
x86_64                randconfig-013-20260225    gcc-14
x86_64                randconfig-013-20260226    gcc-14
x86_64                randconfig-014-20260225    gcc-14
x86_64                randconfig-014-20260226    gcc-14
x86_64                randconfig-015-20260225    gcc-14
x86_64                randconfig-015-20260226    gcc-14
x86_64                randconfig-016-20260225    gcc-14
x86_64                randconfig-016-20260226    gcc-14
x86_64                randconfig-071-20260225    clang-20
x86_64                randconfig-071-20260226    gcc-14
x86_64                randconfig-072-20260225    clang-20
x86_64                randconfig-072-20260226    gcc-14
x86_64                randconfig-073-20260225    clang-20
x86_64                randconfig-073-20260226    gcc-14
x86_64                randconfig-074-20260225    clang-20
x86_64                randconfig-074-20260226    gcc-14
x86_64                randconfig-075-20260225    clang-20
x86_64                randconfig-075-20260226    gcc-14
x86_64                randconfig-076-20260225    clang-20
x86_64                randconfig-076-20260226    gcc-14
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
xtensa                       common_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260225    gcc-11.5.0
xtensa                randconfig-001-20260226    gcc-8.5.0
xtensa                randconfig-002-20260225    gcc-11.5.0
xtensa                randconfig-002-20260226    gcc-8.5.0
xtensa                    smp_lx200_defconfig    gcc-15.2.0
xtensa                         virt_defconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

