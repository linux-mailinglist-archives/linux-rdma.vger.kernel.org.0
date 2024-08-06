Return-Path: <linux-rdma+bounces-4213-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CDA948C82
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2024 12:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A50AB25D13
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2024 10:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F304165EFB;
	Tue,  6 Aug 2024 10:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAvfbnoQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11028A35
	for <linux-rdma@vger.kernel.org>; Tue,  6 Aug 2024 10:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722938461; cv=none; b=hbXRfmZqTty6d5pKi6mclCvcgeCDZGHPYsopE0kpH9bgvH5ZezhoKJOp9oXVSwbaM5exkqZb9PzLdA7VBJRwAcz7+OGsiKHyOLcTypYb++3k499lRPjjZpK2p/aW7kqP2lBsp57JY9F7hMZsH2u5M8VXIkDMzTL3re0dTDr1dLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722938461; c=relaxed/simple;
	bh=D2fEkrEEyLDCJ7GKCrkn9Ra5qNJwi3hO1CH7xoPDbUc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iGvh/ylULTPnAhX+/NMB/jHi0tTUzrNGWa4CSUMD6cKNQdtwfrg22p831tCBrKZXyTmYqAtPv+GX8+ShEyX9gc9QwgXt5IJFPSDD9AcqMjVZFo8sgnnaUzjy+q3IimLTfqgb2SR1fv4CVGmXEJpVUbZoZDFN8ok3cGLyNYRVKU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAvfbnoQ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722938459; x=1754474459;
  h=date:from:to:cc:subject:message-id;
  bh=D2fEkrEEyLDCJ7GKCrkn9Ra5qNJwi3hO1CH7xoPDbUc=;
  b=NAvfbnoQqcHjYZ0EvFoVQQKMAxzLL56q7zYYrZsmrsYeOeN7Pf2vJeHy
   4OIHtKWJ4UNb4ec6UT8VZt6xRNDB8FQWIu9L9VJpDbag15UhfskkEyTwU
   ATx5oEofxHfSgSBSpxd/zGzcoPbBv4ffK5nHzNxCAwGVl9pOY0VEte2Nw
   ZGW/8mJ+pmTfVsMu6rdbVJWNslmrT2MNixvzbpKwMsNV7SSnlIwxx9arP
   kXm6UGoPD1gQNfpowMIa7he5QwFVxDhjtpHGq47ohmpfpJ/fMkPHd5F5a
   G/uPkCTe2KAemTB9rZH1q+NpEb3vp/A1inGQUBh6PJDf/QdryPohsnJ/j
   A==;
X-CSE-ConnectionGUID: Jlm94UicScCoTHhPO+mJrQ==
X-CSE-MsgGUID: F0nrQYC0Td6fg4qlkHDV/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="38397117"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="38397117"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 03:00:58 -0700
X-CSE-ConnectionGUID: xJJTHzv7QhSg0g+GnHR4EA==
X-CSE-MsgGUID: 1vy2PQOmSLiuQNLxSJ+1vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="61085124"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 06 Aug 2024 03:00:50 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbGyJ-0004Nk-0X;
	Tue, 06 Aug 2024 09:59:37 +0000
Date: Tue, 06 Aug 2024 17:58:56 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 d29d64e8d65960365fbec44f177acb61a7b8523b
Message-ID: <202408061753.Z0ggwDlW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: d29d64e8d65960365fbec44f177acb61a7b8523b  RDMA/mlx5: Expose vhca id for all ports in multiport mode

elapsed time: 1342m

