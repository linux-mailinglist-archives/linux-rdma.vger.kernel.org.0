Return-Path: <linux-rdma+bounces-4091-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A3694054C
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 04:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B36628515F
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 02:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FD3148314;
	Tue, 30 Jul 2024 02:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cp+xFMtg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEE1138E
	for <linux-rdma@vger.kernel.org>; Tue, 30 Jul 2024 02:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722306801; cv=none; b=JBvN8HJve0Lrxv1l5sbfGwZ3LkcScejvqIrUBxeAVu7NcWV0PIyVUl5Rftsld/XA7Hxa8PcuzS7vWEnpgi4qWW0ZuKaRIGXYWdcu8fznwaMXwcyFYhaGgBCDYPucOI+WYGDZAThgUnYWzUXDs/7P/YeH8dxB+nESeSRg3ST9AZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722306801; c=relaxed/simple;
	bh=oinzOtdC/vMmYbaJdLM8AUTMOWPq1VaVXEUYs8a/jpE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Eapf+zsdAXDJ63MBLGwM1blbBr+MdwOfjd07mpJKvJdnF52zuBY9OeVBVui8/m3h6s2TZMBFUNptOxvU0O3XvScEjssLS2ogrMOG0du64XYgT7JlkhCZqkXbkqCDsSEihVpteTz7QNGXmxpb6Xr8QRUREeWRerPKEd3nkmCmR0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cp+xFMtg; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722306799; x=1753842799;
  h=date:from:to:cc:subject:message-id;
  bh=oinzOtdC/vMmYbaJdLM8AUTMOWPq1VaVXEUYs8a/jpE=;
  b=cp+xFMtg2SnbZgIO+TyQkKhsDsKWA1/htKyv5K8osZQtjr4Fl6ufxAlB
   IavgMwjb9SIW38HrQTVx9bvu46kbubpeOoybV4kXPdZ1iEmgPtF78t8dH
   hLnuRyObv5zSHojBjX1t8KnYL4lcnSBh/EzhAt4EKHdsBGyGJSQ+zob7b
   ELG68UegPS/Ra3tOwtC5bsgHjQnkB8I33xhqlx0mE2ULSQWMgQRE7HJCK
   wL9iKGIdsmFcTi3CTytGe6TT3lYPDDt0AOr/bT8OWH82+JBZxE87xLvpt
   RvWwK8byV7hgo4M7eb+OkT9gJybx4OUHnix3RX3MGYu38e4ECGWLIdis0
   Q==;
X-CSE-ConnectionGUID: 27VgLEk9RKyHBEf8Om/afA==
X-CSE-MsgGUID: +XZqaCDoTk2GGebb6caN/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="23890472"
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="23890472"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 19:33:18 -0700
X-CSE-ConnectionGUID: DHP+95vkRLCpmgV3WDw/UQ==
X-CSE-MsgGUID: IVME6cl0SC245qPRCQXdvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="58495909"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 29 Jul 2024 19:33:16 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYcfq-000sND-2E;
	Tue, 30 Jul 2024 02:33:14 +0000
Date: Tue, 30 Jul 2024 10:32:37 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 60dc7fcafea817f3dcff7ece18095ca6260b73bc
Message-ID: <202407301032.csZZZHU5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 60dc7fcafea817f3dcff7ece18095ca6260b73bc  RDMA/siw: Remove NETDEV_GOING_DOWN event handler

elapsed time: 1043m

