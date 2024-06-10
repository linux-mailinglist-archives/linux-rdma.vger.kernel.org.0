Return-Path: <linux-rdma+bounces-3027-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10734901E04
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2024 11:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C0DE1F229A8
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2024 09:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AF674054;
	Mon, 10 Jun 2024 09:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KRy0/0Pm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1186A18C31
	for <linux-rdma@vger.kernel.org>; Mon, 10 Jun 2024 09:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011345; cv=none; b=truT87SW75f9gMbSOp4oBJeZYFZ8Ys2TCDqX83Aw2G6b1Vxm5Kmpu1xjCXMI4MCN+Ss0KTwGmBDbQ437oWNnM3t8ssSQe89CEfcPkqlbuVA1QLqtyS3/BQHNW1yrFc4iip1ggsRlqTvEaVRiQ52n4XgV3BELd1hduTnzpxT3BCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011345; c=relaxed/simple;
	bh=SmxFs0yEpIpfCDFqGjsK42+zdThVWumwNSk7MBlKkEM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DbOjMf8YVMIP7k3+FrNQLH7sorKnYPotRoYINv2um7MdV4x4xdgO9K9xJZgOnRDhi3lncIpnS7BDqqthnZO6L2IJKiR4OaJEjXIE5Uwz1b+VtRIkvYmIf9VxegBrNYujqh/q73hr/00b4Bsccui0BwvCx8B5vpN8UCnc8RbVoyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KRy0/0Pm; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718011344; x=1749547344;
  h=date:from:to:cc:subject:message-id;
  bh=SmxFs0yEpIpfCDFqGjsK42+zdThVWumwNSk7MBlKkEM=;
  b=KRy0/0PmXi5zbJd92Esn6GtWzbfus5ZoJyAuF0HE7djOFDAKUiUlPxhl
   qzkKOxWb4Ci2+W1XPmBwVtfRLkkXF1J03H/PGxZXUbgmlPPRYwY5mcuUv
   uNl2yuXoy/8b+f2aMAdWen6HU+9vx6EQZbs5D3wh6kG1tnvLZ/ps/fqVA
   +x954f6fuO3UN5HNemsrzXtkUnmn/CsEKFKn+LcilgXDXA0QyAddsoVll
   u5Jx21MjLTwwOpDGMGS6X4CmLMyy1HaJqcksWWB2ilpEvm8b4OyxhRWvR
   omAfJaDp6K3WOzhfYOQJYNnL0q/frhVLO4eb0gZ8HBP1hNTQkJNF+ZAj2
   Q==;
X-CSE-ConnectionGUID: 6eeo5YtfQCisMgiDc06Dcw==
X-CSE-MsgGUID: 6I9EE/ftTxezaPihTHLiiA==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="25280315"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="25280315"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 02:22:22 -0700
X-CSE-ConnectionGUID: RevFMkt4TmSMLpvRMjX0DA==
X-CSE-MsgGUID: l5rK3hqWQxuDDy3EN0KLTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="69788320"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 10 Jun 2024 02:22:20 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sGbEI-00021I-0F;
	Mon, 10 Jun 2024 09:22:18 +0000
Date: Mon, 10 Jun 2024 17:21:21 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:for-rc] BUILD SUCCESS
 542bb08ab014ec52d71f3ff01e1725005cfb677a
Message-ID: <202406101716.12vcWwH7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: 542bb08ab014ec52d71f3ff01e1725005cfb677a  RDMA/mana_ib: Ignore optional access flags for MRs

elapsed time: 1447m