configs tested: 312
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                          axs103_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                        nsimosci_defconfig   gcc-13.2.0
arc                 nsimosci_hs_smp_defconfig   gcc-13.2.0
arc                   randconfig-001-20240805   gcc-13.2.0
arc                   randconfig-001-20240806   gcc-13.2.0
arc                   randconfig-002-20240805   gcc-13.2.0
arc                   randconfig-002-20240806   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                         assabet_defconfig   gcc-13.2.0
arm                         axm55xx_defconfig   gcc-13.2.0
arm                         bcm2835_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                            dove_defconfig   gcc-13.2.0
arm                          ep93xx_defconfig   gcc-13.2.0
arm                            hisi_defconfig   gcc-13.2.0
arm                      jornada720_defconfig   gcc-13.2.0
arm                        keystone_defconfig   gcc-13.2.0
arm                         mv78xx0_defconfig   gcc-13.2.0
arm                        mvebu_v5_defconfig   gcc-13.2.0
arm                         nhk8815_defconfig   gcc-13.2.0
arm                           omap1_defconfig   gcc-13.2.0
arm                         orion5x_defconfig   gcc-13.2.0
arm                            qcom_defconfig   gcc-13.2.0
arm                   randconfig-001-20240805   gcc-14.1.0
arm                   randconfig-001-20240806   gcc-13.2.0
arm                   randconfig-002-20240805   clang-20
arm                   randconfig-002-20240806   gcc-13.2.0
arm                   randconfig-003-20240805   clang-20
arm                   randconfig-003-20240806   gcc-13.2.0
arm                   randconfig-004-20240805   clang-20
arm                   randconfig-004-20240806   gcc-13.2.0
arm                             rpc_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240805   clang-20
arm64                 randconfig-001-20240806   gcc-13.2.0
arm64                 randconfig-002-20240805   clang-20
arm64                 randconfig-002-20240806   gcc-13.2.0
arm64                 randconfig-003-20240805   clang-17
arm64                 randconfig-003-20240806   gcc-13.2.0
arm64                 randconfig-004-20240805   gcc-14.1.0
arm64                 randconfig-004-20240806   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240805   gcc-14.1.0
csky                  randconfig-001-20240806   gcc-13.2.0
csky                  randconfig-002-20240805   gcc-14.1.0
csky                  randconfig-002-20240806   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240805   clang-16
hexagon               randconfig-002-20240805   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240805   clang-18
i386         buildonly-randconfig-001-20240806   gcc-11
i386         buildonly-randconfig-002-20240805   clang-18
i386         buildonly-randconfig-002-20240806   gcc-11
i386         buildonly-randconfig-003-20240805   clang-18
i386         buildonly-randconfig-003-20240806   gcc-11
i386         buildonly-randconfig-004-20240805   clang-18
i386         buildonly-randconfig-004-20240806   gcc-11
i386         buildonly-randconfig-005-20240805   clang-18
i386         buildonly-randconfig-005-20240806   gcc-11
i386         buildonly-randconfig-006-20240805   clang-18
i386         buildonly-randconfig-006-20240805   gcc-12
i386         buildonly-randconfig-006-20240806   gcc-11
i386                                defconfig   clang-18
i386                  randconfig-001-20240805   clang-18
i386                  randconfig-001-20240806   gcc-11
i386                  randconfig-002-20240805   clang-18
i386                  randconfig-002-20240806   gcc-11
i386                  randconfig-003-20240805   clang-18
i386                  randconfig-003-20240806   gcc-11
i386                  randconfig-004-20240805   clang-18
i386                  randconfig-004-20240806   gcc-11
i386                  randconfig-005-20240805   clang-18
i386                  randconfig-005-20240805   gcc-12
i386                  randconfig-005-20240806   gcc-11
i386                  randconfig-006-20240805   clang-18
i386                  randconfig-006-20240806   gcc-11
i386                  randconfig-011-20240805   clang-18
i386                  randconfig-011-20240806   gcc-11
i386                  randconfig-012-20240805   clang-18
i386                  randconfig-012-20240805   gcc-11
i386                  randconfig-012-20240806   gcc-11
i386                  randconfig-013-20240805   clang-18
i386                  randconfig-013-20240805   gcc-12
i386                  randconfig-013-20240806   gcc-11
i386                  randconfig-014-20240805   clang-18
i386                  randconfig-014-20240805   gcc-12
i386                  randconfig-014-20240806   gcc-11
i386                  randconfig-015-20240805   clang-18
i386                  randconfig-015-20240805   gcc-12
i386                  randconfig-015-20240806   gcc-11
i386                  randconfig-016-20240805   clang-18
i386                  randconfig-016-20240806   gcc-11
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240805   gcc-14.1.0
loongarch             randconfig-001-20240806   gcc-13.2.0
loongarch             randconfig-002-20240805   gcc-14.1.0
loongarch             randconfig-002-20240806   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                        m5407c3_defconfig   gcc-13.2.0
m68k                        mvme147_defconfig   gcc-13.2.0
m68k                           virt_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                        bcm47xx_defconfig   gcc-13.2.0
mips                       bmips_be_defconfig   gcc-13.2.0
mips                         cobalt_defconfig   gcc-13.2.0
mips                     cu1000-neo_defconfig   gcc-13.2.0
mips                         db1xxx_defconfig   gcc-13.2.0
mips                          eyeq6_defconfig   gcc-13.2.0
mips                      fuloong2e_defconfig   gcc-13.2.0
mips                           ip22_defconfig   gcc-13.2.0
mips                           ip28_defconfig   gcc-13.2.0
mips                      maltasmvp_defconfig   gcc-13.2.0
mips                        omega2p_defconfig   gcc-13.2.0
mips                        vocore2_defconfig   gcc-13.2.0
nios2                         10m50_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240805   gcc-14.1.0
nios2                 randconfig-001-20240806   gcc-13.2.0
nios2                 randconfig-002-20240805   gcc-14.1.0
nios2                 randconfig-002-20240806   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
openrisc                       virt_defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240805   gcc-14.1.0
parisc                randconfig-001-20240806   gcc-13.2.0
parisc                randconfig-002-20240805   gcc-14.1.0
parisc                randconfig-002-20240806   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                   bluestone_defconfig   gcc-13.2.0
powerpc                      cm5200_defconfig   gcc-13.2.0
powerpc                   currituck_defconfig   gcc-13.2.0
powerpc                       ebony_defconfig   gcc-13.2.0
powerpc                        fsp2_defconfig   gcc-13.2.0
powerpc                     kmeter1_defconfig   gcc-13.2.0
powerpc                 mpc834x_itx_defconfig   gcc-13.2.0
powerpc                 mpc837x_rdb_defconfig   gcc-13.2.0
powerpc                  mpc866_ads_defconfig   gcc-13.2.0
powerpc                  mpc885_ads_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240805   gcc-14.1.0
powerpc               randconfig-001-20240806   gcc-13.2.0
powerpc               randconfig-003-20240806   gcc-13.2.0
powerpc                    socrates_defconfig   gcc-13.2.0
powerpc                     tqm5200_defconfig   gcc-13.2.0
powerpc                     tqm8540_defconfig   gcc-13.2.0
powerpc                     tqm8555_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240805   gcc-14.1.0
powerpc64             randconfig-001-20240806   gcc-13.2.0
powerpc64             randconfig-002-20240805   clang-15
powerpc64             randconfig-002-20240806   gcc-13.2.0
powerpc64             randconfig-003-20240805   gcc-13.2.0
powerpc64             randconfig-003-20240806   gcc-13.2.0
riscv                            alldefconfig   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240805   gcc-14.1.0
riscv                 randconfig-001-20240806   gcc-13.2.0
riscv                 randconfig-002-20240805   clang-20
riscv                 randconfig-002-20240806   gcc-13.2.0
s390                             alldefconfig   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240805   clang-20
s390                  randconfig-001-20240806   gcc-13.2.0
s390                  randconfig-002-20240805   gcc-14.1.0
s390                  randconfig-002-20240806   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240805   gcc-14.1.0
sh                    randconfig-001-20240806   gcc-13.2.0
sh                    randconfig-002-20240805   gcc-14.1.0
sh                    randconfig-002-20240806   gcc-13.2.0
sh                           se7343_defconfig   gcc-13.2.0
sh                           se7712_defconfig   gcc-13.2.0
sh                  sh7785lcr_32bit_defconfig   gcc-13.2.0
sh                            shmin_defconfig   gcc-13.2.0
sh                            titan_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc32_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240805   gcc-14.1.0
sparc64               randconfig-001-20240806   gcc-13.2.0
sparc64               randconfig-002-20240805   gcc-14.1.0
sparc64               randconfig-002-20240806   gcc-13.2.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240805   clang-20
um                    randconfig-001-20240806   gcc-13.2.0
um                    randconfig-002-20240805   clang-20
um                    randconfig-002-20240806   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240805   gcc-12
x86_64       buildonly-randconfig-001-20240806   clang-18
x86_64       buildonly-randconfig-002-20240805   gcc-12
x86_64       buildonly-randconfig-002-20240806   clang-18
x86_64       buildonly-randconfig-003-20240805   gcc-12
x86_64       buildonly-randconfig-003-20240806   clang-18
x86_64       buildonly-randconfig-004-20240805   gcc-12
x86_64       buildonly-randconfig-004-20240806   clang-18
x86_64       buildonly-randconfig-005-20240805   gcc-12
x86_64       buildonly-randconfig-005-20240806   clang-18
x86_64       buildonly-randconfig-006-20240805   gcc-12
x86_64       buildonly-randconfig-006-20240806   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                                  kexec   clang-18
x86_64                randconfig-001-20240805   gcc-12
x86_64                randconfig-001-20240806   clang-18
x86_64                randconfig-002-20240805   gcc-12
x86_64                randconfig-002-20240806   clang-18
x86_64                randconfig-003-20240805   gcc-12
x86_64                randconfig-003-20240806   clang-18
x86_64                randconfig-004-20240805   gcc-12
x86_64                randconfig-004-20240806   clang-18
x86_64                randconfig-005-20240805   gcc-12
x86_64                randconfig-005-20240806   clang-18
x86_64                randconfig-006-20240805   gcc-12
x86_64                randconfig-006-20240806   clang-18
x86_64                randconfig-011-20240805   gcc-12
x86_64                randconfig-011-20240806   clang-18
x86_64                randconfig-012-20240805   gcc-12
x86_64                randconfig-012-20240806   clang-18
x86_64                randconfig-013-20240805   gcc-12
x86_64                randconfig-013-20240806   clang-18
x86_64                randconfig-014-20240805   gcc-12
x86_64                randconfig-014-20240806   clang-18
x86_64                randconfig-015-20240805   gcc-12
x86_64                randconfig-015-20240806   clang-18
x86_64                randconfig-016-20240805   gcc-12
x86_64                randconfig-016-20240806   clang-18
x86_64                randconfig-071-20240805   gcc-12
x86_64                randconfig-071-20240806   clang-18
x86_64                randconfig-072-20240805   gcc-12
x86_64                randconfig-072-20240806   clang-18
x86_64                randconfig-073-20240805   gcc-12
x86_64                randconfig-073-20240806   clang-18
x86_64                randconfig-074-20240805   gcc-12
x86_64                randconfig-074-20240806   clang-18
x86_64                randconfig-075-20240805   gcc-12
x86_64                randconfig-075-20240806   clang-18
x86_64                randconfig-076-20240805   gcc-12
x86_64                randconfig-076-20240806   clang-18
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   clang-18
xtensa                           alldefconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-13.2.0
xtensa                  audio_kc705_defconfig   gcc-13.2.0
xtensa                generic_kc705_defconfig   gcc-13.2.0
xtensa                          iss_defconfig   gcc-13.2.0
xtensa                randconfig-001-20240805   gcc-14.1.0
xtensa                randconfig-001-20240806   gcc-13.2.0
xtensa                randconfig-002-20240805   gcc-14.1.0
xtensa                randconfig-002-20240806   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