configs tested: 235
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc-13.3.0
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                        nsimosci_defconfig   gcc-13.2.0
arc                     nsimosci_hs_defconfig   gcc-13.2.0
arc                   randconfig-001-20240729   gcc-13.2.0
arc                   randconfig-002-20240729   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                            dove_defconfig   gcc-13.3.0
arm                      footbridge_defconfig   gcc-13.2.0
arm                            hisi_defconfig   gcc-13.2.0
arm                       imx_v4_v5_defconfig   gcc-13.2.0
arm                      integrator_defconfig   gcc-13.3.0
arm                          ixp4xx_defconfig   gcc-13.2.0
arm                        keystone_defconfig   gcc-13.2.0
arm                         nhk8815_defconfig   gcc-13.3.0
arm                             pxa_defconfig   gcc-13.2.0
arm                   randconfig-001-20240729   gcc-13.2.0
arm                   randconfig-002-20240729   gcc-13.2.0
arm                   randconfig-003-20240729   gcc-13.2.0
arm                   randconfig-004-20240729   gcc-13.2.0
arm                        shmobile_defconfig   gcc-13.3.0
arm                       spear13xx_defconfig   gcc-13.3.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240729   gcc-13.2.0
arm64                 randconfig-002-20240729   gcc-13.2.0
arm64                 randconfig-003-20240729   gcc-13.2.0
arm64                 randconfig-004-20240729   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240729   gcc-13.2.0
csky                  randconfig-002-20240729   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240729   clang-18
i386         buildonly-randconfig-001-20240730   gcc-13
i386         buildonly-randconfig-002-20240729   clang-18
i386         buildonly-randconfig-002-20240729   gcc-13
i386         buildonly-randconfig-002-20240730   gcc-13
i386         buildonly-randconfig-003-20240729   clang-18
i386         buildonly-randconfig-003-20240730   gcc-13
i386         buildonly-randconfig-004-20240729   clang-18
i386         buildonly-randconfig-004-20240729   gcc-10
i386         buildonly-randconfig-004-20240730   gcc-13
i386         buildonly-randconfig-005-20240729   clang-18
i386         buildonly-randconfig-005-20240730   gcc-13
i386         buildonly-randconfig-006-20240729   clang-18
i386         buildonly-randconfig-006-20240729   gcc-8
i386         buildonly-randconfig-006-20240730   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240729   clang-18
i386                  randconfig-001-20240729   gcc-12
i386                  randconfig-001-20240730   gcc-13
i386                  randconfig-002-20240729   clang-18
i386                  randconfig-002-20240730   gcc-13
i386                  randconfig-003-20240729   clang-18
i386                  randconfig-003-20240729   gcc-10
i386                  randconfig-003-20240730   gcc-13
i386                  randconfig-004-20240729   clang-18
i386                  randconfig-004-20240729   gcc-13
i386                  randconfig-004-20240730   gcc-13
i386                  randconfig-005-20240729   clang-18
i386                  randconfig-005-20240729   gcc-8
i386                  randconfig-005-20240730   gcc-13
i386                  randconfig-006-20240729   clang-18
i386                  randconfig-006-20240729   gcc-13
i386                  randconfig-006-20240730   gcc-13
i386                  randconfig-011-20240729   clang-18
i386                  randconfig-011-20240729   gcc-13
i386                  randconfig-011-20240730   gcc-13
i386                  randconfig-012-20240729   clang-18
i386                  randconfig-012-20240730   gcc-13
i386                  randconfig-013-20240729   clang-18
i386                  randconfig-013-20240729   gcc-9
i386                  randconfig-013-20240730   gcc-13
i386                  randconfig-014-20240729   clang-18
i386                  randconfig-014-20240730   gcc-13
i386                  randconfig-015-20240729   clang-18
i386                  randconfig-015-20240729   gcc-13
i386                  randconfig-015-20240730   gcc-13
i386                  randconfig-016-20240729   clang-18
i386                  randconfig-016-20240730   gcc-13
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240729   gcc-13.2.0
loongarch             randconfig-002-20240729   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                       m5475evb_defconfig   gcc-13.2.0
m68k                            mac_defconfig   gcc-13.2.0
m68k                        mvme147_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                     cu1000-neo_defconfig   gcc-13.2.0
mips                           gcw0_defconfig   gcc-13.2.0
mips                            gpr_defconfig   gcc-13.2.0
mips                      malta_kvm_defconfig   gcc-13.2.0
mips                      maltaaprp_defconfig   gcc-13.2.0
mips                        qi_lb60_defconfig   gcc-13.3.0
mips                           xway_defconfig   gcc-13.2.0
nios2                         10m50_defconfig   gcc-13.3.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240729   gcc-13.2.0
nios2                 randconfig-002-20240729   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                generic-64bit_defconfig   gcc-13.2.0
parisc                generic-64bit_defconfig   gcc-13.3.0
parisc                randconfig-001-20240729   gcc-13.2.0
parisc                randconfig-002-20240729   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                 canyonlands_defconfig   gcc-13.2.0
powerpc                       eiger_defconfig   gcc-13.3.0
powerpc                      katmai_defconfig   gcc-13.2.0
powerpc                 mpc8313_rdb_defconfig   gcc-13.2.0
powerpc                 mpc8315_rdb_defconfig   gcc-13.2.0
powerpc                 mpc834x_itx_defconfig   gcc-13.3.0
powerpc                     ppa8548_defconfig   gcc-13.2.0
powerpc                     rainier_defconfig   gcc-13.3.0
powerpc                    sam440ep_defconfig   gcc-13.2.0
powerpc                     tqm5200_defconfig   gcc-13.3.0
powerpc                     tqm8541_defconfig   gcc-13.3.0
powerpc                     tqm8548_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240729   gcc-13.2.0
powerpc64             randconfig-002-20240729   gcc-13.2.0
powerpc64             randconfig-003-20240729   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240729   gcc-13.2.0
riscv                 randconfig-002-20240729   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240729   gcc-13.2.0
s390                  randconfig-002-20240729   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                             espt_defconfig   gcc-13.2.0
sh                               j2_defconfig   gcc-13.2.0
sh                          polaris_defconfig   gcc-13.2.0
sh                          r7780mp_defconfig   gcc-13.2.0
sh                    randconfig-001-20240729   gcc-13.2.0
sh                    randconfig-002-20240729   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-13.3.0
sh                          sdk7786_defconfig   gcc-13.2.0
sh                           se7206_defconfig   gcc-13.2.0
sh                           se7721_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240729   gcc-13.2.0
sparc64               randconfig-002-20240729   gcc-13.2.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240729   gcc-13.2.0
um                    randconfig-002-20240729   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240729   clang-18
x86_64       buildonly-randconfig-002-20240729   clang-18
x86_64       buildonly-randconfig-003-20240729   clang-18
x86_64       buildonly-randconfig-004-20240729   clang-18
x86_64       buildonly-randconfig-005-20240729   clang-18
x86_64       buildonly-randconfig-006-20240729   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240729   clang-18
x86_64                randconfig-002-20240729   clang-18
x86_64                randconfig-003-20240729   clang-18
x86_64                randconfig-004-20240729   clang-18
x86_64                randconfig-005-20240729   clang-18
x86_64                randconfig-006-20240729   clang-18
x86_64                randconfig-011-20240729   clang-18
x86_64                randconfig-012-20240729   clang-18
x86_64                randconfig-013-20240729   clang-18
x86_64                randconfig-014-20240729   clang-18
x86_64                randconfig-015-20240729   clang-18
x86_64                randconfig-016-20240729   clang-18
x86_64                randconfig-071-20240729   clang-18
x86_64                randconfig-072-20240729   clang-18
x86_64                randconfig-073-20240729   clang-18
x86_64                randconfig-074-20240729   clang-18
x86_64                randconfig-075-20240729   clang-18
x86_64                randconfig-076-20240729   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240729   gcc-13.2.0
xtensa                randconfig-002-20240729   gcc-13.2.0
xtensa                    smp_lx200_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

