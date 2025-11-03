Return-Path: <linux-rdma+bounces-14190-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2FBC2A6B9
	for <lists+linux-rdma@lfdr.de>; Mon, 03 Nov 2025 08:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDBED4F089C
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Nov 2025 07:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6949D23ED5B;
	Mon,  3 Nov 2025 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NLdIF/5O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A0523EA82
	for <linux-rdma@vger.kernel.org>; Mon,  3 Nov 2025 07:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762156349; cv=none; b=Dpo3BtMMra0MmCsNQ+5Gmpb22AUW7ENAmDydy8Vec+AQ2G6JHNUv1nUx7euSj/j1qydICPJidOkBVtEOQZ0mebhlU4QLCJO3NBusemIT9zDQLJYKoNfRy8uEG4KdrZ20eEvQ5V+75KsX4GbmOrN11BPOLq29aSeFKozDI9Z4OpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762156349; c=relaxed/simple;
	bh=pw52fUxFacMnQqeIZ/7Vck9lm9OIGO7Q4VonNXpI8n0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=csbxDK/LWvDVNIwq0O9KYhi2gC4LoQZ+OPDoKgMlPYHIx+iFGd6KtNZP5KJP/hSqMZgYkUo3MeQAO4yBSm+/O6QtdbY8gQmy4cRtjAOePfh95G4LOTwVwcf9Rq+iRGh960f8pvjUXzQSJ5spIOQIRPkYA436o5hzncmyrKalv00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NLdIF/5O; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762156347; x=1793692347;
  h=date:from:to:cc:subject:message-id;
  bh=pw52fUxFacMnQqeIZ/7Vck9lm9OIGO7Q4VonNXpI8n0=;
  b=NLdIF/5OBagFxpbKwXtQsaJibucaJmHpxVpcWTuR4Y7nb3/5DvLkDN7X
   8lrLrr/sO0a+GPpQApWTQke5YJ43Y9tckJhnIRrQifW1zXbpBKXVhj87T
   qCzWBJ7stgju2eX6kU4FcFOMJ/XkXlROcKB+sWCmry011R8R3ht30GDEW
   DNdu6pNyW/EWglU2Rxopo/E8Hi9mdOTOhf5l1e1yD8i1WxZqwrkQxEuf8
   ZGKp2ZC7gl/vjhzecTVgEQzNAhpyY4TALkMZJHmoZJOnlkd5LlIF4nuAx
   nPZe/IWkHpzUUMj2WcYJgwb4EVuS1RG2S0pBh/NS5JflJM52ULnJ1EPfx
   Q==;
X-CSE-ConnectionGUID: zRMUNbWuRZCqIg7dQMcydA==
X-CSE-MsgGUID: ztWU6Jd3QzS2117fxvKSmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="86848947"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="86848947"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2025 23:52:27 -0800
X-CSE-ConnectionGUID: l05grqnRT/aMHWWTsg3Bbw==
X-CSE-MsgGUID: T3It+jmDQtK5RqJ7SutUjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="191961042"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 02 Nov 2025 23:52:26 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vFpMV-000Pvv-1A;
	Mon, 03 Nov 2025 07:52:23 +0000
Date: Mon, 03 Nov 2025 15:52:12 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-rc] BUILD SUCCESS
 b8126205dbe01e22b0d10c8be132bb53bf3399c1
Message-ID: <202511031506.2Tv2LTDM-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: b8126205dbe01e22b0d10c8be132bb53bf3399c1  MAINTAINERS: Update irdma maintainers

elapsed time: 1186m

