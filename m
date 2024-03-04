Return-Path: <linux-rdma+bounces-1201-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CD286FB15
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Mar 2024 08:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22632821C9
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Mar 2024 07:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9C014AAE;
	Mon,  4 Mar 2024 07:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gEpLKr2f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BF053A6
	for <linux-rdma@vger.kernel.org>; Mon,  4 Mar 2024 07:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709538489; cv=none; b=YcnIbCrsyyrq4X/qxKL7kOUC4K/4nCvqvtDQl0LOxmNu8tdgUyJrcVEOXUZl6VrtQGs9yRnjwyGhi9JDMAjxgROdtCrl1g/C7DOogNkKZevqOstVUlDL0VX4wjF6k7Q+F9skG1nGAZL3yNUSzA0YkiVpT1E/ABTyw/XpZUZDl2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709538489; c=relaxed/simple;
	bh=fI6W4vM5qVwzbYDpnehp2QrG5jZV77AljeX0OOUQ9W8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Bj0ILkfGn0Z5xqmz8ZgwEiC14PcSkACYKZiCExHmLgijoBfr2Lf9CrhtXkACZMLTvradCzOC7KScmyvLBtfSQDXCGRpUma5gcUP8SJ7TnNs1265WuxMnX/SSvnK9+VtKr7EXiibd69WBRCBQ3GCj9CMAA+SpXM0jGMxDXMmMSYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gEpLKr2f; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709538487; x=1741074487;
  h=date:from:to:cc:subject:message-id;
  bh=fI6W4vM5qVwzbYDpnehp2QrG5jZV77AljeX0OOUQ9W8=;
  b=gEpLKr2fpyNog8XVzqeE1vS1gvS6DFIfopVp7Z1ra5iAySfsutPy0GgU
   25Ta/aQmeLrPIVHte1ZNjxYHn+cYlnMXJZpX/YGFHXeKWBSeE5o3dNCqK
   wTmaa8jN3DrD9zh8G0qWdAeiEgLENdl2bkzVcTOjwAjiRj0v6p1QrwDqV
   k3mZD4UhlOwrQOVW2iYtuLfhDKDOCEeF3r1w42uDA8+470/4V6PnnlhH8
   HsqksI9UgdKhOA0infKaomO2wHNxeYJE58jPBcXM84d+wDv1id67ZztCm
   deCh8xa6VcoUTgTpndv3cpiK3MUvmpDMFMtCMJqdQMd1kymiChXfrtnRi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="26478535"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="26478535"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 23:48:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="13467572"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 03 Mar 2024 23:48:05 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rh33L-0002O1-06;
	Mon, 04 Mar 2024 07:48:03 +0000
Date: Mon, 04 Mar 2024 15:47:53 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 155f04366e3cad7cc7471f8736aa05ec0300cddd
Message-ID: <202403041548.Fm9BL73B-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 155f04366e3cad7cc7471f8736aa05ec0300cddd  RDMA/uverbs: Avoid -Wflex-array-member-not-at-end warnings

elapsed time: 1079m

configs tested: 179
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
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240304   gcc  
arc                   randconfig-002-20240304   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                           omap1_defconfig   gcc  
arm                   randconfig-001-20240304   clang
arm                   randconfig-002-20240304   gcc  
arm                   randconfig-003-20240304   clang
arm                   randconfig-004-20240304   clang
arm                           stm32_defconfig   gcc  
arm                        vexpress_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240304   gcc  
arm64                 randconfig-002-20240304   gcc  
arm64                 randconfig-003-20240304   clang
arm64                 randconfig-004-20240304   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240304   gcc  
csky                  randconfig-002-20240304   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240304   clang
hexagon               randconfig-002-20240304   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240303   clang
i386         buildonly-randconfig-002-20240303   clang
i386         buildonly-randconfig-003-20240303   gcc  
i386         buildonly-randconfig-004-20240303   clang
i386         buildonly-randconfig-005-20240303   clang
i386         buildonly-randconfig-006-20240303   clang
i386                                defconfig   clang
i386                  randconfig-001-20240303   gcc  
i386                  randconfig-002-20240303   gcc  
i386                  randconfig-003-20240303   gcc  
i386                  randconfig-004-20240303   clang
i386                  randconfig-005-20240303   gcc  
i386                  randconfig-006-20240303   gcc  
i386                  randconfig-011-20240303   clang
i386                  randconfig-012-20240303   gcc  
i386                  randconfig-013-20240303   gcc  
i386                  randconfig-014-20240303   gcc  
i386                  randconfig-015-20240303   gcc  
i386                  randconfig-016-20240303   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240304   gcc  
loongarch             randconfig-002-20240304   gcc  
m68k                             alldefconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                           ip28_defconfig   gcc  
mips                       rbtx49xx_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240304   gcc  
nios2                 randconfig-002-20240304   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           alldefconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20240304   gcc  
parisc                randconfig-002-20240304   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        cell_defconfig   gcc  
powerpc                          g5_defconfig   gcc  
powerpc               randconfig-001-20240304   clang
powerpc               randconfig-002-20240304   clang
powerpc               randconfig-003-20240304   clang
powerpc                 xes_mpc85xx_defconfig   gcc  
powerpc64             randconfig-001-20240304   clang
powerpc64             randconfig-002-20240304   clang
powerpc64             randconfig-003-20240304   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20240304   clang
riscv                 randconfig-002-20240304   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240304   gcc  
s390                  randconfig-002-20240304   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240304   gcc  
sh                    randconfig-002-20240304   gcc  
sh                          rsk7269_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240304   gcc  
sparc64               randconfig-002-20240304   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240304   gcc  
um                    randconfig-002-20240304   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240304   clang
x86_64       buildonly-randconfig-002-20240304   clang
x86_64       buildonly-randconfig-003-20240304   clang
x86_64       buildonly-randconfig-004-20240304   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240304   clang
x86_64                randconfig-002-20240304   clang
x86_64                randconfig-004-20240304   clang
x86_64                randconfig-012-20240304   clang
x86_64                randconfig-013-20240304   clang
x86_64                randconfig-014-20240304   clang
x86_64                randconfig-015-20240304   clang
x86_64                randconfig-071-20240304   clang
x86_64                randconfig-072-20240304   clang
x86_64                randconfig-073-20240304   clang
x86_64                randconfig-074-20240304   clang
x86_64                randconfig-075-20240304   clang
x86_64                randconfig-076-20240304   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240304   gcc  
xtensa                randconfig-002-20240304   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

