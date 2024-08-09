Return-Path: <linux-rdma+bounces-4261-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD3F94C9F0
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 07:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 139871F22682
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 05:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C409816C863;
	Fri,  9 Aug 2024 05:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RZDM8P5Z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29ED2905
	for <linux-rdma@vger.kernel.org>; Fri,  9 Aug 2024 05:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723183010; cv=none; b=TTM58gVtTrEYbAKKRTtVk3CMYHgYm/lVELr8jtTNMPbIXC/Zv6IVL4yVQSt8S3j/OxjthJv2ORb1UGhpEf+wbkDvsikmP1viqOppxAlEF4UCQWY8QlVIq4yBE4qIDDc1a+uS9jF6g+kjs5FGUC+t+/HMlaLVGwQr5G0O/iMuH7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723183010; c=relaxed/simple;
	bh=XhSByzcKcvAPkdXvznZmSzD5Zli5EegaE1EsPOK7wIk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EHOR9Wdlp3YTiCfSGx2ViZ47b1rIs6IgfX7Fz4w5t+afrMkiamGYe+dk7x/SjULaXbkQ0byLiPkjAZmwuYDMpnXjH3Z+BHzc1cYLsKrBW8nX3OeFdb/+a3vMl04n7Da7T4KfsB/oFuhEWVjKdU0MCnUob4M4o/dd54IwdgqI9pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RZDM8P5Z; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723183009; x=1754719009;
  h=date:from:to:cc:subject:message-id;
  bh=XhSByzcKcvAPkdXvznZmSzD5Zli5EegaE1EsPOK7wIk=;
  b=RZDM8P5ZuQYOhZxn0TLQdxPeckpjY5GGnrQ8AxpXciXOmIZhTn9+GZNq
   0Rw+EtxdH15NqjLkiTxhfov0MFETxB0Yi+l/YFxpggbHqg/XaajaF3atg
   vOorDHAPWmEfrujyEyN7lXS8BXe1ZcOf2C1n698XaQ5JK5LAwFM2KtEIR
   CzlzKZyAKGcdZcKfgrUwlt0PTK3COFji0CVVRS0WoGQo/cWx1ODTqMhoV
   WY69zXF8KdXlOAoNTEtBMAgPLSAjy/5Ua6cbn1cKxUqdMtoYE3o8jc9W2
   8UkQguyImgoawNH1hQjDKnFY5hAza2p1dlh8CpWOvZ9GC77rmABP5LozK
   Q==;
X-CSE-ConnectionGUID: S2gOkjhJQfChGiybpKN4XQ==
X-CSE-MsgGUID: LHhRzQbLTkOp42SuCWoZOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21225670"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="21225670"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 22:56:48 -0700
X-CSE-ConnectionGUID: mHrtb6n9SaOTfRj/T11RRg==
X-CSE-MsgGUID: vIcl3aOASYStVldKYk/S4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="62412023"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 08 Aug 2024 22:56:46 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scIcG-0006sM-0Q;
	Fri, 09 Aug 2024 05:56:44 +0000
Date: Fri, 09 Aug 2024 13:56:00 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 d222b19c595f63d0537273c638a290c7eb2c0f02
Message-ID: <202408091356.FlQI2aLB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: d222b19c595f63d0537273c638a290c7eb2c0f02  RDMA/mlx5: Introduce GET_DATA_DIRECT_SYSFS_PATH ioctl

elapsed time: 1296m