configs tested: 162
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                   randconfig-001-20251102    gcc-8.5.0
arc                   randconfig-001-20251103    gcc-15.1.0
arc                   randconfig-001-20251103    gcc-9.5.0
arc                   randconfig-002-20251102    gcc-14.3.0
arc                   randconfig-002-20251103    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                   randconfig-001-20251102    gcc-15.1.0
arm                   randconfig-001-20251103    clang-22
arm                   randconfig-001-20251103    gcc-15.1.0
arm                   randconfig-002-20251102    gcc-10.5.0
arm                   randconfig-002-20251103    clang-16
arm                   randconfig-002-20251103    gcc-15.1.0
arm                   randconfig-003-20251102    gcc-8.5.0
arm                   randconfig-003-20251103    gcc-14.3.0
arm                   randconfig-003-20251103    gcc-15.1.0
arm                   randconfig-004-20251102    gcc-14.3.0
arm                   randconfig-004-20251103    clang-22
arm                   randconfig-004-20251103    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    gcc-15.1.0
arm64                 randconfig-001-20251103    gcc-8.5.0
arm64                 randconfig-002-20251103    gcc-8.5.0
arm64                 randconfig-003-20251103    gcc-8.5.0
arm64                 randconfig-004-20251103    gcc-8.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                  randconfig-001-20251103    gcc-8.5.0
csky                  randconfig-002-20251103    gcc-8.5.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon               randconfig-001-20251102    clang-22
hexagon               randconfig-001-20251103    gcc-14.3.0
hexagon               randconfig-002-20251102    clang-22
hexagon               randconfig-002-20251103    gcc-14.3.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251103    gcc-13
i386        buildonly-randconfig-002-20251103    gcc-13
i386        buildonly-randconfig-003-20251103    gcc-13
i386        buildonly-randconfig-004-20251103    gcc-13
i386        buildonly-randconfig-005-20251103    gcc-13
i386        buildonly-randconfig-006-20251103    gcc-13
i386                  randconfig-001-20251103    gcc-14
i386                  randconfig-002-20251103    gcc-14
i386                  randconfig-003-20251103    gcc-14
i386                  randconfig-004-20251103    gcc-14
i386                  randconfig-005-20251103    gcc-14
i386                  randconfig-006-20251103    gcc-14
i386                  randconfig-007-20251103    gcc-14
i386                  randconfig-011-20251103    clang-20
i386                  randconfig-012-20251103    clang-20
i386                  randconfig-013-20251103    clang-20
i386                  randconfig-014-20251103    clang-20
i386                  randconfig-015-20251103    clang-20
i386                  randconfig-016-20251103    clang-20
i386                  randconfig-017-20251103    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    gcc-15.1.0
loongarch             randconfig-001-20251102    gcc-15.1.0
loongarch             randconfig-001-20251103    gcc-14.3.0
loongarch             randconfig-002-20251102    gcc-15.1.0
loongarch             randconfig-002-20251103    gcc-14.3.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                            allyesconfig    clang-22
nios2                 randconfig-001-20251102    gcc-11.5.0
nios2                 randconfig-001-20251103    gcc-14.3.0
nios2                 randconfig-002-20251102    gcc-11.5.0
nios2                 randconfig-002-20251103    gcc-14.3.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                randconfig-001-20251103    gcc-14.3.0
parisc                randconfig-002-20251103    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20251103    gcc-8.5.0
powerpc               randconfig-002-20251103    clang-20
powerpc64             randconfig-001-20251103    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    clang-22
sparc                 randconfig-001-20251103    clang-19
sparc                 randconfig-002-20251103    clang-19
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    clang-22
sparc64               randconfig-001-20251103    clang-19
sparc64               randconfig-002-20251103    clang-19
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                    randconfig-001-20251103    clang-19
um                    randconfig-002-20251103    clang-19
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251103    gcc-14
x86_64      buildonly-randconfig-002-20251103    gcc-14
x86_64      buildonly-randconfig-003-20251103    gcc-14
x86_64      buildonly-randconfig-004-20251103    gcc-14
x86_64      buildonly-randconfig-005-20251103    gcc-14
x86_64      buildonly-randconfig-006-20251103    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-011-20251103    gcc-14
x86_64                randconfig-012-20251103    gcc-14
x86_64                randconfig-013-20251103    gcc-14
x86_64                randconfig-014-20251103    gcc-14
x86_64                randconfig-015-20251103    gcc-14
x86_64                randconfig-016-20251103    gcc-14
x86_64                randconfig-071-20251103    gcc-14
x86_64                randconfig-072-20251103    gcc-14
x86_64                randconfig-073-20251103    gcc-14
x86_64                randconfig-074-20251103    gcc-14
x86_64                randconfig-075-20251103    gcc-14
x86_64                randconfig-076-20251103    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251103    clang-19
xtensa                randconfig-002-20251103    clang-19

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

