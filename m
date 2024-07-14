Return-Path: <linux-rdma+bounces-3861-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA3F930B88
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jul 2024 22:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C49F1F229AF
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jul 2024 20:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6771139CFF;
	Sun, 14 Jul 2024 20:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lATHmk9Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A897C2572
	for <linux-rdma@vger.kernel.org>; Sun, 14 Jul 2024 20:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720988490; cv=none; b=TgTjv4a2yM1E8rHQswzLItUGmOXjCNlUI5Oxo0BtO+bjzcVotmN2S+7/+zWoljp43YED/BNidAoxGGy2BRu4yRFhnnWn1eH98LYm6e1gedazF6QbIQ9cy74IpedQbqywniOF/qN2u24Bx+PSDpw8nRXFeRaDLptbPJjJNnD49Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720988490; c=relaxed/simple;
	bh=fjRghipbF4lCN7RiyAF0ER1iRUNJJqRUkhbmHWce23Y=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XWjVHmzZDioF/lba7P6b9BoRh4SGkzKtR+Q+bgVxblIVuMcatJQ1yt7SI5atbjhHc21Kqmen2AtuqyHB9QfTgCsPagZVQdfLcaGAi0WBOkylfkTAUr70WnVjckJJjY9CSi0t+haz5ujBm3Zj8JdIIzastPyHE0s6x4ZrTN5qkt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lATHmk9Q; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720988489; x=1752524489;
  h=date:from:to:cc:subject:message-id;
  bh=fjRghipbF4lCN7RiyAF0ER1iRUNJJqRUkhbmHWce23Y=;
  b=lATHmk9Q7OhsNyLdjDAdi5S8IP7OP4BBgzWuHLGiZ3AcUhieUX6S6gpE
   pScP9s9aaDj3YKYDHbqv14zhiJZHXTq9UNH9atd8ru7renOp4/5mblZ4B
   ke0QRgq52l2CvzUdF06j2NgyjX2H3CzJPkohxhRB4ts9WV32Oif0oqtcA
   mSUHhYey1sieKgEfP3EPLadch7SWfdl0/rUJJKL9IKEBOgCpZy/YM0lp/
   XX6eIDBTks6cLdOXkKX+sPzOimfQlc53v0A0ZswXQwY6ikgp4nxY3oDyU
   03u+ojlmK1Ha/wZZfOB/DKKyYkLa9LMV57QJgzjTbXOQx2OujRP+zl6tf
   Q==;
X-CSE-ConnectionGUID: 7FCqbku9S2KACecFJIAIEA==
X-CSE-MsgGUID: KmoLFZXfQsGh3yedQ61bfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="18514125"
X-IronPort-AV: E=Sophos;i="6.09,208,1716274800"; 
   d="scan'208";a="18514125"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2024 13:21:28 -0700
X-CSE-ConnectionGUID: fHB9O4DsT4uw53ROi0dB0Q==
X-CSE-MsgGUID: EVErmpexStO4aZPAjheS+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,208,1716274800"; 
   d="scan'208";a="53720122"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 14 Jul 2024 13:21:26 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sT5im-000diE-1O;
	Sun, 14 Jul 2024 20:21:24 +0000
Date: Mon, 15 Jul 2024 04:20:30 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-next] BUILD SUCCESS
 95b087f87b780daafad1dbb2c84e81b729d5d33f
Message-ID: <202407150425.9wDwX8n9-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 95b087f87b780daafad1dbb2c84e81b729d5d33f  bnxt_re: Fix imm_data endianness

elapsed time: 750m