configs tested: 200
configs skipped: 8

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
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240808   gcc-13.2.0
arc                   randconfig-002-20240808   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                         assabet_defconfig   clang-15
arm                          collie_defconfig   clang-15
arm                                 defconfig   gcc-13.2.0
arm                            mmp2_defconfig   clang-15
arm                          moxart_defconfig   clang-15
arm                        neponset_defconfig   gcc-13.2.0
arm                   randconfig-001-20240808   gcc-13.2.0
arm                   randconfig-002-20240808   gcc-13.2.0
arm                   randconfig-003-20240808   gcc-13.2.0
arm                   randconfig-004-20240808   gcc-13.2.0
arm                             rpc_defconfig   gcc-13.2.0
arm                         s3c6400_defconfig   clang-15
arm                         s3c6400_defconfig   gcc-13.2.0
arm                       spear13xx_defconfig   clang-15
arm                           stm32_defconfig   gcc-13.2.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240808   gcc-13.2.0
arm64                 randconfig-002-20240808   gcc-13.2.0
arm64                 randconfig-003-20240808   gcc-13.2.0
arm64                 randconfig-004-20240808   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240808   gcc-13.2.0
csky                  randconfig-002-20240808   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240809   gcc-12
i386         buildonly-randconfig-002-20240809   gcc-12
i386         buildonly-randconfig-003-20240809   gcc-12
i386         buildonly-randconfig-004-20240809   gcc-12
i386         buildonly-randconfig-005-20240809   gcc-12
i386         buildonly-randconfig-006-20240809   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240809   gcc-12
i386                  randconfig-002-20240809   gcc-12
i386                  randconfig-003-20240809   gcc-12
i386                  randconfig-004-20240809   gcc-12
i386                  randconfig-005-20240809   gcc-12
i386                  randconfig-006-20240809   gcc-12
i386                  randconfig-011-20240809   gcc-12
i386                  randconfig-012-20240809   gcc-12
i386                  randconfig-013-20240809   gcc-12
i386                  randconfig-014-20240809   gcc-12
i386                  randconfig-015-20240809   gcc-12
i386                  randconfig-016-20240809   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240808   gcc-13.2.0
loongarch             randconfig-002-20240808   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                       m5475evb_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                        bcm47xx_defconfig   gcc-13.2.0
mips                           ip32_defconfig   clang-15
mips                       lemote2f_defconfig   gcc-13.2.0
mips                      pic32mzda_defconfig   gcc-13.2.0
mips                           rs90_defconfig   gcc-13.2.0
mips                   sb1250_swarm_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240808   gcc-13.2.0
nios2                 randconfig-002-20240808   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                generic-32bit_defconfig   gcc-13.2.0
parisc                randconfig-001-20240808   gcc-13.2.0
parisc                randconfig-002-20240808   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                   bluestone_defconfig   clang-15
powerpc               randconfig-001-20240808   gcc-13.2.0
powerpc               randconfig-002-20240808   gcc-13.2.0
powerpc                     skiroot_defconfig   gcc-13.2.0
powerpc64                        alldefconfig   clang-15
powerpc64             randconfig-003-20240808   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv             nommu_k210_sdcard_defconfig   clang-15
riscv                 randconfig-001-20240808   gcc-13.2.0
riscv                 randconfig-002-20240808   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240808   gcc-13.2.0
s390                  randconfig-002-20240808   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240808   gcc-13.2.0
sh                    randconfig-002-20240808   gcc-13.2.0
sh                           se7721_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240808   gcc-13.2.0
sparc64               randconfig-002-20240808   gcc-13.2.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240808   gcc-13.2.0
um                    randconfig-002-20240808   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240808   gcc-12
x86_64       buildonly-randconfig-001-20240809   clang-18
x86_64       buildonly-randconfig-002-20240808   gcc-12
x86_64       buildonly-randconfig-002-20240809   clang-18
x86_64       buildonly-randconfig-003-20240808   gcc-12
x86_64       buildonly-randconfig-003-20240809   clang-18
x86_64       buildonly-randconfig-004-20240808   gcc-12
x86_64       buildonly-randconfig-004-20240809   clang-18
x86_64       buildonly-randconfig-005-20240808   gcc-12
x86_64       buildonly-randconfig-005-20240809   clang-18
x86_64       buildonly-randconfig-006-20240808   gcc-12
x86_64       buildonly-randconfig-006-20240809   clang-18
x86_64                              defconfig   clang-18
x86_64                randconfig-001-20240808   gcc-12
x86_64                randconfig-001-20240809   clang-18
x86_64                randconfig-002-20240808   gcc-12
x86_64                randconfig-002-20240809   clang-18
x86_64                randconfig-003-20240808   gcc-12
x86_64                randconfig-003-20240809   clang-18
x86_64                randconfig-004-20240808   gcc-12
x86_64                randconfig-004-20240809   clang-18
x86_64                randconfig-005-20240808   gcc-12
x86_64                randconfig-005-20240809   clang-18
x86_64                randconfig-006-20240808   gcc-12
x86_64                randconfig-006-20240809   clang-18
x86_64                randconfig-011-20240808   gcc-12
x86_64                randconfig-011-20240809   clang-18
x86_64                randconfig-012-20240808   gcc-12
x86_64                randconfig-012-20240809   clang-18
x86_64                randconfig-013-20240808   gcc-12
x86_64                randconfig-013-20240809   clang-18
x86_64                randconfig-014-20240808   gcc-12
x86_64                randconfig-014-20240809   clang-18
x86_64                randconfig-015-20240808   gcc-12
x86_64                randconfig-015-20240809   clang-18
x86_64                randconfig-016-20240808   gcc-12
x86_64                randconfig-016-20240809   clang-18
x86_64                randconfig-071-20240808   gcc-12
x86_64                randconfig-071-20240809   clang-18
x86_64                randconfig-072-20240808   gcc-12
x86_64                randconfig-072-20240809   clang-18
x86_64                randconfig-073-20240808   gcc-12
x86_64                randconfig-073-20240809   clang-18
x86_64                randconfig-074-20240808   gcc-12
x86_64                randconfig-074-20240809   clang-18
x86_64                randconfig-075-20240808   gcc-12
x86_64                randconfig-075-20240809   clang-18
x86_64                randconfig-076-20240808   gcc-12
x86_64                randconfig-076-20240809   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240808   gcc-13.2.0
xtensa                randconfig-002-20240808   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