configs tested: 206
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20240610   gcc  
arc                   randconfig-002-20240610   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                         assabet_defconfig   clang
arm                         bcm2835_defconfig   clang
arm                        clps711x_defconfig   clang
arm                                 defconfig   clang
arm                       imx_v4_v5_defconfig   clang
arm                           imxrt_defconfig   clang
arm                             mxs_defconfig   clang
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20240610   gcc  
arm                   randconfig-002-20240610   gcc  
arm                   randconfig-003-20240610   clang
arm                   randconfig-004-20240610   gcc  
arm                         s5pv210_defconfig   gcc  
arm                          sp7021_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240610   gcc  
arm64                 randconfig-002-20240610   gcc  
arm64                 randconfig-003-20240610   gcc  
arm64                 randconfig-004-20240610   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240610   gcc  
csky                  randconfig-002-20240610   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240610   clang
hexagon               randconfig-002-20240610   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240609   gcc  
i386         buildonly-randconfig-001-20240610   clang
i386         buildonly-randconfig-002-20240609   gcc  
i386         buildonly-randconfig-003-20240609   gcc  
i386         buildonly-randconfig-004-20240609   gcc  
i386         buildonly-randconfig-004-20240610   clang
i386         buildonly-randconfig-005-20240609   clang
i386         buildonly-randconfig-006-20240609   gcc  
i386         buildonly-randconfig-006-20240610   clang
i386                                defconfig   clang
i386                  randconfig-001-20240609   clang
i386                  randconfig-002-20240609   clang
i386                  randconfig-003-20240609   gcc  
i386                  randconfig-004-20240609   gcc  
i386                  randconfig-005-20240609   clang
i386                  randconfig-005-20240610   clang
i386                  randconfig-006-20240609   clang
i386                  randconfig-011-20240609   clang
i386                  randconfig-011-20240610   clang
i386                  randconfig-012-20240609   clang
i386                  randconfig-012-20240610   clang
i386                  randconfig-013-20240609   clang
i386                  randconfig-013-20240610   clang
i386                  randconfig-014-20240609   clang
i386                  randconfig-014-20240610   clang
i386                  randconfig-015-20240609   gcc  
i386                  randconfig-015-20240610   clang
i386                  randconfig-016-20240609   clang
i386                  randconfig-016-20240610   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240610   gcc  
loongarch             randconfig-002-20240610   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm63xx_defconfig   clang
mips                         bigsur_defconfig   gcc  
mips                     loongson2k_defconfig   gcc  
mips                      pic32mzda_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240610   gcc  
nios2                 randconfig-002-20240610   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20240610   gcc  
parisc                randconfig-002-20240610   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   bluestone_defconfig   clang
powerpc                        icon_defconfig   gcc  
powerpc                  mpc885_ads_defconfig   clang
powerpc                      ppc64e_defconfig   gcc  
powerpc               randconfig-001-20240610   clang
powerpc               randconfig-002-20240610   clang
powerpc               randconfig-003-20240610   clang
powerpc                     tqm8560_defconfig   gcc  
powerpc64             randconfig-001-20240610   clang
powerpc64             randconfig-002-20240610   clang
powerpc64             randconfig-003-20240610   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                    nommu_virt_defconfig   clang
riscv                 randconfig-001-20240610   gcc  
riscv                 randconfig-002-20240610   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240610   gcc  
s390                  randconfig-002-20240610   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                    randconfig-001-20240610   gcc  
sh                    randconfig-002-20240610   gcc  
sh                          rsk7203_defconfig   gcc  
sh                          rsk7264_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240610   gcc  
sparc64               randconfig-002-20240610   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240610   gcc  
um                    randconfig-002-20240610   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240610   gcc  
x86_64       buildonly-randconfig-002-20240610   clang
x86_64       buildonly-randconfig-003-20240610   gcc  
x86_64       buildonly-randconfig-004-20240610   gcc  
x86_64       buildonly-randconfig-005-20240610   gcc  
x86_64       buildonly-randconfig-006-20240610   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240610   gcc  
x86_64                randconfig-002-20240610   gcc  
x86_64                randconfig-003-20240610   clang
x86_64                randconfig-004-20240610   gcc  
x86_64                randconfig-005-20240610   gcc  
x86_64                randconfig-006-20240610   clang
x86_64                randconfig-011-20240610   clang
x86_64                randconfig-012-20240610   gcc  
x86_64                randconfig-013-20240610   gcc  
x86_64                randconfig-014-20240610   gcc  
x86_64                randconfig-015-20240610   clang
x86_64                randconfig-016-20240610   clang
x86_64                randconfig-071-20240610   gcc  
x86_64                randconfig-072-20240610   clang
x86_64                randconfig-073-20240610   clang
x86_64                randconfig-074-20240610   gcc  
x86_64                randconfig-075-20240610   clang
x86_64                randconfig-076-20240610   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                randconfig-001-20240610   gcc  
xtensa                randconfig-002-20240610   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