configs tested: 181
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                        nsim_700_defconfig   gcc-13.2.0
arc                   randconfig-001-20240714   gcc-13.2.0
arc                   randconfig-002-20240714   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                         lpc18xx_defconfig   clang-19
arm                        multi_v5_defconfig   gcc-14.1.0
arm                   randconfig-001-20240714   clang-19
arm                   randconfig-002-20240714   clang-15
arm                   randconfig-003-20240714   clang-17
arm                   randconfig-004-20240714   clang-15
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240714   clang-15
arm64                 randconfig-002-20240714   clang-19
arm64                 randconfig-003-20240714   clang-19
arm64                 randconfig-004-20240714   gcc-14.1.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240714   gcc-14.1.0
csky                  randconfig-002-20240714   gcc-14.1.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240714   clang-19
hexagon               randconfig-002-20240714   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240714   gcc-13
i386         buildonly-randconfig-002-20240714   clang-18
i386         buildonly-randconfig-003-20240714   gcc-11
i386         buildonly-randconfig-004-20240714   clang-18
i386         buildonly-randconfig-005-20240714   gcc-9
i386         buildonly-randconfig-006-20240714   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240714   clang-18
i386                  randconfig-002-20240714   clang-18
i386                  randconfig-003-20240714   clang-18
i386                  randconfig-004-20240714   clang-18
i386                  randconfig-005-20240714   clang-18
i386                  randconfig-006-20240714   gcc-7
i386                  randconfig-011-20240714   clang-18
i386                  randconfig-012-20240714   gcc-13
i386                  randconfig-013-20240714   clang-18
i386                  randconfig-014-20240714   gcc-10
i386                  randconfig-015-20240714   gcc-13
i386                  randconfig-016-20240714   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240714   gcc-14.1.0
loongarch             randconfig-002-20240714   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                          multi_defconfig   gcc-14.1.0
microblaze                       alldefconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                         db1xxx_defconfig   clang-19
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240714   gcc-14.1.0
nios2                 randconfig-002-20240714   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240714   gcc-14.1.0
parisc                randconfig-002-20240714   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc                   bluestone_defconfig   clang-19
powerpc                      chrp32_defconfig   clang-19
powerpc                     kilauea_defconfig   clang-19
powerpc                     kmeter1_defconfig   gcc-14.1.0
powerpc                   lite5200b_defconfig   clang-14
powerpc                      pcm030_defconfig   clang-19
powerpc                      ppc44x_defconfig   clang-16
powerpc               randconfig-001-20240714   clang-19
powerpc               randconfig-002-20240714   clang-19
powerpc               randconfig-003-20240714   gcc-14.1.0
powerpc64             randconfig-001-20240714   gcc-14.1.0
powerpc64             randconfig-002-20240714   gcc-14.1.0
powerpc64             randconfig-003-20240714   gcc-14.1.0
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                               defconfig   clang-19
riscv                 randconfig-002-20240714   clang-15
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                          debug_defconfig   gcc-14.1.0
s390                                defconfig   clang-19
s390                  randconfig-002-20240714   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240714   gcc-14.1.0
sh                    randconfig-002-20240714   gcc-14.1.0
sh                          rsk7264_defconfig   gcc-14.1.0
sh                           se7619_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240714   clang-18
x86_64       buildonly-randconfig-002-20240714   gcc-13
x86_64       buildonly-randconfig-003-20240714   gcc-13
x86_64       buildonly-randconfig-004-20240714   clang-18
x86_64       buildonly-randconfig-005-20240714   clang-18
x86_64       buildonly-randconfig-006-20240714   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240714   gcc-13
x86_64                randconfig-002-20240714   clang-18
x86_64                randconfig-003-20240714   gcc-13
x86_64                randconfig-004-20240714   clang-18
x86_64                randconfig-005-20240714   gcc-10
x86_64                randconfig-006-20240714   gcc-10
x86_64                randconfig-011-20240714   clang-18
x86_64                randconfig-012-20240714   gcc-7
x86_64                randconfig-013-20240714   clang-18
x86_64                randconfig-014-20240714   clang-18
x86_64                randconfig-015-20240714   gcc-13
x86_64                randconfig-016-20240714   clang-18
x86_64                randconfig-071-20240714   clang-18
x86_64                randconfig-072-20240714   gcc-13
x86_64                randconfig-073-20240714   clang-18
x86_64                randconfig-074-20240714   clang-18
x86_64                randconfig-075-20240714   clang-18
x86_64                randconfig-076-20240714   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                  audio_kc705_defconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

